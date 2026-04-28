Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CF347FE1
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456406; cv=none; b=ulD8Pse3HmYeMTW7dtm6BqAD6W4OfWdN/vxVtMahahW6ZEdN8VQsXUJ/OcOyHivGe6ZA9mOxW9iA9jPNhueDjWRrxxu9y7sYyepoDorXyyNPV30wzOUIPrt7IKYkX9YOZAb0ahYLVA4B7XfK77kAeDSuWAzjPvnPlqkv+4QoeLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456406; c=relaxed/simple;
	bh=/ReN6K+0yo9euoyN9evyrR42IX6RvMM/bMgT1hfvlFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UWznJl8TmLfxAqUNBG6XB9OaQO4ID13jVunwHNpK8eKSlZHVh3MSg2eDRyZS3RtTOdmdRTIxPC5d9ZY+TjjkKqKLtC4sWHE9/WyYV3tXihW1n6XCGLPSbJtg1S6iJRbI9DnCJlmnvxKUa5/cfsYyYvGSOEHDe6a/tljDKHTkY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1nNQG/P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1nNQG/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777456403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qq68cDnnkQDnhZ7FI3gXWBcfZHPGoFfOX51hOZJBhgs=;
	b=Y1nNQG/PI9cqV7qE6V+bdpfJ11b3UGC0DrI2FvyRlpQa0m0QrQA8ubTkdVp7Zq515PYvoh
	28NsT/qwqsbgXJel5yEnvJW/rHfcFhqRt4WeuiR8OubXA3hhV57LHnSVbL+ZPy1kDOQDlN
	IWuGGxcZNbGyvrRsv1vh1hWizDnN6a8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-zKQ7loXTOOy2OOTEaOvsFA-1; Wed,
 29 Apr 2026 05:53:13 -0400
X-MC-Unique: zKQ7loXTOOy2OOTEaOvsFA-1
X-Mimecast-MFC-AGG-ID: zKQ7loXTOOy2OOTEaOvsFA_1777456382
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A22F81800378;
	Wed, 29 Apr 2026 09:53:02 +0000 (UTC)
Received: from f43vm.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B47B41800349;
	Wed, 29 Apr 2026 09:52:58 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: Chia-I Wu <olvaffe@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sergio Lopez <slp@redhat.com>
Subject: [PATCH v2 3/3] drm/virtio: add VIRTGPU_PARAM_BLOB_ALIGNMENT to params
Date: Tue, 28 Apr 2026 21:44:50 +0200
Message-ID: <20260428194450.518296-4-slp@redhat.com>
In-Reply-To: <20260428194450.518296-1-slp@redhat.com>
References: <20260428194450.518296-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: w1wdayGay6Pw7m0BIOsP-UITe_KlQHTQAtLeOznRY8g_1777456382
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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
index d0c4edf1eaf4..146ff25396c2 100644
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
2.53.0

