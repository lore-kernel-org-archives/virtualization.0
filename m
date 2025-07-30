Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087629344F
	for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867823; cv=none; b=oMZhFMphp92INZGm8rW0H9W6reMkiwMw3e4IX44Idq/HFPcaeWTxLxRQOt81nFulM0tnepEJte8VTKQuthX0uFRvP+wi7KX2azmT0xp15cL61W6ypWsnekzVgRHTNoHakWKMfF84IiZufNQNjTlUUphc6rreIh3s/Z4fDKXqi54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867823; c=relaxed/simple;
	bh=kh8oZZLxtpKtHprLa+VlRCslzZw9tpPZ2cm6feCEKvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qicQTerJ0cuhFtHJsAspp3T7kCVYSAugx4radVmIbFd1c8I5NKJrRQpFLikOUnIB5ce8NTY1YHkl5zl8EjuBiih0t3oXFgMQ0tYRP/QM637sr4ZP07hK15NIFO3fJ9i8yGgK3rTSCVQlLpZLl29SpkBbyuuC2Ge2eQBmpB1c6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BM7O7/C3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BM7O7/C3"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso5415799a91.1
        for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 02:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753867820; x=1754472620; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDdIW5aB1KFsKcGqeqlSYjq6LlhWq0LdQwZTMGlp6LY=;
        b=BM7O7/C3qewwxaTjSbgt1uUxZP6bTVNDL7q2Cd6/t548YtfMXHPtUe6UHGOTvn9/jp
         9STXjas16JBWCmNGVxTicyr/n8BS7WwOtcMo4InGPrAI55c8k1ou32+ORtvuWDgXTizm
         aqTNzOhcGIHujILB3sAhETgReHk/ElbSDcmpWxSH5T3AO4OERUy42V3bWpBux24ujGk1
         8eH6DJpEAoEY4x3gd7ZMoPNkDyUTL+iSVUdDr0nr3hBQbb36IY102xYdzGz34u3dKaLm
         c5zy06zfc/H28nJxtrUi3WklgyECYyoWtqAVpbmHXUJjCVFZK2r6yamjztkdB5UQoxI6
         0cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867820; x=1754472620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDdIW5aB1KFsKcGqeqlSYjq6LlhWq0LdQwZTMGlp6LY=;
        b=eECsqTFr4J6wSsmGuRC861asluKEkphsuFr6JtkxwV1SVPtMO74ztMd9gI31dtypHI
         iLRgtG8lgawbjg7NezVljZuySW7OQafWKRWCn582PhMLX/4ehWifllPKxi664QBAFmbT
         G19Cz170u1GoOKxkFO0c++f6mLS/2B2/5m0SWHQg+eUurCzfxvRLsByhhpbZxlxFPI4Y
         1RZA9/DufWtmqQ3RdP75wya3PM0nhpEn88xRh60nG0ld1uHrV4LAliJUqdSoSDCZpif+
         R6fs6vAZgui8BgvBZuVmEGlZZRxzJRhRYKh5mV7F70cG3ZFw/Siw/qtnevSEMq03Of0O
         55rg==
X-Forwarded-Encrypted: i=1; AJvYcCXsCP8OZLcihwd3cUY3DDBDepc3f6QixocBwa02uluLN/Cs7ZT4PbQ8RzfvPFw2NXU7i5vuEWb+mD03GfExoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwKr7IkPofDzPKLNUqi8+S6f0M728F6HvR0uk9jm+JY07WWa/V
	Cv1RYzafbUzRyOT9aIMsn6qk96OyLVlPjXDwuMR5dIzOoV5ifdDrqAuZxogjy83iCI4x0C7715Y
	+qhd9
