From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [Lguest] [PATCH] virtio config_ops refactoring
Date: Fri, 09 Nov 2007 02:16:53 +0200
Message-ID: <4733A6F5.3040202__29333.6673909382$1194567534$gmane$org@qumranet.com>
References: <4730A8F3.6020008@us.ibm.com><200711081320.35844.rusty__6233.15023626692$1194488552$gmane$org@rustcorp.com.au><4732774C.6020903@codemonkey.ws><200711090924.28659.rusty@rustcorp.com.au><47338EA0.6050100@codemonkey.ws>
	<13426df10711081447o688550a4jc01be2d7f06209e0@mail.gmail.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6622043332650966682=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <13426df10711081447o688550a4jc01be2d7f06209e0@mail.gmail.com>
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
To: ron minnich <rminnich@gmail.com>
Cc: lguest <lguest@ozlabs.org>, Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============6622043332650966682==
Content-Type: multipart/alternative;
	boundary="------------000402070003050708070601"

This is a multi-part message in MIME format.
--------------000402070003050708070601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ron minnich wrote:
>
> Hi, I'm sorry, I've been stuck on other things (NFS RDMA anyone?) and
> missed part of this discussion.
>
> Is it really the case that operations on virtio devices will involve
> outl/inl etc.?
>
What's the problem with them?
Except for the kick event it's not performance critical and the 
difference between pio vmexit
and hypercall exit is very small.
I don't know about problems in other architectures, maybe mmio is better?
Dor.
>
>
> Apologies in advance for my failure to pay attention.
>
> thanks
>
> ron
> _______________________________________________
> Lguest mailing list
> Lguest@ozlabs.org
> https://ozlabs.org/mailman/listinfo/lguest
>


--------------000402070003050708070601
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
ron minnich wrote:
<blockquote
 cite="mid:13426df10711081447o688550a4jc01be2d7f06209e0@mail.gmail.com"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta name="Generator"
 content="MS Exchange Server version 6.5.7652.24">
  <title>Re: [Lguest] [PATCH] virtio config_ops refactoring</title>
<!-- Converted from text/plain format -->
  <p><font size="2">Hi, I'm sorry, I've been stuck on other things (NFS
RDMA anyone?) and<br>
missed part of this discussion.<br>
  <br>
Is it really the case that operations on virtio devices will involve<br>
outl/inl etc.?<br>
  </font></p>
</blockquote>
What's the problem with them?<br>
Except for the kick event it's not performance critical and the
difference between pio vmexit<br>
and hypercall exit is very small.<br>
I don't know about problems in other architectures, maybe mmio is
better?<br>
Dor.<br>
<blockquote
 cite="mid:13426df10711081447o688550a4jc01be2d7f06209e0@mail.gmail.com"
 type="cite">
  <p><font size="2"><br>
Apologies in advance for my failure to pay attention.<br>
  <br>
thanks<br>
  <br>
ron<br>
_______________________________________________<br>
Lguest mailing list<br>
<a class="moz-txt-link-abbreviated" href="mailto:Lguest@ozlabs.org">Lguest@ozlabs.org</a><br>
  <a moz-do-not-send="true"
 href="https://ozlabs.org/mailman/listinfo/lguest">https://ozlabs.org/mailman/listinfo/lguest</a><br>
  </font>
  </p>
</blockquote>
<br>
</body>
</html>

--------------000402070003050708070601--

--===============6622043332650966682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============6622043332650966682==--
