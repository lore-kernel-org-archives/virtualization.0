Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF674293B46
	for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867817; cv=none; b=t/IBc9GMJm8FeRGbz0y5xTgVWjZfnr+xp9UAKcWV3ZWFK/bxMHrnNxc4ZvvFND9PYVZ0dLlCOjVtTU2ExH4306DdBu7jzy7LW5PCD49E7wgfFcS6GXHZT5XAjTWcM4Hp1vblvHa8Hz6n/lzVOYQ0AwQCFQb9wiJRfzmcxqPjM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867817; c=relaxed/simple;
	bh=6f8fR5oGU3uBFsY6EzBrs3St+X+QZ3T82ZZgrxz65Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rN84NcYRcnhY81NYBMgcnqiOEdXJ4pDuG25cKJj6xUrkQpMOU2rrtGIKhP/XKxMBYQsUllob0WLs2nvc3isPl2x8K87maO0kS7wVH41haH4yQPcJ6GY/Oavh+QzH1L9nhewM+6RjZdt8lwPIukHXyFBCaSz90sZt/nV9tNbThHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BzXyhUxD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BzXyhUxD"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso6235023b3a.0
        for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 02:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753867815; x=1754472615; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEy7nkqd60biSBMPI8mV+T/3vRYKIkBFSmMXiXvTu5Q=;
        b=BzXyhUxDpr+L9tkrapnZhFecmPpx2A+yJfEfAbpGMIisTE2ORNblMmIKjoXNPfn0ve
         YxsZUUuHvTqbk6FJ0JskNMwM/iGxCqmpaVbQtzNyhKcp2B9hmoos3Iya76Px1WgDrw9E
         kyYMGv1jtrtYqYS/PpNKqQVDIcjsLzLVF8UcLm2raJin0YJRB16e3NNjbr3kMTAUWmVA
         jl86S29uwZS2KkuPKnvG8EqobXiOP4sboZf7Fz/RT7wdZ1We+B3te0Jteka0KYxwSXui
         r95n8jdVGGt+4d+iTxnaaG/HmhfKAs3POUEk4wgdEk4TqAZBf74CCuc9CbIjp99CRd8M
         q0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867815; x=1754472615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEy7nkqd60biSBMPI8mV+T/3vRYKIkBFSmMXiXvTu5Q=;
        b=AWE5SdyvmMEDR3ZoK89sRC9OuWvg7w33+AbHgz3XyUR63OqfcTw0GRLXkwQuhmXyul
         zNckO+gYav+lsQ+aYGuC2fQY84Ewi2QOjcacSBTltU8vLGqnqA0J/9mOec2Y7i5jz7cZ
         d+yT4AisoxMg8THSwjxBPK6thNB3iJGv+X9XNt3fav7SFsIwUb71GptXYHvgN+dMmVG2
         IHup41Yc5vJF2TvEE26DbI/H5ciie+HfiBTBDhrab6f+/Ihjkx5ZdHYA2cUpWeA8T7iC
         I71pW7or+oLQjs8I3zDhS3k7ypJ3AdanzTmP+rm6k1irIU9+Wn6DAaijW+sOK42tUFGw
         xIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU96ItZ/gXljR/e5SkkFiwe0wNLr8uZCj+Hpi2UVNvXp5b+pdSU/IupPezkhhTFcxXYmtn30fmbQhyHUkKhng==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYA+8RLi7h1t0B/+OsHxs1vCp47ItiHL+v758weqM3ZpqLd6r6
	uOIDf30D+fhTHLsowY2vFSwhopdcj/M4UDCePaBSkEepcI+D1thtAMNrCmIowiS5Ml0=
X-Gm-Gg: ASbGnctZL/uuTemGdqdySdRxOtmMsPj+p8JcNVtG90FgUozCEyW+zeyYVvXaSs7ATxH
	2+euOkdBnrUcMNO1o8Ucxj6aOuEi04Rlw3UvKT1JAsS9LOefqWnqkpkUKdrLZVxzejbbrxnCxCi
	nLVvMI0hGOR3Btr/7vtzjqKTOZ90iaJIXGiJZBGhkLgoJlJgdtDVhO3m9cOs+DuFZbJNp3X3wIt
	ovecYv8j1Q4Hb5Lo75CmXaPwJJP0xYcaTdKEUSIpPUarceySNSJJ7fdFvjdnpalLyrg8fqDom41
	p32dR/ADPe3FkNZauihZ0IWaA+n+mrIoAzRfPDwJ7oTSflWrtAjPlnvvYFpPHUoEmu01gKxt9aN
	83GgX/cMUyRdOFHJJG8JyQNI=
