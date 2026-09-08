Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2A37F8CA
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845994; cv=none; b=M9bFYTCaFcpCHbypl5xHHu6p2p/gqwfixwmQLeZuKdiudkIKpsgmBiaW8hxxvqx00jMgKzFQ42q6DNLjF1JhEDw5PufBcbvIAQl4C0Z3uL7n9ojUXH5egYxNkG6HOzudXWQ135QA8hEP9Ob+qiKywYztegcLZE1Nq9S9cPO2YPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845994; c=relaxed/simple;
	bh=Z1mqy3qNtdRxgKwEWqMkljOG1k4ekHUKiS2/6Ca17Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJyOx2OwQTsHHrQ+7X8hICTOcyseKhsmbYbsDsWk9Cb6Q5X7GaAOtwV+0XviX8taKc/S2UKHaBgoTSiT/2phMGEodTkv64+HLPsYyiUxoYawdqBTpznvehVZj0yJHxSKbZSGTQ6R/FqOP2YEJNpxYRM93c2/lUYuzDhmFLvHa+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+VPNPyY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+VPNPyY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso40940875e9.0
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845988; x=1789450788; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0UrpxibHZnDBNXE1bN5qrJqc7sTw2Bd+aGpZLtd0Ug=;
        b=H+VPNPyYElbY+xRIn7UkerlTc427qmGq3bCNfgT9F8t05i+4SUEXMtr2n9T2tiQHvs
         sDdvIXXullpQPkftP2oL0/79E3Egto5B28lpGPUpkwd1KE0SZimXNK5wy/04rRbode/p
         tyNuRdoDVyZJ5rp/UlMYQ6ugs5FlwwCJi9d5rYqYa4qgOHcfvPOg24oubdqsLpUprHQV
         Zl9JRTErfmrzJfvJbBXfYnIi4PASdMvg8A3yccPCQHkManaWBnKSpSnfCYRy+BJIiVgS
         1tlBMAfEKZ0J60cRpdrMjfW2r9ZIhOUKwDXS0xYwamzhQtuvI+61KAy1vOpR+NvRSO6s
         zNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845988; x=1789450788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0UrpxibHZnDBNXE1bN5qrJqc7sTw2Bd+aGpZLtd0Ug=;
        b=om37OtSTmj1lfog2xCGYaUa5Mi6xcysEYnIGQHJ/ly0hq1ehQd/VUB9XXqtUIUO/8c
         zcJBDDMicNfE2USViO3Z7MWFyhQ7huLM4ZxlhtRlefHfeFvTHGiczTD+n/ylHafRfrM8
         5hqeBqG4JC82v0Pa426GDMg39Ocp5dwU6jix6DksxGu+ljoYQJex6KJ9e81rQbUZ6RHh
         ijTObUozUAOU12xtfuP+4ckD8yYQUTAqoEaMmMiyQZ98q84xd7UNUGyYi9En00LGTgKr
         /UrxpQFEEr/kW64W8ADtwDNKuygZsNtgbF6ooPHD7NSNTJ4C5YKVTNAZdEFWBhLVmfZ1
         iY+w==
X-Forwarded-Encrypted: i=1; AKwUvBwDohi1EZGAU0LIRKqTb+IaMyI6YMoTQ7JaWl7MNNvsWUJETCMvYkorEhKLe3vbQfkRrVyofkCiTbKBUIYOvQ==@lists.linux.dev
X-Gm-Message-State: AFuF++ljGnjBuDv7SFFl2wWUm1QSuQjIp5giAtWPtZlZPdQclYW+buU0
	ywubPmBysMZL13F5K3u3+INkG1kzSDFaPTHHRa+SJxhPZeiSHAWvj6fF
X-Gm-Gg: AYBFou3zIz7e36OqeiQ/mBkRNMuGqgvgTi5Gh1EuGqN8DDWmsVD8jw0OsDz5fX/4eMd
	7UuJ7E5NLPo0lNnsGrPrrGKsm5BzzsASpOnrUkf42BawN3HeblOiDuU4qfItxlFjIONAgODr6sH
	1OGQOv3JxPxP2R1tvP5IfL9tAwt0AKUG0rBtQdbSZazfMwLUud7/AaRqCy7Yxs7KxPAD7T4HrZJ
	1Twe9+TVf64FJ8U52EHmdtbPxgj3EX/TiUr15E7FBMvhQq/RVCLzXsKyU90aLqJN2m9kB+w2Qjr
	9Nwj1/I+1tFwc0zKNPd3YqKUIkzj4shQGdFDyoNz8BdGmYVB2nzM7Ry3LwN47bKg4rXo5tukhCc
	ViLhJw9tjpI9G04annWsyLQTRaagRzU69yJUG16OSodeXthUvREu43zy5AoWiXPPJvrxJ16Wx27
	dvwFtim5N/mMk4c4i5NjCmO35OsAHa0buOt3/ZOdNufEqnmglnfId+tpuz/2aR9qZizBLToMadt
	o+sNqzHqxGUvsU1nQiA4IaT2In1cTDllPu8RJ74lu3rNM/8mL2YzY+H5g2by8vY29UQys6VIqqr
	6ttcFpRXqCkGisfeU/PgzIdS+3XELDA=
