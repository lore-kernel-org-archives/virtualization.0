Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82DDC433E3
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 08:15:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C76820720
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 08:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Viod+5Sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C76820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 49DF98864D;
	Fri, 21 Aug 2020 08:15:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1dibPKFRqyz6; Fri, 21 Aug 2020 08:15:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 936CF88611;
	Fri, 21 Aug 2020 08:15:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AABBC0889;
	Fri, 21 Aug 2020 08:15:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C954BC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 08:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B50FA20384
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 08:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v0mugMSdSqQK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 08:15:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 1332D20242
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597997699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0I/pNL884gnkHmjBwkHes0nHXe8WPkrBrHsq+QyWGEw=;
 b=Viod+5SbJ0vXHrkNS8Dy6sLZ6s2kOpwgxSwBlquFnKpAs1mb9V2P8GU4bFdpus9ijnmGMv
 /OT0CdO8R+b6Hq5knCYoB89DnFWXft2lQoA0RhZEuA2a8B3Qi08/o/Pi3KG83a3iXP+Pl7
 ioF9RH8NK64ostyTfayNsN0U4w4pSlU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-WSb93f33MTWcumt52kONgw-1; Fri, 21 Aug 2020 04:14:55 -0400
X-MC-Unique: WSb93f33MTWcumt52kONgw-1
Received: by mail-wm1-f70.google.com with SMTP id z1so517623wmf.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 01:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0I/pNL884gnkHmjBwkHes0nHXe8WPkrBrHsq+QyWGEw=;
 b=US1wFp7RosbLIYe5zj/sIW04DG04+Kw3j22m9HUn53hUGF3gxK/Em6JlXueTWHvkBk
 A4zyF2PIud7tlajY6nypSHxZz6Os8sXEbuh2TSFaD6llfJL2s0DclJXy36dmwd1Q9IeT
 2PSeaR5P/+bjPHUXWCH1Bg0ZvazNK5/E9jUi4e6y29DYT/JpGb7HVBWJRIn0pvsByhID
 GYx28vFkvmOws87K17njZUhbFIzA3/ZaseGq949BL0cjWt2s7OwQMoR7+iB60/KLrV7J
 bVi0fo9zbbh+xfzp6WsFBvpQ7scpPQXE3U80EQ6EW4KqwtcPfF4+bYvSf4JKH2Ihzst7
 Gj6A==
X-Gm-Message-State: AOAM532tsfpJWhkB2qRiRdLPXDz2ouEzS/+JuRqS5R9z6NB/bYfTn6Jt
 6HmiBhIi2lx8gODiq8kpEWFrOQ6h/tBJRmnz4Pp/ENOIp5jl1zmycLb1BE+dJBEfnU+Uy0jVBUh
 lYVcUypl4XE96JG6wCPCAga1ojQDUOQcC22u1tEv4yg==
X-Received: by 2002:adf:ba52:: with SMTP id t18mr1610248wrg.26.1597997694825; 
 Fri, 21 Aug 2020 01:14:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOjSXuqWXCiJ2sanB2D/fqYVUmGyFMmgD/33KFzetwXwzZI+JIqhRYkybHiV59yMxrm2afOg==
X-Received: by 2002:adf:ba52:: with SMTP id t18mr1610227wrg.26.1597997694626; 
 Fri, 21 Aug 2020 01:14:54 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id r206sm3363766wma.6.2020.08.21.01.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 01:14:54 -0700 (PDT)
Date: Fri, 21 Aug 2020 10:14:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] virtio-blk: Use kobj_to_dev() instead of container_of()
Message-ID: <20200821081451.ell5jcyq6ozpzruo@steredhat>
References: <1597972755-60633-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <1597972755-60633-1-git-send-email-tiantao6@hisilicon.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, mst@redhat.com, linuxarm@huawei.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

On Fri, Aug 21, 2020 at 09:19:15AM +0800, Tian Tao wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 63b213e0..eb367b5 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -631,7 +631,7 @@ static struct attribute *virtblk_attrs[] = {
>  static umode_t virtblk_attrs_are_visible(struct kobject *kobj,
>  		struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct gendisk *disk = dev_to_disk(dev);
>  	struct virtio_blk *vblk = disk->private_data;
>  	struct virtio_device *vdev = vblk->vdev;
> -- 
> 2.7.4
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
