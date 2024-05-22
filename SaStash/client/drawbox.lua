function DrawRectangle(rec)
    DrawPoly(rec[1].x, rec[1].y, rec[1].z, rec[2].x, rec[2].y, rec[2].z, rec[3].x, rec[3].y, rec[3].z, 255, 42, 24, 100)
    DrawPoly(rec[2].x, rec[2].y, rec[2].z, rec[1].x, rec[1].y, rec[1].z, rec[3].x, rec[3].y, rec[3].z, 255, 42, 24, 100)
    DrawPoly(rec[1].x, rec[1].y, rec[1].z, rec[4].x, rec[4].y, rec[4].z, rec[3].x, rec[3].y, rec[3].z, 255, 42, 24, 100)
    DrawPoly(rec[4].x, rec[4].y, rec[4].z, rec[1].x, rec[1].y, rec[1].z, rec[3].x, rec[3].y, rec[3].z, 255, 42, 24, 100)
end

function DebugDrawBox(entity, type, ajust, coordspr)
    local coordspr = coordspr or false

    if not coordspr  then

        local coords = GetEntityCoords(entity)
        local heading = GetEntityHeading(entity)

        if type == nil then

            xCoord = (coords.x) + 0.0
            yCoord = (coords.y) + 0.0
            zCoord = (coords.z) + 0.0

        elseif type == "+"then

            xCoord = (coords.x) + 0.0
            yCoord = (coords.y) + 0.0
            zCoord = (coords.z) + ajust or 0.0

        elseif type == "-"then

            xCoord = (coords.x) + 0.0
            yCoord = (coords.y) + 0.0
            zCoord = (coords.z) - ajust or 0.0

        end

    else

        local coords = coordspr
        local heading = coordspr.h

        xCoord = (coords.x) + 0.0
        yCoord = (coords.y) + 0.0
        zCoord = (coords.z) + 0.0

    end
end

function DebugDrawBox_table(coordspr)

        local coords = coordspr
        local heading = coordspr.h

        xCoord = (coords.x) + 0.0
        yCoord = (coords.y) + 0.0
        zCoord = (coords.z) + 0.0

        local recoords = vector3(xCoord, yCoord, zCoord)

    DebugDrawBox(coords, heading)
end

function DebugDrawBox_gizmo(entity, type, ajust)

        local coords = GetEntityCoords(entity)
        local heading = GetEntityHeading(entity)

        if type == nil then

            xCoord = (coords.x) + 0.0
            yCoord = (coords.y) + 0.0
            zCoord = (coords.z) + 0.0

        elseif type == "+"then

            xCoord = (coords.x) + 0.0
            yCoord = (coords.y) + 0.0
            zCoord = (coords.z) + ajust or 0.0

        elseif type == "-"then

            xCoord = (coords.x) + 0.0
            yCoord = (coords.y) + 0.0
            zCoord = (coords.z) - ajust or 0.0

        end

        local recoords = vector3(xCoord, yCoord, zCoord)

    DebugDrawBox(recoords, heading)
end

function DebugDrawBox_entity(entity)

    local coords = GetEntityCoords(entity)
    local heading = GetEntityHeading(entity)

    DebugDrawBox(coords, heading)
end

function DebugDrawBox(coords, heading)

    local coords = coords
    local heading = heading

    xCoord = (coords.x) + 0.0
    yCoord = (coords.y) + 0.0
    zCoord = (coords.z) + 0.0

    height = 2.3
    width = 1.5
    length = 1.5

    local rad = math.rad(-heading)
    local sinH = math.sin(rad)
    local cosH = math.cos(rad)
    local center = vec2(xCoord, yCoord)
    ---@type vector2[]
    points = {
        center + vec2((width * cosH + length * sinH), (length * cosH - width * sinH)) / 2,
        center + vec2(-(width * cosH - length * sinH), (length * cosH + width * sinH)) / 2,
        center + vec2(-(width * cosH + length * sinH), -(length * cosH - width * sinH)) / 2,
        center + vec2((width * cosH - length * sinH), -(length * cosH + width * sinH)) / 2,
    }

    local thickness = vec(0, 0, height / 2)
    local activeA, activeB = vec(xCoord, yCoord, zCoord) + thickness, vec(xCoord, yCoord, zCoord) - thickness

    for i = 1, #points do
        points[i] = vec(points[i].x, points[i].y, zCoord)
        local a = points[i] + thickness
        local b = points[i] - thickness
        local c = (points[i + 1] and vec(points[i + 1].x, points[i + 1].y, zCoord) or points[1]) + thickness
        local d = (points[i + 1] and vec(points[i + 1].x, points[i + 1].y, zCoord) or points[1]) - thickness
        local e = points[i]
        local f = (points[i + 1] and vec(points[i + 1].x, points[i + 1].y, zCoord) or points[1])


        DrawLine(a.x, a.y, a.z, b.x, b.y, b.z, 255, 42, 24, 225)
        DrawLine(a.x, a.y, a.z, c.x, c.y, c.z, 255, 42, 24, 225)
        DrawLine(b.x, b.y, b.z, d.x, d.y, d.z, 255, 42, 24, 225)
        DrawLine(e.x, e.y, e.z, f.x, f.y, f.z, 255, 42, 24, 225)

        DrawRectangle({a, b, d, c})

    end
end