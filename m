Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB2DC4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 06:11:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DD260F02
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 06:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19DD260F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD2A640476;
	Fri, 23 Jul 2021 06:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0DRDfZ_Oyo4s; Fri, 23 Jul 2021 06:11:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 23BD240272;
	Fri, 23 Jul 2021 06:11:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFD6CC0010;
	Fri, 23 Jul 2021 06:11:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1A7BC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 06:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9A5782F41
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 06:11:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bJaIGrCQzztz
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 06:11:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F7CF82EA1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 06:11:37 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 gv20-20020a17090b11d4b0290173b9578f1cso5448616pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BPDQ2kVL0UdvRLtrnYW5IaWsLJTP3znWjR1im+Y6laM=;
 b=RvwcrzV5uqh1+tuqehkGGlROHKEcLre8WM6HULfyzeNhzxZS3xa0TDvLo7rqbPwM8f
 6/TmZMCTk98uBL6PRA4fWEKrT4kWSWdVo1EPXell3eibaPvYB5BGl4ElmL5zV4q5GNgU
 Y4hGXuo+FyXcm97D5To7/8AklWcrz0VLt48wF95DChUyC0JY90o/B8U+erPmvFpKZqFe
 rBR8al5p7HUYanfJjWxwmU0Uq6k25KOl75QP/F9TfMB+CFNa4rn7Ne+I2VLKgiPCbizA
 G4T2Ju6JCVrO65waa3hCnRMGfpZr6F0GJ5B3F2g/g+LGRxCmGvoV9TEJ5C0O/wvP9x3a
 Vl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BPDQ2kVL0UdvRLtrnYW5IaWsLJTP3znWjR1im+Y6laM=;
 b=oIn6UrNMdRtqnrx8RYoklDnJvOTj/KXMw9J3YiMH+37qDVLfkjH2uiQBcV6R/I0kfJ
 0FMJ9yOUN5T+BYaRQ0NufrSV7ZklYY8zFZculxvzNSidr7SHMwlb5QNJzWNMwN5QO9xh
 UdMSpmSvU2xC3EpKnuR6djBLnoDrvlXaefd1uqzoas2PK+4E7Up6ifmTNotNGh4Pl488
 yKMh+l1m3CkQkq7sEs1jsy4GE5IiqqWDXHY2d9tkSErZdTSpg2pfeWwpHmijZWt1gAnJ
 MpFVJdfesAd+c47G72v+0UelQKzUC6sqUuoM0ZHpuKfAk9tGcQ+j93myTkNfJA2XgDmI
 Vi2g==
X-Gm-Message-State: AOAM5304UGaxNJ9xU3DiYsj6hlbdw3hDTw5ZWDL/ssdth86R6c+75Q6p
 Ta4hTyzJFug3SFhgxoRqkLCDow==
X-Google-Smtp-Source: ABdhPJySZza7P56XmnuJ3Cil+h7yPhUfS2othNjGYfb7MFSL04v38Aiyv3G2haUnbVxgIAr6POQIzA==
X-Received: by 2002:a17:90a:c57:: with SMTP id
 u23mr843021pje.186.1627020697200; 
 Thu, 22 Jul 2021 23:11:37 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id ie13sm4902106pjb.45.2021.07.22.23.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 23:11:35 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH V2.1 5/5] virtio: Bind virtio device to device-tree node
Date: Fri, 23 Jul 2021 11:41:31 +0530
Message-Id: <3606cdcc637682a3eb401d617e6e247431b78ec6.1627019436.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <026ad5f274d64d46590623f9f3a04b8abfbe62d7.1626947324.git.viresh.kumar@linaro.org>
References: <026ad5f274d64d46590623f9f3a04b8abfbe62d7.1626947324.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Vincent Guittot <vincent.guittot@linaro.org>, devicetree@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Bind the virtio devices with their of_node. This will help users of the
virtio devices to mention their dependencies on the device in the DT
itself. Like GPIO pin users can use the phandle of the device node, or
the node may contain more subnodes to add i2c or spi eeproms and other
users.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V2.1
- Remove list of virtio device and use of_device_is_compatible() instead.

 drivers/virtio/virtio.c | 56 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..7c56b3416895 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -4,6 +4,7 @@
 #include <linux/virtio_config.h>
 #include <linux/module.h>
 #include <linux/idr.h>
+#include <linux/of.h>
 #include <uapi/linux/virtio_ids.h>
 
 /* Unique numbering for virtio devices. */
@@ -292,6 +293,9 @@ static int virtio_dev_remove(struct device *_d)
 
 	/* Acknowledge the device's existence again. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
+
+	of_node_put(dev->dev.of_node);
+
 	return 0;
 }
 
@@ -319,6 +323,42 @@ void unregister_virtio_driver(struct virtio_driver *driver)
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_driver);
 
+static int virtio_device_of_init(struct virtio_device *dev)
+{
+	struct device_node *np, *pnode = dev->dev.parent->of_node;
+	int ret, count;
+	char compat[12];
+
+	if (!pnode)
+		return 0;
+
+	count = of_get_available_child_count(pnode);
+	if (!count)
+		return 0;
+
+	/* There can be only 1 child node */
+	if (WARN_ON(count > 1))
+		return -EINVAL;
+
+	np = of_get_next_available_child(pnode, NULL);
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	snprintf(compat, sizeof(compat), "virtio,%x", dev->id.device);
+
+	if (!of_device_is_compatible(np, compat)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dev->dev.of_node = np;
+	return 0;
+
+out:
+	of_node_put(np);
+	return ret;
+}
+
 /**
  * register_virtio_device - register virtio device
  * @dev        : virtio device to be registered
@@ -343,6 +383,10 @@ int register_virtio_device(struct virtio_device *dev)
 	dev->index = err;
 	dev_set_name(&dev->dev, "virtio%u", dev->index);
 
+	err = virtio_device_of_init(dev);
+	if (err)
+		goto out_ida_remove;
+
 	spin_lock_init(&dev->config_lock);
 	dev->config_enabled = false;
 	dev->config_change_pending = false;
@@ -362,10 +406,16 @@ int register_virtio_device(struct virtio_device *dev)
 	 */
 	err = device_add(&dev->dev);
 	if (err)
-		ida_simple_remove(&virtio_index_ida, dev->index);
+		goto out_of_node_put;
+
+	return 0;
+
+out_of_node_put:
+	of_node_put(dev->dev.of_node);
+out_ida_remove:
+	ida_simple_remove(&virtio_index_ida, dev->index);
 out:
-	if (err)
-		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
 	return err;
 }
 EXPORT_SYMBOL_GPL(register_virtio_device);
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
