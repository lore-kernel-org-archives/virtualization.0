Return-Path: <SRS0=TOd4=GZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28AAC433E0
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 10:03:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0898235E4
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 10:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0898235E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5241E87352;
	Fri, 22 Jan 2021 10:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O--thvposYki; Fri, 22 Jan 2021 10:03:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 32BB187350;
	Fri, 22 Jan 2021 10:03:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0398C08A1;
	Fri, 22 Jan 2021 10:03:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A278C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 10:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3C09786E5A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 10:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lCsBkx7P0QC3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 10:03:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 783CD86CEF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 10:03:05 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id i63so3749906wma.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 02:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=pxR73uYax2G5yfjba411z30jS6rXBdckdXhkr2akbsA=;
 b=X5WwYFfsYNJfDQh92DGtNFimXbpUN+GxqfLE1NYzEe3/wu5PgFoLIvm7+ki/7buNkl
 kZ7RdFYAlQPqXf/58zvq7XnDgQ1lbSBY6MD18BNTiXhDewgngp7ByIGO1awg/WVpMYos
 IfC9x4aac9zTPv6TJxwkXPhaYSyoZUf4qrM0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=pxR73uYax2G5yfjba411z30jS6rXBdckdXhkr2akbsA=;
 b=NP9OkN7q4yQ0M++4kU3ZYjny3yQ2hR+murlgfdfc4ZBc2SnHEowUGPm/3OKGtTyRBP
 KcYJOwu8I20QFK9kNC4JIbV1naS/klNQIY8HhgXvzAjH1DYabnnJaQBNimi8xsNymiAb
 PSO/xusXnudtiUI4yN0u4FA1tfUhYJnS5arntI4FEzSABmVC80+liDEFncSb0nMe/WjR
 OCGC2Arq64U1FKJBVRRAmrC1d3bhQYKzzFUcAYyoxzobO7Vdeo+84KlycD3njTUFL2/e
 TwAG7IItpKNZY7slIW5iBtC8b4KveYKcWX4GHq36Sc+znOCk3XwWVl4Q23bW9SnmaCjy
 T/AA==
X-Gm-Message-State: AOAM532RWZ7WEk8XyX1ooTaTwz9dvpTXPa07SoY1fuRV4ebLiag+ixk7
 muzSn7AZHuqzC+ZboBvA9oCaxg==
X-Google-Smtp-Source: ABdhPJwktUuERnfSCATLUZYNfXmNl/x8CSvfB/VjEK+Oyk/w1j74oeLsbOorMsQA09eB6833W+nOvQ==
X-Received: by 2002:a05:600c:215:: with SMTP id
 21mr3149956wmi.54.1611309783694; 
 Fri, 22 Jan 2021 02:03:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id o14sm10491607wmc.28.2021.01.22.02.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 02:03:03 -0800 (PST)
Date: Fri, 22 Jan 2021 11:03:01 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Yiwei Zhang <zzyiwei@android.com>
Subject: Re: [PATCH v4] drm/virtio: Track total GPU memory for virtio driver
Message-ID: <YAqi1fKM8Vy8ocay@phenom.ffwll.local>
Mail-Followup-To: Yiwei Zhang <zzyiwei@android.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kernel-team <kernel-team@android.com>
References: <20210122053159.1720274-1-zzyiwei@android.com>
 <20210122054011.1722954-1-zzyiwei@android.com>
 <CAKB3++bLzn5YVaR3iUTHtNYwBeG6Z27NjtWZ1q-xmjOkApAQwg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKB3++bLzn5YVaR3iUTHtNYwBeG6Z27NjtWZ1q-xmjOkApAQwg@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET..." <virtualization@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, kernel-team <kernel-team@android.com>
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

