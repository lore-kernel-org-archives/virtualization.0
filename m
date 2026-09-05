Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC54AE8DB
	for <virtualization@lists.linux.dev>; Sat,  5 Sep 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621685; cv=none; b=ZkJ+tgeXGpCYuHBFWbog2fX1sV7Cq3w1qlXQPKcvypD/p4uxtzanG6OqTyw51GHies1/vQNS1jH902OfqkUe7qJAgKjeBbDFDvJrGVS8ZhF2hesV47xRG/KEkgVFw5BgyVlQndYzCHcqYKqU39nPaMZGWI33yQcEdZxRXdriAyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621685; c=relaxed/simple;
	bh=o5w8meMgR85hvsqu/UmribMxya6NB2BOgGgde6W9CO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUbF/iZ9xx6f1MJSJT8BEfEp3vBS+/QAPuJpXDObcqx13VmUrd/ilF3tlA3PeivUFN27ZlJz3LkeWzqv9QBQbQgEIAC3TJwXMx0BtFgqarIOWbNcT1jEzXlk4Lms3Fo7nkGzHqZELZv06l9EH2h4fgDtuGXW8LtMXyThSbIwLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFeq1dJB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFeq1dJB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49cd9add88aso14600495e9.3
        for <virtualization@lists.linux.dev>; Sat, 05 Sep 2026 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788621677; x=1789226477; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tpulPZddhuPwIKcjBWNAE6zpuXjOxSBLaTnXCz35ckk=;
        b=UFeq1dJB2pABjwNr7miKytL1G+6kLWtTKykIvvYs7KSlZPaSlgqMiYwjI/jDohMnmp
         yeYdkBE7C9dCQN37cJlS+pJSPcu+VmpEnT1IfGbqq/YUZcP1QVHUybg9Xj5sQc4C+yap
         zlNHDjvodTDMtP9cYdX4OHH8W2rLWM/mi4MvCcrx25NkjIoOAIS8N9wBynGutnM/XYjY
         3e/vEYugS8/3wW0Y6wyo7vgFFEshBIzWeoq4abpBT1YUh0ZAOLJole3H1HszWJkJDUOz
         umsHGmYlfvdgtL7YLs+Sg7d2NlkgwCZFWI6eQMvmCkKHTZXshcfNuBpujhnJOP8mSiDZ
         UrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788621677; x=1789226477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tpulPZddhuPwIKcjBWNAE6zpuXjOxSBLaTnXCz35ckk=;
        b=j3gzyuiXFATQKL/UDwhQGNRrDLS7hC7HTAnrSgrIDonO4ASt0w+BsXf8vyx4R2L/9m
         aCSS5OP/5p6/zVlYkakVKscs9nJzQknqOLvPIX9gl6ymEpHVqg8Q81RpWbYZ6rjMtaaD
         aALPry72QJJZ/Lth4D/ejzaLJ5W7vMTFuhSvROaXUPW4QVJQuoZvVsYZB2iZnrq+LD4c
         u7wcPSysFqzLgGnrOSv7flwefZATmrX62hfjEHgFfgq3RXLVw2smWOusVXs9KdqWil/d
         1VcfRLF3m92329DlXtia4xSrbwewgR8EFJv8RjrYIZ3SScxFKhJ0OHk+SzvmI/OcO6Io
         XxIg==
X-Forwarded-Encrypted: i=1; AKwUvBz8o9RZGGQF/XEo7d57gps75oTLJl+5paAzvB+wm7le4N0j1OHKtI2vTC4HjwtHNzZ2rcsQn6TSgFYHHq2m/A==@lists.linux.dev
X-Gm-Message-State: AFuF++lvfO6n20NOLUKdkH6ciYMxxBSMtup1Oz2SRmbPA+/nlKYZV53C
	2DiRKPP6gO70CRcK3eaj+EMH8M4eJ1FMHjOLEGpH/B5Qau76wqEKK3tI
X-Gm-Gg: AYBFou1AiJ4fmbl/+gI9ftAi+ef8m7N6TrNGYFYSIDsACG76jk5PceEjw2KSkH5w8VL
	zzbkGnT6lzpSuR83JC9/0ijeL/gZLl+JseJr8zulRBgXnTr91VxHMpgdmTl2ErVsDuOBtcly4T7
	Z5gbu0kXbG4zq8p5x80CiMUaIc7AQDCbNNXvLtK9zI62MtB3VobHoxFPqRnSQPXZ7I/wwhy5QOc
	bfPsRvF+pcus5lfJFQlC4vAElz3xXWRGtiLNIrKCtQWlPKpCb/VU31xAW0uh4l2Q0Gh4QbYqnK9
	qoAWtgsGIKFq3Ha/mISmVyTPEMsyMV2+8MkX1kAfzIBMWdsHGUIthcLZMTFOAtiTYYeatzdzBLR
	jKMIaM6iFYINs+By+/osG3GCon0VxVtVZKzJ7cAuYvXDFmSoiaysLT25IxdI4ObNBqOeYO+vqBx
	vBsSxrq0X4nkynXKnO3hl1P54iE62iyGo85w3m4ASGUarT0/Oe6TfnJ6JJYjDL2dlUr9MkzJ733
	mhaB1J1t1Ja3q0uziDfpmdes4JaVSjurvckS8GH2lOx0SBGNgOu/Pex88y9DWn2syVldCVT3qyt
	ew4CnCVUiw3gVlvjmOCWGOuox1CI3hx8dIfBQznGvfJwQMrFljPxSEudx5A1HB/KsIU=
