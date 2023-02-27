Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E10DC64ED6
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 16:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDD1F8146D;
	Mon, 27 Feb 2023 16:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDD1F8146D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Ihkny839
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eWGFNe83qzti; Mon, 27 Feb 2023 16:56:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C2E0681310;
	Mon, 27 Feb 2023 16:56:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2E0681310
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97979C0033;
	Mon, 27 Feb 2023 16:56:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 869EFC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55C2240A60
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:56:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55C2240A60
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=Ihkny839
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GHtgVGgONIgP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:56:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10E9B404F5
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10E9B404F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:56:36 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id o12so5698027oik.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UFOFhw8IRNqs5cPEOOn1fmt/veQOghOiXH0c0ACn44g=;
 b=Ihkny839qJsF9eJvYoIxD5wZsPdFIkxSe2idlYePFV7G/ClKpGzvX1tsvulQ526bZs
 jwhfQQDDdy0W0NyL4gxvnE4D1/BO0CSOhEnRqag/roMIUr+y9H6aDTaA20HwjGsJYJpV
 aseRMPqIXjL8X/S+wVfgA/OBjiLvEi629ygZDNbzcgaV1TFCrrJAYqmf0zxGG+TcrFb+
 V/EHim8g3XCqUpz+IdAGbZ1gc9VbdgrIb1OV/Q3v2xTzMvfRvLtzWZKU/yHq3UyN/BzB
 h74E2WrSACowm/TakUCYDXQvqSXRtDJeRj7HRhgHSDMEB05WFeZvwrGDhIuD/VgdsxQS
 YnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UFOFhw8IRNqs5cPEOOn1fmt/veQOghOiXH0c0ACn44g=;
 b=LLY2RtNc0WTLgTQ4SMPdI/Vctn1QESQyCb031k7jbE2SeRQ/vRYyJSdJv4uNRezCFt
 wiyOAGqs9U3s8GFQNummm+fM1MQIuzfzemtDGJeUmqRjg/VN9RF9qCawstPq/2qFQMpa
 ufXECYhveoNu7O6qdRf38FZeP8mV/IietzARqzOhk7Gza6cbCoR81OINYm2E71rIwNbu
 CjfPEJFrj7NUCC7mc3U2Y4/dlt3nfeH3A0SJvAJaVOAl6/72oG7qUDiPjdbwSNAJwmCv
 ntXbsR1kzF0Nnh9uS962Kj203MUb6PYwNiDSljtXz8WgfxI+Ffz1WdZA/2illEv4EtHN
 hKeg==
X-Gm-Message-State: AO0yUKUAahjM39dNbLRHv+zW+0MfAZMxwnN/LEDmSdhYt2+Zr2ACw9fh
 hAMXQfvwCyEhf0+/6u90vtKpk0V2fMhmreK9f1M=
X-Google-Smtp-Source: AK7set9KKDyOAtXfl6ttjcR6L1Q7g1Em64KRPcVyPy0CnlrqZJRRGo704yVg02/SL9WYEkXwyrCt9VRtT9E2YEAE+Wc=
X-Received: by 2002:a54:409a:0:b0:384:253:642d with SMTP id
 i26-20020a54409a000000b003840253642dmr3506494oii.3.1677516996023; Mon, 27 Feb
 2023 08:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20230227160114.2799001-1-robdclark@gmail.com>
 <Y/zXaaFJhi8Q5YRZ@phenom.ffwll.local>
In-Reply-To: <Y/zXaaFJhi8Q5YRZ@phenom.ffwll.local>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 27 Feb 2023 08:56:24 -0800
Message-ID: <CAF6AEGt1fjSVhV03uP2v-jxzwRvZLia+0CZOwxbbS038rAZgzw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Add option to disable KMS support
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, 
 Chia-I Wu <olvaffe@gmail.com>, Ryan Neph <ryanneph@chromium.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Rob Clark <robdclark@chromium.org>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, 
 open list <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
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

On Mon, Feb 27, 2023 at 8:16 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Feb 27, 2023 at 08:01:13AM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add a build option to disable modesetting support.  This is useful in
> > cases where the guest only needs to use the GPU in a headless mode, or
> > (such as in the CrOS usage) window surfaces are proxied to a host
> > compositor.
> >
> > v2: Use more if (IS_ENABLED(...))
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> This feels a bit much like a worksforus solution. Not objecting to landing
> this, but would some kind of feature bit on the virtio hw and
> autodetection in the guest driver side work? Especially if people ever
> want to get this to a Just Works model with standard distros.

I could probably make this also work if the host advertises zero
scanouts.  But I don't expect distro's would want to disable this
option, which is why it is "If unsure, say Y".  The CrOS guest kernel
already needs a special "virtio-wl" driver, so we are already
venturing outside of "guest is just a generic distro" territory.

BR,
-R

