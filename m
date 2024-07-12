Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503316F27E
	for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794564; cv=none; b=qTvbBRzJ7M+YwZ3yzDY/dvwKGrimvs2vkZzDRq8VWmI3oOOBfxw8DuiVoB/ZuIF89a7DkybVPIbwsuki4oJL6VZvmuNhxxmEIAn2VODh+DOFmItF2vwcP9+icAN0UdwDkiuhM07GSJE1xhG+ovh31tN0EQDAeCtqT/1UhaduRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794564; c=relaxed/simple;
	bh=LbTNChU8bTRD5sx7/n91xzehW9iyZBQZchWZoFuWKPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lVGpHKAUndv/pHhVCss19KE5A7D6TrLvtNDG0I0dkezsCKuTws1EZRyBQzffZaAsza7sSJlfI43T1OeffDuUZXFK59dEqFyE9EYwuf7a23c8bxZ9kF+HPUkzyARjeaa8gWzzIzEZx6iyUH7ckvBjnI06to8eoCO041LSXDrfdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YzRKo/Uf; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzRKo/Uf"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-75e7e110e89so1312528a12.3
        for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720794562; x=1721399362; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfRcvqvyLWqqw4VZbdos3kGou0KYGp4KID6MEMi5E0s=;
        b=YzRKo/UfTU6p2hreMdWbD0vZOuA/qC1qoci5Bk7dew+EYovvQY/Ln62/19P6erMhep
         aUbBi7w3pkTw+aJTVUI6uEBa9sxrGiUVU6IHpy8IP5T0JGTs2MOsy8NIfI4NopAjvM6O
         yJlULysNklE1YUZYUa6oLV0GklqLJniMliBPjIv3SbUduw6wHk9VxXhy36VBUu6uaLxS
         fjEsV/Atxka+xjhPq5jcnTUfcnJSr3QonJxMLdNaq9CqJe5JTg3ddoOTSjwzKt3PSzyt
         0wCqTXaGtJ7bAzrjY7BDACouaaGQP3kTwvzU3n7Rc2lSwxkz8f+GSnbh4dPW4y5oMbDZ
         CNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794562; x=1721399362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfRcvqvyLWqqw4VZbdos3kGou0KYGp4KID6MEMi5E0s=;
        b=R43xZsaxULoDaNuw2ZpIYHSlSEoXmdZikAPPqqvRe7WzyVTYk4oaAAI9tqYX4fknvN
         KAa4MiGOE/okp6y0yaQ2e6LlOOJmVz3/bPrGw+m/QC+9BPB35iNivEPp8Avc1rnksw4u
         WY0LFMHrMEHukkmtA6SuR4YNQPAFkJLw99izW3b/NaKW07aPsaOJXI63urW2a4XK96Uw
         NRPg8D5e9fxVGXkeRmX8gJvB0Q7Q/74RyZaY5PZhEnGhg4HDGMKBZad3FFDOUECHQEne
         VhjuZrsBLV9KY+3WwqAgPx27IlqJhb0xy7KJpcPIHIa+FdVRbPThpTU8VG7JWTavLRu+
         ZTBA==
X-Forwarded-Encrypted: i=1; AJvYcCV8NfyVyh5C4Ytca5aMKaDw/M1CYv+aLzGduPYxmBObd+EOjlHD7wM1jxGrT5D3bqNGW39FN8EcT9byo8TBZLvyqgbc9zYe8a9eQ8th6YM=
X-Gm-Message-State: AOJu0YzHQ4PX7l1UzQ5lAaHF9eUL8djHK+LAzGoHx46CS6zjAph/57II
	vUqGXS3NR6rkonjUeXKaEfJ5ZwLdfsch9ovPYvIKpHdmaobdmU7471CU98yfPg==
X-Google-Smtp-Source: AGHT+IHbEdR45IjDHcAMoLP6rDlFFdiSoFMz5LWcZABCTasJiEG5qGfVuq47Emz5imjJVxqZsw3w+A==
X-Received: by 2002:a05:6a20:cd0e:b0:1c2:8cc4:c361 with SMTP id adf61e73a8af0-1c2981fc191mr12859114637.10.1720794561783;
        Fri, 12 Jul 2024 07:29:21 -0700 (PDT)
