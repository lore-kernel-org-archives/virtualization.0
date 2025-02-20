Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6CE1FECCE
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061808; cv=none; b=T/J5pKYJUV5gHNGLMitEEnTxZpA6Yo5eqhsc8EDWdJ42onYDFLWlF9EIG2LD26QpUcU8Lk824RMpe+VMgspycMiaasFypywWkm+VpeA/iMfL+GplJqX4RnG6dih6qShsMDZFm0fW4EhzO60FrBegc2eAQZdoxJFzOd0u6ID61v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061808; c=relaxed/simple;
	bh=HI9Yq5I4O39ewz8THclJRiNmMRL0UMmWH7PQ7qSDiQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sl5tS5hXdbd1hhfhnJnG+i+Stk/EV+FPwhz3g1ApjeoYNsxk+Uc2BAR9adJoejdp+KMnuQ8eumZ9MsNDB+GkLw5yqXfCx7tIBr2rjpWiNE9qOvKug1rP6FODWYvfmdB1sFrPguFZ8QQXzL7wkzI759+56lxkjs1Y4BjmGs6NCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtXf6Gbm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtXf6Gbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740061805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdC/IAoeSMLIQ4OUOk35zjurJj/IxmY0a02LUnio0io=;
	b=WtXf6GbmfyWuTAyGkNCzPv2F8Z+5eg6RYtg92xBsCzW3NQjXMbMu7PhkVYCf4kO23l6bhP
	fLd+EdAaARelTTxvgFIZmaDyUgaitQv6t6JuIKxvW21jwnBpMAkDw+FgxQrpJCJjM0uwcF
	3U70wmjufN4o7pGhfPdoiMqIOhG6YP4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-cpfN9vOrNfWVMVOLG4BHFw-1; Thu,
 20 Feb 2025 09:30:04 -0500
X-MC-Unique: cpfN9vOrNfWVMVOLG4BHFw-1
X-Mimecast-MFC-AGG-ID: cpfN9vOrNfWVMVOLG4BHFw_1740061802
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C019180087E;
	Thu, 20 Feb 2025 14:30:02 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.45.225.137])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91770180034D;
	Thu, 20 Feb 2025 14:29:55 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 20 Feb 2025 15:28:52 +0100
Subject: [PATCH RFC v3 3/4] virtio-mmio: read shm region page size
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-virtio-shm-page-size-v3-3-874fff6f3979@redhat.com>
References: <20250220-virtio-shm-page-size-v3-0-874fff6f3979@redhat.com>
In-Reply-To: <20250220-virtio-shm-page-size-v3-0-874fff6f3979@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Sergio Lopez <slp@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146; i=slp@redhat.com;
 h=from:subject:message-id; bh=HI9Yq5I4O39ewz8THclJRiNmMRL0UMmWH7PQ7qSDiQU=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBntzxKYgKPqmR77A3KduYsn47cHdfHzt2CfCFH1
 NDFL8L7YAyJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ7c8SgAKCRD0aSeNLwwC
 Nb8tD/9s45gxTwPddTHpHmXpSK/30m7AnNkqU9wxKZCfSGivH8PGfzo7V/RkAbWnoCFBLADk+LL
 dBZsx5onK4HDQIOEqYryzQFkIHKcSdZsCSuaLX7llc+6yZkpLVLhbGnasdD+La8+gshbF8AmJek
 EImP7BsDJLpk3O9ntXYQF45mSMm+17Sq1qPn0YWDVruXFw1JIiTkJU3agPJ9xCbE7xPnbiWl+vs
 F2urZR4xgoargHBBnkunp+MoOtmKwYRgapxLtrImADzn3zwurOBtAswq0Hs4vv2ALcggICNaNjw
 UvLBeZqyicVmdisMvFvwwL4GXRaj+j7PqNImmWtZ8AFuXaLBOXpgzw1HNyJaQ9aDP4/VDEJ+0Hg
 MtaYF1FJ/VNmnt9fzBXgu4D85DpNddaFAmnQnqCXRh1AOHsu9gfU6pQM6H24RQMob8vCmj0TBVm
 lwRyK48K4sK0wVz4RuqnSYycQY9vQzZ5KxGcuGV5BL82TR3R8+2FFCYo1txTP+sHJO7WKXuAavt
 YCEf+F9YBNvxG1bR17xYp9ZTH2ib153g1cu8oaE+wQDTyt0/eC0jKb8TBk5DkR634ysox+eaEKi
 nCy9rtRDcvAijO3WhEl/BtyHorc21Dau+m+xaaYn4jFF3a9TqyW0BHtxdl68La2zGxO+rO1Te4J
 R+28J+ArAYuLnMA==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Use the newly introduced SHM_PAGE_SHIFT register to read the page shift
for the shared memory region, derive the page size from it and store the
resulting value into virtio_shm_region.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/virtio/virtio_mmio.c     | 11 ++++++++++-
 include/uapi/linux/virtio_mmio.h |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 1f594b626d7a7734e8ec58766737a118c26bad94..0f892770739ea84b3e7be5615332773049b10ab1 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -537,6 +537,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
 			      struct virtio_shm_region *region, u8 id)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	u8 page_shift = 0;
 	u64 len, addr;
 
 	/* Select the region we're interested in */
@@ -560,7 +561,15 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
 
 	region->addr = addr;
 
-	region->page_size = 4096;
+	/* If supported by the device transport, read the region page size.
+	 * The page_shift variable is initialized to zero above, so if this
+	 * feature isn't supported it will result in a page_size of 4096, a
+	 * default safe value.
+	 */
+	if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE))
+		page_shift = (u8) readl(vm_dev->base + VIRTIO_MMIO_SHM_PAGE_SHIFT);
+
+	region->page_size = 1 << (page_shift + 12);
 
 	return true;
 }
diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
index 0650f91bea6c70f935764070d825d181a2379afb..43348be30eff90ee228b6490b9d3c35ba4c50aa5 100644
--- a/include/uapi/linux/virtio_mmio.h
+++ b/include/uapi/linux/virtio_mmio.h
@@ -133,6 +133,9 @@
 #define VIRTIO_MMIO_SHM_BASE_LOW        0x0b8
 #define VIRTIO_MMIO_SHM_BASE_HIGH       0x0bc
 
+/* Shared memory region page shift */
+#define VIRTIO_MMIO_SHM_PAGE_SHIFT      0x0c4
+
 /* Configuration atomicity value */
 #define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
 

-- 
2.48.1

