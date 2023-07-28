Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5CFEB64DD
	for <virtualization@archiver.kernel.org>; Fri, 28 Jul 2023 22:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D718D421B8;
	Fri, 28 Jul 2023 22:04:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D718D421B8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dRlwR8eK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YdwWC4r1d_Qm; Fri, 28 Jul 2023 22:04:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E67C3421F8;
	Fri, 28 Jul 2023 22:04:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E67C3421F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADFFCC0072;
	Fri, 28 Jul 2023 22:04:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE5C5C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 22:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D44661500
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 22:04:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D44661500
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dRlwR8eK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E23B5olf895A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 22:04:05 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA479614F9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 22:04:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA479614F9
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-98dfb3f9af6so366860966b.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 15:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1690581842; x=1691186642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=haX0t9f5hamyUvHUswvSCOkaKoMQnOQJcQIDNPRvdEM=;
 b=dRlwR8eK6YaxNI4Bzu02zh3txrAR6Mj3KrAyZvU5E0bUCA3qsCpsYtHwFgIbvEuS5E
 gSne2rM0czZ7DNGojkAtCsgdl7cnC9wa189YkZQPBdXksELm0elWlSc2NZ+QnBaK2uJW
 UbckgSPW4z/up8bfYmLUiPVsBOlAS7ztD1Ed4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690581842; x=1691186642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=haX0t9f5hamyUvHUswvSCOkaKoMQnOQJcQIDNPRvdEM=;
 b=JhEfE3XSpLeDBYQRh93yYM/02s1QkxFDNDm9dV2i1sjaQvED4jhMx3/8YFj6PcEX8U
 7EGlGstUFPLrdG1y1YdwAVdul1ffy9oF8oeUb6Pu4dxvCisTGH4kVgG3UM//4FPKbOmW
 7NTZhvRZ/O6s223pRBWmzJw6aXVTFBoDvp5752BOIRZEkYGBXIQc/TlE4NPny9LdAyJP
 YJukHPVHg0vn+y8S3lX4+9pd+6WfBIQHdAjiFHiZyzvZYYTg8vTvAHQ5JFSa79lxXUMq
 TFOM4JWZHccsWt9/LJe+Xwp9DsGjuX8GkCA9fWDmn4DfpEJdMMDMZrJPpJ+Dr2RvPqAJ
 5JpA==
X-Gm-Message-State: ABy/qLaVRWFvqAhc/kMW2xtonUBbRanujGbyGj7DCibyRDpf0C7wTHHl
 KAWSLpaNJnEhwww0NxAdclKQT/bRqGh1jxugyjMqRQ==
X-Google-Smtp-Source: APBJJlHC+4ZYQN0QFdD3opcruCRbFOqZZqitf7PaErkRp9N2FLFBlXY1a9Q5PPrrYQmBMgZNvq/EQQ==
X-Received: by 2002:a17:906:530e:b0:993:6845:89d6 with SMTP id
 h14-20020a170906530e00b00993684589d6mr380357ejo.47.1690581842130; 
 Fri, 28 Jul 2023 15:04:02 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com.
 [209.85.208.50]) by smtp.gmail.com with ESMTPSA id
 v5-20020a170906564500b00992e4d8cc89sm2518944ejr.57.2023.07.28.15.04.01
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 15:04:01 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-521e046f6c7so1655a12.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 15:04:01 -0700 (PDT)
X-Received: by 2002:a50:8ac1:0:b0:51a:1ffd:10e with SMTP id
 k1-20020a508ac1000000b0051a1ffd010emr12661edk.3.1690581841061; Fri, 28 Jul
 2023 15:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com>
 <CAAfnVBnrUotph4TYJVu9Bohqv3m80t90V34TNhh-Tspxwsj-ZQ@mail.gmail.com>
 <CAF6AEGs4fuq4i8UJdO5hvgHTNhzFMKGZ87+w1oyvL0LAqWio6A@mail.gmail.com>
 <CAAfnVBkLhYVaSG3U_QUZwXLFv-XT=9F2v2pgrCDQQBgNZ3MSWA@mail.gmail.com>
 <a453d562-7e93-aef3-a533-171f572b6ee3@collabora.com>
 <CAAfnVBmwVTBNx4GC2hiYQ9Ya8ufP_D8N0-JOzT2iPV9BYZhD9w@mail.gmail.com>
 <CAF6AEGvWrUN9W9DKv45OT-MfYAS4D_bXa_Sb5ptgrMEf9WSSqA@mail.gmail.com>
 <4c18744d-b6cd-d517-5726-104017d0764b@collabora.com>
