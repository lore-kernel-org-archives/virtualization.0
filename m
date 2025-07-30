Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33CB292B4D
	for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867814; cv=none; b=aoshNo4QlgnQ/wmDfGkNaZMVgBRjUfD7ROy7Y4bgUkRNgv0c0RLq54QTi5xeekklJc/glmKq/GvGbUKodpU4dHJEfEJh5A/vimWPMxJQsu6cSiTCn+mn6WEpMXwmXpv1hQ24UDCjpVoDCYNF2YlU/ABkleH0JReyDWaXrhiPp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867814; c=relaxed/simple;
	bh=28YY79GFjl+hM8HZrdmjJDLd2cqTsYSp+YdjB06PAas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ubDgJoJLFILqdg8jSCQWJmsxWWDFeo10bbPkNLuelZ2Dic5/3EhAujzjbJLMy6EK2exEh+L8fwrvh+aWEmgtIaKiW/kUHFVzfm2A4HtlaaiMmS9TObZPK/nAmZuwtGnthj7jY2m199eIhOExKT2mxrwAzwtIMImoSiKluxuANDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8awLcEP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8awLcEP"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso1158100b3a.3
        for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 02:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753867811; x=1754472611; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIAaZo+AqJKeIQbQL2TV8b2KKjEOk6DoCk5oJX1a0a8=;
        b=j8awLcEPflkhCYF/bs9j9ETNLTdN7H0VEJgDg3uSTFFwnOrU1TsaPAL9l1C9LXc4/d
         pU2IAawZ9q2eHbkFXvh9PuejxCSVoGpw6wufzysT2QYYzz91YBpgU/nxisUjSA2aZqrn
         qZidGP7sJJeCQNndrMDBMgnF5JEVsd2Mlj8CrMhnYWj7XkxdZ7SP6KGEWHU92FGHR88f
         GP4cMwHVoPHEVAP+richlUjAzrKry4lP8CvXbqoBpTwFN9D7MDaoI5fS+dzZ/F1d7jtY
         Fj2LkOBbdIT4RHJQBlZJScfXmsdRmxhG4p9HGcfcFC3OzQQL4tj6Z03SxNKOZe43MFuD
         13xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867811; x=1754472611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIAaZo+AqJKeIQbQL2TV8b2KKjEOk6DoCk5oJX1a0a8=;
        b=Z2w/0m384kFvP1VLReB94bwTxvhNvXhV8RKSZ7rniOoYUDClaMmPMMw2bwT8aCTjfW
         s6/anmrKeL9WN5tQMaVMvShOnE+qAG49/kYwrqpDblh9CQ0+VWN4j4Zap5ehh09Xn+RQ
         8ALWGyGR1agjcU4dK061ow8hj2PvUDhqDZrarRQj2htFZL9j/uNKwKfHhd+RvOTWgVPu
         AZcmlvi8XcBeASao5pQ7hc5mR0aiLrfnWiI0mkF+7EwRiPv2stcvXzV7HjG3N4HvmKLM
         L0lP0zrZwG/YeahVHzXpFk+OrKq/RTc5NEqSvJ8srSFFoa7q9BBOzC/ie53J80vKnCkX
         4w+A==
X-Forwarded-Encrypted: i=1; AJvYcCWxpd+iPFMGHMtxLn0ZNfc/uogOnUr1hVkNzqSBPgIyCtYC4TCy5aadMPY1FTXyhqXLv8gPWIDQHoN4EQQffw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRYY2KVP/ZGCMJKeHIKMyT4tFOaK9KAlDy//g3948NWTIWZkNd
	GLZ+z3xHki7vHEbCvGYW5C59fz/22uFApW68EIKaK25zAUo2dSmmv+yiXB9cPv1eBu4=
X-Gm-Gg: ASbGncvmVmsnR+UMIqxrMLc6KCFvftyZxSI6K6HnI5lirgbUlGm1Nj+1psxY3EFiQKL
	7lGaSUqmFcNkB68RIt8orfyGNDNxcfRcZqbqiMiEZRnfCRnlv7xxmRAA7mV3YSqa0aghb5jVGM/
	3UcpX4Wd9bSw2kWGXuKWlaBXkSPobx+j/PFYg7tEwKiQj+zt0qP8CrxDLxjncL6BqFMXa3VrJVU
	nnLsqMpY7A0YoLZNimigIkqk4/x+s7vFFji8jeviLccNtJXdU0Uz/gI1JORDo5eyob0KTz1YiOS
	bB78p7MkYg8U7s8H0nB0E6I1656BKiyNGfXz8dzk0If2OXu6AjlIigHoaIWeswldPszL/4jaWAf
	AYnEZ2XPjHDZSbj7+kbALISU=
