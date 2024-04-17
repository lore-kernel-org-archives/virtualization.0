Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C2F171060
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372363; cv=none; b=HIo57OgaGbvZVSJaZIctYOjM1AZBPUVu4vebnR4smRKakqq25XaFv/Zp72olOWidLtOhd+UJdgN7bgvv4q9+ysBt4TB1EeEjQZb4QpOlFhn9yaUK2cZrn2agfl/HC4XoZXHXLrGCCjLl0AbG/R6p8/tnq3OvYnrIQNKnoP9Rrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372363; c=relaxed/simple;
	bh=Z1jeF7qulVW1TKjqXw6uzDM0QuhOgT0g9J8apBaAcXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeFZI1jF2K4Abb2qM7/+vmmTJ9UJclhLloEYNXyjJQ++T8J4Zic74mhCIiePz5gaPwyoGvad75Goq/0r99nXfXqYKwGzKX12XWB7v5oT4rFF/MGJWI7G2Hd4u1UvJej7pMmKMEW/P0j25suPKBkRTJSbyCsc7rN9Q2YCNdhcBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Z9OIHuM9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Z9OIHuM9"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d487659bso7061188e87.2
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372358; x=1713977158; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZJaM2/V0pnubO2BGW86GHU/5TxU4Qdi1H/FL0P6KP4=;
        b=Z9OIHuM9XEvw1PKFro16Lj/ALEFCFp1LobSBp5727vZWKdL6ecU/erVj//B1hNTguT
         9yiNqse6aQgITGDUbMrV6U89xLnULm52+XNQd9XxcgVqIWADO5rYSJ44mj6Ftn62lnEl
         siRdjWypIDpG+Ea0u1z8lQmMAoZkgafp3xUU19M/FPb9o/3GICbPAmnYiEiTsAJANQGj
         CtVXWSzjbBamfw+te4C7Tptxe3NOIPgCpCbE9OlgHecH6Ru00qxu9nRXSANxj1knmNuh
         jzurHbahg4aqS8gUVC9kMpMc5/glD+TDIPNjjXHr2Zx1hju3w2y6fb9c1BDrXmf9Ivth
         LeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372358; x=1713977158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZJaM2/V0pnubO2BGW86GHU/5TxU4Qdi1H/FL0P6KP4=;
        b=T3635Oib4lSKG2EanSSLB9K58atkyPXiIdfyJrTDHIHEn1tac5vrYXdDmB+fBgtNzo
         rkcFpik90njBj4qoDSAgDOns/pqWb95GhGIoCr7MTjEb0ZO/9SAGCs54WpnDTgRK5UnP
         HGEX8Zk5gO40iqsD4q9mtdzmO7xwsIEW/ORgqBnZ8xy3uhHbsKUEOOWHvQo+BYRzd0go
         sjwRzCsySXQ5KJDL7jbaN7V2O4nXDeic7yvpgRTomr3HMvqfBA1aZTTh9GLw+IwLw9MR
         hMtc8vgFzo8dy7rQouj3225ZcOPs8ngkZmxuZ8kPUneSblDWs75PWiDaHTm7rTl7N0jT
         iieA==
X-Forwarded-Encrypted: i=1; AJvYcCWY4suRL+ErEdli7GVEt8YOxCEazkftLkTNB4xYW/O9bumY4XghwnFYrtq6Zlt6MGaarM0ZzPJ0s08AZO8w2EapbE/QIaHVftPWc4y4Mvk=
X-Gm-Message-State: AOJu0YyEFrCx92LtY3XNkLAiioFOwL4xGX2wDteF4aZ368jcJ1cSEjfk
	ZTDLgPrnnrZHJ3Ga2jhkfCmjoniwgUYPajWiscEwlIsq0l5XKrHlIfhZIyQ0oeU=
X-Google-Smtp-Source: AGHT+IFJRy4WGVC99gUa+NMpTN/n+ZnaXpnDdQSDf7b49mSyGVi+4F9pz0oQ6VVETvmFdL+w8DRctw==
X-Received: by 2002:ac2:4906:0:b0:518:f2f8:edc6 with SMTP id n6-20020ac24906000000b00518f2f8edc6mr5025571lfi.63.1713372357840;
        Wed, 17 Apr 2024 09:45:57 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id h14-20020a1709070b0e00b00a518c69c4e3sm8261964ejl.23.2024.04.17.09.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:45:57 -0700 (PDT)
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
Subject: [patch net-next v3 1/6] virtio: add debugfs infrastructure to allow to debug virtio features
Date: Wed, 17 Apr 2024 18:45:49 +0200
Message-ID: <20240417164554.3651321-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417164554.3651321-1-jiri@resnulli.us>
References: <20240417164554.3651321-1-jiri@resnulli.us>
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
v2->v3:
- added missing kdoc for debugfs_filter_features struct field
---
 drivers/virtio/Kconfig        |   9 +++
 drivers/virtio/Makefile       |   1 +
 drivers/virtio/virtio.c       |   8 +++
 drivers/virtio/virtio_debug.c | 109 ++++++++++++++++++++++++++++++++++
 include/linux/virtio.h        |  35 +++++++++++
 5 files changed, 162 insertions(+)
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
index b0201747a263..c5f363b9f4d8 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -126,6 +126,8 @@ struct virtio_admin_cmd {
  * @vqs: the list of virtqueues for this device.
  * @features: the features supported by both driver and device.
  * @priv: private pointer for the driver's use.
+ * @debugfs_dir: debugfs directory entry.
+ * @debugfs_filter_features: features to be filtered set by debugfs.
  */
 struct virtio_device {
 	int index;
@@ -141,6 +143,10 @@ struct virtio_device {
 	struct list_head vqs;
 	u64 features;
 	void *priv;
+#ifdef CONFIG_VIRTIO_DEBUG
+	struct dentry *debugfs_dir;
+	u64 debugfs_filter_features;
+#endif
 };
 
 #define dev_to_virtio(_dev)	container_of_const(_dev, struct virtio_device, dev)
@@ -234,4 +240,33 @@ void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t a
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

