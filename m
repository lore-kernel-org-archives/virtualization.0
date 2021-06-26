Return-Path: <SRS0=Vnwm=LU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47ADC2B9F4
	for <virtualization@archiver.kernel.org>; Sat, 26 Jun 2021 00:28:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E7561963
	for <virtualization@archiver.kernel.org>; Sat, 26 Jun 2021 00:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E7561963
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3262A400DC;
	Sat, 26 Jun 2021 00:28:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u20EzxIE1Sy6; Sat, 26 Jun 2021 00:28:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7C8740025;
	Sat, 26 Jun 2021 00:28:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D00CC0010;
	Sat, 26 Jun 2021 00:28:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F611C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Jun 2021 00:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 033FE606F7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Jun 2021 00:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FmSVKErPtVU6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Jun 2021 00:28:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2150F60607
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Jun 2021 00:28:46 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 z3-20020a17090a3983b029016bc232e40bso6491410pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 17:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=gUzNA6icESOi6r5yBhlC4RfW16OnXxUIkK8ty8beQx4=;
 b=cQYchxcxYG8KaEyotj+Td6Bxh+Aodu/7R7MzWpzdC7LUwdDfUq6+wwuoO4Fsb0yLEQ
 H/rPExUb8VH2MXVzzp1RjN+HBFfJl6UUh+OLjv0fbt+18B81R9/0bA5NPxgzG8MPP5Bc
 f6DM+wrwS13VbevPbJXtzFX20Bt5u+kBOWT1VtvA32YQR7KsBgacRsaQHmx2Wt52vf9o
 lLXGyPPS+sdxwc1uHajAXq03RIENVn9p39FnFBcK2byYN8uccOIhvCaNptIBqtNcN5DZ
 AWzWHFDasp4hzxn6PvWvLhge4FfAWQO3oAWXSUdJL+bGVJ//3mu+avYZbdJEt8txhBar
 LxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=gUzNA6icESOi6r5yBhlC4RfW16OnXxUIkK8ty8beQx4=;
 b=VDOp2yt/FacrJw+YCfzLjwi9oQnkZNYGyxUZ6uH76ay/gqjEdXP1m7DHoGGkFOvV3b
 0vkU2SC7UjKuUTNsE1Ay4hXX4TcJB6nDi4Xz7pDKbaXlTfDnREv66CrHScOHscQ7tYQ5
 SzKqX2ahOLSwtrS9OJY3JMn/ILwsCehoPeQqbnTE8VGcN3NjVU29o3R+AvFzePjptnn8
 Ibf7lPiglr4bjOQ8GZq/5rtPmIQqYy7VG4lnoYDf59HgdS34wCMNqwXkxz8xEv8Cjvyb
 VrmaR+VWb20pVaa6H0CIc4Cz8MJItWJNLoPhU+X02IaJurjAXUFOhcShdJg8UCizhcDV
 EzMA==
X-Gm-Message-State: AOAM532KalJCx+IohfRIjjwm2eKfxTlgaqNL928c9N98RuNCqZlIgEXc
 TZN90gOrJzCZ9nXpT2E7RXWReVYEhzw3jx2j0fFW3VU=
X-Google-Smtp-Source: ABdhPJxkZEBiieUMEp6/3OKqnc2wARy9hMn1N/qr/9Gd7ZTZphNQgY6yn2UKYUkA2kHIru0jVtLBE0ktALSx693PtRA=
X-Received: by 2002:a17:90a:5202:: with SMTP id
 v2mr7644764pjh.169.1624667325465; 
 Fri, 25 Jun 2021 17:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ1_6NDsB5pOct13uJ0DWqgC6-=+Rn5a8Zc6i0KxGtPR8AKpJA@mail.gmail.com>
In-Reply-To: <CAJ1_6NDsB5pOct13uJ0DWqgC6-=+Rn5a8Zc6i0KxGtPR8AKpJA@mail.gmail.com>
From: Halley Zhao <aihua.halley.zhao@gmail.com>
Date: Sat, 26 Jun 2021 08:28:34 +0800
Message-ID: <CAJ1_6NAAY9rSL_PooVvVhXU=vDw_srep7RtP3PVU-_3895hd_A@mail.gmail.com>
Subject: Re: Seeking advice on virtio dmabuf
To: virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4704133688330760805=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4704133688330760805==
Content-Type: multipart/alternative; boundary="000000000000d0082a05c5a05679"

--000000000000d0082a05c5a05679
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

