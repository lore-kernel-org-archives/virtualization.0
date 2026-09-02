Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8364A8C
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315447; cv=none; b=SCU/Lc+FDQ/k315XrSj7QnUSz0DKdvwrpV3eoekXW4YPdrw+9ZHgzK5byfO2ykHa+tKMTyYnLFOLXVAxkrUp6I6K4dj+JlzdSCe/l/blwHdFWLUu/64MDP0S/pA+tagcsgs2n5rV7QiXov+gZTeJpNJOvI5ED83mmt2LOh+Lirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315447; c=relaxed/simple;
	bh=X6SEXN1MtL4C4qVSQL1EWtj1D+RmSsIzlH9OBqfHTv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozCPIEliXpLZzDR78+VfnsgwmXqL88Ag/U798N+2gJ+uHgGQPPRU+WGn5NDlj+7SZYGBxezHSI9hBHFIvVK+1CjXQrIDbCSgQB5WB6A0nxSbpaqvVl/z7SeUD1r0hI7aqFR2S6j7zEWvDK377kdEmaP3KaR7iNAIpW7v5ajVZo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=N/CTSOZd; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="N/CTSOZd"
Received: from dog.kanata.rendec.net (pool-174-112-193-187.cpe.net.cable.rogers.com [174.112.193.187])
	by mail.mindbit.ro (Postfix) with ESMTPSA id C79DDCC9F8;
	Wed,  2 Sep 2026 05:07:49 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro C79DDCC9F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1788314871;
	bh=Cjajgd/jUGPexmsDns+dmEhiuhxFtpao5LJ1FXoMN8E=;
	h=From:To:Cc:Subject:Date:From;
	b=N/CTSOZdaQOM2dFSaa0XYxSOkFNS8jOjJjrqSyAplr9N9JlK5lfFZqnQYCy9njs2R
	 CSkqk9d2pUZ1xVqeB0vDrk5uaw3bmoUEz+aiINuTEHqUjTUrcwC4QTHau6fOGMIdpd
	 6W5oSsKuLhR8SQxhH207eVulAu9aEiU+c9VLZ1PUtSYg39k/6XirpLSr9YDeE3CmVd
	 4U9rerhuJony2/aqgDB5CBMHyS0XOC+XbAKa9VCRqvCnYjqX92GNrJorRdiBCwbg+e
	 OnsHtMGdn9J9xQfP9RHMOYRkX590pPMyPqC5PcCDhbXcx1tltRlN0+8Lwu9yC+/WBh
	 y8u8zpmVMzvOA==
From: Radu Rendec <radu@rendec.net>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: virtualization@lists.linux.dev,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] virtio: avoid hanging forever in reset
Date: Tue,  1 Sep 2026 22:07:41 -0400
Message-ID: <20260902020741.3686084-1-radu@rendec.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under certain conditions(*) vp_modern_get_status() can always return
0xff. This has a ripple effect that ultimately makes the system fail to
boot if the drivers are built-in and the virtio devices are probed
during boot:
 * vp_reset() for the virtio-net-pci device spins forever in the loop
   around vp_modern_get_status(mdev), which always returns 0xff.
 * vp_reset() is called in the context of the probe() function for the
   virtio-net-pci device, so probe() never returns.
 * the init task gets stuck in wait_for_device_probe() before it
   executes the real init binary.

Add a timeout to the reset function and make the device probing fail if
the reset function times out.

(*) This is not a theoretical problem. It happens on imx8mp-evk under
Qemu due to a relatively recent change to the dw_pcie driver that's
incompatible with the dw_pcie emulation in Qemu. I reported that bug
separately as a follow up to the patch that introduced it:
https://lore.kernel.org/all/ed86629d74368c6811e9f3b8f169584c0faf71ce.camel@rendec.net/

Signed-off-by: Radu Rendec <radu@rendec.net>
---
 drivers/remoteproc/remoteproc_virtio.c |  4 +++-
 drivers/virtio/virtio.c                |  8 +++++---
 drivers/virtio/virtio_mmio.c           |  5 ++++-
 drivers/virtio/virtio_pci_legacy.c     |  4 +++-
 drivers/virtio/virtio_pci_modern.c     | 15 ++++++++++++---
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_config.h          |  2 +-
 7 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index d5e9ff045a28..d103b80b1faf 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -231,7 +231,7 @@ static void rproc_virtio_set_status(struct virtio_device *vdev, u8 status)
 	dev_dbg(&vdev->dev, "status: %d\n", status);
 }
 
