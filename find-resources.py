""" Crawl HDX to find resources with HXL Proxy links

"""

import ckancrawler, csv, logging, sys

#
# Set up logging
#
logging.basicConfig(stream=sys.stderr, level=logging.INFO)
logger = logging.getLogger(__name__)

#
# Configuration
#
DELAY = 0
"""Time delay in seconds between datasets, to give HDX a break."""

CHUNK_SIZE=100
"""Number of datasets to read at once"""

CKAN_URL = 'https://data.humdata.org'
"""Base URL for the CKAN instance."""

USER_AGENT='HDX-Developer-2015'
"""User agent (for analytics)"""

#
# Open a connection to HDX
#
crawler = ckancrawler.Crawler(CKAN_URL, user_agent=USER_AGENT, delay=DELAY)

#
# Open a CSV output stream
#
output = csv.writer(sys.stdout)

#
# Write the CSV header rows
#
output.writerow([
    'Org',
    'Dataset',
    'Resource',
    'State',
    'URL',
])

output.writerow([
    '#org+provider',
    "#x_dataset",
    "#x_resource",
    "#status",
    "#meta+url",
])

#
# Iterate through all the datasets ("packages") and resources on HDX
#
for n, package in enumerate(crawler.packages()):
    if (n % 100) == 0:
        logger.info("%d...", n)
    for resource in package['resources']:
        # false positives are unlikely
        if "proxy.hxlstandard.org" in resource['url']:
            output.writerow([
                package['organization']['name'],
                package['name'],
                resource['id'],
                resource['state'],
                resource['url'],
            ])


