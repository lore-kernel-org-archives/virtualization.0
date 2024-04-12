Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3681D1482EA
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934806; cv=none; b=O/dF06dlAg1lddS0hEg3sALC2IKth5PDyWedDw5N1vaT4sCZLnRq1iH+62Ydrdz1Y7Xpmau0m6Sj6LlCMEfTD+V55g0SCIWOKJ9tKCFsjXIl7JmiJwn7F50hdV3Y/oCR4/EiZPl7D1RmjX76vwLiSlzXPLOaiRm7aTrrkfNsdYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934806; c=relaxed/simple;
	bh=H3pjtAzG8pQcFoMfgL2Fil38d0Ryh7wHYYt0AdNSf3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seWnvtp1XAVIewkAR2ob6CuxHgr6uCOzZiYibOtvxaqIO4k2VxDs2ckReubOTXxFOjPGm0gSfIIIvIDA2zu0vxlwTYte+glb32fppLXOn9cWyEJpy821s7DUB1y74sj+lby/jLmig/2TCSiCTWjAY9UUjAm/9Kicv59Yn2h2eM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cn738Fbw; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cn738Fbw"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d4979cd8c8so9680601fa.0
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934801; x=1713539601; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxBkGe7SdmsJXy9vmp58aQDE3BF9aWZY5P/z4wlEcJY=;
        b=cn738FbwVSn91sccM7h0aF5MbmzXviuDzNC5HUPLXueGxgAQjYh4Dras6NZ+pKzI1/
         pvIft8F6tBCWsC+bO4uwKTDJbKLWqQIIWKXGsVFXSS0N1vFzapeqRK0ZhIXbe90R87op
         C34/6dlrvykCWNJHx/K8ni+Lo1LcUWfmURcjqBwRZOXanjJ6Id3ed7vut5ywfWApkFOa
         fDHisxXJd2NIzkI28iht8e8bKsn4P4CBP2BYR89iub6BQJTVpx8RnDH8rstIedcg/0SQ
         lZLEIbhF9eBAADx3EsSdoewvnAnWz8H1ygQXShXW4xPgapPz4Ah7lAwD1t8CdlsmK6tF
         eOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934801; x=1713539601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxBkGe7SdmsJXy9vmp58aQDE3BF9aWZY5P/z4wlEcJY=;
        b=g22U72g4rfhR5F5nW8J0vS/5R5Uh9LpHusStCIJTxodc/NlOYCt0YBQFnJFogd/Zzb
         Zzhs5LG+NiPXBVAnNyBXuLaqebK9J1FPfcqlM+pXZufn3bOdGQAX7sGw94L0Pi3NbhNV
         nBRNXVOmtCNvtVkyZVp3wNY8fan5Sdxpmd4QXVSgH3XGfYFGgXsse5jsiKcBjZwsQqbZ
         cGBvUuSwxtVbVLwRHsUS2K6b4oAer6RLuETIkw8rr2rojFqJ2dTJEG7PQeSfydiNmWuy
         A8zvswMlB5bUAwE3XGzuFl8vFTisecgepEMe9ZprlwSUuxN5i938KLTBDpN4QQaxSqnY
         POvA==
X-Forwarded-Encrypted: i=1; AJvYcCUq/Yhh3EnWDbP7Lx4MLDHiODNAcviGzblEXHJdHJAg5HyW7koIvzfy0fcVxCMJlpsnBSakjJeEWZNS/nda4+kjg+6nF09J6w+OUJQD1mQ=
X-Gm-Message-State: AOJu0YwGHeypxk7lsViCd4nOkhsaRUP8qN7AcZG5JPhF5hra85JpV+uU
	0s4XYOoT4sQeBk+GeNF8IIGYVvuiGhYPcr7+57qHYjEDd9G2Aays1Wk5Jz5HTnQ=
X-Google-Smtp-Source: AGHT+IF5xmjOkt+mt8whN9TEMlmNYz0RdgWHOIS/bCJOWvnRIOASdyC/CnLVmXdaKFeEDcTznXuFTg==
X-Received: by 2002:a2e:8783:0:b0:2d8:bda5:2d81 with SMTP id n3-20020a2e8783000000b002d8bda52d81mr1846865lji.19.1712934801088;
        Fri, 12 Apr 2024 08:13:21 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n9-20020a05651c000900b002d2697570fcsm526278lja.93.2024.04.12.08.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	parav@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	vladimir.oltean@nxp.com,
	bpoirier@nvidia.com,
	idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: [patch net-next 1/6] virtio: add debugfs infrastructure to allow to debug virtio features
