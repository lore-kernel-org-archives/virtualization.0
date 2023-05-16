Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC0BC77B7A
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 08:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4268182157;
	Tue, 16 May 2023 08:55:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4268182157
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DtxVaZr0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UjCVm1Vcf6rH; Tue, 16 May 2023 08:55:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BE0F88206F;
	Tue, 16 May 2023 08:55:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE0F88206F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0315C0036;
	Tue, 16 May 2023 08:55:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96C87C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 08:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6396360706
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 08:55:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6396360706
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DtxVaZr0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGFgfKecci9q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 08:55:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F829605A2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F829605A2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684227298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eq/mJ6TAAxJjl7zNrtuDiAJaf9k+xodjW5Fgf6CgBUc=;
 b=DtxVaZr0deycyarEDp0PcEr6G6xnrQl76vdrBaBRWgQfZMeK3/1vuiyMSae2smOCMd228t
 PudpRtt34mxf/uVayL+qxjf9LFQxdsvmkLqpBEJZMJG2GA+YoKJN/PZ/koT5BKZCeTR/cm
 sbXTybw6TW32Kr649ay1ja3A9rz7VyI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-1uxR9rwiPJ6JsW5OEbobtA-1; Tue, 16 May 2023 04:54:57 -0400
X-MC-Unique: 1uxR9rwiPJ6JsW5OEbobtA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7582a35bbf8so1036173885a.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 01:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684227296; x=1686819296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eq/mJ6TAAxJjl7zNrtuDiAJaf9k+xodjW5Fgf6CgBUc=;
 b=TzgoR59vccYhweU4RS8iBBXoexZV8cN4xCag+lGfqJkDELYoaECSAEfEW6CyclhIpd
 vmQ3tGBCUpydprNrNCrCT8uM2LLaImq6NyI+a/vLnF9muPCmd+Ot9+BQHLJ0Jmi7xG6C
 1gQGz6cAz79OP8diN1X+iMSQpbnxbQNsqQp4X+j0JZZMGXuHAQcf9C3auVpOukxWujXE
 ZEhY/DIAFoL4cS98OJ7Zpk6c5ZHfEn0IjqSnfz1e2LA/Enlavt85CG/iA84Nt5Yn4ypR
 +0zQ6GNh6QmKaE+IyvxSdbbYWkjiRKqTjzlv/kRKpW6wRZpMFAqhGTqAPKYYDXqbkUnt
 sIWQ==
X-Gm-Message-State: AC+VfDy3vwb/yA//wqOd5CoBMjdr0aXiru/K2CFDPFzbYHdRf+BSe8en
 B/mR8HjeAr+c0mrbFbdbUpAj3FF2CU37dwA4Kt7htZyl+q39M+X9uJbBpllsm9j89yJ9RIZWg9V
 CfrKtJ7+duyDz6ain2gNopQhmf1ufjRYhdCFaLQhjzg==
X-Received: by 2002:a05:622a:1209:b0:3ef:2649:44ae with SMTP id
 y9-20020a05622a120900b003ef264944aemr58730395qtx.13.1684227296805; 
 Tue, 16 May 2023 01:54:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5D9o1sGj4fhdU2O4/61znCNopICXE8BhGEHjhbqI5WM+IEL+ulBtWf2tSFOkkGS6Bw6+fuOw==
X-Received: by 2002:a05:622a:1209:b0:3ef:2649:44ae with SMTP id
 y9-20020a05622a120900b003ef264944aemr58730380qtx.13.1684227296564; 
 Tue, 16 May 2023 01:54:56 -0700 (PDT)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a05622a148e00b003f549b8b7d6sm24436qtx.68.2023.05.16.01.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 01:54:56 -0700 (PDT)
Date: Tue, 16 May 2023 10:54:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2] virtio: Add missing documentation for structure fields
Message-ID: <y6kgnwu35oci7y5hx2htfobglrecjhxgpnqmtjetv52xk7hlsc@gwvfoojunl4x>
References: <20230510-virtio-kdoc-v2-1-1c5a20eb4cfe@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230510-virtio-kdoc-v2-1-1c5a20eb4cfe@kernel.org>
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

On Thu, May 11, 2023 at 04:46:22PM +0200, Simon Horman wrote:
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
>Changes in v2:
>- As suggested by Michael S. Tsirkin
>  + @validate is not called on probe
>  + @validate does validates config space
>  + embarrassingly, validate was misspelt
>- Link to v1: https://lore.kernel.org/r/20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org
>---
> include/linux/virtio.h | 2 ++
> 1 file changed, 2 insertions(+)

I left some minor comments, anyway this version LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>index b93238db94e3..3abe8e9c8090 100644
>--- a/include/linux/virtio.h
>+++ b/include/linux/virtio.h
>@@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>  * @config_enabled: configuration change reporting enabled
>  * @config_change_pending: configuration change reported while disabled
>  * @config_lock: protects configuration change reporting
>+ * @vqs_list_lock: protects @vqs.

Maybe we can now remove `/* Protects VQs list access */`

>  * @dev: underlying device.
>  * @id: the device type identification (used to match it with a driver).
>  * @config: the configuration ops for this device.
>@@ -160,6 +161,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
>  * @feature_table_size: number of entries in the feature table array.
>  * @feature_table_legacy: same as feature_table but when working in legacy mode.
>  * @feature_table_size_legacy: number of entries in feature table legacy array.
>+ * @validate: the function to call to validate features and config space

Maybe we can add ". Returns 0 or -errno."

Thanks,
Stefano

>  * @probe: the function to call when a device is found.  Returns 0 or -errno.
>  * @scan: optional function to call after successful probe; intended
>  *    for virtio-scsi to invoke a scan.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
