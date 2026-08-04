Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47442E8D0
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830500; cv=none; b=JimMb8XXfYp/y/KmTAIc8RJsRKjKCf/nBIXJYDCCQLJjvI66yBuXw3syNXEpt330fc3WiNwQPPjOh/F69t5gyKrnjMLTuZtfixxuWLG1jHYne+9ZYWJK535rrQBBw7AFWLSE4ukgS/pNHZ2NuwgDXb5jahP5BLDAtwIUautc1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830500; c=relaxed/simple;
	bh=jv/8jh4nUeoRb+P/0T3xefwTXs5/+xJ/He96kSRljGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J5FMdctH5USOA4bU3VG+v1OjBjSrHtWIHaQa9uYBjOWo3nzwvYgDs1AGBfrUURfT3+nUqA2PsbIe3LtZD7jcnXQ/Xoho86Rkirn2ehqh9DEN9ogYpkEtX8jxuwGnS0tXH2sGaqaw2lXC3zZ4v2GBvWsqCcjYO6yWcCFMFPhCmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HCq1Es2X; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HCq1Es2X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GD
	XLoRKgzjKVnPrgwJcrOOcZrQyU97XBZRb6Hz6oZlY=; b=HCq1Es2XyjzlONBs2u
	wjs1KTefU8C1R/l72mjb6w9ZyueDEEmWlceHcp0UTFJAExFmQxlLS5bcYsnQTlA+
	9tDCPvGS6cMOAjHIdqTDdYS0RvziQ9YwXBdhzp0T1fdOmTogxKNla0CeCJ0m+QGd
	WbeA6uKI50m1yH+5Z+vxBA3+0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3+bZVnHFqQsQvLQ--.12248S5;
	Tue, 04 Aug 2026 16:01:29 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: virtualization@lists.linux.dev
Cc: eperezma@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	pabeni@redhat.com,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>
Subject: [PATCH 3/3] tools/virtio: add --features-array switch
Date: Tue,  4 Aug 2026 16:01:25 +0800
Message-Id: <20260804080125.79403-4-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804080125.79403-1-r4o5m6e8o@163.com>
References: <CAJaqyWfP7j5_PvOP0JiHuAQ8appGnoJDS3OB-qK7riBpZ_d_tQ@mail.gmail.com>
 <20260804080125.79403-1-r4o5m6e8o@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3+bZVnHFqQsQvLQ--.12248S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr1fXrW3WF4xZrWkAF17Awb_yoW7GFy8p3
	ySqF15AF43Jr1xCa13J39ruF45Gw1xAF45ArZ2y34rC3WUGFyUAFs2ka10qa9xZ3ykXFWa
	gFn0vr4xCFWDu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j76p9UUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbC8Bk0qWpxnFnjNAAA39

From: Yufeng Wang <wangyufeng@kylinos.cn>

Add a --features-array command-line switch that exercises the array-variant
feature ioctls, VHOST_SET_FEATURES_ARRAY and VHOST_GET_FEATURES_ARRAY,
instead of the legacy VHOST_SET_FEATURES.  The legacy path is used when the
switch is omitted, so both code paths stay covered.

SET: features are programmed via VHOST_SET_FEATURES_ARRAY.

GET: VHOST_GET_FEATURES_ARRAY is issued twice with a count above
VIRTIO_FEATURES_U64S, once into a zero-initialized buffer and once into a
sentinel-filled one; the two reads must match.  This verifies the kernel
fills the prefix and clear_user()s the trailing entries, and stays correct
as the kernel's feature-word count grows.

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 tools/virtio/vhost_net_test.c | 70 +++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.c
index 389d99a6d7c7..77191e60a7a3 100644
--- a/tools/virtio/vhost_net_test.c
+++ b/tools/virtio/vhost_net_test.c
@@ -26,6 +26,12 @@
 #define TEST_PTYPE	ETH_P_LOOPBACK
 #define DESC_NUM	256
 
+/* Number of u64 entries that the kernel uses to store all currently-defined
+ * virtio features. Must stay in sync with the kernel's VIRTIO_FEATURES_U64S. */
+#define FEATURES_U64S	2
+/* Above VIRTIO_FEATURES_U64S so trailing entries hit the clear_user() tail. */
+#define GET_FEATURES_ARRAY_COUNT	8
+
 /* Used by implementation of kmalloc() in tools/virtio/linux/kernel.h */
 void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
 
