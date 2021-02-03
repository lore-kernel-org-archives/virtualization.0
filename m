Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B0C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 10:15:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD7664F59
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 10:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD7664F59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 07323870E4;
	Wed,  3 Feb 2021 10:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQIhcVgpXj6W; Wed,  3 Feb 2021 10:15:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3BAA28653F;
	Wed,  3 Feb 2021 10:15:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22B83C0174;
	Wed,  3 Feb 2021 10:15:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA715C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 10:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A315584DDC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 10:15:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z7bImFiHzCzi
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 10:15:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C50E28493F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 10:15:45 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id b3so5365308wrj.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Feb 2021 02:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=a321zpi9EYFPKrHa/w5wiDf7FzXZmd2yWZ5PnRvh2oY=;
 b=RCZYqjo8I8AawXH9nn6NQo2bQR2kzFkM3XePpRANJJFh+lczMkaDb319tOYYIL1zXa
 yxn6aF18WkJpG3iAp/H1LKgx52iDyHPIS7MGdZknlRvHXfaNZJXshs8+A0/iv6kNsVrB
 JXrIIwgJ+TTIv7ID15/NbNfrIDf5JA+9CfuIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=a321zpi9EYFPKrHa/w5wiDf7FzXZmd2yWZ5PnRvh2oY=;
 b=K5PBXR2ztvgZoM8LpBGx0sJysDM6gBJ5pTQ8MuumZepl2W+gcZMk6mijTtN7hSgsYA
 dOZ1O9KSJ19wC47x07lOVFeFNyA3Npqs6i5OEwDt4l8Akrcf3vDgdSZvRO4gOIb4W86m
 1P5lAbtXKDZyMrTi4qpklpTpqytwDCe861SUt5ioYIRqeY8V33mSrAjkbRZZxbmzI3kf
 Nq5GtCvcPUzNFTMYhDvLziuY2945q2G/3AH02hJK47nzTkrulQJKd6E4q+DaBFARPhMG
 f8FLzRAHxDHGleE9JNPXyfF8GIz2+72NR9hhetqK2cgX5GaWXmW7HrcqY99QNouu85T6
 vhtw==
X-Gm-Message-State: AOAM533TdFYWhx5S+xoex7xwXHx6tgPlQpQjieamLa0dAMheDln81uRG
 SIY1xL9Au2VaCH805amUIZIZnQ==
X-Google-Smtp-Source: ABdhPJzHB+ffvr9s3UM8FPaGZKcUXhORlDn7t4V0qu+UbQAlINgveENCa31EtHjKs1ycCeGI9sFg6g==
X-Received: by 2002:adf:f743:: with SMTP id z3mr2655431wrp.165.1612347344092; 
 Wed, 03 Feb 2021 02:15:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f4sm2825617wrs.34.2021.02.03.02.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 02:15:43 -0800 (PST)
Date: Wed, 3 Feb 2021 11:15:41 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 5/5] drm/qxl: properly free qxl releases
Message-ID: <YBp3zQqomQziZbPT@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
 dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@linux.ie>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, 
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20210126165812.1661512-1-kraxel@redhat.com>
 <20210126165812.1661512-6-kraxel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210126165812.1661512-6-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@redhat.com>
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

On Tue, Jan 26, 2021 at 05:58:12PM +0100, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.h     |  1 +
>  drivers/gpu/drm/qxl/qxl_kms.c     | 22 ++++++++++++++++++++--
>  drivers/gpu/drm/qxl/qxl_release.c |  2 ++
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
> index 01354b43c413..1c57b587b6a7 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -214,6 +214,7 @@ struct qxl_device {
>  	spinlock_t	release_lock;
>  	struct idr	release_idr;
>  	uint32_t	release_seqno;
> +	atomic_t	release_count;
>  	spinlock_t release_idr_lock;
>  	struct mutex	async_io_mutex;
>  	unsigned int last_sent_io_cmd;
> diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
> index 4a60a52ab62e..f177f72bfc12 100644
> --- a/drivers/gpu/drm/qxl/qxl_kms.c
> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> @@ -25,6 +25,7 @@
>  
>  #include <linux/io-mapping.h>
>  #include <linux/pci.h>
> +#include <linux/delay.h>
>  
>  #include <drm/drm_drv.h>
>  #include <drm/drm_managed.h>
> @@ -286,8 +287,25 @@ int qxl_device_init(struct qxl_device *qdev,
>  
>  void qxl_device_fini(struct qxl_device *qdev)
>  {
> -	qxl_bo_unref(&qdev->current_release_bo[0]);
> -	qxl_bo_unref(&qdev->current_release_bo[1]);
> +	int cur_idx, try;
> +
> +	for (cur_idx = 0; cur_idx < 3; cur_idx++) {
> +		if (!qdev->current_release_bo[cur_idx])
> +			continue;
> +		qxl_bo_unpin(qdev->current_release_bo[cur_idx]);
> +		qxl_bo_unref(&qdev->current_release_bo[cur_idx]);
> +		qdev->current_release_bo_offset[cur_idx] = 0;
> +		qdev->current_release_bo[cur_idx] = NULL;
> +	}
> +
> +	/*
> +	 * Ask host to release resources (+fill release ring),
> +	 * then wait for the release actually happening.
> +	 */
> +	qxl_io_notify_oom(qdev);
> +	for (try = 0; try < 20 && atomic_read(&qdev->release_count) > 0; try++)
> +		msleep(20);

A bit icky, why not use a wait queue or something like that instead of
hand-rolling this? Not for perf reasons, just so it's a bit clear who
waits for whom and why.
-Daniel

> +
>  	qxl_gem_fini(qdev);
>  	qxl_bo_fini(qdev);
>  	flush_work(&qdev->gc_work);
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> index 28013fd1f8ea..43a5436853b7 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -196,6 +196,7 @@ qxl_release_free(struct qxl_device *qdev,
>  		qxl_release_free_list(release);
>  		kfree(release);
>  	}
> +	atomic_dec(&qdev->release_count);
>  }
>  
>  static int qxl_release_bo_alloc(struct qxl_device *qdev,
> @@ -344,6 +345,7 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
>  			*rbo = NULL;
>  		return idr_ret;
>  	}
> +	atomic_inc(&qdev->release_count);
>  
>  	mutex_lock(&qdev->release_mutex);
>  	if (qdev->current_release_bo_offset[cur_idx] + 1 >= releases_per_bo[cur_idx]) {
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
