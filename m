Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419C5C433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 17:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF614402A4;
	Tue,  5 Apr 2022 17:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gS5hGoPY_Dmf; Tue,  5 Apr 2022 17:57:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4CB82402BE;
	Tue,  5 Apr 2022 17:57:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1828DC002C;
	Tue,  5 Apr 2022 17:57:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83AB3C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BE0C40283
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rrpgTO0zuMIq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:57:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A4254018A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:57:04 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id qh7so18274481ejb.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Apr 2022 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fWlXCTkYGyXzOu6P6awXX/6nfl84WYIZI9g+WSGOyw0=;
 b=jwx0XQUGCaRHrpcErZBCsWMj23/VXGgzoKqDbPSw2f+7F8N/d9igo6HIZ+sSRTWP9a
 hqVlvkcMJHhbv8xYnDkM7bGSTq93zYJVCDN/0Uym3PloU+pHINLS9cTw6XdP9ouh17le
 it2++ow9VO0gUkSzqvwdCeMBzqbqoP5MRFjfawj+UxJefktYATV0WZknO8TYNGxTGfMQ
 A4SEg3p8c2YD/MFhBiOnIcKNUo84CMezQUHC+Em+oj9ZjR24dmD358+boudl6sT0Vpem
 JS1XGjGYbGqUCc76nIevCdXkQ4b19TaL0abiCBotNqqN7PtVcy3R/zqZT3DhISco56Xk
 7VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fWlXCTkYGyXzOu6P6awXX/6nfl84WYIZI9g+WSGOyw0=;
 b=dQmaesEbU3cSFyevdsoOIgM93k5g91HZN/KFJ6JAzM6rw/OkYxWblaUgXZMyyFkyHI
 pDWnCDOQZkpu9sOrLcZX9CbZZRe2QsGMnW+qEoN4FivB9NDXfZw668VM1o+cmkdTswTN
 FpN4ogjuSlCGdCKcilRcjJvECBbszueWLtMO4VssA91EE7hXVGpsreP2w3sSIyqu+mnp
 3Sbidu6Yb8i3dGKHj9aVCHiZdTqZWt5p5C2GrL4s+fwoSwvKEliQQ99qDSxQ/uRBN1KF
 kOALfYvh+uOtRIh3VLfG7FDZz3B4olNWXwTebhAKhxXdSnYdD7vvpXD1+9dFs4OCWOno
 wHmg==
X-Gm-Message-State: AOAM530LmozLJqxpaIrF1JjE9mmiT0btrkMzne2Wb3bKDYgAgXvEHupw
 bKdQY0taMGuV0xCNx6c3jw/ltAjw9bUZxtFy58k=
X-Google-Smtp-Source: ABdhPJzNwJLndNEvf8of6myr8gcbYVYJMmeilk2VVKShekHBfh+c8nN7LVIdcrL0bjowhSiwuKS+l8gYahoKhGqXbFU=
X-Received: by 2002:a17:906:d10c:b0:6cd:4aa2:cd62 with SMTP id
 b12-20020a170906d10c00b006cd4aa2cd62mr4684858ejz.229.1649181422577; Tue, 05
 Apr 2022 10:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220405173918.1000846-1-robdclark@gmail.com>
In-Reply-To: <20220405173918.1000846-1-robdclark@gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 5 Apr 2022 10:56:51 -0700
Message-ID: <CAPaKu7Tur-_Kf3Lb9U=98Yr_08onxPHNKTPh2anHU6zLPhr5ZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Add execbuf flag to request no fence-event
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

On Tue, Apr 5, 2022 at 10:38 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> It would have been cleaner to have a flag to *request* the fence event.
> But that ship has sailed.  So add a flag so that userspace which doesn't
> care about the events can opt-out.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>

Might want to wait for Gurchetan to chime in as he added the mechanism.

> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 8 +++++---
>  include/uapi/drm/virtgpu_drm.h         | 2 ++
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 3a8078f2ee27..09f1aa263f91 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -225,9 +225,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                 goto out_unresv;
>         }
>
> -       ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
> -       if (ret)
> -               goto out_unresv;
> +       if (!(exbuf->flags & VIRTGPU_EXECBUF_NO_EVENT)) {
> +               ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
> +               if (ret)
> +                       goto out_unresv;
> +       }
>
>         if (out_fence_fd >= 0) {
>                 sync_file = sync_file_create(&out_fence->f);
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 0512fde5e697..d06cac3407cc 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -52,10 +52,12 @@ extern "C" {
>  #define VIRTGPU_EXECBUF_FENCE_FD_IN    0x01
>  #define VIRTGPU_EXECBUF_FENCE_FD_OUT   0x02
>  #define VIRTGPU_EXECBUF_RING_IDX       0x04
> +#define VIRTGPU_EXECBUF_NO_EVENT       0x08
>  #define VIRTGPU_EXECBUF_FLAGS  (\
>                 VIRTGPU_EXECBUF_FENCE_FD_IN |\
>                 VIRTGPU_EXECBUF_FENCE_FD_OUT |\
>                 VIRTGPU_EXECBUF_RING_IDX |\
> +               VIRTGPU_EXECBUF_NO_EVENT |\
>                 0)
>
>  struct drm_virtgpu_map {
> --
> 2.35.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