X-Gm-Gg: ASbGncvcx9aKwy6W1vRmf11TDQQjj/mAuoEm1VKulBtYyhE2pUpZQDKb7xBfayw22k/
	Jns2GFtaZDZlxGmak0uRtjPTBvVhP4BMyEA21P3ZD2LVmWFr77KKVljdDCqKoSo99TPdxzmSjpF
	ECN550K6S/VR7Qvj+OS+Hn+JzJ9z6crV+p+sLzwYXsl8SncrR6LYzPsbWJE7sBe3oDb5UxWJ7ND
	i1Xyjy1ocZHgIfomQFYaU9rf6Z+w34v0JZ5AmN1lznoUCVw35UKlB+Urt9aHD9mA37Iimls5Oye
	MaJ96+SNQBv3ICIG3gE37wziWwFssyelwf5+FHQgLGvNLrIu28Awcs/Z9VRCeXgKfUYeCZ5/VoH
	9zFvG8VvE23uSL7L9rdLP1q0=
X-Google-Smtp-Source: AGHT+IFQ0s2+2/egoEkMdJ3Tv9LHI5rzvo7KvcNNz9TKi4S2Jyq1GVoMeyJ7IOza8UhnllAqhv/heQ==
X-Received: by 2002:a17:90b:4b83:b0:31c:3872:9411 with SMTP id 98e67ed59e1d1-31f5de63c28mr4175721a91.33.1753867819846;
        Wed, 30 Jul 2025 02:30:19 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0b4b9sm1481141a91.27.2025.07.30.02.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:30:19 -0700 (PDT)
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
Subject: [RFC PATCH  5/6] virtio-msg: Add support for FF-A (Firmware Framework for Arm) bus
Date: Wed, 30 Jul 2025 14:59:34 +0530
Message-Id: <c3b5352befaac3bdeb0c169bdb76b7ae2453361e.1753865268.git.viresh.kumar@linaro.org>
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

Introduce a virtio-msg bus implementation based on the Arm FF-A
(Firmware Framework for Arm) communication interface.

This bus enables virtio-msg transport over secure channels typically
used between the normal world OS and a secure OS or hypervisor. It
leverages the standardized FF-A interface to exchange messages with a
remote backend service.

The implementation integrates with the core virtio-msg transport and
uses FF-A service calls to transmit and receive messages.

Optionally, this bus supports attaching a reserved-memory region to
constrain DMA-coherent and streaming DMA allocations to a well-defined
contiguous area. This memory can be pre-mapped on the remote side,
reducing runtime overhead and preventing accidental sharing of unrelated
pages due to page-granularity mapping.

To enable reserved memory, the following device tree node should be
defined (the node must be named "vmsgffa"):

  reserved-memory {
    #address-cells = <2>;
    #size-cells   = <2>;
    ranges;

    vmsgffa@100000000 {
      compatible = "restricted-dma-pool";
      reg = <0x00000001 0x00000000  0x0 0x00400000>; /* 4 MiB */
    };
  };

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/virtio/Kconfig              |  12 +-
 drivers/virtio/Makefile             |   1 +
 drivers/virtio/virtio_msg_ffa.c     | 505 ++++++++++++++++++++++++++++
 include/uapi/linux/virtio_msg_ffa.h |  94 ++++++
 4 files changed, 611 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_msg_ffa.c
 create mode 100644 include/uapi/linux/virtio_msg_ffa.h

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index a86025c9e008..683152477e3f 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -176,7 +176,8 @@ config VIRTIO_MSG
 	select VIRTIO
 	help
 	  This enables support for Virtio message transport. This option is
-	  selected by any driver which implements the virtio message bus.
+	  selected by any driver which implements the virtio message bus, such
+	  as VIRTIO_MSG_FFA.
 
 config VIRTIO_MSG_USER
 	tristate "Userspace interface for virtio message transport"
@@ -186,6 +187,15 @@ config VIRTIO_MSG_USER
 	  can be used to read / write messages over virtio-msg transport from
 	  userspace.
 
+config VIRTIO_MSG_FFA
+	tristate "FF-A bus driver for virtio message transport"
+	depends on ARM_FFA_TRANSPORT
+	select VIRTIO_MSG
+	help
+	 This implements a Virtio message bus based on ARM FF-A protocol.
+
+	 If unsure, say N.
+
 config VIRTIO_DMA_SHARED_BUFFER
 	tristate
 	depends on DMA_SHARED_BUFFER
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 5b664c5f5f25..96ec0a9c4a7a 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
 virtio_msg_transport-y := virtio_msg.o
 virtio_msg_transport-$(CONFIG_VIRTIO_MSG_USER) += virtio_msg_user.o
 obj-$(CONFIG_VIRTIO_MSG) += virtio_msg_transport.o
