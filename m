Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD793C43334
	for <virtualization@archiver.kernel.org>; Mon, 20 Jun 2022 08:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 37BAC40AD7;
	Mon, 20 Jun 2022 08:49:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37BAC40AD7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cfqhyHgG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpIHIJ-zvRIe; Mon, 20 Jun 2022 08:49:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D62DF40AD0;
	Mon, 20 Jun 2022 08:49:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D62DF40AD0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD22FC0032;
	Mon, 20 Jun 2022 08:49:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5663DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23448831E3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:49:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23448831E3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cfqhyHgG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q5u7aqJaQGhd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:49:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CC56831A9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CC56831A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655714966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lSi9UTj5bNQNadCcaLjxqTxQzNSJdNW8P+mf6Ts+LLM=;
 b=cfqhyHgGFAE+UooIz5MHPI7hpdMG9DccUbzXjr8A9NNnKPZuzPWEUCPzutEoQ4O8C1+s8D
 i01pOrHPT2XpYOrFBVlgeHOajmVYr3uDBsxfs/m6+Gsfzrzq5MmPmyXBGoFezDahuxeK1d
 3vlcgXVjkzFR/iVd3cd/nNW8eNSFy2c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-bdcuyZQaM8WItK7IxM5ylA-1; Mon, 20 Jun 2022 04:49:25 -0400
X-MC-Unique: bdcuyZQaM8WItK7IxM5ylA-1
Received: by mail-qk1-f198.google.com with SMTP id
 bm2-20020a05620a198200b006a5dac37fa2so12371381qkb.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 01:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lSi9UTj5bNQNadCcaLjxqTxQzNSJdNW8P+mf6Ts+LLM=;
 b=rwpHn/T/8k/Y7jqCL4oeZKgl1zfg66VKwFpPnEjgehbFDzx17C32BTZbrik1Zf/qgF
 bQaN8J4cTUaq8ta/h76/5iuooCk3sbQFWvsWd4sRqE301ebERJiA0xOrF2X4p4cosVhQ
 TOYoue9tsknDVyV83q25/M458o8KBiw9VAQbwefmJMEfhHKUQTVeyIV9BKlFIVLfKEDd
 bwjZkXOCHESRQkTiEJ+Sf6tZjWX0PtnH64ziFzs2jVIcn5IqHdUNf8zCaCXG6n7ieTZN
 JfZjWy3iJluj6psIndt9Z8XiCnVf6AVHpD7yesPItdz6HC669yoef3mDyv/20MNu5DFy
 ZUWg==
X-Gm-Message-State: AJIora/pQW/aun+uoNBFQuUI9kC7Tcoznabq9WHwiCIfc6UYYGokR0Zz
 u9FB2IHA7kAREx7Kb93Pm2NXyHex+9mB4WJfJPBfTyxvyiZXl6QrLWYSNe/e9qf5SxSXV45w1Bx
 KSoIxEhafwdWwLgDy+XL+/1NmQ0jCqdNI0wV2hlqnMQ==
X-Received: by 2002:a37:a5d3:0:b0:6a6:87cc:202c with SMTP id
 o202-20020a37a5d3000000b006a687cc202cmr14962948qke.732.1655714964739; 
 Mon, 20 Jun 2022 01:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ukLXJ0hiAf3fLsl8d/IHt8LkeC8/B5yxiWUk2MoMKqvnjnha/BmfyLZXLNqtA0PTIQ1uB4tw==
X-Received: by 2002:a37:a5d3:0:b0:6a6:87cc:202c with SMTP id
 o202-20020a37a5d3000000b006a687cc202cmr14962939qke.732.1655714964530; 
 Mon, 20 Jun 2022 01:49:24 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 h20-20020a05620a245400b006a6b374d8bbsm12929220qkn.69.2022.06.20.01.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 01:49:23 -0700 (PDT)
Date: Mon, 20 Jun 2022 10:49:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH] virtio: Remove unnecessary variable assignments
Message-ID: <20220620084917.uroobx2dptpade3t@sgarzare-redhat>
References: <20220617055952.5364-1-liubo03@inspur.com>
MIME-Version: 1.0
In-Reply-To: <20220617055952.5364-1-liubo03@inspur.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Fri, Jun 17, 2022 at 01:59:52AM -0400, Bo Liu wrote:
>In function vp_modern_probe(), "mdev->pci_dev" is assigned to
>variable "pci_dev", variable "pci_dev" and "mdev->pci_dev" have
>the same value. There is no need to assign variable "pci_dev" to
>"mdev->pci_dev". So remove it.
>

I suggest rephrasing the description a bit.
Maybe into something like this:

     In function vp_modern_probe(), "pci_dev" is initialized with the
     value of "mdev->pci_dev", so assigning "pci_dev" to "mdev->pci_dev"
     is unnecessary since they store the same value.

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>Signed-off-by: Bo Liu <liubo03@inspur.com>
>---
> drivers/virtio/virtio_pci_modern_dev.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>index b790f30b2b56..fa2a9445bb18 100644
>--- a/drivers/virtio/virtio_pci_modern_dev.c
>+++ b/drivers/virtio/virtio_pci_modern_dev.c
>@@ -220,8 +220,6 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>
> 	check_offsets();
>
>-	mdev->pci_dev = pci_dev;
>-
> 	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
> 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
> 		return -ENODEV;
>-- 
>2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
