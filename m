Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793367028;
	b=lrtshezehXYNF9uV/ggHjqSU3vba+YSpQGHdGWj3jtRnAnn2Ee/LbNzrB2SiezukZ+wP
	 nV5lA7mPuZehoki/AduLAEiCO7ogtqYr7c45sSxD5dn2QHI8wjp99QbrfNfjZocYhiayQ
	 eKqomNhavH2FU1xMa0TuFLR2GMvHHudfilAZ8sdKfSOVpjFIQkrqyUY+AxV6j9Khn8c3O
	 IFHFwvosL+BNYN7PuLUq8bKJGC3jh7B29AVWAXtWOBfWjJ+vbzJR6NvtgcKaThaUfVzXo
	 9R4zei6fIIh8jzBDjRn9KfL7SBOsSHpHWI1iCzW+7SgJMa4MvYqQ8e9/74UFVdU6Bbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367028;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=kPLJdMdCYaFPwA3nXO5GxGvHMoOb6ZI73KYLn5eKbME=;
	b=veXz+60uSEdfJqEL8RYhPI9KIZKvTSs/n2cSbBtV7Mbl9QjCT2s1lFXsUvXUjGTw0fYQ
	 5IIvpC2jC7PsYBQJJ2NE9zzvEfZ4DUzb+GO+X03qWo/4kteOEFB+d+AYMlVehr2uy/K//
	 Mt4KlwUOWt98vl8aMLyfKX2MkqDivWu/dj3Xmi+vTbBNLzzHkKLWJpcdwRDsGjOo1GPFc
	 y3DJahYrfhBGhiI228Dcz4zujS7nVY+rhqoY8YvYH3mbBzo5MeAIFb22BwtPgymEJZMq1
	 aYilmOKbGpTeo/X5nhEXc6XJ8kijJzoc5rcHy/nNFbcEe8FZn6+q7ffturK4WTdFMKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.eu;
	spf=pass smtp.mailfrom=zohomail.eu;
	dkim=pass header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=Hj3Ppuq+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
