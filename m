Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF842A96;
	Sat, 15 Nov 2025 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763246739; cv=none; b=mCwxFpB+8jdAI98+QRXpCh6QNlH+L4P46b607o3diRME0h0TsORt1e/xxWBQyjELEBjXX7SJqvVesX1bsw/cS0O6xScCRXU7YSLoiPy5U124bgQo5rkcNurXSPGPeGCymyak2JjNuOfVQb9zkCFsndXxrdRGx029If50ETTAAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763246739; c=relaxed/simple;
	bh=zpdWxSWaVdv/XiNVVdkWOu+quMBfraxvv0hwmGK4FLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K9jDCk+vMMI6Q2t/YTMoRKM7ZZ1hnkQ/872Ag022DSB75R8dvpR6UN2VBSpNIqt4VKsbpc0cJYmw9SfgRy+YRSoCVOtuOx3CP7ASoHKoIj8WGb2eWvz+QuAeT2AWfo4hjIxOSxXa/7kqhAW4L6R3VtnaQyAucRp2lToscISfQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b9MBMAYG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b9MBMAYG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KKvrORyrKOe963KVeTzKdMSbSh2sTwiDIBWeDXj/9z8=; b=b9MBMAYGCEg+iCgMwXOEZdKOmC
	4sBi9k2a9DlZy5MBwqTc+T2QcCRvH7XYRnh+VSnJrONVbPw62NlOLeLKvr+yrTIEAQfvBzeMYwpvo
	oqFevjSkilU9pcAL6wDe2cJfzaRfhujaymNDtXOUwvJ1VdEQI4Vq2HtPo5DROiip/hfSofffv9R/o
	ZoaOTZ+2W0ARh5tOdqV/0zRojaRTMW2kPkAVhcu/PwuS+aEcnHLaZDgytk8QBz114uia5oV1Wqybe
	owKPuSewdFvbT2NRBbcOOQBqJcxp5zUgYwlg6TiQZLqzjeXIjNPulPlq79NIb5H62jckutLtLooBl
	rtI+czdg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKP1S-0000000EASd-2bAS;
	Sat, 15 Nov 2025 22:45:36 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] virtio_ring: kernel-doc: fix function name, function param warnings
Date: Sat, 15 Nov 2025 14:45:33 -0800
Message-ID: <20251115224534.3832145-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add description for the function parameter @vaddr.
Correct the function name in a kernel-doc comment.

Fixes these warning:
WARNING: drivers/virtio/virtio_ring.c:3174 function parameter 'vaddr' not
 described in 'virtqueue_map_free_coherent'
WARNING: drivers/virtio/virtio_ring.c:3308 expecting prototype for
 virtqueue_mapping_error(). Prototype was for virtqueue_map_mapping_error()
 instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Eugenio Pérez <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/virtio/virtio_ring.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20251114.orig/drivers/virtio/virtio_ring.c
+++ linux-next-20251114/drivers/virtio/virtio_ring.c
@@ -3166,6 +3166,7 @@ EXPORT_SYMBOL_GPL(virtqueue_map_alloc_co
  * @vdev: the virtio device we are talking to
  * @map: metadata for performing mapping
  * @size: the size of the buffer
+ * @vaddr: virtual address of the buffer
  * @map_handle: the mapped address that needs to be freed
  *
  */
@@ -3299,7 +3300,7 @@ void virtqueue_unmap_single_attrs(const
 EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
 
 /**
- * virtqueue_mapping_error - check dma address
+ * virtqueue_map_mapping_error - check dma address
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  *
