Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB66C433EF
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 19:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78448402D1;
	Fri, 14 Jan 2022 19:57:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z2fhvkcKsy-V; Fri, 14 Jan 2022 19:57:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C07441574;
	Fri, 14 Jan 2022 19:57:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E426AC002F;
	Fri, 14 Jan 2022 19:57:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 367C4C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 19:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E09241583
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 19:57:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lP657seLQg6W
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 19:57:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA78341574
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642190242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=jBT/nNeSa+Ii/P6rldCEBEg5crRoFIcXmmoQTy71T4A=;
 b=EwvQNmFefyXVQYIA2J7yXYTKBlrVAw5ZV5QnLcc7RxuAGs586S3JtAHNv0BvYCB5IeODJ2
 ato4lWW/ETcQSivKn+RCtyfbZiYIVZRRHRkt3lUHViv/Q6Vs77qomjTX3WUi42RDZb6L9T
 T9he2cv0+qmswMgGh/K9dCaRrnu5dPk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-C_-jl74oOPe8IvLu4TVvtg-1; Fri, 14 Jan 2022 14:57:21 -0500
X-MC-Unique: C_-jl74oOPe8IvLu4TVvtg-1
Received: by mail-ed1-f71.google.com with SMTP id
 l10-20020a056402124a00b0040186fbe40dso466847edw.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 11:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=jBT/nNeSa+Ii/P6rldCEBEg5crRoFIcXmmoQTy71T4A=;
 b=T5lxypxG7LoudqwLDv58UDMemXhh67PVg6XALpWOh84JiycTKMRiHT06VA2CZm1GTl
 kKzFOW5lbSGK4w+VAUPoGg2sCLydokSDs6gOx6LFyy/5Jk7GqtTE2E1ORJRhh45vZpJb
 wctD/+/lT/1TVWNvyiH9/mIDzDXC4eVKcbjrDCAaJbQWd4V0R2BonH/dOsb/vcwSUQ0X
 wF1OdDJoSI/MKSTSOFOh9yRSro0ebrWTzVqrpGNtvvCg5hZEoNPy3Nq26Fgp3WmF8ASS
 CowyH7w/xQg96+JKpWsAIcbLd1kMl3Zl6MBhw+Jxb+7dm8SaG2RJL0CHFUh8+2E7Qyml
 SImQ==
X-Gm-Message-State: AOAM531oSsbYfIZXQLbRo3S7LxVTXuHXYFOO/R6+uHNQC9kBEoDvtAcX
 iFwQxnvA2OEJpaeb7gP9QZwcKYOvgChpjzlHc6tOR6hdIdpYx86+ljE0g9HcF+Pj31CaoiL46ND
 XoQdEkI3BcqkySrG1Ia+ZbGlbpTlBDvHMcXZpSXfFSA==
X-Received: by 2002:a05:6402:27d1:: with SMTP id
 c17mr10169356ede.128.1642190240047; 
 Fri, 14 Jan 2022 11:57:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkD8j7cTwK4rTOGXJcnDS2Znn/r1A0C96Nzycv1PW0gtcGx4Q/58wmzs1emQigbpUXzSB24w==
X-Received: by 2002:a05:6402:27d1:: with SMTP id
 c17mr10169348ede.128.1642190239850; 
 Fri, 14 Jan 2022 11:57:19 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id c19sm2688490ede.47.2022.01.14.11.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 11:57:19 -0800 (PST)
Date: Fri, 14 Jan 2022 14:57:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: unexport virtio_finalize_features
Message-ID: <20220114195710.149933-1-mst@redhat.com>
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

virtio_finalize_features is only used internally within virtio.
No reason to export it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 3 +--
 include/linux/virtio.h  | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 00ac9db792a4..d891b0a354b0 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -166,7 +166,7 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
-int virtio_finalize_features(struct virtio_device *dev)
+static int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
 	unsigned status;
@@ -202,7 +202,6 @@ int virtio_finalize_features(struct virtio_device *dev)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(virtio_finalize_features);
 
 void virtio_reset_device(struct virtio_device *dev)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 72292a62cd90..5464f398912a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -133,7 +133,6 @@ bool is_virtio_device(struct device *dev);
 void virtio_break_device(struct virtio_device *dev);
 
 void virtio_config_changed(struct virtio_device *dev);
-int virtio_finalize_features(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