for the 2nd point, I begin to understand the logic,
there are some userspace priv data passed with sgtable between guest and
host os;  width/height/stride/format and other information can be sent
inside these private data.
these private data is opaque to kernel driver, doesn't require negotiation
from the point of dmabuf.



Halley Zhao <aihua.halley.zhao@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=882=
3=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:47=E5=86=99=E9=81=93=EF=BC=
=9A

> Hi Experts:
> I notice that dmabuf sharing has been supported early this year:
> https://lists.linuxfoundation.org/pipermail/virtualization/2021-February/=
052708.html
>
> I'd like use it, but have some other thoughts, seeking your advice:
> 1. How about use shared dmabuf stream as virtual camera on host os side?
> the above implementation supports qemu for now, with newly defined ioctl
> command and events; but not available for common app usage.  if we add
> dmabuf stream as a node for V4L2, then app can use the stream as a virtua=
l
> camera.
> though, there is still some gap in V4L2, since V4L2 support V4L2_MEMORY_D=
MABUF
> by importing external dmabuf. anyway, I can give it a quick try: app may
> send dmabuf to V4L2 and host kernel driver copy the guest dmabuf data to
> app created dmabuf.
> 2. in the above implementation, dmabuf is shared between guest and host
> with few information, size only. w/o width/height/stride/format
> information. I don't know how the userspace app could retrieve these buff=
er
> attributes. the patch creates some special ioctl command and data structu=
re
> for new usage.
> as to guest and host kernel driver, how about reuse fb or v4l2(OUTPUT)
> device command for the shared dmabuf? then we can reuse the well-defined
> interface of fb or v4l2.
>
> appreciate for your comments.
>

--000000000000d0082a05c5a05679
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">for the 2nd point, I begin to understand the logic,<div>th=
ere are some userspace priv data passed with sgtable between guest and host=
 os;=C2=A0 width/height/stride/format and other information can be sent ins=
ide these private data.</div><div>these private data is opaque=C2=A0to kern=
el driver, doesn&#39;t require negotiation from the point of dmabuf.</div><=
div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Halley Zhao &lt;<a href=3D"mailto:aihua.halle=
y.zhao@gmail.com">aihua.halley.zhao@gmail.com</a>&gt; =E4=BA=8E2021=E5=B9=
=B46=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:47=E5=86=99=
=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr">Hi Experts:<div>I notice that dmabuf sharing has been s=
upported early this year:=C2=A0<a href=3D"https://lists.linuxfoundation.org=
/pipermail/virtualization/2021-February/052708.html" target=3D"_blank">http=
s://lists.linuxfoundation.org/pipermail/virtualization/2021-February/052708=
.html</a></div><div><br></div><div>I&#39;d like use it, but have some other=
 thoughts, seeking your=C2=A0advice:</div><div>1. How about use shared dmab=
uf stream as virtual camera on host os side?</div><div>the above implementa=
tion supports qemu for now, with newly defined ioctl command and events; bu=
t not available for common app usage.=C2=A0 if we add dmabuf stream as a no=
de for V4L2, then app can use the stream as a virtual camera.</div><div>tho=
ugh, there is still some gap in V4L2, since V4L2 support=C2=A0<span style=
=3D"color:black;font-family:=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91;font-size:=
10pt">V4L2_MEMORY_DMABUF by importing external dmabuf. anyway, I can give i=
t a quick try: app may send dmabuf to V4L2 and host kernel driver copy the =
guest dmabuf data to app created dmabuf.</span></div><div><span style=3D"co=
lor:black;font-family:=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91;font-size:10pt">=
2. in the above implementation, dmabuf is shared between guest and host wit=
h few information, size only. w/o width/height/stride/format information. I=
 don&#39;t know how the userspace app could retrieve these buffer attribute=
s. the patch creates some special ioctl command and data structure for new =
usage.</span></div><div><span style=3D"color:black;font-family:=E5=BE=AE=E8=
=BD=AF=E9=9B=85=E9=BB=91;font-size:10pt">as to guest and host kernel driver=
, how about reuse fb or v4l2(OUTPUT) device command for the shared dmabuf? =
then we can reuse the well-defined interface of fb or v4l2.</span></div><di=
v><span style=3D"color:black;font-family:=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=
=91;font-size:10pt"><br></span></div><div><span style=3D"color:black;font-f=
amily:=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91;font-size:10pt">appreciate for y=
our comments.</span></div></div>
</blockquote></div>

--000000000000d0082a05c5a05679--

--===============4704133688330760805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4704133688330760805==--
