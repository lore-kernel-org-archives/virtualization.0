Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271602ED15D
	for <virtualization@lists.linux.dev>; Mon, 10 Nov 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806645; cv=none; b=ZXVGMGMoMQydYK76wwt8GLB7MA/++hmtHCW3+zElN0dqSOX7MHc+0IwK0aM0ydA3TmOlLnULjgrTaITyarcCL1HfZ7qkdJtjvbvau5lFeWpFPUz66RCsshMHaG6f7KJxFbY661eWYRquZW1uoPbGCQAz/abg15op0j6fMqB9xZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806645; c=relaxed/simple;
	bh=XPCALEKMTqvrYzdXKp4012lIXgr9shCCsxUVs1Kr7cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KCbt4oTUfiGYA/MOxjdsQ0ojAFDp1vPIZdbjhwF8+ikq2+LBDH6jFeW9gmD7p7wuMbtozK6bg0I2wg04e5D9OC3v6xXFaRukFNpGfLqwGWVO7GpH7pvM/RncXjZIp3bLLnJpi6GSKJ+6gMjNM7CrvnNiPhDxxS+8+9V8LIfzhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA6I0krM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA6I0krM"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so2528001b3a.1
        for <virtualization@lists.linux.dev>; Mon, 10 Nov 2025 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762806643; x=1763411443; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ro8LfVFs4vPgQTzcnnWdFnGjc8mt7GRah6t2C6MZm1M=;
        b=jA6I0krMa/b6+dSvump29POdIZ+0twNhArsE7XriNqGmsdVH/FqUxS5vej9nlkDF9T
         qizlH+NAEdb+0NwgYlyP2mzwfCau8yE3ThTlz8QpD16zsDk1qLMrTUS3iQMjyCgJitHM
         hOkcyIhQuxN1fwE84Y4EgZxp87DmfXeQ0uXluzVh3yuZps8QvR1l9rSMQOQKeS/jt/zr
         HuXSOd1lbxSvROmCJ4VGlFoyFR2q/KVhmGgNLCPtiw9hY1vEcq/cxLXeXq1GaMoK9Ykq
         x8nk6C4Ikyjo6756qYfcTkU+tgw4pXEYyGaMm/Dzi2FXwKMR7nAbvKphlgxQsGde9Ja3
         HcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806643; x=1763411443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro8LfVFs4vPgQTzcnnWdFnGjc8mt7GRah6t2C6MZm1M=;
        b=XWg53xXAR0iLKxPHrmXlheX3wnqQL95Of7HNDpU8Yt+cp9ZcH7OTjvGxi5WkTtHNkG
         x+6WGh0q1zleaJJx53+s1c23W9vzEVrzYExgtlPs3KMWzvEy9GGV/B+grAfMVa0TpDu/
         cPPsnqUE4CMJnSaDQl/bzOD6EIRZT6LIs9m6n7RALps2mRV6QKojXVD9z49++/co24GJ
         nubOUcsbt+lGgd1ijTRPS7Lx49LOmitf824/Nrqx52k88x435pSpGdvDllGuxkvriSU1
         fQwX0Jg537FWHXVp+lOi5BIfEYJnPnoonqby9wkNZ/MzYpYHjWSzvcmPB5GJpWJDQBP4
         IyCg==
X-Gm-Message-State: AOJu0Yyq2RwD5QaEByfVxWIG/fnMZAMzMO6cq6DeG/t7BRaXbGBc9Mpm
	d8wyDImxCfOO0QrQtaQ7YNUdLBA10z1p2pYqm9reUefuTnrTg10Hk+HV
