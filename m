Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BE3C433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 01:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9677C401C9;
	Wed, 16 Feb 2022 01:33:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JLRgihskrgZk; Wed, 16 Feb 2022 01:33:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B23424056A;
	Wed, 16 Feb 2022 01:33:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C955C0011;
	Wed, 16 Feb 2022 01:33:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66C60C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42BA982CDD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:32:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SdfI88OX1lx2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:32:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F8DD8316F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:32:58 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id qk11so1109959ejb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 17:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sp7BCWIo45dUgDZ6Yeet+HVNBAxj5eJOd+Cy1XLZ2f8=;
 b=h64up5gwC+DME3RYkAv/xtT38PBrUhx8RlwtNtdfjGy0qVK47DQH13pPuOpT/+hxjz
 mBcfxYbPOSBpvzdHAu4jXWaEhfLSWkMZsxFzOZr0qPVXJV3ZGJ+zUWdnMffzk7qAZUnQ
 2QkFS2k4xx7K5DF58Oi9W3pF93xHzjyDv9EuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sp7BCWIo45dUgDZ6Yeet+HVNBAxj5eJOd+Cy1XLZ2f8=;
 b=Y3mDMHH6DhPlm/j5QiO/XlqFugTLRopUHIXQz/3TJCbhkBc1zInxE5htokqi+4DLhD
 liMVpVMHwf043Bt3CMbYUHEx9IILWH7ER7dPY28tQ056Q5qZLaDdpCsWKvmFvO3xKShb
 uwpsmxFMpRKJKz/P2CDrkUa/XK7elsLDcNTD6p6e0gefDttnWrzPugw4yDKCzQZRfQO7
 tLbBue4+YjzWsKV21ymTvWVmgOKNh7I7Lp3rMpV7dlwbNf2xw/t87x3QrTxZOZSDsZ2P
 J8PMk40gFIimP+dAv3W9CYBSBTcJ5jFI37OnGx8VEUi3Bh6f+gUEl66sawFkMuBwDwHe
 HwGA==
X-Gm-Message-State: AOAM533J3z9QrEygukvmgCLoAWDEwEXDJG96e7CXZupX2dFTUMLvTHO7
 rAp8424S/oDNOI17WjUOcu09FXiCBqAbU8T6
X-Google-Smtp-Source: ABdhPJxXo62I449oDMejbpZzZGwPVS49pYEA4CQA6aB6atsjBtUIaODTxNeeJp6h5prnM4qIKiFSLw==
X-Received: by 2002:a17:906:1656:b0:6cf:571c:f91d with SMTP id
 n22-20020a170906165600b006cf571cf91dmr503579ejd.377.1644975175905; 
 Tue, 15 Feb 2022 17:32:55 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com.
 [209.85.221.53])
 by smtp.gmail.com with ESMTPSA id bv2sm12277993ejb.155.2022.02.15.17.32.53
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 17:32:55 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id w11so906907wra.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 17:32:53 -0800 (PST)
X-Received: by 2002:a5d:63c3:0:b0:1e3:240a:550f with SMTP id
 c3-20020a5d63c3000000b001e3240a550fmr466622wrw.402.1644975172490; Tue, 15 Feb
 2022 17:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20220216011614.360451-1-robdclark@gmail.com>
In-Reply-To: <20220216011614.360451-1-robdclark@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 15 Feb 2022 17:32:41 -0800
X-Gmail-Original-Message-ID: <CAAfnVB=8pQbRit50q3HaKU5Q+33uLLESh4=FAHje9gvZ+O8K1A@mail.gmail.com>
Message-ID: <CAAfnVB=8pQbRit50q3HaKU5Q+33uLLESh4=FAHje9gvZ+O8K1A@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Fix capset-id query size
To: Rob Clark <robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, David Airlie <airlied@linux.ie>,
 open list <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Lingfeng Yang <lfy@google.com>,
 Chia-I Wu <olvaffe@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4730457611077778936=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4730457611077778936==
Content-Type: multipart/alternative; boundary="000000000000d2b80a05d818a023"

--000000000000d2b80a05d818a023
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 15, 2022 at 5:15 PM Rob Clark <robdclark@gmail.com> wrote:

