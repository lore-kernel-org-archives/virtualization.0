Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31783C433DB
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 07:04:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E21A2312D
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 07:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E21A2312D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5014827422;
	Tue, 19 Jan 2021 07:04:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eFh92B9XKIMd; Tue, 19 Jan 2021 07:03:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A0081204FE;
	Tue, 19 Jan 2021 07:03:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 823CCC08A1;
	Tue, 19 Jan 2021 07:03:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D51AC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 07:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 22977870BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 07:03:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X4Pl9b46FESq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 07:03:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 488A3870BD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 07:03:56 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id s2so20206768oij.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 23:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EJfr3/AKEq2QADngtAYKe4AoRRhjmaDaH7m9gP7iKZk=;
 b=QTuZQk1jhavaArScLuX825QGN1+4u8iMeAhAGEf2hdFQElT6hBH3OAqp4GWM414T3x
 OhPOEAy1Kz4ZpI9WwoduNX7BOyU8O0lkt1T0VPwCR4IHdm7ulmCEgVs3HjF7Kuo9bVPU
 5zKNsh/v5pHUSHc8+qbV8FUIcMLMob2pq56xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EJfr3/AKEq2QADngtAYKe4AoRRhjmaDaH7m9gP7iKZk=;
 b=PeGunXTwZT0ST3selb+CqdsEyAalw+VDUoAJ/szyVIo92kub31BVcZSWOaENvwA4E3
 V6ZSF2YNNpX4nCznfO+ZX8yxoY6aKKqGpgfJO7zC7O6rIJuSBZ9KgoCRpd0lvKJqPrfk
 Mr/uQn7KpVA42vcfeYA1VkI8OH6hcYTO2y5dMpt/GxH2jbDkxBsvKOLHJq8l9DG+Iscw
 1S1l9I4MzrzwuvdVWDaBG+nluWboAhBYc1AZFc94seXFXXV60BEGRLQJnNtfmVak8QIk
 +l+RO08n3u9yEXXMKOmhCtnBzrZoXMmW+t9xUcVACV67foSY2p0/69Der9reUaXKp7VA
 bO0w==
X-Gm-Message-State: AOAM533GZMsXm81KvgXpd6qhfBNYhb3IKVGbgi0hQ+V+l+fR6fzq+vkt
 sPcrX2/M8/UU7yrWsPW1XIhTOSvxDEIWR0t01J9kng==
X-Google-Smtp-Source: ABdhPJwzWPH2WmifDkmYPSJv8qrdqWCijQwai9Z73gYetT9ZosaVToylZDsq4xxrQohrbu5edGpgeFpegU9SJ40pzxU=
X-Received: by 2002:aca:ad92:: with SMTP id w140mr1708049oie.128.1611039835927; 
 Mon, 18 Jan 2021 23:03:55 -0800 (PST)
MIME-Version: 1.0
References: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
 <20210118234057.270930-1-zzyiwei@android.com>
In-Reply-To: <20210118234057.270930-1-zzyiwei@android.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 19 Jan 2021 08:03:44 +0100
Message-ID: <CAKMK7uE+7S5q8bU0ibyepb8yQL3QYNjZE+Jwf13+bVfAmoSuhw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Track total GPU memory for virtio driver
To: Yiwei Zhang <zzyiwei@android.com>
Cc: David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET..." <virtualization@lists.linux-foundation.org>,
 Android Kernel Team <kernel-team@android.com>
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

On Tue, Jan 19, 2021 at 12:41 AM Yiwei Zhang <zzyiwei@android.com> wrote:
>
> On the success of virtio_gpu_object_create, add size of newly allocated
> bo to the tracled total_mem. In drm_gem_object_funcs.free, after the gem
> bo lost its last refcount, subtract the bo size from the tracked
> total_mem if the original underlying memory allocation is successful.
>
> Signed-off-by: Yiwei Zhang <zzyiwei@android.com>

Isn't this something that ideally we'd for everyone? Also tracepoint
for showing the total feels like tracepoint abuse, usually we show
totals somewhere in debugfs or similar, and tracepoint just for what's
happening (i.e. which object got deleted/created).

What is this for exactly?
-Daniel

> ---
>  drivers/gpu/drm/virtio/Kconfig          |  1 +
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  4 ++++
>  drivers/gpu/drm/virtio/virtgpu_object.c | 19 +++++++++++++++++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
> index b925b8b1da16..e103b7e883b1 100644
> --- a/drivers/gpu/drm/virtio/Kconfig
> +++ b/drivers/gpu/drm/virtio/Kconfig
> @@ -5,6 +5,7 @@ config DRM_VIRTIO_GPU
>         select DRM_KMS_HELPER
>         select DRM_GEM_SHMEM_HELPER
>         select VIRTIO_DMA_SHARED_BUFFER
> +       select TRACE_GPU_MEM
>         help
>            This is the virtual GPU driver for virtio.  It can be used with
>            QEMU based VMMs (like KVM or Xen).
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 6a232553c99b..7c60e7486bc4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -249,6 +249,10 @@ struct virtio_gpu_device {
>         spinlock_t resource_export_lock;
>         /* protects map state and host_visible_mm */
>         spinlock_t host_visible_lock;
> +
> +#ifdef CONFIG_TRACE_GPU_MEM
> +       atomic64_t total_mem;
> +#endif
>  };
>
>  struct virtio_gpu_fpriv {
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index d69a5b6da553..1e16226cebbe 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -25,12 +25,29 @@
>
>  #include <linux/dma-mapping.h>
>  #include <linux/moduleparam.h>
> +#ifdef CONFIG_TRACE_GPU_MEM
> +#include <trace/events/gpu_mem.h>
> +#endif
>
>  #include "virtgpu_drv.h"
>
>  static int virtio_gpu_virglrenderer_workaround = 1;
>  module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
>
> +#ifdef CONFIG_TRACE_GPU_MEM
> +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
> +                                             s64 delta)
> +{
> +       u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
> +
> +       trace_gpu_mem_total(0, 0, total_mem);
> +}
> +#else
> +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *, s64)
> +{
> +}
> +#endif
> +
>  int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, uint32_t *resid)
>  {
>         if (virtio_gpu_virglrenderer_workaround) {
> @@ -104,6 +121,7 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
>         struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
>
>         if (bo->created) {
> +               virtio_gpu_trace_total_mem(vgdev, -(obj->size));
>                 virtio_gpu_cmd_unref_resource(vgdev, bo);
>                 virtio_gpu_notify(vgdev);
>                 /* completion handler calls virtio_gpu_cleanup_object() */
> @@ -265,6 +283,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>                 virtio_gpu_object_attach(vgdev, bo, ents, nents);
>         }
>
> +       virtio_gpu_trace_total_mem(vgdev, shmem_obj->base.size);
>         *bo_ptr = bo;
>         return 0;
>
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