In-Reply-To: <4c18744d-b6cd-d517-5726-104017d0764b@collabora.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 28 Jul 2023 15:03:47 -0700
X-Gmail-Original-Message-ID: <CAAfnVB=qOjM1EQUyxdczu9KOGjD0sieoTODohbHz4ZDN0mqojw@mail.gmail.com>
Message-ID: <CAAfnVB=qOjM1EQUyxdczu9KOGjD0sieoTODohbHz4ZDN0mqojw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6067101255667732775=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============6067101255667732775==
Content-Type: multipart/alternative; boundary="0000000000001a90dd0601934260"

--0000000000001a90dd0601934260
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 11:58=E2=80=AFAM Dmitry Osipenko <
dmitry.osipenko@collabora.com> wrote:

> 27.06.2023 20:16, Rob Clark =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
> >> Now these are just suggestions, and while I think they are good, you
> can safely ignore them.
> >>
> >> But there's also the DRM requirements, which state "userspace side mus=
t
> be fully reviewed and tested to the standards of that user-space
> project.".  So I think to meet the minimum requirements, I think we shoul=
d
> at-least have one of the following (not all, just one) reviewed:
> >>
> >> 1) venus using the new uapi
> >> 2) gfxstream vk using the new uapi
> >> 3) amdgpu nctx out of "draft" mode and using the new uapi.
> >> 4) virtio-intel using new uapi
> >> 5) turnip using your new uapi
> >
> > forgot to mention this earlier, but
> > https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23533
> >
> > Dmitry, you can also add, if you haven't already:
> >
> > Tested-by: Rob Clark <robdclark@gmail.com>
>
> Gurchetan, Turnip Mesa virtio support is ready to be merged upstream,
> it's using this new syncobj UAPI. Could you please give yours r-b if you
> don't have objections?
>

Given that Turnip native contexts are reviewed using this UAPI, your change
does now meet the requirements and is ready to merge.

One thing I noticed is you might need explicit padding between
`num_out_syncobjs` and `in_syncobjs`.  Otherwise, feel free to add my
acked-by.


>
> --
> Best regards,
> Dmitry
>
>

--0000000000001a90dd0601934260
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">=C2=A0</div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 19, 2023 at 11:58=E2=80=
=AFAM Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com" =
target=3D"_blank">dmitry.osipenko@collabora.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">27.06.2023 20:16, Rob Clark =
=D0=BF=D0=B8=D1=88=D0=B5=D1=82:<br>
...<br>
&gt;&gt; Now these are just suggestions, and while I think they are good, y=
ou can safely ignore them.<br>
&gt;&gt;<br>
&gt;&gt; But there&#39;s also the DRM requirements, which state &quot;users=
pace side must be fully reviewed and tested to the standards of that user-s=
pace project.&quot;.=C2=A0 So I think to meet the minimum requirements, I t=
hink we should at-least have one of the following (not all, just one) revie=
wed:<br>
&gt;&gt;<br>
&gt;&gt; 1) venus using the new uapi<br>
&gt;&gt; 2) gfxstream vk using the new uapi<br>
&gt;&gt; 3) amdgpu nctx out of &quot;draft&quot; mode and using the new uap=
i.<br>
&gt;&gt; 4) virtio-intel using new uapi<br>
&gt;&gt; 5) turnip using your new uapi<br>
&gt; <br>
&gt; forgot to mention this earlier, but<br>
&gt; <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/2=
3533" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/m=
esa/mesa/-/merge_requests/23533</a><br>
&gt; <br>
&gt; Dmitry, you can also add, if you haven&#39;t already:<br>
&gt; <br>
&gt; Tested-by: Rob Clark &lt;<a href=3D"mailto:robdclark@gmail.com" target=
=3D"_blank">robdclark@gmail.com</a>&gt;<br>
<br>
Gurchetan, Turnip Mesa virtio support is ready to be merged upstream,<br>
it&#39;s using this new syncobj UAPI. Could you please give yours r-b if yo=
u<br>
don&#39;t have objections?<br></blockquote><div><br></div><div>Given that T=
urnip native contexts are reviewed using this UAPI, your change does now me=
et the requirements and is ready to merge.=C2=A0=C2=A0</div><div><br></div>=
<div>One thing I noticed is you might need explicit padding between `num_ou=
t_syncobjs` and `in_syncobjs`.=C2=A0 Otherwise, feel free to add my acked-b=
y.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
Best regards,<br>
Dmitry<br>
<br>
</blockquote></div></div>

--0000000000001a90dd0601934260--

--===============6067101255667732775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6067101255667732775==--
