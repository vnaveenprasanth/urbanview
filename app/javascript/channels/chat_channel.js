import consumer from "./consumer";


document.addEventListener("turbo:load", function () {
  const chatMessage = document.getElementById('new-chat-form');
  const chatSection = document.getElementById('chat-section');
  if (chatSection) {
    consumer.subscriptions.create(
      { channel: 'ChatChannel', post_id: getPostId() },
      {
        connected() {
          // Called when the subscription is ready for use on the server
          console.log('Connected to the chat channel');
        },
      
        disconnected() {
          // Called when the subscription has been terminated by the server
          console.log('Disconnected from the chat channel');
        },

        received(data) {
          this.appendLine(data)
        },

        appendLine(data) {
          const html = this.createLine(data)
          if (chatSection) {
            chatSection.innerHTML += html;
          }
        },

        createLine(data) {
          return `
        <div class="chat-message">
        <span class="chat_Useravatar"><img src="${data.avatar_url}" alt="userimg" class="chatAvatar"/></span>
        <span class="chat_Username">${data.username}</span>
        <span class="chat_Message">${data.message}</span>
        </div>`
        }

      }
    );

    function getPostId() {
      const chatSection = document.getElementById('chat-section');
      return chatSection ? Number(chatSection.getAttribute('data-post-id')) : null;
    }

    function getUserId() {
      const chatSection = document.getElementById('chat-section');
      return chatSection ? Number(chatSection.getAttribute('data-user-id')) : null;
    }
  
    chatMessage.addEventListener("submit", function (e) {
      e.preventDefault();
      const message = document.getElementById("chat_content").value;
      if (message == '' || message.length < 1) return
      consumer.subscriptions.subscriptions[0].perform("send_message", {
        message: message,
        post_Id: getPostId(),
        user_Id: getUserId()
      });
      document.getElementById("chat_content").value = "";
    });
  }
});