Received: from localhost.localdomain ([120.60.61.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad141fsm67508075ad.277.2024.07.12.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:29:21 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mst@redhat.com,
	jasowang@redhat.co
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mie@igel.co.jp,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] virtio-pci: Add MSI support
Date: Fri, 12 Jul 2024 19:59:14 +0530
Message-Id: <20240712142914.16979-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio spec has so far only supported MSI-X and INTX for receiving the
interrupts from the virtio device on PCI transport. But this becomes a
limiting factor for devices supporting only MSI (plus INTX emulation) as
they have to use the legacy INTX emulation which is limited to one IRQ per
PCIe function.

But this now addressed with the help of a proposal to the Virtio spec
adding MSI support [1]. Based on that, let's implement MSI support in the
virtio-pci driver.

The Virtio spec proposal reuses the existing MSI-X infrastructure, like the
config_msix_vector/queue_msix_vector fields of the Virito common config
structure. Following that, MSI support in virtio-pci driver is also added
on top of the existing MSI-X implementation and it mostly reuses the MSI-X
code base. The existing vp_find_vqs_msix() API is modified to support MSI
along with MSI-X.

The preference for interrupt allocation is still given to MSI-X as per the
spec. The driver will try to allocate MSI only if both of the MSI-X
allocations (one vector for each queue and 2 vectors) fails. As like MSI-X,
driver will try to allocate one MSI vector for each queue first, and if
that fails, it will try to allocate 2 vectors (one for config queue and one
shared for queues). If both of them fails, driver will fallback to the
legacy INTX as usual.

For keeping the changes minimal, existing 'virtio_pci_device::msix_enabled'
flag is used to indicate the status of MSI and MSI-X. Rest of the MSI-X
functionalities such as IRQ affinity are also reused for MSI (but the
affinity setting really depends on the underlying IRQCHIP controller).

[1] https://lore.kernel.org/virtio-comment/20240712140144.12066-1-manivannan.sadhasivam@linaro.org/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++------
 drivers/virtio/virtio_pci_common.h |  2 +-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index f6b0b00e4599..6f80b0c46c5f 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -100,11 +100,11 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 }
 
 static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
-				   bool per_vq_vectors, struct irq_affinity *desc)
+				   bool per_vq_vectors, struct irq_affinity *desc,
+				   unsigned int flags)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
-	unsigned int flags = PCI_IRQ_MSIX;
 	unsigned int i, v;
 	int err = -ENOMEM;
 
@@ -288,7 +288,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
 		const char * const names[], bool per_vq_vectors,
 		const bool *ctx,
-		struct irq_affinity *desc)
+		struct irq_affinity *desc, unsigned int flags)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 msix_vec;
@@ -310,7 +310,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 	}
 
 	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors,
-				      per_vq_vectors ? desc : NULL);
+				      per_vq_vectors ? desc : NULL, flags);
 	if (err)
 		goto error_find;
 
@@ -407,11 +407,23 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	int err;
 
 	/* Try MSI-X with one vector per queue. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
+			       desc, PCI_IRQ_MSIX);
 	if (!err)
 		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
+			       desc, PCI_IRQ_MSIX);
+	if (!err)
+		return 0;
+	/* Try MSI with one vector per queue. */
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
+			       desc, PCI_IRQ_MSI);
+	if (!err)
+		return 0;
+	/* Fallback: MSI with one vector for config, one shared for queues. */
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
+			       desc, PCI_IRQ_MSI);
 	if (!err)
 		return 0;
 	/* Is there an interrupt? If not give up. */
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 7fef52bee455..a5062ca85f3b 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -77,7 +77,7 @@ struct virtio_pci_device {
 
 	struct virtio_pci_admin_vq admin_vq;
 
-	/* MSI-X support */
+	/* MSI/MSI-X support */
 	int msix_enabled;
 	int intx_enabled;
 	cpumask_var_t *msix_affinity_masks;
-- 
2.25.1

