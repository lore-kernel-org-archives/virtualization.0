From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [PATCH 0/6] virtio with config abstraction and ring
	implementation
Date: Thu, 20 Sep 2007 15:43:54 +0200
Message-ID: <46F2791A.8070601__37159.9260288805$1190296124$gmane$org@qumranet.com>
References: <1190289808.7262.223.camel@localhost.localdomain>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5294556754372658894=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190289808.7262.223.camel@localhost.localdomain>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============5294556754372658894==
Content-Type: multipart/alternative;
	boundary="------------020400040408010003010806"

This is a multi-part message in MIME format.
--------------020400040408010003010806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rusty Russell wrote:
>
> Hi all,
>
>         This patch series attempts to come closer to unifying kvm and 
> lguest's
> usage of virtio.  As these two are the first implementations we've seen,
> I hope making them closer will make future ones closer too.
>
>         Drivers now unpack their own configuration: their probe() 
> methods are
> uniform.  The configuration mechanism is extensible and can be backed by
> PCI, a string of bytes, or something else.
>
>         I've abstracted out the lguest ring buffer code into a common 
> library.
> The format has changed slightly (mainly because I had an epiphany about
> inter-guest I/O).
>
>         I also implemented a console (lguest needs one).
>
>         Finally, there is a working lguest implementation.  Unfortunately,
> lguest is being refactored for non-i386 ports, so the virtio patches sit
> at the end of the (quite long) for-2.6.24 patchqueue.  Nonetheless, they
> can be found at http://lguest.ozlabs.org/patches (click on bz2 to get
> the series).
>
> Cheers!
> Rusty.
>
Superb job, it saved me the burden of try to merge the in-house 
virtio_backend.

I like the separation of the ring code, the improved descriptors and the 
notify too.
Regarding the pci config space, I rather see config_ops type of 
operations to let
the 390/xen/other implementations jump on our wagon.

Maybe change the offset/len type into a handle pointer and function 
pointers.
The best would be to let them comment on that. I glimpsed over xen 
netfront.c and I think that
the config space can be used without too many hassles
Dor.


--------------020400040408010003010806
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Rusty Russell wrote:
<blockquote cite="mid:1190289808.7262.223.camel@localhost.localdomain"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta name="Generator"
 content="MS Exchange Server version 6.5.7652.24">
  <title>[PATCH 0/6] virtio with config abstraction and ring
implementation</title>
<!-- Converted from text/plain format -->
  <p><font size="2">Hi all,<br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This patch series attempts to come closer to unifying kvm and
lguest's<br>
usage of virtio.&nbsp; As these two are the first implementations we've seen,<br>
I hope making them closer will make future ones closer too.<br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Drivers now unpack their own configuration: their probe()
methods are<br>
uniform.&nbsp; The configuration mechanism is extensible and can be backed by<br>
PCI, a string of bytes, or something else.<br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I've abstracted out the lguest ring buffer code into a common
library.<br>
The format has changed slightly (mainly because I had an epiphany about<br>
inter-guest I/O).<br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I also implemented a console (lguest needs one).<br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Finally, there is a working lguest implementation.&nbsp;
Unfortunately,<br>
lguest is being refactored for non-i386 ports, so the virtio patches sit<br>
at the end of the (quite long) for-2.6.24 patchqueue.&nbsp; Nonetheless, they<br>
can be found at <a moz-do-not-send="true"
 href="http://lguest.ozlabs.org/patches">http://lguest.ozlabs.org/patches</a>
(click on bz2 to get<br>
the series).<br>
  <br>
Cheers!<br>
Rusty.<br>
  </font><br>
  </p>
</blockquote>
Superb job, it saved me the burden of try to merge the in-house
virtio_backend.<br>
<br>
I like the separation of the ring code, the improved descriptors and
the notify too.<br>
Regarding the pci config space, I rather see config_ops type of
operations to let <br>
the 390/xen/other implementations jump on our wagon.<br>
<br>
Maybe change the offset/len type into a handle pointer and function
pointers.<br>
The best would be to let them comment on that. I glimpsed over xen
netfront.c and I think that<br>
the config space can be used without too many hassles<br>
Dor.<br>
<br>
</body>
</html>

--------------020400040408010003010806--

--===============5294556754372658894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============5294556754372658894==--
