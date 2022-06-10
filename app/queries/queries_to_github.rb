class QueriesToGithub
  UserRepoQuery = GitHubClient::CLIENT.parse <<-'GRAPHQL'
      query($username: String!) {
       user(login: $username) {
          repositories(last: 10) {
           nodes {
              name
              createdAt
           }
         }
       }
     }
  GRAPHQL

  UserRepoCommitQuery = GitHubClient::CLIENT.parse <<-'GRAPHQL'
    query($username: String!, $repository: String!) {
     repository(owner: $username, name: $repository) {
       ref(qualifiedName: "master") {
         target {
           ... on Commit {
              id
             history(first: 10) {
               edges {
                  node {
                    message
                    committedDate
                 }
                }
             }
           }
         }
       }
     }
    }
  GRAPHQL
end
