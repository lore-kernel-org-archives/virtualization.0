Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF283E1D17
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462492; cv=none; b=lMq5HwZGLrXQfyn7H4WnNdzjhpo9CH37utnfIfgiStbbdxgyaCs6c6qiHGi3x8EABnFrq+nk3TJnXKLn3HU/xxWGvdQpvSU06ZdmjPV9WyalH1T7EnkTSaKeWlZiy3AXxT7yEnS6XE3vriPQgL6biSSQ9bR079cvSmZF9u53oWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462492; c=relaxed/simple;
	bh=eJ8luZ+SOFYZ9CBtpa/OCOcnNLbnaIoYUY4vzqqI4mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDqmoPR7VwR6jv/PRM7h2LGCyESoE69OS+z+J/VsaSvm6VxG3pgjgfY7pwkH12F4nbLUn3VpZSV4fJ6LIoIJaL/mRUmO0D3ZO9wU1SgZQFbZTqOdqwy4ls5C3dMGM4wPUGbXCI0BeB6NJasocWgnraLf2JAe+iHreYZRXTce1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3PzXqe8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3PzXqe8"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0006ea8eso3742101cf.1
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788462484; x=1789067284; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0ORsVXBJpmzlPcHJRa4DochV+ZXbyOiZ7M55TiOe3k=;
        b=h3PzXqe8uzdmg71d0iP6AWkkp++RL/SV3fe4HI4dwEmI8heU4DtXNuDhut3EpmRs1E
         cnO8X4HFxHu6hAb89looQNMEHOA7pLK3lYjknyu9jDBJaPfVp8UqnIk9+KqRfY22gzl8
         V8wuusp6djZH3QoVEQwkskOJAVYR3t3tgmvMCR+zdrM/UAaXTvdxExfxcBjsZC9ggRcf
         rxw3iH/qBjWAvnY9ciJlpS8vWF45eFboOtVRXGNwar960GxxTZ1RQFQP5Q6h9hDFVW/B
         BOTbqbOmZ6EcdCMr5U9hnizrPrCQWGrkXkQ33QhXEPpGjkJ5gqtQbprFIOjwE80o+gFH
         2HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788462484; x=1789067284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0ORsVXBJpmzlPcHJRa4DochV+ZXbyOiZ7M55TiOe3k=;
        b=beFoBlWBs1FrhtU+q/hVtJPW5I45zMRzOKi/Uo7y4j60gNTLGufHWJSTZi9o/0oX8n
         UhLu/hHbxfsrJ2CFI3zotZ+5Yq0VxaXX+lcm53DU3zPq0JXe/CPnVvyW880AaMeRMYbm
         37myNopp5YIq7b5Jo/49EKtD0R5sTggZSnuwOCGWE7MTM9RtNqFL2tQxWVGhP9LaaC8z
         iOHM9XRxsPHDJ73+DIthGW3ZTHdA6DnkCexk5XP5osLmUhwtadzY68vxXqjiqtL3Ws10
         cA7yeHPdcRRZJDMUTJurfKfDJbW6tOFFdTx9kZOWx1NJPyHTT5p1V1dLO6UIZnr4I1yI
         d6hw==
X-Forwarded-Encrypted: i=1; AKwUvBzrr/b4S1f628dmIQ43F6zUWCWGnb0lfgAscGgTQ/5rH8Sk5bQnp4eO63Lh/pZM/uzjuTfnNJ/uQUya5fCLWQ==@lists.linux.dev
X-Gm-Message-State: AFuF++l46vXFU/7qFQ+lWgTJhjGKChyfx0oLUQmSitTP3E6VgdqjV4co
	ToYgx/vVItLbPoCO/4y6pVnaoDJLSZ8u9Dp2ZNpSlpo2O0eOxjs11E92
