From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 20:13:18 +0300
Message-ID: <4A36812E.3050909@redhat.com>
References: <4A364381.401@redhat.com> <4A364401.6010500@codemonkey.ws>	
	<4A3647FB.9010808@redhat.com> <4A364B53.9080007@codemonkey.ws>	
	<4A364FE0.40204@redhat.com> <4A3651EB.3070204@codemonkey.ws>	
	<4A36555A.4090303@redhat.com> <4A3659A0.3050108@codemonkey.ws>	
	<20090615143737.GB14405@redhat.com>
	<4A3662BA.6030304@codemonkey.ws>	
	<20090615150804.GH7233@redhat.com> <4A3664EE.30207@redhat.com>
	<1245083231.3222.104.camel@blaa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5217256499067416666=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1245083231.3222.104.camel@blaa>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============5217256499067416666==
Content-Type: multipart/alternative;
 boundary="------------000201020409010800000406"

This is a multi-part message in MIME format.
--------------000201020409010800000406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/15/2009 07:27 PM, Mark McLoughlin wrote:
>
> Providing end users with the *option* to choose PCI slots sounds like a
> fine feature request for any management app.
>
> Requiring all management apps to force end users to explicitly choose
> PCI slots in order for slots to be stable is not so reasonable.
>    

Think any installer's partitioning utility.  It will provide a default 
placement and try to hide it from you.  If you ask, it will let you 
place the partitions yourself.

The management app is the end user's agent.  When we push something 
there, we allow it to choose something, or push the decision further up 
to the user.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.


--------------000201020409010800000406
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
On 06/15/2009 07:27 PM, Mark McLoughlin wrote:<br>
<blockquote cite="mid:1245083231.3222.104.camel@blaa" type="cite">
  <pre wrap=""><!---->
Providing end users with the *option* to choose PCI slots sounds like a
fine feature request for any management app.

Requiring all management apps to force end users to explicitly choose
PCI slots in order for slots to be stable is not so reasonable.
  </pre>
</blockquote>
<br>
Think any installer's partitioning utility.&nbsp; It will provide a default
placement and try to hide it from you.&nbsp; If you ask, it will let you
place the partitions yourself.<br>
<br>
The management app is the end user's agent.&nbsp; When we push something
there, we allow it to choose something, or push the decision further up
to the user.<br>
<pre class="moz-signature" cols="72">-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.</pre>
</body>
</html>

--------------000201020409010800000406--

--===============5217256499067416666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============5217256499067416666==--
