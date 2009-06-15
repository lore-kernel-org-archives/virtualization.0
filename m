From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 20:09:22 +0300
Message-ID: <4A368042.7060502@redhat.com>
References: <1244821292.30522.56.camel@blaa>	
	<4A327E4A.7010300@codemonkey.ws>	<1244825303.26769.19.camel@blaa>	
	<20090614095016.GA7560@redhat.com>	<1245056916.6891.31.camel@blaa>	
	<4A3613EC.6030608@redhat.com>	<20090615103249.GB6351@redhat.com>	
	<4A363012.8050409@redhat.com>	<20090615114858.GG6351@redhat.com>	
	<4A3636FA.1040609@redhat.com>	<20090615124101.GH6351@redhat.com>	
	<4A364381.401@redhat.com>	<4A364401.6010500@codemonkey.ws>	
	<4A3647FB.9010808@redhat.com>	<4A364B53.9080007@codemonkey.ws>	
	<4A364FE0.40204@redhat.com> <4A3651EB.3070204@codemonkey.ws>	
	<4A36555A.4090303@redhat.com> <4A3659A0.3050108@codemonkey.ws>	
	<4A366348.1030202@redhat.com> <1245083229.3222.103.camel@blaa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8238121640501449462=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1245083229.3222.103.camel@blaa>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============8238121640501449462==
Content-Type: multipart/alternative;
 boundary="------------000404090704080701010503"

This is a multi-part message in MIME format.
--------------000404090704080701010503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/15/2009 07:27 PM, Mark McLoughlin wrote:
>> However this may end up, isn't it offtopic?  Whatever we do we have to
>> support both pci_addr= and default placement, so we can push this
>> discussion to livirt-devel and bid them godspeed.
>>      
>
> Presumably you're not proposing that qemu-devel completely ignore the
> typical requirements of management apps?
>    

We propose to allow both qemu-allocated slots and user-allocated slots, 
so we're only ignoring the actual decision by the management tool 
providers, not their requirements.

> You can push the discussion to libvirt-devel, and the conclusion would
> most likely be:
>
>    "We can do slot allocation if you provide us with a way to query free
>     slots, or we can use qemu's default allocation if you provide us a
>     way to query the allocation.
>
>     We'd prefer the default allocation problem, but we don't really
>     care. Both require about the same amount of work for us."
>    

Well, they'll find out if they try default allocation.  It's traditional 
to try all the complicated solutions before trying the simplest one, so 
I guess we'll just have to let them.

> libvirt was only mentioned in this thread as a concrete example of how
> the suggested solutions would actually be used by management apps.
>    

True, others will wind up doing things differently.  In fact, I'm a 
little surprised that libvirt is involved, since the place to do 
inventory is in the management app itself (it's true that libvirt also 
maintains its own database, so the line is blurred).

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.


--------------000404090704080701010503
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
On 06/15/2009 07:27 PM, Mark McLoughlin wrote:<br>
<blockquote cite="mid:1245083229.3222.103.camel@blaa" type="cite">
  <blockquote type="cite">
    <pre wrap="">However this may end up, isn't it offtopic?  Whatever we do we have to 
support both pci_addr= and default placement, so we can push this 
discussion to livirt-devel and bid them godspeed.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Presumably you're not proposing that qemu-devel completely ignore the
typical requirements of management apps?
  </pre>
</blockquote>
<br>
We propose to allow both qemu-allocated slots and user-allocated slots,
so we're only ignoring the actual decision by the management tool
providers, not their requirements.<br>
<br>
<blockquote cite="mid:1245083229.3222.103.camel@blaa" type="cite">
  <pre wrap="">You can push the discussion to libvirt-devel, and the conclusion would
most likely be:

  "We can do slot allocation if you provide us with a way to query free 
   slots, or we can use qemu's default allocation if you provide us a
   way to query the allocation.

   We'd prefer the default allocation problem, but we don't really 
   care. Both require about the same amount of work for us."
  </pre>
</blockquote>
<br>
Well, they'll find out if they try default allocation.&nbsp; It's
traditional to try all the complicated solutions before trying the
simplest one, so I guess we'll just have to let them.<br>
<br>
<blockquote cite="mid:1245083229.3222.103.camel@blaa" type="cite">
  <pre wrap="">libvirt was only mentioned in this thread as a concrete example of how
the suggested solutions would actually be used by management apps.
  </pre>
</blockquote>
<br>
True, others will wind up doing things differently.&nbsp; In fact, I'm a
little surprised that libvirt is involved, since the place to do
inventory is in the management app itself (it's true that libvirt also
maintains its own database, so the line is blurred).<br>
<pre class="moz-signature" cols="72">-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.</pre>
</body>
</html>

--------------000404090704080701010503--

--===============8238121640501449462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============8238121640501449462==--