@@ -205,8 +211,10 @@ static void vq_info_add(struct vdev_info *dev, int idx, int num, int fd)
 	assert(!r);
 }
 
-static void vdev_info_init(struct vdev_info *dev, unsigned long long features)
+static void vdev_info_init(struct vdev_info *dev, unsigned long long features,
+			   bool features_array)
 {
+	struct vhost_features_array *fa;
 	struct ether_header *eh;
 	int i, r;
 
@@ -248,8 +256,20 @@ static void vdev_info_init(struct vdev_info *dev, unsigned long long features)
 	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
 	assert(r >= 0);
 
-	r = ioctl(dev->control, VHOST_SET_FEATURES, &features);
-	assert(r >= 0);
+	if (features_array) {
+		fa = calloc(1, struct_size(fa, features, FEATURES_U64S));
+		assert(fa);
+		fa->count = FEATURES_U64S;
+		fa->features[0] = features;
+
+		r = ioctl(dev->control, VHOST_SET_FEATURES_ARRAY, fa);
+		assert(r >= 0);
+
+		free(fa);
+	} else {
+		r = ioctl(dev->control, VHOST_SET_FEATURES, &features);
+		assert(r >= 0);
+	}
 
 	dev->nvqs = 2;
 }
@@ -455,6 +475,10 @@ static const struct option longopts[] = {
 		.val = 'b',
 		.has_arg = required_argument,
 	},
+	{
+		.name = "features-array",
+		.val = 'F',
+	},
 	{
 	}
 };
@@ -467,11 +491,43 @@ static void help(int status)
 		" [--no-virtio-1]"
 		" [--delayed-interrupt]"
 		" [--buf-num]"
+		" [--features-array]"
 		"\n");
 
 	exit(status);
 }
 
+static void verify_get_features_array(struct vdev_info *dev)
+{
+	struct vhost_features_array *clean, *dirty;
+	int r, i;
+
+	clean = calloc(1, struct_size(clean, features, GET_FEATURES_ARRAY_COUNT));
+	assert(clean);
+	clean->count = GET_FEATURES_ARRAY_COUNT;
+	r = ioctl(dev->control, VHOST_GET_FEATURES_ARRAY, clean);
+	assert(r >= 0);
+
+	/* Sentinel-fill so the kernel's clear_user() of the tail is visible. */
+	dirty = calloc(1, struct_size(dirty, features, GET_FEATURES_ARRAY_COUNT));
+	assert(dirty);
+	dirty->count = GET_FEATURES_ARRAY_COUNT;
+	memset(dirty->features, 0xa5, GET_FEATURES_ARRAY_COUNT * sizeof(dirty->features[0]));
+	r = ioctl(dev->control, VHOST_GET_FEATURES_ARRAY, dirty);
+	assert(r >= 0);
+
+	/* Must match; a wrong clear_user() start would leave them unequal. */
+	for (i = 0; i < GET_FEATURES_ARRAY_COUNT; i++)
+		assert(clean->features[i] == dirty->features[i]);
+
+	printf("GET_FEATURES_ARRAY: 0x%llx 0x%llx (tail zeroed) OK\n",
+	       (unsigned long long)clean->features[0],
+	       (unsigned long long)clean->features[1]);
+
+	free(clean);
+	free(dirty);
+}
+
 int main(int argc, char **argv)
 {
 	unsigned long long features = (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
@@ -480,6 +536,7 @@ int main(int argc, char **argv)
 	long nbufs = 0x100000;
 	struct vdev_info dev;
 	bool delayed = false;
+	bool features_array = false;
 	int o, fd;
 
 	for (;;) {
@@ -503,6 +560,9 @@ int main(int argc, char **argv)
 		case 'D':
 			delayed = true;
 			break;
+		case 'F':
+			features_array = true;
+			break;
 		case 'n':
 			nbufs = strtol(optarg, NULL, 10);
 			assert(nbufs > 0);
@@ -520,7 +580,9 @@ int main(int argc, char **argv)
 	fd = tun_alloc(&dev, tun_name);
 	assert(fd >= 0);
 
-	vdev_info_init(&dev, features);
+	vdev_info_init(&dev, features, features_array);
+	if (features_array)
+		verify_get_features_array(&dev);
 	vq_info_add(&dev, 0, DESC_NUM, fd);
 	vq_info_add(&dev, 1, DESC_NUM, fd);
 	vdev_create_socket(&dev, tun_name);
-- 
2.34.1

