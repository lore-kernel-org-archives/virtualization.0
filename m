Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0B3C77B7C
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 16:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46FA36FE78;
	Wed, 10 May 2023 16:04:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46FA36FE78
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cfOQbks0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TqtzfNrkf_Bq; Wed, 10 May 2023 16:04:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DEF9570059;
	Wed, 10 May 2023 16:04:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEF9570059
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 894B3C0037;
	Wed, 10 May 2023 16:04:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B92E1C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 16:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 924536FEDB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 16:04:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 924536FEDB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mw5rPGtUetE8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 16:04:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC9FA615A7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC9FA615A7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 16:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683734671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=20W4Czom/LJp0YWSRRHuIr7SauQc+F/OF764Zl7g/+k=;
 b=cfOQbks03IA4+M78zTjYPI8iid9C7ce28QnUu5zGqGL5f/wEwqJWHTzF5xg9KhQ3nxQ/BP
 5p/gfosdUwprXSb4a/Nk8rdnSd9q5d3QRhKXza7tDdIWTF5Rf2TxmoDfzOHTQezBvzHDIR
 jzk028g2Vm718pzrztOzRxg+Pvo2n4k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-jHQOYWMCMJeMDGOKsE-WJQ-1; Wed, 10 May 2023 12:04:27 -0400
X-MC-Unique: jHQOYWMCMJeMDGOKsE-WJQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f420ec766dso29311575e9.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 09:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683734665; x=1686326665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20W4Czom/LJp0YWSRRHuIr7SauQc+F/OF764Zl7g/+k=;
 b=VnjdLtgqBkUvFyr0lyuIljtOShaXrA1QqTJGohHrrcegUajbBMCsmPKm1WzldtznS/
 yvXu1brEKMjyMBsS8UzRAyUF7BZBXlecpocPyuXNlZWeYomV4WKUYWup0yiwO8pRM+TG
 6KaDJGPoRUjMQVRv/EKlDraxjCN4PaO/zjBhTR509bOHePmSis1VUQW8S8U8E8r6F+GU
 dnzIHupcu7Cf2R9WrOvE/06RI3AjhcObukgbXqbHaFsBbUNGOmO8yyFfKmQpl375NDvW
 3ihgImoGjoTHK0bCaf312CowV1t0AdB3eROqhcklbvp73bcs4B4dnBzoFH9vCigm/YhC
 Oeqw==
X-Gm-Message-State: AC+VfDzt493SUTdZoJEtlNUf/65TvZbj+n+HI/Idz5V6R64A95ODIayJ
 VaQo1uaHLhtFrckBL7aCW4xfZvGqwQ8XL3HmWcr9P53Xr+j64AneiVKdrdRTsoKgNoCHB0o9dhp
 /FAjByovtPdX8PblVqKT8oQQAvsWRLrNFxjeEvtiBoA==
X-Received: by 2002:a05:600c:3658:b0:3f4:2374:3517 with SMTP id
 y24-20020a05600c365800b003f423743517mr7838667wmq.19.1683734665554; 
 Wed, 10 May 2023 09:04:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4B9LaeUTLsozM8szgufxr/B/Bt2vHbFZ0LpsmFrPFfyNdAV/BNdYrFPVeeFecPUepl4T7lUw==
X-Received: by 2002:a05:600c:3658:b0:3f4:2374:3517 with SMTP id
 y24-20020a05600c365800b003f423743517mr7838651wmq.19.1683734665269; 
 Wed, 10 May 2023 09:04:25 -0700 (PDT)
Received: from redhat.com ([2.52.1.223]) by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c220a00b003f17122587bsm23382638wml.36.2023.05.10.09.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 May 2023 09:04:24 -0700 (PDT)
Date: Wed, 10 May 2023 12:04:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] virtio: Add missing documentation for structure fields
Message-ID: <20230510120332-mutt-send-email-mst@kernel.org>
References: <20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
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

On Wed, May 10, 2023 at 02:23:12PM +0200, Simon Horman wrote:
> Add missing documentation for the vqs_list_lock field of struct virtio_device,
> and the validate field of struct virtio_driver.
> 
> ./scripts/kernel-doc says:
> 
>  .../virtio.h:131: warning: Function parameter or member 'vqs_list_lock' not described in 'virtio_device'
>  .../virtio.h:192: warning: Function parameter or member 'validate' not described in 'virtio_driver'
>  2 warnings as Errors
> 
> No functional changes intended.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  include/linux/virtio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b93238db94e3..0b2b82ee3220 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>   * @config_enabled: configuration change reporting enabled
>   * @config_change_pending: configuration change reported while disabled
>   * @config_lock: protects configuration change reporting
> + * @vqs_list_lock: protects @vqs.
>   * @dev: underlying device.
>   * @id: the device type identification (used to match it with a driver).
>   * @config: the configuration ops for this device.
> @@ -160,6 +161,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
>   * @feature_table_size: number of entries in the feature table array.
>   * @feature_table_legacy: same as feature_table but when working in legacy mode.
>   * @feature_table_size_legacy: number of entries in feature table legacy array.
> + * @validate: the function to call to vaidate features at probe time.

typo

and this is called before probe actually not at probe time

>   * @probe: the function to call when a device is found.  Returns 0 or -errno.
>   * @scan: optional function to call after successful probe; intended
>   *    for virtio-scsi to invoke a scan.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
