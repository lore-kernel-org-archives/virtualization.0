Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82247D27E
	for <virtualization@lists.linux.dev>; Sun, 30 Nov 2025 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764474576; cv=none; b=EMr20Tt109LEg5ezFm7DO6WGqPQ/Ws9KO7WIIRB8sQtuk1f/X3IMzTiExZ86nArdHnXm4oPbtZ82QNlS9d/uWvQLipHiayJcz+bDlsJA+uUL9EIZ06lQ9v/iN+7wgrFO0obI7HmGexFskpFOTN/gJOrsaN00143y62yhSnon1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764474576; c=relaxed/simple;
	bh=1RgXUY4fEcrVTvfcLMOUM6UHNzw/N9ERFIJsUR/OXpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdhgoZneaXDTCpKMMk4yK1Yw6pxJYCNYNLdgv3hEhZ2QRg+XT2kwHWvp+y9UQ7t1TqDTPxU6WUo2qnRPChWN4a7TMK8LNvq0rAJqJ4FeJkBcUXsmUonHik9Y4sNK3v1qTl5Rf8Xdxh3zxmURVG/w1Yup3IDvnafUsNN+wX3b/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wkst+kWa; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wkst+kWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2h
	1LwzTVcI55M1ofR/V3jw4zIILxhUZQgjvlO98Tj9c=; b=Wkst+kWaoNdnEPw2lm
	60JdXs93LYbtspHJ3XCtp4GP2XI9QZxNvAgfCjf6GsfZPjgBsQ5+1dcOE4Z8aVGL
	Nhb0VY8Yjg59y+xZwWLsUR01gQ6c97OP2sHc1K3SPNa9vyZsLfXPL8uU1BaBOuBj
	KvATmK4W3HkOhbFsJYfxhS3oc=
Received: from rom-ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBnd31RvCtpeoIkDA--.13754S2;
	Sun, 30 Nov 2025 11:38:58 +0800 (CST)
From: Yufeng Wang <r4o5m6e8o@163.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yufeng Wang <r4o5m6e8o@163.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Yuedong Wang <wyd20130109@163.com>,
	Yuexuan Wang <wangyx20170302@163.com>,
	Haimei Qu <545714393@qq.com>
Subject: [PATCH] tools: add map and vmap to virtio_device
Date: Sun, 30 Nov 2025 11:38:55 +0800
Message-ID: <20251130033855.28823-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnd31RvCtpeoIkDA--.13754S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF18Ww4DCFW3XF45WF47CFg_yoW5KF4UpF
	yUAr13GrWUKF4fZFyfA3WUCw4a9rn7Cryxta47W34jgF13XrnFvF1qka4rtr43AryDCFW8
	ArnYqr4FkryDuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKXHRiUUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/1tbiRRIWdWkrtUy2NAAAsN

Fix compile error when make tools/virtio,
port over the virtio_device member map and vmap to tools.

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Signed-off-by: Yufeng Wang <r4o5m6e8o@163.com>
Tested-by: Yuedong Wang <wyd20130109@163.com>
Tested-by: Yuexuan Wang <wangyx20170302@163.com>
Tested-by: Haimei Qu <545714393@qq.com>
---
 tools/virtio/linux/virtio.h        | 28 ++++++++++++++++++++++++++++
 tools/virtio/linux/virtio_config.h | 21 +++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 5d3440f474dd..4c2c87336d29 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -4,17 +4,24 @@
 #include <linux/scatterlist.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
+#include <linux/dma-mapping.h>
 
 struct device {
 	void *parent;
 };
 
+union virtio_map {
+	struct device *dma_dev;
+};
+
 struct virtio_device {
 	struct device dev;
 	u64 features;
 	struct list_head vqs;
 	spinlock_t vqs_list_lock;
 	const struct virtio_config_ops *config;
+	const struct virtio_map_ops *map;
+	union virtio_map vmap;
 };
 
 struct virtqueue {
@@ -69,4 +76,25 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      const char *name);
 void vring_del_virtqueue(struct virtqueue *vq);
 
+void *virtqueue_map_alloc_coherent(struct virtio_device *vdev,
+				   union virtio_map mapping_token,
+				   size_t size, dma_addr_t *dma_handle,
+				   gfp_t gfp);
+
+void virtqueue_map_free_coherent(struct virtio_device *vdev,
+				 union virtio_map mapping_token,
+				 size_t size, void *vaddr,
+				 dma_addr_t dma_handle);
+
+dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
+				    struct page *page,
+				    unsigned long offset,
+				    size_t size,
+				    enum dma_data_direction dir,
+				    unsigned long attrs);
+
+void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
+				dma_addr_t dma_handle,
+				size_t size, enum dma_data_direction dir,
+				unsigned long attrs);
 #endif
diff --git a/tools/virtio/linux/virtio_config.h b/tools/virtio/linux/virtio_config.h
index 42a564f22f2d..ee696dad294a 100644
--- a/tools/virtio/linux/virtio_config.h
+++ b/tools/virtio/linux/virtio_config.h
@@ -10,6 +10,27 @@ struct virtio_config_ops {
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
 };
 
+struct virtio_map_ops {
+	dma_addr_t (*map_page)(union virtio_map map, struct page *page,
+			       unsigned long offset, size_t size,
+			       enum dma_data_direction dir, unsigned long attrs);
+	void (*unmap_page)(union virtio_map map, dma_addr_t map_handle,
+			   size_t size, enum dma_data_direction dir,
+			   unsigned long attrs);
+	void (*sync_single_for_cpu)(union virtio_map map, dma_addr_t map_handle,
+				    size_t size, enum dma_data_direction dir);
+	void (*sync_single_for_device)(union virtio_map map,
+				       dma_addr_t map_handle, size_t size,
+				       enum dma_data_direction dir);
+	void *(*alloc)(union virtio_map map, size_t size,
+		       dma_addr_t *map_handle, gfp_t gfp);
+	void (*free)(union virtio_map map, size_t size, void *vaddr,
+		     dma_addr_t map_handle, unsigned long attrs);
+	bool (*need_sync)(union virtio_map map, dma_addr_t map_handle);
+	int (*mapping_error)(union virtio_map map, dma_addr_t map_handle);
+	size_t (*max_mapping_size)(union virtio_map map);
+};
+
 /*
  * __virtio_test_bit - helper to test feature bits. For use by transports.
  *                     Devices should normally use virtio_has_feature,
-- 
2.43.0

