Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D179AC4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 10:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4079E40236;
	Tue,  8 Nov 2022 10:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4079E40236
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=D2398hz5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zo8IZ_bsz_sL; Tue,  8 Nov 2022 10:09:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6316940155;
	Tue,  8 Nov 2022 10:09:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6316940155
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CB75C0032;
	Tue,  8 Nov 2022 10:09:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CFBAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52F674038C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:09:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52F674038C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=D2398hz5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UO084JGoyjB5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:09:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C4C640060
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C4C640060
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:09:43 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id l14so20188321wrw.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 02:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=thliBNGXADjq2MFXX5lS5AJ/0QGnhgzKyo3G9Wf9z2U=;
 b=D2398hz5Kt++zg7i1WLII5EuxH8z2q9HRvXJk4V1NGsRehMYdB7pM9jXtCYk+oRqPM
 8sw6SRJEheqQYnWJsmfg4pudYDeydlMwBENrAkKdDwsQAV9bFlnObXlCC//8IVMpyBgg
 0g1r0w1iNukjrVaIf0VnWMFO7hJl22p5dQboA6IvPIiFHt808CI/vN0omIgDyfyyx4wG
 Mwq3Bvxx1jW4w3XxF/L5bJKKfrslY5JYAMC/cSRbz0F53DrjQ3YhhMFjKRxPVD20bGib
 rxOYJSVkAfq3bfrsUEUjXtHp8FZYownpK+AL/vpxJKOb1pChl+K/H0L4MNqsaxatsfZY
 xV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=thliBNGXADjq2MFXX5lS5AJ/0QGnhgzKyo3G9Wf9z2U=;
 b=jFt7IYMA6fKSgxTTpi1z74HBeBaA2ishhAfLhHdXcq74IgGUdgsRO5Ypn7FkuWcEj+
 TWs9/S4+3hb2wt+LmcknWbZE6PArDTz8CJNlOJCRjMc1QOdogC7i5OmyvIW7O6KppK1s
 AKTWuvnec1QJtgFnTNgGkUHu6nPx92qhTkNCsL3ZO2sHOAboIZ27ZNiBTSHH59K6qqdl
 6Ic9gxtPvbjRVjhK/sl4m5oK2lc2+2OT5RoxrGNIa3TlI3Urh/AQ0TFobxvMPZL2E1oC
 zHH6O8UmjKj4OX9vsbHW396DzCDz57Ov4pqeeP8oHiFsMo+ShMzJC7L4ohcsocA93wZM
 N94w==
X-Gm-Message-State: ACrzQf1Z2XGogtUbIIQWjIf3IIEOJX60zWJd/D0Ehx0WAlE/1PUzrAIC
 zAYBGOgWUKNKnsU5CkioTH6zGWdDBIjSRg==
X-Google-Smtp-Source: AMsMyM6vVVqRk3PtuCTL6Stih8lbSmq4sF0c9kA3fD8NbupLZzSwyVBXhxhPva0vS8KFX3N2fdobiA==
X-Received: by 2002:a05:6000:156e:b0:236:ed91:5354 with SMTP id
 14-20020a056000156e00b00236ed915354mr21007517wrz.203.1667902180834; 
 Tue, 08 Nov 2022 02:09:40 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a5d6611000000b002383edcde09sm9840689wru.59.2022.11.08.02.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Nov 2022 02:09:40 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: vdpa: new SolidNET DPU driver.
Date: Tue,  8 Nov 2022 12:09:15 +0200
Message-Id: <20221108100925.823841-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This commit includes:
 1) The driver to manage the controlplane over vDPA bus.
 2) A HW monitor device to read health values from the DPU.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 MAINTAINERS                        |   4 +
 drivers/vdpa/Kconfig               |  11 +
 drivers/vdpa/Makefile              |   1 +
 drivers/vdpa/solidrun/Makefile     |   3 +
 drivers/vdpa/solidrun/snet_hwmon.c | 191 +++++++
 drivers/vdpa/solidrun/snet_main.c  | 858 +++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_vdpa.h  | 192 +++++++
 7 files changed, 1260 insertions(+)
 create mode 100644 drivers/vdpa/solidrun/Makefile
 create mode 100644 drivers/vdpa/solidrun/snet_hwmon.c
 create mode 100644 drivers/vdpa/solidrun/snet_main.c
 create mode 100644 drivers/vdpa/solidrun/snet_vdpa.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 046ff06ff97..ae425b3bed4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21725,6 +21725,10 @@ IFCVF VIRTIO DATA PATH ACCELERATOR
 R:	Zhu Lingshan <lingshan.zhu@intel.com>
 F:	drivers/vdpa/ifcvf/
 
+SNET DPU VIRTIO DATA PATH ACCELERATOR
+R:	Alvaro Karsz <alvaro.karsz@solid-run.com>
+F:	drivers/vdpa/solidrun/
+
 VIRTIO BALLOON
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	David Hildenbrand <david@redhat.com>
diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 50f45d03761..cd880d1af7f 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -86,4 +86,15 @@ config ALIBABA_ENI_VDPA
 	  VDPA driver for Alibaba ENI (Elastic Network Interface) which is built upon
 	  virtio 0.9.5 specification.
 
+ config SNET_VDPA
+	tristate "SolidRun's vDPA driver for SolidNET"
+	select HWMON
+	depends on PCI_MSI
+	help
+	  vDPA driver for SolidNET DPU.
+	  With this driver, the VirtIO dataplane can be
+	  offloaded to a SolidNET DPU.
+	  This driver includes a HW monitor device that
+	  reads health values from the DPU.
+
 endif # VDPA
diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
index 15665563a7f..59396ff2a31 100644
--- a/drivers/vdpa/Makefile
+++ b/drivers/vdpa/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_IFCVF)    += ifcvf/
 obj-$(CONFIG_MLX5_VDPA) += mlx5/
 obj-$(CONFIG_VP_VDPA)    += virtio_pci/
 obj-$(CONFIG_ALIBABA_ENI_VDPA) += alibaba/
