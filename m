Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236D2F39BD
	for <virtualization@lists.linux.dev>; Sun,  7 Dec 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765117714; cv=none; b=pTt1jTH+3Pw+VrkT+x3nkqtcx5/A9fqPOnGYShXvFV5fxWilB+fDC+Y6Wqe5ToRedIZnJpPrBWARF6ajQvKB6lwGX9mVm3lno3i18Vzvvabncrqdfn1k/FMrWfq32MelsaM3P+dNrELPbvTq+sEPAXwbwUKD0D12WZP2XddtJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765117714; c=relaxed/simple;
	bh=5TEuQSHM48KEXudliz/ABXdGqZlvkyN+2962zJSFkjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kS4a5Zfc0w3DsSpGnN5zHXHSrK0yZvsw+TUTc/lVE5pRHtJ75S6AEdsWe44PsgPEiIbotoPeN38zO05Rd+Tw/lPSST7e/OjfkxZtwofYtCDU0RQEWSsXumdDcj/Cb0Hb9jM2liOjSe0aHKQupw7wJxclj6aQ9lNbFKpJJIXQfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R5Jx4mY5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R5Jx4mY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Zz
	idKFiWZGWUMhbHITDbA3/OqeGy105gWS20itCH+C8=; b=R5Jx4mY5RetFrErvEA
	Q1Nh5aP3TDo5EUuULOCI/HS/r3dU9DVYC1nCmzqRwFMc6unhsvjSY2Qosr0mwuig
	a6r6EqzJupJbq2rO8DTMLg9WzWvCz9nN8kttzJ1KkL6oW0XoiyUVzUUoakzaTgpU
	RgVlrvkQJde+tdXObE9Jb2iKs=
Received: from rom-ubuntu.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDH4_P4jjVp5GEuGw--.37658S2;
	Sun, 07 Dec 2025 22:28:12 +0800 (CST)
From: Yufeng Wang <r4o5m6e8o@163.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yufeng Wang <r4o5m6e8o@163.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuedong Wang <wyd20130109@163.com>
Subject: [PATCH v2 2/2] tools: virtio: Fix no definition of dma_map_page_attrs
Date: Sun,  7 Dec 2025 22:28:07 +0800
Message-ID: <20251207142807.10808-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251206032318.19084-1-r4o5m6e8o@163.com>
References: <20251206032318.19084-1-r4o5m6e8o@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDH4_P4jjVp5GEuGw--.37658S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1xuw47Gw4rXry8Zry7Wrg_yoW8tr48pF
	WFkFyUt398tF4fuw1kGa4fuFyUu39xGw18WFW7Xwn8CF1xJwn2yws29ay2vr9rur109rWk
	AFn8uF1agasrArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEknYnUUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/1tbiRRIddWk1igxhIAAAsk

Fix tools/virtio compiler error, port over the definition
of dma_map_page_attrs, dma_unmap_page_attrs, dev_WARN_ONCE

v2: remove do {} while (0).

Fixes: 447beec8065b ("virtio_ring: switch to use dma_{map|unmap}_page()")
Signed-off-by: Yufeng Wang <r4o5m6e8o@163.com>
Tested-by: Yuedong Wang <wyd20130109@163.com>
---
 tools/virtio/linux/dma-mapping.h | 3 +++
 tools/virtio/linux/kernel.h      | 1 +
 2 files changed, 4 insertions(+)

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
index 6702008f7f5c..460df937ba9d 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -134,6 +134,7 @@ static inline void *krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t
 #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn_once(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
+#define dev_WARN_ONCE(dev, condition, format, ...) fprintf(stderr, format, ## __VA_ARGS__)
 
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
-- 
2.43.0