X-Google-Smtp-Source: AGHT+IGoQYRgE/xCt11HlKmjHJ6BWta8RG1iAWKjGhUYUuslzxH8eST83YTCzDSFHb5yqiGXLYNVGQ==
X-Received: by 2002:aa7:888a:0:b0:742:a77b:8c4 with SMTP id d2e1a72fcca58-76ab0f1787fmr4602205b3a.3.1753867810602;
        Wed, 30 Jul 2025 02:30:10 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640ad0688asm9499455b3a.73.2025.07.30.02.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:30:09 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [RFC PATCH  3/6] virtio: Add support for virtio-msg transport
Date: Wed, 30 Jul 2025 14:59:32 +0530
Message-Id: <9238de42e22678fdd7c483f407720c9272a56428.1753865268.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1753865268.git.viresh.kumar@linaro.org>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces support for a new Virtio transport type: "virtio-msg".
Unlike existing transport types like virtio-mmio or virtio-pci which
rely on memory-mapped registers, virtio-msg implements transport
operations via structured message exchanges using standard virtqueues.

It separates bus-level functionality (e.g., device enumeration, hotplug
events) from device-specific operations (e.g., feature negotiation,
virtqueue setup), ensuring that a single, generic transport layer can be
reused across multiple bus implementations (like ARM Firmware Framework
(FF-A), IPC, etc.).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                          |   7 +
 drivers/virtio/Kconfig               |   7 +
 drivers/virtio/Makefile              |   1 +
 drivers/virtio/virtio_msg.c          | 655 +++++++++++++++++++++++++++
 drivers/virtio/virtio_msg_internal.h |  56 +++
 include/uapi/linux/virtio_msg.h      | 213 +++++++++
 6 files changed, 939 insertions(+)
 create mode 100644 drivers/virtio/virtio_msg.c
 create mode 100644 drivers/virtio/virtio_msg_internal.h
 create mode 100644 include/uapi/linux/virtio_msg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c0b444e5fd5a..7d9ecac4fdbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26358,6 +26358,13 @@ W:	https://virtio-mem.gitlab.io/
 F:	drivers/virtio/virtio_mem.c
 F:	include/uapi/linux/virtio_mem.h
 
+VIRTIO MSG TRANSPORT
+M:	Viresh Kumar <viresh.kumar@linaro.org>
+L:	virtualization@lists.linux.dev
+S:	Maintained
+F:	drivers/virtio/virtio_msg*
+F:	include/uapi/linux/virtio_msg*
+
 VIRTIO PMEM DRIVER
 M:	Pankaj Gupta <pankaj.gupta.linux@gmail.com>
 L:	virtualization@lists.linux.dev
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 6db5235a7693..690ac98850b6 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -171,6 +171,13 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
 
 	 If unsure, say 'N'.
 
+config VIRTIO_MSG
+	tristate
+	select VIRTIO
+	help
+	  This enables support for Virtio message transport. This option is
+	  selected by any driver which implements the virtio message bus.
+
 config VIRTIO_DMA_SHARED_BUFFER
 	tristate
 	depends on DMA_SHARED_BUFFER
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index eefcfe90d6b8..3eff8ca72446 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
 obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
 obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
 obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
+obj-$(CONFIG_VIRTIO_MSG) += virtio_msg.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
 virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
 virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
