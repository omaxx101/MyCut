// Signup
document.getElementById("signupForm")?.addEventListener("submit", function (e) {
  e.preventDefault();
  const username = document.getElementById("username").value;
  const password = document.getElementById("password").value;

  localStorage.setItem("afrocut_user", JSON.stringify({ username, password }));
  alert("User registered!");
  window.location.href = "login.html";
});

// Login
document.getElementById("loginForm")?.addEventListener("submit", function (e) {
  e.preventDefault();
  const loginUsername = document.getElementById("username").value;
  const loginPassword = document.getElementById("password").value;


  const user = JSON.parse(localStorage.getItem("afrocut_user"));
  if (user && user.username === loginUsername && user.password === loginPassword) {
    alert("Login successful!");
    window.location.href = "welcome.html";
  } else {
    alert("Invalid username or password");
  }
});
