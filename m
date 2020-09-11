Return-Path: <SRS0=G0EF=CU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31B9C43461
	for <virtualization@archiver.kernel.org>; Fri, 11 Sep 2020 03:49:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495A0221E5
	for <virtualization@archiver.kernel.org>; Fri, 11 Sep 2020 03:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495A0221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DAB5887759;
	Fri, 11 Sep 2020 03:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hrdr+pX8X7HB; Fri, 11 Sep 2020 03:49:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 70ACD875DC;
	Fri, 11 Sep 2020 03:49:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53059C088B;
	Fri, 11 Sep 2020 03:49:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84607C0052
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 03:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 68949226D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 03:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xwN6yYakITxu
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 03:48:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id 925C5207A2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 03:48:56 +0000 (UTC)
IronPort-SDR: 170zN7uu4eFs6QCcuwhKdw9f1aBwE2K+irDWIv1Z0urN3vHvex7Q4IKZtZa/g8/AdOYD0uYQhZ
 AJE+JQKGdsDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="157970434"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="157970434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 20:48:55 -0700
IronPort-SDR: uRdfT9JHy2HDMe5eUAHhRnhp09i7k05mp6FINsF5Vu/DeWPknumtm92c96bpZVoBrwiVC5hYtS
 4r1RACk6YqZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="329612008"
Received: from jiedeng-optiplex-7050.sh.intel.com ([10.239.154.138])
 by fmsmga004.fm.intel.com with ESMTP; 10 Sep 2020 20:48:51 -0700
From: Jie Deng <jie.deng@intel.com>
To: linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: virtio: add a virtio i2c frontend driver
Date: Fri, 11 Sep 2020 11:48:42 +0800
Message-Id: <c4bd4fd56df36864ed34d3572f00b2b838fd833a.1599795029.git.jie.deng@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, mst@redhat.com, krzk@kernel.org,
 tali.perry1@gmail.com, wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, rppt@kernel.org, shuo.a.liu@intel.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, jdelvare@suse.de,
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

This driver communicates with the backend driver through a
virtio I2C message structure which includes following parts:

- Header: i2c_msg addr, flags, len.
- Data buffer: the pointer to the I2C msg data.
- Status: the processing result from the backend.

People may implement different backend drivers to emulate
different controllers according to their needs. A backend
example can be found in the device model of the open source
project ACRN. For more information, please refer to
https://projectacrn.org.

The virtio device ID 34 is used for this I2C adpter since IDs
before 34 have been reserved by other virtio devices.

Co-developed-by: Conghui Chen <conghui.chen@intel.com>
Signed-off-by: Conghui Chen <conghui.chen@intel.com>
Signed-off-by: Jie Deng <jie.deng@intel.com>
Reviewed-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
The device ID request:
	https://github.com/oasis-tcs/virtio-spec/issues/85 

