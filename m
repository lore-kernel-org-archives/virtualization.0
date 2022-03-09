Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99FCC433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 01:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E02B40AB9;
	Wed,  9 Mar 2022 01:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uum_kvfLRyLa; Wed,  9 Mar 2022 01:11:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 893534014E;
	Wed,  9 Mar 2022 01:11:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E582C0012;
	Wed,  9 Mar 2022 01:11:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 969CAC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 01:11:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D5108427D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 01:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PGJkx2FV6Npx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 01:11:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 452A884279
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 01:11:51 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id r10so722949wrp.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jpY2z4H34H3eyBeRRD+CGY7silW4WSqrGPqcmBECpU8=;
 b=OQR6wnO5d5c3LTMBJooNcShzMDnrZE0ChK/EkciE7eBjvAp9AaNTh8JGyr9hqlIe8o
 /uLpYB3Sz5zoaFGYFpt6ebZD8vcNRigI2VhxHWkHBGHeMI5X4yVN+av7yUE0A4dksIjT
 fz6/CovaYl8F+Gl4PS4wx725aQ2QwTOGvwK8bvceboZj1VlrJ6pLLMF2GFGLzX9QXTKt
 xCSafwiMNAidJBvjoxUwKtaQPB2Qs3FRt0A5UoEpCYNk8OZNYo29CazknewuE2JjVElV
 7cesBfsDlrU3roEDItdYH7xJ10SRqQ/6EvLmITBvheW5vavY0ObFtOFW2WTbvIZhGwT0
 tfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jpY2z4H34H3eyBeRRD+CGY7silW4WSqrGPqcmBECpU8=;
 b=sTqC1M2iJBoogkryeDoVYbwpdeUoU+FKJBpW5LUNdqb2VE43wm3qdp5koc8PxuLwAe
 Vl5BXP6fipkG3ul43RUk2cIdHtMkPuW4BRBkuUZ4LKdocPg0+1+8btWp3w1tZRMr4aYH
 +SA4vCn52F4QvYBwyjMMU56xnmBv5EH5znVLHI8UZ30/TympB4fAY4Y86HFeg7mS5Z63
 Lz4LJgcZD8xpv1HVOXK6Ykh1YlwtdnaUAv6QFGgqMUzAvr8+7XjWAvnjf16bOdEkXxJY
 FiXkbQ42vQQNFqRFswhLAm6HHvBHKJoHa8T/frrpF2qkZG3Mrd61yeIHuhfNnlBAlLhb
 mL5g==
X-Gm-Message-State: AOAM532gP0awsQi4dC+rU91/wtvYD1rzde/V2cQnN8YfAQ7J04LtSRen
 c2mOiheHYQimKxuVJR+CQTN5lzx39rv1JRQDWuo=
X-Google-Smtp-Source: ABdhPJxzYEf+xhzYvzLMbZ4CzUdlFlyPdwT3Ou9S7TZYGaRoHbCq8sPvHqx4BSkcicG04BJi2Bnpw9/xcgw7LbDC4hs=
X-Received: by 2002:a5d:6344:0:b0:1f0:21ee:9705 with SMTP id
 b4-20020a5d6344000000b001f021ee9705mr13967971wrw.93.1646788309356; Tue, 08
 Mar 2022 17:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <20220308131725.60607-6-dmitry.osipenko@collabora.com>
In-Reply-To: <20220308131725.60607-6-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 8 Mar 2022 17:12:18 -0800
Message-ID: <CAF6AEGvVmV4fesd0MsSo-4WxSVqOFN-U+p5HOE2job6CeYbqTA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] drm/virtio: Add memory shrinker
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gert Wollny <gert.wollny@collabora.com>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dmitry Osipenko <digetx@gmail.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Mar 8, 2022 at 5:17 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Add memory shrinker and new madvise IOCTL to the VirtIO-GPU driver.
> Userspace (BO cache manager of Mesa driver) will mark BOs as "don't need"
> using the new IOCTL to let shrinker purge the marked BOs on OOM, thus
> shrinker will lower memory pressure and prevent OOM kills.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/Makefile               |   3 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.h          |  26 +++-
>  drivers/gpu/drm/virtio/virtgpu_gem.c          |  84 ++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c | 124 ++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c        |  37 ++++++
>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  10 ++
>  drivers/gpu/drm/virtio/virtgpu_object.c       |   7 +
>  drivers/gpu/drm/virtio/virtgpu_plane.c        |  17 ++-
>  drivers/gpu/drm/virtio/virtgpu_vq.c           |  15 +++
>  include/uapi/drm/virtgpu_drm.h                |  14 ++
>  10 files changed, 333 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c
>

[snip]

> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c b/drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c
> new file mode 100644
> index 000000000000..39eb9a3e7e4a
> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Collabora Ltd.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/shmem_fs.h>
> +
> +#include "virtgpu_drv.h"
> +
> +static unsigned long
> +virtio_gpu_gem_shrinker_count_objects(struct shrinker *shrinker,
> +                                     struct shrink_control *sc)
> +{
> +       struct drm_gem_shmem_object *shmem;
> +       struct virtio_gpu_device *vgdev;
> +       unsigned long count = 0;
> +       bool empty = true;
> +
> +       vgdev = container_of(shrinker, struct virtio_gpu_device,
> +                            vgshrinker.shrinker);
> +
> +       if (!mutex_trylock(&vgdev->mm_lock))
> +               return 0;

One bit of advice from previously dealing with shrinker and heavy
memory pressure situations (turns out 4GB chromebooks can be pretty
much under *constant* memory pressure):

You *really* want to make shrinker->count_objects lockless.. and
minimize the lock contention on shrinker->scan_objects (ie.  The
problem is you can end up with shrinking going on on all CPU cores in
parallel, you want to not funnel that thru one lock as much as
possible.

See in particular:

25ed38b3ed26 ("drm/msm: Drop mm_lock in scan loop")
cc8a4d5a1bd8 ("drm/msm: Avoid mutex in shrinker_count()")

BR,
-R

> +       list_for_each_entry(shmem, &vgdev->vgshrinker.list, madv_list) {
> +               empty = false;
> +
> +               if (!mutex_trylock(&shmem->pages_lock))
> +                       continue;
> +
> +               if (drm_gem_shmem_is_purgeable(shmem))
> +                       count += shmem->base.size >> PAGE_SHIFT;
> +
> +               mutex_unlock(&shmem->pages_lock);
> +       }
> +
> +       mutex_unlock(&vgdev->mm_lock);
> +
> +       return empty ? SHRINK_EMPTY : count;
> +}
> +
> +static bool virtio_gpu_gem_shrinker_purge(struct virtio_gpu_device *vgdev,
> +                                         struct drm_gem_object *obj)
> +{
> +       struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> +       struct drm_gem_shmem_object *shmem = &bo->base;
> +       int err;
> +
> +       if (!dma_resv_test_signaled(obj->resv, true) ||
> +           !drm_gem_shmem_is_purgeable(shmem) ||
> +           refcount_read(&bo->pin_count))
> +               return false;
> +
> +       /*
> +        * Release host's memory before guest's memory is gone to ensure that
> +        * host won't touch released memory of the guest.
> +        */
> +       err = virtio_gpu_gem_host_mem_release(bo);
> +       if (err)
> +               return false;
> +
> +       list_del_init(&shmem->madv_list);
> +       drm_gem_shmem_purge_locked(shmem);
> +
> +       return true;
> +}
> +
> +static unsigned long
> +virtio_gpu_gem_shrinker_scan_objects(struct shrinker *shrinker,
> +                                    struct shrink_control *sc)
> +{
> +       struct drm_gem_shmem_object *shmem, *tmp;
> +       struct virtio_gpu_device *vgdev;
> +       unsigned long freed = 0;
> +
> +       vgdev = container_of(shrinker, struct virtio_gpu_device,
> +                            vgshrinker.shrinker);
> +
> +       if (!mutex_trylock(&vgdev->mm_lock))
> +               return SHRINK_STOP;
> +
> +       list_for_each_entry_safe(shmem, tmp, &vgdev->vgshrinker.list, madv_list) {
> +               if (freed >= sc->nr_to_scan)
> +                       break;
> +
> +               if (!dma_resv_trylock(shmem->base.resv))
> +                       continue;
> +
> +               if (!mutex_trylock(&shmem->pages_lock))
> +                       goto resv_unlock;
> +
> +               if (virtio_gpu_gem_shrinker_purge(vgdev, &shmem->base))
> +                       freed += shmem->base.size >> PAGE_SHIFT;
> +
> +               mutex_unlock(&shmem->pages_lock);
> +resv_unlock:
> +               dma_resv_unlock(shmem->base.resv);
> +       }
> +
> +       mutex_unlock(&vgdev->mm_lock);
> +
> +       return freed;
> +}
> +
> +int virtio_gpu_gem_shrinker_init(struct virtio_gpu_device *vgdev)
> +{
> +       struct shrinker *shrinker = &vgdev->vgshrinker.shrinker;
> +
> +       shrinker->count_objects = virtio_gpu_gem_shrinker_count_objects;
> +       shrinker->scan_objects = virtio_gpu_gem_shrinker_scan_objects;
> +       shrinker->seeks = DEFAULT_SEEKS;
> +
> +       INIT_LIST_HEAD(&vgdev->vgshrinker.list);
> +
> +       return register_shrinker(shrinker);
> +}
> +
> +void virtio_gpu_gem_shrinker_fini(struct virtio_gpu_device *vgdev)
> +{
> +       struct shrinker *shrinker = &vgdev->vgshrinker.shrinker;
> +
> +       unregister_shrinker(shrinker);
> +}
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