diff --git a/drivers/virtio/virtio_msg.c b/drivers/virtio/virtio_msg.c
new file mode 100644
index 000000000000..7034818475ab
--- /dev/null
+++ b/drivers/virtio/virtio_msg.c
@@ -0,0 +1,655 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Virtio message transport.
+ *
+ * Copyright (C) 2025 Google LLC and Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * The virtio-msg transport encapsulates virtio operations as discrete message
+ * exchanges rather than relying on PCI or memory-mapped I/O regions. It
+ * separates bus-level functionality (e.g., device enumeration, hotplug events)
+ * from device-specific operations (e.g., feature negotiation, virtqueue setup),
+ * ensuring that a single, generic transport layer can be reused across multiple
+ * bus implementations (like ARM Firmware Framework (FF-A), IPC, etc.).
+ *
+ * This file implements the generic Virtio message transport layer.
+ */
+
+#define pr_fmt(fmt) "virtio-msg: " fmt
+
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ring.h>
+#include <uapi/linux/virtio_msg.h>
+
+#include "virtio_msg_internal.h"
+
+#define to_virtio_msg_device(_dev)	\
+	container_of(_dev, struct virtio_msg_device, vdev)
+
+static void msg_prepare(struct virtio_msg *vmsg, bool bus, u8 msg_id,
+			u16 dev_id, u16 payload_size)
+{
+	u16 size = sizeof(*vmsg) + payload_size;
+
+	memset(vmsg, 0, size);
+
+	if (bus) {
+		vmsg->type = VIRTIO_MSG_TYPE_BUS;
+	} else {
+		vmsg->type = VIRTIO_MSG_TYPE_TRANSPORT;
+		vmsg->dev_id = cpu_to_le16(dev_id);
+	}
+
+	vmsg->msg_id = msg_id;
+	vmsg->msg_size = cpu_to_le16(size);
+}
+
+static void transport_msg_prepare(struct virtio_msg_device *vmdev, u8 msg_id,
+				  u16 payload_size)
+{
+	msg_prepare(vmdev->request, false, msg_id, vmdev->dev_id, payload_size);
+}
+
+/**
+ * virtio_msg_prepare - Initialize a virtio message for bus transfer
+ * @vmsg: Pointer to the virtio message structure to initialize
+ * @msg_id: Message ID to set in the message header
+ * @payload_size: Size of the payload (in bytes)
+ *
+ * Prepares a virtio_msg structure for transmission over the bus transport
+ * (VIRTIO_MSG_TYPE_BUS). The payload buffer follows the header.
+ */
+void virtio_msg_prepare(struct virtio_msg *vmsg, u8 msg_id, u16 payload_size)
+{
+	msg_prepare(vmsg, true, msg_id, 0, payload_size);
+}
+EXPORT_SYMBOL_GPL(virtio_msg_prepare);
+
+static int virtio_msg_xfer(struct virtio_msg_device *vmdev)
+{
+	int ret;
+
+	memset(vmdev->response, 0, vmdev->msg_size);
+
+	ret = vmdev->ops->transfer(vmdev, vmdev->request, vmdev->response);
+	if (ret)
+		dev_err(&vmdev->vdev.dev, "Transfer request failed (%d)\n", ret);
+
+	return ret;
+}
+
+static inline int virtio_msg_send(struct virtio_msg_device *vmdev)
+{
+	int ret;
+
+	ret = vmdev->ops->transfer(vmdev, vmdev->request, NULL);
+	if (ret)
+		dev_err(&vmdev->vdev.dev, "Send request failed (%d)\n", ret);
+
+	return ret;
+}
+
+static int virtio_msg_get_device_info(struct virtio_msg_device *vmdev)
+{
+	struct get_device_info_resp *payload = virtio_msg_payload(vmdev->response);
+	struct virtio_device *vdev = &vmdev->vdev;
+	u32 num_feature_bits;
+	int ret;
+
+	static_assert(sizeof(*vmdev->response) + sizeof(*payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_DEVICE_INFO, 0);
+
+	ret = virtio_msg_xfer(vmdev);
+	if (ret)
+		return ret;
+
+	vdev->id.device = le32_to_cpu(payload->device_id);
+	if (vdev->id.device == 0) {
+		/*
+		 * A virtio device with ID 0 is a placeholder and indicates no
+		 * valid device function is present.
+		 */
+		return -ENODEV;
+	}
+
+	vdev->id.vendor = le32_to_cpu(payload->vendor_id);
+	vmdev->config_size = le32_to_cpu(payload->config_size);
+	num_feature_bits = le32_to_cpu(payload->num_feature_bits);
+
+	/* Linux supports 64 feature bits */
+	if (num_feature_bits != 64) {
+		dev_err(&vdev->dev, "Incompatible num_feature_bits (%u)\n",
+			num_feature_bits);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u64 virtio_msg_get_features(struct virtio_device *vdev)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vdev);
+	struct get_features *req_payload = virtio_msg_payload(vmdev->request);
+	struct get_features_resp *res_payload = virtio_msg_payload(vmdev->response);
+	__le32 *features;
+	int ret;
+
+	static_assert(sizeof(*vmdev->request) + sizeof(*req_payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+	static_assert(sizeof(*vmdev->response) + sizeof(*res_payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_GET_DEV_FEATURES,
+			      sizeof(*req_payload));
+
+	/* Linux supports 64 feature bits */
+	req_payload->num = cpu_to_le32(2);
+	req_payload->index = 0;
+
+	ret = virtio_msg_xfer(vmdev);
+	if (ret)
+		return 0;
+
+	features = (__le32 *)res_payload->features;
+	return ((u64)(le32_to_cpu(features[1])) << 32) | le32_to_cpu(features[0]);
+}
+
+static int virtio_msg_finalize_features(struct virtio_device *vdev)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vdev);
+	struct set_features *payload = virtio_msg_payload(vmdev->request);
+	__le32 *features = (__le32 *)payload->features;
+
+	static_assert(sizeof(*vmdev->request) + sizeof(*payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+
+	/* Give virtio_ring a chance to accept features */
+	vring_transport_features(vdev);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_SET_DRV_FEATURES, sizeof(*payload));
+
+	/* Linux supports 64 feature bits */
+	payload->num = cpu_to_le32(2);
+	payload->index = 0;
+
+	features[0] = cpu_to_le32((u32)vmdev->vdev.features);
+	features[1] = cpu_to_le32(vmdev->vdev.features >> 32);
+
+	return virtio_msg_xfer(vmdev);
+}
+
+static void virtio_msg_get(struct virtio_device *vdev, unsigned int offset,
+			   void *buf, unsigned int len)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vdev);
+	struct get_config *req_payload = virtio_msg_payload(vmdev->request);
+	struct get_config_resp *res_payload = virtio_msg_payload(vmdev->response);
+	u32 i = 0, max;
+
+	static_assert(sizeof(*vmdev->request) + sizeof(*req_payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+	static_assert(sizeof(*vmdev->response) + sizeof(*res_payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+
+	if (offset + len > vmdev->config_size) {
+		dev_err(&vmdev->vdev.dev,
+			"Invalid config read operation: %u: %u: %u\n", offset,
+			len, vmdev->config_size);
+		return;
+	}
+
+	/* Maximum payload size available in the response message buffer */
+	max = vmdev->msg_size - sizeof(*vmdev->response) - sizeof(*res_payload);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_GET_CONFIG, sizeof(*req_payload));
+
+	while (i != len) {
+		u32 size = min(max, len - i);
+
+		req_payload->offset = cpu_to_le32(offset + i);
+		req_payload->size = cpu_to_le32(size);
+
+		if (virtio_msg_xfer(vmdev))
+			return;
+
+		/* Buffer holds the data in little endian */
+		memcpy(buf + i, res_payload->config, size);
+		i += size;
+	}
+
+	vmdev->generation_count = le32_to_cpu(res_payload->generation);
+}
+
+static void virtio_msg_set(struct virtio_device *vdev, unsigned int offset,
+			   const void *buf, unsigned int len)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vdev);
+	struct set_config *payload = virtio_msg_payload(vmdev->request);
+	u32 i = 0, max;
+
+	static_assert(sizeof(*vmdev->request) + sizeof(*payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+
+	if (offset + len > vmdev->config_size) {
+		dev_err(&vmdev->vdev.dev,
+			"Invalid config write operation: %u: %u: %u\n", offset,
+			len, vmdev->config_size);
+		return;
+	}
+
+	/* Maximum payload size available in the request message buffer */
+	max = vmdev->msg_size - sizeof(*vmdev->request) - sizeof(*payload);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_SET_CONFIG, sizeof(*payload));
+	payload->generation = cpu_to_le32(vmdev->generation_count);
+
+	while (i != len) {
+		u32 size = min(max, len - i);
+
+		payload->offset = cpu_to_le32(offset + i);
+		payload->size = cpu_to_le32(size);
+
+		/* Buffer holds the data in little endian */
+		memcpy(payload->config, buf + i, size);
+		i += size;
+
+		if (virtio_msg_xfer(vmdev))
+			return;
+	}
+}
+
+static u32 virtio_msg_generation(struct virtio_device *vdev)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vdev);
+	struct get_config *req_payload = virtio_msg_payload(vmdev->request);
+	struct get_config_resp *res_payload = virtio_msg_payload(vmdev->response);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_GET_CONFIG, sizeof(*req_payload));
+	req_payload->offset = cpu_to_le32(0);
+	req_payload->size = cpu_to_le32(0);
+
+	if (virtio_msg_xfer(vmdev))
+		return 0;
+
+	vmdev->generation_count = le32_to_cpu(res_payload->generation);
+	return vmdev->generation_count;
+}
+
+static u8 virtio_msg_get_status(struct virtio_device *vdev)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vdev);
+	struct get_device_status_resp *payload = virtio_msg_payload(vmdev->response);
+
+	static_assert(sizeof(*vmdev->response) + sizeof(*payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_GET_DEVICE_STATUS, 0);
+
+	if (virtio_msg_xfer(vmdev))
+		return 0;
+
+	return (u8)le32_to_cpu(payload->status);
+}
+
+static void virtio_msg_set_status(struct virtio_device *vdev, u8 status)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vdev);
+	struct set_device_status *payload = virtio_msg_payload(vmdev->request);
+
+	static_assert(sizeof(*vmdev->request) + sizeof(*payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_SET_DEVICE_STATUS, sizeof(*payload));
+	payload->status = cpu_to_le32(status);
+
+	if (virtio_msg_xfer(vmdev))
+		dev_warn(&vmdev->vdev.dev, "Set status %u failed\n", status);
+}
+
+static void virtio_msg_vq_reset(struct virtqueue *vq)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vq->vdev);
+	struct reset_vqueue *payload = virtio_msg_payload(vmdev->request);
+
+	static_assert(sizeof(*vmdev->request) + sizeof(*payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_RESET_VQUEUE, sizeof(*payload));
+	payload->index = cpu_to_le32(vq->index);
+
+	if (virtio_msg_xfer(vmdev))
+		dev_warn(&vmdev->vdev.dev, "Virtqueue reset failed\n");
+}
+
+static void virtio_msg_reset(struct virtio_device *vdev)
+{
+	/* Setting status to 0 initiates a device reset */
+	virtio_msg_set_status(vdev, 0);
+}
+
+static bool _vmsg_notify(struct virtqueue *vq, u32 index, u32 offset, u32 wrap)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vq->vdev);
+	struct event_avail *payload = virtio_msg_payload(vmdev->request);
+	u32 val;
+
+	static_assert(sizeof(*vmdev->request) + sizeof(*payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_EVENT_AVAIL, sizeof(*payload));
+	payload->index = cpu_to_le32(index);
+
+	val = offset & ((1U << VIRTIO_MSG_EVENT_AVAIL_WRAP_SHIFT) - 1);
+	val |= wrap & (1U << VIRTIO_MSG_EVENT_AVAIL_WRAP_SHIFT);
+	payload->next_offset_wrap = cpu_to_le32(val);
+
+	return !virtio_msg_send(vmdev);
+}
+
+static bool virtio_msg_notify(struct virtqueue *vq)
+{
+	return _vmsg_notify(vq, vq->index, 0, 0);
+}
+
+static bool virtio_msg_notify_with_data(struct virtqueue *vq)
+{
+	u32 index, offset, wrap, data = vring_notification_data(vq);
+
+	index = data | 0xFFFF;
+	data >>= 16;
+	offset = data | 0x7FFF;
+	wrap = data >> 15;
+
+	return _vmsg_notify(vq, index, offset, wrap);
+}
+
+/**
+ * virtio_msg_event - Handle an incoming event message for a virtio message device.
+ * @vmdev: Pointer to the virtio message device.
+ * @vmsg: Pointer to the incoming virtio message containing the event.
+ *
+ * Processes an event message received from the bus layer for the given
+ * virtio message device. Depending on the message type, this function either:
+ *
+ *  - Triggers the device configuration change handler if the message is of type
+ *    VIRTIO_MSG_EVENT_CONFIG.
+ *
+ *  - Delivers a used-buffer notification to the corresponding virtqueue if the
+ *    message is of type VIRTIO_MSG_EVENT_USED.
+ *
+ * Return: 0 on success, -EIO if the interrupt handler fails, -EINVAL for
+ * unknown message types or invalid virtqueue indices.
+ */
+int virtio_msg_event(struct virtio_msg_device *vmdev, struct virtio_msg *vmsg)
+{
+	struct event_used *payload = virtio_msg_payload(vmsg);
+	struct device *dev = &vmdev->vdev.dev;
+	struct virtqueue *vq;
+	unsigned int index;
+
+	if (vmsg->msg_id == VIRTIO_MSG_EVENT_CONFIG) {
+		virtio_config_changed(&vmdev->vdev);
+		return 0;
+	}
+
+	if (vmsg->msg_id == VIRTIO_MSG_EVENT_USED) {
+		index = le32_to_cpu(payload->index);
+
+		virtio_device_for_each_vq(&vmdev->vdev, vq) {
+			if (index == vq->index) {
+				if (vring_interrupt(0, vq) != IRQ_HANDLED)
+					return -EIO;
+
+				return 0;
+			}
+		}
+
+		dev_err(dev, "Failed to find virtqueue (%u)", index);
+	} else {
+		dev_err(dev, "Unexpected message id: (%u)\n", vmsg->msg_id);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(virtio_msg_event);
+
+static void virtio_msg_del_vqs(struct virtio_device *vdev)
+{
+	struct virtqueue *vq, *n;
+
+	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
+		virtio_msg_vq_reset(vq);
+		vring_del_virtqueue(vq);
+	}
+}
+
+static int virtio_msg_vq_get(struct virtio_msg_device *vmdev, unsigned int *num,
+			     unsigned int index)
+{
+	struct get_vqueue *req_payload = virtio_msg_payload(vmdev->request);
+	struct get_vqueue_resp *res_payload = virtio_msg_payload(vmdev->response);
+	int ret;
+
+	static_assert(sizeof(*vmdev->request) + sizeof(*req_payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+	static_assert(sizeof(*vmdev->response) + sizeof(*res_payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_GET_VQUEUE, sizeof(*req_payload));
+	req_payload->index = cpu_to_le32(index);
+
+	ret = virtio_msg_xfer(vmdev);
+	if (ret)
+		return ret;
+
+	*num = le32_to_cpu(res_payload->max_size);
+	if (!*num)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int virtio_msg_vq_set(struct virtio_msg_device *vmdev,
+			     struct virtqueue *vq, unsigned int index)
+{
+	struct set_vqueue *payload = virtio_msg_payload(vmdev->request);
+
+	static_assert(sizeof(*vmdev->request) + sizeof(*payload) <
+		      VIRTIO_MSG_MIN_SIZE);
+
+	transport_msg_prepare(vmdev, VIRTIO_MSG_SET_VQUEUE, sizeof(*payload));
+	payload->index = cpu_to_le32(index);
+	payload->size = cpu_to_le32(virtqueue_get_vring_size(vq));
+	payload->descriptor_addr = cpu_to_le64(virtqueue_get_desc_addr(vq));
+	payload->driver_addr = cpu_to_le64(virtqueue_get_avail_addr(vq));
+	payload->device_addr = cpu_to_le64(virtqueue_get_used_addr(vq));
+
+	return virtio_msg_xfer(vmdev);
+}
+
+static struct virtqueue *
+virtio_msg_setup_vq(struct virtio_msg_device *vmdev, unsigned int index,
+		    void (*callback)(struct virtqueue *vq), const char *name,
+		    bool ctx)
+{
+	bool (*notify)(struct virtqueue *vq);
+	struct virtqueue *vq;
+	unsigned int num;
+	int ret;
+
+	if (__virtio_test_bit(&vmdev->vdev, VIRTIO_F_NOTIFICATION_DATA))
+		notify = virtio_msg_notify_with_data;
+	else
+		notify = virtio_msg_notify;
+
+	ret = virtio_msg_vq_get(vmdev, &num, index);
+	if (ret)
+		return ERR_PTR(ret);
+
+	vq = vring_create_virtqueue(index, num, PAGE_SIZE, &vmdev->vdev, true,
+				    true, ctx, notify, callback, name);
+	if (!vq)
+		return ERR_PTR(-ENOMEM);
+
+	vq->num_max = num;
+
+	ret = virtio_msg_vq_set(vmdev, vq, index);
+	if (ret) {
+		vring_del_virtqueue(vq);
+		return ERR_PTR(ret);
+	}
+
+	return vq;
+}
+
+static int virtio_msg_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
+			       struct virtqueue *vqs[],
+			       struct virtqueue_info vqs_info[],
+			       struct irq_affinity *desc)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vdev);
+	int i, queue_idx = 0;
+
+	for (i = 0; i < nvqs; ++i) {
+		struct virtqueue_info *vqi = &vqs_info[i];
+
+		if (!vqi->name) {
+			vqs[i] = NULL;
+			continue;
+		}
+
+		vqs[i] = virtio_msg_setup_vq(vmdev, queue_idx++, vqi->callback,
+					     vqi->name, vqi->ctx);
+		if (IS_ERR(vqs[i])) {
+			virtio_msg_del_vqs(vdev);
+			return PTR_ERR(vqs[i]);
+		}
+	}
+
+	return 0;
+}
+
+static const char *virtio_msg_bus_name(struct virtio_device *vdev)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vdev);
+
+	return vmdev->bus_name;
+}
+
+static void virtio_msg_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vdev);
+
+	vmdev->ops->synchronize_cbs(vmdev);
+}
+
+static void virtio_msg_release_dev(struct device *_d)
+{
+	struct virtio_device *vdev =
+			container_of(_d, struct virtio_device, dev);
+	struct virtio_msg_device *vmdev = to_virtio_msg_device(vdev);
+
+	if (vmdev->ops->release)
+		vmdev->ops->release(vmdev);
+}
+
+static struct virtio_config_ops virtio_msg_config_ops = {
+	.get			= virtio_msg_get,
+	.set			= virtio_msg_set,
+	.generation		= virtio_msg_generation,
+	.get_status		= virtio_msg_get_status,
+	.set_status		= virtio_msg_set_status,
+	.reset			= virtio_msg_reset,
+	.find_vqs		= virtio_msg_find_vqs,
+	.del_vqs		= virtio_msg_del_vqs,
+	.get_features		= virtio_msg_get_features,
+	.finalize_features	= virtio_msg_finalize_features,
+	.bus_name		= virtio_msg_bus_name,
+};
+
+/**
+ * virtio_msg_register - Register a virtio message device with the virtio core
+ * @vmdev: Pointer to the virtio message device to register
+ *
+ * Initializes and registers a virtio message device.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int virtio_msg_register(struct virtio_msg_device *vmdev)
+{
+	u32 version;
+	int ret;
+
+	if (!vmdev || !vmdev->ops || !vmdev->ops->bus_info ||
+	    !vmdev->ops->transfer)
+		return -EINVAL;
+
+	vmdev->bus_name = vmdev->ops->bus_info(vmdev, &vmdev->msg_size,
+					       &version);
+	if (version != VIRTIO_MSG_REVISION_1 ||
+	    vmdev->msg_size < VIRTIO_MSG_MIN_SIZE)
+		return -EINVAL;
+
+	/*
+	 * Allocate per-device request and response buffers, each of size
+	 * `msg_size`.
+	 *
+	 * Since requests are serialized per device, one pair of buffers
+	 * suffices.
+	 */
+	vmdev->request = kzalloc(2 * vmdev->msg_size, GFP_KERNEL);
+	if (!vmdev->request)
+		return -ENOMEM;
+
+	vmdev->response = (void *)vmdev->request + vmdev->msg_size;
+
+	vmdev->vdev.config = &virtio_msg_config_ops;
+	vmdev->vdev.dev.release = virtio_msg_release_dev;
+
+	if (vmdev->ops->synchronize_cbs)
+		virtio_msg_config_ops.synchronize_cbs = virtio_msg_synchronize_cbs;
+
+	ret = virtio_msg_get_device_info(vmdev);
+	if (ret) {
+		if (vmdev->ops->release)
+			vmdev->ops->release(vmdev);
+		goto free;
+	}
+
+	ret = register_virtio_device(&vmdev->vdev);
+	if (ret) {
+		put_device(&vmdev->vdev.dev);
+		goto free;
+	}
+
+	return 0;
+
+free:
+	kfree(vmdev->request);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_msg_register);
+
+/**
+ * virtio_msg_unregister - Unregister a virtio message device
+ * @vmdev: Pointer to the virtio message device to unregister
+ *
+ * Unregisters a previously registered virtio message device from the virtio
+ * core and releases associated resources.
+ */
+void virtio_msg_unregister(struct virtio_msg_device *vmdev)
+{
+	unregister_virtio_device(&vmdev->vdev);
+	kfree(vmdev->request);
+}
+EXPORT_SYMBOL_GPL(virtio_msg_unregister);
+
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
+MODULE_DESCRIPTION("Virtio message transport");
+MODULE_LICENSE("GPL");
diff --git a/drivers/virtio/virtio_msg_internal.h b/drivers/virtio/virtio_msg_internal.h
new file mode 100644
index 000000000000..b7c2cb44b67b
--- /dev/null
+++ b/drivers/virtio/virtio_msg_internal.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Virtio message transport header.
+ *
+ * Copyright (C) 2025 Google LLC and Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef _DRIVERS_VIRTIO_MSG_INTERNAL_H
+#define _DRIVERS_VIRTIO_MSG_INTERNAL_H
+
+#include <linux/virtio.h>
+#include <uapi/linux/virtio_msg.h>
+
+struct virtio_msg_device;
+
+/*
+ * struct virtio_msg_ops - Virtio message bus operations.
+ * @bus_info: Return bus information.
+ * @transfer: Transfer a message.
+ * @synchronize_cbs: Synchronize with the virtqueue callbacks (optional).
+ * @release: Release the resources corresponding to the device (optional).
+ */
+struct virtio_msg_ops {
+	const char *(*bus_info)(struct virtio_msg_device *vmdev, u16 *msg_size, u32 *rev);
+	int (*transfer)(struct virtio_msg_device *vmdev, struct virtio_msg *request,
+			struct virtio_msg *response);
+	void (*synchronize_cbs)(struct virtio_msg_device *vmdev);
+	void (*release)(struct virtio_msg_device *vmdev);
+};
+
+/*
+ * Representation of a device using virtio message
+ * transport.
+ */
+struct virtio_msg_device {
+	struct virtio_device vdev;
+	struct virtio_msg_ops *ops;
+	const char *bus_name;
+	void *bus_data;
+	u32 generation_count;
+	u32 config_size;
+	u16 msg_size;
+	u16 dev_id;
+
+	struct virtio_msg *request;
+	struct virtio_msg *response;
+};
+
+int virtio_msg_register(struct virtio_msg_device *vmdev);
+void virtio_msg_unregister(struct virtio_msg_device *vmdev);
+
+void virtio_msg_prepare(struct virtio_msg *vmsg, u8 msg_id, u16 payload_size);
+int virtio_msg_event(struct virtio_msg_device *vmdev, struct virtio_msg *vmsg);
+
+#endif /* _DRIVERS_VIRTIO_MSG_INTERNAL_H */
diff --git a/include/uapi/linux/virtio_msg.h b/include/uapi/linux/virtio_msg.h
new file mode 100644
index 000000000000..4f619906015b
--- /dev/null
+++ b/include/uapi/linux/virtio_msg.h
@@ -0,0 +1,213 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Virtio message transport header.
+ *
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
+ * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
+ *
+ * Copyright (C) 2025 Google LLC and Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef _LINUX_VIRTIO_MSG_H
+#define _LINUX_VIRTIO_MSG_H
+
+#include <linux/types.h>
+
+/* Virtio message transport definitions */
+
+/* Message types */
+#define VIRTIO_MSG_DEVICE_INFO			0x02
+#define VIRTIO_MSG_GET_DEV_FEATURES		0x03
+#define VIRTIO_MSG_SET_DRV_FEATURES		0x04
+#define VIRTIO_MSG_GET_CONFIG			0x05
+#define VIRTIO_MSG_SET_CONFIG			0x06
+#define VIRTIO_MSG_GET_DEVICE_STATUS		0x07
+#define VIRTIO_MSG_SET_DEVICE_STATUS		0x08
+#define VIRTIO_MSG_GET_VQUEUE			0x09
+#define VIRTIO_MSG_SET_VQUEUE			0x0a
+#define VIRTIO_MSG_RESET_VQUEUE			0x0b
+#define VIRTIO_MSG_GET_SHM			0x0c
+#define VIRTIO_MSG_EVENT_CONFIG			0x40
+#define VIRTIO_MSG_EVENT_AVAIL			0x41
+#define VIRTIO_MSG_EVENT_USED			0x42
+#define VIRTIO_MSG_MAX				VIRTIO_MSG_EVENT_USED
+
+#define VIRTIO_MSG_MIN_SIZE			44
+#define VIRTIO_MSG_MAX_SIZE			65536
+#define VIRTIO_MSG_REVISION_1			0x1
+
+/* Message payload format */
+
+struct get_device_info_resp {
+	__le32 device_id;
+	__le32 vendor_id;
+	__le32 num_feature_bits;
+	__le32 config_size;
+	__le32 max_vq_count;
+	__le16 admin_vq_start_idx;
+	__le16 admin_vq_count;
+} __attribute__((packed));
+
+struct get_features {
+	__le32 index;
+	__le32 num;
+} __attribute__((packed));
+
+struct get_features_resp {
+	__le32 index;
+	__le32 num;
+	__u8 features[];
+} __attribute__((packed));
+
+struct set_features {
+	__le32 index;
+	__le32 num;
+	__u8 features[];
+} __attribute__((packed));
+
+struct get_config {
+	__le32 offset;
+	__le32 size;
+} __attribute__((packed));
+
+struct get_config_resp {
+	__le32 generation;
+	__le32 offset;
+	__le32 size;
+	__u8 config[];
+} __attribute__((packed));
+
+struct set_config {
+	__le32 generation;
+	__le32 offset;
+	__le32 size;
+	__u8 config[];
+} __attribute__((packed));
+
+struct set_config_resp {
+	__le32 generation;
+	__le32 offset;
+	__le32 size;
+	__u8 config[];
+} __attribute__((packed));
+
+struct get_device_status_resp {
+	__le32 status;
+} __attribute__((packed));
+
+struct set_device_status {
+	__le32 status;
+} __attribute__((packed));
+
+struct set_device_status_resp {
+	__le32 status;
+} __attribute__((packed));
+
+struct get_vqueue {
+	__le32 index;
+} __attribute__((packed));
+
+struct get_vqueue_resp {
+	__le32 index;
+	__le32 max_size;
+	__le32 size;
+	__le64 descriptor_addr;
+	__le64 driver_addr;
+	__le64 device_addr;
+} __attribute__((packed));
+
+struct set_vqueue {
+	__le32 index;
+	__le32 unused;
+	__le32 size;
+	__le64 descriptor_addr;
+	__le64 driver_addr;
+	__le64 device_addr;
+} __attribute__((packed));
+
+struct reset_vqueue {
+	__le32 index;
+} __attribute__((packed));
+
+struct get_shm {
+	__le32 index;
+} __attribute__((packed));
+
+struct get_shm_resp {
+	__le32 index;
+	__le32 count;
+	__le32 addr;
+} __attribute__((packed));
+
+struct event_config {
+	__le32 status;
+	__le32 generation;
+	__le32 offset;
+	__le32 size;
+	__u8 config[];
+} __attribute__((packed));
+
+struct event_avail {
+	__le32 index;
+	#define VIRTIO_MSG_EVENT_AVAIL_WRAP_SHIFT	31
+	__le32 next_offset_wrap;
+} __attribute__((packed));
+
+struct event_used {
+	__le32 index;
+} __attribute__((packed));
+
+struct virtio_msg {
+	#define VIRTIO_MSG_TYPE_REQUEST		(0 << 0)
+	#define VIRTIO_MSG_TYPE_RESPONSE	(1 << 0)
+	#define VIRTIO_MSG_TYPE_TRANSPORT	(0 << 1)
+	#define VIRTIO_MSG_TYPE_BUS		(1 << 1)
+	__u8 type;
+
+	__u8 msg_id;
+	__le16 dev_id;
+	__le16 msg_size;
+	__u8 payload[];
+} __attribute__((packed));
+
+static inline void *virtio_msg_payload(struct virtio_msg *vmsg)
+{
+	return &vmsg->payload;
+}
+
+/* Virtio message bus definitions */
+
+/* Message types */
+#define VIRTIO_MSG_BUS_GET_DEVICES	0x02
+#define VIRTIO_MSG_BUS_PING		0x03
+#define VIRTIO_MSG_BUS_EVENT_DEVICE	0x40
+
+struct bus_get_devices {
+	__le16 offset;
+	__le16 num;
+} __attribute__((packed));
+
+struct bus_get_devices_resp {
+	__le16 offset;
+	__le16 num;
+	__le16 next_offset;
+	__u8 devices[];
+} __attribute__((packed));
+
+struct bus_event_device {
+	__le16 dev_num;
+	#define VIRTIO_MSG_BUS_EVENT_DEV_STATE_READY	0x1
+	#define VIRTIO_MSG_BUS_EVENT_DEV_STATE_REMOVED	0x2
+	__le16 dev_state;
+} __attribute__((packed));
+
+struct bus_ping {
+	__le32 data;
+} __attribute__((packed));
+
+struct bus_ping_resp {
+	__le32 data;
+} __attribute__((packed));
+
+#endif /* _LINUX_VIRTIO_MSG_H */
-- 
2.31.1.272.g89b43f80a514

