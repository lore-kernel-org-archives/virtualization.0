Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9258FC433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 02:00:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2B8650DE
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 02:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2B8650DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C56324CA63;
	Thu,  4 Mar 2021 02:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4NjPknU_-A3y; Thu,  4 Mar 2021 02:00:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C96B74C66E;
	Thu,  4 Mar 2021 02:00:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3FBFC000A;
	Thu,  4 Mar 2021 02:00:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72DE9C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 02:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 59BD3606F9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 02:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ggi7eQ9OxetN
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 02:00:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D025606CB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 02:00:37 +0000 (UTC)
IronPort-SDR: /mJ/g2gdf12DkJhNDKDAHi2YdMCgf5XX/hdi8baFxGE/J/FnJyjbUmWlMJe6aay4ATPc+ssVuH
 PYb0ml9yGizw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="272321953"
X-IronPort-AV: E=Sophos;i="5.81,221,1610438400"; d="scan'208";a="272321953"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 18:00:36 -0800
IronPort-SDR: WHWKMOIfNgdIlYabsz+h7jNfs4plbMkfwvqRhmYWbRe+ir1sXZ6swC9whU4LvEQzgsKhXbjL9P
 VCVLG1csEhgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,221,1610438400"; d="scan'208";a="435620030"
Received: from jiedeng-optiplex-7050.sh.intel.com ([10.239.154.105])
 by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2021 18:00:30 -0800
From: Jie Deng <jie.deng@intel.com>
To: linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6] i2c: virtio: add a virtio i2c frontend driver
Date: Thu,  4 Mar 2021 09:59:33 +0800
Message-Id: <9a2086f37c0a62069b67c39a3f75941b78a0039c.1614749417.git.jie.deng@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, arnd@arndb.de, mst@redhat.com,
 viresh.kumar@linaro.org, shuo.a.liu@intel.com, tali.perry1@gmail.com,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, pbonzini@redhat.com,
 jarkko.nikula@linux.intel.com, stefanha@redhat.com,
 u.kleine-koenig@pengutronix.de, kblaiech@mellanox.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, rppt@kernel.org,
 yu1.wang@intel.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Add an I2C bus driver for virtio para-virtualization.

The controller can be emulated by the backend driver in
any device model software by following the virtio protocol.

The device specification can be found on
https://lists.oasis-open.org/archives/virtio-comment/202101/msg00008.html.

By following the specification, people may implement different
backend drivers to emulate different controllers according to
their needs.

Co-developed-by: Conghui Chen <conghui.chen@intel.com>
Signed-off-by: Conghui Chen <conghui.chen@intel.com>
Signed-off-by: Jie Deng <jie.deng@intel.com>
---
 drivers/i2c/busses/Kconfig      |  11 ++
 drivers/i2c/busses/Makefile     |   3 +
 drivers/i2c/busses/i2c-virtio.c | 289 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_i2c.h |  42 ++++++
 include/uapi/linux/virtio_ids.h |   1 +
 5 files changed, 346 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-virtio.c
 create mode 100644 include/uapi/linux/virtio_i2c.h

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 05ebf75..0860395 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -21,6 +21,17 @@ config I2C_ALI1535
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-ali1535.
 
+config I2C_VIRTIO
+	tristate "Virtio I2C Adapter"
+	depends on VIRTIO
+	help
+	  If you say yes to this option, support will be included for the virtio
+	  I2C adapter driver. The hardware can be emulated by any device model
+	  software according to the virtio protocol.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-virtio.
+
 config I2C_ALI1563
 	tristate "ALI 1563"
 	depends on PCI
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 615f35e..b88da08 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -6,6 +6,9 @@
 # ACPI drivers
 obj-$(CONFIG_I2C_SCMI)		+= i2c-scmi.o
 
+# VIRTIO I2C host controller driver
+obj-$(CONFIG_I2C_VIRTIO)	+= i2c-virtio.o
+
 # PC SMBus host controller drivers
 obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
 obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
