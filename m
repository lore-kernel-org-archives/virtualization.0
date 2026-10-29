Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.91
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263266;
	b=IUJreYe9F7BcdAKw9O28IkAFu5gvuHcKhUBDVOSKCO8Zj9BqfFCNFdfxnHkDTKxjOtOj
	 prkE2TR170Ng4/9LPxz07TYPm3GyoZ/5qwPD/yvpR3U7zYpswYqjoIsIGwkBQFyvnoHsx
	 YZly4n450u0tNTd1qoFgxg2RYMl+1ktL0Blt0Q+qFsm+Zagefcvz79GD+yFa2IwMjpzve
	 CNroDxPE/H4DMwbw+eTmZdgJ1y6N6mBtDw8KAOZkJWSiEh8cHQ5rk9hT7FGbB89/j8+vw
	 G3i6mGkfRXmO5qOWvm1QkNNoLNpI672mNRPahJMygf2R/8JFRqqOlyAvCuz5SrSeCCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263266;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SvpC/CqEqjBdZnQpgRe5OfHjCtNzXh6/qxDST/OshQQ=;
	b=PO0i1OTy3ZHUNmtIZsbfu3RfCZPyKkv8agCyCJyDfIHwyq75Onr18bsMphdevWP/gq0k
	 KHtno1u/imM0L4FgO0blg0V717+copUJSj/N9IY4LVJ6bsW8k2bgyasaTzmFYBXIxkuKC
	 mKeKsTMhSSh7G/YY1YN0gVOvCXMdBF3hJ8p/iZDJZAuv92lUWFMIT7hNctgKjaXKDmioH
	 sc0rxxcrgDCev1Wie0U0nFQgK3xaaK4rbefz+97slLPosGXYhkmZMMqGux0GwfB9apv2U
	 aBJyevkvozWvEd68ElBGUGH/dGeH3ANh11F1sCL16n1IDiTMw+xJ9U551Tb41zq7rwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.91
Received: from mta1.migadu.com (out-91.mta1.migadu.com [95.215.58.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0E606A31C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6B0E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=TqpGNjKT+lD2Rel7GLiUVY2FqEfci48dH7mpDqNpEiM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793263262; v=1; x=1793868062;
 b=PXd0JWeQwCYvtlvhw2Sz21W/lWoZwoErCK3uSvellB3AA9AONRCKoSGHaBw6oB7DQdnbjunm
 QFuKFPEvxqayjUv+DGm3XAI9QZURGen4jV+bEVpapUXQWJ5osDYNICMAqBTQrnDJgqF3tRa9ljB
 +vxxJ0DQ8Fm3WXVtOCGeKXA8=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 2945813667bcd118;
	Thu, 29 Oct 2026 08:41:02 +0000
X-Mizu-Trace-ID: 2945813667bcd118
X-Migadu-Flow: FLOW_OUT
From: Zenghui Yu <zenghui.yu@linux.dev>
To: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	nicolinc@nvidia.com,
	jgg@nvidia.com,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: [PATCH] virtio_pci: don't take the MSI mutex under cpu_hotplug_lock
Date: Thu, 29 Oct 2026 16:40:43 +0800
Message-ID: <20261029084043.19409-1-zenghui.yu@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

Lockdep reports the following circular locking dependency when a virtio-net
device is probed with lockdep enabled on a system whose devices sit behind
an IOMMU:

    ======================================================
    WARNING: possible circular locking dependency detected
    7.3.0-rc1+ #84 Not tainted
    ------------------------------------------------------
    kworker/u34:0/57 is trying to acquire lock:
    ffff800104f83ee8 (&md->mutex){+.+.}-{4:4}, at: msi_domain_get_virq+0xf0/0x118

    but task is already holding lock:
    ffffc00081edd930 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x10/0x1c

    which lock already depends on the new lock.

    Chain exists of:
      &md->mutex --> &group->mutex --> cpu_hotplug_lock

The cycle is composed of three dependencies:

* cpu_hotplug_lock -> &md->mutex (which triggers the splat). virtio_net's
  init_vqs() calls cpus_read_lock() around virtnet_set_affinity(), which
  reaches vp_set_vq_affinity(). That calls pci_irq_vector(), which takes
  the per-device MSI mutex (&dev->msi.data->mutex) via
  msi_domain_get_virq().

* &md->mutex -> &domain->mutex -> &group->mutex.  MSI-X allocation of any
  device behind the IOMMU holds the MSI mutex while allocating interrupts
  through the IRQ domain hierarchy. The MSI parent domain (GICv2m, or ITS
  likewise) calls iommu_dma_prepare_msi() from its .alloc() to map the MSI
  doorbell, which takes the IOMMU group mutex.

* &group->mutex -> cpu_hotplug_lock. bus_iommu_probe() calls
  iommu_setup_dma_ops() under the group mutex; initializing the IOVA
  rcaches registers a cpuhp instance, which takes cpu_hotplug_lock.

The cycle only became complete since commit 288683c92b1a ("iommu: Make
iommu_dma_prepare_msi() into a generic operation"), where
iommu_dma_prepare_msi() switched to use the group mutex.

pci_irq_vector() is a pure lookup of a vector that is bound to the
queue for the whole lifetime of the queue, so there is no reason to
take the MSI mutex for it from cpu hotplug locked contexts.

Cache the IRQ number in virtio_pci_vq_info {} at vector binding time and
make vp_set_vq_affinity() use the cached value.

This also covers the CPU hotplug callbacks
(virtnet_cpu_online/virtnet_cpu_dead), which call virtnet_set_affinity()
with cpu_hotplug_lock already held.

Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
---
 drivers/virtio/virtio_pci_common.c | 12 +++++++++++-
 drivers/virtio/virtio_pci_common.h |  3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b90c174450b2..2f42300a8a84 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -224,6 +224,16 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
 		goto out_info;
 
 	info->vq = vq;
+
+	/*
+	 * Cache the Linux IRQ number so that later users (e.g.
+	 * vp_set_vq_affinity() from cpu hotplug locked contexts)
+	 * don't have to take the MSI mutex via pci_irq_vector().
+	 */
+	info->virq = 0;
+	if (msix_vec != VIRTIO_MSI_NO_VECTOR)
+		info->virq = pci_irq_vector(vp_dev->pci_dev, msix_vec);
+
 	if (callback) {
 		spin_lock_irqsave(&vp_dev->lock, flags);
 		if (!vp_is_slow_path_vector(msix_vec))
@@ -571,7 +581,7 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 
 	if (vp_dev->msix_enabled) {
 		mask = vp_dev->msix_affinity_masks[info->msix_vector];
-		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
+		irq = info->virq;
 		if (!cpu_mask)
 			irq_update_affinity_hint(irq, NULL);
 		else {
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..18b15a5f84ae 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -40,6 +40,9 @@ struct virtio_pci_vq_info {
 
 	/* MSI-X vector (or none) */
 	unsigned int msix_vector;
+
+	/* Linux IRQ number of msix_vector, or 0 if not mapped */
+	unsigned int virq;
 };
 
 struct virtio_pci_admin_vq {
-- 
2.56.0

