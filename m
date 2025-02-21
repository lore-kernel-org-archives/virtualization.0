Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2C24C681
	for <virtualization@lists.linux.dev>; Fri, 21 Feb 2025 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157622; cv=none; b=sjXYiHyDrKsiiVsLa/g0w28jK2MZ6P2G7Uki17xr/hvE7YHrvo9wi2f4p1igHRncZcH42UhpAWK07oeHFC93sNkuH+YVCFKF3YzFveRSxc0ssxI0oDoxRYQQOoTOUvT2zZxmGxYJDBlo8WsesRlMLSQcM7yIO+iMknNSRAwgNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157622; c=relaxed/simple;
	bh=R2pHPtQbZxMeE8vsZFIHnNQdPLF23xfHO+AwC7CTpog=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fo7a3tMzyOi5MihD5mqZ6XQuUohfRKQSJVHTeiketNT5C3PD39G+ryIehZMDocGURKJu8KX3KTUm/bXgaF5eK2VIhQBn/vPjh+f5oZMqgOuXrklAO6InaWuTskxtworcEJxAgWRL77OdjvjG9grNTinB2dhEtaps4iRXQj8HXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LN9EzxvJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LN9EzxvJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740157620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKpHdC3+C0gWAiFeQvQHPEenqVM4VXEfdc+nfLPbzg4=;
	b=LN9EzxvJPQ9ROJ/S+6Iul6/pQADYPSkfhtU4eny38i78gJyvpHsXhPNI15piDWt//Bf9gy
	hCWNHmm1EJgmtvaIHs9aw+vocawmVsHFz06ufByuMyQ1Nm4Ts8fqhufxxU4wNf3WYhCSpG
	al8sz87ToczgC1vXNxfklKlbxlRQqg8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-qeDPwVdyNaiNa6U3es7YEw-1; Fri,
 21 Feb 2025 12:06:53 -0500
X-MC-Unique: qeDPwVdyNaiNa6U3es7YEw-1
X-Mimecast-MFC-AGG-ID: qeDPwVdyNaiNa6U3es7YEw_1740157612
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7C9C190F9E9;
	Fri, 21 Feb 2025 17:06:51 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB4711800941;
	Fri, 21 Feb 2025 17:06:46 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	linux-kernel@vger.kernel.org,
	German Maglione <gmaglione@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	yama@redhat.com,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>
Subject: [RFC v2 3/5] virtio_ring: add api for premapped out and in buffer chain
Date: Fri, 21 Feb 2025 18:06:24 +0100
Message-ID: <20250221170626.261687-4-eperezma@redhat.com>
In-Reply-To: <20250221170626.261687-1-eperezma@redhat.com>
References: <20250221170626.261687-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 3ef66af31fea ("virtio_ring: introduce add api for premapped")
add functions to add premapped input or output chains to a virtqueue.
Add a generic one that supports out+in buffers chains.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/virtio/virtio_ring.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fdd2d2b07b5a..7ef1f37e025f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2318,6 +2318,41 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
 
+/**
+ * virtqueue_add_sgs_premapped - expose buffers to other end
+ * @_vq: the struct virtqueue we're talking about.
+ * @sgs: array of terminated scatterlists.
+ * @out_sgs: the number of scatterlists readable by other side
+ * @in_sgs: the number of scatterlists which are writable (after readable ones)
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_sgs_premapped(struct virtqueue *_vq,
+				struct scatterlist *sgs[],
+				unsigned int out_sgs,
+				unsigned int in_sgs,
+				void *data,
+				gfp_t gfp)
+{
+	unsigned int i, total_sg = 0;
+
+	/* Count them first. */
+	for (i = 0; i < out_sgs + in_sgs; i++) {
+		struct scatterlist *sg;
+
+		for (sg = sgs[i]; sg; sg = sg_next(sg))
+			total_sg++;
+	}
+	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
+			     data, NULL, true, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_sgs_premapped);
+
 /**
  * virtqueue_add_outbuf - expose output buffers to other end
  * @vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4d16c13d0df5..7f61f66ddaa2 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -74,6 +74,13 @@ int virtqueue_add_sgs(struct virtqueue *vq,
 		      void *data,
 		      gfp_t gfp);
 
+int virtqueue_add_sgs_premapped(struct virtqueue *vq,
+				struct scatterlist *sgs[],
+				unsigned int out_sgs,
+				unsigned int in_sgs,
+				void *data,
+				gfp_t gfp);
+
 struct device *virtqueue_dma_dev(struct virtqueue *vq);
 
 bool virtqueue_kick(struct virtqueue *vq);
-- 
2.48.1