new file mode 100644
index 0000000..98c0fcc
--- /dev/null
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Virtio I2C Bus Driver
+ *
+ * The Virtio I2C Specification:
+ * https://raw.githubusercontent.com/oasis-tcs/virtio-spec/master/virtio-i2c.tex
+ *
+ * Copyright (c) 2021 Intel Corporation. All rights reserved.
+ */
+
+#include <linux/acpi.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/wait.h>
+
+#include <linux/virtio.h>
+#include <linux/virtio_i2c.h>
+
+/**
+ * struct virtio_i2c - virtio I2C data
+ * @vdev: virtio device for this controller
+ * @completion: completion of virtio I2C message
+ * @adap: I2C adapter for this controller
+ * @i2c_lock: lock for virtqueue processing
+ * @vq: the virtio virtqueue for communication
+ */
+struct virtio_i2c {
+	struct virtio_device *vdev;
+	struct completion completion;
+	struct i2c_adapter adap;
+	struct mutex i2c_lock;
+	struct virtqueue *vq;
+};
+
+/**
+ * struct virtio_i2c_req - the virtio I2C request structure
+ * @out_hdr: the OUT header of the virtio I2C message
+ * @buf: the buffer into which data is read, or from which it's written
+ * @in_hdr: the IN header of the virtio I2C message
+ */
+struct virtio_i2c_req {
+	struct virtio_i2c_out_hdr out_hdr;
+	u8 *buf;
+	struct virtio_i2c_in_hdr in_hdr;
+};
+
+static void virtio_i2c_msg_done(struct virtqueue *vq)
+{
+	struct virtio_i2c *vi = vq->vdev->priv;
+
+	complete(&vi->completion);
+}
+
+static int virtio_i2c_send_reqs(struct virtqueue *vq,
+				struct virtio_i2c_req *reqs,
+				struct i2c_msg *msgs, int nr)
+{
+	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
+	int i, outcnt, incnt, err = 0;
+	u8 *buf;
+
+	for (i = 0; i < nr; i++) {
+		if (!msgs[i].len)
+			break;
+
+		/* Only 7-bit mode supported for this moment. For the address format,
+		 * Please check the Virtio I2C Specification.
+		 */
+		reqs[i].out_hdr.addr = cpu_to_le16(msgs[i].addr << 1);
+
+		if (i != nr - 1)
+			reqs[i].out_hdr.flags |= VIRTIO_I2C_FLAGS_FAIL_NEXT;
+
+		outcnt = incnt = 0;
+		sg_init_one(&out_hdr, &reqs[i].out_hdr, sizeof(reqs[i].out_hdr));
+		sgs[outcnt++] = &out_hdr;
+
+		buf = kzalloc(msgs[i].len, GFP_KERNEL);
+		if (!buf)
+			break;
+
+		reqs[i].buf = buf;
+		sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
+
+		if (msgs[i].flags & I2C_M_RD) {
+			sgs[outcnt + incnt++] = &msg_buf;
+		} else {
+			memcpy(reqs[i].buf, msgs[i].buf, msgs[i].len);
+			sgs[outcnt++] = &msg_buf;
+		}
+
+		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
+		sgs[outcnt + incnt++] = &in_hdr;
+
+		err = virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL);
+		if (err < 0) {
+			pr_err("failed to add msg[%d] to virtqueue.\n", i);
+			kfree(reqs[i].buf);
+			reqs[i].buf = NULL;
+			break;
+		}
+	}
+
+	return i;
+}
+
+static int virtio_i2c_complete_reqs(struct virtqueue *vq,
+					struct virtio_i2c_req *reqs,
+					struct i2c_msg *msgs, int nr)
+{
+	struct virtio_i2c_req *req;
+	unsigned int len;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		req = (struct virtio_i2c_req *)virtqueue_get_buf(vq, &len);
+		if (!(req && req == &reqs[i])) {
+			pr_err("msg[%d]: addr=0x%x virtqueue error.\n", i, msgs[i].addr);
+			break;
+		}
+
+		if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
+			pr_err("msg[%d]: addr=0x%x backend error.\n", i, msgs[i].addr);
+			break;
+		}
+
+		if (msgs[i].flags & I2C_M_RD)
+			memcpy(msgs[i].buf, req->buf, msgs[i].len);
+
+		kfree(req->buf);
+		req->buf = NULL;
+	}
+
+	return i;
+}
+
+static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	struct virtio_i2c *vi = i2c_get_adapdata(adap);
+	struct virtqueue *vq = vi->vq;
+	struct virtio_i2c_req *reqs;
+	unsigned long time_left;
+	int ret, nr;
+
+	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
+	if (!reqs)
+		return -ENOMEM;
+
+	mutex_lock(&vi->i2c_lock);
+
+	ret = virtio_i2c_send_reqs(vq, reqs, msgs, num);
+	if (ret == 0)
+		goto err_unlock_free;
+
+	nr = ret;
+
+	virtqueue_kick(vq);
+
+	time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
+	if (!time_left) {
+		dev_err(&adap->dev, "virtio i2c backend timeout.\n");
+		ret = -ETIMEDOUT;
+		goto err_unlock_free;
+	}
+
+	ret = virtio_i2c_complete_reqs(vq, reqs, msgs, nr);
+
+	reinit_completion(&vi->completion);
+
+err_unlock_free:
+	mutex_unlock(&vi->i2c_lock);
+	kfree(reqs);
+	return ret;
+}
+
+static void virtio_i2c_del_vqs(struct virtio_device *vdev)
+{
+	vdev->config->reset(vdev);
+	vdev->config->del_vqs(vdev);
+}
+
+static int virtio_i2c_setup_vqs(struct virtio_i2c *vi)
+{
+	struct virtio_device *vdev = vi->vdev;
+
+	vi->vq = virtio_find_single_vq(vdev, virtio_i2c_msg_done, "msg");
+	return PTR_ERR_OR_ZERO(vi->vq);
+}
+
+static u32 virtio_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static struct i2c_algorithm virtio_algorithm = {
+	.master_xfer = virtio_i2c_xfer,
+	.functionality = virtio_i2c_func,
+};
+
+static struct i2c_adapter virtio_adapter = {
+	.owner = THIS_MODULE,
+	.name = "Virtio I2C Adapter",
+	.class = I2C_CLASS_DEPRECATED,
+	.algo = &virtio_algorithm,
+};
+
+static int virtio_i2c_probe(struct virtio_device *vdev)
+{
+	struct device *pdev = vdev->dev.parent;
+	struct virtio_i2c *vi;
+	int ret;
+
+	vi = devm_kzalloc(&vdev->dev, sizeof(*vi), GFP_KERNEL);
+	if (!vi)
+		return -ENOMEM;
+
+	vdev->priv = vi;
+	vi->vdev = vdev;
+
+	mutex_init(&vi->i2c_lock);
+	init_completion(&vi->completion);
+
+	ret = virtio_i2c_setup_vqs(vi);
+	if (ret)
+		return ret;
+
+	vi->adap = virtio_adapter;
+	i2c_set_adapdata(&vi->adap, vi);
+	vi->adap.dev.parent = &vdev->dev;
+	/* Setup ACPI node for controlled devices which will be probed through ACPI */
+	ACPI_COMPANION_SET(&vi->adap.dev, ACPI_COMPANION(pdev));
+	vi->adap.timeout = HZ / 10;
+
+	ret = i2c_add_adapter(&vi->adap);
+	if (ret) {
+		virtio_i2c_del_vqs(vdev);
+		dev_err(&vdev->dev, "failed to add virtio-i2c adapter.\n");
+	}
+
+	return ret;
+}
+
+static void virtio_i2c_remove(struct virtio_device *vdev)
+{
+	struct virtio_i2c *vi = vdev->priv;
+
+	i2c_del_adapter(&vi->adap);
+	virtio_i2c_del_vqs(vdev);
+}
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_I2C_ADPTER, VIRTIO_DEV_ANY_ID },
+	{}
+};
+MODULE_DEVICE_TABLE(virtio, id_table);
+
+static int __maybe_unused virtio_i2c_freeze(struct virtio_device *vdev)
+{
+	virtio_i2c_del_vqs(vdev);
+	return 0;
+}
+
+static int __maybe_unused virtio_i2c_restore(struct virtio_device *vdev)
+{
+	return virtio_i2c_setup_vqs(vdev->priv);
+}
+
+static struct virtio_driver virtio_i2c_driver = {
+	.id_table	= id_table,
+	.probe		= virtio_i2c_probe,
+	.remove		= virtio_i2c_remove,
+	.driver	= {
+		.name	= "i2c_virtio",
+	},
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtio_i2c_freeze,
+	.restore = virtio_i2c_restore,
+#endif
+};
+module_virtio_driver(virtio_i2c_driver);
+
+MODULE_DESCRIPTION("Virtio i2c bus driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/virtio_i2c.h b/include/uapi/linux/virtio_i2c.h
new file mode 100644
index 0000000..00f4508
--- /dev/null
+++ b/include/uapi/linux/virtio_i2c.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
+/*
+ * Definitions for virtio I2C Adpter
+ *
+ * Copyright (c) 2021 Intel Corporation. All rights reserved.
+ */
+
+#ifndef _UAPI_LINUX_VIRTIO_I2C_H
+#define _UAPI_LINUX_VIRTIO_I2C_H
+
+#include <linux/types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+
+/**
+ * struct virtio_i2c_out_hdr - the virtio I2C message OUT header
+ * @addr: the controlled device address
+ * @padding: used to pad to full dword
+ * @flags: used for feature extensibility
+ */
+struct virtio_i2c_out_hdr {
+	__le16 addr;
+	__le16 padding;
+	__le32 flags;
+};
+
+/* The bit 0 of the @virtio_i2c_out_hdr.@flags, used to group the requests */
+#define VIRTIO_I2C_FLAGS_FAIL_NEXT	0x00000001
+
+/**
+ * struct virtio_i2c_in_hdr - the virtio I2C message IN header
+ * @status: the processing result from the backend
+ */
+struct virtio_i2c_in_hdr {
+	u8 status;
+};
+
+/* The final status written by the device */
+#define VIRTIO_I2C_MSG_OK	0
+#define VIRTIO_I2C_MSG_ERR	1
+
+#endif /* _UAPI_LINUX_VIRTIO_I2C_H */
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index bc1c062..6ae32db 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -54,5 +54,6 @@
 #define VIRTIO_ID_FS			26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM			27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
+#define VIRTIO_ID_I2C_ADPTER		34 /* virtio i2c adpter */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.7.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
