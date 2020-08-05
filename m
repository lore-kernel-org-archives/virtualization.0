Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D75C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D982065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFKcUIC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D982065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7DAD6226A0;
	Wed,  5 Aug 2020 13:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6ZBIaLYifao; Wed,  5 Aug 2020 13:44:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 04D4522660;
	Wed,  5 Aug 2020 13:44:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D92F1C0051;
	Wed,  5 Aug 2020 13:44:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA177C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D692520BF8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0tvxNFhj8XAB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 1370B226A0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zXTzwQncFETdoKYzPm5tvIQfmxAfJtNu07ODUBYdb0E=;
 b=RFKcUIC3DwE45aTNcYbJ0m3/A4eyEmgiRPxHAJbb4DoVjf8xYk8Ie/ngRgjev0h9pEZzdD
 yxkFnYyoe5ibwYScN4vNhicVv3Nt08WCCO3Ehw4nmiQGYz4gusxu4a9wS2f7pqAXtOF7K+
 C99QFF4sJeBXOIVYSWtj5dNPx8v/nHE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-9PICJM6cNmG11Qbzz7lrPg-1; Wed, 05 Aug 2020 09:44:11 -0400
X-MC-Unique: 9PICJM6cNmG11Qbzz7lrPg-1
Received: by mail-wr1-f72.google.com with SMTP id w7so13646099wrt.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zXTzwQncFETdoKYzPm5tvIQfmxAfJtNu07ODUBYdb0E=;
 b=gmnQGvs6yXqWyDGAD9lK0C0Eg6QO+zi6rPD0plTgx1erJH+sQvA1j4/VqE525Y3pOD
 ZImVKmVfQ0A1E8ftwlftk3aC/BXJObGpEHq+icasR6dn9CaXpcMC4kLTS52HlQfCCw79
 XOozGWgPn24UH9fDfWSQG1/OTnE818ydZU0GZfiOxSQW0+bphxpErb0jtzGGfjvOF6ao
 JkIkzglrz2e2B3J691ghG5c5H8FtoZ+M850wckAYnUKCp86dhorUhQrdd7Y+pPGFVJB5
 lOsT8phbi3yxfbKkXH/0SJqMZVVvZdAG0NptBzOtH2IvzaGF0AObvDCPZwhbCswSMn50
 FPgg==
X-Gm-Message-State: AOAM532B6/b27IR3KiUm0LSq0b0l4GdU1V+qRQgx80Sicp5XIoV6Eg/A
 PBLwH/vCVFr12OEzGFvRCa+WdtJREZnRQp1P2NlNvtl2jIIwuZbnPaZTUvWEmzzSXqmDLYo9PeH
 CH7r9akGtb0rrVMY2R7+t1d9wVNkEzYcWknZQBRwL8Q==
X-Received: by 2002:adf:ebc5:: with SMTP id v5mr2874753wrn.100.1596635050288; 
 Wed, 05 Aug 2020 06:44:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN15n3nk3moRyvVlKfo0eUXQqSTsa3wGWLzNDiCq5dlFLmjNv9TM2NLycLh5wHgFYsktf9nw==
X-Received: by 2002:adf:ebc5:: with SMTP id v5mr2874729wrn.100.1596635049955; 
 Wed, 05 Aug 2020 06:44:09 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 l11sm2746431wme.11.2020.08.05.06.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:09 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/38] vdpa: make sure set_features is invoked for legacy
Message-ID: <20200805134226.1106164-20-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
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
