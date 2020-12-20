require 'open3'
module Convert
  module ToHtml
    class << self

      def download(url, distPath)
      
      end
      
      def to_html(input, output, options = {})
        stdin, stdout, stderr, process = Open3.popen3("#{Rails.application.config.process_pdf_to_html} -in #{input} -out #{output}")
      end

      def export_base_info(filePath)
        @doc = Nokogiri::HTML(File.open(filePath))
        rs = {}
        xpaths = {
          ho_va_ten: "/html/body/div[1]/table[1]/tr[2]/td[1]/p",
          ngay_sinh: "/html/body/div[1]/table[1]/tr[2]/td[2]/p",
          cmnd: "/html/body/div[1]/table[1]/tr[4]/td[1]/p",
          ngay_cap: "/html/body/div[1]/table[1]/tr[4]/td[2]/p",
          nguoi_tham_chieu_1: "/html/body/div[1]/p[13]/span[2]",
          sdt_tham_chieu_1: "/html/body/div[1]/table[2]/tr[1]/td[2]/p",
          nguoi_tham_chieu_2: "/html/body/div[1]/table[2]/tr[2]/td[1]/p",
          sdt_tham_chieu_2: "/html/body/div[1]/table[2]/tr[3]/td[2]/p",
          sdt: "/html/body/div[1]/table[1]/tr[8]/td[1]/p",
          dia_chi: "/html/body/div[1]/p[7]",
          tinh: "/html/body/div[1]/p[7]",
          ten_goi_vay: "/html/body/div[2]/p[4]/span[2]",
          ngay_vay: "/html/body/div[3]/p[2]"
        }

        rs = {
          ho_va_ten: @doc.xpath(xpaths[:ho_va_ten]).try('text').try(:downcase).gsub("họ và tên:", ""),
          ngay_sinh: @doc.xpath(xpaths[:ngay_sinh]).try('text').try(:downcase).gsub("ngày sinh:", ""),
          cmnd: @doc.xpath(xpaths[:cmnd]).try('text').try(:downcase).gsub("số cmnd:", ""),
          ngay_cap: @doc.xpath(xpaths[:ngay_cap]).try('text').try(:downcase).gsub("ngày cấp:", ""),
          nguoi_tham_chieu_1:@doc.xpath(xpaths[:nguoi_tham_chieu_1]).try('text').try(:downcase).gsub("thông tin người tham chiếu họ và tên:", ""),
          sdt_tham_chieu_1: @doc.xpath(xpaths[:sdt_tham_chieu_1]).try('text').try(:downcase).gsub("số điện thoại:", ""),
          nguoi_tham_chieu_2: @doc.xpath(xpaths[:nguoi_tham_chieu_2]).try('text').try(:downcase).gsub("họ và tên:", ""),
          sdt_tham_chieu_2: @doc.xpath(xpaths[:sdt_tham_chieu_2]).try('text').try(:downcase).gsub("số điện thoại:", ""),
          sdt: @doc.xpath(xpaths[:sdt]).try('text').try(:downcase).gsub("số đtdđ:", ""),
          dia_chi: @doc.xpath(xpaths[:dia_chi]).try('text').try(:downcase).gsub("địa chỉ công ty:", ""),
          tinh: @doc.xpath(xpaths[:tinh]).try('text').try(:downcase).gsub("địa chỉ công ty:", ""),
          ten_goi_vay: @doc.xpath(xpaths[:ten_goi_vay]).try('text').try(:downcase).gsub("tên gói sản phẩm:", ""),
          ngay_vay: @doc.xpath(xpaths[:ngay_vay]).try('text').try(:downcase),
        }
        rs 
      end

      def convert_html_and_parse(inputFile, options = {})
        outputFile = "#{Time.now.to_i}.html"
        stdin, stdout, stderr, process = to_html(inputFile, outputFile)
        rs = {}
        while process.alive? do
          sleep(1)
        end
        export_base_info(outputFile)
      end

    end

  end
end