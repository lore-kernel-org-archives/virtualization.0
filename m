Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DFB1AAE28
	for <virtualization@lists.linux.dev>; Sat,  6 Dec 2025 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764991284; cv=none; b=USHs5wPV6CFCyRj97Hgr9Wjnquy6ulLs+9tZ7SvsUSTFyqXt5NWNw11H3Wyj9mY3MiJ+bJ0bxlpFRTUkMu43mKewFoStgy7nb3feRvZujZ9Z2zOP6WfWQZKma2LFys57a/KpJZ/tUj06oho5AWns5RwjiVDRrtxLu1tEmu3EZlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764991284; c=relaxed/simple;
	bh=nYjcH9s7xGli7k3QBHsTFWjRc7+OkUyFPyDnQGOu0CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UeGW1NF8cVX4UyqaPsZE4Fu1ktPb+alQKGODr25WgI2calylcFcnUVtkZY1zKKKx551NA/NvMYTv2Oh/jjOEbVsLfNMEnDA25kDhpy6Mk3EuqPpqpxSNp4qIDWMq2SHPmBkHzYOZKsh+qx6V0TN9YkVCfkNhmt6fjBE5vriFZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kIrtot/h; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kIrtot/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IN
	dg9dIg841Q66PNX6lFviRH0M+IGiepOLgShdZd3r8=; b=kIrtot/hU7C3Mjxra/
	iOwYZgXjzPDSCoNVH95Tu6wlJhHK/ChLhH/Hy0LnJteCs0/lFAKrwHm2fNZ+foUF
	bWyzG0I5sN/5i0EOxV4JhwG18RSpe0GM+MZIJ/NBMCS8wamew2c9cT+w3lMisHRD
	Thioj7PhyvTBGWThZDIV1kCqg=
Received: from rom-ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXzcEooTNpj_ByAA--.3976S2;
	Sat, 06 Dec 2025 11:21:14 +0800 (CST)
From: Yufeng Wang <r4o5m6e8o@163.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yufeng Wang <r4o5m6e8o@163.com>,
	virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Haimei Qu <545714393@qq.com>
Subject: [PATCH 1/2] tools: virtio: port over virtqueue_map_single_attrs define.
Date: Sat,  6 Dec 2025 11:21:10 +0800
Message-ID: <20251206032110.18923-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXzcEooTNpj_ByAA--.3976S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw15Cw1furW5Xw17CrW3Wrg_yoWkJFg_Ar
	1DXr1vgr4vkFW2vFW2yrySqr1fG3WxGF4DWF1FqFyrAFy5JFs8XFn3AFZ8GFy7Xw4I9F43
	ZayrWrZ8Xw1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKL0n7UUUUU==
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/1tbiYAAcdWkzm-uLZwAAsf

Fix compile error when make tools/virtio,
port over the definition of virtqueue_map_single_attrs to tools.
the issue begin at
commit 447beec8065b ("virtio_ring: switch to use dma_{map|unmap}_page()")
then the function name have been changed at
commit b41cb3bcf67f ("virtio: rename dma helpers")

Fixes: b41cb3bcf67fc ("virtio: rename dma helpers")
Signed-off-by: Yufeng Wang <r4o5m6e8o@163.com>
Tested-by: Haimei Qu <545714393@qq.com>
---
 tools/virtio/linux/virtio.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 961e326e3c53..b20e4b633859 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -97,4 +97,9 @@ void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
 				dma_addr_t dma_handle,
 				size_t size, enum dma_data_direction dir,
 				unsigned long attrs);
+
+dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr, size_t size,
+				      enum dma_data_direction dir, unsigned long attrs);
+
+
 #endif
-- 
2.43.0

