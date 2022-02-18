Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4657C433EF
	for <virtualization@archiver.kernel.org>; Fri, 18 Feb 2022 16:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DA9A84C8B;
	Fri, 18 Feb 2022 16:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4FdueXeLWLZB; Fri, 18 Feb 2022 16:42:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E901284C84;
	Fri, 18 Feb 2022 16:42:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9610DC0021;
	Fri, 18 Feb 2022 16:42:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E73CC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 16:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9DC9403A5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 16:42:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QUON7SQ0e_da
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 16:42:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F067340192
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 16:42:35 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id a23so16360779eju.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2NJFZ3jit1chzQSDay79B6keWsZIR8EarnNGHw6lS5A=;
 b=DHRCvWEUqlZ11SBmiaPTfaEu3Yo1jAIFR55Bv9awW3zHDU8MgB38YYiwE3k1tsP9IM
 HqYXGe1BdnOx8rUHDoZonAC2XarFEFOq4v+c/5lTITz2d4w2dSyXrCk5BKXI1rrD4q1n
 C1tJUzze9zYJQJ54SlFmxZLOcTT0mjNLdJf6M5Z5XvN2S2K5JzW10lrPTXbUXrHFtW/b
 fhxgg8Rmc1ejll3eRtaCBFAqDw0UlRROVgZCHtBBBIsmpUcv4R2LGPHHHx6+Gludoddw
 wJtnSnScemddJo4gD/IItWmvriTj2IS1Kd/r+/FfGDLltEmVRoPQLSdlJvU6O+KX+WQQ
 Iyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2NJFZ3jit1chzQSDay79B6keWsZIR8EarnNGHw6lS5A=;
 b=S0e4Bs00MhZJC7FzCjuj5EPpRVF6StARhA2khoeowIopzvw2w4B1l7FPmAQ3qpsQ/j
 0i5IP1COYF9DU51sBlFnOUsTl6KzXrkdpvcJ266LZovlR3xLAaj9RRaNDfJIhED03b4h
 8U+CE73LkbLWZxd357NkzV7B+c8Nl+YhJ6pdmOS2X08qJg/BXod5qokYNUREKHWZbJzh
 J/xalzUDgj7zk9Fuv3rpnhqMKA3xP/wKtXgjgyo096GbZfCsVSX6i3nDwu1uuTjtJFTB
 kcnevrNBMKo1+PtOL4QNECZ2N1i6LAsAYdUlqQtrooCZq02z3ylkX+XSyDK2iCEvBdBT
 5dGg==
X-Gm-Message-State: AOAM5310tNPssQx8abSdNSPX7bi3kZ+aUWY6IfgJO+C70fiEHQPpZaeL
 EUrQOKWOD2Vz0kRtjgQl1R2q+Zbfk05niL+W+wY=
X-Google-Smtp-Source: ABdhPJxMYiQ2RRshnCbmjcn6dcHzICLifg4wwcX0owuwZ4uHR6ntkXXhuxL+HAeJ/wF4RPQrvng6ji7o3qRH97h+mxk=
X-Received: by 2002:a17:906:350d:b0:6b9:5871:8f34 with SMTP id
 r13-20020a170906350d00b006b958718f34mr7050936eja.493.1645202553886; Fri, 18
 Feb 2022 08:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20220218155725.487785-1-robdclark@gmail.com>
In-Reply-To: <20220218155725.487785-1-robdclark@gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 18 Feb 2022 08:42:22 -0800
Message-ID: <CAPaKu7R+6g9XRzWPk-u0jKWa602z6CJVxhPqgjJPipzY=S-txA@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Add USE_INTERNAL blob flag
To: Rob Clark <robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, David Airlie <airlied@linux.ie>,
 open list <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Feb 18, 2022 at 7:57 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> With native userspace drivers in guest, a lot of GEM objects need to be
> neither shared nor mappable.  And in fact making everything mappable
> and/or sharable results in unreasonably high fd usage in host VMM.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> This is for a thing I'm working on, a new virtgpu context type that
> allows for running native userspace driver in the guest, with a
> thin shim in the host VMM.  In this case, the guest has a lot of
> GEM buffer objects which need to be neither shared nor mappable.
>
> Alternative idea is to just drop the restriction that blob_flags
> be non-zero.  I'm ok with either approach.
Dropping the restriction sounds better to me.

What is the use case for such a resource?  Does the host need to know
such a resource exists?

>
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 7 ++++++-
>  include/uapi/drm/virtgpu_drm.h         | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 69f1952f3144..92e1ba6b8078 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -36,7 +36,8 @@
>
>  #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
>                                     VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
> -                                   VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
> +                                   VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
> +                                   VIRTGPU_BLOB_FLAG_USE_INTERNAL)
>
>  static int virtio_gpu_fence_event_create(struct drm_device *dev,
>                                          struct drm_file *file,
> @@ -662,6 +663,10 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>         params->size = rc_blob->size;
>         params->blob = true;
>         params->blob_flags = rc_blob->blob_flags;
> +
> +       /* USE_INTERNAL is local to guest kernel, don't past to host: */
> +       params->blob_flags &= ~VIRTGPU_BLOB_FLAG_USE_INTERNAL;
> +
>         return 0;
>  }
>
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 0512fde5e697..62b7483e5c60 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -163,6 +163,7 @@ struct drm_virtgpu_resource_create_blob {
>  #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>  #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>  #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> +#define VIRTGPU_BLOB_FLAG_USE_INTERNAL     0x0008   /* not-mappable, not-shareable */
>         /* zero is invalid blob_mem */
>         __u32 blob_mem;
>         __u32 blob_flags;
> --
> 2.34.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
