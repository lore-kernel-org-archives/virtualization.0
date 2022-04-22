Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E53C433F5
	for <virtualization@archiver.kernel.org>; Fri, 22 Apr 2022 21:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7DE9640AFB;
	Fri, 22 Apr 2022 21:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U6wjVX-QoAnw; Fri, 22 Apr 2022 21:05:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CD8C240141;
	Fri, 22 Apr 2022 21:05:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F9E7C0039;
	Fri, 22 Apr 2022 21:05:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71A82C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 21:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5990B60AAE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 21:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PiaFUAqyjIgS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 21:05:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7443260A88
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 21:05:05 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 l3-20020a05600c1d0300b0038ff89c938bso5580284wms.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gmRkt5N52LVAcW5jIpeF1Nn5yhhAyoF29FUFsd01Fns=;
 b=brYIpV1+gbZnACdgtobiaHYB0nSPaEQY0ScB0C1CEeIsPotvLvC9d7oCAEPCZgA89C
 uxr4XWWt08JrUjRW2taPLwIBI0l08LIQ+tdBDD3Dcvl2N+LHeNiiWLLSiJ/2nAXSmxbW
 5V6Qt8AQIHi92IOyOLysC7CDhQRUu7lZDi7hKcHVobTK+mt9yg3GXLl1gnF6CUN511k8
 2dACgkZB0zdoeD223DTUdfjYRFediBrQ/WkFCx20AwAddSmuDegIlAyVpQMaA+YkJeVl
 i9/jYTuvmZKVUkEHz5l8/VZdcoi46D7lI/zvaAmJgrcM3qXnC1vMcqvjxQtND51sdUpm
 7npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gmRkt5N52LVAcW5jIpeF1Nn5yhhAyoF29FUFsd01Fns=;
 b=vCgGsAutqtdjXGIC0dzPQYgBeA/4COkRDGHHAEdJ4n4lOe8xHu22hwnHx/k+MK2jqZ
 7MDd2GDEiJGW5MA9YFG9zUd/urccyiczsPXXug7glzGGQ1kkaP9bAjd5lU0Y1v4hIZM7
 uSJ72LhVOc6vseYW0dBOMEhO1xUeNdQWiP1aZqqeztS6Ecp0ARdMwSj0mAke709OlY9H
 IbKAFTrtmT2cGgdBw9PnSWkGNbtnCabiniS8BbU1UmPqr/aypPisgk4vT7NyExSCj+N/
 oYAZl2MW3CbAMaPkOBDz36QrkJBm50bC0gbiozt1K1DoMQ3dPnmmYeTpuuBpZTdZxvGP
 ocLg==
X-Gm-Message-State: AOAM530bAYdK+cU+wMD7/Wm79k2e9s25SxChMYgfzz5PiJQhzOk3HBMQ
 3nes50JaIOTbWBYWueYj2cL1fbDAetia5FZ/72s=
X-Google-Smtp-Source: ABdhPJwKs/6J6K59SHxPCUJVmRs3c/Et02MftfleiTfkZ7qpvT/EN+91VaTZjZn+ojcG4yAIgaCF1NrTLKUqpfpuOBY=
X-Received: by 2002:a05:600c:3011:b0:38e:ba57:8b79 with SMTP id
 j17-20020a05600c301100b0038eba578b79mr14709846wmh.26.1650661503393; Fri, 22
 Apr 2022 14:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220405173918.1000846-1-robdclark@gmail.com>
 <CAPaKu7Tur-_Kf3Lb9U=98Yr_08onxPHNKTPh2anHU6zLPhr5ZQ@mail.gmail.com>
In-Reply-To: <CAPaKu7Tur-_Kf3Lb9U=98Yr_08onxPHNKTPh2anHU6zLPhr5ZQ@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 22 Apr 2022 14:06:08 -0700
Message-ID: <CAF6AEGsUVDbqYOeDBXBOySfs+7ftVf5_86CiFGOLfY9fmQuEVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Add execbuf flag to request no fence-event
To: Chia-I Wu <olvaffe@gmail.com>
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

On Tue, Apr 5, 2022 at 10:57 AM Chia-I Wu <olvaffe@gmail.com> wrote:
>
> On Tue, Apr 5, 2022 at 10:38 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > It would have been cleaner to have a flag to *request* the fence event.
> > But that ship has sailed.  So add a flag so that userspace which doesn't
> > care about the events can opt-out.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
>
> Might want to wait for Gurchetan to chime in as he added the mechanism.

It turns out this patch is unnecessary.. I can simply not set
VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK instead

so self-nak for this patch ;-)

BR,
-R

> > ---
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 8 +++++---
> >  include/uapi/drm/virtgpu_drm.h         | 2 ++
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > index 3a8078f2ee27..09f1aa263f91 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > @@ -225,9 +225,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> >                 goto out_unresv;
> >         }
> >
> > -       ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
> > -       if (ret)
> > -               goto out_unresv;
> > +       if (!(exbuf->flags & VIRTGPU_EXECBUF_NO_EVENT)) {
> > +               ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
> > +               if (ret)
> > +                       goto out_unresv;
> > +       }
> >
> >         if (out_fence_fd >= 0) {
> >                 sync_file = sync_file_create(&out_fence->f);
> > diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> > index 0512fde5e697..d06cac3407cc 100644
> > --- a/include/uapi/drm/virtgpu_drm.h
> > +++ b/include/uapi/drm/virtgpu_drm.h
> > @@ -52,10 +52,12 @@ extern "C" {
> >  #define VIRTGPU_EXECBUF_FENCE_FD_IN    0x01
> >  #define VIRTGPU_EXECBUF_FENCE_FD_OUT   0x02
> >  #define VIRTGPU_EXECBUF_RING_IDX       0x04
> > +#define VIRTGPU_EXECBUF_NO_EVENT       0x08
> >  #define VIRTGPU_EXECBUF_FLAGS  (\
> >                 VIRTGPU_EXECBUF_FENCE_FD_IN |\
> >                 VIRTGPU_EXECBUF_FENCE_FD_OUT |\
> >                 VIRTGPU_EXECBUF_RING_IDX |\
> > +               VIRTGPU_EXECBUF_NO_EVENT |\
> >                 0)
> >
> >  struct drm_virtgpu_map {
> > --
> > 2.35.1
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
