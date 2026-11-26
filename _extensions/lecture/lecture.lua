-- Lecture video shortcode for videos hosted on video.edu.nl (SURF, PeerTube).
--
-- Usage:  {{< lecture VIDEO_ID "Title of the lecture" >}}
--
-- VIDEO_ID is the short ID at the end of the video's address,
-- e.g. https://video.edu.nl/w/3jcY3fkGvs7AH9k7MVJD46
--
-- HTML: a collapsed callout box. Its title row shows the video's preview still,
--       a video icon, the title and the length. The player sits inside the box
--       and only loads when a reader opens it.
-- Other formats (PDF, EPUB): one line with a link to the video.
--
-- The stills (images/lectures/<ID>.jpg) and lengths (images/lectures/lectures.json)
-- are saved by scripts/download_lecture_videos.R. Without them the box still
-- works, but shows no still or length.

local WATCH_URL = "https://video.edu.nl/w/"
local EMBED_URL = "https://video.edu.nl/videos/embed/"
local LECTURE_DIR = "images/lectures/"

local function html_escape(s)
  return (s:gsub("&", "&amp;"):gsub('"', "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function project_path(rel)
  local dir = quarto.project.directory
  if dir == nil or dir == "" then return rel end
  return pandoc.path.join({ dir, rel })
end

local function file_exists(path)
  local f = io.open(path, "rb")
  if f then f:close() return true end
  return false
end

-- Video lengths, read once from images/lectures/lectures.json
local lecture_info = nil
local function get_info(id)
  if lecture_info == nil then
    lecture_info = {}
    local f = io.open(project_path(LECTURE_DIR .. "lectures.json"), "r")
    if f then
      local ok, decoded = pcall(pandoc.json.decode, f:read("a"))
      f:close()
      if ok and type(decoded) == "table" then lecture_info = decoded end
    end
  end
  return lecture_info[id]
end

return {
  ["lecture"] = function(args, kwargs, meta)
    if #args < 2 then
      error("lecture shortcode needs a video ID and a title: {{< lecture ID \"Title\" >}}")
    end
    local id = pandoc.utils.stringify(args[1])
    local title = pandoc.utils.stringify(args[2])
    if not id:match("^[%w]+$") then
      error("lecture shortcode: video ID '" .. id .. "' should only contain letters and digits")
    end

    if quarto.doc.is_format("html:js") then
      local thumb_rel = LECTURE_DIR .. id .. ".jpg"
      local thumb_html = ""
      if file_exists(project_path(thumb_rel)) then
        thumb_html = string.format(
          '<span class="lecture-thumb"><img src="%s" alt="" loading="lazy" width="280" height="157">' ..
          '<i class="bi bi-play-circle-fill" aria-hidden="true"></i></span>', thumb_rel)
      else
        quarto.log.warning("lecture: no still for video " .. id ..
          " - run scripts/download_lecture_videos.R")
      end

      local duration_html = ""
      local info = get_info(id)
      if info and tonumber(info.duration) then
        duration_html = string.format('<span class="lecture-duration">%d min</span>',
          math.floor(tonumber(info.duration) / 60 + 0.5))
      end

      local title_html = string.format(
        '<span class="lecture-title">%s<span class="lecture-text">' ..
        '<span class="lecture-label"><i class="bi bi-camera-video-fill" aria-hidden="true"></i>Lecture video</span>' ..
        '<span class="lecture-name">%s</span>%s</span></span>',
        thumb_html, html_escape(title), duration_html)

      local player = string.format(
        '<div class="lecture-video" style="position:relative;width:100%%;aspect-ratio:16/9;">' ..
        '<iframe src="%s%s" title="%s" loading="lazy" allow="fullscreen" allowfullscreen ' ..
        'sandbox="allow-same-origin allow-scripts allow-popups allow-forms" ' ..
        'style="position:absolute;inset:0;width:100%%;height:100%%;border:0;"></iframe></div>',
        EMBED_URL, id, html_escape(title))

      return quarto.Callout({
        type = "note",
        title = pandoc.Inlines({ pandoc.RawInline("html", title_html) }),
        collapse = true,
        icon = false,
        content = { pandoc.RawBlock("html", player) }
      })
    end

    return pandoc.Para({
      pandoc.Strong({ pandoc.Str("Lecture video:") }),
      pandoc.Space(),
      pandoc.Link(title, WATCH_URL .. id)
    })
  end
}
