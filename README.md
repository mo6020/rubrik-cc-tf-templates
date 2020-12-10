# Template Terraform files for Rubrik Cloud Cluster
### 100% Unofficial and unsupported.


I created these files for my own usage as I spin up/down Cloud Clusters on a weekly basis. Obviously I am not you, so you might need to change these considerably to meet your use case, but I will say that these create the bare minimum required to stand-up a Cloud Cluster.

Some assumptions you can make:
  - Unsupported by Rubrik and 100% unofficial.
    - No assertions around best practises are being made here and these probably don't meet your security needs in production.
      - Don't blame me if anything breaks. Raise an Issue on GitHub and we can try and fix it together, but no promises.

      # Azure

        - Depends on the Azure CLI being set up
          - Deploys the relevant infrastructure in it's own Resource Group - this is good for my use case in that I can keep everything in an RG and then just trash that RG when I'm done. YMMV.
            - Cloud Cluster deployment not included due to the current mechanism of purchasing Cloud Cluster

            # AWS

              - All variable based, it's probably safe to assume you need the AWS CLI installed as well...
                - The Cloud Cluster image in this instance will need to be shared with you by support.
                  - You could just deploy it from the Marketplace, but I work for Rubrik and thus have access to all the images so it's easier for me to just spin up/down via TF
                    - Honestly, just deploy it from the Marketplace....

                    That's about it. Don't blame me if you break anything, like I said this works for my usecases, in my environment. The TF files are not complicated tho, so you should be able to get something workable out of them if you need to make changes.
