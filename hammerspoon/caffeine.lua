--
-- Caffeine: prevents the Mac from falling asleep.
--
-- I pulled the icons from here:
-- http://jimmygreen.deviantart.com/art/Retina-Caffeine-menubar-icons-350451587
--

local caffeine = hs.menubar.new()

local function updateCaffeineDisplay(state)
  local result
  if state then
    caffeine:setIcon("caffeine-active.png")
  else
    caffeine:setIcon("caffeine-inactive.png")
  end
end

function toggleCaffeine()
  updateCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

function removeCaffeine()
  caffeine:delete()
  caffeine = nil
end

if caffeine then
  caffeine:setClickCallback(toggleCaffeine)
  updateCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
