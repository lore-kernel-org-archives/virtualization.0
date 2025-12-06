Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15836213254
	for <virtualization@lists.linux.dev>; Sat,  6 Dec 2025 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764991417; cv=none; b=YDCbPhq+4Dmo1JUNZwgRxub1aEbgdeCvP81kOPrH4ayDiV9RVCqF948NMNl0SfVND69q5pLOqo9skwf51HSVw6Y92CPNR2XFgORR6gEHCJlTbpKyaCMYHUI8++M8RQClsvvB8/9a+aRNVtNJmE+iQ/sSHmrjs7L0x6RzEx6Kxuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764991417; c=relaxed/simple;
	bh=1lHZaBf4JRWz20EOwCdwLp14p9D7AUUsmYHYZVAxz7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGfIbyakhbe1f1N+TfowD8EnlBhTG2wn1Zbyf1EuTkxy7zTj5y7/1EurRhfuUQq5rUDAYtwwlTQ3oUhrD//EOV+I/39RkOZB5ZhK/P28MTEb5cTaXbYTxv04gf6s51sD1uRoW+CWNsQcqQnJptlFoFnuraJzkZnY0+66J8cp+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nqd8hCsn; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nqd8hCsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6S
	xMiMG5L2vE5t8MwMx3uIEGwx3rj3162HlCR+SojRk=; b=Nqd8hCsn7FrmlXd8Mh
	j4RjMy6Rc3j7wGvrFxBAunJQs9ogy75A435pK3yPRDfC+1FaZjSv4cAHMH+YUjIT
	N/pOoN4/NA7t3HOsfR/UrdL/PsWPPm8dk8C7qbVxhwVrpCEnKoV/3sPRggh3fBP6
	Y39Vnsv3sxFYsAdYoqAbKgXW8=
Received: from rom-ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAH9iWooTNp8+ZzAA--.6222S2;
	Sat, 06 Dec 2025 11:23:21 +0800 (CST)
From: Yufeng Wang <r4o5m6e8o@163.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yufeng Wang <r4o5m6e8o@163.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuedong Wang <wyd20130109@163.com>
Subject: [PATCH 2/2] tools: virtio: Fix no definition of dma_map_page_attrs
Date: Sat,  6 Dec 2025 11:23:18 +0800
Message-ID: <20251206032318.19084-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH9iWooTNp8+ZzAA--.6222S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1xuw47Gw4xAr15ZFy5Arb_yoW8trWDpF
	WFkFyUt398tF4fuw1kGa4fuFyUu39xGw18WFW7Xwn8CF1xJwn2yrs29ay2vr9rur18ury8
	AFn8uF1agasrArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pElApUUUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/1tbiYAocdWkzm-uXnwAAsx

Fix tools/virtio compiler error, port over the definition
of dma_map_page_attrs, dma_unmap_page_attrs, dev_WARN_ONCE

Fixes: 447beec8065b ("virtio_ring: switch to use dma_{map|unmap}_page()")
Signed-off-by: Yufeng Wang <r4o5m6e8o@163.com>
Tested-by: Yuedong Wang <wyd20130109@163.com>
---
 tools/virtio/linux/dma-mapping.h | 3 +++
 tools/virtio/linux/kernel.h      | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
index 095958461788..de251a1f0c37 100644
--- a/tools/virtio/linux/dma-mapping.h
+++ b/tools/virtio/linux/dma-mapping.h
@@ -22,6 +22,7 @@ enum dma_data_direction {
 #define dma_free_coherent(d, s, p, h) kfree(p)
 
 #define dma_map_page(d, p, o, s, dir) (page_to_phys(p) + (o))
+#define dma_map_page_attrs(d, p, o, s, dir, a) (page_to_phys(p) + (o))
 
 #define dma_map_single(d, p, s, dir) (virt_to_phys(p))
 #define dma_map_single_attrs(d, p, s, dir, a) (virt_to_phys(p))
@@ -29,6 +30,8 @@ enum dma_data_direction {
 
 #define dma_unmap_single(d, a, s, r) do { (void)(d); (void)(a); (void)(s); (void)(r); } while (0)
 #define dma_unmap_page(d, a, s, r) do { (void)(d); (void)(a); (void)(s); (void)(r); } while (0)
+#define dma_unmap_page_attrs(d, a, s, r, t) \
+	do { (void)(d); (void)(a); (void)(s); (void)(r); (void)(t); } while (0)
 
 #define sg_dma_address(sg) (0)
 #define sg_dma_len(sg) (0)
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 6702008f7f5c..88e474f46916 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -134,6 +134,9 @@ static inline void *krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t
 #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn_once(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
+#define dev_WARN_ONCE(dev, condition, format, ...) \
+	do { (void)(dev); (void)(condition); \
+	fprintf(stderr, format, ## __VA_ARGS__); } while (0)
 
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
-- 
2.43.0

