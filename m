Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC64C07E9C
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:25:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0E16196C
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0E16196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CB374046E;
	Mon,  5 Jul 2021 18:25:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M2m5HDGJYZ4i; Mon,  5 Jul 2021 18:25:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 82DF74047B;
	Mon,  5 Jul 2021 18:25:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF3AC0010;
	Mon,  5 Jul 2021 18:25:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5723C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87430607AB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 864kMEjZCHSt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:25:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C20A9605B3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625509539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1dA7LuS21CZJga9dfZTy+xFxKT35DcGT8NXfH7SV3w=;
 b=g06k/VM7aEZ6bulPGceNdaJxMn+F5wAurDqCmlmdEE8/r3EOLHoU8jFzKBqt6fQjAm4z8b
 k3jLM3AO09oTD2id2RRizJYZvQSreVmiMvh31tDLauIGElausMjrVHz+8H386TwYliI6DQ
 D8vyDlaCpyVDLGUMdBSx2VEAm5QvrlU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-xWpKYyVcObyc9YJm5QyvlA-1; Mon, 05 Jul 2021 14:25:38 -0400
X-MC-Unique: xWpKYyVcObyc9YJm5QyvlA-1
Received: by mail-ed1-f72.google.com with SMTP id
 n13-20020a05640206cdb029039589a2a771so1512393edy.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 11:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R1dA7LuS21CZJga9dfZTy+xFxKT35DcGT8NXfH7SV3w=;
 b=Pkv5EgMvLnTJpxwVEN4plJWiAiviwhFBQVAQ1wEExRQKFFCHXorJmbvbjnREafrtEj
 7IKfMWUuzhnt/zpKI8aBsGM44YkU8Mo3zWMuCgLPWt9CPvJ8/b7irFCh/Pn2YgOV4xjK
 zxhbu+i7SlHsXDRB4+sx4ByzdTgGG1HNDiORW1UYCYXI+ytLaGQtlnT8XE7yiyRssjNF
 V0DdekWrd+fBxlIoRQWTsX0aEeksxrQ5SCY6sqJjrTwuhD6ayz+WCbLDbvZV6h7L8WQy
 SVeeT0AKUg/8onfJKIVGSGzUQWpdkflRWSzVkH1ehlvfGQiDTBLfmOh/UYDUdhyO+LZY
 lWnA==
X-Gm-Message-State: AOAM532suR33BllkaydKk1pr8age08/iBONeOYMS+KLSR5StWCXyUtLs
 brfBX9Ns8kfwsYgc9kztKGCKFNPXyzMb5X5z8S7YRp4B88733KsLkl3xaY5xSQN5h6zxjLMUIIv
 /ypAYQ0Hg9NqJ5eAPo/f7xpcbvWxOHY7qzqCTHd5SNw==
X-Received: by 2002:a05:6402:1c82:: with SMTP id
 cy2mr17477381edb.324.1625509537510; 
 Mon, 05 Jul 2021 11:25:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyiqkphTkUX3OHsr5lvwvQkNygRb1AqpshkkZAXPOLJN5NLWa7fPK/aNr11ZHLweIF1oUb7w==
X-Received: by 2002:a05:6402:1c82:: with SMTP id
 cy2mr17477367edb.324.1625509537409; 
 Mon, 05 Jul 2021 11:25:37 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
 by smtp.gmail.com with ESMTPSA id qo20sm522933ejb.106.2021.07.05.11.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 11:25:36 -0700 (PDT)
Date: Mon, 5 Jul 2021 14:25:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v4] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210705142431-mutt-send-email-mst@kernel.org>
References: <20210705100006.90-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210705100006.90-1-xieyongji@bytedance.com>
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

On Mon, Jul 05, 2021 at 06:00:06PM +0800, Xie Yongji wrote:
> This ensures that we will not use an invalid block size
> in config space (might come from an untrusted device).
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

I replied on v3.
Silently ignoring what hypervisor said is not a good idea.


> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index e4bd3b1fc3c2..e9d7747c3cc0 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -819,7 +819,7 @@ static int virtblk_probe(struct virtio_device *vdev)
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
