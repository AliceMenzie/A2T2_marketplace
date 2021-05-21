const button = document.getElementById('stripe-button');
// spread syntax
const {sessionId, publicKey} = button.dataset
// eventlistener
button.addEventListener('click', () => {
	const stripe = Stripe(publicKey);
	stripe.redirectToCheckout({sessionId: sessionId})

});