X-Google-Smtp-Source: AGHT+IEBL0ir8PS5GKTv6LcN3fEFv6jphsgvwEpAmbEVl0EK6WXhOEQBi3VfOVeY0YtPPql5u2NErA==
X-Received: by 2002:a05:6a00:2347:b0:74e:a560:dd23 with SMTP id d2e1a72fcca58-76ab30c553dmr4723064b3a.21.1753867815053;
        Wed, 30 Jul 2025 02:30:15 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640872a209sm10182952b3a.4.2025.07.30.02.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:30:14 -0700 (PDT)
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
Subject: [RFC PATCH  4/6] virtio-msg: Add optional userspace interface for message I/O
Date: Wed, 30 Jul 2025 14:59:33 +0530
Message-Id: <97ae7b7bea8a22108aaebdfd9330de93ecc91333.1753865268.git.viresh.kumar@linaro.org>
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

Add support for an optional userspace interface to the virtio-msg
transport via a per-bus miscdevice. When enabled by a bus
implementation, this interface allows userspace to send and receive
virtio messages through a character device node.

A separate device node is created for each bus that registers for
userspace access, e.g., /dev/virtio-msg-N. This enables backend-side
components or test tools to interact with the transport layer directly
from userspace.

Bus implementations that do not require userspace interaction can omit
this interface entirely.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/virtio/Kconfig               |   8 ++
 drivers/virtio/Makefile              |   4 +-
 drivers/virtio/virtio_msg_internal.h |  32 ++++++
 drivers/virtio/virtio_msg_user.c     | 140 +++++++++++++++++++++++++++
 4 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_msg_user.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 690ac98850b6..a86025c9e008 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -178,6 +178,14 @@ config VIRTIO_MSG
 	  This enables support for Virtio message transport. This option is
 	  selected by any driver which implements the virtio message bus.
 
+config VIRTIO_MSG_USER
+	tristate "Userspace interface for virtio message transport"
+	depends on VIRTIO_MSG
+	help
+	  This enables userspace interface for Virtio message transport. This
+	  can be used to read / write messages over virtio-msg transport from
+	  userspace.
+
 config VIRTIO_DMA_SHARED_BUFFER
 	tristate
 	depends on DMA_SHARED_BUFFER
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 3eff8ca72446..5b664c5f5f25 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -4,7 +4,9 @@ obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
 obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
 obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
 obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
-obj-$(CONFIG_VIRTIO_MSG) += virtio_msg.o
+virtio_msg_transport-y := virtio_msg.o
+virtio_msg_transport-$(CONFIG_VIRTIO_MSG_USER) += virtio_msg_user.o
+obj-$(CONFIG_VIRTIO_MSG) += virtio_msg_transport.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
 virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
 virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
diff --git a/drivers/virtio/virtio_msg_internal.h b/drivers/virtio/virtio_msg_internal.h
index b7c2cb44b67b..0d13d73507eb 100644
--- a/drivers/virtio/virtio_msg_internal.h
+++ b/drivers/virtio/virtio_msg_internal.h
@@ -9,6 +9,8 @@
 #ifndef _DRIVERS_VIRTIO_MSG_INTERNAL_H
 #define _DRIVERS_VIRTIO_MSG_INTERNAL_H
 
+#include <linux/completion.h>
+#include <linux/miscdevice.h>
 #include <linux/virtio.h>
 #include <uapi/linux/virtio_msg.h>
 
@@ -53,4 +55,34 @@ void virtio_msg_unregister(struct virtio_msg_device *vmdev);
 void virtio_msg_prepare(struct virtio_msg *vmsg, u8 msg_id, u16 payload_size);
 int virtio_msg_event(struct virtio_msg_device *vmdev, struct virtio_msg *vmsg);
 
