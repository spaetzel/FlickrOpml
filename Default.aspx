<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FlickrOpml._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Flickr Contacts OPML Generator</title>
    <link rel="stylesheet" type="text/css" href="style.css" />

</head>
<body>
    <h1>Flickr Contacts OPML Generator</h1>
    <p>This tool will generate an OPML file containing a single RSS feed for each of your Flickr contacts.
    The tool will also replace the thumbnails in the feeds with a larger size and give you the option 
    of filtering the feeds to contain only the best photos. Please send an e-mail to flic<a href="http://mailhide.recaptcha.net/d?k=01lk4Wovw-gRpmVoY5Ysbx9A==&amp;c=FXNHE5Sm07SMIwwxpmyie3F-AA2qdVAX9dh-W829iMA=" onclick="window.open('http://mailhide.recaptcha.net/d?k=01lk4Wovw-gRpmVoY5Ysbx9A==&amp;c=FXNHE5Sm07SMIwwxpmyie3F-AA2qdVAX9dh-W829iMA=', '', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=500,height=300'); return false;" title="Reveal this e-mail address">...</a>@redune.com with any questions.</p>
    <form action="Opml.ashx" method="get">
    <table>
        <tr>
            <td>
                Folder Name:
            </td>
            <td>
                <input name="tag" type="text" value="Flickr Contacts" />
            </td>
            <td>
                The folder in your reader that you would like your contacts to appear within.
            </td>
        </tr>
        <tr>
            <td>
                NSID:
            </td>
            <td>
                <input name="nsid" type="text"/>
            </td>
            <td>
                Your Flickr ID, find yours <a href="http://idgettr.com">here</a>.
            </td>
        </tr>
        <tr>
            <td>
                Size:
            </td>
            <td>
                <select id="size" name="size">
                    <option value="Large">Large</option>
                    <option value="Medium" selected="selected">Medium</option>
                    <option value="Small">Small</option>
                    <option value="Square">Square</option>
                </select>
            </td>
            <td>
                The size of photos you would like to appear in the feeds.
            </td>
        </tr>
        <tr>
            <td>
                PostRank
            </td>
            <td>
                <select id="postRank" name="postRank">
                    <option value="10">10 - Best</option>
                    <option value="9">9</option>
                    <option value="8">8</option>
                    <option value="7">7</option>
                    <option value="6">6</option>
                    <option value="5">5</option>
                    <option value="4">4</option>
                    <option value="3">3</option>
                    <option value="2">2</option>
                    <option value="1">1</option>
                    <option value="0" selected="selected">0 - All</option>
                </select>
            </td>
            <td>
                The minimum <a href="http://www.postrank.com/postrank">PostRank</a> of photos to
                allow in the feeds. The higher the number, the fewer photos will appear. Use this
                to only allow the best photos to appear. Set to 0 to disable PostRank filtering.
            </td>
        </tr>
    </table>
    <input type="submit" value="Get OPML File" />
    </form>
</body>
</html>
