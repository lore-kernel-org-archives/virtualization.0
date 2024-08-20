Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71FC18A6CD
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144973; cv=none; b=IANXzQIWvbM1DXEaKvVxQgs4XH8OBtJhwqCQDK094hpVmJkBWHFbROsqc6ag3tJVLrbrvWPlHBGWmd6hrt3kzgy5hB2sY5hudZvXPvHgSxKn9VyRWp0NTKOL1G+AS8Sv9fuPM4USdv4io50sTW1Pv5ZLpsFH8SSAyC/FJL4obeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144973; c=relaxed/simple;
	bh=bJkTyS8PfMg1NE2jw8oJV3eE5W74EcFlrnjY/8VSxRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqPVJhTQI1EiKlMRZyasAA0833k2qUClBMS8GIHDOAJBL0IjkwQ2m73XRDsT9UCLPjWeJMRT6I9rmlZWQNKxRGNw/JWYe8mdlWjBeB0VbKtydowh1+NPNGHqFG8Js2nxP8NfbEiDXL8LFIHLVjQY3rl9V3G7VJNEBXF7x0tpH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqolPHKi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqolPHKi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724144969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUSPSFlfbnk2GBQn/hXYCEuTgzqE3rPm+JVguTpTv3E=;
	b=aqolPHKicFo67YsVCBCQZh/4ilboJpCP/o4oYuLdGftiPqihYUOhJeSvKftktr72M4h1vN
	32xZxoUaP5BpHODgriR8qSsBaJgR6Imcq3pAK08JKITqLDrYjQE5g0KtWqOjUtvbbhsrjv
	dMLd6Q6s10VDcEVsJgBp8j50ifS9mOw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-ZN5DTtbaMSSXzbIbgL6-eg-1; Tue,
 20 Aug 2024 05:09:25 -0400
X-MC-Unique: ZN5DTtbaMSSXzbIbgL6-eg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A4AD1955F4A;
	Tue, 20 Aug 2024 09:09:23 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 737AE1955F39;
	Tue, 20 Aug 2024 09:09:19 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 2/2] drm/virtio: Fix host color format for big endian guests
Date: Tue, 20 Aug 2024 11:07:41 +0200
Message-ID: <20240820090908.151042-2-jfalempe@redhat.com>
In-Reply-To: <20240820090908.151042-1-jfalempe@redhat.com>
References: <20240820090908.151042-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The colors are inverted when testing a s390x VM on a s390x host.
Changing the conversion from DRM_FORMAT -> VIRTIO_GPU_FORMAT on big
endian guests fixes the colors. But it may break big-endian guest on
little-endian host. In this case, the fix should be in qemu, because
the host endianess is not known in the guest VM.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Acked-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 860b5757ec3fc..0ec6ecc96eb13 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -37,16 +37,24 @@ static const uint32_t virtio_gpu_cursor_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
+#ifdef __BIG_ENDIAN
+#define VIRTIO_GPU_HOST_XRGB8888 VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM
+#define VIRTIO_GPU_HOST_ARGB8888 VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM
+#else
+#define VIRTIO_GPU_HOST_XRGB8888 VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM
+#define VIRTIO_GPU_HOST_ARGB8888 VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM
+#endif
+
 uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 {
 	uint32_t format;
 
 	switch (drm_fourcc) {
 	case DRM_FORMAT_XRGB8888:
-		format = VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM;
+		format = VIRTIO_GPU_HOST_XRGB8888;
 		break;
 	case DRM_FORMAT_ARGB8888:
-		format = VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM;
+		format = VIRTIO_GPU_HOST_ARGB8888;
 		break;
 	default:
 		/*
-- 
2.46.0

