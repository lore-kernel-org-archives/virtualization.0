Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD84C54EAA
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 15:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73BF441D8F;
	Fri, 27 Jan 2023 15:44:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73BF441D8F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=kB3eWzbB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdWJ3ZvbQZ7A; Fri, 27 Jan 2023 15:44:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B011341D8E;
	Fri, 27 Jan 2023 15:44:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B011341D8E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74784C0033;
	Fri, 27 Jan 2023 15:44:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79CBBC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 15:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FE9B612AD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 15:44:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FE9B612AD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=kB3eWzbB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0UZ44qeaOt1b
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 15:44:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FFC96129D
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FFC96129D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 15:44:30 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1636eae256cso2639821fac.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 07:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L5WWz9fhXxpXg6EmN48bNkcnM7o/dG+N+CVzIWey7Ow=;
 b=kB3eWzbBuevretKVLNQIc6LnDaUJHg5dX47XzvPpviB+kLJMTkhi9hl2bFF0hxzGc3
 1bmSwTNoKR8A+Z6O5ncrKR7CxOx7fXA75d3uTgdaCsreaoy//RN8rK0DyYDVGqmY6LLt
 2y/4h4bK8kJRWJYGcCig26s7uh0mZE/pdqy0ewstsusrnvnbrfiBYZr8IMxGJEMdYHzc
 M8lj0oIw3aH87LgaDDhE600YKPSJuZ3DWbAOKOMnNgnxlvpgh3tA7/4TZlDV8iWk7HAB
 +x6U3xQnbA/mApF+QruzLba0Dk/H/cWlrGCJ3tWceCwlFNM/X6mKz9KmRccQb5RxqJQo
 i47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L5WWz9fhXxpXg6EmN48bNkcnM7o/dG+N+CVzIWey7Ow=;
 b=3M3DrADJ+gjDtcHi4xFjUPAedH4H3aTHRrlMEwVvXt1S2VyLP9Xf4M0poYfFtFudiI
 kpOGNoFv0Xz32cZ1u47XyDPowdJ4tHHTU3SxD3Wh1BCcXJxqS/pGUsQKbSBrMpC7l6ng
 zDCYErUI8d0GI8bcsSXfnxwQcS133cVKipaZ1akKyE9ul6/kb9kOgEjJ8amyAYaOmWHW
 7ULmX5kQy0moSye5f1dSXuBQDm7Ok3lMVHh842AE9nsb0au/Iq3HKxcM8zZOajD2hgqC
 jYcM50OzJFVVbh/wLg5aYRoBduaBxVmFYqnz0uxpgLbN35hO6qwJXciO/Bir7bs0KwhA
 Mieg==
X-Gm-Message-State: AFqh2koW9EfKZfo7cBV2xKUmF70BqOn78ykEcPKu4GkLfOuMPxBsBq4/
 e9Mc9kcg9SrjgCc7UJJnyFU0C604XCExE0plIhE=
X-Google-Smtp-Source: AMrXdXup/oiP7Q12YFafrFfdB69dMqfoWyegvyVl2UR664bFNRQnR7IiR+R5erW+114UUEr4FAe2K42dz+pOGsd06QE=
X-Received: by 2002:a05:6870:44d0:b0:15b:96b8:e2be with SMTP id
 t16-20020a05687044d000b0015b96b8e2bemr2505559oai.38.1674834269272; Fri, 27
 Jan 2023 07:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20230126225815.1518839-1-ryanneph@chromium.org>
In-Reply-To: <20230126225815.1518839-1-ryanneph@chromium.org>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 27 Jan 2023 07:44:17 -0800
Message-ID: <CAF6AEGtQ1nsHZtigJs4ABe=3ibqbWJgWXzfPjypBcQZ8vgZekg@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: exbuf->fence_fd unmodified on interrupted wait
To: Ryan Neph <ryanneph@chromium.org>
Cc: Rob Clark <robdclark@chromium.org>, Robert Foss <robert.foss@collabora.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jan 27, 2023 at 12:31 AM Ryan Neph <ryanneph@chromium.org> wrote:
>
> An interrupted dma_fence_wait() becomes an -ERESTARTSYS returned
> to userspace ioctl(DRM_IOCTL_VIRTGPU_EXECBUFFER) calls, prompting to
> retry the ioctl(), but the passed exbuf->fence_fd has been reset to -1,
> making the retry attempt fail at sync_file_get_fence().
>
> The uapi for DRM_IOCTL_VIRTGPU_EXECBUFFER is changed to retain the
> passed value for exbuf->fence_fd when returning ERESTARTSYS or EINTR.
>
> Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
> Signed-off-by: Ryan Neph <ryanneph@chromium.org>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 9 ++++++---
>  include/uapi/drm/virtgpu_drm.h         | 3 +++
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 9f4a90493aea..ffce4e2a409a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -132,6 +132,8 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         uint64_t fence_ctx;
>         uint32_t ring_idx;
>
> +       exbuf->fence_fd = -1;
> +
>         fence_ctx = vgdev->fence_drv.context;
>         ring_idx = 0;
>
> @@ -152,8 +154,6 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                 ring_idx = exbuf->ring_idx;
>         }
>
> -       exbuf->fence_fd = -1;
> -
>         virtio_gpu_create_context(dev, file);
>         if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
>                 struct dma_fence *in_fence;
> @@ -173,7 +173,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>
>                 dma_fence_put(in_fence);
>                 if (ret)
> -                       return ret;
> +                       goto out_err;
>         }
>
>         if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
> @@ -259,6 +259,9 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>
>         if (out_fence_fd >= 0)
>                 put_unused_fd(out_fence_fd);
> +out_err:
> +       if (ret == -EINTR || ret == -ERESTARTSYS)
> +               exbuf->fence_fd = in_fence_fd;
>
>         return ret;
>  }
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 0512fde5e697..ac8d1eed12ab 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -64,6 +64,9 @@ struct drm_virtgpu_map {
>         __u32 pad;
>  };
>
> +/* For ioctl() returning ERESTARTSYS or EINTR, fence_fd is unmodified.
> + * For all other errors it is set to -1.
> + */
>  struct drm_virtgpu_execbuffer {
>         __u32 flags;
>         __u32 size;
> --
> 2.39.1.456.gfc5497dd1b-goog
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
