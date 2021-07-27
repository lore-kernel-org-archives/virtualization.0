Return-Path: <SRS0=8N1b=MT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C193DC4338F
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 05:24:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C57610D0
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 05:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88C57610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A21183834;
	Tue, 27 Jul 2021 05:24:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HIIsu9H7R5pq; Tue, 27 Jul 2021 05:24:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 06F52837B6;
	Tue, 27 Jul 2021 05:24:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4453C0010;
	Tue, 27 Jul 2021 05:24:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86B3CC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8282E404BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6tR9mhN0cOFs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67BE3404B8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:34 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 o44-20020a17090a0a2fb0290176ca3e5a2fso3296573pjo.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 22:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2bReu9/QiDlixJ/zUrMpF+Tdh8nXeZ2MTWODegeEltE=;
 b=sguymNCUwJvY2Vm/IznufncDBF3sjETSlEYR+vj6oJ+UM67MLBhMqFWHk4mxJ2PsSK
 5b/s7cah1FqzNg7kC19ikh307/G6HXGV6vMozb6gQ9Ivrinas5A5uGFE+gYR4y+sp8CP
 ooRPiSyF+J/ZHTpxuhxzjHDtCtY6Ig6pMCAsZA77tabFVO9u5bZFxnaz0DMP43yxUwc0
 BsPvx34ZEDZ4sn9IAvNFCcHSOMaiylMSvxoU6OsQqf64kvFfB6/cJZ/Wc6nZS8In21fJ
 Il3PEhvnL7Rv74YUjSqCJQU+77wRAcE34sRn7mrHM27QxxrNB5RZ77Q1OyKTtOWvxq+T
 z91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2bReu9/QiDlixJ/zUrMpF+Tdh8nXeZ2MTWODegeEltE=;
 b=ItHlRFqA4Zzr6PKzSQGVQsOPqXf50sNyyQJzj/hFpV3I1q56iM9brHeA995MW8URsc
 CzC+O1WoX4ba8YOWWyOZherUG8gucMR6WlG8x6QxbwQuEpEoTugpCQGmlISgcM6ypAlm
 P7v1IaTzBno0r4fbpZpy9RLCT+/OLsLrq/0eJPWBzKTaMBJZYDSwuty032tBQEw6FvVT
 RYV6aaEfkyjNCMYihFyFO0cgKvk02LhQfdChR5TXhqQvPvC1Tv0s80RdPxMEe7bBjYui
 TLFV0eSJcaCPdzA0/hlweR0qVograuBGUl9sY2LMCvnwWvf2e6r/BtfBOudKI3VFsSGP
 Oqzg==
X-Gm-Message-State: AOAM533/E3aXJCT2GK2804cP9d/y91irUOJOQ+PSwjYnos70F4TjiPrC
 Y5WIXab2CYielGLnBPe1jZ5mJ87G2cwgJg==
X-Google-Smtp-Source: ABdhPJy6I9aeK/9Rc3UXH2kpfbIZFK/LBxRNWnIHopkBRg9v94YtfYYGkl2/6Qm2SBVK8JZ5lLhYiQ==
X-Received: by 2002:a17:90a:86:: with SMTP id a6mr2447703pja.133.1627363473907; 
 Mon, 26 Jul 2021 22:24:33 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id b9sm1857444pfm.124.2021.07.26.22.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 22:24:28 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH V4 5/5] virtio: Bind virtio device to device-tree node
Date: Tue, 27 Jul 2021 10:53:52 +0530
Message-Id: <94c12705602929968477aaf27e02439eb7a7f253.1627362340.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627362340.git.viresh.kumar@linaro.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, linux-kernel@vger.kernel.org,
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

Bind the virtio devices with their of_node. This will help users of the
virtio devices to mention their dependencies on the device in the DT
itself. Like GPIO pin users can use the phandle of the device node, or
the node may contain more subnodes to add i2c or spi eeproms and other
users.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/virtio/virtio.c | 57 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..5f80786c2aa2 100644
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
 
@@ -319,6 +323,43 @@ void unregister_virtio_driver(struct virtio_driver *driver)
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_driver);
 
+static int virtio_device_of_init(struct virtio_device *dev)
+{
+	struct device_node *np, *pnode = dev_of_node(dev->dev.parent);
+	char compat[] = "virtio,deviceXXXXXXXX";
+	int ret, count;
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
+	ret = snprintf(compat, sizeof(compat), "virtio,device%x", dev->id.device);
+	BUG_ON(ret >= sizeof(compat));
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
@@ -343,6 +384,10 @@ int register_virtio_device(struct virtio_device *dev)
 	dev->index = err;
 	dev_set_name(&dev->dev, "virtio%u", dev->index);
 
+	err = virtio_device_of_init(dev);
+	if (err)
+		goto out_ida_remove;
+
 	spin_lock_init(&dev->config_lock);
 	dev->config_enabled = false;
 	dev->config_change_pending = false;
@@ -362,10 +407,16 @@ int register_virtio_device(struct virtio_device *dev)
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
