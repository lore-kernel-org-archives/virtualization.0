Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506A0C433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 23:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2C1981B17;
	Fri,  7 Jan 2022 23:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qO9fHRGTjkkp; Fri,  7 Jan 2022 23:34:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8B5CC81A6F;
	Fri,  7 Jan 2022 23:34:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 685CAC0030;
	Fri,  7 Jan 2022 23:34:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80087C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 23:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5988D607A1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 23:34:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e-kwQvqnTIBS
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 23:34:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3932860797
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 23:34:54 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id q25so19208713edb.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Jan 2022 15:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6RfbULMQmWmI8HuUvl95Pjwv+4zm3q8U8akXNuzZLEg=;
 b=RGMCxHiZetzlQvKF2rsRndOID7+6Rmk9zDeA5A0s7bkW3YTvMYXdRn2nn/bxkYFIcM
 QDyBuXLNTr2ri3J119Hpet5XmWpxnsAYs98RyVbsqaCsg0rOm502dHJscJ9grwtCLM0D
 Zfqbjcr/kXXb8rnKx5uX2qcVS+eEvmrjfBd9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6RfbULMQmWmI8HuUvl95Pjwv+4zm3q8U8akXNuzZLEg=;
 b=OOG/w1ARmNp4tnteY/0cojfGe8dkvOW2Szi4RDL1Zp34bYW4pouxchYVoCwX7NlAl6
 QCHFNPQS/ktGtr124xOh1m/mlvK+5/5Nxe1GnBgAyfsVuLEHYqt40F4z01Go9Jsx8+SO
 oOVAu7qiJAEctLWHsHBHiTHiwSpbBkgpUpzdKg953Cz9y8KrKeabxVylEApT6MHBpUyn
 77k8ityyg1etBICcBk/52JpgSEM6cedKeh4PzaORMhceEBKMxw2IwqpYVrkk9P8F8BNU
 ZA56G1JCX1K2sOECqmofwsyPDobR+YQYJqmgDn6gtbYKsdosZAxtb9DMlsFim9L/8Dy5
 pcDQ==
X-Gm-Message-State: AOAM531H+fmn47S69zt6jd5EuNhZgHnWL+mBq8RRJ+3seCBsPI0nqzKa
 owNC6NsWRewZ9MtKIOcbOFzAiir1ikn/BQ==
X-Google-Smtp-Source: ABdhPJz6/6HBVQnFnIwmZ+MAxe1RWjJ2Ji0jo9NOCNXWzndKMwVYa+RrzoX3DdHVH2KgMfx6SSiLKA==
X-Received: by 2002:a05:6402:11c9:: with SMTP id
 j9mr62758612edw.411.1641598491901; 
 Fri, 07 Jan 2022 15:34:51 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com.
 [209.85.221.42])
 by smtp.gmail.com with ESMTPSA id s3sm18273ejs.145.2022.01.07.15.34.51
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jan 2022 15:34:51 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id r9so12095383wrg.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Jan 2022 15:34:51 -0800 (PST)
X-Received: by 2002:a05:6000:1567:: with SMTP id
 7mr56873454wrz.513.1641598490665; 
 Fri, 07 Jan 2022 15:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20211222072649.18169-1-linmq006@gmail.com>
In-Reply-To: <20211222072649.18169-1-linmq006@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 7 Jan 2022 15:34:38 -0800
X-Gmail-Original-Message-ID: <CAAfnVBn-VFzjQ8A+mYJF9=O-NeSFRS+4j36bBPohBD5QBzLf4g@mail.gmail.com>
Message-ID: <CAAfnVBn-VFzjQ8A+mYJF9=O-NeSFRS+4j36bBPohBD5QBzLf4g@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Fix NULL vs IS_ERR checking in
 virtio_gpu_object_shmem_init
To: Miaoqian Lin <linmq006@gmail.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>
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
Content-Type: multipart/mixed; boundary="===============2328568357335527918=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2328568357335527918==
Content-Type: multipart/alternative; boundary="000000000000e70cda05d5066ed0"

--000000000000e70cda05d5066ed0
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 21, 2021 at 11:26 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> Since drm_prime_pages_to_sg() function return error pointers.
> The drm_gem_shmem_get_sg_table() function returns error pointers too.
> Using IS_ERR() to check the return value to fix this.
>
> Fixes: f651c8b05542("drm/virtio: factor out the sg_table from
> virtio_gpu_object")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>

Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>


> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c
> b/drivers/gpu/drm/virtio/virtgpu_object.c
> index f648b0e24447..8bb80289672c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -168,9 +168,9 @@ static int virtio_gpu_object_shmem_init(struct
> virtio_gpu_device *vgdev,
>          * since virtio_gpu doesn't support dma-buf import from other
> devices.
>          */
>         shmem->pages = drm_gem_shmem_get_sg_table(&bo->base.base);
> -       if (!shmem->pages) {
> +       if (IS_ERR(shmem->pages)) {
>                 drm_gem_shmem_unpin(&bo->base.base);
> -               return -EINVAL;
> +               return PTR_ERR(shmem->pages);
>         }
>
>         if (use_dma_api) {
> --
> 2.17.1
>
>

--000000000000e70cda05d5066ed0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 21, 2021 at 11:26 PM Miao=
qian Lin &lt;<a href=3D"mailto:linmq006@gmail.com">linmq006@gmail.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Since =
drm_prime_pages_to_sg() function return error pointers.<br>
The drm_gem_shmem_get_sg_table() function returns error pointers too.<br>
Using IS_ERR() to check the return value to fix this.<br>
<br>
Fixes: f651c8b05542(&quot;drm/virtio: factor out the sg_table from virtio_g=
pu_object&quot;)<br>
Signed-off-by: Miaoqian Lin &lt;<a href=3D"mailto:linmq006@gmail.com" targe=
t=3D"_blank">linmq006@gmail.com</a>&gt;<br></blockquote><div><br></div>Revi=
ewed-by: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.org"=
>gurchetansingh@chromium.org</a>&gt;<br><div>=C2=A0<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0drivers/gpu/drm/virtio/virtgpu_object.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virt=
io/virtgpu_object.c<br>
index f648b0e24447..8bb80289672c 100644<br>
--- a/drivers/gpu/drm/virtio/virtgpu_object.c<br>
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c<br>
@@ -168,9 +168,9 @@ static int virtio_gpu_object_shmem_init(struct virtio_g=
pu_device *vgdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* since virtio_gpu doesn&#39;t support dm=
a-buf import from other devices.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 shmem-&gt;pages =3D drm_gem_shmem_get_sg_table(=
&amp;bo-&gt;base.base);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!shmem-&gt;pages) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(shmem-&gt;pages)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_gem_shmem_unpin=
(&amp;bo-&gt;base.base);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(shme=
m-&gt;pages);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (use_dma_api) {<br>
-- <br>
2.17.1<br>
<br></blockquote><div><br></div><div>=C2=A0</div></div></div>

--000000000000e70cda05d5066ed0--

--===============2328568357335527918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2328568357335527918==--
