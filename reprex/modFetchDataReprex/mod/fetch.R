# fetch module
# modFetchDataReprex

# fetch will need to have reactive values that will store the fetched result
# and then use it further in the app. For instance, the maxUV24 will be a NULL value
# until the fetch function is called. The maxUVfetch function would be stored separately
# within the fun folder. To make the fetch reactive, it should also take the id parameter.
# That way, we can write just one fetch function. This is considering that there are
# different data sources. However, let's say this isn't the case, and that the json
# structure is similar across regions. Then we just pass the correct URL to the function.
# This way makes the most sense. This fetch module should have the URLs hardcoded once,
# then passed along to the maxUVfetch function

#
fetch_server <- function(id) {
     moduleServer(id, function(input, output, session) {




     })
}