Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FB1CCEF9
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350089; cv=none; b=kqN/VMFnzWJsoR+EOBljw+3/fSQZMvgZsJiQLAkL1pBu4sbnfpzeWCw1n5APsB17w1PNL1nBSyFD7Za+/bUE7bx+M5GHHRIYhiKnj8NkX6m6xhDyYIu7zT+yWkTxFvhARTQQz5GYe4kPi+RsXOC2F3PDLHoKfPVYCirYO0a7I3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350089; c=relaxed/simple;
	bh=s4rDXcPwuc6qxX4cx33h6vqmV7j0rO+bTVklqLv85bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoFOW9f5bgb51JxweSxLk1mxEfc4IJ6L+/j3rK5jbxiO5bm1htgU1RdRIGhaIvY4R6O/+UaAg1CFtrvxJknT7O091bLfMziIvE//b9vXvz1dfo8p7qY1YXjgzesfdlucK8/qFhk76bUi7wfIMBDOxwc/V2vlXibecT4AKm+FR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CwLGqz8q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwLGqz8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725350086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMz8Bmz9K6BETtasWKV8Y0O1GLHRAqizhsVEmWP+wGM=;
	b=CwLGqz8qHclXjMgGa190gBu7rwv5tStIk4Iw/1DrUUUWYAkP5QhT9Qh0IBEHJq9+WSj3Pc
	6oWhaYquRNbk/TYwxBdVxHwScWBHxTPAN9yXpqwhErxtEuOqdX6iIy0E196Ei8wcdzfVOq
	5yqHz0idVmuJBcLkFh525ByYG7LRmZI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-Sjq94ZiINSuyOCgYdFoiig-1; Tue,
 03 Sep 2024 03:54:43 -0400
X-MC-Unique: Sjq94ZiINSuyOCgYdFoiig-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B239519560B1;
	Tue,  3 Sep 2024 07:54:41 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.228])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A38830001A4;
	Tue,  3 Sep 2024 07:54:38 +0000 (UTC)
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
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v2 2/2] drm/virtio: Add support for XRGB8888 and BGRX8888
Date: Tue,  3 Sep 2024 09:48:27 +0200
Message-ID: <20240903075414.297622-2-jfalempe@redhat.com>
In-Reply-To: <20240903075414.297622-1-jfalempe@redhat.com>
References: <20240903075414.297622-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

On big endian machine, fbdev wants BGRX8888, but gnome/wayland wants
XRGB8888, which wasn't possible because virtio-gpu could only support
one format. Now that it's fixed, it can support both.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 6 ++++--
 drivers/gpu/drm/virtio/virtgpu_plane.c   | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 5e8ca742c6d00..b94d16134b8cf 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -325,8 +325,10 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	struct virtio_gpu_object *bo;
 	int ret;
 
-	if (mode_cmd->pixel_format != DRM_FORMAT_HOST_XRGB8888 &&
-	    mode_cmd->pixel_format != DRM_FORMAT_HOST_ARGB8888)
+	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888 &&
+	    mode_cmd->pixel_format != DRM_FORMAT_ARGB8888 &&
+	    mode_cmd->pixel_format != DRM_FORMAT_BGRX8888 &&
+	    mode_cmd->pixel_format != DRM_FORMAT_BGRA8888)
 		return ERR_PTR(-ENOENT);
 
 	/* lookup object associated with res handle */
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a72a2dbda031c..32fbe30b45a46 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -30,11 +30,13 @@
 #include "virtgpu_drv.h"
 
 static const uint32_t virtio_gpu_formats[] = {
-	DRM_FORMAT_HOST_XRGB8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_BGRX8888,
 };
 
 static const uint32_t virtio_gpu_cursor_formats[] = {
-	DRM_FORMAT_HOST_ARGB8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_BGRA8888,
 };
 
 uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
-- 
2.46.0

