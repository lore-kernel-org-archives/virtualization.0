Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C069C0032E
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 14:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A028585261;
	Wed, 25 Oct 2023 14:53:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A028585261
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QjuxYihK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0kOca5_nWIyl; Wed, 25 Oct 2023 14:53:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB0DD84879;
	Wed, 25 Oct 2023 14:53:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB0DD84879
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84581C0071;
	Wed, 25 Oct 2023 14:53:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2054BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 14:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0911E4F2BD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 14:53:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0911E4F2BD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=QjuxYihK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z7jMfalwNLgw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 14:53:24 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3E4B4ED92
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 14:53:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3E4B4ED92
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-991c786369cso866852966b.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1698245601; x=1698850401;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IV52gqKvJLev/nEwlZaq8bDCbTo7SRK1FTCEJKQYD08=;
 b=QjuxYihKi5bJHFMM5thdR64mCb4ijCPikuRS02vryvvaseCZKC6SzIYSqSv19a/cjD
 fZ5Q+lQ0U1HscsPMSfwX0oX/KZpIdJ7Ku+eaY7pi29m6TzsIYFrFDp1HX2VAY78vAbDp
 NkYb7mda9JcKR60IDqCXmnmWKNhwCqygMMYwPx3RogtQiu+E0nBVVSOnBVPJGZWLULRS
 tLSGTejoU0ia7DfBtRacPlYxXxTEIaH5gAIx+OuSwVCGfJInYhO76EFo5BpW+w85pJk8
 K4JdaFwUJYskl5x4r4iZe51KeERm3g0A+vXlXd5PlMnL7RjwMMjGeJUPdJ/OpUNu3Ut0
 GLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698245601; x=1698850401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IV52gqKvJLev/nEwlZaq8bDCbTo7SRK1FTCEJKQYD08=;
 b=caTna3PJ50zSpHSZJGifB84NRC+I8BLA0F/fleVW2+1nB4vP7EpD40iKc9fpURQYld
 rEj3bxEEIWGmEULtSBdy7Wvv9T6uLgrn2KdhzRK95D/TMyK2pgpx626RprNY8o1+h6ve
 UUbYq1sFlnzAJsqvu6EOnA6wAsLiUVqmGMSnCQFGo/XpNfiZ03W3m7UilqAihdPZuodN
 jA+tgSgZKvHbKqD2OgSpr3QiI/P+5YejP64lEq19esDSUBG9ZRy7E/GHVT2GADp/l38s
 sgNq2VTmV9CEH0mF09uiGH/mFjqDyYW/PKEEsSF/95kJIZHN3qbtnXTuBknNly4m5w9j
 x3TQ==
X-Gm-Message-State: AOJu0YxEHA4jiYfp+fSanqfjSVSAYHH6UCETOaeI72sCisPm8MzXNKLH
 i8o1YFD1Dl7FRL/QA03YqT+OysZQM18avtT5rOFMJA==
X-Google-Smtp-Source: AGHT+IGmhcMX3P2d7rTTjdKLj40MV1gB5lLVVyV2lpf5dzF8jwl8z5JSxtSWL2/X52ewQjM28dAM3Q==
X-Received: by 2002:a17:907:94ce:b0:9bd:931e:30d8 with SMTP id
 dn14-20020a17090794ce00b009bd931e30d8mr12102066ejc.14.1698245601586; 
 Wed, 25 Oct 2023 07:53:21 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a6])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a1709062b0700b009932337747esm9856733ejg.86.2023.10.25.07.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 07:53:21 -0700 (PDT)
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2] virtio_pci: Switch away from deprecated
 irq_set_affinity_hint
Date: Wed, 25 Oct 2023 16:53:19 +0200
Message-ID: <20231025145319.380775-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.41.0
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
v2:
 - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
   Proposed a change to IRQ affinity interface to address this limitation:
   https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com

v1: https://lore.kernel.org/r/20231019101625.412936-2-jakub@cloudflare.com
---
 drivers/virtio/virtio_pci_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index c2524a7207cf..7a5593997e0e 100644
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
@@ -443,10 +443,10 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 		mask = vp_dev->msix_affinity_masks[info->msix_vector];
 		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
 		if (!cpu_mask)
-			irq_set_affinity_hint(irq, NULL);
+			irq_update_affinity_hint(irq, NULL);
 		else {
 			cpumask_copy(mask, cpu_mask);
-			irq_set_affinity_hint(irq, mask);
+			irq_set_affinity_and_hint(irq, mask);
 		}
 	}
 	return 0;
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