X-Received: by 2002:a05:600c:6209:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-49cfed6cd4dmr81095545e9.23.1788621677280;
        Sat, 05 Sep 2026 08:21:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm267779515e9.1.2026.09.05.08.21.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 08:21:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] virtio: synchronize callbacks during device reset
Date: Sat,  5 Sep 2026 17:20:57 +0200
Message-Id: <20260905152059.89560-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_reset_device() promises that vq callbacks have finished when it
returns. virtio-pci waits in vp_reset(), but other transports can return
with a callback still running.

Call virtio_synchronize_cbs() after config->reset() and drop the duplicate
waits from both PCI reset methods. Add the wait to virtio_device_shutdown()
too, since it calls config->reset() directly. Keep the pre-reset call under
CONFIG_VIRTIO_HARDEN_NOTIFICATION so callbacks see vq->broken.

Always take irq_lock in the classic virtio-ccw interrupt handler so it
pairs with synchronize_cbs even without notification hardening. Use
is_thinint to choose the lock: airq_info can stay allocated after a
fallback to classic interrupts.

The transport reset must still stop new callbacks before this wait.

Fixes: d9679d0013a6 ("virtio: wrap config->reset calls")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/s390/virtio/virtio_ccw.c   | 6 +-----
 drivers/virtio/virtio.c            | 2 ++
 drivers/virtio/virtio_pci_legacy.c | 2 --
 drivers/virtio/virtio_pci_modern.c | 3 ---
 include/linux/virtio_config.h      | 6 +++---
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index bab6cad3fd5c..552d77998012 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1062,7 +1062,7 @@ static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	struct airq_info *info = vcdev->airq_info;
 
-	if (info) {
+	if (vcdev->is_thinint && info) {
 		/*
 		 * This device uses adapter interrupts: synchronize with
 		 * vring_interrupt() called by virtio_airq_handler()
@@ -1204,13 +1204,11 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			vcdev->err = -EIO;
 	}
 	virtio_ccw_check_activity(vcdev, activity);
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	/*
 	 * Paired with virtio_ccw_synchronize_cbs() and interrupts are
 	 * disabled here.
 	 */
 	read_lock(&vcdev->irq_lock);
-#endif
 	for_each_set_bit(i, indicators(vcdev),
 			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
@@ -1219,9 +1217,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 		vq = virtio_ccw_vq_by_ind(vcdev, i);
 		vring_interrupt(0, vq);
 	}
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	read_unlock(&vcdev->irq_lock);
-#endif
 	if (test_bit(0, indicators2(vcdev))) {
 		virtio_config_changed(&vcdev->vdev);
 		clear_bit(0, indicators2(vcdev));
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 75bb4ffe3b87..ad1c50b8a94e 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -264,6 +264,7 @@ void virtio_reset_device(struct virtio_device *dev)
 #endif
 
 	dev->config->reset(dev);
+	virtio_synchronize_cbs(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
 
@@ -424,6 +425,7 @@ void virtio_device_shutdown(struct virtio_device *dev)
 	 * Some devices get wedged if this happens, so reset to make sure it does not.
 	 */
 	dev->config->reset(dev);
+	virtio_synchronize_cbs(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_device_shutdown);
 
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d9cbb02b35a1..8115aa39e01e 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
 	vp_legacy_get_status(&vp_dev->ldev);
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..c9e21317c51a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -559,9 +559,6 @@ static void vp_reset(struct virtio_device *vdev)
 		msleep(1);
 
 	vp_modern_avq_cleanup(vdev);
-
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..8684a1e268ee 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -71,9 +71,9 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
  * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
- *      The function guarantees that all memory operations on the
- *      queue before it are visible to the vring_interrupt() that is
- *      called after it.
+ *      Wait for running callbacks to complete. Memory operations on the
+ *      queue before this call must be visible to vring_interrupt() calls
+ *      that follow it.
  *      vdev: the virtio_device
  * @get_features: get the array of feature bits for this device.
  *	vdev: the virtio_device
-- 
2.39.5 (Apple Git-154)
