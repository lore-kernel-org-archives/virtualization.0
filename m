Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269DFECAAD3
	for <virtualization@archiver.kernel.org>; Mon, 19 Sep 2022 21:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C2F081286;
	Mon, 19 Sep 2022 21:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C2F081286
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mejDcyLS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fj1IVsD-5EUI; Mon, 19 Sep 2022 21:13:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1492D81992;
	Mon, 19 Sep 2022 21:13:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1492D81992
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D90F3C0033;
	Mon, 19 Sep 2022 21:13:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7039C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 21:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B957060899
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 21:13:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B957060899
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=mejDcyLS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jRx3OpW2Kbap
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 21:13:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1B46607F0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1B46607F0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 21:13:17 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id l14so1604029eja.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=bhPmmvgwrI1UWM0Mt5gyQZnNHupU9etq5Dz6jZIcg4M=;
 b=mejDcyLSWZX5mTMuwttKSMZJm/QXJls6I8T91VDCeShs4ASYX1lvxUPBvTC3zrre4q
 All/qoUAXzFIgQJ4R7mPOegXTUDzQ2Kk0QO+zGqSftVDPMFjE9rDOKC6kEtTaefrbyzJ
 3OYEsoyVN0+wUQTC0yPVPfclgxmA9DYEAYu3amjVekoKyDfz+7Xy2OqePk1BQ2SQLcgc
 netRXOM6oxDD1Q2oNxcEYcWljqaceOfKeLLZsF8F69hkNa4/OS/oWDkfMD2lnCXRSecH
 MTXI2/iv2VNj3MRrI8NjCwUeyWV+xUl63IntLIyiHz0sh32s9dMbyn7M87+Y4R2oOkb3
 ChUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=bhPmmvgwrI1UWM0Mt5gyQZnNHupU9etq5Dz6jZIcg4M=;
 b=x2M+sW7AuIYXtlUpThNeqEdt5TQJmItlldJ87ncSlYkgBTH5T5rpxXOmCCsfg6eOpE
 wlQGUWr+UtV+2QdmgiZ4alrjzYTmVeOImVNDvAU9MbXSBZ7DhWDHX7Gkj5d5uEGQG8tj
 djckGrqoLEBYPk7G2A+/TT43+vJSdywiwQ7OJLTqPLkyBhyHOECPpLb0YUL7j/Uf6JaJ
 Bb7EkdmBt9+bdPHWDZdIjIgPhjrs7YWISqBUqSpZHnds4MGhuIszx6xE8e3JIH77XU++
 KFY+7FZq+Cr6UUZgzgQ3MPjL4B23qpHVkIcULRO7U6f5h04N0jtQtt9RT/wc+OJQ0Qmz
 KODg==
X-Gm-Message-State: ACrzQf1ZDeiDbCCdIP8KSOslTfdpgEaYaERzZDuo7O1PY/CpX9Ny2dwE
 Qs1n2F0XJLJLNT6xu8K4YCVDPcccAHaX2MKMWh4=
X-Google-Smtp-Source: AMsMyM7zA8miSzkjN6wj3Wenio+9x9e3vwc1VxojIm7Bo9m4q5oppQbWwS1UZxQZlPWbppFokj1RitvLKfh3ykEyn3E=
X-Received: by 2002:a17:907:6d09:b0:780:aef0:694c with SMTP id
 sa9-20020a1709076d0900b00780aef0694cmr12570553ejc.717.1663621995972; Mon, 19
 Sep 2022 14:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <YygN7jY0GdUSQSy0@kili>
In-Reply-To: <YygN7jY0GdUSQSy0@kili>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Mon, 19 Sep 2022 14:13:04 -0700
Message-ID: <CAPaKu7RbWXTziR0pCeqgYiq-hVdayG8gh_hd_t0gu1swZtA9uw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: fix shift wrapping bug in
 virtio_gpu_fence_event_create()
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 Nicholas Verne <nverne@chromium.org>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 virtualization@lists.linux-foundation.org
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

On Sun, Sep 18, 2022 at 11:36 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The ->ring_idx_mask variable is a u64 so static checkers, Smatch in
> this case, complain if the BIT() is not also a u64.
>
> drivers/gpu/drm/virtio/virtgpu_ioctl.c:50 virtio_gpu_fence_event_create()
> warn: should '(1 << ring_idx)' be a 64 bit type?
>
> Fixes: cd7f5ca33585 ("drm/virtio: implement context init: add virtio_gpu_fence_event")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Style change.  Use BIT_ULL().
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
>
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 3b1701607aae..5d05093014ac 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -47,7 +47,7 @@ static int virtio_gpu_fence_event_create(struct drm_device *dev,
>         struct virtio_gpu_fence_event *e = NULL;
>         int ret;
>
> -       if (!(vfpriv->ring_idx_mask & (1 << ring_idx)))
> +       if (!(vfpriv->ring_idx_mask & BIT_ULL(ring_idx)))
>                 return 0;
>
>         e = kzalloc(sizeof(*e), GFP_KERNEL);
> --
> 2.35.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
