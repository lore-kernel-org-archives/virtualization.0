Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2677EC433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 09:11:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6657D23131
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 09:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6657D23131
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EADE686FDB;
	Wed, 20 Jan 2021 09:11:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v4rcjNn+AmG2; Wed, 20 Jan 2021 09:11:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B983486F9E;
	Wed, 20 Jan 2021 09:11:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3C97C088B;
	Wed, 20 Jan 2021 09:11:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA690C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 09:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AB23B86847
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 09:11:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QPAnTnwHXEpf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 09:11:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1C278863A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 09:11:37 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 190so2152859wmz.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 01:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=jnHw/9ZfOUdDPDIVRz58fMDvzkElIsdRxNOVrSA30u0=;
 b=SGoQ9256qHzwYxJkdrl57cIN/rchQtnhGfDJQqGJl6DxiHNa08K0KF4sF3C0FAf2A7
 YLk9qmb/uL5XHhHwCi5Iajxw6DXC6CyegFsLorVcMW701MtboWCBTXBqCUNuBfIbJ9eE
 t3oQ+hDZvWjkNetM7HNtZSBdWv6X+pzHEvJwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=jnHw/9ZfOUdDPDIVRz58fMDvzkElIsdRxNOVrSA30u0=;
 b=gUnaQpEeo+syBuPkiHvYNVRgRaIPSLCg2ToS63FEriTaWAx9mklOK0xCybtm2iI/F0
 /CJ/p+bKTvY3n4vnC4ka0329e7HcIxRWJag4G0uutwib8dGZShWGu16zV9qe9HQD8yg2
 VguNKcTmZ1lBvcEyArLJIerfIUuzSMsFZ9sxSAqOyPGXy3qeeVetd6rXOWqRcbH0x6Pd
 lu+UYYTRbjYCMo17Oeg233O06Nh4To45H2cFx7GyrQ46b5iMrZdPYe1tOa9ZLoDDK83n
 0GDuhIAAD6i+PpvD/zzbfr0RtyhDM2gmDjfCVgynoFOhXz+0TydgDi3Pl4VxxYJjiQcN
 j1bA==
X-Gm-Message-State: AOAM531YUkqsDRZOOqtLQKS5g+gvSAHUNriX0O6inX2c1o7LtVledWmf
 C6gVXM+eEZ7YRlvHZMPHwl+mLw==
X-Google-Smtp-Source: ABdhPJzE7C10TNLXpBnvYdfGRuBE9aOqbzxwogIQA7eNkIY+mSb+2vFm6RbVRZNIKOZzXPQKUScUyQ==
X-Received: by 2002:a05:600c:258:: with SMTP id
 24mr3297878wmj.161.1611133895972; 
 Wed, 20 Jan 2021 01:11:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id b64sm2775341wmb.26.2021.01.20.01.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 01:11:34 -0800 (PST)
Date: Wed, 20 Jan 2021 10:11:33 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Yiwei Zhang <zzyiwei@android.com>
Subject: Re: [PATCH v2] drm/virtio: Track total GPU memory for virtio driver
Message-ID: <YAfzxS95Yy86qnBi@phenom.ffwll.local>
Mail-Followup-To: Yiwei Zhang <zzyiwei@android.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Android Kernel Team <kernel-team@android.com>
References: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
 <20210118234057.270930-1-zzyiwei@android.com>
 <CAKMK7uE+7S5q8bU0ibyepb8yQL3QYNjZE+Jwf13+bVfAmoSuhw@mail.gmail.com>
 <CAKB3++aNtrjzFoq4icMWSUvXw7bL69FRM+9t69firXHkiuTwDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKB3++aNtrjzFoq4icMWSUvXw7bL69FRM+9t69firXHkiuTwDQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET..." <virtualization@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Android Kernel Team <kernel-team@android.com>
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