+/* Virtio msg userspace interface */
+struct virtio_msg_user_device;
+
+struct virtio_msg_user_ops {
+	int (*handle)(struct virtio_msg_user_device *vmudev, struct virtio_msg *vmsg);
+};
+
+/* Host side device using virtio message */
+struct virtio_msg_user_device {
+	struct virtio_msg_user_ops *ops;
+	struct miscdevice misc;
+	struct completion r_completion;
+	struct completion w_completion;
+	struct virtio_msg *vmsg;
+	struct device *parent;
+	char name[15];
+};
+
+#if IS_REACHABLE(CONFIG_VIRTIO_MSG_USER)
+int virtio_msg_user_register(struct virtio_msg_user_device *vmudev);
+void virtio_msg_user_unregister(struct virtio_msg_user_device *vmudev);
+#else
+static inline int virtio_msg_user_register(struct virtio_msg_user_device *vmudev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void virtio_msg_user_unregister(struct virtio_msg_user_device *vmudev) {}
+#endif /* CONFIG_VIRTIO_MSG_USER */
+
 #endif /* _DRIVERS_VIRTIO_MSG_INTERNAL_H */
diff --git a/drivers/virtio/virtio_msg_user.c b/drivers/virtio/virtio_msg_user.c
new file mode 100644
index 000000000000..cf7286b3a311
--- /dev/null
+++ b/drivers/virtio/virtio_msg_user.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Virtio message transport user API.
+ *
+ * Copyright (C) 2025 Google LLC and Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#define pr_fmt(fmt) "virtio-msg: " fmt
+
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include "virtio_msg_internal.h"
+
+#define to_virtio_msg_user_device(_misc) \
+	container_of(_misc, struct virtio_msg_user_device, misc)
+
+static ssize_t vmsg_miscdev_read(struct file *file, char __user *buf,
+				 size_t count, loff_t *pos)
+{
+	struct miscdevice *misc = file->private_data;
+	struct virtio_msg_user_device *vmudev = to_virtio_msg_user_device(misc);
+	struct device *dev = vmudev->parent;
+	int ret;
+
+	if (count < VIRTIO_MSG_MIN_SIZE) {
+		dev_err(dev, "Trying to read message of incorrect size: %zu\n",
+			count);
+		return 0;
+	}
+
+	/* Wait for the message */
+	ret = wait_for_completion_interruptible(&vmudev->r_completion);
+	if (ret < 0) {
+		dev_err(dev, "Interrupted while waiting for response: %d\n", ret);
+		return 0;
+	}
+
+	WARN_ON(!vmudev->vmsg);
+
+	/* The "vmsg" pointer is filled by the bus driver before waking up */
+	if (copy_to_user(buf, vmudev->vmsg, count) != 0)
+		return 0;
+
+	vmudev->vmsg = NULL;
+
+	return count;
+}
+
+static ssize_t vmsg_miscdev_write(struct file *file, const char __user *buf,
+				  size_t count, loff_t *pos)
+{
+	struct miscdevice *misc = file->private_data;
+	struct virtio_msg_user_device *vmudev = to_virtio_msg_user_device(misc);
+	struct virtio_msg *vmsg __free(kfree) = NULL;
+
+	if (count < VIRTIO_MSG_MIN_SIZE) {
+		dev_err(vmudev->parent, "Trying to write message of incorrect size: %zu\n",
+			count);
+		return 0;
+	}
+
+	vmsg = kzalloc(count, GFP_KERNEL);
+	if (!vmsg)
+		return 0;
+
+	if (copy_from_user(vmsg, buf, count) != 0)
+		return 0;
+
+	vmudev->ops->handle(vmudev, vmsg);
+
+	/* Wake up the handler only for responses */
+	if (vmsg->type & VIRTIO_MSG_TYPE_RESPONSE)
+		complete(&vmudev->w_completion);
+
+	return count;
+}
+
+static const struct file_operations vmsg_miscdev_fops = {
+	.owner = THIS_MODULE,
+	.read = vmsg_miscdev_read,
+	.write = vmsg_miscdev_write,
+};
+
+/**
+ * virtio_msg_user_register - Register a user-space accessible virtio message device
+ * @vmudev: Pointer to the virtio message user device
+ *
+ * Initializes and registers a user-accessible virtio message device as a `misc`
+ * character device. Upon successful registration, the device appears in
+ * userspace as `/dev/virtio-msg-N` where `N` is a unique identifier assigned at
+ * runtime.
+ *
+ * The resulting device node allows user-space interaction with the virtio
+ * message transport.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int virtio_msg_user_register(struct virtio_msg_user_device *vmudev)
+{
+	static u8 vmsg_user_device_count;
+	int ret;
+
+	if (!vmudev || !vmudev->ops)
+		return -EINVAL;
+
+	init_completion(&vmudev->r_completion);
+	init_completion(&vmudev->w_completion);
+
+	vmudev->misc.parent = vmudev->parent;
+	vmudev->misc.minor = MISC_DYNAMIC_MINOR;
+	vmudev->misc.fops = &vmsg_miscdev_fops;
+	vmudev->misc.name = vmudev->name;
+	sprintf(vmudev->name, "virtio-msg-%d", vmsg_user_device_count);
+
+	ret = misc_register(&vmudev->misc);
+	if (ret)
+		return ret;
+
+	vmsg_user_device_count++;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtio_msg_user_register);
+
+/**
+ * virtio_msg_user_unregister - Unregister a user-space virtio message device
+ * @vmudev: Pointer to the virtio message user device
+ *
+ * Unregisters a previously registered virtio message device from the misc
+ * subsystem. This removes its user-space interface (e.g., /dev/virtio-msg-N).
+ */
+void virtio_msg_user_unregister(struct virtio_msg_user_device *vmudev)
+{
+	misc_deregister(&vmudev->misc);
+}
+EXPORT_SYMBOL_GPL(virtio_msg_user_unregister);
-- 
2.31.1.272.g89b43f80a514