Changes in v2:
	- Addressed comments received from Michael, Andy and Jason.

 drivers/i2c/busses/Kconfig      |  11 ++
 drivers/i2c/busses/Makefile     |   3 +
 drivers/i2c/busses/i2c-virtio.c | 271 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h |   1 +
 4 files changed, 286 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-virtio.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 293e7a0..70c8e30 100644
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
+	  i2c adapter driver. The hardware can be emulated by any device model
+	  software according to the virtio protocol.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-virtio.
+
 config I2C_ALI1563
 	tristate "ALI 1563"
 	depends on PCI
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 19aff0e..821acfa 100644
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
index 0000000..aff1a9a
--- /dev/null
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Virtio I2C Bus Driver
+ *
+ * Copyright (c) 2020 Intel Corporation. All rights reserved.
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
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+
+#define VIRTIO_I2C_MSG_OK	0
+#define VIRTIO_I2C_MSG_ERR	1
+
+/**
+ * struct virtio_i2c_hdr - the virtio I2C message header structure
+ * @addr: i2c_msg addr, the slave address
+ * @flags: i2c_msg flags
+ * @len: i2c_msg len
+ */
+struct virtio_i2c_hdr {
+	__le16 addr;
+	__le16 flags;
+	__le16 len;
+};
+
+/**
+ * struct virtio_i2c_msg - the virtio I2C message structure
+ * @hdr: the virtio I2C message header
+ * @buf: virtio I2C message data buffer
+ * @status: the processing result from the backend
+ */
+struct virtio_i2c_msg {
+	struct virtio_i2c_hdr hdr;
+	u8 *buf;
+	u8 status;
+};
+
+/**
+ * struct virtio_i2c - virtio I2C data
+ * @vdev: virtio device for this controller
+ * @completion: completion of virtio I2C message
+ * @vmsg: the virtio I2C message for communication
+ * @adap: I2C adapter for this controller
+ * @i2c_lock: lock for virtqueue processing
+ * @vq: the virtio virtqueue for communication
+ */
+struct virtio_i2c {
+	struct virtio_device *vdev;
+	struct completion completion;
+	struct virtio_i2c_msg vmsg;
+	struct i2c_adapter adap;
+	struct mutex i2c_lock;
+	struct virtqueue *vq;
+};
+
+static void virtio_i2c_msg_done(struct virtqueue *vq)
+{
+	struct virtio_i2c *vi = vq->vdev->priv;
+
+	complete(&vi->completion);
+}
+
+static int virtio_i2c_add_msg(struct virtqueue *vq,
+			      struct virtio_i2c_msg *vmsg,
+			      struct i2c_msg *msg)
+{
+	struct scatterlist *sgs[3], hdr, bout, bin, status;
+	int outcnt = 0, incnt = 0;
+
+	if (!msg->len)
+		return -EINVAL;
+
+	vmsg->hdr.addr = cpu_to_le16(msg->addr);
+	vmsg->hdr.flags = cpu_to_le16(msg->flags);
+	vmsg->hdr.len = cpu_to_le16(msg->len);
+
+	vmsg->buf = kzalloc(msg->len, GFP_KERNEL);
+	if (!vmsg->buf)
+		return -ENOMEM;
+
+	sg_init_one(&hdr, &vmsg->hdr, sizeof(struct virtio_i2c_hdr));
+	sgs[outcnt++] = &hdr;
+	if (msg->flags & I2C_M_RD) {
+		sg_init_one(&bin, vmsg->buf, msg->len);
+		sgs[outcnt + incnt++] = &bin;
+	} else {
+		memcpy(vmsg->buf, msg->buf, msg->len);
+		sg_init_one(&bout, vmsg->buf, msg->len);
+		sgs[outcnt++] = &bout;
+	}
+	sg_init_one(&status, &vmsg->status, sizeof(vmsg->status));
+	sgs[outcnt + incnt++] = &status;
+
+	return virtqueue_add_sgs(vq, sgs, outcnt, incnt, vmsg, GFP_KERNEL);
+}
+
+static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	struct virtio_i2c *vi = i2c_get_adapdata(adap);
+	struct virtqueue *vq = vi->vq;
+	struct virtio_i2c_msg *vmsg;
+	unsigned long time_left;
+	int len, i, ret = 0;
+
+	mutex_lock(&vi->i2c_lock);
+	vmsg = &vi->vmsg;
+	vmsg->buf = NULL;
+
+	for (i = 0; i < num; i++) {
+		ret = virtio_i2c_add_msg(vq, vmsg, &msgs[i]);
+		if (ret) {
+			dev_err(&adap->dev, "failed to add msg[%d] to virtqueue.\n", i);
+			break;
+		}
+
+		virtqueue_kick(vq);
+
+		time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
+		if (!time_left) {
+			dev_err(&adap->dev, "msg[%d]: addr=0x%x timeout.\n", i, msgs[i].addr);
+			break;
+		}
+
+		vmsg = (struct virtio_i2c_msg *)virtqueue_get_buf(vq, &len);
+		if (vmsg) {
+			/* vmsg should point to the same address with &vi->vmsg */
+			if (vmsg != &vi->vmsg) {
+				dev_err(&adap->dev, "msg[%d]: addr=0x%x virtqueue error.\n",
+					i, le16_to_cpu(vmsg->hdr.addr));
+				break;
+			}
+			if (vmsg->status != VIRTIO_I2C_MSG_OK) {
+				dev_err(&adap->dev, "msg[%d]: addr=0x%x error=%d.\n",
+					i, le16_to_cpu(vmsg->hdr.addr), vmsg->status);
+				break;
+			}
+			if ((msgs[i].flags & I2C_M_RD) && msgs[i].len)
+				memcpy(msgs[i].buf, vmsg->buf, msgs[i].len);
+
+			kfree(vmsg->buf);
+			vmsg->buf = NULL;
+		}
+
+		reinit_completion(&vi->completion);
+	}
+
+	mutex_unlock(&vi->i2c_lock);
+	kfree(vmsg->buf);
+	return ((ret < 0) ? ret : i);
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
+	/* Setup ACPI node for slave devices which will be probed through ACPI */
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
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index b052355..398ef2d 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -48,5 +48,6 @@
 #define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
+#define VIRTIO_ID_I2C_ADPTER   34 /* virtio i2c adpter */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.7.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
