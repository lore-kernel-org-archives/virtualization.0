Received: from mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B733F59A
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080635; cv=none; b=odCb/Y2LQasUuXCtK938Ibc06XJDXGx+tyeUvP3CDn6ofHvMQ+ljsSU2zaKau+qP8VWFqptDmqS4OSzxS+tzdZ54HLVVcY3qvX0Vnj1bCZ5hG0EkwFa8TSQ6Q9ys0k3O7ZViU/aBNuunH9u3lhYSV2/028xY+nTjS80sIKkC5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080635; c=relaxed/simple;
	bh=/wWM1O7+jECTaTFVDaIS2R+n4/QQ6bdoXIsJIVwL0cY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=hOjgGR28YW0Haa1uqL2kyQ3l3s0cCcO/MbWrIOB0+oBNWBLIydQkvINtxb2FqQv6GkP/uEEopTFi0RExeEfSM7S4LCil+ezR18GI1ZawIal2S5vQifWjwPiu3oQudUMFCla2acM5ihbWx9iZ+wzOU3QcVrp8hsRy6AY/UmXT/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hs0SWFVt; arc=none smtp.client-ip=95.215.58.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hs0SWFVt"
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=/wWM1O7+jECTaTFVDaIS2R+n4/QQ6bdoXIsJIVwL0cY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790080630; v=1; x=1790685430;
 b=Hs0SWFVtM8wZJIvXWIRXpgvPr95HB62hajupdWi2PU1vQo2ywDBXOgKVXu/voaqLMVUko9p5
 plSxtYOxWJRuXYrZVbeZC8YIoNrAQ5YYY2puun3OuQGVS1rws2Tb3uUnXnHCDYYWVgHxhqq3yO3
 kLM649rbnrtGghRFBn8KUckg=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id daaa1f66b4a6125f;
	Tue, 22 Sep 2026 12:37:09 +0000
X-Mizu-Trace-ID: daaa1f66b4a6125f
X-Migadu-Flow: FLOW_OUT
Message-ID: <98f2f4f9-a7fe-413e-a366-7bed08290697@linux.dev>
Date: Tue, 22 Sep 2026 20:37:04 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
Subject: [virtio_pci?] WARNING: possible circular locking dependency detected
To: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, nicolinc@nvidia.com,
 jgg@ziepe.ca
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi folks,

I hit the following lockdep splat in an arm64 guest whose PCI devices sit
behind an SMMUv3.

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

The cycle is built from three dependencies:

* cpu_hotplug_lock -> &md_mutex (which triggers the splat).  virtio_net's
  init_vqs() calls cpus_read_lock() around virtnet_set_affinity(), which
  reaches vp_set_vq_affinity().  That calls pci_irq_vector(), which takes
  the per-device MSI mutex (&dev->msi.data->mutex) via
  msi_domain_get_virq().

* &md->mutex -> &domain->mutex -> &group->mutex.  MSI-X allocation of any
  device behind the IOMMU holds the MSI mutex while allocating interrupts
  through the IRQ domain hierarchy.  The MSI parent domain (GICv2m, or ITS
  likewise) calls iommu_dma_prepare_msi() from its .alloc() to map the MSI
  doorbell, which takes the IOMMU group mutex.

* &group->mutex -> cpu_hotplug_lock.  bus_iommu_probe() calls
  iommu_setup_dma_ops() under the group mutex; initializing the IOVA
  rcaches registers a cpuhp instance, which takes cpu_hotplug_lock.

The cycle only became complete since commit 288683c92b1a ("iommu: Make
iommu_dma_prepare_msi() into a generic operation"), where
iommu_dma_prepare_msi() switched to use the group mutex.

Caching the IRQ number in virtio_pci_vq_info {} (and making
vp_set_vq_affinity() use the cached value) removes the first dependency.
But I'm not sure if this is an appropriate fix.  Please have a look.

---8<---

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
+	info->virq = pci_irq_vector(vp_dev->pci_dev, msix_vec);
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

Thanks,
Zenghui
