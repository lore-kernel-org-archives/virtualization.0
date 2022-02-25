Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89198C433F5
	for <virtualization@archiver.kernel.org>; Fri, 25 Feb 2022 11:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1093C80C44;
	Fri, 25 Feb 2022 11:48:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2rlydYpdjHn7; Fri, 25 Feb 2022 11:48:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B3FBD80BAB;
	Fri, 25 Feb 2022 11:48:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 866E2C0033;
	Fri, 25 Feb 2022 11:48:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6115C001A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 11:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2C5640475
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 11:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3KObFgmOw-hQ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 11:48:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B7554011B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 11:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645789731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=scWxKg4GU2Bc5BNOef08NlM2V9Xj4Fo3ABvGq3MHV14=;
 b=Dt4EoMNkuryhqdo/VUaOWuG7VKitZ+9Fh5dsvsJ4v7ZnLJog+WG/SkyViSb85n03Dg6yaW
 qNt9PP4BBkOWsyrORMy4WbESRQ5miEsDQhU0KxclxBObXJFpV/aFNCI4G/AAByS+eqhItb
 1E5sMDxSkIg33MtHPqxXvRf/2pw+31k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-I7TyjK8FOt-rzHAev9R7UQ-1; Fri, 25 Feb 2022 06:48:50 -0500
X-MC-Unique: I7TyjK8FOt-rzHAev9R7UQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 7-20020a1c1907000000b003471d9bbe8dso2405899wmz.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 03:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=scWxKg4GU2Bc5BNOef08NlM2V9Xj4Fo3ABvGq3MHV14=;
 b=l83pB1CkYtT3L5iPuynsUDqv9HTctRq7w+393MxIUsOOPCS4yrgH1vtomcmYH+fd8b
 Xa21Wa5+KeuqDrXWn2ce3a52fmGRHg3pBJJodYn0Jq0SQoF7D6yJMNUT8mSm2UfUVTh5
 nq2HUdwDEEgV5XtVC/3VMitzIPJh0r+yiwyX2dNvUsLldcdyl3rdSu/GL3w4ib3Z++66
 RC70noVldvT9s+gQR4J20gEdsT0C4u90xSZcIYXOv68t1KKhhVHhWYrFgyn5Pu1oJWLv
 GyeFynM3ixK1DNlxpSnCeJ786TuQR4zl2Dw86Mu69Iv3rQ/IFrkXH4qhAoanQst5BWzd
 /5mw==
X-Gm-Message-State: AOAM5326OQZ99CNqHBs0e57paXeVtSZ9pnIIiHqFHd67wkK50Yh0NrlZ
 zm2gannVMXNRMJCtLSO/buypWr/Zl4jHuHgC8uZbyg10Fyh3Rw5kdSwwmcl4y2tNLYxCnipxcqP
 Sm8gx4zA6RV7MEXLL1OY1haN/s3J4nXPjRXSIv/4jxA==
X-Received: by 2002:a5d:5887:0:b0:1d7:36e4:e40f with SMTP id
 n7-20020a5d5887000000b001d736e4e40fmr5963318wrf.298.1645789728939; 
 Fri, 25 Feb 2022 03:48:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwu1fG1N/2AZ+M3s346bFKeHxAClPaPazs6BuiKvazV+7Ij8KAG57M+nTgR/+3dBEb+ML0KZw==
X-Received: by 2002:a5d:5887:0:b0:1d7:36e4:e40f with SMTP id
 n7-20020a5d5887000000b001d736e4e40fmr5963302wrf.298.1645789728723; 
 Fri, 25 Feb 2022 03:48:48 -0800 (PST)
Received: from redhat.com ([2.55.145.157]) by smtp.gmail.com with ESMTPSA id
 f4-20020a5d4dc4000000b001d8e67e5214sm2122519wru.48.2022.02.25.03.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Feb 2022 03:48:47 -0800 (PST)
Date: Fri, 25 Feb 2022 06:48:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: drop default for virtio-mem
Message-ID: <20220225114801.47348-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

There's no special reason why virtio-mem needs a default that's
different from what kconfig provides, any more than e.g. virtio blk.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 34f80b7a8a64..492fc26f0b65 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -105,7 +105,6 @@ config VIRTIO_BALLOON
 
 config VIRTIO_MEM
 	tristate "Virtio mem driver"
-	default m
 	depends on X86_64
 	depends on VIRTIO
 	depends on MEMORY_HOTPLUG
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
