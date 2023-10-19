Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74437CDB483
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 10:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2D0283AD1;
	Thu, 19 Oct 2023 10:16:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2D0283AD1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=fgU5but1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fJ6xi6DRQymW; Thu, 19 Oct 2023 10:16:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7E43D83ABE;
	Thu, 19 Oct 2023 10:16:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E43D83ABE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50757C0039;
	Thu, 19 Oct 2023 10:16:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E16FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 10:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE4BD6FB26
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 10:16:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE4BD6FB26
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=fgU5but1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OOPC15Ng_7Gx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 10:16:32 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08CB56FB1C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 10:16:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08CB56FB1C
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9b1ebc80d0aso1222014366b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1697710590; x=1698315390;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibyNWRVCDx3qtUdZOs6HtDQhMI8S1gxSQ6nQBRN1fXM=;
 b=fgU5but1Wsi+vXCq7WVgk8qyaTZNhl78JEPFreZ6N17vPYLPWSzpc7zcZAVV4Q16iv
 hZOMYkhh55eslAEG4GsL3JD66mFvWWbGsHHyRPfHjiEPoF2coJm0OPE2Oki0K8eY1T2G
 wrLlveDO3z4Y0RkObvLWTYWQFt+6za2pES5QXNWWzrihIz1AwINiMKXklnJbacbbiX1E
 A06Eu0btKvOYfmgv5FgPGh8tuMIsKWrcKYmIgunEJgyYdymMigfckWiZULzc8sf0K+Bh
 Whz/IBFwPxZJ633OT7C0qVRWtK8MfDRRWv4Fegc4OHTZ2S1o46XNvus1R27viYlDWTF9
 cl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697710590; x=1698315390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ibyNWRVCDx3qtUdZOs6HtDQhMI8S1gxSQ6nQBRN1fXM=;
 b=gMqymugiHOf2rrdDr8OFPibXK8SsR46uJnq9ggOdkjmx6/Pda41KTBY0X8Cx2vFOJa
 E0amFwTIteTXyQCKqglBcfYBlr7dW8VcjKpHJxwJlZjjVEqf0It7Q/fL5/hvz+vfOT+Z
 LQ4Dw5Sr6gXuxl8o/4djf/gEQHYRYOjxnMNSCkpIFrx0bS6C6CpfYX8OzvTPxDuTJ9Vr
 H8YClDPCRtyq2qQKQi93AFmyKprnPcjIiKyJCR5gmN0yqpVh5K3qMkTWWw4rhPn+XRjK
 IOHH9CkkknheQoD1cRiWL9albpdFdFkXMrZDSF4gEA39t6J5ePIBEAWxh+iQFGJk/p2Q
 pvfg==
X-Gm-Message-State: AOJu0YxFhfRq2bONWxkLWNQE/V70VonzJy89kEltmla6tMLhU+a3v9DK
 v4LPfGRzXzVydSzEv+7sGpNPrEVXxiewk1LHIMFyEg==
X-Google-Smtp-Source: AGHT+IHF/5NdBr8oE08ju1QLZcHvtSIqTtdkG3W8vghatpkOTfnKNt9vsEurU2jwiofOOYZadF9yrg==
X-Received: by 2002:a17:907:706:b0:9be:45b3:3116 with SMTP id
 xb6-20020a170907070600b009be45b33116mr1517324ejb.71.1697710589833; 
 Thu, 19 Oct 2023 03:16:29 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:194])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a1709061b4600b009b65b2be80bsm3249835ejg.76.2023.10.19.03.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:16:29 -0700 (PDT)
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] virtio_pci: Switch away from deprecated
 irq_set_affinity_hint
Date: Thu, 19 Oct 2023 12:16:25 +0200
Message-ID: <20231019101625.412936-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019101625.412936-1-jakub@cloudflare.com>
References: <20231019101625.412936-1-jakub@cloudflare.com>
MIME-Version: 1.0
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kernel-team@cloudflare.com,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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
From: Jakub Sitnicki via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
hints") irq_set_affinity_hint is being phased out.

Switch to new interfaces for setting and applying irq affinity hints.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/virtio/virtio_pci_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 8927bc338f06..9fab99b540f1 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -242,7 +242,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 			if (v != VIRTIO_MSI_NO_VECTOR) {
 				int irq = pci_irq_vector(vp_dev->pci_dev, v);
 
-				irq_set_affinity_hint(irq, NULL);
+				irq_update_affinity_hint(irq, NULL);
 				free_irq(irq, vq);
 			}
 		}
@@ -440,7 +440,7 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 
 	if (vp_dev->msix_enabled) {
 		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
-		irq_set_affinity_hint(irq, cpu_mask);
+		irq_set_affinity_and_hint(irq, cpu_mask);
 	}
 	return 0;
 }
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
