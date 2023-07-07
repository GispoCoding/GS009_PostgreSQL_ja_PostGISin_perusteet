function enterToken() {
    const token = prompt('Enter a token:');

    if (token === 'testi') {
    localStorage.setItem('token', token);

    alert('Token saved successfully!');
    } else {
    alert('Invalid token');
    }
}