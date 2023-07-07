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

const answerButtons = [...document.getElementsByClassName('answer_btn')];
answerButtons.forEach(button => {
  button.textContent = "Näytä " + button.textContent;
});

function navToggle() {
  let sidebar = document.getElementById('sidebar');
  sidebar.classList.toggle('show');
  let hamburger = document.querySelector('.hamburger')
  hamburger.classList.toggle('is-active');
}

function toggleAnswer(button) {
  if (button.classList.contains('token')) {
    const token = localStorage.getItem('token');
    if (token == null) {
      alert("You haven't entered the token correctly!");
      return;
    }
  }
  console.log(button)
  let buttons = document.getElementsByClassName('answer_btn');
  let buttonIndex = Array.from(buttons).indexOf(button) + 1;

  let buttonTextInput = button.textContent;
  let words = buttonTextInput.split(" ");
  let originalButtonText = words.slice(1).join(' ');

  let boxId = "hidden-box-" + buttonIndex;
  let hiddenBox = document.getElementById(boxId);

  if (hiddenBox) {
    let currentDisplay = window.getComputedStyle(hiddenBox).getPropertyValue("display");
    if (currentDisplay === "none") {
      hiddenBox.style.display = "block";
      button.textContent = "Piilota " + originalButtonText;
    } else {
      hiddenBox.style.display = "none";
      button.textContent = "Näytä " + originalButtonText;
    }
  }
  else {
    button.textContent = "ERROR: Could not find hidden-box";
  }
}