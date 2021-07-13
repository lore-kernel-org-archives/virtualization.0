Return-Path: <SRS0=VeF6=MF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED7AC11F68
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 10:50:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C0961375
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 10:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C0961375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B23D83ABA;
	Tue, 13 Jul 2021 10:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kl1LP7MbjAon; Tue, 13 Jul 2021 10:50:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 06CF083AB9;
	Tue, 13 Jul 2021 10:50:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFB39C001A;
	Tue, 13 Jul 2021 10:50:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D002C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DDEF4038F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id neZ_OAZ_EIdV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C6094039C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:53 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 oj10-20020a17090b4d8ab0290172f77377ebso1861806pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 03:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=986/a+XL1T//36W39++oB7kOlKnW5eYSo8veeEHej88=;
 b=A3Q/umcFWAyQTFsjWu0zZq7yNfzjuO2F03oZsK9+N4gsF+Yto7uv9o93Cw5O4pU30l
 pmnq3CcUhEL/8tHaQIa+H/J2XMafGoTkXXFgigVY7VlwFGYDdhNmVsHwifGLRFlY6aBF
 MhZjtulyDf+CNgTgvShltXI9F0SdCXh8U3XJrTebKTTnwD7KJkBiCo6+0X64QFfMWTCP
 mpx5FAYJl1zlDjBE91cO4IM6oEEZBzb7Oh9yI6PC8BwncgDUhYF+CuBM/obQfTg5AqOc
 4JVUPbUiBB3xNewdVUjwYvLePcJIV3R0zNGOZDUrLFAn56bpGPhYm7ZQgbg+7xnbUY6v
 9gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=986/a+XL1T//36W39++oB7kOlKnW5eYSo8veeEHej88=;
 b=ZEJKx1IZ5d9GPbPKHQzabjcP2YlYl/Dvpy9Ssi8l2UAxeqeNRUsTpqcCazXgvSy5gP
 bpp60ripWl8bd6LZT6/uCZ4YPPp4CaDHlwGRsscGuVea/8PDV1u89qn5qWB9DX6XO/Q8
 gSawv9fRSuKY94TedZa9AwiTIzpgBgmFCxC21lOQmLKUtojCfDGuVbjLFHfOu4jnPdCl
 Tr7Zj8QgQazrJyE9HPU9ZY97upp1xqoBE0L1Colpq30XAUTN3i2ZrcM8jk38RDc5IXxj
 sq9jdwcRDNbQJnrVWzSraDa5gYb2WFdOqZ/eJb7hM6plDh9PXuvo+ake8eLfMCkuuub3
 2A/Q==
X-Gm-Message-State: AOAM532KihIbj7TqttmZ5+hjfnlHoPRyYyQ9rqq4M6kGP9VQKhIDgVAj
 UAfWrP9R4/FpzgaqUQGX/rB4bw==
X-Google-Smtp-Source: ABdhPJzdSsYRQEKyCDDhOUHI4C1uEGpynqL8WeWZ0/WvMY/knBSGmDC2UG1V/5sgTs+RTyv3zKragQ==
X-Received: by 2002:a17:90a:1549:: with SMTP id
 y9mr3808382pja.211.1626173452771; 
 Tue, 13 Jul 2021 03:50:52 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id y15sm8993842pfn.63.2021.07.13.03.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 03:50:52 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 2/5] virtio_mmio: Bind virtio device to device-tree node
Date: Tue, 13 Jul 2021 16:20:31 +0530
Message-Id: <26ba6941fa01eee88c99ecdd611d235c22bd6e3c.1626173013.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626173013.git.viresh.kumar@linaro.org>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
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

Bind the virtio device with its device protocol's sub-node. This will
help users of the virtio device to mention their dependencies on the
device in the DT file itself. Like GPIO pin users can use the phandle of
the device node, or the node may contain more subnodes to add i2c or spi
eeproms and other users.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/virtio/virtio_mmio.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..ae40546a66a3 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -551,11 +551,51 @@ static void virtio_mmio_release_dev(struct device *_d)
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct platform_device *pdev = vm_dev->pdev;
 
+	of_node_put(vdev->dev.of_node);
 	devm_kfree(&pdev->dev, vm_dev);
 }
 
 /* Platform device */
 
+static int virtio_mmio_of_init(struct virtio_device *vdev)
+{
+	struct device_node *np, *pnode = vdev->dev.parent->of_node;
+	int ret, count;
+	u32 reg;
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
+	ret = of_property_read_u32(np, "reg", &reg);
+	if (ret < 0)
+		goto out;
+
+	/* The reg field should match the device id */
+	if (WARN_ON(reg != vdev->id.device)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	vdev->dev.of_node = np;
+	return 0;
+
+out:
+	of_node_put(np);
+	return ret;
+}
+
 static int virtio_mmio_probe(struct platform_device *pdev)
 {
 	struct virtio_mmio_device *vm_dev;
@@ -621,6 +661,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	if (rc)
 		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
 
+	rc = virtio_mmio_of_init(&vm_dev->vdev);
+	if (rc)
+		return rc;
+
 	platform_set_drvdata(pdev, vm_dev);
 
 	rc = register_virtio_device(&vm_dev->vdev);
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
