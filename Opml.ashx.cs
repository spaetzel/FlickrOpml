using System;
using System.Collections;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Configuration;

namespace FlickrOpml
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class Opml : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string nsid = context.Request.QueryString["nsid"].Trim();
            string tag = context.Request.QueryString["tag"].Trim();
            int postRank = Convert.ToInt32(context.Request.QueryString["postRank"].Trim());
            string size = context.Request.QueryString["size"].Trim();

            XDocument contactsDoc = GetContactsDoc(nsid);

            var items = from c in contactsDoc.Descendants("contact")
                        select new XElement("outline",
                            new XAttribute("title", String.Format("Uploads from {0}, Min PostRank: {1}", c.Attribute("username").Value, postRank)),
                                    new XAttribute("type", "rss"),
                                    new XAttribute("version", "RSS"),
                                    new XAttribute("xmlUrl", GetPipeFeedUrl(c.Attribute("nsid").Value, c.Attribute("username").Value, size, postRank)),
                                    new XAttribute("htmlUrl", string.Format("http://flickr.com/photos/{0}", c.Attribute("nsid").Value))
                                    );

            XDocument document = new XDocument(
                new XElement("opml",
                    new XElement("body",
                        new XElement("outline",
                            new XAttribute("title", tag),
            items))));

            context.Response.ContentType = "text/xml";
            context.Response.AddHeader("content-disposition", "attachment; filename=flickrContacts.opml");
            document.Save(context.Response.Output);
            context.Response.End();  

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        private static XDocument GetContactsDoc(string nsid)
        {
            string url = String.Format("http://api.flickr.com/services/rest?method=flickr.contacts.getPublicList&api_key={0}&user_id={1}&page=1&per_page=1000", ConfigurationSettings.AppSettings["apiKey"], nsid);

            XDocument doc = XDocument.Load(url);

            return doc;
        }

        private static string GetPipeFeedUrl(string nsid, string title, string size, int minPostrank)
        {

            string flickrFeed = String.Format("http://api.flickr.com/services/feeds/photos_public.gne?id={0}&lang=en-us&format=atom", nsid);

            string pipeFeed = String.Format("http://pipes.yahoo.com/pipes/pipe.run?Feed={0}&_id=8d927c19da2500032cb9f10d5601c892&_render=rss&postrank={1}&size={2}&title={3}", HttpUtility.UrlEncode(flickrFeed), minPostrank, size, title);

            return pipeFeed;
        }
    }
}