> Usually the argument for compile option is "binary size", but you're
> leaving most of the kms stuff in there so that's clearly not it :-)
> -Daniel
>
>
>
> > ---
> >  drivers/gpu/drm/virtio/Kconfig       | 11 +++++++++
> >  drivers/gpu/drm/virtio/Makefile      |  5 +++-
> >  drivers/gpu/drm/virtio/virtgpu_drv.c |  6 ++++-
> >  drivers/gpu/drm/virtio/virtgpu_drv.h | 10 ++++++++
> >  drivers/gpu/drm/virtio/virtgpu_kms.c | 35 ++++++++++++++++------------
> >  5 files changed, 50 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
> > index 51ec7c3240c9..ea06ff2aa4b4 100644
> > --- a/drivers/gpu/drm/virtio/Kconfig
> > +++ b/drivers/gpu/drm/virtio/Kconfig
> > @@ -11,3 +11,14 @@ config DRM_VIRTIO_GPU
> >          QEMU based VMMs (like KVM or Xen).
> >
> >          If unsure say M.
> > +
> > +config DRM_VIRTIO_GPU_KMS
> > +     bool "Virtio GPU driver modesetting support"
> > +     depends on DRM_VIRTIO_GPU
> > +     default y
> > +     help
> > +        Enable modesetting support for virtio GPU driver.  This can be
> > +        disabled in cases where only "headless" usage of the GPU is
> > +        required.
> > +
> > +        If unsure, say Y.
> > diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makefile
> > index b99fa4a73b68..24c7ebe87032 100644
> > --- a/drivers/gpu/drm/virtio/Makefile
> > +++ b/drivers/gpu/drm/virtio/Makefile
> > @@ -4,8 +4,11 @@
> >  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> >
> >  virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o virtgpu_vram.o \
> > -     virtgpu_display.o virtgpu_vq.o \
> > +     virtgpu_vq.o \
> >       virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
> >       virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o
> >
> > +virtio-gpu-$(CONFIG_DRM_VIRTIO_GPU_KMS) += \
> > +     virtgpu_display.o
> > +
> >  obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > index ae97b98750b6..9cb7d6dd3da6 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > @@ -172,7 +172,11 @@ MODULE_AUTHOR("Alon Levy");
> >  DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
> >
> >  static const struct drm_driver driver = {
> > -     .driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC,
> > +     .driver_features =
> > +#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
> > +                     DRIVER_MODESET | DRIVER_ATOMIC |
> > +#endif
> > +                     DRIVER_GEM | DRIVER_RENDER,
> >       .open = virtio_gpu_driver_open,
> >       .postclose = virtio_gpu_driver_postclose,
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > index af6ffb696086..ffe8faf67247 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > @@ -426,8 +426,18 @@ virtio_gpu_cmd_set_scanout_blob(struct virtio_gpu_device *vgdev,
> >                               uint32_t x, uint32_t y);
> >
> >  /* virtgpu_display.c */
> > +#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
> >  int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
> >  void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
> > +#else
> > +static inline int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
> > +{
> > +     return 0;
> > +}
> > +static inline void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
> > +{
> > +}
> > +#endif
> >
> >  /* virtgpu_plane.c */
> >  uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc);
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > index 27b7f14dae89..70d87e653d07 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > @@ -161,7 +161,8 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
> >       if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
> >               vgdev->has_virgl_3d = true;
> >  #endif
> > -     if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
> > +     if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) &&
> > +         virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
> >               vgdev->has_edid = true;
> >       }
> >       if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
> > @@ -218,17 +219,19 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
> >               goto err_vbufs;
> >       }
> >
> > -     /* get display info */
> > -     virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
> > -                     num_scanouts, &num_scanouts);
> > -     vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
> > -                                 VIRTIO_GPU_MAX_SCANOUTS);
> > -     if (!vgdev->num_scanouts) {
> > -             DRM_ERROR("num_scanouts is zero\n");
> > -             ret = -EINVAL;
> > -             goto err_scanouts;
> > +     if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS)) {
> > +             /* get display info */
> > +             virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
> > +                             num_scanouts, &num_scanouts);
> > +             vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
> > +                                         VIRTIO_GPU_MAX_SCANOUTS);
> > +             if (!vgdev->num_scanouts) {
> > +                     DRM_ERROR("num_scanouts is zero\n");
> > +                     ret = -EINVAL;
> > +                     goto err_scanouts;
> > +             }
> > +             DRM_INFO("number of scanouts: %d\n", num_scanouts);
> >       }
> > -     DRM_INFO("number of scanouts: %d\n", num_scanouts);
> >
> >       virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
> >                       num_capsets, &num_capsets);
> > @@ -246,10 +249,12 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
> >               virtio_gpu_get_capsets(vgdev, num_capsets);
> >       if (vgdev->has_edid)
> >               virtio_gpu_cmd_get_edids(vgdev);
> > -     virtio_gpu_cmd_get_display_info(vgdev);
> > -     virtio_gpu_notify(vgdev);
> > -     wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
> > -                        5 * HZ);
> > +     if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS)) {
> > +             virtio_gpu_cmd_get_display_info(vgdev);
> > +             virtio_gpu_notify(vgdev);
> > +             wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
> > +                                5 * HZ);
> > +     }
> >       return 0;
> >
> >  err_scanouts:
> > --
> > 2.39.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
