var hiddenBoxes = document.getElementsByClassName("hidden-box");
  
for (var i = 0; i < hiddenBoxes.length; i++) {
    hiddenBoxes[i].id = "hidden-box-" + (i + 1);
}

const codeBoxes = document.querySelectorAll('.code-box, .commandline-box');

codeBoxes.forEach(box => {
  const copyButton = document.createElement('button');
  copyButton.className = 'copy-button';

  copyButton.addEventListener('click', () => {
    const text = box.innerText.trim();

    navigator.clipboard.writeText(text)
      .then(() => {
        copyButton.classList.add('show-checkmark');
        setTimeout(() => {
          copyButton.classList.remove('show-checkmark');
        }, 1000);
      })
      .catch(err => {
        console.error('Failed to copy text:', err);
      });
  });

  box.appendChild(copyButton);
});

function navToggle() {
  let sidebar = document.getElementById('sidebar');
  sidebar.classList.toggle('show');
  let hamburger = document.querySelector('.hamburger')
  hamburger.classList.toggle('is-active');
}

function toggleAnswer(button) {
  let buttons = document.getElementsByClassName('answer_btn');
  let buttonIndex = Array.from(buttons).indexOf(button) + 1;

  let boxId = "hidden-box-" + buttonIndex;
  let hiddenBox = document.getElementById(boxId);

  if (hiddenBox) {
    let currentDisplay = window.getComputedStyle(hiddenBox).getPropertyValue("display");
    if (currentDisplay === "none") {
      hiddenBox.style.display = "block";
      button.textContent = "Piilota vastaus";
    } else {
      hiddenBox.style.display = "none";
      button.textContent = "Näytä vastaus";
    }
  }
  else {
    button.textContent = "ERROR: Could not find hidden-box";
  }
}