On Tue, Jan 19, 2021 at 11:08:12AM -0800, Yiwei Zhang wrote:
> On Mon, Jan 18, 2021 at 11:03 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Tue, Jan 19, 2021 at 12:41 AM Yiwei Zhang <zzyiwei@android.com> wrote:
> > >
> > > On the success of virtio_gpu_object_create, add size of newly allocated
> > > bo to the tracled total_mem. In drm_gem_object_funcs.free, after the gem
> > > bo lost its last refcount, subtract the bo size from the tracked
> > > total_mem if the original underlying memory allocation is successful.
> > >
> > > Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
> >
> > Isn't this something that ideally we'd for everyone? Also tracepoint
> > for showing the total feels like tracepoint abuse, usually we show
> > totals somewhere in debugfs or similar, and tracepoint just for what's
> > happening (i.e. which object got deleted/created).
> >
> > What is this for exactly?
> > -Daniel
> >
> > > ---
> > >  drivers/gpu/drm/virtio/Kconfig          |  1 +
> > >  drivers/gpu/drm/virtio/virtgpu_drv.h    |  4 ++++
> > >  drivers/gpu/drm/virtio/virtgpu_object.c | 19 +++++++++++++++++++
> > >  3 files changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
> > > index b925b8b1da16..e103b7e883b1 100644
> > > --- a/drivers/gpu/drm/virtio/Kconfig
> > > +++ b/drivers/gpu/drm/virtio/Kconfig
> > > @@ -5,6 +5,7 @@ config DRM_VIRTIO_GPU
> > >         select DRM_KMS_HELPER
> > >         select DRM_GEM_SHMEM_HELPER
> > >         select VIRTIO_DMA_SHARED_BUFFER
> > > +       select TRACE_GPU_MEM
> > >         help
> > >            This is the virtual GPU driver for virtio.  It can be used with
> > >            QEMU based VMMs (like KVM or Xen).
> > > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > index 6a232553c99b..7c60e7486bc4 100644
> > > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > @@ -249,6 +249,10 @@ struct virtio_gpu_device {
> > >         spinlock_t resource_export_lock;
> > >         /* protects map state and host_visible_mm */
> > >         spinlock_t host_visible_lock;
> > > +
> > > +#ifdef CONFIG_TRACE_GPU_MEM
> > > +       atomic64_t total_mem;
> > > +#endif
> > >  };
> > >
> > >  struct virtio_gpu_fpriv {
> > > diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> > > index d69a5b6da553..1e16226cebbe 100644
> > > --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> > > @@ -25,12 +25,29 @@
> > >
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/moduleparam.h>
> > > +#ifdef CONFIG_TRACE_GPU_MEM
> > > +#include <trace/events/gpu_mem.h>
> > > +#endif
> > >
> > >  #include "virtgpu_drv.h"
> > >
> > >  static int virtio_gpu_virglrenderer_workaround = 1;
> > >  module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
> > >
> > > +#ifdef CONFIG_TRACE_GPU_MEM
> > > +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
> > > +                                             s64 delta)
> > > +{
> > > +       u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
> > > +
> > > +       trace_gpu_mem_total(0, 0, total_mem);
> > > +}
> > > +#else
> > > +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *, s64)
> > > +{
> > > +}
> > > +#endif
> > > +
> > >  int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, uint32_t *resid)
> > >  {
> > >         if (virtio_gpu_virglrenderer_workaround) {
> > > @@ -104,6 +121,7 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
> > >         struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
> > >
> > >         if (bo->created) {
> > > +               virtio_gpu_trace_total_mem(vgdev, -(obj->size));
> > >                 virtio_gpu_cmd_unref_resource(vgdev, bo);
> > >                 virtio_gpu_notify(vgdev);
> > >                 /* completion handler calls virtio_gpu_cleanup_object() */
> > > @@ -265,6 +283,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
> > >                 virtio_gpu_object_attach(vgdev, bo, ents, nents);
> > >         }
> > >
> > > +       virtio_gpu_trace_total_mem(vgdev, shmem_obj->base.size);
> > >         *bo_ptr = bo;
> > >         return 0;
> > >
> > > --
> > > 2.30.0.284.gd98b1dd5eaa7-goog
> > >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> Thanks for your reply! Android Cuttlefish virtual platform is using
> the virtio-gpu driver, and we currently are carrying this small patch
> at the downstream side. This is essential for us because:
> (1) Android has deprecated debugfs on production devices already
> (2) Android GPU drivers are not DRM based, and this won't change in a
> short term.
> 
> Android relies on this tracepoint + eBPF to make the GPU memory totals
> available at runtime on production devices, which has been enforced
> already. Not only game developers can have a reliable kernel total GPU
> memory to look at, but also Android leverages this to take GPU memory
> usage out from the system lost ram.
> 
> I'm not sure whether the other DRM drivers would like to integrate
> this tracepoint(maybe upstream drivers will move away from debugfs
> later as well?), but at least we hope virtio-gpu can take this.

There's already another proposal from Android people for tracking dma-buf
(in dma-buf heaps/ion) usage. I think we need something which is overall
integrated, otherwise we have a complete mess of partial solutions.

Also there's work going on to add cgroups support to gpu drivers (pushed
by amd and intel folks, latest rfc have been quite old), so that's another
proposal for gpu memory usage tracking.

Also for upstream we need something which works with upstream gpu drivers
(even if you don't end up using that in shipping products). So that's
another reason maybe why a quick hack in the virtio gpu driver isn't the
best approach here.

I guess a good approach would be if Android at least can get to something
unified (gpu driver, virtio-gpu, dma-buf heaps), and then we need to
figure out how to mesh that with the cgroups side somehow.

Also note that at least on dma-buf we already have some other debug
features (for android), so an overall "how does this all fit together"
would be good.
-Daniel

> 
> Many thanks!
> Yiwei

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
