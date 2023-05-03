Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2542C77B78
	for <virtualization@archiver.kernel.org>; Wed,  3 May 2023 17:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AEE283C3A;
	Wed,  3 May 2023 17:07:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AEE283C3A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J9QxD/1Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4uHnM_Fb015A; Wed,  3 May 2023 17:07:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 96BB583C2C;
	Wed,  3 May 2023 17:07:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96BB583C2C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FFBBC0037;
	Wed,  3 May 2023 17:07:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5034AC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 17:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E09683C2D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 17:07:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E09683C2D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r--AtOEF5wXh
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 17:07:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B3C983C2C
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B3C983C2C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 17:07:45 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-50bc070c557so8781261a12.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 May 2023 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1683133664; x=1685725664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tqgRjKeAlYwdSQZlNcCAAg86aRPeNLHNBU6nas3RZ6E=;
 b=J9QxD/1QXu+7IwdDU81QuY6jTbppC0cHLNpRQwNP60tcx3RCZvR71AQVXfzxRNMfH0
 W0ydkkEltICHurrgEIGDrzhZCvIez22yOFwaexx3D1eAkFC/QPapJStjEYmBDR3lo04c
 cXUxcSAnmC8BgCAfzYTsgSX7OpwOzMhKoQ+/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683133664; x=1685725664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tqgRjKeAlYwdSQZlNcCAAg86aRPeNLHNBU6nas3RZ6E=;
 b=g4C/0gx4LoYuD6OwUnXzZwmprQV+pJmWpcWwsGJrPlZveEzLk875DI+OCBC/5jrLHF
 P6g+PDm/S2z0kl/sheppV+/7EDtmrMwBa0xtVdxrWsY/2elEKtPl/Q1Lz74pdsdlroBo
 JdLdtuEWUuv0iPIjfdTLdrMdQlJHXd+Z/01KxMqpIQRFy2J05k3xSVcPXYvr+yXo4qHo
 YpeJaN8i8/ya2/NVQNUPmS/BDhGNoJxmbdN9F+XKpZIrXKyr1bkLaHOPS3mNjIuO8KqA
 caFHEcBxrKtYeaAmMobKHZIo2mvAvUHE4c7t//L2y9xukywGcBQHZNpk9VqwVCUNZn3D
 Yy2w==
X-Gm-Message-State: AC+VfDwgLkE2wl9WoWdkN6nhdnCQOYpo4uJlpfOit+XTZ1FIPgrZs12M
 fZZ+YMyYtFi5F03BAkHfvm60cUO3kLi/WSMdEcs=
X-Google-Smtp-Source: ACHHUZ5TSg2evZ2Ojmv23S8jpxPxqN0A4/94BmFkNMr6d/4bw97l4myCexL90Lf9SlB89JYHB6E8Tw==
X-Received: by 2002:a17:907:9721:b0:94f:3980:bf91 with SMTP id
 jg33-20020a170907972100b0094f3980bf91mr4713221ejc.19.1683133664145; 
 Wed, 03 May 2023 10:07:44 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com.
 [209.85.208.43]) by smtp.gmail.com with ESMTPSA id
 gv57-20020a1709072bf900b00960c27e4611sm7580504ejc.181.2023.05.03.10.07.43
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 May 2023 10:07:43 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-4d9b2045e1cso13922a12.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 May 2023 10:07:43 -0700 (PDT)
X-Received: by 2002:a05:6402:2b90:b0:50a:20bf:d92d with SMTP id
 fj16-20020a0564022b9000b0050a20bfd92dmr83038edb.5.1683133663353; Wed, 03 May
 2023 10:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com>
In-Reply-To: <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 3 May 2023 10:07:31 -0700
X-Gmail-Original-Message-ID: <CAAfnVBnrUotph4TYJVu9Bohqv3m80t90V34TNhh-Tspxwsj-ZQ@mail.gmail.com>
Message-ID: <CAAfnVBnrUotph4TYJVu9Bohqv3m80t90V34TNhh-Tspxwsj-ZQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Rob Clark <robdclark@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@redhat.com>,
 kernel@collabora.com, Chia-I Wu <olvaffe@gmail.com>,
 Emil Velikov <emil.velikov@collabora.com>
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
Content-Type: multipart/mixed; boundary="===============2531182391468620778=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2531182391468620778==
Content-Type: multipart/alternative; boundary="0000000000001d933005facd18d1"

--0000000000001d933005facd18d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 1, 2023 at 8:38=E2=80=AFAM Dmitry Osipenko <
dmitry.osipenko@collabora.com> wrote:

