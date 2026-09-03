Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3E3CF1E7
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470373; cv=none; b=j8vYaX4LzWk60TbMQXxWL3XjaWZJEc0bX4T8VMT7PCA4NkdmdzTc2OJ6duMxv0LNkBf6QuK1d7yi6aKVyv1Xo/SGxe4whuVxDUV3i8uwZ1xoaVAR7NEeJ/rJWe7CDk+lJPal48SNE5ERQkmj8QMF8V3qqVQnH894j9bHbjLtWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470373; c=relaxed/simple;
	bh=REy89PXGUMAwBFAst7loyqllkqdZtkEQu0QGt9d0S1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dKxk8kkfAA9LDHBgyTDyQ8XFYjmdnJflnBcyV0zaXgONBz7s1TJRvlLTZnr79tGdRWY3nGHMwEYTvAIS1Xf0+KK8wg/tdZnz7nP0a1BT7JoModinO5R5IldF7Y6Y7ByDD9d6dslizvOUsHmTLrCQ3mMn6b2fIC2M/XuicoplDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXPKLtDF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXPKLtDF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788470366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6wdYDVz/iY+alwXjGKwrS1eyvjuEX5rquxAFWMQOOc=;
	b=VXPKLtDFewWG3Mi+fv80nENQ1ne8Ztu2HIy9hQGHjXjbDKHH4VqkZvQlW4IY7QDAlBGtvx
	o7em9ydop4Ok5m8KxfXdYGbOixJjSmgb66GIBXLMvdsmvAoeraoqpiJttjUOIGdrQgNEMH
	f2PUwOeFWAfuZEDQPF+N1IJ+0D5k4RI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-tButmvDpNsmYRZS04qoxDQ-1; Thu,
 03 Sep 2026 17:19:22 -0400
X-MC-Unique: tButmvDpNsmYRZS04qoxDQ-1
X-Mimecast-MFC-AGG-ID: tButmvDpNsmYRZS04qoxDQ_1788470361
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DD4E185FDA2;
	Thu,  3 Sep 2026 21:19:21 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.64.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C8DD1955F70;
	Thu,  3 Sep 2026 21:19:18 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@lists.freedesktop.org
Cc: Christian Hergert <christian@sourceandstack.com>,
	"Dmitry Osipenko" <dmitry.osipenko@collabora.com>,
	"David Airlie" <airlied@redhat.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	"Simona Vetter" <simona@ffwll.ch>,
	"Gerd Hoffmann" <kraxel@redhat.com>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 1/2] drm/virtio: preserve damage clips for rendered resources
Date: Thu,  3 Sep 2026 17:15:51 -0400
Message-ID: <20260903211914.1109100-2-lyude@redhat.com>
In-Reply-To: <20260903211914.1109100-1-lyude@redhat.com>
References: <20260903211914.1109100-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: mQytIMhecf9PJpTAYeZA_jwQqPFpQBXh2QKqj6MDPQw_1788470361
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Christian Hergert <christian@sourceandstack.com>

virtio_gpu_plane_atomic_check() unconditionally ignores FB_DAMAGE_CLIPS
when the framebuffer changes. This forces a full resource flush on every
page flip when a compositor rotates through multiple framebuffers, even
when userspace supplies accumulated per-buffer damage.

The full update is required for dumb buffers because their contents are
uploaded per buffer. Rendered resources are already coherent on the host,
so replacing their damage with the full plane only discards useful
information.

Restrict ignore_damage_clips to dumb buffers. This allows damage-aware
compositors to propagate partial updates through RESOURCE_FLUSH while
preserving the existing full-upload behavior for dumb buffers.

Signed-off-by: Christian Hergert <christian@sourceandstack.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 1d1b27ece62a7..d9579a4b4714c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -103,6 +103,7 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 										 plane);
 	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
 										 plane);
+	struct virtio_gpu_object *bo;
 	bool is_cursor = plane->type == DRM_PLANE_TYPE_CURSOR;
 	struct drm_crtc_state *crtc_state;
 	int ret;
@@ -113,9 +114,12 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 	/*
 	 * Ignore damage clips if the framebuffer attached to the plane's state
 	 * has changed since the last plane update (page-flip). In this case, a
-	 * full plane update should happen because uploads are done per-buffer.
+	 * full plane update should happen for dumb buffers because uploads are
+	 * done per-buffer. Rendered resources are already coherent on the host,
+	 * so preserve userspace's accumulated per-buffer damage for those.
 	 */
-	if (old_plane_state->fb != new_plane_state->fb)
+	bo = gem_to_virtio_gpu_obj(new_plane_state->fb->obj[0]);
+	if (old_plane_state->fb != new_plane_state->fb && bo->dumb)
 		new_plane_state->ignore_damage_clips = true;
 
 	crtc_state = drm_atomic_get_crtc_state(state,
-- 
2.55.0

