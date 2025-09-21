class ChatResponseJob < ApplicationJob
  def perform(chat_id, content)
    chat = Chat.find(chat_id)

    context = Context.find_by(slug: "confluence")
    markdown = context.markdown.map { |file| file.blob }

    system_prompt = context.system_prompt.attached? ? context.system_prompt.download : ""
    chat.with_instructions(system_prompt)

    chat.ask(content, with: markdown) do |chunk|
      if chunk.content && !chunk.content.blank?
        message = chat.messages.last
        message.update!(content: message.content + chunk.content)
      end
    end
  end
end
