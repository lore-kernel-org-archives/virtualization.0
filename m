Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7465CDB483
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 10:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3FA7F42E9F;
	Thu, 19 Oct 2023 10:16:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FA7F42E9F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=SeDo3OXA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iEHy8PHPhgKO; Thu, 19 Oct 2023 10:16:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4F90C41831;
	Thu, 19 Oct 2023 10:16:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F90C41831
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2191BC0039;
	Thu, 19 Oct 2023 10:16:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5A03C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 10:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F26741831
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 10:16:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F26741831
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7eWSEs82cW3e
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 10:16:29 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F9014060B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 10:16:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F9014060B
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99de884ad25so1254354766b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1697710587; x=1698315387;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wsXbezCZoeuJrO98GwOgaGC8RBPaWgtTZVWkdUgAb5c=;
 b=SeDo3OXA6FJI9OLEn7xtJA7w9Ak0o1zwEtRiELmYCCG0r7oIsPBwUd4BRgM2ud4bhK
 PKaFCHeSVGyn599P+JXICk358/gL4Rtgh8lbZ0dBdOUJ6OZvgJc5Qmr+MUlVU2641h+a
 dcqFvIAQNF4xpT7Y/wHVLzxlVa/u08cFsDwYLLHcBX52S4b7DYLoENQ9S785yblkMZnp
 nauKkbTX2Kc1s1UvEvY5P/RavJTEDNL4Ov/SzMBNfWmSbhfOD2SqiYrJhhBc1lFt6wg+
 KRHsaUbcqfiEUx6jNsxdkUu5XU2XBRNCrXH0TfRhBaFRTBD7GLbKhtmxIWH8mGIjb6m6
 ILhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697710587; x=1698315387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wsXbezCZoeuJrO98GwOgaGC8RBPaWgtTZVWkdUgAb5c=;
 b=RIUt/GLBmAiJnzcIBG06M56m7gVYW/Xvw/QHGfaX0+HMco1s/1Rg0TdQWkuiTHBWam
 F/LgrqUHkYkREwfw0ZOGHikGMIMQfC9PdIeK5l8K/mXtjlifdC4t0JMVOSYFLjBCMdRb
 5rsNxngWFVZS3Kp4uuwFbxP/B5JLShUPXfo4nX+3nBfDd9dJGdG8vlcEw3d9GV50DO4O
 pBcbcenC13en1Rr/0f+aqRHQHabfACfn4VUEMK9McDFNkn/njJP2gEftIggXLR1nmlWF
 OwEOjvGYidiqO6/u8upBmuB/JkJFrOS3s45cAahFL8Tf0Ar4yz/d8MKgWwZIBQS1DQgA
 aDlA==
X-Gm-Message-State: AOJu0YxzLMey0oqQ3fjTlw59KrOevr3KqQMAduyArKeOWgLa53ctU27Z
 Ly3olnGDcVgOYQVD8C31x2ZzpcPBVwLBrhkWN9nDIg==
X-Google-Smtp-Source: AGHT+IGKx6okUJClW9akG9H6m9kJqJ0Nyt+kBKsXxyAiYiyCKsRx/FPkbX0599vNxVESnPv8DZ7cIQ==
X-Received: by 2002:a17:906:dac4:b0:9c4:4b20:44a4 with SMTP id
 xi4-20020a170906dac400b009c44b2044a4mr1270036ejb.48.1697710587277; 
 Thu, 19 Oct 2023 03:16:27 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:194])
 by smtp.gmail.com with ESMTPSA id
 le3-20020a170907170300b009c70b392051sm3252439ejc.100.2023.10.19.03.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:16:26 -0700 (PDT)
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu affinity mask
Date: Thu, 19 Oct 2023 12:16:24 +0200
Message-ID: <20231019101625.412936-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Caleb Raitto <caraitto@google.com>,
 kernel-team@cloudflare.com, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org
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

Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
mask.") it is actually not needed to have a local copy of the cpu mask.

Pass the cpu mask we got as argument to set the irq affinity hint.

Cc: Caleb Raitto <caraitto@google.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/virtio/virtio_pci_common.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index c2524a7207cf..8927bc338f06 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -433,21 +433,14 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 	struct virtio_device *vdev = vq->vdev;
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
-	struct cpumask *mask;
 	unsigned int irq;
 
 	if (!vq->callback)
 		return -EINVAL;
 
 	if (vp_dev->msix_enabled) {
-		mask = vp_dev->msix_affinity_masks[info->msix_vector];
 		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
-		if (!cpu_mask)
-			irq_set_affinity_hint(irq, NULL);
-		else {
-			cpumask_copy(mask, cpu_mask);
-			irq_set_affinity_hint(irq, mask);
-		}
+		irq_set_affinity_hint(irq, cpu_mask);
 	}
 	return 0;
 }
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
