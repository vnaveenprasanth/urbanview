document.addEventListener("turbo:load", () => {
    const shareButton = document.querySelector('.share-post-button');
    const indexshareButton = document.querySelector('.index-share-button');
    
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


document.addEventListener("turbo:load", () => {
    const indexshareButton = document.querySelectorAll('.index-share-button');
    
    if (indexshareButton && navigator.share) {
        indexshareButton.forEach(btn => btn.addEventListener('click', async () => {
            try {
                const { title, text, url } = btn.dataset;
                await navigator.share({ title, url });
                console.log('Successfully shared');
            } catch (error) {
                console.error('Error sharing:', error);
            }
        }));
    }
});