Date: Fri, 12 Apr 2024 17:13:09 +0200
Message-ID: <20240412151314.3365034-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412151314.3365034-1-jiri@resnulli.us>
References: <20240412151314.3365034-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently there is no way for user to set what features the driver
should obey or not, it is hard wired in the code.

In order to be able to debug the device behavior in case some feature is
disabled, introduce a debugfs infrastructure with couple of files
allowing user to see what features the device advertises and
to set filter for features used by driver.

Example:
$cat /sys/bus/virtio/devices/virtio0/features
1110010111111111111101010000110010000000100000000000000000000000
$ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
$ cat /sys/kernel/debug/virtio/virtio0/filter_features
5
$ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
$ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
$ cat /sys/bus/virtio/devices/virtio0/features
1110000111111111111101010000110010000000100000000000000000000000

Note that sysfs "features" know already exists, this patch does not
touch it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/Kconfig        |   9 +++
 drivers/virtio/Makefile       |   1 +
 drivers/virtio/virtio.c       |   8 +++
 drivers/virtio/virtio_debug.c | 109 ++++++++++++++++++++++++++++++++++
 include/linux/virtio.h        |  34 +++++++++++
 5 files changed, 161 insertions(+)
 create mode 100644 drivers/virtio/virtio_debug.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index c17193544268..fc839a354958 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -178,4 +178,13 @@ config VIRTIO_DMA_SHARED_BUFFER
 	 This option adds a flavor of dma buffers that are backed by
 	 virtio resources.
 
+config VIRTIO_DEBUG
+        bool "Debug facilities"
+        help
+          Enable this to expose debug facilities over debugfs.
+	  This allows to debug features, to see what features the device
+	  advertises and to set filter for features used by driver.
+
+          If unsure, say N.
+
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 73ace62af440..58b2b0489fc9 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
 obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
 obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
 obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
+obj-$(CONFIG_VIRTIO_DEBUG) += virtio_debug.o
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f173587893cb..8d9871145e28 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -274,6 +274,9 @@ static int virtio_dev_probe(struct device *_d)
 	else
 		dev->features = driver_features_legacy & device_features;
 
+	/* When debugging, user may filter some features by hand. */
+	virtio_debug_device_filter_features(dev);
+
 	/* Transport features always preserved to pass to finalize_features. */
 	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++)
 		if (device_features & (1ULL << i))
@@ -463,6 +466,8 @@ int register_virtio_device(struct virtio_device *dev)
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
+	virtio_debug_device_init(dev);
+
 	/*
 	 * device_add() causes the bus infrastructure to look for a matching
 	 * driver.
@@ -494,6 +499,7 @@ void unregister_virtio_device(struct virtio_device *dev)
 	int index = dev->index; /* save for after device release */
 
 	device_unregister(&dev->dev);
+	virtio_debug_device_exit(dev);
 	ida_free(&virtio_index_ida, index);
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_device);
@@ -588,11 +594,13 @@ static int virtio_init(void)
 {
 	if (bus_register(&virtio_bus) != 0)
 		panic("virtio bus registration failed");
+	virtio_debug_init();
 	return 0;
 }
 
 static void __exit virtio_exit(void)
 {
+	virtio_debug_exit();
 	bus_unregister(&virtio_bus);
 	ida_destroy(&virtio_index_ida);
 }
diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.c
new file mode 100644
index 000000000000..28cf30948939
--- /dev/null
+++ b/drivers/virtio/virtio_debug.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/debugfs.h>
+
+static struct dentry *virtio_debugfs_dir;
+
+static int virtio_debug_device_features_show(struct seq_file *s, void *data)
+{
+	struct virtio_device *dev = s->private;
+	u64 device_features;
+	unsigned int i;
+
+	device_features = dev->config->get_features(dev);
+	for (i = 0; i < BITS_PER_LONG_LONG; i++) {
+		if (device_features & (1ULL << i))
+			seq_printf(s, "%u\n", i);
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(virtio_debug_device_features);
+
+static int virtio_debug_filter_features_show(struct seq_file *s, void *data)
+{
+	struct virtio_device *dev = s->private;
+	unsigned int i;
+
+	for (i = 0; i < BITS_PER_LONG_LONG; i++) {
+		if (dev->debugfs_filter_features & (1ULL << i))
+			seq_printf(s, "%u\n", i);
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(virtio_debug_filter_features);
+
+static int virtio_debug_filter_features_clear(void *data, u64 val)
+{
+	struct virtio_device *dev = data;
+
+	if (val == 1)
+		dev->debugfs_filter_features = 0;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(virtio_debug_filter_features_clear_fops, NULL,
+			 virtio_debug_filter_features_clear, "%llu\n");
+
+static int virtio_debug_filter_feature_add(void *data, u64 val)
+{
+	struct virtio_device *dev = data;
+
+	if (val >= BITS_PER_LONG_LONG)
+		return -EINVAL;
+	dev->debugfs_filter_features |= BIT_ULL_MASK(val);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(virtio_debug_filter_feature_add_fops, NULL,
+			 virtio_debug_filter_feature_add, "%llu\n");
+
+static int virtio_debug_filter_feature_del(void *data, u64 val)
+{
+	struct virtio_device *dev = data;
+
+	if (val >= BITS_PER_LONG_LONG)
+		return -EINVAL;
+	dev->debugfs_filter_features &= ~BIT_ULL_MASK(val);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(virtio_debug_filter_feature_del_fops, NULL,
+			 virtio_debug_filter_feature_del, "%llu\n");
+
+void virtio_debug_device_init(struct virtio_device *dev)
+{
+	dev->debugfs_dir = debugfs_create_dir(dev_name(&dev->dev),
+					      virtio_debugfs_dir);
+	debugfs_create_file("device_features", 0400, dev->debugfs_dir, dev,
+			    &virtio_debug_device_features_fops);
+	debugfs_create_file("filter_features", 0400, dev->debugfs_dir, dev,
+			    &virtio_debug_filter_features_fops);
+	debugfs_create_file("filter_features_clear", 0200, dev->debugfs_dir, dev,
+			    &virtio_debug_filter_features_clear_fops);
+	debugfs_create_file("filter_feature_add", 0200, dev->debugfs_dir, dev,
+			    &virtio_debug_filter_feature_add_fops);
+	debugfs_create_file("filter_feature_del", 0200, dev->debugfs_dir, dev,
+			    &virtio_debug_filter_feature_del_fops);
+}
+
+void virtio_debug_device_filter_features(struct virtio_device *dev)
+{
+	dev->features &= ~dev->debugfs_filter_features;
+}
+
+void virtio_debug_device_exit(struct virtio_device *dev)
+{
+	debugfs_remove_recursive(dev->debugfs_dir);
+}
+
+void virtio_debug_init(void)
+{
+	virtio_debugfs_dir = debugfs_create_dir("virtio", NULL);
+}
+
+void virtio_debug_exit(void)
+{
+	debugfs_remove_recursive(virtio_debugfs_dir);
+}
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b0201747a263..ab3f36c39686 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -126,6 +126,7 @@ struct virtio_admin_cmd {
  * @vqs: the list of virtqueues for this device.
  * @features: the features supported by both driver and device.
  * @priv: private pointer for the driver's use.
+ * @debugfs_dir: debugfs directory entry.
  */
 struct virtio_device {
 	int index;
@@ -141,6 +142,10 @@ struct virtio_device {
 	struct list_head vqs;
 	u64 features;
 	void *priv;
+#ifdef CONFIG_VIRTIO_DEBUG
+	struct dentry *debugfs_dir;
+	u64 debugfs_filter_features;
+#endif
 };
 
 #define dev_to_virtio(_dev)	container_of_const(_dev, struct virtio_device, dev)
@@ -234,4 +239,33 @@ void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t a
 void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
 						unsigned long offset, size_t size,
 						enum dma_data_direction dir);
+
+#ifdef CONFIG_VIRTIO_DEBUG
+void virtio_debug_device_init(struct virtio_device *dev);
+void virtio_debug_device_exit(struct virtio_device *dev);
+void virtio_debug_device_filter_features(struct virtio_device *dev);
+void virtio_debug_init(void);
+void virtio_debug_exit(void);
+#else
+static inline void virtio_debug_device_init(struct virtio_device *dev)
+{
+}
+
+static inline void virtio_debug_device_exit(struct virtio_device *dev)
+{
+}
+
+static inline void virtio_debug_device_filter_features(struct virtio_device *dev)
+{
+}
+
+static inline void virtio_debug_init(void)
+{
+}
+
+static inline void virtio_debug_exit(void)
+{
+}
+#endif
+
 #endif /* _LINUX_VIRTIO_H */
-- 
2.44.0