X-Gm-Gg: ASbGncvQMvxj4ODDF47f50NEo5uOSicw42FQu5Uu5EMsUwmfPEiwS1MXcUze3o39cjr
	I8viXxtJATb9IrQMhoKZ3PTGOjjpTKhXGsiFOd9OsKXMpAU9P8UgKul3oP5BiSoaLtWRfVElr1Y
	pcbmHq5IoBVG4Mod4KMtUjjr38kncK42gFv+0e1g3OQpnbO9ubJ0/8XLD5xkF0cjcY9qq5V9pJZ
	z3SVV7XcK+PvgjiFBdIBcJ9ziVnNwp1A/qcU6H7hQg/pYvslm8/BWp5skdmGY6vYh/yjxo/WD4y
	hN+HAeXgazbbXrXjmZBAOgi4GNxH66LbaaSv5je+Z/rcAq7qtVlW9eV/Mfm4kxqC4U44+Q3h3RH
	e0JBwZvVWxQVtCODxFEzGvhqPl7OwxKhm5JnJR41jfjphrqJIYgtcxnBozIrt41isN3nJI7/RzN
	NwFdVBi6NCZJkf8OpB
X-Google-Smtp-Source: AGHT+IGkzYVEYBFXghKEZPwUaZCu1Fha5OHUKNcP3PPtxc6UkSUM+cKWRwlTckCHb6/fSObwrLGs6Q==
X-Received: by 2002:a05:6a00:b53:b0:7a2:7237:79ff with SMTP id d2e1a72fcca58-7b225acd9admr10942610b3a.7.1762806643188;
        Mon, 10 Nov 2025 12:30:43 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a688sm12920048b3a.40.2025.11.10.12.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:30:42 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] virtio: fix kernel-doc for mapping/free_coherent functions
Date: Mon, 10 Nov 2025 20:29:20 +0000
Message-Id: <20251110202920.2250244-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation build reported:

  WARNING: ./drivers/virtio/virtio_ring.c:3174 function parameter 'vaddr' not described in 'virtqueue_map_free_coherent'
  WARNING: ./drivers/virtio/virtio_ring.c:3308 expecting prototype for virtqueue_mapping_error(). Prototype was for virtqueue_map_mapping_error() instead

The kernel-doc block for virtqueue_map_free_coherent() omitted the @vaddr parameter, and
the kernel-doc header for virtqueue_map_mapping_error() used the wrong function name
(virtqueue_mapping_error) instead of the actual function name.

This change updates:

  - the function name in the comment to virtqueue_map_mapping_error()
  - adds the missing @vaddr description in the comment for virtqueue_map_free_coherent()

Fixes: b41cb3bcf67f ("virtio: rename dma helpers")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/virtio/virtio_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7b6205253b46..ddab68959671 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3166,6 +3166,7 @@ EXPORT_SYMBOL_GPL(virtqueue_map_alloc_coherent);
  * @vdev: the virtio device we are talking to
  * @map: metadata for performing mapping
  * @size: the size of the buffer
+ * @vaddr: the virtual address that needs to be freed
  * @map_handle: the mapped address that needs to be freed
  *
  */
@@ -3190,7 +3191,7 @@ EXPORT_SYMBOL_GPL(virtqueue_map_free_coherent);
  * @dir: mapping direction
  * @attrs: mapping attributes
  *
- * Returns mapped address. Caller should check that by virtqueue_mapping_error().
+ * Returns mapped address. Caller should check that by virtqueue_map_mapping_error().
  */
 dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
 				    struct page *page,
@@ -3249,7 +3250,7 @@ EXPORT_SYMBOL_GPL(virtqueue_unmap_page_attrs);
  * The caller calls this to do dma mapping in advance. The DMA address can be
  * passed to this _vq when it is in pre-mapped mode.
  *
- * return mapped address. Caller should check that by virtqueue_mapping_error().
+ * return mapped address. Caller should check that by virtqueue_map_mapping_error().
  */
 dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr,
 				      size_t size,
@@ -3299,7 +3300,7 @@ void virtqueue_unmap_single_attrs(const struct virtqueue *_vq,
 EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
 
 /**
- * virtqueue_mapping_error - check dma address
+ * virtqueue_map_mapping_error - check dma address
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  *
-- 
2.34.1