X-Received: by 2002:a05:600c:3587:b0:49d:17d8:abec with SMTP id 5b1f17b1804b1-49d17d8abf5mr31972855e9.21.1788845987998;
        Mon, 07 Sep 2026 22:39:47 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:47 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
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
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 6/6] virtio_vdpa: implement synchronize_cbs()
Date: Tue,  8 Sep 2026 07:38:17 +0200
Message-Id: <20260908053817.26065-7-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_vdpa relies on the core's synchronize_rcu() fallback for callback
synchronization. That covers IRQ handlers and sections with interrupts,
preemption or bottom halves disabled. virtio_vdpa does not enforce any
of those contexts when a vDPA driver invokes a callback.

Add an SRCU domain per device and enter it around the virtqueue and
config callbacks. Implement synchronize_cbs() with synchronize_srcu()
so it covers the callbacks regardless of the calling context.

SRCU uses per-CPU reader accounting, avoiding a single callback lock
shared by all queues. Cover the config callback too, as virtio-pci
does for its config vector.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio_vdpa.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 6bcf4567a929..f9559b6b2e0b 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/srcu.h>
 #include <linux/uuid.h>
 #include <linux/group_cpus.h>
 #include <linux/virtio.h>
@@ -27,6 +28,7 @@
 struct virtio_vdpa_device {
 	struct virtio_device vdev;
 	struct vdpa_device *vdpa;
+	struct srcu_struct cb_srcu;
 	u64 features;
 };
 
@@ -114,8 +116,11 @@ static bool virtio_vdpa_notify_with_data(struct virtqueue *vq)
 static irqreturn_t virtio_vdpa_config_cb(void *private)
 {
 	struct virtio_vdpa_device *vd_dev = private;
+	int idx;
 
+	idx = srcu_read_lock(&vd_dev->cb_srcu);
 	virtio_config_changed(&vd_dev->vdev);
+	srcu_read_unlock(&vd_dev->cb_srcu, idx);
 
 	return IRQ_HANDLED;
 }
@@ -123,8 +128,22 @@ static irqreturn_t virtio_vdpa_config_cb(void *private)
 static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
 {
 	struct virtqueue *vq = private;
+	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vq->vdev);
+	irqreturn_t ret;
+	int idx;
+
+	idx = srcu_read_lock(&vd_dev->cb_srcu);
+	ret = vring_interrupt(0, vq);
+	srcu_read_unlock(&vd_dev->cb_srcu, idx);
+
+	return ret;
+}
+
+static void virtio_vdpa_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 
-	return vring_interrupt(0, vq);
+	synchronize_srcu(&vd_dev->cb_srcu);
 }
 
 static struct virtqueue *
@@ -440,6 +459,7 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
 	.reset		= virtio_vdpa_reset,
 	.find_vqs	= virtio_vdpa_find_vqs,
 	.del_vqs	= virtio_vdpa_del_vqs,
+	.synchronize_cbs = virtio_vdpa_synchronize_cbs,
 	.get_features	= virtio_vdpa_get_features,
 	.finalize_features = virtio_vdpa_finalize_features,
 	.bus_name	= virtio_vdpa_bus_name,
@@ -454,6 +474,7 @@ static void virtio_vdpa_release_dev(struct device *_d)
 	struct virtio_vdpa_device *vd_dev =
 	       container_of(vdev, struct virtio_vdpa_device, vdev);
 
+	cleanup_srcu_struct(&vd_dev->cb_srcu);
 	kfree(vd_dev);
 }
 
@@ -467,6 +488,11 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	if (!vd_dev)
 		return -ENOMEM;
 
+	if (init_srcu_struct(&vd_dev->cb_srcu)) {
+		kfree(vd_dev);
+		return -ENOMEM;
+	}
+
 	vd_dev->vdev.dev.parent = vdpa->map ? &vdpa->dev :
 				  vdpa_get_map(vdpa).dma_dev;
 	vd_dev->vdev.dev.release = virtio_vdpa_release_dev;
@@ -489,10 +515,12 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	return 0;
 
 err:
-	if (reg_dev)
+	if (reg_dev) {
 		put_device(&vd_dev->vdev.dev);
-	else
+	} else {
+		cleanup_srcu_struct(&vd_dev->cb_srcu);
 		kfree(vd_dev);
+	}
 	return ret;
 }
 
-- 
2.39.5 (Apple Git-154)
