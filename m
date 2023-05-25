Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87461C7EE29
	for <virtualization@archiver.kernel.org>; Thu, 25 May 2023 15:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECBA784282;
	Thu, 25 May 2023 15:17:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECBA784282
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBQASlsG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WxB5qXwaqWZw; Thu, 25 May 2023 15:17:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 637FD84281;
	Thu, 25 May 2023 15:17:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 637FD84281
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 309DEC0036;
	Thu, 25 May 2023 15:17:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5C8CC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 15:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D5BE41734
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 15:17:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D5BE41734
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBQASlsG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 84kUi9YInKzI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 15:17:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE3B14116E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE3B14116E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685027863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fOUzguOOu1eni0hOPBESb2FaTGC+gEEK2fy0+NLRd2Y=;
 b=FBQASlsGG1f1Vd1vcs0VOop+s+xH8lAGj0FW+EfBjUW/5wSferXSuihxHI3db/0ZZkAzcr
 peo7RREDfNShlkmuqcpmjQnbclcZwGxgTa3VZsxDYzxy25F48cg/jrS2GOjGeWxs7QJ/Fd
 dfbpiIQJ8iCeXUrq3ySIrICy0bOU6Tg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-9z_tyNYiO3WfRXp5p0CVSQ-1; Thu, 25 May 2023 11:17:41 -0400
X-MC-Unique: 9z_tyNYiO3WfRXp5p0CVSQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5ff240197so3204845e9.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 08:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685027860; x=1687619860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOUzguOOu1eni0hOPBESb2FaTGC+gEEK2fy0+NLRd2Y=;
 b=Aul5Y5SN3RDPxVmpQpUZMYhtnE5BEPPRjFMpCTizuaouIm9iKsoEbwYqBp+tl19L9s
 qgnSuQvGwgVySTXJ2DTVX2ppjNWUzqBbVnGF8OPfY/E6G46ATuzho+1rj4L/4pYb5zDt
 /MayYvO001x2EwXEwI18QURZqPci3hL0QE9qTXFU/SwOOUAklRd+Tx7rMmy0FU6XwJVe
 7DNfZr4TLhumVidZnZgrWPp4BCKzP91EoNVer06PNbcAwbj9H7dykcg5XZpcVbuKX4IW
 PtzuElZ82D0nwJbPRssI2m+G26nEarL2frVy0SVOBhhgWubWKbU9AITmyMOAP5iJ/Ueb
 puKg==
X-Gm-Message-State: AC+VfDxPDmAtCuElWHtS4gqWA8K+4k8Enb38PMpAOjasWkny5uMRQ9PU
 IzwMVewHoHbkY5KnWmljKqh3pPslSBfwVvXjE52Dw3VTQcQtrg7YLdR20gKa2tn71hWIGUYsjvq
 t77vOG14o6+9QR/c88C2l5fqDhSQgfrXq/eB7Pusy9Q==
X-Received: by 2002:a5d:4212:0:b0:2ef:ba4f:c821 with SMTP id
 n18-20020a5d4212000000b002efba4fc821mr2822693wrq.36.1685027860655; 
 Thu, 25 May 2023 08:17:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6u2bAg+oYFeJ8M2WSKlZ3Xymkov7A3BUBv/G/uJks2LTYCIXu75pDamPUph1Z92vbUzEybCA==
X-Received: by 2002:a5d:4212:0:b0:2ef:ba4f:c821 with SMTP id
 n18-20020a5d4212000000b002efba4fc821mr2822672wrq.36.1685027860264; 
 Thu, 25 May 2023 08:17:40 -0700 (PDT)
Received: from sgarzare-redhat ([217.171.68.36])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a5d488c000000b003090cb7a9e6sm2104222wrq.31.2023.05.25.08.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 08:17:39 -0700 (PDT)
Date: Thu, 25 May 2023 17:17:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v3] virtio: Add missing documentation for structure fields
Message-ID: <xjns5ktnvejnlze6viube6qzxs4fd5fb5trpvqpip2rlrvift4@utwfddrxavxw>
References: <20230510-virtio-kdoc-v3-1-e2681ed7a425@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230510-virtio-kdoc-v3-1-e2681ed7a425@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, May 25, 2023 at 04:35:42PM +0200, Simon Horman wrote:
>Add missing documentation for the vqs_list_lock field of struct virtio_device,
>and the validate field of struct virtio_driver.
>
>./scripts/kernel-doc says:
>
> .../virtio.h:131: warning: Function parameter or member 'vqs_list_lock' not described in 'virtio_device'
> .../virtio.h:192: warning: Function parameter or member 'validate' not described in 'virtio_driver'
> 2 warnings as Errors
>
>No functional changes intended.
>
>Signed-off-by: Simon Horman <horms@kernel.org>
>---
>Changes in v3:
>- As suggested by Stefano Garzarella
>  + Drop inline comment for @vqs_list_lock which is now covered by Kdoc
>  + Add "Returns 0 or -errno." to @validate Kdoc
>- Link to v2: https://lore.kernel.org/r/20230510-virtio-kdoc-v2-1-1c5a20eb4cfe@kernel.org
>
>Changes in v2:
>- As suggested by Michael S. Tsirkin
>  + @validate is not called on probe
>  + @validate does validates config space
>  + embarrassingly, validate was misspelt
>- Link to v1: https://lore.kernel.org/r/20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org
>---
> include/linux/virtio.h | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>index b93238db94e3..de6041deee37 100644
>--- a/include/linux/virtio.h
>+++ b/include/linux/virtio.h
>@@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>  * @config_enabled: configuration change reporting enabled
>  * @config_change_pending: configuration change reported while disabled
>  * @config_lock: protects configuration change reporting
>+ * @vqs_list_lock: protects @vqs.
>  * @dev: underlying device.
>  * @id: the device type identification (used to match it with a driver).
>  * @config: the configuration ops for this device.
>@@ -117,7 +118,7 @@ struct virtio_device {
> 	bool config_enabled;
> 	bool config_change_pending;
> 	spinlock_t config_lock;
>-	spinlock_t vqs_list_lock; /* Protects VQs list access */
>+	spinlock_t vqs_list_lock;
> 	struct device dev;
> 	struct virtio_device_id id;
> 	const struct virtio_config_ops *config;
>@@ -160,6 +161,8 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
>  * @feature_table_size: number of entries in the feature table array.
>  * @feature_table_legacy: same as feature_table but when working in legacy mode.
>  * @feature_table_size_legacy: number of entries in feature table legacy array.
>+ * @validate: the function to call to validate features and config space.
>+ *            Returns 0 or -errno.
>  * @probe: the function to call when a device is found.  Returns 0 or -errno.
>  * @scan: optional function to call after successful probe; intended
>  *    for virtio-scsi to invoke a scan.
>

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