> From: Rob Clark <robdclark@chromium.org>
>
> The UABI was already defined for pointer to 64b value, and all the
> userspace users of this ioctl that I could find are already using a
> uint64_t (but zeroing it out to work around kernel only copying 32b).
> Unfortunately this ioctl doesn't have a length field, so out of paranoia
> I restricted the change to copy 64b to the single 64b param that can be
> queried.
>
> Fixes: 78aa20fa4381 ("drm/virtio: implement context init: advertise
> feature to userspace")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
>

Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>


> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 0f2f3f54dbf9..0158d27d5645 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -269,7 +269,8 @@ static int virtio_gpu_getparam_ioctl(struct drm_device
> *dev, void *data,
>  {
>         struct virtio_gpu_device *vgdev = dev->dev_private;
>         struct drm_virtgpu_getparam *param = data;
> -       int value;
> +       int value, ret, sz = sizeof(int);
> +       uint64_t value64;
>
>         switch (param->param) {
>         case VIRTGPU_PARAM_3D_FEATURES:
> @@ -291,13 +292,20 @@ static int virtio_gpu_getparam_ioctl(struct
> drm_device *dev, void *data,
>                 value = vgdev->has_context_init ? 1 : 0;
>                 break;
>         case VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs:
> -               value = vgdev->capset_id_mask;
> +               value64 = vgdev->capset_id_mask;
> +               sz = sizeof(value64);
>                 break;
>         default:
>                 return -EINVAL;
>         }
> -       if (copy_to_user(u64_to_user_ptr(param->value), &value,
> sizeof(int)))
> -               return -EFAULT;
> +
> +       if (sz == sizeof(int)) {
> +               if (copy_to_user(u64_to_user_ptr(param->value), &value,
> sz))
> +                       return -EFAULT;
> +       } else {
> +               if (copy_to_user(u64_to_user_ptr(param->value), &value64,
> sz))
> +                       return -EFAULT;
> +       }
>
>         return 0;
>  }
> --
> 2.34.1
>
>

--000000000000d2b80a05d818a023
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 15, 2022 at 5:15 PM Rob C=
lark &lt;<a href=3D"mailto:robdclark@gmail.com">robdclark@gmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Ro=
b Clark &lt;<a href=3D"mailto:robdclark@chromium.org" target=3D"_blank">rob=
dclark@chromium.org</a>&gt;<br>
<br>
The UABI was already defined for pointer to 64b value, and all the<br>
userspace users of this ioctl that I could find are already using a<br>
uint64_t (but zeroing it out to work around kernel only copying 32b).<br>
Unfortunately this ioctl doesn&#39;t have a length field, so out of paranoi=
a<br>
I restricted the change to copy 64b to the single 64b param that can be<br>
queried.<br>
<br>
Fixes: 78aa20fa4381 (&quot;drm/virtio: implement context init: advertise fe=
ature to userspace&quot;)<br>
Signed-off-by: Rob Clark &lt;<a href=3D"mailto:robdclark@chromium.org" targ=
et=3D"_blank">robdclark@chromium.org</a>&gt;<br></blockquote><div><br></div=
><div><span class=3D"gmail-il">Reviewed</span>-<span class=3D"gmail-il">by<=
/span>:=C2=A0<span class=3D"gmail-il">Gurchetan</span>=C2=A0<span class=3D"=
gmail-il">Singh</span>=C2=A0&lt;<a href=3D"mailto:gurchetansingh@chromium.o=
rg" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0drivers/gpu/drm/virtio/virtgpu_ioctl.c | 16 ++++++++++++----<br>
=C2=A01 file changed, 12 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c<br>
index 0f2f3f54dbf9..0158d27d5645 100644<br>
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c<br>
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c<br>
@@ -269,7 +269,8 @@ static int virtio_gpu_getparam_ioctl(struct drm_device =
*dev, void *data,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_device *vgdev =3D dev-&gt;dev=
_private;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_virtgpu_getparam *param =3D data;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int value, ret, sz =3D sizeof(int);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t value64;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (param-&gt;param) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case VIRTGPU_PARAM_3D_FEATURES:<br>
@@ -291,13 +292,20 @@ static int virtio_gpu_getparam_ioctl(struct drm_devic=
e *dev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D vgdev-&gt=
;has_context_init ? 1 : 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D vgdev-&gt=
;capset_id_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value64 =3D vgdev-&=
gt;capset_id_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sz =3D sizeof(value=
64);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_to_user(u64_to_user_ptr(param-&gt;valu=
e), &amp;value, sizeof(int)))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFAULT;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (sz =3D=3D sizeof(int)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_to_user(u6=
4_to_user_ptr(param-&gt;value), &amp;value, sz))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_to_user(u6=
4_to_user_ptr(param-&gt;value), &amp;value64, sz))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000d2b80a05d818a023--

--===============4730457611077778936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4730457611077778936==--
