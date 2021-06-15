Return-Path: <SRS0=k2cl=LJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BB7C48BE8
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 15:27:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D33616EA
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D33616EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59F7A60871;
	Tue, 15 Jun 2021 15:27:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qLr7AggILgdl; Tue, 15 Jun 2021 15:27:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 11872605AF;
	Tue, 15 Jun 2021 15:27:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4676C000E;
	Tue, 15 Jun 2021 15:27:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A390C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 15:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30AF6401FD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 15:27:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IcqXaeRy1vix
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 15:27:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFFC7400C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623770850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBaVLpIdsAFYJF8kqK3yekJ5AzD1bcUpe8+m6jwsVLg=;
 b=fSBjcT318OH6wnTl6N7EHhkq2zdRp2JFmiKMkBfeMzkl9RXUivf4h6bBXFjih5YpZZRyd8
 tLoVHSThaHqUDfNUMCMwFZ6UhltYgi71D5VzgNamut0P9PqmnFY6t11WztoVS4WOzY1ePW
 x5PkBVmK58zFA/Gs96pwClfVxcTOklY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-vvSO2onfOJaW6hc6Et4_Ag-1; Tue, 15 Jun 2021 11:27:29 -0400
X-MC-Unique: vvSO2onfOJaW6hc6Et4_Ag-1
Received: by mail-ej1-f70.google.com with SMTP id
 gv42-20020a1709072beab02903eab8e33118so4692321ejc.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 08:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BBaVLpIdsAFYJF8kqK3yekJ5AzD1bcUpe8+m6jwsVLg=;
 b=JY63oa7zwB1s8VMWIO37k/fvvsrrMOSuNzrcqMsgusWycvEzCjq/lDodKetmGoBEGV
 3LF6BrBzHmAJeM2OgGeqKPrKTEvpnyXS7Bt1OVDKojV4legt/FZd23+jAHsRwi+pXfbR
 syI8LoPC6cYVrcF7UoZFjcl37S+Jcr/Inw7PkgCCBEKqkP9iKIkNEM3Zh4fjFv/KW/hp
 3osJl6ZEvi5JFuDxDP3QGPyBUqJuD7yGrvhI3/G4rogsJVACuDk7iliLHDkTqKn0MyWM
 LSdyT6VC3emUe7YZkfYWvu72Ew4ArKy2wQrEJ4S3xiZBkn4MXltSVJw8nVqnLh5eTi24
 W8Iw==
X-Gm-Message-State: AOAM533cGNhPXVEf7FpEQDCgkVXBkr2ArUlnOyArWBjqUKkle8lpo6Ak
 C1hHajx+LPdFcCSaTdEmrhSyvTDBkxXHDU+52y+RC/vcsQXaBPD/Ak+a20uB+/uheST5p7QK4Vy
 5nCIcgERsiold+Olb7Dhu53M/xbzvb6IIHKWPYZ2Btw==
X-Received: by 2002:a17:907:e8d:: with SMTP id
 ho13mr40597ejc.387.1623770848250; 
 Tue, 15 Jun 2021 08:27:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyccg0L1KZ9HRDmng0aCPycLedCiLWQMiR/1yuXJ4epefHBw9Kz5GYIcrrgex/qKDfX2NhxbQ==
X-Received: by 2002:a17:907:e8d:: with SMTP id
 ho13mr40579ejc.387.1623770848094; 
 Tue, 15 Jun 2021 08:27:28 -0700 (PDT)
Received: from redhat.com ([77.126.22.11])
 by smtp.gmail.com with ESMTPSA id y10sm10323681ejm.76.2021.06.15.08.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jun 2021 08:27:26 -0700 (PDT)
Date: Tue, 15 Jun 2021 11:27:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210615112612-mutt-send-email-mst@kernel.org>
References: <20210615104810.151-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210615104810.151-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com
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

On Tue, Jun 15, 2021 at 06:48:10PM +0800, Xie Yongji wrote:
> This ensures that we will not use an invalid block size
> in config space (might come from an untrusted device).
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

I'd say if device presents an unreasonable value,
and we want to ignore that, then we should not
negotiate VIRTIO_BLK_F_BLK_SIZE so that host knows.

So maybe move the logic to validate_features.

> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b9fa3ef5b57c..85ae3b27ea4b 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -827,7 +827,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &blk_size);
> -	if (!err)
> +	if (!err && blk_size >= SECTOR_SIZE && blk_size <= PAGE_SIZE)
>  		blk_queue_logical_block_size(q, blk_size);
>  	else
>  		blk_size = queue_logical_block_size(q);
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