> On 4/16/23 14:52, Dmitry Osipenko wrote:
> > We have multiple Vulkan context types that are awaiting for the additio=
n
> > of the sync object DRM UAPI support to the VirtIO-GPU kernel driver:
> >
> >  1. Venus context
> >  2. Native contexts (virtio-freedreno, virtio-intel, virtio-amdgpu)
> >
> > Mesa core supports DRM sync object UAPI, providing Vulkan drivers with =
a
> > generic fencing implementation that we want to utilize.
> >
> > This patch adds initial sync objects support. It creates fundament for =
a
> > further fencing improvements. Later on we will want to extend the
> VirtIO-GPU
> > fencing API with passing fence IDs to host for waiting, it will be a ne=
w
> > additional VirtIO-GPU IOCTL and more. Today we have several VirtIO-GPU
> context
> > drivers in works that require VirtIO-GPU to support sync objects UAPI.
> >
> > The patch is heavily inspired by the sync object UAPI implementation of
> the
> > MSM driver.
>
> Gerd, do you have any objections to merging this series?
>
> We have AMDGPU [1] and Intel [2] native context WIP drivers depending on
> the sync object support. It is the only part missing from kernel today
> that is wanted by the native context drivers. Otherwise, there are few
> other things in Qemu and virglrenderer left to sort out.
>
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
> [2]
> https://gitlab.freedesktop.org/digetx/mesa/-/commits/native-context-iris


I'm not saying this change isn't good, just it's probably possible to
implement the native contexts (even up to even VK1.2) without it.  But this
patch series may be the most ergonomic way to do it, given how Mesa is
designed.  But you probably want one of Mesa MRs reviewed first before
merging (I added a comment on the amdgpu change) and that is a requirement
[a].

[a] "The userspace side must be fully reviewed and tested to the standards
of that user space project. For e.g. mesa this means piglit testcases and
review on the mailing list. This is again to ensure that the new interface
actually gets the job done." -- from the requirements


>
>
> --
> Best regards,
> Dmitry
>
>

--0000000000001d933005facd18d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 1, 2023 at 8:38=E2=80=AFA=
M Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com">dmit=
ry.osipenko@collabora.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 4/16/23 14:52, Dmitry Osipenko wrote:<br>
&gt; We have multiple Vulkan context types that are awaiting for the additi=
on<br>
&gt; of the sync object DRM UAPI support to the VirtIO-GPU kernel driver:<b=
r>
&gt; <br>
&gt;=C2=A0 1. Venus context<br>
&gt;=C2=A0 2. Native contexts (virtio-freedreno, virtio-intel, virtio-amdgp=
u)<br>
&gt; <br>
&gt; Mesa core supports DRM sync object UAPI, providing Vulkan drivers with=
 a<br>
&gt; generic fencing implementation that we want to utilize.<br>
&gt; <br>
&gt; This patch adds initial sync objects support. It creates fundament for=
 a<br>
&gt; further fencing improvements. Later on we will want to extend the Virt=
IO-GPU<br>
&gt; fencing API with passing fence IDs to host for waiting, it will be a n=
ew<br>
&gt; additional VirtIO-GPU IOCTL and more. Today we have several VirtIO-GPU=
 context<br>
&gt; drivers in works that require VirtIO-GPU to support sync objects UAPI.=
<br>
&gt; <br>
&gt; The patch is heavily inspired by the sync object UAPI implementation o=
f the<br>
&gt; MSM driver.<br>
<br>
Gerd, do you have any objections to merging this series?<br>
<br>
We have AMDGPU [1] and Intel [2] native context WIP drivers depending on<br=
>
the sync object support. It is the only part missing from kernel today<br>
that is wanted by the native context drivers. Otherwise, there are few<br>
other things in Qemu and virglrenderer left to sort out.<br>
<br>
[1] <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21=
658" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/me=
sa/mesa/-/merge_requests/21658</a><br>
[2] <a href=3D"https://gitlab.freedesktop.org/digetx/mesa/-/commits/native-=
context-iris" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedeskt=
op.org/digetx/mesa/-/commits/native-context-iris</a></blockquote><div><br><=
/div><div>I&#39;m not saying this change isn&#39;t good, just it&#39;s prob=
ably possible to implement the native contexts (even up to even VK1.2) with=
out it.=C2=A0 But this patch series may be the most ergonomic way to do it,=
 given how Mesa is designed.=C2=A0 But you probably want one of Mesa MRs re=
viewed first before merging (I added a comment on the amdgpu change) and th=
at is a requirement [a].=C2=A0</div><div><br></div><div>[a] &quot;The users=
pace side must be fully reviewed and tested to the standards of that user s=
pace project. For e.g. mesa this means piglit testcases and review on the m=
ailing list. This is again to ensure that the new interface actually gets t=
he job done.&quot; -- from the requirements</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>
<br>
-- <br>
Best regards,<br>
Dmitry<br>
<br>
</blockquote></div></div>

--0000000000001d933005facd18d1--

--===============2531182391468620778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2531182391468620778==--
