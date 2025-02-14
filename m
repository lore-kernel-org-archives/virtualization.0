Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5826771B
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546269; cv=none; b=jwmNNUONfGw/A02UE+gMj7gNdNIaEmji1XOGz3BpADAHrlPS0Z0uYlV8+rtVIA4QAxqr8rbeLi3L7LQLHJiETikd0X4EsMT54Pwu8SAovCBcM+pgAu1in6P2WVQNzEREzByOzl1hQ2zBvs9tKLGVZ+ohat40QAZUUpVGm4H+Fbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546269; c=relaxed/simple;
	bh=bFNAeiutqaKlzP1FD1cFK1Z9ZYhJkQlnMXqcmyttT0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pkhMcRrUpY+3je9+E01rwFNvs4iHBjR2PQ19e0zKHaTOKFEtd6Eh6fHsEWeo/H38rJH3yua5C99wzcGtGdCSX1W2ag4I6Y5LCvafq/PGDwDxM2c7lxriPWsq6Brhpp9yCD1xoie0z4HxfCuOy6POkZ2YKGQ5ocwnQY1uJmExo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bePewpOe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bePewpOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739546267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70XUhg1h3eaHyrcsKI0iPpsHIUl4Ui2L6Ps666PmFIk=;
	b=bePewpOe2QazhZTaQO8QXj4Zoan+rhliabtljKqiCNoa1RbSHzkboe05cZNqaz/qYms3qs
	O8kaSccnKxit0DvMZzyLqSrSd8hiu4jNds1C9iZpxSR9N/HXP96SfWMxsq2qXFuJpFGEMo
	NWOjS56QpGaJsY0UjP7L2/8rrvp4Aok=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-8wcthZH6NKqoVpfwU0TUpA-1; Fri,
 14 Feb 2025 10:17:43 -0500
X-MC-Unique: 8wcthZH6NKqoVpfwU0TUpA-1
X-Mimecast-MFC-AGG-ID: 8wcthZH6NKqoVpfwU0TUpA_1739546261
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61C631955F28;
	Fri, 14 Feb 2025 15:17:41 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.45.225.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 637C819373C4;
	Fri, 14 Feb 2025 15:17:35 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 14 Feb 2025 16:16:58 +0100
Subject: [PATCH RFC v2 4/5] virtio-mmio: read shm region page size
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-virtio-shm-page-size-v2-4-aa1619e6908b@redhat.com>
References: <20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com>
In-Reply-To: <20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2084; i=slp@redhat.com;
 h=from:subject:message-id; bh=bFNAeiutqaKlzP1FD1cFK1Z9ZYhJkQlnMXqcmyttT0U=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBnr15vpsuLOT4QGRMWMhOlh38UgELGNfZ10v1z9
 7t1WHXIhlmJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ69ebwAKCRD0aSeNLwwC
 NShRD/0euxKei/j8TGZULeworXe/uhUTALV4XHBFlpYT9nZtUDghsMKu0ELFUbSvmX/PydQPyBK
 MxRu0qTEcSd7gNnNRNwxdOFSAbGtYLPJfSjnkU+0HLJrX2Dp/zrDYlogJ4QaKhPgYAylfYv3+B0
 if9t7wq8vXf9oa5bWgKt8Ihc2JRS93R8N8kD7j2QJ7eskFiuXyFViaCUGEDgpejov8hsGXVQaz1
 WPBf2vEmgL9q/jOyRNd22AGUitAu8F1Z09lO6+KTlkNbM7FLi32gayd6ll8OPjP5EuN41H2dq6U
 vYeLI0Rw+8WpS+4RXAVsAetyiqC6qTuorAn36Y8Hu8T84YqOnHfr3z4rphxHyTQT8tNvYd2yu83
 6bfVFDIfJZoZhHDzinIk0PBWkggStpR7NHPswEvK7OZva3V6ntHYWLwD9WNVsXOULf95Whcoclu
 SykvVezLdDgVLAZdXSR+weC3EV6XUgLOhohZe8tyMhLR/LQcew75/mxnQ+oiiVIZaPNFWP7nSQ0
 wN3OI3r5mFCFzf2rqaTduUYwUk5nBFNbqKle7KsqGn8xOjeX7Bhksrb+sBlNKKMnbZ+slSOuUH/
 0c1BG2XCZ/JJZ79C0DxNh3gfIjF92x+TA2KtVrW9ZRYwoaBasQ2/4lzxYwksdiZ0P5+nUlWh5C9
 NzJam9SWZ4kmtLw==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Use the newly introduced SHM_PAGE_SHIFT register to read the page shift
for the shared memory region, derive the page size from it and store the
resulting value into virtio_shm_region.

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