Received: from sender-pp-o97.zoho.eu (sender-pp-o97.zoho.eu [136.143.169.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159B606A323
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 13:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5159B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=Hj3Ppuq+
ARC-Seal: i=1; a=rsa-sha256; t=1793367008; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=WUYlcEj+LObzmDOaKJQnkIyt4RYCfUPRlHn2f5wGaW/vX1Mbuj56muf7NTJYJpyscn+TKExsHBvGLck3qKAgjc6dwHHPS2h+TnKHUEbTdKIwp9wbLtMi6gb8d8DXSCr4XT5kvDjq6M/hSSKeLNNpJplfx84ooI2JDBlrAEPE28M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793367008; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kPLJdMdCYaFPwA3nXO5GxGvHMoOb6ZI73KYLn5eKbME=; 
	b=YmxEwH4jLPqgbAF7PYXmCFhIzXDYQleDl5XNxdz2CMxpXQuaxVrP8YCwog+eS7AgzicreBdxjetiFuM7dXhAfHKXhV0WM4/L2NNGeXrRJ9wrTeGM4q1U6TqoirJkMvsYdWCNmx9pDWYCGa+2yTd2KJZJTP9bL84tAkG0rB6GQ5s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=zohomail.eu;
	spf=pass  smtp.mailfrom=harukak@zohomail.eu;
	dmarc=pass header.from=<harukak@zohomail.eu>
DKIM-Signature: a=rsa-sha256; b=Hj3Ppuq+Bx+sVNcG22+hAvqGYwwyhp1qzkKHh9IuCsmI8KoHxYNbRunm89p3RFWk0zwZo3MZr0rdbcjv+Wbmdo+PdULLr4eeg4xQ0tDChj2oi0DPprL9RPJWupDMQcjyuHJL2EdndqyMk136VMHCDYYxYdMU3lnGbn2WWI1l5CA=; c=relaxed/relaxed; s=zoho; d=zohomail.eu; v=1; bh=kPLJdMdCYaFPwA3nXO5GxGvHMoOb6ZI73KYLn5eKbME=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793367007723776.6676224323274;
	Fri, 30 Oct 2026 14:30:07 +0100 (CET)
From: Haruka Kuze <harukak@zohomail.eu>
To: Jens Wiklander <jenswi@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Tomas Winkler <tomas.winkler@sandisk.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	virtualization@lists.linux.dev,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] rpmb: add a virtio RPMB device driver
Date: Fri, 30 Oct 2026 22:30:00 +0900
Message-ID: <20261030133000.24147-3-harukak@zohomail.eu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030133000.24147-1-harukak@zohomail.eu>
References: <20261030133000.24147-1-harukak@zohomail.eu>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Haruka Kuze <harukak@zohomail.eu>

No driver exists for virtio-rpmb devices (virtio ID 28), so OP-TEE
running in a guest can not use them.

This registers the virtio-rpmb devices found with the RPMB sub-system.
Each request is done in one transfer on request queue, and for key
programming and data writing a result read frame is appended so that
the device can return the result.

These frames are copied since the caller's buffers are not always
usable for DMA.

These frames follow the emmc definition, so that the device is
registered as RPMB_TYPE_EMMC. The device has no identifier of own, so
that a fixed dev_id is used for the key derivation for the device.

Based on the virtio-rpmb driver in Alex Bennée's RPMB series.

Link: https://lore.kernel.org/all/20220405093759.1126835-4-alex.bennee@linaro.org/
Signed-off-by: Haruka Kuze <harukak@zohomail.eu>
---
 MAINTAINERS                      |   7 +
 drivers/misc/Kconfig             |  10 ++
 drivers/misc/Makefile            |   1 +
 drivers/misc/virtio_rpmb.c       | 300 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_rpmb.h |  56 ++++++
 5 files changed, 374 insertions(+)
 create mode 100644 drivers/misc/virtio_rpmb.c
 create mode 100644 include/uapi/linux/virtio_rpmb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 748ce4d1c6a2..488003a28534 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29707,6 +29707,13 @@ S:	Maintained
 F:	drivers/char/hw_random/virtio-rng.c
 F:	include/uapi/linux/virtio_rng.h
 
+VIRTIO RPMB DRIVER
+M:	Haruka Kuze <harukak@zohomail.eu>
+L:	virtualization@lists.linux.dev
+S:	Maintained
+F:	drivers/misc/virtio_rpmb.c
+F:	include/uapi/linux/virtio_rpmb.h
+
 VIRTIO RTC DRIVER
 M:	Peter Hilber <peter.hilber@oss.qualcomm.com>
 L:	virtualization@lists.linux.dev
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index c40e89cc5724..eb3518ecc8fe 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -91,6 +91,16 @@ config RPMB
 
 	  If unsure, select N.
 
+config VIRTIO_RPMB
+	tristate "Virtio RPMB driver"
+	depends on VIRTIO && RPMB
+	help
+	  Driver for virtio RPMB devices. The device is registered with the
+	  RPMB subsystem, where in-kernel users such as OP-TEE can use it.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called virtio_rpmb.
+
 config TI_FPC202
 	tristate "TI FPC202 Dual Port Controller"
 	depends on I2C
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 7cc3d615d37a..e4390bb8bdc0 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_PHANTOM)		+= phantom.o
 obj-$(CONFIG_RPMB)		+= rpmb-core.o
+obj-$(CONFIG_VIRTIO_RPMB)	+= virtio_rpmb.o
 obj-$(CONFIG_QCOM_COINCELL)	+= qcom-coincell.o
 obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
 obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