-static void rproc_virtio_reset(struct virtio_device *vdev)
+static int rproc_virtio_reset(struct virtio_device *vdev)
 {
 	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
 	struct fw_rsc_vdev *rsc;
@@ -240,6 +240,8 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
 
 	rsc->status = 0;
 	dev_dbg(&vdev->dev, "reset !\n");
+
+	return 0;
 }
 
 /* provide the vdev features as retrieved from the firmware */
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 75bb4ffe3b87..9542e4f7cb31 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -250,7 +250,7 @@ static int virtio_features_ok(struct virtio_device *dev)
  * call/workqueue/bh.  Invoking virtio_break_device then flushing any such
  * contexts is one way to handle that.
  * */
-void virtio_reset_device(struct virtio_device *dev)
+int virtio_reset_device(struct virtio_device *dev)
 {
 #ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	/*
@@ -263,7 +263,7 @@ void virtio_reset_device(struct virtio_device *dev)
 	virtio_synchronize_cbs(dev);
 #endif
 
-	dev->config->reset(dev);
+	return dev->config->reset(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
 
@@ -567,7 +567,9 @@ int register_virtio_device(struct virtio_device *dev)
 
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up.  This also tests that code path a little. */
-	virtio_reset_device(dev);
+	err = virtio_reset_device(dev);
+	if (err)
+		goto out_of_node_put;
 
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 316f03b97356..537d38841331 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -249,7 +249,7 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
 	writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
 }
 
-static void vm_reset(struct virtio_device *vdev)
+static int vm_reset(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 
@@ -260,7 +260,10 @@ static void vm_reset(struct virtio_device *vdev)
 		/* Wait for reset to complete. */
 		while (vm_get_status(vdev))
 			fsleep(1000);
+		/* TODO: add timeout */
 	}
+
+	return 0;
 }
 
 
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d9cbb02b35a1..2882756c7084 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -90,7 +90,7 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
 	vp_legacy_set_status(&vp_dev->ldev, status);
 }
 
-static void vp_reset(struct virtio_device *vdev)
+static int vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* 0 status means a reset. */
@@ -100,6 +100,8 @@ static void vp_reset(struct virtio_device *vdev)
 	vp_legacy_get_status(&vp_dev->ldev);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
+
+	return 0;
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..4a6906a18cfa 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -21,6 +21,7 @@
 #include "virtio_pci_common.h"
 
 #define VIRTIO_AVQ_SGS_MAX	4
+#define VIRTIO_PCI_RESET_TIMEOUT_MS 1000
 
 static void vp_get_features(struct virtio_device *vdev, u64 *features)
 {
@@ -543,10 +544,11 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
 		vp_modern_avq_activate(vdev);
 }
 
-static void vp_reset(struct virtio_device *vdev)
+static int vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	int timeout = VIRTIO_PCI_RESET_TIMEOUT_MS;
 
 	/* 0 status means a reset. */
 	vp_modern_set_status(mdev, 0);
@@ -555,13 +557,20 @@ static void vp_reset(struct virtio_device *vdev)
 	 * This will flush out the status write, and flush in device writes,
 	 * including MSI-X interrupts, if any.
 	 */
-	while (vp_modern_get_status(mdev))
-		msleep(1);
+	while (vp_modern_get_status(mdev)) {
+		if (!timeout--) {
+			dev_warn(&vdev->dev, "reset timeout");
+			return -ETIMEDOUT;
+		}
+		msleep(1000);
+	}
 
 	vp_modern_avq_cleanup(vdev);
 
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
+
+	return 0;
 }
 
 static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index f923e42cfd01..568e1bd95e4c 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -212,7 +212,7 @@ void virtio_config_driver_enable(struct virtio_device *dev);
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
 #endif
-void virtio_reset_device(struct virtio_device *dev);
+int virtio_reset_device(struct virtio_device *dev);
 void virtio_device_shutdown(struct virtio_device *dev);
 int virtio_device_reset_prepare(struct virtio_device *dev);
 int virtio_device_reset_done(struct virtio_device *dev);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..153426b0ae79 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -117,7 +117,7 @@ struct virtio_config_ops {
 	u32 (*generation)(struct virtio_device *vdev);
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
-	void (*reset)(struct virtio_device *vdev);
+	int (*reset)(struct virtio_device *vdev);
 	int (*find_vqs)(struct virtio_device *vdev, unsigned int nvqs,
 			struct virtqueue *vqs[],
 			struct virtqueue_info vqs_info[],
-- 
2.55.0

