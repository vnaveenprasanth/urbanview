document.addEventListener("turbo:load", () => {
    const shareButton = document.querySelector('.share-post-button');

    if (shareButton && navigator.share) {
        shareButton.addEventListener('click', async () => {
            try {
                const { title, text, url } = shareButton.dataset;
                console.log(shareButton.dataset)
                await navigator.share({ title, url });
                console.log('Successfully shared');
            } catch (error) {
                console.error('Error sharing:', error);
            }
        });
    }
});