+obj-$(CONFIG_VIRTIO_MSG_FFA) += virtio_msg_ffa.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
 virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
 virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
diff --git a/drivers/virtio/virtio_msg_ffa.c b/drivers/virtio/virtio_msg_ffa.c
new file mode 100644
index 000000000000..e7f2cbcd238b
--- /dev/null
+++ b/drivers/virtio/virtio_msg_ffa.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * FF-A bus implementation for Virtio message transport.
+ *
+ * Copyright (C) 2025 Google LLC and Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This implements the FF-A (Arm Firmware Framework) bus for Virtio msg
+ * transport.
+ */
+
+#define pr_fmt(fmt) "virtio-msg-ffa: " fmt
+
+#include <linux/arm_ffa.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/virtio.h>
+#include <uapi/linux/virtio_msg_ffa.h>
+
+#include "virtio_msg_internal.h"
+
+struct virtio_msg_indirect_data {
+	struct completion completion;
+	struct virtio_msg *response;
+};
+
+struct virtio_msg_device_data {
+	struct virtio_msg_device vmdev;
+	struct virtio_msg_indirect_data idata;
+};
+
+/* Represents FF-A corresponding to a partition */
+struct virtio_msg_ffa_device {
+	struct ffa_device *ffa_dev;
+	struct reserved_mem *rmem;
+	struct virtio_msg_indirect_data idata;
+	struct virtio_msg_device_data *vmdevs;
+	int (*send)(struct virtio_msg_ffa_device *vmfdev,
+		    struct virtio_msg *request,
+		    struct virtio_msg *response,
+		    struct virtio_msg_indirect_data *idata);
+	int vmdev_count;
+	u16 msg_size;
+};
+
+#define to_vmdevdata(_vmdev) \
+	container_of(_vmdev, struct virtio_msg_device_data, vmdev)
+#define to_vmfdev(_vmdev) ((struct virtio_msg_ffa_device *)(_vmdev)->bus_data)
+
+static int vmsg_ffa_send_direct(struct virtio_msg_ffa_device *vmfdev,
+				struct virtio_msg *request,
+				struct virtio_msg *response,
+				struct virtio_msg_indirect_data *idata_unused)
+{
+	struct ffa_device *ffa_dev = vmfdev->ffa_dev;
+	struct ffa_send_direct_data2 ffa_data;
+	int ret;
+
+	memcpy(&ffa_data, request, request->msg_size);
+
+	ret = ffa_dev->ops->msg_ops->sync_send_receive2(ffa_dev, &ffa_data);
+	if (ret) {
+		dev_dbg(&ffa_dev->dev,
+			"Unable to send direct FF-A message: %d\n", ret);
+		return ret;
+	}
+
+	if (response)
+		memcpy(response, &ffa_data, vmfdev->msg_size);
+
+	return 0;
+}
+
+static int vmsg_ffa_send_indirect(struct virtio_msg_ffa_device *vmfdev,
+				  struct virtio_msg *request,
+				  struct virtio_msg *response,
+				  struct virtio_msg_indirect_data *idata)
+{
+	struct ffa_device *ffa_dev = vmfdev->ffa_dev;
+	struct device *dev = &ffa_dev->dev;
+	int ret, count = 10;
+
+	/*
+	 * Store the response pointer in idata structure. This will be updated
+	 * by vmsg_ffa_notifier_cb() later.
+	 */
+	idata->response = response;
+
+try_again:
+	ret = ffa_dev->ops->msg_ops->indirect_send(ffa_dev, request,
+						   request->msg_size);
+	if (ret == -EBUSY && --count) {
+		cpu_relax();
+		goto try_again;
+	}
+
+	if (ret) {
+		dev_err(dev, "Failed sending indirect FF-A message: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Always wait for the operation to finish, otherwise we may start
+	 * another operation while the previous one is still ongoing.
+	 */
+	ret = wait_for_completion_interruptible_timeout(&idata->completion, 1000);
+	if (ret < 0) {
+		dev_err(dev, "Interrupted - waiting for a response: %d\n", ret);
+	} else if (!ret) {
+		dev_err(dev, "Timed out waiting for a response\n");
+		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static struct virtio_msg_device *
+find_vmdev(struct virtio_msg_ffa_device *vmfdev, u16 dev_id)
+{
+	int i;
+
+	/* Find the device corresponding to a dev_id */
+	for (i = 0; i < vmfdev->vmdev_count; i++) {
+		if (vmfdev->vmdevs[i].vmdev.dev_id == dev_id)
+			return &vmfdev->vmdevs[i].vmdev;
+	}
+
+	dev_err(&vmfdev->ffa_dev->dev, "Couldn't find matching vmdev: %d\n",
+		dev_id);
+	return NULL;
+}
+
+static void vmsg_ffa_notifier_cb(int notify_id, void *cb_data, void *buf)
+{
+	struct virtio_msg_ffa_device *vmfdev = cb_data;
+	struct ffa_device *ffa_dev = vmfdev->ffa_dev;
+	struct virtio_msg_indirect_data *idata;
+	struct virtio_msg_device *vmdev;
+	struct virtio_msg *vmsg = buf;
+
+	/*
+	 * We can either receive a response message (to a previously sent
+	 * request), or an EVENT_USED request message.
+	 */
+	if (vmsg->type & VIRTIO_MSG_TYPE_RESPONSE) {
+		if (vmsg->type & VIRTIO_MSG_TYPE_BUS) {
+			idata = &vmfdev->idata;
+		} else {
+			vmdev = find_vmdev(vmfdev, le16_to_cpu(vmsg->dev_id));
+			if (!vmdev)
+				return;
+
+			idata = &to_vmdevdata(vmdev)->idata;
+		}
+
+		if (idata->response)
+			memcpy(idata->response, vmsg, vmsg->msg_size);
+
+		complete(&idata->completion);
+
+		return;
+	}
+
+	/* Only support EVENT_USED virtio request messages */
+	if (vmsg->type & VIRTIO_MSG_TYPE_BUS ||
+	    vmsg->msg_id != VIRTIO_MSG_EVENT_USED) {
+		dev_err(&ffa_dev->dev, "Unsupported message received\n");
+		return;
+	}
+
+	vmdev = find_vmdev(vmfdev, le16_to_cpu(vmsg->dev_id));
+	if (!vmdev)
+		return;
+
+	virtio_msg_event(vmdev, vmsg);
+}
+
+static int vmsg_ffa_notify_setup(struct virtio_msg_ffa_device *vmfdev)
+{
+	struct ffa_device *ffa_dev = vmfdev->ffa_dev;
+	int ret;
+
+	ret = ffa_dev->ops->notifier_ops->fwk_notify_request(ffa_dev,
+			&vmsg_ffa_notifier_cb, vmfdev, 0);
+	if (ret)
+		dev_err(&ffa_dev->dev, "Unable to request notifier: %d\n", ret);
+
+	return ret;
+}
+
+static void vmsg_ffa_notify_cleanup(struct virtio_msg_ffa_device *vmfdev)
+{
+	struct ffa_device *ffa_dev = vmfdev->ffa_dev;
+	int ret;
+
+	ret = ffa_dev->ops->notifier_ops->fwk_notify_relinquish(ffa_dev, 0);
+	if (ret)
+		dev_err(&ffa_dev->dev, "Unable to relinquish notifier: %d\n", ret);
+}
+
+static int vmsg_ffa_bus_get_devices(struct virtio_msg_ffa_device *vmfdev,
+				    u16 *map, u16 *count)
+{
+	u8 req_buf[VIRTIO_MSG_FFA_BUS_MSG_SIZE];
+	u8 res_buf[VIRTIO_MSG_FFA_BUS_MSG_SIZE];
+	struct virtio_msg *request = (struct virtio_msg *)&req_buf;
+	struct virtio_msg *response = (struct virtio_msg *)&res_buf;
+	struct bus_get_devices *req_payload = virtio_msg_payload(request);
+	struct bus_get_devices_resp *res_payload = virtio_msg_payload(response);
+	int ret;
+
+	static_assert(sizeof(*request) + sizeof(*req_payload) <
+		      VIRTIO_MSG_FFA_BUS_MSG_SIZE);
+	static_assert(sizeof(*response) + sizeof(*res_payload) <
+		      VIRTIO_MSG_FFA_BUS_MSG_SIZE);
+
+	virtio_msg_prepare(request, VIRTIO_MSG_BUS_GET_DEVICES,
+			   sizeof(*req_payload));
+	req_payload->offset = 0;
+	req_payload->num = cpu_to_le16(0xFF);
+
+	ret = vmfdev->send(vmfdev, request, response, &vmfdev->idata);
+	if (ret < 0)
+		return ret;
+
+	*count = le16_to_cpu(res_payload->num);
+	if (!*count)
+		return -ENODEV;
+
+	if (res_payload->offset != req_payload->offset)
+		return -EINVAL;
+
+	/* Support up to 16 devices for now */
+	if (res_payload->next_offset)
+		return -EINVAL;
+
+	map[0] = res_payload->devices[0];
+	map[1] = res_payload->devices[1];
+
+	return 0;
+}
+
+static int vmsg_ffa_bus_version(struct virtio_msg_ffa_device *vmfdev)
+{
+	u8 req_buf[VIRTIO_MSG_FFA_BUS_MSG_SIZE];
+	u8 res_buf[VIRTIO_MSG_FFA_BUS_MSG_SIZE];
+	struct virtio_msg *request = (struct virtio_msg *)&req_buf;
+	struct virtio_msg *response = (struct virtio_msg *)&res_buf;
+	struct bus_ffa_version *req_payload = virtio_msg_payload(request);
+	struct bus_ffa_version_resp *res_payload = virtio_msg_payload(response);
+	u32 features;
+	int ret;
+
+	static_assert(sizeof(*request) + sizeof(*req_payload) <
+		      VIRTIO_MSG_FFA_BUS_MSG_SIZE);
+	static_assert(sizeof(*response) + sizeof(*res_payload) <
+		      VIRTIO_MSG_FFA_BUS_MSG_SIZE);
+
+	virtio_msg_prepare(request, VIRTIO_MSG_FFA_BUS_VERSION,
+			   sizeof(*req_payload));
+	req_payload->driver_version = cpu_to_le32(VIRTIO_MSG_FFA_BUS_VERSION_1_0);
+	req_payload->vmsg_revision = cpu_to_le32(VIRTIO_MSG_REVISION_1);
+	req_payload->vmsg_features = cpu_to_le32(VIRTIO_MSG_FEATURES);
+	req_payload->features = cpu_to_le32(VIRTIO_MSG_FFA_FEATURE_BOTH_SUPP);
+	req_payload->area_num = cpu_to_le16(VIRTIO_MSG_FFA_AREA_ID_MAX);
+
+	ret = vmfdev->send(vmfdev, request, response, &vmfdev->idata);
+	if (ret < 0)
+		return ret;
+
+	if (le32_to_cpu(res_payload->device_version) != VIRTIO_MSG_FFA_BUS_VERSION_1_0)
+		return -EINVAL;
+
+	if (le32_to_cpu(res_payload->vmsg_revision) != VIRTIO_MSG_REVISION_1)
+		return -EINVAL;
+
+	if (le32_to_cpu(res_payload->vmsg_features) != VIRTIO_MSG_FEATURES)
+		return -EINVAL;
+
+	features = le32_to_cpu(res_payload->features);
+
+	/*
+	 * - Direct message must be supported if it already worked.
+	 * - Indirect message must be supported if it already worked
+	 * - And direct message must not be supported since it didn't work.
+	 */
+	if ((ffa_partition_supports_direct_recv(vmfdev->ffa_dev) &&
+	     !(features & VIRTIO_MSG_FFA_FEATURE_DIRECT_MSG_RX_SUPP)) ||
+	    (ffa_partition_supports_indirect_msg(vmfdev->ffa_dev) &&
+	     !(features & VIRTIO_MSG_FFA_FEATURE_INDIRECT_MSG_SUPP))) {
+		dev_err(&vmfdev->ffa_dev->dev, "Invalid features\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int virtio_msg_ffa_transfer(struct virtio_msg_device *vmdev,
+				   struct virtio_msg *request,
+				   struct virtio_msg *response)
+{
+	struct virtio_msg_indirect_data *idata = &to_vmdevdata(vmdev)->idata;
+	struct virtio_msg_ffa_device *vmfdev = to_vmfdev(vmdev);
+
+	return vmfdev->send(vmfdev, request, response, idata);
+}
+
+static const char *virtio_msg_ffa_bus_info(struct virtio_msg_device *vmdev,
+					   u16 *msg_size, u32 *rev)
+{
+	struct virtio_msg_ffa_device *vmfdev = to_vmfdev(vmdev);
+
+	*msg_size = vmfdev->msg_size;
+	*rev = VIRTIO_MSG_REVISION_1;
+
+	return dev_name(&vmfdev->ffa_dev->dev);
+}
+
+static struct virtio_msg_ops vmf_ops = {
+	.transfer = virtio_msg_ffa_transfer,
+	.bus_info = virtio_msg_ffa_bus_info,
+};
+
+static void remove_vmdevs(struct virtio_msg_ffa_device *vmfdev, int count)
+{
+	while (count--)
+		virtio_msg_unregister(&vmfdev->vmdevs[count].vmdev);
+}
+
+static int virtio_msg_ffa_probe(struct ffa_device *ffa_dev)
+{
+	struct virtio_msg_ffa_device *vmfdev;
+	struct device *dev = &ffa_dev->dev;
+	struct virtio_msg_device *vmdev;
+	unsigned long devices = 0;
+	int ret, i = 0, bit;
+	u16 count;
+
+	vmfdev = devm_kzalloc(dev, sizeof(*vmfdev), GFP_KERNEL);
+	if (!vmfdev)
+		return -ENOMEM;
+
+	if (ffa_partition_supports_direct_recv(ffa_dev)) {
+		vmfdev->send = vmsg_ffa_send_direct;
+	} else if (ffa_partition_supports_indirect_msg(ffa_dev)) {
+		vmfdev->send = vmsg_ffa_send_indirect;
+	} else {
+		dev_err(dev, "Direct or Indirect messages not supported\n");
+		return -EINVAL;
+	}
+
+	vmfdev->ffa_dev = ffa_dev;
+	vmfdev->msg_size = VIRTIO_MSG_FFA_BUS_MSG_SIZE;
+	ffa_dev_set_drvdata(ffa_dev, vmfdev);
+	init_completion(&vmfdev->idata.completion);
+
+	ret = vmsg_ffa_notify_setup(vmfdev);
+	if (ret)
+		return ret;
+
+	ret = vmsg_ffa_bus_version(vmfdev);
+	if (ret)
+		goto notify_cleanup;
+
+	ret = vmsg_ffa_bus_get_devices(vmfdev, (u16 *)&devices, &count);
+	if (ret)
+		goto notify_cleanup;
+
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		dev_warn(dev, "Failed to enable 64-bit or 32-bit DMA\n");
+
+	vmfdev->rmem = of_reserved_mem_lookup_by_name("vmsgffa");
+	if (!IS_ERR(vmfdev->rmem)) {
+		ret = reserved_mem_device_init(dev, vmfdev->rmem);
+		if (ret)
+			goto rmem_free;
+	} else {
+		dev_info(dev, "Continuing without reserved-memory block\n");
+	}
+
+	vmfdev->vmdevs = devm_kcalloc(dev, count, sizeof(*vmfdev->vmdevs),
+				      GFP_KERNEL);
+	if (!vmfdev->vmdevs) {
+		ret = -ENOMEM;
+		goto rmem_free;
+	}
+	vmfdev->vmdev_count = count;
+
+	for_each_set_bit(bit, &devices, sizeof(devices)) {
+		init_completion(&vmfdev->vmdevs[i].idata.completion);
+		vmdev = &vmfdev->vmdevs[i].vmdev;
+		vmdev->dev_id = bit;
+		vmdev->ops = &vmf_ops;
+		vmdev->vdev.dev.parent = dev;
+		vmdev->bus_data = vmfdev;
+
+		ret = virtio_msg_register(vmdev);
+		if (ret) {
+			dev_err(dev, "Failed to register virtio-msg device (%d)\n", ret);
+			goto unregister;
+		}
+
+		i++;
+	}
+
+	return 0;
+
+unregister:
+	remove_vmdevs(vmfdev, i);
+rmem_free:
+	if (!IS_ERR(vmfdev->rmem))
+		of_reserved_mem_device_release(dev);
+notify_cleanup:
+	vmsg_ffa_notify_cleanup(vmfdev);
+	return ret;
+}
+
+static void virtio_msg_ffa_remove(struct ffa_device *ffa_dev)
+{
+	struct virtio_msg_ffa_device *vmfdev = ffa_dev->dev.driver_data;
+
+	remove_vmdevs(vmfdev, vmfdev->vmdev_count);
+
+	if (!IS_ERR(vmfdev->rmem))
+		of_reserved_mem_device_release(&ffa_dev->dev);
+
+	vmsg_ffa_notify_cleanup(vmfdev);
+}
+
+static const struct ffa_device_id virtio_msg_ffa_device_ids[] = {
+	/* c66028b5-2498-4aa1-9de7-77da6122abf0 */
+	{ UUID_INIT(0xc66028b5, 0x2498, 0x4aa1,
+		    0x9d, 0xe7, 0x77, 0xda, 0x61, 0x22, 0xab, 0xf0) },
+	{}
+};
+
+static int __maybe_unused virtio_msg_ffa_suspend(struct device *dev)
+{
+	struct virtio_msg_ffa_device *vmfdev = dev_get_drvdata(dev);
+	int ret, i, index;
+
+	for (i = 0; i < vmfdev->vmdev_count; i++) {
+		index = vmfdev->vmdev_count - i - 1;
+		ret = virtio_device_freeze(&vmfdev->vmdevs[index].vmdev.vdev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused virtio_msg_ffa_resume(struct device *dev)
+{
+	struct virtio_msg_ffa_device *vmfdev = dev_get_drvdata(dev);
+	int ret, i;
+
+	for (i = 0; i < vmfdev->vmdev_count; i++) {
+		ret = virtio_device_restore(&vmfdev->vmdevs[i].vmdev.vdev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops virtio_msg_ffa_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(virtio_msg_ffa_suspend, virtio_msg_ffa_resume)
+};
+
+static struct ffa_driver virtio_msg_ffa_driver = {
+	.name = "virtio-msg-ffa",
+	.probe = virtio_msg_ffa_probe,
+	.remove = virtio_msg_ffa_remove,
+	.id_table = virtio_msg_ffa_device_ids,
+	.driver = {
+		.pm = &virtio_msg_ffa_pm_ops,
+	},
+};
+
+static int virtio_msg_ffa_init(void)
+{
+	if (IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
+		return ffa_register(&virtio_msg_ffa_driver);
+	else
+		return -EOPNOTSUPP;
+}
+module_init(virtio_msg_ffa_init);
+
+static void virtio_msg_ffa_exit(void)
+{
+	if (IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
+		ffa_unregister(&virtio_msg_ffa_driver);
+}
+module_exit(virtio_msg_ffa_exit);
+
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
+MODULE_DESCRIPTION("Virtio message FF-A bus driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/virtio_msg_ffa.h b/include/uapi/linux/virtio_msg_ffa.h
new file mode 100644
index 000000000000..adcc081b483a
--- /dev/null
+++ b/include/uapi/linux/virtio_msg_ffa.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Virtio message FF-A (Arm Firmware Framework) bus header.
+ *
+ * Copyright (C) 2025 Google LLC and Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef _LINUX_VIRTIO_MSG_FFA_H
+#define _LINUX_VIRTIO_MSG_FFA_H
+
+#include <linux/types.h>
+
+/* Message types */
+#define VIRTIO_MSG_FFA_BUS_VERSION			0x80
+#define VIRTIO_MSG_FFA_BUS_AREA_SHARE			0x81
+#define VIRTIO_MSG_FFA_BUS_AREA_UNSHARE			0x82
+#define VIRTIO_MSG_FFA_BUS_RESET			0x83
+#define VIRTIO_MSG_FFA_BUS_EVENT_POLL			0x84
+#define VIRTIO_MSG_FFA_BUS_AREA_RELEASE			0xC0
+
+#define VIRTIO_MSG_FEATURES				0
+#define VIRTIO_MSG_FFA_BUS_VERSION_1_0			0x1
+#define VIRTIO_MSG_FFA_BUS_MSG_SIZE			VIRTIO_MSG_MIN_SIZE
+
+#define VIRTIO_MSG_FFA_FEATURE_DIRECT_MSG_RX_SUPP	(1 << 0)
+#define VIRTIO_MSG_FFA_FEATURE_DIRECT_MSG_TX_SUPP	(1 << 1)
+#define VIRTIO_MSG_FFA_FEATURE_DIRECT_MSG_SUPP		\
+	(VIRTIO_MSG_FFA_FEATURE_DIRECT_MSG_RX_SUPP |	\
+	 VIRTIO_MSG_FFA_FEATURE_DIRECT_MSG_TX_SUPP)
+
+#define VIRTIO_MSG_FFA_FEATURE_INDIRECT_MSG_RX_SUPP	(1 << 2)
+#define VIRTIO_MSG_FFA_FEATURE_INDIRECT_MSG_TX_SUPP	(1 << 3)
+#define VIRTIO_MSG_FFA_FEATURE_INDIRECT_MSG_SUPP	\
+	(VIRTIO_MSG_FFA_FEATURE_INDIRECT_MSG_RX_SUPP |	\
+	 VIRTIO_MSG_FFA_FEATURE_INDIRECT_MSG_TX_SUPP)
+
+#define VIRTIO_MSG_FFA_FEATURE_BOTH_SUPP		\
+	(VIRTIO_MSG_FFA_FEATURE_DIRECT_MSG_SUPP |	\
+	 VIRTIO_MSG_FFA_FEATURE_INDIRECT_MSG_SUPP)
+
+#define VIRTIO_MSG_FFA_AREA_ID_MAX			0xFF
+#define VIRTIO_MSG_FFA_AREA_ID_OFFSET			56
+#define VIRTIO_MSG_FFA_OFFSET_MASK			\
+	((ULL(1) << VIRTIO_MSG_FFA_AREA_ID_OFFSET) - 1)
+
+#define VIRTIO_MSG_FFA_RESULT_ERROR			(1 << 0)
+#define VIRTIO_MSG_FFA_RESULT_BUSY			(1 << 1)
+
+/* Message payload format */
+
+struct bus_ffa_version {
+	__le32 driver_version;
+	__le32 vmsg_revision;
+	__le32 vmsg_features;
+	__le32 features;
+	__le16 area_num;
+} __attribute__((packed));
+
+struct bus_ffa_version_resp {
+	__le32 device_version;
+	__le32 vmsg_revision;
+	__le32 vmsg_features;
+	__le32 features;
+	__le16 area_num;
+} __attribute__((packed));
+
+struct bus_area_share {
+	__le16 area_id;
+	__le64 mem_handle;
+	__le64 tag;
+	__le32 count;
+	__le32 attr;
+} __attribute__((packed));
+
+struct bus_area_share_resp {
+	__le16 area_id;
+	__le16 result;
+} __attribute__((packed));
+
+struct bus_area_unshare {
+	__le16 area_id;
+} __attribute__((packed));
+
+struct bus_area_unshare_resp {
+	__le16 area_id;
+	__le16 result;
+} __attribute__((packed));
+
+struct bus_area_release {
+	__le16 area_id;
+} __attribute__((packed));
+
+#endif /* _LINUX_VIRTIO_MSG_FFA_H */
-- 
2.31.1.272.g89b43f80a514

