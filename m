Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29866C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 16:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD1FC84166;
	Tue,  8 Mar 2022 16:29:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZgqODCiHbwZH; Tue,  8 Mar 2022 16:29:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BF9B84001;
	Tue,  8 Mar 2022 16:29:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E7B9C001D;
	Tue,  8 Mar 2022 16:29:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D28F8C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0DAF40AB5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XFevOl5emEBi
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:29:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EF3440AB3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:29:05 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id j17so29504989wrc.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SYDOiiE/T/Y7VYsIB3p/zW4CbpW2wGMyym0vbgifcOE=;
 b=WNVHOSyNNfjEW9O3TED1BUUpsZlmtWZ5GMHSHHEVFGg7+rjPoN4aQMb1uneNNfYFmJ
 t6flvC3RMKFIUdsgeIjsapRQTl+EqkEfyUY61YObOG7prCe8glX8SziJdfhIhh9ntGtw
 5PYICSaCHkWCxD9iay5Qo/8n1YfjEmPAl5TY6IFLzCxewPS15FEJr6ImSYwI3RRgUul9
 d9JvnyrG3dWs1ImlSIkqz7bMqSZA+4UTu3JYiEOZaBJrz5b/y8MOqLgL3Glvr7MJ561P
 SaAw9NkYUHoo0W3dRhvxVTpr/NdQMotVJH1ht/KW0KosH4wu3toSK3wPypEvUgLGA8UK
 OAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SYDOiiE/T/Y7VYsIB3p/zW4CbpW2wGMyym0vbgifcOE=;
 b=tNu0FESIylK+Ny89zwMYJKOBZeqVN9SIt5losDcKPSxm50A0zWFhKpu9v88+vqLABC
 pOLI/5DUCSy/YKMSAF7EavHk/SKLqLH/NDwuKNalzcO7nhGCGY5rsrj5AHhjid+he8JH
 ooJpcB3X5uNdT23DQxVWx+FxgWw6116K7vt9Pz26mSEoGYctjnnmo6UX08hE4/Ww399l
 5sFJjhONm34q7t8Dy2zpsL73pKmeqgJtiPrWjwvaZmPCTjOvhNA2lhdymyCzs4ut2HRA
 5c1IM8lFM9/hoyN33OKthS3gyBps4Rqb/9GsM1RPS7V8zUZq3I/io1QkWxSnyNgVobwt
 VO1A==
X-Gm-Message-State: AOAM531+e4xC7WBDWy4ca03OyxndKWSWRqTvsf9qivrri1xivP5KBsMC
 Sx3GQMrgRswg9CpqizmhOzVtyhdIOLpfTZb1avs=
X-Google-Smtp-Source: ABdhPJyR74mrKbhqIZt8QWvM99w64IQ3UB0prHiSjO57e806D1kgvYf/kWL3XMCcUIHNTOXynsFWDPS+QJu3axJda3U=
X-Received: by 2002:a5d:5382:0:b0:1f0:2f64:5a5a with SMTP id
 d2-20020a5d5382000000b001f02f645a5amr12914704wrv.418.1646756943508; Tue, 08
 Mar 2022 08:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 8 Mar 2022 08:29:32 -0800
Message-ID: <CAF6AEGt=aVJ9nR+Wv+bJEFZrn-cNOSNXG1TaJr=Cx-FTgutwKA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Rob Clark <robdclark@chromium.org>, Gert Wollny <gert.wollny@collabora.com>,
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
> Hello,
>
> This patchset introduces memory shrinker for the VirtIO-GPU DRM driver.
> During OOM, the shrinker will release BOs that are marked as "not needed"
> by userspace using the new madvise IOCTL. The userspace in this case is
> the Mesa VirGL driver, it will mark the cached BOs as "not needed",
> allowing kernel driver to release memory of the cached shmem BOs on lowmem
> situations, preventing OOM kills.

Will host memory pressure already trigger shrinker in guest?  This is
something I'm quite interested in for "virtgpu native contexts" (ie.
native guest driver with new context type sitting on top of virtgpu),
since that isn't using host storage

BR,
-R

> This patchset includes couple fixes for problems I found while was working
> on the shrinker, it also includes prerequisite DMA API usage improvement
> needed by the shrinker.
>
> The Mesa and IGT patches will be kept on hold until this kernel series
> will be approved and applied.
>
> This patchset was tested using Qemu and crosvm, including both cases of
> IOMMU off/on.
>
> Mesa: https://gitlab.freedesktop.org/digetx/mesa/-/commits/virgl-madvise
> IGT:  https://gitlab.freedesktop.org/digetx/igt-gpu-tools/-/tree/virtio-madvise
>
> Dmitry Osipenko (5):
>   drm/virtio: Correct drm_gem_shmem_get_sg_table() error handling
>   drm/virtio: Check whether transferred 2D BO is shmem
>   drm/virtio: Unlock GEM reservations in error code path
>   drm/virtio: Improve DMA API usage for shmem BOs
>   drm/virtio: Add memory shrinker
>
>  drivers/gpu/drm/virtio/Makefile               |   3 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.c          |  22 +++-
>  drivers/gpu/drm/virtio/virtgpu_drv.h          |  31 ++++-
>  drivers/gpu/drm/virtio/virtgpu_gem.c          |  84 ++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c | 124 ++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c        |  37 ++++++
>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  17 ++-
>  drivers/gpu/drm/virtio/virtgpu_object.c       |  63 +++------
>  drivers/gpu/drm/virtio/virtgpu_plane.c        |  17 ++-
>  drivers/gpu/drm/virtio/virtgpu_vq.c           |  30 +++--
>  include/uapi/drm/virtgpu_drm.h                |  14 ++
>  11 files changed, 373 insertions(+), 69 deletions(-)
>  create mode 100644 drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c
>
> --
> 2.35.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
