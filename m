Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2053EC63793
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:57:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D318561248
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D318561248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DAFB405B6;
	Thu, 22 Jul 2021 09:57:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lhNyn1HZ4WL9; Thu, 22 Jul 2021 09:57:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1DEE2405B2;
	Thu, 22 Jul 2021 09:57:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC05BC0010;
	Thu, 22 Jul 2021 09:57:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF943C0010
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91C6B4026B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:57:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lKWnzTM2SY4E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:57:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0232940109
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:57:03 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 nt18-20020a17090b2492b02901765d605e14so3767484pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zqCgE34yKyEIxvuJmPDWwVVxXXN+22OEi5ENUvJ8OeA=;
 b=oNd9MyfvR0nYVTjrW1t93WrZmnXFXN7AAJDIlU2Ob6ZsJ6AU3uISvEzFldVwS/MN9y
 T+lAXUsG6wseU6YsEN069LVRTMg2F+luTvrzDcO6ABMJee/zl4OVlVUjIxOw3AKPXCVK
 7aV8DcMDgsVAgTuP+HGVtzfa1qTbErhmDrgwIiELLIroBKiMtJlnjJYkcQBlQ3wbCB9x
 9SCcjQZhUu+w+qSF1F5GNFSwX+ny4kwes2xQbcFfKHhotxKM/Nq9JMYodrgOaFYlb8Ik
 jERO1a1rAdxXN9yAyjOamz+lXVVqJkBTLTcEyh26w+pWL1N1SH/IbLS3ggA6HRd6N7WI
 fTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zqCgE34yKyEIxvuJmPDWwVVxXXN+22OEi5ENUvJ8OeA=;
 b=lAuL0YnBcMUb9F6fR9qY9YW1qLQrMan9lsfihyfUdRDn89R+L6AaA+HoyUuVjX+e16
 DDHQ9RQkvPMEqDaoOX2zjFBtc93nO2nDJmfYZB4N6pPGn5LJ4mt2Ofs7GwR1uPOEkAeb
 f9dm7hVr4PWeY0ARoPSK+S+J6MOeH8nMoGDKLPNGv0LcCFFzfDssOQ3PFXAhzawdb4C6
 0WG/2Xqwb0dSvmNCPcATY85LoFJZd5bE3+rciCPELLQ9+q7Hj1d/WTA//KvnFxTT/w/5
 OAyTJ9TIjzJ/ZUieL43R1nbbcs8Uzf6/idK/PclkaqmLVJ/xrkTEmgUhYgWs/GptIaXV
 YASw==
X-Gm-Message-State: AOAM533w3ldTfCGsRAj/X6hsH9VDGNUCLH7gtVeFWwE8rXrWQsC16+Ax
 MVq3FqrCKw5IiZHLLiMa8qwjQw==
X-Google-Smtp-Source: ABdhPJxt9prk84Rhz1qfl8PCP3CdBdMFHhzAR/AnhH9ZFn8x+XmZlhtH9HWAY7tkUHoyMCqWqiy6gw==
X-Received: by 2002:a17:90a:658c:: with SMTP id
 k12mr8021272pjj.167.1626947823491; 
 Thu, 22 Jul 2021 02:57:03 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id ay2sm2400955pjb.14.2021.07.22.02.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 02:57:03 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH V2 5/5] virtio: Bind virtio device to device-tree node
Date: Thu, 22 Jul 2021 15:26:43 +0530
Message-Id: <026ad5f274d64d46590623f9f3a04b8abfbe62d7.1626947324.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626947324.git.viresh.kumar@linaro.org>
References: <cover.1626947324.git.viresh.kumar@linaro.org>
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
 drivers/virtio/virtio.c | 67 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..87bee5b966c3 100644
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
 
@@ -319,6 +323,53 @@ void unregister_virtio_driver(struct virtio_driver *driver)
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_driver);
 
+/* Virtio device compatibles and IDs */
+static const struct of_device_id of_virtio_devices[] = {
+	{ .compatible = "virtio,22", .data = (void *)VIRTIO_ID_I2C_ADAPTER },
+	{ .compatible = "virtio,29", .data = (void *)VIRTIO_ID_GPIO },
+	{ }
+};
+
+static int virtio_device_of_init(struct virtio_device *dev)
+{
+	struct device_node *np, *pnode = dev->dev.parent->of_node;
+	const struct of_device_id *match;
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
+	match = of_match_node(of_virtio_devices, np);
+	if (!match) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if ((unsigned long)match->data != dev->id.device) {
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
@@ -343,6 +394,10 @@ int register_virtio_device(struct virtio_device *dev)
 	dev->index = err;
 	dev_set_name(&dev->dev, "virtio%u", dev->index);
 
+	err = virtio_device_of_init(dev);
+	if (err)
+		goto out_ida_remove;
+
 	spin_lock_init(&dev->config_lock);
 	dev->config_enabled = false;
 	dev->config_change_pending = false;
@@ -362,10 +417,16 @@ int register_virtio_device(struct virtio_device *dev)
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
