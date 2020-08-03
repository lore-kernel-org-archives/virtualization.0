Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D233C433E1
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8DC22C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnTYdDYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8DC22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F95287A72;
	Mon,  3 Aug 2020 21:00:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OjcCfB4FkGqI; Mon,  3 Aug 2020 21:00:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7C71A8782A;
	Mon,  3 Aug 2020 21:00:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 651F4C0050;
	Mon,  3 Aug 2020 21:00:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E6AAC004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0DB408656A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UMEa1zuh+YSW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 56CFC8657C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zXTzwQncFETdoKYzPm5tvIQfmxAfJtNu07ODUBYdb0E=;
 b=WnTYdDYxPKp6oAPtSzTSvnboND3Bp8Iuo/UmKGuEBfv8Zn5lh0hMwOF3n4cEnWPgB275Ah
 iclfRv4PCCEgDw6ddodkpyDFv3A6Aqucwnl8jc4umvRNe/nUeRpXIc1F5xDGvUTRPC9mmD
 xdkIASkDNccOWYN1Z0n9wA5z3clPknc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-rWFETeS0No-zhjtoLSRbNQ-1; Mon, 03 Aug 2020 17:00:11 -0400
X-MC-Unique: rWFETeS0No-zhjtoLSRbNQ-1
Received: by mail-qv1-f70.google.com with SMTP id e6so26944540qva.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 14:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zXTzwQncFETdoKYzPm5tvIQfmxAfJtNu07ODUBYdb0E=;
 b=VmDf+tcws5m4jCTOgeIi8Z7MvLlfBklYc81TzRrCbPu+wP1vObGW2D4q4krrFRsBH/
 r5SHZhaHr1I1GRCEE2kczjD2WThk9IOyi31ZtPC+a0/TTjH/3/897wXdxVZuO0Ig56yk
 nmsQx4bKNkwJFcptTzU9YZrmqHZ+GgLjMIcH4PO4K7sS5YNV6T3kABUxKaw8WFvrNNGT
 JuXYHcyZXGM2irJx871JzhO+v1JOCtvCuHtY5kC4fBDkqD0+LHAnCBjdCpP7V9K9A1Io
 06/AROOBqXQ0T2dqePqti7YmH1byDvMM7XI4c1hABT6MalPlZ/RmNKXlX5C/5HPdTxGk
 +2Qw==
X-Gm-Message-State: AOAM532YLB0AsTikUQk52kphzAtHwEZ7G9UdX1q9MYmGhHRgIc6j0RKr
 1MQXCtuxjw4WWFrbtvNf3yUZuTIQcAOGon5jwCYKlqknRNZA8OJEyL8/s5GnBHE/hP4gfw0RBAL
 9UJObvCKFy7meAhFHIThie1ZmPhOA76hdHRdN+V8nfg==
X-Received: by 2002:ac8:6f4a:: with SMTP id n10mr19336694qtv.363.1596488411243; 
 Mon, 03 Aug 2020 14:00:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsw+1IlRfJnIjdEoKs3Vv6bLSmRyUcD4mlV2rqAS2EYVV9QWgDpoODTZA6ZKFejWTRYJGpxQ==
X-Received: by 2002:ac8:6f4a:: with SMTP id n10mr19336681qtv.363.1596488411014; 
 Mon, 03 Aug 2020 14:00:11 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id a67sm14259023qkd.40.2020.08.03.14.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 14:00:10 -0700 (PDT)
Date: Mon, 3 Aug 2020 17:00:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/24] vdpa: make sure set_features in invoked for legacy
Message-ID: <20200803205814.540410-20-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
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

Some legacy guests just assume features are 0 after reset.
We detect that config space is accessed before features are
set and set features to 0 automatically.
Note: some legacy guests might not even access config space, if this is
reported in the field we might need to catch a kick to handle these.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa.c  |  1 +
 include/linux/vdpa.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index de211ef3738c..7105265e4793 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -96,6 +96,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	vdev->dev.release = vdpa_release_dev;
 	vdev->index = err;
 	vdev->config = config;
+	vdev->features_valid = false;
 
 	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
 	if (err)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 239db794357c..29b8296f1414 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -33,12 +33,14 @@ struct vdpa_notification_area {
  * @dma_dev: the actual device that is performing DMA
  * @config: the configuration ops for this device.
  * @index: device index
+ * @features_valid: were features initialized? for legacy guests
  */
 struct vdpa_device {
 	struct device dev;
 	struct device *dma_dev;
 	const struct vdpa_config_ops *config;
 	unsigned int index;
+	bool features_valid;
 };
 
 /**
@@ -266,4 +268,36 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 {
 	return vdev->dma_dev;
 }
+
+static inline void vdpa_reset(struct vdpa_device *vdev)
+{
+        const struct vdpa_config_ops *ops = vdev->config;
+
+	vdev->features_valid = false;
+        ops->set_status(vdev, 0);
+}
+
+static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
+{
+        const struct vdpa_config_ops *ops = vdev->config;
+
+	vdev->features_valid = true;
+        return ops->set_features(vdev, features);
+}
+
+
+static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
+				   void *buf, unsigned int len)
+{
+        const struct vdpa_config_ops *ops = vdev->config;
+
+	/*
+	 * Config accesses aren't supposed to trigger before features are set.
+	 * If it does happen we assume a legacy guest.
+	 */
+	if (!vdev->features_valid)
+		vdpa_set_features(vdev, 0);
+	ops->get_config(vdev, offset, buf, len);
+}
+
 #endif /* _LINUX_VDPA_H */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
