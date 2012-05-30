using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Xml;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace Flick
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        static Random r = new Random();
        protected void leftButton_Click(object sender, CommandEventArgs e)
        {
            
            {
                string tags = searchBox.Text;
                tags = cleanTags(tags);
                string rss = "http://api.flickr.com/services/feeds/photos_public.gne?tags=" + tags + "&format=rss2";

                WebRequest WebRequestObject = HttpWebRequest.Create(rss);
                WebResponse ResponseObject = WebRequestObject.GetResponse();
                StreamReader reader = new StreamReader(ResponseObject.GetResponseStream());

                XmlDocument doc = new XmlDocument();
                doc.Load(reader);
                //namespace for tags with 'media:' eg media:thumbnail
                XmlNamespaceManager xmlnsManager = new XmlNamespaceManager(doc.NameTable);
                xmlnsManager.AddNamespace("prefix", "http://search.yahoo.com/mrss/");

                XmlNodeList imageList = doc.SelectNodes("/rss/channel/item");
                int classNum = 1;
                resultsLocation.Text = "";
                foreach (XmlNode item in imageList)
                {

                    XmlNode link = item.SelectSingleNode("prefix:thumbnail", xmlnsManager);
                    if (link != null)
                    {
                        XmlNode full = item.SelectSingleNode("prefix:content", xmlnsManager);

                        int top = r.Next(400);
                        int left = r.Next(550);

                        resultsLocation.Text += "<DIV savelink = " + full.Attributes["url"].Value + " savethumb=" + link.Attributes["url"].Value + " id='drag" + classNum + "' STYLE='position:absolute; float:none; top:" + top + "px; left:" + left;
                        resultsLocation.Text += "px;' onmouseover='this.style.zIndex = 10' onmouseout='this.style.zIndex = 0'  >";

                        classNum++;

                        resultsLocation.Text += "<img src = '";
                        resultsLocation.Text += link.Attributes["url"].Value;
                        resultsLocation.Text += "'/></div>";
                    }

                }
            }
            

        }

        private string cleanTags(string tags)
        {
            //take user input and validate, separate words with comma as per Flickr api
            return tags.Replace(" ", ",");
        }

        private string cleanSQL(string str)
        {
            return str.Replace("'", "''");;
        }

        protected void Button1_Click(object sender, CommandEventArgs e)
        {
            string link = linkHidden.Text;
            string thumb = thumbHidden.Text;
            link = cleanSQL(link);
            thumb = cleanSQL(thumb);
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DB_42245_imagetagConnectionString1"].ConnectionString);
            SqlCommand nonqueryCommand = conn.CreateCommand();

            try
            {
                // Open Connection
                conn.Open();

                // Create INSERT statement with named parameters
                nonqueryCommand.CommandText = "INSERT  INTO saves (image, mainimg, tag) VALUES (@image, @link, null)";

                // Add Parameters to Command Parameters collection
                nonqueryCommand.Parameters.Add("@image", SqlDbType.NVarChar, 100);
                nonqueryCommand.Parameters.Add("@link", SqlDbType.NVarChar, 100);
                nonqueryCommand.Parameters["@image"].Value = thumb;
                nonqueryCommand.Parameters["@link"].Value = link;
                nonqueryCommand.ExecuteNonQuery();

            }

            catch (SqlException ex)
            {
                // Display error
            }
            finally
            {
                conn.Close();
            }
            GridView1.DataBind();
        }


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
