from scrapy.selector import HtmlXPathSelector
from scrapy.contrib.linkextractors.sgml import SgmlLinkExtractor
from scrapy.contrib.spiders import CrawlSpider, Rule
from sitegraph.items import SitegraphItem
from scrapy.utils.url import urljoin_rfc
from re import sub, match
class GraphspiderSpider(CrawlSpider):
    name = 'graphspider'
    allowed_domains = ['simple.wikipedia.org']
    start_urls = ['http://simple.wikipedia.org']
    
    SgmlLE = SgmlLinkExtractor (deny=[  '/Special:', '/Talk:', '/Category:'
                                        ,'/Template:', '/Template_talk:', '/T:'
                                        ,'/File:'
                                        ,'/Help:', '/Help_talk'
                                        ,'/Wikipedia:' ,'/Wikipedia_talk:'
                                        ,'/User:', '/User_talk'
                                        ,'index.php\?'],
                                deny_extensions=['css','js'
                                            ,'bmp','gif','jpeg','jpg','ico','png','tiff','tif','svg'
                                            ,'mid','mp2','mp3','mp4','wav','avi','mov','mpeg','ram','m4v', 'ogg'
                                            ,'pdf','rm','smil','wmv','swf','wma','zip','rar','gz']
                               )
    rules = (
        Rule(SgmlLE, callback='parse_item', follow=True),
    )

    def parse_item(self, response):
        hxs = HtmlXPathSelector(response)
        i = SitegraphItem()
        i['url'] = response.url
        links=[]
        for anchor in hxs.select('//a[@href]'):
            href = anchor.select('@href').extract()[0]
            link = sub('#.*$', '', urljoin_rfc(response.url,href))
            if link.lower().startswith("http://simple.wikipedia.org") and self.SgmlLE.matches(link):# and not match('.*index.php\?.*',link.lower()):
                links.append(link)
        i['linkedurls'] = links
        name = sub('^.*/', '', response.url)
        if match('[-_0-9a-zA-Z\.]', name):
            f = open('/home/burmisha/github/bursda/inforet/sitegraph/wiki/' + name,'w+')
            body = response.body
            body = " ".join(body.split())
            body = sub('<script>.*?<\/script>', '', body)
            body = sub('<style( type="text/css")?>.*?<\/style>', '', body)
            body = sub('<[^>]*>', '', body)
            body = sub('<[-][-][^>]*>', '', body)
            body = sub('&.{2,4};', ' ', body)
            f.write(body)
            f.close()
        i['size'] = response.headers['content-length'] # len(hxs.select('/html').extract()[0])
        return i
