Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDEBC433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 15:27:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9086664E24
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 15:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9086664E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4939385F93;
	Mon, 22 Feb 2021 15:27:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qx98cs1AekUA; Mon, 22 Feb 2021 15:27:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A235285F8D;
	Mon, 22 Feb 2021 15:27:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 918E3C000A;
	Mon, 22 Feb 2021 15:27:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA330C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 15:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A4ED8871F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 15:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQo-308caL+n
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 15:27:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6EC6B871F0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 15:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614007640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TXZsMYpXn71LSKrMbfU4t7gfQPTn4Ouohxtv8HpftpQ=;
 b=gdAJB3bISNjWGv+eXrlk+0UoM71OC1XPoTBjXa/pCQ1/a2jllfDOkpwqM8dbb6I1Sj6gPt
 gaEoSJlFNxqDO6XUiMjTWJivnv//zhKKslbKv/9ALA70zxPfNrR2LoEJ8VC3BtDaOMamxk
 AWvbjv0tRehfIAmjfDsJOXftZbUrBA4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-CmOXxoDeNqW__iOkpctymw-1; Mon, 22 Feb 2021 10:27:18 -0500
X-MC-Unique: CmOXxoDeNqW__iOkpctymw-1
Received: by mail-wm1-f72.google.com with SMTP id b62so5190378wmc.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 07:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TXZsMYpXn71LSKrMbfU4t7gfQPTn4Ouohxtv8HpftpQ=;
 b=VKJmQbFl0+zGZOikCl/B2965UejfFYqd0heqPG7mPbWO94/chKBiPFCh72LrjbWzNJ
 ZWtdsi56khZ4Lar3kt+MEdx1tQ/01o9s0BO36zuZ2QcbFktD/mfLmYUc8u1VXaDC4HyA
 TSgD6dAUhJVK5Wyd8oD7ZlNh/bgH2f4K3cHd0aWHVq7XGAohPJMvRxT8ZgIBzufXYRb7
 EZ0jvx7AT3nVVfdRvb4tt+YZ1D/IkezUydnXmaOke08hUCvzN7CFz3t/MQuRqM8pCwiA
 1r098WEid3vLUk8Hnhl4DzBJFjsR1jKua1ChIvv11kcRW8ZlWRobWiIzkP7PxnlvYzCX
 tnIw==
X-Gm-Message-State: AOAM531idK9huwXSa5CmWyzujOjDK8EvuC7BWM3Pcr0ntAKWf2UUi0Th
 aMGn6DsZedOOTtBwAxlETnrT+jAux+Q5XTGK7yz0EC5KoPT9LUVWvFZtk+2Xe0n7LJojJL99SiA
 786flIAZ8P+hIjtN9fo1r8YqJe4caMk4m98wmNpE+DQ==
X-Received: by 2002:adf:e444:: with SMTP id t4mr10980957wrm.97.1614007637010; 
 Mon, 22 Feb 2021 07:27:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhiINXVo9/Kl6zyPC/+Cx2AASIrpnH/QSMH0uXnxoLV5V5LDfLysUW9pHxz/qycFwCzMn7/A==
X-Received: by 2002:adf:e444:: with SMTP id t4mr10980943wrm.97.1614007636842; 
 Mon, 22 Feb 2021 07:27:16 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id a3sm1755509wrt.68.2021.02.22.07.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 07:27:16 -0800 (PST)
Date: Mon, 22 Feb 2021 16:27:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xianting Tian <xianting_tian@126.com>
Subject: Re: [PATCH] virtio: remove export for virtio_config_{enable, disable}
Message-ID: <20210222152714.jhggub3lrv7xfwju@steredhat>
References: <1613838498-8791-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
In-Reply-To: <1613838498-8791-1-git-send-email-xianting_tian@126.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: guoren@linux.alibaba.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

On Sat, Feb 20, 2021 at 11:28:18AM -0500, Xianting Tian wrote:
>virtio_config_enable(), virtio_config_disable() are only used inside
>drivers/virtio/virtio.c, so it doesn't need export the symbols.
>
>Signed-off-by: Xianting Tian <xianting_tian@126.com>
>---
> drivers/virtio/virtio.c | 6 ++----
> include/linux/virtio.h  | 2 --
> 2 files changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>index 42e09cc..4b15c00 100644
>--- a/drivers/virtio/virtio.c
>+++ b/drivers/virtio/virtio.c
>@@ -141,15 +141,14 @@ void virtio_config_changed(struct virtio_device *dev)
> }
> EXPORT_SYMBOL_GPL(virtio_config_changed);
>
>-void virtio_config_disable(struct virtio_device *dev)
>+static void virtio_config_disable(struct virtio_device *dev)
> {
> 	spin_lock_irq(&dev->config_lock);
> 	dev->config_enabled = false;
> 	spin_unlock_irq(&dev->config_lock);
> }
>-EXPORT_SYMBOL_GPL(virtio_config_disable);
>
>-void virtio_config_enable(struct virtio_device *dev)
>+static void virtio_config_enable(struct virtio_device *dev)
> {
> 	spin_lock_irq(&dev->config_lock);
> 	dev->config_enabled = true;
>@@ -158,7 +157,6 @@ void virtio_config_enable(struct virtio_device *dev)
> 	dev->config_change_pending = false;
> 	spin_unlock_irq(&dev->config_lock);
> }
>-EXPORT_SYMBOL_GPL(virtio_config_enable);
>
> void virtio_add_status(struct virtio_device *dev, unsigned int status)
> {
>diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>index 55ea329..b1894e0 100644
>--- a/include/linux/virtio.h
>+++ b/include/linux/virtio.h
>@@ -132,8 +132,6 @@ static inline struct virtio_device *dev_to_virtio(struct device *_dev)
> void virtio_break_device(struct virtio_device *dev);
>
> void virtio_config_changed(struct virtio_device *dev);
>-void virtio_config_disable(struct virtio_device *dev);
>-void virtio_config_enable(struct virtio_device *dev);
> int virtio_finalize_features(struct virtio_device *dev);
> #ifdef CONFIG_PM_SLEEP
> int virtio_device_freeze(struct virtio_device *dev);
>-- 
>1.8.3.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
