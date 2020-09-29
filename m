Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590F0C4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 11:00:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B9E207C4
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 11:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jsz6B1+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B9E207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 50C2986759;
	Tue, 29 Sep 2020 11:00:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ULh0ggpXb2mX; Tue, 29 Sep 2020 11:00:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 858F484F57;
	Tue, 29 Sep 2020 11:00:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A4F1C0889;
	Tue, 29 Sep 2020 11:00:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A5C9C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 11:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 579012049F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 11:00:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aEGDxOxVBSUi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 11:00:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by silver.osuosl.org (Postfix) with ESMTPS id AA6EC20117
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 11:00:02 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id b22so4937958lfs.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 04:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=m/8RcwvNRZX4QrC1qgXuNqwd8pHZ5jEfkIMP8FcXGzs=;
 b=jsz6B1+YEp5B8KlbE/d0+3hD+n5mvwweCSSsHXznFq2L+MbyNhnwBbEVTadiV9A8e8
 Hj/4Q37N4gMr3WISbfGAUlxUR7jJYV5BX7k2uQWCUyOolHRZurqdtTKtWu98cbslD4kd
 j3VLPxLK5+IeiS53iuP6Pb2M5x1wuj8Ww0P4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=m/8RcwvNRZX4QrC1qgXuNqwd8pHZ5jEfkIMP8FcXGzs=;
 b=n3BJW6d7AeWYltepOagGwkLobt5NhuFlEknw2PA3oxA8xWjQfyQUzNWMakj3GlssSq
 Mrx8P7DRPtEqisT5T+MkLkWJjLJa8z3e9X4QRv+CsTA+cSB9fNzewgrxCF0b+853gX/V
 HMlJhiPacZs0mAxSVn0X+wj7v/ISrJba9mccbfVv1gpj3FXyL9hymMeCGCDA7kIXHUy0
 CshpbiTz6zHVS3xVXN6lS5RI2A0LvumwAmM8wsYRzf7cYm9jWe6Vm30nruExyjbNQSRe
 8UEiAJzO6i/jRkHLCOCrRZmF/6UfaqKru4SVDFVHALLS0ZVVByITGwXm0iIbDqbciik/
 25kg==
X-Gm-Message-State: AOAM5338c/FGyk2MC4R7giAlVDu8h0dO/H7Sosnr2w+QVNjwl5kYRhbW
 A7qNh+P3YlObpPTY7b2mmbHwT0+TC/E1WPqv
X-Google-Smtp-Source: ABdhPJzmw2CD/MpLrTQRlDKQtbpWYZdfZO7lS5wPv+xREi43g7gWZnZuZtDrMycOZuDAjAbXvAqStA==
X-Received: by 2002:a5d:6552:: with SMTP id z18mr3513370wrv.32.1601376783538; 
 Tue, 29 Sep 2020 03:53:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id l5sm5116546wmf.10.2020.09.29.03.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 03:53:02 -0700 (PDT)
Date: Tue, 29 Sep 2020 12:53:00 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 4/4] drm/qxl: use qxl pin function
Message-ID: <20200929105300.GM438822@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
 dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, 
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20200929095115.24430-1-kraxel@redhat.com>
 <20200929095115.24430-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200929095115.24430-5-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Huang Rui <ray.huang@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@redhat.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
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

On Tue, Sep 29, 2020 at 11:51:15AM +0200, Gerd Hoffmann wrote:
> Otherwise ttm throws a WARN because we try to pin without a reservation.
> 
> Fixes: 9d36d4320462 ("drm/qxl: switch over to the new pin interface")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
> index d3635e3e3267..eb45267d51db 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -145,7 +145,7 @@ int qxl_bo_create(struct qxl_device *qdev,
>  		return r;
>  	}
>  	if (pinned)
> -		ttm_bo_pin(&bo->tbo);
> +		qxl_bo_pin(bo);

I think this is now after ttm_bo_init, and at that point the object is
visible to lru users and everything. So I do think you need to grab locks
here instead of just incrementing the pin count alone.

It's also I think a bit racy, since ttm_bo_init drops the lock, so someone
might have snuck in and evicted the object already.

I think what you need is to call ttm_bo_init_reserved, then ttm_bo_pin,
then ttm_bo_unreserve, all explicitly.
-Daniel

>  	*bo_ptr = bo;
>  	return 0;
>  }
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
