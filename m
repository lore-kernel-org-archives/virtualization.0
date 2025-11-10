Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC230F939
	for <virtualization@lists.linux.dev>; Mon, 10 Nov 2025 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779169; cv=none; b=XeFsSGeeeVfFfPnyfrCvVhPFrlZuplwdjbAnv0FWm77FasbRYCYI+e0R2eFrMJuMLkzfJ1NeWZV8VL/0udtCBhbkUP2DIeVSkyp9CH55WY3cYW6W5c0u2vi5FMobEkdfua7SEMerxsAN4QwcIv9JzZ9zoF35CLWwMT/YNhnmIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779169; c=relaxed/simple;
	bh=1Z7oep0jfRz17U7/DTdj2irH4BdMbaTIFTk8Q0+Fziw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dag+2qvYy4xIk7jS+H/dH2RPh9lzH4qveq7I7sywegzS5zcE21J7VtmVfDVjc0h2jcHwpE8w1hIMunkmAWFpxZP2MaJvjzmXGi+M6/+DtlBDnYNvHpLMtQRY2oPyROqO96N5Cq32iQJUbhZQOWhd/LmGDgmyqRTzg+CClL/+D4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVCq0OuU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVCq0OuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762779166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKsIDGP2A6MVPtV5Pql3fmpnvf+qSOjFLDwKwKmalio=;
	b=FVCq0OuUJZPride37Q5XjfyDkG3MKvV4FxZ+DvRB3zp0BhG3+lOcMYLSGRKU7l79a0P0aI
	h556ieni51QJdYTcziuMZssIKL2Gey2wPdMQNd3OdfaTSBidEssO56X8zrvTuksGDpfpZ/
	O3C1CEWTYVqkK39o54IkLS1IAq0DLwM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-Qb9ZmxY6Muq1JJPQhs2AsA-1; Mon,
 10 Nov 2025 07:52:42 -0500
X-MC-Unique: Qb9ZmxY6Muq1JJPQhs2AsA-1
X-Mimecast-MFC-AGG-ID: Qb9ZmxY6Muq1JJPQhs2AsA_1762779161
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE24519560B2;
	Mon, 10 Nov 2025 12:52:40 +0000 (UTC)
Received: from slp-asahi.redhat.com (unknown [10.44.32.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA85F30001B9;
	Mon, 10 Nov 2025 12:52:34 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Sergio Lopez <slp@redhat.com>
Subject: [PATCH 3/3] drm/virtio: add VIRTGPU_PARAM_BLOB_ALIGNMENT to params
Date: Mon, 10 Nov 2025 13:52:13 +0100
Message-ID: <20251110125213.12633-4-slp@redhat.com>
In-Reply-To: <20251110125213.12633-1-slp@redhat.com>
References: <20251110125213.12633-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add VIRTGPU_PARAM_BLOB_ALIGNMENT as a param that can be read with
VIRTGPU_GETPARAM by userspace applications running in the guest to
obtain the host's page size and find out the right alignment to be used
in shared memory allocations.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
 include/uapi/drm/virtgpu_drm.h         | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index c33c057365f8..b7651f504f00 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -117,6 +117,11 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 	case VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME:
 		value = vgdev->has_context_init ? 1 : 0;
 		break;
+	case VIRTGPU_PARAM_BLOB_ALIGNMENT:
+		if (!vgdev->has_blob_alignment)
+			return -ENOENT;
+		value = vgdev->blob_alignment;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 9debb320c34b..7d4e4884d942 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -98,6 +98,7 @@ struct drm_virtgpu_execbuffer {
 #define VIRTGPU_PARAM_CONTEXT_INIT 6 /* DRM_VIRTGPU_CONTEXT_INIT */
 #define VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs 7 /* Bitmask of supported capability set ids */
 #define VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME 8 /* Ability to set debug name from userspace */
+#define VIRTGPU_PARAM_BLOB_ALIGNMENT 9 /* Device alignment requirements for blobs */
 
 struct drm_virtgpu_getparam {
 	__u64 param;
-- 
2.51.0

