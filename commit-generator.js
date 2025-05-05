const jsonfile = require("jsonfile");
const moment = require("moment");
const simpleGit = require("simple-git");

const FILE_PATH = "./data.json";
const TOTAL_COMMITS = 100; // Adjust this number as needed

// Helper function to generate random integers
function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

const makeCommit = (remainingCommits) => {
  if (remainingCommits === 0) {
    return simpleGit().push();
  }

  // Generate random weeks (0-54) and days (0-6) in the past year
  const randomWeeks = getRandomInt(0, 54);
  const randomDays = getRandomInt(0, 6);

  // Calculate a random date within the past year
  const commitDate = moment()
    .subtract(1, "year")
    .add(1, "day")
    .add(randomWeeks, "weeks")
    .add(randomDays, "days")
    .format();

  const commitData = {
    date: commitDate,
  };

  console.log(`Creating commit for ${commitDate}`);

  jsonfile.writeFile(FILE_PATH, commitData, () => {
    simpleGit()
      .add([FILE_PATH])
      .commit(commitDate, { "--date": commitDate }, () => {
        makeCommit(--remainingCommits);
      });
  });
};

// Start the process with the desired number of commits
makeCommit(TOTAL_COMMITS);
