import scrapy
from scrapy.selector import Selector
from scrapy.spider import BaseSpider
from xlrd import open_workbook
from openpyxl import Workbook, load_workbook
import xlrd,sys
import openpyxl,os

class linkedInSpider(scrapy.Spider):
	name = "zopnow"
	allowed_domains = ["zopnow.com"]

	urls = []
	links = []

	wb = openpyxl.load_workbook('../../../media/Benchmarking.xlsx')
	ws = wb.get_sheet_by_name('Done')
	
	list2 = []
	for row in range(2, ws.max_row + 1):
		list = []
		# Each row in the spreadsheet has data for one census tract.
		ref  = ws['A' + str(row)].value
		link = ws['T' + str(row)].value
		print ref,link
		if link and (link.encode('utf8')).startswith("https:"):
			list.append(ref)
			list.append(link)
			list2.append(list) 
	
	print list2

	for ref,link in list2:
		links.append(link)
	print links
	start_urls = links#("https://www.zopnow.com/red-bull-energy-drink-pack-of-4-nos-can-v-250-ml-p.php",)

	def parse(self, response):
		reload(sys)
		sys.setdefaultencoding('utf-8')
		import base64
		import csv
        	import cStringIO
		sel = Selector(response)
		#hxs = HtmlXPathSelector(text=response.body)
		
		
		names = sel.xpath('//h1[@itemprop="name"]/text()').extract()
		prod_name = []
		prod_price = []
		
		if len(names)>1:
			l = 0
			for name in names:
				l += 1
				product_name = (((name).strip().rstrip()).encode('utf-8')).replace("\\s+","")
				prod_name.append(product_name)
				if l < len(names):
					prod_name.append("\n")
		else:
			product_name = (((names[0]).strip().rstrip()).encode('utf-8')).replace("\\s+"," ")
			prod_name.append(product_name)
		product_name = (''.join(prod_name)).strip().rstrip()
			
		prices = sel.xpath('//h2[@class="finalPrice"]/text()').extract()
		if len(prices)>1:
			c = 0
			for price in prices:
				c += 1
				product_price = (((price).strip().rstrip()).encode('utf-8')).replace("\\s+","")
				prod_price.append(product_price)
				if c < len(prices):
					prod_price.append("\n")
		else:
			product_price = (((prices[0]).strip().rstrip()).encode('utf-8')).replace("\\s+","")
			prod_price.append(product_price)
		product_price = ''.join(prod_price)
		
		print "urls::::::::::",response.url
		print "names:::::::::",product_name
		print "prices::::::::",product_price
		
		"""
		list2 = []
		for name, price in zip(names,prices):
			list1 = []
			product_name = (((name).strip().rstrip()).encode('utf-8')).replace("\\s+","")
			product_price = (((price).strip().rstrip()).encode('utf-8')).replace("\\s+","")
			print product_name,product_price
			
			for list_part in self.list2:
				if response.url in list_part:
					ref = list_part[0]

			list1.append(ref)
			list1.append(product_name)
		        list1.append(product_price)
			list1.append(response.url)
			list2.append(list1)
		print "URL>>>>>>",response.url
		"""
		
		for list_part in self.list2:
			if response.url in list_part:
				ref = list_part[0]
		
		if os.path.isfile('../../../media/zopnow_rates.csv'):
		        csvfile = open('../../../media/zopnow_rates.csv', 'a')
		        fieldnames = ['Reference','Name', 'Price', 'URL']
		        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
		        writer.writerow({'Reference': ref, 'Name': product_name, 'Price': product_price, 'URL': response.url})
		 	print "Done"
		
		else:
		        csvfile = open('../../../media/zopnow_rates.csv', 'a')
		        fieldnames = ['Reference', 'Name', 'Price', 'URL']
                        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
              	        writer.writeheader()
	                writer.writerow({'Reference': ref, 'Name': product_name, 'Price': product_price, 'URL': response.url})
			print "Done"
		
		