+obj-$(CONFIG_SNET_VDPA) += solidrun/
diff --git a/drivers/vdpa/solidrun/Makefile b/drivers/vdpa/solidrun/Makefile
new file mode 100644
index 00000000000..0acabd040fd
--- /dev/null
+++ b/drivers/vdpa/solidrun/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
+snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o snet_hwmon.o
diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
new file mode 100644
index 00000000000..50e5743b8ee
--- /dev/null
+++ b/drivers/vdpa/solidrun/snet_hwmon.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SolidRun DPU driver for control plane
+ *
+ * Copyright (C) 2022 SolidRun
+ *
+ * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
+ *
+ */
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+#include "snet_vdpa.h"
+
+/* Monitor offsets */
+#define SNET_MON_TMP0_IN_OFF      0x00
+#define SNET_MON_TMP0_MAX_OFF     0x08
+#define SNET_MON_TMP0_CRIT_OFF    0x10
+#define SNET_MON_TMP1_IN_OFF      0x18
+#define SNET_MON_TMP1_CRIT_OFF    0x20
+#define SNET_MON_CURR_IN_OFF      0x28
+#define SNET_MON_CURR_MAX_OFF     0x30
+#define SNET_MON_CURR_CRIT_OFF    0x38
+#define SNET_MON_PWR_IN_OFF       0x40
+#define SNET_MON_VOLT_IN_OFF      0x48
+#define SNET_MON_VOLT_CRIT_OFF    0x50
+#define SNET_MON_VOLT_LCRIT_OFF   0x58
+
+static void snet_hwmon_read_reg(struct psnet *psnet, u32 reg, long *out)
+{
+	*out = (long)psnet_read64(psnet, psnet->cfg.hwmon_off + reg);
+}
+
+static umode_t snet_howmon_is_visible(const void *data,
+				      enum hwmon_sensor_types type,
+				      u32 attr, int channel)
+{
+	/* Files are read only */
+	return 0444;
+}
+
+static int snet_howmon_read(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long *val)
+{
+	struct psnet *psnet = dev_get_drvdata(dev);
+	int ret = 0;
+
+	switch (type) {
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_lcrit:
+			snet_hwmon_read_reg(psnet, SNET_MON_VOLT_LCRIT_OFF, val);
+			break;
+		case hwmon_in_crit:
+			snet_hwmon_read_reg(psnet, SNET_MON_VOLT_CRIT_OFF, val);
+			break;
+		case hwmon_in_input:
+			snet_hwmon_read_reg(psnet, SNET_MON_VOLT_IN_OFF, val);
+			break;
+		default:
+			ret = -EOPNOTSUPP;
+			break;
+		}
+		break;
+
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			snet_hwmon_read_reg(psnet, SNET_MON_PWR_IN_OFF, val);
+			break;
+
+		default:
+			ret = -EOPNOTSUPP;
+			break;
+		}
+		break;
+
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			snet_hwmon_read_reg(psnet, SNET_MON_CURR_IN_OFF, val);
+			break;
+		case hwmon_curr_max:
+			snet_hwmon_read_reg(psnet, SNET_MON_CURR_MAX_OFF, val);
+			break;
+		case hwmon_curr_crit:
+			snet_hwmon_read_reg(psnet, SNET_MON_CURR_CRIT_OFF, val);
+			break;
+		default:
+			ret = -EOPNOTSUPP;
+			break;
+		}
+		break;
+
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			if (channel == 0)
+				snet_hwmon_read_reg(psnet, SNET_MON_TMP0_IN_OFF, val);
+			else
+				snet_hwmon_read_reg(psnet, SNET_MON_TMP1_IN_OFF, val);
+			break;
+		case hwmon_temp_max:
+			if (channel == 0)
+				snet_hwmon_read_reg(psnet, SNET_MON_TMP0_MAX_OFF, val);
+			else
+				ret = -EOPNOTSUPP;
+			break;
+		case hwmon_temp_crit:
+			if (channel == 0)
+				snet_hwmon_read_reg(psnet, SNET_MON_TMP0_CRIT_OFF, val);
+			else
+				snet_hwmon_read_reg(psnet, SNET_MON_TMP1_CRIT_OFF, val);
+			break;
+
+		default:
+			ret = -EOPNOTSUPP;
+			break;
+		}
+		break;
+
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+	return ret;
+}
+
+static int snet_hwmon_read_string(struct device *dev,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel, const char **str)
+{
+	int ret = 0;
+
+	switch (type) {
+	case hwmon_in:
+		*str = "main_vin";
+		break;
+	case hwmon_power:
+		*str = "soc_pin";
+		break;
+	case hwmon_curr:
+		*str = "soc_iin";
+		break;
+	case hwmon_temp:
+		if (channel == 0)
+			*str = "power_stage_temp";
+		else
+			*str = "ic_junction_temp";
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+	return ret;
+}
+
+static const struct hwmon_ops snet_hwmon_ops = {
+	.is_visible = snet_howmon_is_visible,
+	.read = snet_howmon_read,
+	.read_string = snet_hwmon_read_string
+};
+
+static const struct hwmon_channel_info *snet_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),
+	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT | HWMON_C_LABEL),
+	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT | HWMON_I_CRIT | HWMON_I_LCRIT | HWMON_I_LABEL),
+			   NULL
+};
+
+static const struct hwmon_chip_info snet_hwmono_info = {
+	.ops = &snet_hwmon_ops,
+	.info = snet_hwmon_info,
+};
+
+/* Create an HW monitor device */
+void snet_create_hwmon(struct pci_dev *pdev)
+{
+	struct device *hwmon;
+	struct psnet *psnet = pci_get_drvdata(pdev);
+
+	snprintf(psnet->hwmon_name, SNET_HWMON_NAME_SIZE, "snet%d_hwmon", psnet->id);
+	hwmon = devm_hwmon_device_register_with_info(&pdev->dev, psnet->hwmon_name, psnet,
+						     &snet_hwmono_info, NULL);
+	/* The monitor is not mandatory, Just alert user in case of an error */
+	if (!hwmon)
+		SNET_WARN(pdev, "Failed to create SNET hwmon\n");
+}
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
new file mode 100644
index 00000000000..c27e345b3bb
--- /dev/null
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -0,0 +1,858 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SolidRun DPU driver for control plane
+ *
+ * Copyright (C) 2022 SolidRun
+ *
+ * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
+ *
+ */
+
+#include "snet_vdpa.h"
+
+/* SolidRun's PCI vendor ID */
+#define SOLIDRUN_PCI_VENDOR_ID  0xD063
+#define SNET_DEVICE_ID          0x1000
+/* PCI Bar used to access DPU */
+#define SNET_ACCESS_BAR         0x2
+/* SNET signature */
+#define SNET_SIGNATURE          0xD0D06363
+/* Max. config version that we can work with */
+#define SNET_CFG_VERSION        0x1
+/* Queue align */
+#define SNET_QUEUE_ALIGNMENT    PAGE_SIZE
+/* Kick value to notify that new data is available */
+#define SNET_KICK_VAL           0x1
+#define SNET_CONFIG_OFF         0x0
+
+enum snet_msg {
+	SNET_MSG_CLEAR = 0,
+	SNET_MSG_DESTROY = 1,
+};
+
+/* Global variable to hold the next psnet unique id to be used */
+static u32 psnet_next_uid;
+
+static struct snet *vdpa_to_snet(struct vdpa_device *vdpa)
+{
+	return container_of(vdpa, struct snet, vdpa);
+}
+
+static int snet_set_vq_address(struct vdpa_device *vdev, u16 idx, u64 desc_area,
+			       u64 driver_area, u64 device_area)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+	/* save received parameters in vqueue sturct */
+	snet->vqs[idx]->desc_area = desc_area;
+	snet->vqs[idx]->driver_area = driver_area;
+	snet->vqs[idx]->device_area = device_area;
+	/* Set serial ID */
+	snet->vqs[idx]->sid = snet->psnet->next_vq++;
+	/* Set kick address - every VQ gets 4B */
+	snet->vqs[idx]->kick_offset = snet->psnet->cfg.kick_off + snet->vqs[idx]->sid * 4;
+	/* Save kick ptr*/
+	snet->vqs[idx]->kick_ptr = snet->psnet->access_bar + snet->vqs[idx]->kick_offset;
+	/* Clear kick address for this VQ */
+	iowrite32(0, snet->vqs[idx]->kick_ptr);
+
+	return 0;
+}
+
+static void snet_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+	/* save num in vqueue */
+	snet->vqs[idx]->num = num;
+}
+
+static void snet_kick_vq(struct vdpa_device *vdev, u16 idx)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+	/* not ready - ignore */
+	if (!snet->vqs[idx]->ready)
+		return;
+
+	iowrite32(SNET_KICK_VAL, snet->vqs[idx]->kick_ptr);
+}
+
+static void snet_set_vq_cb(struct vdpa_device *vdev, u16 idx, struct vdpa_callback *cb)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	snet->vqs[idx]->cb.callback = cb->callback;
+	snet->vqs[idx]->cb.private = cb->private;
+}
+
+static void snet_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+
+	snet->vqs[idx]->ready = ready;
+}
+
+static bool snet_get_vq_ready(struct vdpa_device *vdev, u16 idx)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	return snet->vqs[idx]->ready;
+}
+
+static int snet_set_vq_state(struct vdpa_device *vdev, u16 idx, const struct vdpa_vq_state *state)
+{
+	/* Not supported */
+	return 0;
+}
+
+static int snet_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa_vq_state *state)
+{
+	/* Not supported */
+	return -EOPNOTSUPP;
+}
+
+static int snet_get_vq_irq(struct vdpa_device *vdev, u16 idx)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	return snet->vqs[idx]->irq;
+}
+
+static u32 snet_get_vq_align(struct vdpa_device *vdev)
+{
+	return (u32)SNET_QUEUE_ALIGNMENT;
+}
+
+static void snet_reset(struct snet *snet)
+{
+	/* no reset yet - just update generation */
+	snet->generation++;
+}
+
+static int snet_main_reset(struct vdpa_device *vdev)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	snet_reset(snet);
+	return 0;
+}
+
+static size_t snet_get_config_size(struct vdpa_device *vdev)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	return (size_t)snet->cfg->cfg_size;
+}
+
+static u64 snet_get_features(struct vdpa_device *vdev)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	return snet->cfg->features;
+}
+
+static int snet_set_drv_features(struct vdpa_device *vdev, u64 features)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	snet->used_features = snet->cfg->features & features;
+	return 0;
+}
+
+static u64 snet_get_drv_features(struct vdpa_device *vdev)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	return snet->used_features;
+}
+
+static u16 snet_get_vq_num_max(struct vdpa_device *vdev)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	return (u16)snet->cfg->vq_size;
+}
+
+static void snet_set_config_cb(struct vdpa_device *vdev, struct vdpa_callback *cb)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	snet->cb.callback = cb->callback;
+	snet->cb.private = cb->private;
+}
+
+static u32 snet_get_device_id(struct vdpa_device *vdev)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	return snet->cfg->virtio_id;
+}
+
+static u32 snet_get_vendor_id(struct vdpa_device *vdev)
+{
+	return (u32)SOLIDRUN_PCI_VENDOR_ID;
+}
+
+static u8 snet_get_status(struct vdpa_device *vdev)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	return snet->status;
+}
+
+static bool is_last_snet_in_pdev(struct snet *snet)
+{
+	/* Check if this is the last device (count starts from 0) */
+	return snet->sid == snet->psnet->total_devs - 1;
+}
+
+static void snet_send_msg(struct snet *snet, u32 msg)
+{
+	psnet_write32(snet->psnet, snet->cfg->snet_msg_off, msg);
+	/* Wait until the msg is written.
+	 * We need to be sure that the DPU gets the msg.
+	 */
+	smp_wmb();
+}
+
+static void snet_write_conf(struct snet *snet)
+{
+	struct psnet *psnet = snet->psnet;
+	u32 off, magic_off, next_off;
+	int i;
+
+	/* No need to notify twice for the same SNET device */
+	if (snet->dpu_ready)
+		return;
+
+	/* Get offset from snet pdev */
+	off = snet->psnet->next_dpu_addr;
+
+	/* Snet data :
+	 * 0x0             0x4       0x8         0xC         0x10               0x14         0x18
+	 * |  MAGIC NUMBER | CFG VER |  SNET SID  | SNET TYPE | NUMBER OF QUEUES | CFG IRQ IDX |
+	 *
+	 * 0x18          0x1C	        0x24        0x28         0x50
+	 * |  CONFIG OFF  |   FEATURES	 |  MSG OFF  |  RESERVED  |
+	 *
+	 * For every VQ:
+	 * 0x0      0x4          0x8         0xC       0x20
+	 * | VQ SID | QUEUE SIZE | IRQ Index |
+	 * |     DESC AREA       |
+	 * |     DEVICE AREA     |
+	 * |     DRIVER AREA     |
+	 * |     KICK AREA       |
+	 * |                    RESERVED                |
+	 *
+	 * Footer:
+	 * 0x0                     0x8
+	 * |  Next Device Address   |
+	 *
+	 * If this is the last device, footer is set to 0
+	 *
+	 * Magic number should be written last, this is the DPU indication that the data is ready
+	 */
+	magic_off = off;
+	off += 4;
+	psnet_write32(psnet, off, psnet->negotiated_cfg_ver);
+	off += 4;
+	psnet_write32(psnet, off, snet->sid);
+	off += 4;
+	psnet_write32(psnet, off, snet->cfg->virtio_id);
+	off += 4;
+	psnet_write32(psnet, off, snet->cfg->vq_num);
+	off += 4;
+	psnet_write32(psnet, off, snet->cfg_irq_idx);
+	off += 4;
+	psnet_write32(psnet, off, snet->cfg->cfg_off);
+	off += 4;
+	psnet_write64(psnet, off, snet->used_features);
+	off += 8;
+	psnet_write32(psnet, off, snet->cfg->snet_msg_off);
+	off += 4;
+	/* Ignore reserved */
+	off += 40;
+	/* Write VQs */
+	for (i = 0 ; i < snet->cfg->vq_num ; i++) {
+		psnet_write32(psnet, off, i);
+		off += 4;
+		psnet_write32(psnet, off, snet->vqs[i]->num);
+		off += 4;
+		psnet_write32(psnet, off, snet->vqs[i]->irq_idx);
+		off += 4;
+		psnet_write64(psnet, off, snet->vqs[i]->desc_area);
+		off += 8;
+		psnet_write64(psnet, off, snet->vqs[i]->device_area);
+		off += 8;
+		psnet_write64(psnet, off, snet->vqs[i]->driver_area);
+		off += 8;
+		psnet_write64(psnet, off, snet->vqs[i]->kick_offset);
+		off += 8;
+		/* Ignore reserved */
+		off += 32;
+	}
+	/* Calculate and write the next address */
+	if (is_last_snet_in_pdev(snet))
+		next_off = 0;
+	else
+		next_off = off + 8;
+
+	psnet_write64(psnet, off, next_off);
+	off += 8;
+	/* Save next address in snet pdev */
+	snet->psnet->next_dpu_addr = next_off;
+	/* Clear snet messages address */
+	snet_send_msg(snet, SNET_MSG_CLEAR);
+	/* Write magic number - data is ready */
+	psnet_write32(psnet, magic_off, SNET_SIGNATURE);
+	/* set DPU flag */
+	snet->dpu_ready = true;
+}
+
+static void snet_set_status(struct vdpa_device *vdev, u8 status)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	snet->status = status;
+	/*if status is 0, do a reset*/
+	if (!status)
+		snet_reset(snet);
+
+	/* If device is ready - write device configuration to the DPU */
+	if (status & VIRTIO_CONFIG_S_DRIVER_OK)
+		snet_write_conf(snet);
+}
+
+static void snet_get_config(struct vdpa_device *vdev, unsigned int offset,
+			    void *buf, unsigned int len)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+	u32 i;
+	/* check for offset error */
+	if (offset + len > snet->cfg->cfg_size)
+		return;
+
+	/* Write into buffer */
+	for (i = 0; i < len; i++)
+		*(u8 *)((u64)buf + i) = ioread8(snet->cfg->virtio_cfg + offset + i);
+}
+
+static void snet_set_config(struct vdpa_device *vdev, unsigned int offset,
+			    const void *buf, unsigned int len)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+	u8 i;
+	/* check for offset error */
+	if (offset + len > snet->cfg->cfg_size)
+		return;
+
+	/* Write into PCIe BAR */
+	for (i = 0; i < len; i++)
+		iowrite8(*(u8 *)((u64)buf + i), snet->cfg->virtio_cfg + offset + i);
+}
+
+static u32 snet_get_generation(struct vdpa_device *vdev)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	return snet->generation;
+}
+
+static struct vdpa_iova_range snet_get_iova_range(struct vdpa_device *vdev)
+{
+	struct vdpa_iova_range range = {
+		.first = 0ULL,
+		.last = ULLONG_MAX,
+	};
+
+	return range;
+}
+
+static void snet_free(struct vdpa_device *vdev)
+{
+	/* Resources are freed when pci's remove callback is called */
+}
+
+static const struct vdpa_config_ops snet_config_ops = {
+	.set_vq_address         = snet_set_vq_address,
+	.set_vq_num             = snet_set_vq_num,
+	.kick_vq                = snet_kick_vq,
+	.set_vq_cb              = snet_set_vq_cb,
+	.set_vq_ready           = snet_set_vq_ready,
+	.get_vq_ready           = snet_get_vq_ready,
+	.set_vq_state           = snet_set_vq_state,
+	.get_vq_state           = snet_get_vq_state,
+	.get_vq_irq		= snet_get_vq_irq,
+	.get_vq_align           = snet_get_vq_align,
+	.reset                  = snet_main_reset,
+	.get_config_size        = snet_get_config_size,
+	.get_device_features    = snet_get_features,
+	.set_driver_features    = snet_set_drv_features,
+	.get_driver_features    = snet_get_drv_features,
+	.get_vq_num_min         = snet_get_vq_num_max,
+	.get_vq_num_max         = snet_get_vq_num_max,
+	.set_config_cb          = snet_set_config_cb,
+	.get_device_id          = snet_get_device_id,
+	.get_vendor_id          = snet_get_vendor_id,
+	.get_status             = snet_get_status,
+	.set_status             = snet_set_status,
+	.get_config             = snet_get_config,
+	.set_config             = snet_set_config,
+	.get_generation         = snet_get_generation,
+	.get_iova_range         = snet_get_iova_range,
+	.free                   = snet_free,
+};
+
+static int snet_open_access_bar(struct pci_dev *pdev, struct psnet *psnet)
+{
+	int ret;
+	/* Request BAR */
+	ret = pci_request_region(pdev, SNET_ACCESS_BAR, "snet-notify");
+	if (ret) {
+		SNET_ERR(pdev, "Failed to request PCI BAR\n");
+		return ret;
+	}
+
+	/* Map BAR */
+	psnet->access_bar = pci_iomap(pdev, SNET_ACCESS_BAR, 0);
+	if (!psnet->access_bar) {
+		SNET_ERR(pdev, "Failed to map PCI BAR\n");
+		ret = -ENOMEM;
+		goto release;
+	}
+	return 0;
+release:
+	pci_release_region(pdev, SNET_ACCESS_BAR);
+	return ret;
+}
+
+static void snet_free_cfg(struct snet_cfg *cfg)
+{
+	u32 i;
+
+	if (!cfg->devs)
+		return;
+
+	/* Free devices */
+	for (i = 0; i < cfg->devices_num; i++) {
+		if (!cfg->devs[i])
+			break;
+
+		kfree(cfg->devs[i]);
+	}
+	/* Free pointers to devices */
+	kfree(cfg->devs);
+}
+
+/* Read SNET config from PCIe BAR */
+static int snet_read_cfg(struct pci_dev *pdev, struct psnet *psnet)
+{
+	struct snet_cfg *cfg = &psnet->cfg;
+	u32 i, off;
+	/* Move to where the config starts */
+	off = SNET_CONFIG_OFF;
+
+	/* SNET DPU will write SNET's signature when the config is ready */
+	cfg->key = psnet_read32(psnet, off);
+	off += 4;
+	if (cfg->key != SNET_SIGNATURE) {
+		SNET_INFO(pdev, "No valid config found in PCI BAR.\n");
+		return -ENODEV;
+	}
+
+	/* Load general config data */
+	cfg->cfg_size = psnet_read32(psnet, off);
+	off += 4;
+	cfg->cfg_ver = psnet_read32(psnet, off);
+	off += 4;
+	/* The negotiated config version is the lower one between this driver's config
+	 * and the DPU's.
+	 */
+	psnet->negotiated_cfg_ver = min_t(u32, cfg->cfg_ver, SNET_CFG_VERSION);
+	SNET_DBG(pdev, "SNET config version %u\n", psnet->negotiated_cfg_ver);
+
+	cfg->irqs_num = psnet_read32(psnet, off);
+	off += 4;
+	cfg->dpu_off = psnet_read32(psnet, off);
+	off += 4;
+	cfg->kick_off = psnet_read32(psnet, off);
+	off += 4;
+	cfg->hwmon_off = psnet_read32(psnet, off);
+	off += 4;
+	cfg->flags = psnet_read32(psnet, off);
+	off += 4;
+	/* Ignore Reserved */
+	off += sizeof(cfg->rsvd);
+
+	cfg->devices_num = psnet_read32(psnet, off);
+	off += 4;
+	/* Allocate memory to hold pointer to the devices */
+	cfg->devs = kcalloc(cfg->devices_num, sizeof(void *), GFP_KERNEL);
+	if (!cfg->devs) {
+		SNET_ERR(pdev, "Failed to allocate memory for SNET config\n");
+		return -ENOMEM;
+	}
+
+	/* Load device configuration from BAR */
+	for (i = 0; i < cfg->devices_num; i++) {
+		cfg->devs[i] = kzalloc(sizeof(struct snet_dev_cfg), GFP_KERNEL);
+		if (!cfg->devs[i]) {
+			SNET_ERR(pdev, "Failed to allocate memory for SNET config\n");
+			snet_free_cfg(cfg);
+			return -ENOMEM;
+		}
+		/* Read device config */
+		cfg->devs[i]->virtio_id = psnet_read32(psnet, off);
+		off += 4;
+		cfg->devs[i]->vq_num = psnet_read32(psnet, off);
+		off += 4;
+		cfg->devs[i]->vq_size = psnet_read32(psnet, off);
+		off += 4;
+		cfg->devs[i]->features = psnet_read64(psnet, off);
+		off += 8;
+		cfg->devs[i]->snet_msg_off = psnet_read32(psnet, off);
+		off += 4;
+		/* Ignore Reserved */
+		off += sizeof(cfg->devs[i]->rsvd);
+
+		cfg->devs[i]->cfg_size = psnet_read32(psnet, off);
+		off += 4;
+		cfg->devs[i]->cfg_off = psnet_read32(psnet, off);
+		off += 4;
+		/* Save VirtIO config address in BAR */
+		cfg->devs[i]->virtio_cfg = psnet->access_bar + off;
+		/* Move to next device, we don't want to load the VirtIO config */
+		off += cfg->devs[i]->cfg_size;
+	}
+	return 0;
+}
+
+static int snet_alloc_irq_vector(struct pci_dev *pdev, struct psnet *psnet)
+{
+	int ret = 0;
+
+	ret = pci_alloc_irq_vectors(pdev, psnet->cfg.irqs_num, psnet->cfg.irqs_num, PCI_IRQ_MSIX);
+	if (ret <= 0) {
+		SNET_ERR(pdev, "Failed to allocate IRQ vectors\n");
+		return ret;
+	} else if (ret != psnet->cfg.irqs_num) {
+		SNET_WARN(pdev, "Allocated %u irq vectors instead of %u\n", ret,
+			  psnet->cfg.irqs_num);
+	}
+	return 0;
+}
+
+static void snet_free_vqs(struct snet *snet)
+{
+	u32 i;
+
+	if (!snet->vqs)
+		return;
+
+	for (i = 0 ; i < snet->cfg->vq_num ; i++) {
+		if (!snet->vqs[i])
+			break;
+
+		kfree(snet->vqs[i]);
+	}
+	kfree(snet->vqs);
+}
+
+static int snet_build_vqs(struct pci_dev *pdev, struct snet *snet)
+{
+	u32 i;
+	/* Allocate the array of VQ pointers */
+	snet->vqs = kcalloc(snet->cfg->vq_num, sizeof(void *), GFP_KERNEL);
+	if (!snet->vqs) {
+		SNET_ERR(pdev, "Failed to allocate memory for SNET VQs\n");
+		return -ENOMEM;
+	}
+
+	/* Allocate VQs */
+	for (i = 0; i < snet->cfg->vq_num; i++) {
+		/* Allocate VQ memory */
+		snet->vqs[i] = kzalloc(sizeof(struct snet_vq), GFP_KERNEL);
+		if (!snet->vqs[i]) {
+			SNET_ERR(pdev, "Failed to allocate memory for a SNET VQ\n");
+			snet_free_vqs(snet);
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+static irqreturn_t snet_cfg_irq_hndlr(int irq, void *data)
+{
+	struct snet *snet = data;
+	/* Call callback if any */
+	if (snet->cb.callback)
+		return snet->cb.callback(snet->cb.private);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t snet_vq_irq_hndlr(int irq, void *data)
+{
+	struct snet_vq *vq = data;
+	/* Call callback if any */
+	if (vq->cb.callback)
+		return vq->cb.callback(vq->cb.private);
+
+	return IRQ_HANDLED;
+}
+
+static int snet_request_irqs(struct pci_dev *pdev, struct snet *snet)
+{
+	int ret, i;
+	/* Request one IRQ for every VQ, and one for the config change */
+	/* Get next free IRQ ID */
+	snet->cfg_irq_idx = snet->psnet->next_irq++;
+	snprintf(snet->cfg_irq_name, SNET_IRQ_NAME_SIZE, "snet-cfg-%d",  snet->cfg_irq_idx);
+
+	/* Request config IRQ */
+	snet->cfg_irq = pci_irq_vector(pdev, snet->cfg_irq_idx);
+	ret = devm_request_irq(&pdev->dev, snet->cfg_irq, snet_cfg_irq_hndlr, 0,
+			       snet->cfg_irq_name, snet);
+	if (ret) {
+		SNET_ERR(pdev, "Failed to request IRQ\n");
+		return ret;
+	}
+
+	/* Request IRQ for every VQ */
+	for (i = 0; i < snet->cfg->vq_num; i++) {
+		/* Get next free IRQ ID */
+		snet->vqs[i]->irq_idx = snet->psnet->next_irq++;
+		/* Write IRQ name */
+		snprintf(snet->vqs[i]->irq_name, SNET_IRQ_NAME_SIZE, "snet[%u]-vq[%u]",
+			 snet->sid, i);
+		/* Request IRQ */
+		snet->vqs[i]->irq = pci_irq_vector(pdev, snet->vqs[i]->irq_idx);
+		ret = devm_request_irq(&pdev->dev, snet->vqs[i]->irq, snet_vq_irq_hndlr, 0,
+				       snet->vqs[i]->irq_name, snet->vqs[i]);
+		if (ret) {
+			SNET_ERR(pdev, "Failed to request IRQ\n");
+			/* Free all IRQs requested so far and exit */
+			devm_free_irq(&pdev->dev, snet->cfg_irq, snet);
+			i--;
+			for (; i != -1; i--)
+				devm_free_irq(&pdev->dev, snet->vqs[i]->irq, snet->vqs[i]);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static void free_snet_irqs(struct pci_dev *pdev, struct snet *snet)
+{
+	u32 i;
+	/* Free config's IRQ */
+	devm_free_irq(&pdev->dev, snet->cfg_irq, snet);
+	/* Free VQ IRQs */
+	for (i = 0; i < snet->cfg->vq_num; i++)
+		devm_free_irq(&pdev->dev, snet->vqs[i]->irq, snet->vqs[i]);
+}
+
+static int snet_alloc_dev(struct pci_dev *pdev, struct psnet *psnet, struct snet_dev_cfg *dev_cfg)
+{
+	struct snet *snet;
+	int ret;
+	/* Allocate vdpa device */
+	snet = vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_config_ops, 1, 1, NULL,
+				 false);
+	if (!snet) {
+		SNET_ERR(pdev, "Failed to allocate a vdpa device\n");
+		return -ENOMEM;
+	}
+	snet->psnet = psnet;
+	snet->cfg = dev_cfg;
+	snet->dpu_ready = false;
+	snet->sid = psnet->next_snet++;
+
+	/* build snet VQs */
+	ret = snet_build_vqs(pdev, snet);
+	if (ret)
+		goto put_device;
+
+	/* Request IRQs */
+	ret = snet_request_irqs(pdev, snet);
+	if (ret)
+		goto free_vqs;
+
+	/*set DMA device*/
+	snet->vdpa.dma_dev = &pdev->dev;
+
+	/* Register VDPA device */
+	ret = vdpa_register_device(&snet->vdpa, snet->cfg->vq_num);
+	if (ret) {
+		SNET_ERR(pdev, "Failed to register vdpa device\n");
+		goto free_irqs;
+	}
+
+	/* Save snet in psnet */
+	psnet->devs[psnet->dev_num++] = snet;
+	return 0;
+
+free_irqs:
+	free_snet_irqs(pdev, snet);
+free_vqs:
+	snet_free_vqs(snet);
+put_device:
+	put_device(&snet->vdpa.dev);
+	return ret;
+}
+
+/* Free a single snet device */
+static void snet_free_dev(struct pci_dev *pdev, struct snet *snet)
+{
+	vdpa_unregister_device(&snet->vdpa);
+	snet_free_vqs(snet);
+	free_snet_irqs(pdev, snet);
+}
+
+/* Free all snet devices */
+static void snet_free_devs(struct pci_dev *pdev, struct psnet *psnet)
+{
+	u32 i;
+
+	for (i = 0 ; i < psnet->total_devs ; i++) {
+		if (psnet->devs[i])
+			snet_free_dev(pdev, psnet->devs[i]);
+		else
+			break;
+	}
+	kfree(psnet->devs);
+}
+
+static int snet_create_devs(struct pci_dev *pdev, struct psnet *psnet)
+{
+	int ret, i;
+	/* Allocate memory to hold the device pointers */
+	psnet->total_devs = psnet->cfg.devices_num;
+	psnet->devs = kcalloc(psnet->total_devs, sizeof(void *), GFP_KERNEL);
+	if (!psnet->devs) {
+		SNET_ERR(pdev, "Failed to allocate memory for SNET devices\n");
+		return -ENOMEM;
+	}
+	/* init next address */
+	psnet->next_dpu_addr = psnet->cfg.dpu_off;
+	/* Give the device an unique ID */
+	psnet->id = psnet_next_uid++;
+	/* Allocate all devices */
+	for (i = 0; i < psnet->total_devs; i++) {
+		ret = snet_alloc_dev(pdev, psnet, psnet->cfg.devs[i]);
+		if (ret) {
+			snet_free_devs(pdev, psnet);
+			return ret;
+		}
+	}
+	SNET_INFO(pdev, "Created %u SNET devices\n", psnet->total_devs);
+	return 0;
+}
+
+static int snet_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct psnet *psnet;
+	int ret = 0;
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		SNET_ERR(pdev, "Failed to enable PCI device\n");
+		return ret;
+	}
+
+	psnet = kzalloc(sizeof(struct psnet), GFP_KERNEL);
+	if (!psnet) {
+		SNET_ERR(pdev, "Failed to allocate memory for PSNET device\n");
+		ret = -ENOMEM;
+		goto disable_dev;
+	}
+
+	/* Open SNET BAR */
+	ret = snet_open_access_bar(pdev, psnet);
+	if (ret)
+		goto free_psnet;
+
+	/* Try to read SNET's config from PCIe BAR */
+	ret = snet_read_cfg(pdev, psnet);
+	if (ret)
+		goto release_bar;
+
+	/* Request for MSI-X IRQs */
+	ret = snet_alloc_irq_vector(pdev, psnet);
+	if (ret)
+		goto free_cfg;
+
+	/* Create all devices from config */
+	ret = snet_create_devs(pdev, psnet);
+	if (ret)
+		goto free_irqs;
+
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, psnet);
+
+	/* Create an HW monitor device */
+	if (SNET_CFG_FLAG(psnet, SNET_CFG_FLAG_HWMON))
+		snet_create_hwmon(pdev);
+
+	return 0;
+
+free_irqs:
+	pci_free_irq_vectors(pdev);
+free_cfg:
+	snet_free_cfg(&psnet->cfg);
+release_bar:
+	pci_iounmap(pdev, psnet->access_bar);
+	pci_release_region(pdev, SNET_ACCESS_BAR);
+free_psnet:
+	kfree(psnet);
+disable_dev:
+	pci_disable_device(pdev);
+	return ret;
+}
+
+static void snet_vdpa_remove(struct pci_dev *pdev)
+{
+	struct psnet *psnet = pci_get_drvdata(pdev);
+	struct snet *snet;
+	u32 i;
+
+	/* Iterate through all SNET devices and send a "destroy" message */
+	for (i = 0; i < psnet->cfg.devices_num; i++) {
+		snet = psnet->devs[i];
+		snet_send_msg(snet, SNET_MSG_DESTROY);
+		/* Reset status */
+		snet->status = 0;
+	}
+	/* Free all SNET devices */
+	snet_free_devs(pdev, psnet);
+	/* Free IRQ vectors */
+	pci_free_irq_vectors(pdev);
+	/* Free SNET config read from DPU */
+	snet_free_cfg(&psnet->cfg);
+	/* Unmap and release PCI BAR */
+	pci_iounmap(pdev, psnet->access_bar);
+	pci_release_region(pdev, SNET_ACCESS_BAR);
+	/* Free PSNET device */
+	SNET_INFO(pdev, "Removed %u SNET devices\n", psnet->total_devs);
+	kfree(psnet);
+}
+
+static struct pci_device_id snet_driver_pci_ids[] = {
+	{ PCI_DEVICE_SUB(SOLIDRUN_PCI_VENDOR_ID, SNET_DEVICE_ID,
+			 SOLIDRUN_PCI_VENDOR_ID, SNET_DEVICE_ID) },
+	{ 0 },
+};
+
+MODULE_DEVICE_TABLE(pci, snet_driver_pci_ids);
+
+static struct pci_driver snet_vdpa_driver = {
+	.name		= "snet-vdpa-driver",
+	.id_table	= snet_driver_pci_ids,
+	.probe		= snet_vdpa_probe,
+	.remove		= snet_vdpa_remove,
+};
+
+module_pci_driver(snet_vdpa_driver);
+
+MODULE_AUTHOR("Alvaro Karsz <alvaro.karsz@solid-run.com>");
+MODULE_DESCRIPTION("SolidRun vDPA driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/vdpa/solidrun/snet_vdpa.h b/drivers/vdpa/solidrun/snet_vdpa.h
new file mode 100644
index 00000000000..e44c900832a
--- /dev/null
+++ b/drivers/vdpa/solidrun/snet_vdpa.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SolidRun DPU driver for control plane
+ *
+ * Copyright (C) 2022 SolidRun
+ *
+ * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
+ *
+ */
+#ifndef _SNET_VDPA_H_
+#define _SNET_VDPA_H_
+
+#include <linux/vdpa.h>
+#include <linux/pci.h>
+
+#define SNET_IRQ_NAME_SIZE 20
+#define SNET_HWMON_NAME_SIZE 20
+
+#define SNET_ERR(pdev, fmt, ...) dev_err(&pdev->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
+#define SNET_WARN(pdev, fmt, ...) dev_warn(&pdev->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
+#define SNET_INFO(pdev, fmt, ...) dev_info(&pdev->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
+#define SNET_DBG(pdev, fmt, ...) dev_dbg(&pdev->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
+
+/* VQ struct */
+struct snet_vq {
+	/* VQ callback */
+	struct vdpa_callback cb;
+	/* desc base address */
+	u64 desc_area;
+	/* device base address */
+	u64 device_area;
+	/* driver base address */
+	u64 driver_area;
+	/* Queue size */
+	u32 num;
+	/* Kick address offset for this VQ */
+	u64 kick_offset;
+	/* Serial ID for VQ */
+	u32 sid;
+	/* is ready flag */
+	bool ready;
+	/* IRQ number */
+	u32 irq;
+	/* IRQ index, DPU uses this to parse data from MSI-X table */
+	u32 irq_idx;
+	/* IRQ name */
+	char irq_name[SNET_IRQ_NAME_SIZE];
+	/* pointer to mapped PCI BAR register used by this VQ to kick */
+	void __iomem *kick_ptr;
+};
+
+struct snet {
+	/* vdpa device */
+	struct vdpa_device vdpa;
+	/* Config callback */
+	struct vdpa_callback cb;
+	/* array of virqueues */
+	struct snet_vq **vqs;
+	/* Used features */
+	u64 used_features;
+	/* driver features */
+	u64 drv_features;
+	/* device generation */
+	u32 generation;
+	/* Device serial ID */
+	u32 sid;
+	/* device status */
+	u8 status;
+	/* boolean indicating if VQ data was dumped to DPU */
+	bool dpu_ready;
+	/* IRQ number */
+	u32 cfg_irq;
+	/* IRQ index, DPU uses this to parse data from MSI-X table */
+	u32 cfg_irq_idx;
+	/* IRQ name */
+	char cfg_irq_name[SNET_IRQ_NAME_SIZE];
+	/* Pointer to snet pdev parent device */
+	struct psnet *psnet;
+	/* Pointer to snet config device */
+	struct snet_dev_cfg *cfg;
+};
+
+struct snet_dev_cfg {
+	/* Device ID following VirtIO spec. */
+	u32 virtio_id;
+	/* Number of VQs for this device (NOT PAIRS!) */
+	u32 vq_num;
+	/* Size of every VQ */
+	u32 vq_size;
+	/* Device features, following VirtIO spec */
+	u64 features;
+	/* Offset to write messages to the DPU SNET_MSG_* */
+	u32 snet_msg_off;
+	/* Reserved for future usage */
+	u32 rsvd[6];
+	/* VirtIO device specific config size */
+	u32 cfg_size;
+	/* VirtIO device specific config offset in BAR */
+	u32 cfg_off;
+	/* VirtIO device specific config address */
+	void __iomem *virtio_cfg;
+} __packed;
+
+struct snet_cfg {
+	/* Magic key */
+	u32 key;
+	/* Size of total config in bytes */
+	u32 cfg_size;
+	/* Config version */
+	u32 cfg_ver;
+	/* Number of IRQs to be asked */
+	u32 irqs_num;
+	/* Offset in PCIe BAR for writing device data to DPU */
+	u32 dpu_off;
+	/* Offset in PCIe BAR for VQ kicks */
+	u32 kick_off;
+	/* Offset in PCIe BAR for HW monitoring */
+	u32 hwmon_off;
+	/* Config general flags - enum snet_cfg_flags */
+	u32 flags;
+	/* Reserved for future usage */
+	u32 rsvd[6];
+	/* Number of snet devices */
+	u32 devices_num;
+	/* The actual devices */
+	struct snet_dev_cfg **devs;
+} __packed;
+
+/* SolidNET PCIe device, one device per PCIe physical function */
+struct psnet {
+	/* Unique snet pdev id */
+	u32 id;
+	/* Number of snet devices */
+	u32 dev_num;
+	/* Control IRQ IDs */
+	u32 next_irq;
+	/* Control device IDs */
+	u32 next_snet;
+	/* Control VQ IDs */
+	u32 next_vq;
+	/* Total number of devices (including future devices) */
+	u32 total_devs;
+	/* Negotiated config version */
+	u32 negotiated_cfg_ver;
+	/* Next address to write snet info to DPU */
+	u64 next_dpu_addr;
+	/* devices list */
+	struct snet **devs;
+	/* pointer to mapped PCI BAR */
+	void __iomem *access_bar;
+	/* Pointer to the device's config read from BAR */
+	struct snet_cfg cfg;
+	/* Name of monitor device */
+	char hwmon_name[SNET_HWMON_NAME_SIZE];
+};
+
+enum snet_cfg_flags {
+	/* Create a HWMON device */
+	SNET_CFG_FLAG_HWMON = BIT(0),
+};
+
+/* Check if a config flag is set */
+#define SNET_CFG_FLAG(p, f)	((p)->cfg.flags & (f))
+
+static inline u32 psnet_read32(struct psnet *psnet, u32 off)
+{
+	return ioread32(psnet->access_bar + off);
+}
+
+static inline void psnet_write32(struct psnet *psnet, u32 off, u32 val)
+{
+	iowrite32(val, psnet->access_bar + off);
+}
+
+static inline u64 psnet_read64(struct psnet *psnet, u32 off)
+{
+	u64 val;
+
+	val = (u64)ioread32(psnet->access_bar + off);
+	val |= ((u64)ioread32(psnet->access_bar + off + 4) << 32);
+	return val;
+}
+
+static inline void psnet_write64(struct psnet *psnet, u32 off, u64 val)
+{
+	psnet_write32(psnet, off, val >> 32);
+	psnet_write32(psnet, off + 4, val & 0xFFFFFFFF);
+}
+
+void snet_create_hwmon(struct pci_dev *pdev);
+
+#endif //_SNET_VDPA_H_
-- 
2.32.0


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

