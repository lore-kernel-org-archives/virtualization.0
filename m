Return-Path: <SRS0=2EET=LR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879AFC4743C
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 12:47:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F61A61076
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 12:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F61A61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3C9340267;
	Wed, 23 Jun 2021 12:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WPMjOm2_9OSN; Wed, 23 Jun 2021 12:47:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 475394022F;
	Wed, 23 Jun 2021 12:47:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27CDAC0010;
	Wed, 23 Jun 2021 12:47:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91922C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 12:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E44C40392
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 12:47:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lak2moCRePdY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 12:47:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BA574022A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 12:47:21 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id g24so1437195pji.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=lf/bJgo5dkIp0rmMdcZqx8HyzQPjXQWZsgAnRfK95R8=;
 b=b7ptnM45LZkIQuW21NCedG92URkS1ogKrkBtNrmU0N439/IehxWoxphCs6J9NyQDUn
 0w/I3Qo8/btsM7BMmdYvPaZtm2BVqqgSNNhG5O6zepIh/256C364OPFkLi4zcnF7iP+g
 5LMSaMir0acEHGmgTIBPWie2RbLiICa2VfjO+DZ5HpYJbGC92fIlmT8mgyL5Qjni8eb2
 Sla1Udt85urxeF8SYYUUFNevFEiFKMVyjOuPzmqJlhDvnybpNlGj5CJZZBLc8PseMVJT
 b4fdW50kIFGKjLU7L+Q7yYC5sNOkD2BdLEYh17koE4PVCo4lnvl4zC9oVeBcuU5ZH/a4
 tQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=lf/bJgo5dkIp0rmMdcZqx8HyzQPjXQWZsgAnRfK95R8=;
 b=uLdNlhyElc25fhBIZZttPdK6uvoDChzQrNYiwYUJjBR8TXCIVGn0JpEF1YleaVA7ul
 y0jVkX5YanZGzzE6dhi3AT3OLeGAyeubb5kjdAV8LGlFPhpH80i5Onsbc/tbeCfnq9Gb
 nGmUYbSoqIioaul/TVOHSOw6QRH/lGkvvz3300LCelUKo0Ro2rV2I0qJjY46ZQ3nfO7A
 vBORAW/oPay39DIvF8QuQBLt/DANG4BWWt9Cpbq6jUI+lhRRsamhepnIYPAZm8iBP6mm
 c1Ms89/orpVFFB/FaG+EfRYSeHgMxisHS1574JCC20Ys+Pu8Qpf8MfRWn86VI8LaqDD5
 H3sg==
X-Gm-Message-State: AOAM533ZqO1YMl1fXHDF1n9lUUomELByFSYUeWVhLHLYej76++FM6oJp
 Xxi4Q3+xFK5oTuABoL0CQfxvW7eDLx3x0qZwrCpHZ8OEbO0dDUw=
X-Google-Smtp-Source: ABdhPJyB5+fErLP53Srw7eYXZwzz15NE1uvY1Fpuf5hDOcTFwdUGnwBof9Pt5EGB1K7eS77m/crckyQbXGVPJYHHnB4=
X-Received: by 2002:a17:90a:9205:: with SMTP id
 m5mr4360539pjo.172.1624452440669; 
 Wed, 23 Jun 2021 05:47:20 -0700 (PDT)
MIME-Version: 1.0
From: Halley Zhao <aihua.halley.zhao@gmail.com>
Date: Wed, 23 Jun 2021 20:47:10 +0800
Message-ID: <CAJ1_6NDsB5pOct13uJ0DWqgC6-=+Rn5a8Zc6i0KxGtPR8AKpJA@mail.gmail.com>
Subject: Seeking advice on virtio dmabuf
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
Content-Type: multipart/mixed; boundary="===============5872186786299692838=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5872186786299692838==
Content-Type: multipart/alternative; boundary="000000000000ae417705c56e4e6c"

--000000000000ae417705c56e4e6c
Content-Type: text/plain; charset="UTF-8"

Hi Experts:
I notice that dmabuf sharing has been supported early this year:
https://lists.linuxfoundation.org/pipermail/virtualization/2021-February/052708.html

I'd like use it, but have some other thoughts, seeking your advice:
1. How about use shared dmabuf stream as virtual camera on host os side?
the above implementation supports qemu for now, with newly defined ioctl
command and events; but not available for common app usage.  if we add
dmabuf stream as a node for V4L2, then app can use the stream as a virtual
camera.
though, there is still some gap in V4L2, since V4L2 support V4L2_MEMORY_DMABUF
by importing external dmabuf. anyway, I can give it a quick try: app may
send dmabuf to V4L2 and host kernel driver copy the guest dmabuf data to
app created dmabuf.
2. in the above implementation, dmabuf is shared between guest and host
with few information, size only. w/o width/height/stride/format
information. I don't know how the userspace app could retrieve these buffer
attributes. the patch creates some special ioctl command and data structure
for new usage.
as to guest and host kernel driver, how about reuse fb or v4l2(OUTPUT)
device command for the shared dmabuf? then we can reuse the well-defined
interface of fb or v4l2.

appreciate for your comments.

--000000000000ae417705c56e4e6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Experts:<div>I notice that dmabuf sharing has been supp=
orted early this year:=C2=A0<a href=3D"https://lists.linuxfoundation.org/pi=
permail/virtualization/2021-February/052708.html">https://lists.linuxfounda=
tion.org/pipermail/virtualization/2021-February/052708.html</a></div><div><=
br></div><div>I&#39;d like use it, but have some other thoughts, seeking yo=
ur=C2=A0advice:</div><div>1. How about use shared dmabuf stream as virtual =
camera on host os side?</div><div>the above implementation supports qemu fo=
r now, with newly defined ioctl command and events; but not available for c=
ommon app usage.=C2=A0 if we add dmabuf stream as a node for V4L2, then app=
 can use the stream as a virtual camera.</div><div>though, there is still s=
ome gap in V4L2, since V4L2 support=C2=A0<span style=3D"color:black;font-fa=
mily:=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91;font-size:10pt">V4L2_MEMORY_DMABU=
F by importing external dmabuf. anyway, I can give it a quick try: app may =
send dmabuf to V4L2 and host kernel driver copy the guest dmabuf data to ap=
p created dmabuf.</span></div><div><span style=3D"color:black;font-family:=
=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91;font-size:10pt">2. in the above implem=
entation, dmabuf is shared between guest and host with few information, siz=
e only. w/o width/height/stride/format information. I don&#39;t know how th=
e userspace app could retrieve these buffer attributes. the patch creates s=
ome special ioctl command and data structure for new usage.</span></div><di=
v><span style=3D"color:black;font-family:=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=
=91;font-size:10pt">as to guest and host kernel driver, how about reuse fb =
or v4l2(OUTPUT) device command for the shared dmabuf? then we can reuse the=
 well-defined interface of fb or v4l2.</span></div><div><span style=3D"colo=
r:black;font-family:=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91;font-size:10pt"><b=
r></span></div><div><span style=3D"color:black;font-family:=E5=BE=AE=E8=BD=
=AF=E9=9B=85=E9=BB=91;font-size:10pt">appreciate for your comments.</span><=
/div></div>

--000000000000ae417705c56e4e6c--

--===============5872186786299692838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5872186786299692838==--