diff --git a/drivers/misc/virtio_rpmb.c b/drivers/misc/virtio_rpmb.c
new file mode 100644
index 000000000000..046ed1ca6681
--- /dev/null
+++ b/drivers/misc/virtio_rpmb.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtio RPMB driver
+ *
+ * Copyright (c) 2018-2019 Intel Corporation.
+ * Copyright (c) 2021-2022 Linaro Ltd.
+ *
+ * Based on the virtio-rpmb driver in Alex Bennée's RPMB series.
+ */
+
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rpmb.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_rpmb.h>
+
+#define VIRTIO_RPMB_FRAME_SIZE	sizeof(struct virtio_rpmb_frame)
+static_assert(VIRTIO_RPMB_FRAME_SIZE == 512);
+
+/*
+ * This device has no identifier on its own.
+ * This value is used as input when OP-TEE is deriving the RPMB
+ * key, so it shall stay stable.
+ */
+static const u8 virtio_rpmb_dev_id[16] = "virtio-rpmb";
+
+/**
+ * struct virtio_rpmb - virtio RPMB device state
+ * @vdev: virtio device
+ * @vq: request queue, NULL while the device is gone or frozen
+ * @lock: serializes requests and protects @vq
+ * @vq_lock: serializes virtqueue operations with the completion callback
+ * @rdev: RPMB device
+ * @max_wr: maximum number of blocks in one write request, 0 if unlimited
+ * @max_rd: maximum number of blocks in one read request, 0 if unlimited
+ */
+struct virtio_rpmb {
+	struct virtio_device *vdev;
+	struct virtqueue *vq;
+	struct mutex lock;
+	spinlock_t vq_lock;
+	struct rpmb_dev *rdev;
+	u8 max_wr;
+	u8 max_rd;
+};
+
+struct virtio_rpmb_req {
+	struct completion done;
+	unsigned int len;
+};
+
+static void virtio_rpmb_done(struct virtqueue *vq)
+{
+	struct virtio_rpmb *vr = vq->vdev->priv;
+	struct virtio_rpmb_req *req;
+	unsigned int len;
+
+	guard(spinlock_irqsave)(&vr->vq_lock);
+	while ((req = virtqueue_get_buf(vq, &len))) {
+		req->len = len;
+		complete(&req->done);
+	}
+}
+
+static int virtio_rpmb_xfer(struct virtio_rpmb *vr, void *out,
+			    unsigned int out_len, void *in, unsigned int in_len)
+{
+	struct scatterlist out_sg, in_sg, *sgs[2] = { &out_sg, &in_sg };
+	struct virtio_rpmb_req req;
+	int ret;
+
+	sg_init_one(&out_sg, out, out_len);
+	sg_init_one(&in_sg, in, in_len);
+	init_completion(&req.done);
+
+	guard(mutex)(&vr->lock);
+	if (!vr->vq)
+		return -ENODEV;
+
+	scoped_guard(spinlock_irqsave, &vr->vq_lock) {
+		ret = virtqueue_add_sgs(vr->vq, sgs, 1, 1, &req, GFP_ATOMIC);
+		if (ret)
+			return ret;
+		virtqueue_kick(vr->vq);
+	}
+
+	wait_for_completion(&req.done);
+
+	return req.len == in_len ? 0 : -EIO;
+}
+
+static int virtio_rpmb_route_frames(struct device *dev, u8 *req,
+				    unsigned int req_len, u8 *resp,
+				    unsigned int resp_len)
+{
+	struct virtio_rpmb *vr = dev_to_virtio(dev)->priv;
+	struct virtio_rpmb_frame *frm = (struct virtio_rpmb_frame *)req;
+	struct virtio_rpmb_frame *result;
+	unsigned int out_len = req_len;
+	bool result_read = false;
+	void *out, *in;
+	int ret;
+
+	if (req_len < VIRTIO_RPMB_FRAME_SIZE)
+		return -EINVAL;
+
+	switch (be16_to_cpu(frm->req_resp)) {
+	case VIRTIO_RPMB_REQ_PROGRAM_KEY:
+		if (req_len != VIRTIO_RPMB_FRAME_SIZE ||
+		    resp_len != VIRTIO_RPMB_FRAME_SIZE)
+			return -EINVAL;
+		result_read = true;
+		break;
+	case VIRTIO_RPMB_REQ_GET_WRITE_COUNTER:
+		if (req_len != VIRTIO_RPMB_FRAME_SIZE ||
+		    resp_len != VIRTIO_RPMB_FRAME_SIZE)
+			return -EINVAL;
+		break;
+	case VIRTIO_RPMB_REQ_DATA_WRITE:
+		if (req_len % VIRTIO_RPMB_FRAME_SIZE ||
+		    resp_len != VIRTIO_RPMB_FRAME_SIZE)
+			return -EINVAL;
+		if (vr->max_wr && req_len / VIRTIO_RPMB_FRAME_SIZE > vr->max_wr)
+			return -EINVAL;
+		result_read = true;
+		break;
+	case VIRTIO_RPMB_REQ_DATA_READ:
+		if (req_len != VIRTIO_RPMB_FRAME_SIZE ||
+		    !resp_len || resp_len % VIRTIO_RPMB_FRAME_SIZE)
+			return -EINVAL;
+		if (vr->max_rd && resp_len / VIRTIO_RPMB_FRAME_SIZE > vr->max_rd)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * The caller's buffers may be unsuitable for DMA, so
+	 * copy the frames.  Writes are followed by result read
+	 * request in the same rpmb xfer, which makes the
+	 * device return the result.
+	 */
+	if (result_read)
+		out_len += VIRTIO_RPMB_FRAME_SIZE;
+
+	out = kmalloc(out_len, GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+	in = kzalloc(resp_len, GFP_KERNEL);
+	if (!in) {
+		kfree(out);
+		return -ENOMEM;
+	}
+
+	memcpy(out, req, req_len);
+	if (result_read) {
+		result = out + req_len;
+		memset(result, 0, sizeof(*result));
+		result->block_count = cpu_to_be16(1);
+		result->req_resp = cpu_to_be16(VIRTIO_RPMB_REQ_RESULT_READ);
+	}
+
+	ret = virtio_rpmb_xfer(vr, out, out_len, in, resp_len);
+	if (!ret)
+		memcpy(resp, in, resp_len);
+
+	kfree(in);
+	kfree(out);
+	return ret;
+}
+
+static int virtio_rpmb_init_vq(struct virtio_rpmb *vr)
+{
+	struct virtqueue *vq;
+
+	vq = virtio_find_single_vq(vr->vdev, virtio_rpmb_done, "request");
+	if (IS_ERR(vq))
+		return PTR_ERR(vq);
+
+	virtio_device_ready(vr->vdev);
+
+	scoped_guard(mutex, &vr->lock)
+		vr->vq = vq;
+	return 0;
+}
+
+static void virtio_rpmb_del_vq(struct virtio_rpmb *vr)
+{
+	struct virtio_device *vdev = vr->vdev;
+
+	scoped_guard(mutex, &vr->lock) {
+		if (!vr->vq)
+			return;
+		vr->vq = NULL;
+	}
+
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+}
+
+static int virtio_rpmb_probe(struct virtio_device *vdev)
+{
+	struct rpmb_descr descr = {
+		/* Frames and their semantics are that of eMMC */
+		.type = RPMB_TYPE_EMMC,
+		.route_frames = virtio_rpmb_route_frames,
+		.dev_id = (u8 *)virtio_rpmb_dev_id,
+		.dev_id_len = sizeof(virtio_rpmb_dev_id),
+	};
+	struct virtio_rpmb *vr;
+	u8 capacity;
+	int ret;
+
+	capacity = virtio_cread8(vdev, offsetof(struct virtio_rpmb_config,
+						capacity));
+	if (!capacity || capacity > 0x80)
+		return dev_err_probe(&vdev->dev, -EINVAL,
+				     "invalid capacity %u\n", capacity);
+
+	vr = devm_kzalloc(&vdev->dev, sizeof(*vr), GFP_KERNEL);
+	if (!vr)
+		return -ENOMEM;
+
+	vdev->priv = vr;
+	vr->vdev = vdev;
+	mutex_init(&vr->lock);
+	spin_lock_init(&vr->vq_lock);
+	vr->max_wr = virtio_cread8(vdev, offsetof(struct virtio_rpmb_config,
+						  max_wr_cnt));
+	vr->max_rd = virtio_cread8(vdev, offsetof(struct virtio_rpmb_config,
+						  max_rd_cnt));
+
+	ret = virtio_rpmb_init_vq(vr);
+	if (ret)
+		return ret;
+
+	/*
+	 * reliable_wr_count is in 512 byte sectors, as defined in
+	 * struct rpmb_descr. But OP-TEE turns that back into 256 byte
+	 * frames for eMMC. So halve max_wr here.
+	 *
+	 * With max_wr of 1 this is 0, which makes OP-TEE write one frame
+	 * at a time.
+	 */
+	descr.capacity = capacity;
+	descr.reliable_wr_count = (vr->max_wr ?: U8_MAX) / 2;
+
+	vr->rdev = rpmb_dev_register(&vdev->dev, &descr);
+	if (IS_ERR(vr->rdev)) {
+		virtio_rpmb_del_vq(vr);
+		return PTR_ERR(vr->rdev);
+	}
+
+	return 0;
+}
+
+static void virtio_rpmb_remove(struct virtio_device *vdev)
+{
+	struct virtio_rpmb *vr = vdev->priv;
+
+	rpmb_dev_unregister(vr->rdev);
+	virtio_rpmb_del_vq(vr);
+}
+
+static int virtio_rpmb_freeze(struct virtio_device *vdev)
+{
+	virtio_rpmb_del_vq(vdev->priv);
+	return 0;
+}
+
+static int virtio_rpmb_restore(struct virtio_device *vdev)
+{
+	return virtio_rpmb_init_vq(vdev->priv);
+}
+
+static const struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_RPMB, VIRTIO_DEV_ANY_ID },
+	{}
+};
+MODULE_DEVICE_TABLE(virtio, id_table);
+
+static struct virtio_driver virtio_rpmb_driver = {
+	.driver.name	= KBUILD_MODNAME,
+	.id_table	= id_table,
+	.probe		= virtio_rpmb_probe,
+	.remove		= virtio_rpmb_remove,
+	.freeze		= pm_sleep_ptr(virtio_rpmb_freeze),
+	.restore	= pm_sleep_ptr(virtio_rpmb_restore),
+};
+module_virtio_driver(virtio_rpmb_driver);
+
+MODULE_DESCRIPTION("Virtio RPMB driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/virtio_rpmb.h b/include/uapi/linux/virtio_rpmb.h
new file mode 100644
index 000000000000..66f45202857a
--- /dev/null
+++ b/include/uapi/linux/virtio_rpmb.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Virtio RPMB Device
+ *
+ * The Virtio RPMB Specification:
+ * https://github.com/oasis-tcs/virtio-spec/tree/master/device-types/rpmb
+ */
+
+#ifndef _UAPI_LINUX_VIRTIO_RPMB_H
+#define _UAPI_LINUX_VIRTIO_RPMB_H
+
+#include <linux/types.h>
+
+struct virtio_rpmb_config {
+	__u8 capacity;
+	__u8 max_wr_cnt;
+	__u8 max_rd_cnt;
+};
+
+/* Request types (req_resp) */
+#define VIRTIO_RPMB_REQ_PROGRAM_KEY		0x0001
+#define VIRTIO_RPMB_REQ_GET_WRITE_COUNTER	0x0002
+#define VIRTIO_RPMB_REQ_DATA_WRITE		0x0003
+#define VIRTIO_RPMB_REQ_DATA_READ		0x0004
+#define VIRTIO_RPMB_REQ_RESULT_READ		0x0005
+
+/* Response types (req_resp) */
+#define VIRTIO_RPMB_RESP_PROGRAM_KEY		0x0100
+#define VIRTIO_RPMB_RESP_GET_COUNTER		0x0200
+#define VIRTIO_RPMB_RESP_DATA_WRITE		0x0300
+#define VIRTIO_RPMB_RESP_DATA_READ		0x0400
+
+/* Operation results (result) */
+#define VIRTIO_RPMB_RES_OK			0x0000
+#define VIRTIO_RPMB_RES_GENERAL_FAILURE		0x0001
+#define VIRTIO_RPMB_RES_AUTH_FAILURE		0x0002
+#define VIRTIO_RPMB_RES_COUNT_FAILURE		0x0003
+#define VIRTIO_RPMB_RES_ADDR_FAILURE		0x0004
+#define VIRTIO_RPMB_RES_WRITE_FAILURE		0x0005
+#define VIRTIO_RPMB_RES_READ_FAILURE		0x0006
+#define VIRTIO_RPMB_RES_NO_AUTH_KEY		0x0007
+#define VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED	0x0080
+
+struct virtio_rpmb_frame {
+	__u8 stuff[196];
+	__u8 key_mac[32];
+	__u8 data[256];
+	__u8 nonce[16];
+	__be32 write_counter;
+	__be16 address;
+	__be16 block_count;
+	__be16 result;
+	__be16 req_resp;
+};
+
+#endif /* _UAPI_LINUX_VIRTIO_RPMB_H */
-- 
2.55.0