On Thu, Jan 21, 2021 at 11:58:22PM -0800, Yiwei Zhang wrote:
> On Thu, Jan 21, 2021 at 9:40 PM Yiwei Zhang <zzyiwei@android.com> wrote:
> >
> > On the success of virtio_gpu_object_create, add size of newly allocated
> > bo to the tracked total_mem. In drm_gem_object_funcs.free, after the gem
> > bo loses its last refcount, subtract the bo size from the tracked
> > total_mem if the original underlying memory allocation is successful.
> >
> > It's more accurate to do this in device driver layer to best match when
> > the underlying resource gets allocated and destroyed during tracing.
> >
> > Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
> > ---
> >  drivers/gpu/drm/virtio/Kconfig          |  1 +
> >  drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 ++
> >  drivers/gpu/drm/virtio/virtgpu_object.c | 11 +++++++++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
> > index b925b8b1da16..e103b7e883b1 100644
> > --- a/drivers/gpu/drm/virtio/Kconfig
> > +++ b/drivers/gpu/drm/virtio/Kconfig
> > @@ -5,6 +5,7 @@ config DRM_VIRTIO_GPU
> >         select DRM_KMS_HELPER
> >         select DRM_GEM_SHMEM_HELPER
> >         select VIRTIO_DMA_SHARED_BUFFER
> > +       select TRACE_GPU_MEM
> >         help
> >            This is the virtual GPU driver for virtio.  It can be used with
> >            QEMU based VMMs (like KVM or Xen).
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > index 6a232553c99b..c5622f9b591f 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > @@ -249,6 +249,8 @@ struct virtio_gpu_device {
> >         spinlock_t resource_export_lock;
> >         /* protects map state and host_visible_mm */
> >         spinlock_t host_visible_lock;
> > +
> > +       atomic64_t total_mem;
> >  };
> >
> >  struct virtio_gpu_fpriv {
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> > index d69a5b6da553..e2251fc41509 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> > @@ -25,12 +25,21 @@
> >
> >  #include <linux/dma-mapping.h>
> >  #include <linux/moduleparam.h>
> > +#include <trace/events/gpu_mem.h>
> >
> >  #include "virtgpu_drv.h"
> >
> >  static int virtio_gpu_virglrenderer_workaround = 1;
> >  module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
> >
> > +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
> > +                                             s64 delta)
> > +{
> > +       u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
> > +
> > +       trace_gpu_mem_total(vgdev->ddev->primary->index, 0, total_mem);
> > +}
> > +
> >  int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, uint32_t *resid)
> >  {
> >         if (virtio_gpu_virglrenderer_workaround) {
> > @@ -104,6 +113,7 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
> >         struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
> >
> >         if (bo->created) {
> > +               virtio_gpu_trace_total_mem(vgdev, -(obj->size));
> >                 virtio_gpu_cmd_unref_resource(vgdev, bo);
> >                 virtio_gpu_notify(vgdev);
> >                 /* completion handler calls virtio_gpu_cleanup_object() */
> > @@ -265,6 +275,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
> >                 virtio_gpu_object_attach(vgdev, bo, ents, nents);
> >         }
> >
> > +       virtio_gpu_trace_total_mem(vgdev, shmem_obj->base.size);
> >         *bo_ptr = bo;
> >         return 0;
> >
> > --
> > 2.30.0.280.ga3ce27912f-goog
> >
> 
> Re Gerd and Daniel:
> 
> I'm not sure why we want to couple this patch too much with the
> dma-bufs tracking. The tracepoint added here itself is pretty useful
> for tracking gem bo total usage in virtio gpu upon tracing. The
> original purpose for integrating this tracepoint in all Android gpu
> kernel drivers is to just track total gpu memory usage and serve the
> accurate data to game developers in a much easier way. It's something
> they can rely on for robust testing and regression monitoring.
> 
> The only overlap with the dma-buf side is when we export a bo via
> prime to a dma-buf. But still, the total here is already useful for
> this particular device. Using which approach to account for the
> overlap wouldn't block this small integration from my understanding.
> 
> Besides, there's no plan for adding per-process gem total tracking in
> virtio-gpu at this moment. This patch should be light enough to carry
> without worrying about tech debt I believe.

The tracepoint is clearly more generic than just what you implement here,
to support the full use cases on Android's closed stacks. And it is uapi.

Tech debt isn't measured in lines of code, but in how expensive it's going
to be to fix up the mess in the future. uapi is expensive no matter how
few lines are used to implement it.

So yeah this needs to be properly thought out, properly implemented (not
just on the virtual demo stack but something that looks like actual
production stack), with open drivers, proper alignment with other efforts
like tracking memory with cgroups, and the interactions with dma-buf
tracking resolved, and igt testcases (this is meant to be generic after
all), and at least solid proposals for rolling this out across the drm
drivers, and ...

In other words, new uapi needs to be done right.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