X-Gm-Gg: AYBFou2dWdYgppgw1+d9xQdO0vcZVqoGuNe1rGWlQa7Hi6mZaa0E/hxSHgWCWDgkx28
	XqZQjuAP65+ykIdE4SQNsQzh2kvbqEvMZR2ZEIit6gdUKDz8kvxc7XCcz3Yx5Vb5Ck17Tanobam
	2ts6BudMM4Csyf8UPk9MUsac85L/lzSlyXXMFSfk7PTeRU8LiFwoIohJkIumBeejCaX22FEge7B
	FZtCsC3ebrpqliNNWMxidkeWB+BBHxauStSIuXYsMWt3M3x+2v2aPqPbRMsxI6feE27j3Vx71/a
	BgGgwRkU/HJhMgQQHUgGZFCVTm8oqqU5Ht1EHiUbvmbEg8a3sU/KV8wk/NfFzXYAKTvErbF7tRp
	a9q7BX1E2TJrInD0QcLdC+GoLM2XNuSJFA1lODw+K+77wZMig1YashDA2C5FHq/elRXaG87HbsH
	CZbQcp3XeBQb3p+pFntWp2iWKf/JPHEB5+YW2WkKOwZ6/aWz98eo7DI2xgye/5gy2PkT+3FOvOI
	+fAWwIV24y3fnXJBXJ//3Z8dqZG0EsPmmiwoXwOCzjkjktzUzY7E6nYv0gJyH72lM5yuJqpOhTs
	5UPW8VAVDcty0klt8xiHLGNjAr/EdH4jDlQIn7637rE86/IOSBXz1z4IfAy7YHw=
X-Received: by 2002:a05:622a:1f98:b0:530:31c8:a302 with SMTP id d75a77b69052e-5305495da66mr12171581cf.23.1788462484170;
        Thu, 03 Sep 2026 12:08:04 -0700 (PDT)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:bc26:3e94:1d7f:e1ff])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406940f3sm1342666d6.38.2026.09.03.12.08.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 12:08:03 -0700 (PDT)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: mst@redhat.com
Cc: jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev
Subject: [PATCH v2 3/4] virtio-pci: return IRQ_HANDLED after non-zero ISR
Date: Thu,  3 Sep 2026 15:07:31 -0400
Message-ID: <20260903190731.13783-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903111342-mutt-send-email-mst@kernel.org>
References: <20260903111342-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vp_interrupt() reads the ISR before dispatching config-change and
vring handling. Reading the ISR also clears it, so once the read
returns non-zero the interrupt was from this device and has already
been consumed.

Currently vp_interrupt() returns the result of vp_vring_interrupt().
For a config-change interrupt with no vring work, that can return
IRQ_NONE even though the ISR was non-zero and the interrupt was
handled.

Call vp_vring_interrupt() for any queue work, but once the ISR is
non-zero return IRQ_HANDLED.

Tested with QEMU virtio-blk-pci forced to INTx using vectors=0 and
pci=nomsi. On an idle device, 200 config-change interrupts were
generated using QMP block_resize.

Before this change, irq_handler_exit reported ret=unhandled and
/proc/irq/11/spurious increased from 0 to 200 unhandled interrupts.
After this change, irq_handler_exit reported ret=handled and the
unhandled count remained at 0.

Fixes: 77cf524654a8 ("virtio_pci: split up vp_interrupt")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
---
Changes from v1:
- Return IRQ_HANDLED for any non-zero ISR, as suggested by Michael.
- Add Fixes and Suggested-by tags.
- Test the change with virtio-blk forced to legacy INTx under QEMU.

Full red/green test logs and the exact tested patch:
https://github.com/andrewstellman/quality-playbook/tree/11ba61d/evidence/virtio-pci-intx

 drivers/virtio/virtio_pci_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 10371ecbc054..b90c174450b2 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -120,7 +120,9 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	if (isr & VIRTIO_PCI_ISR_CONFIG)
 		vp_config_changed(irq, opaque);
 
-	return vp_vring_interrupt(irq, opaque);
+	vp_vring_interrupt(irq, opaque);
+
+	return IRQ_HANDLED;
 }
 
 static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
-- 
2.43.0

