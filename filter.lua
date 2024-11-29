function Blocks(blocks)
    local new_blocks = {}
    local current_section = nil
    local current_article = nil

    for _, block in ipairs(blocks) do
        if block.t == "Header" and block.level == 2 then
            -- Close the current article if open
            if current_article then
                table.insert(current_section.content, pandoc.RawBlock("html", "<article>"))
                for _, content in ipairs(current_article.content) do
                    table.insert(current_section.content, content)
                end
                table.insert(current_section.content, pandoc.RawBlock("html", "</article>"))
                current_article = nil
            end
            -- Close the current section if open
            if current_section then
                table.insert(new_blocks, pandoc.RawBlock("html", "<section>"))
                for _, content in ipairs(current_section.content) do
                    table.insert(new_blocks, content)
                end
                table.insert(new_blocks, pandoc.RawBlock("html", "</section>"))
            end
            -- Start a new section
            current_section = {content = {block}}
        elseif block.t == "Header" and block.level == 3 then
            -- Close the current article if open
            if current_article then
                table.insert(current_section.content, pandoc.RawBlock("html", "<article>"))
                for _, content in ipairs(current_article.content) do
                    table.insert(current_section.content, content)
                end
                table.insert(current_section.content, pandoc.RawBlock("html", "</article>"))
            end
            -- Start a new article
            current_article = {content = {block}}
        else
            -- Add content to the current article or section
            if current_article then
                table.insert(current_article.content, block)
            elseif current_section then
                table.insert(current_section.content, block)
            else
                table.insert(new_blocks, block)
            end
        end
    end

    -- Close any remaining open blocks
    if current_article then
        table.insert(current_section.content, pandoc.RawBlock("html", "<article>"))
        for _, content in ipairs(current_article.content) do
            table.insert(current_section.content, content)
        end
        table.insert(current_section.content, pandoc.RawBlock("html", "</article>"))
    end
    if current_section then
        table.insert(new_blocks, pandoc.RawBlock("html", "<section>"))
        for _, content in ipairs(current_section.content) do
            table.insert(new_blocks, content)
        end
        table.insert(new_blocks, pandoc.RawBlock("html", "</section>"))
    end

    return new_blocks
end