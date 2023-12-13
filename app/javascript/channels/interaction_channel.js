import consumer from "./consumer"

document.addEventListener("turbo:load", function () {
  const interactions = document.querySelector('.interactionButtons');

  if (interactions) {
    consumer.subscriptions.create({ channel: 'InteractionChannel', post_id: getPostId() }, {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log('Connected to interaction channel')
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
        console.log('Disconnected to interaction channel')

      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        this.updateInteractions(data)
      },

      updateInteractions(data) {
        let post_id = data.post.id;
        this.updateCount('going', data.going_count, 'Going',post_id);
        this.updateCount('not_going', data.not_going_count, 'Not going');
        this.updateCount('maybe', data.maybe_count, 'Maybe');
        this.updateCount('donated', data.donated_count, 'Donated',post_id);
        this.updateCount('like', data.like_count, 'Like',post_id);
        this.updateCount('dislike', data.dislike_count, 'Dislike');

        // const postElement = document.getElementById(`post_${post_id}`);
        // if (postElement) {
        //   this.updateIndexCount('going', data.going_count, 'Going', post_id);
        //   this.updateIndexCount('donated', data.donated_count, 'Donated', post_id);
        //   this.updateIndexCount('like', data.like_count, 'Like', post_id);
        // }
      },

      updateCount(option, count, interaction) {
        const countElement = document.getElementById(`${option}_count`);
        if (countElement) {
          countElement.innerText = `${count} ${interaction}`;
        }
      },

      // updateIndexCount(option,count,interaction,post_id) {
      //   const indexInteraction = document.getElementById(`post_${post_id}_${option}`);
      //   if (indexInteraction) {
      //     indexInteraction.innerText = `${count} ${interaction}`;
      //   }
      // }
    }
    );

    function getPostId() {
      const interactionSection = document.getElementById('interactionButtons');
      return interactionSection ? Number(interactionSection.getAttribute('data-post-id')) : null;
    }

  }
})