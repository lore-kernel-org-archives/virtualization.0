Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58026158D64
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jan 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548232; cv=none; b=AbufvpV6pOR8Qy2QYKbEINNZ6d2gFRk6tMmgWT+ONSGcvLo92wyDIgMKv8NvfThZCNuRv/51xP3xyjZjVo7jitWA1imi0TtocaFSDXjt6FmsMIFMlNDHXOcUeNekk/yZODnZhIR61v4czUboh1EmEZF2vb1aa2u/duIU/7bJH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548232; c=relaxed/simple;
	bh=qA8iGN3XKJOBwwOYBy9X7jMTB+6ug6Rfjp5pHQPjwNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0Q+qGM8bonLppJTz0fWB3TryCpmnNH49PkZnAEThie12Ene96MOrBjlgQY/mz7ukqelLGTaaJt1myh3s+X2GRpOhBjNNOtN4257eTcZRT5MmQoCfVAnosvBjcOsZrmwDBN2aksktUXpAeQsBgjW0MhuxbE3X6kOQuS/p4zjGyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qfL2Adpl; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qfL2Adpl"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4740E8229E
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jan 2024 17:10:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4740E8229E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qfL2Adpl
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jUrO9ELDO8uZ
	for <virtualization@lists.linux-foundation.org>;
	Mon, 29 Jan 2024 17:10:28 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F3E682274
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jan 2024 17:10:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F3E682274
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 58C03CE10F9;
	Mon, 29 Jan 2024 17:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6C1C433F1;
	Mon, 29 Jan 2024 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548223;
	bh=qA8iGN3XKJOBwwOYBy9X7jMTB+6ug6Rfjp5pHQPjwNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfL2AdplyiBLlQef2gy7+y2wQcrEB3phyhIPLs0yDrxLkdspAkNksyTzcRj7z8C1C
	 NBJn421ZfCBpMcMSQ6wKJggfmbhEnTokMgj9/wu9+xKfgpKZ3qXLnU1ZPUskvRW4YV
	 wMjhh9qKIBK5Q2YbDELrMW8yO5TSfFacNCQJ6f54=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zack Rusin <zackr@vmware.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	spice-devel@lists.freedesktop.org,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Simon Ser <contact@emersion.fr>
Subject: [PATCH 6.7 253/346] drm: Disable the cursor plane on atomic contexts with virtualized drivers
Date: Mon, 29 Jan 2024 09:04:44 -0800
Message-ID: <20240129170023.851641380@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zack Rusin <zackr@vmware.com>

commit 4e3b70da64a53784683cfcbac2deda5d6e540407 upstream.

Cursor planes on virtualized drivers have special meaning and require
that the clients handle them in specific ways, e.g. the cursor plane
should react to the mouse movement the way a mouse cursor would be
expected to and the client is required to set hotspot properties on it
in order for the mouse events to be routed correctly.

This breaks the contract as specified by the "universal planes". Fix it
by disabling the cursor planes on virtualized drivers while adding
a foundation on top of which it's possible to special case mouse cursor
planes for clients that want it.

Disabling the cursor planes makes some kms compositors which were broken,
e.g. Weston, fallback to software cursor which works fine or at least
better than currently while having no effect on others, e.g. gnome-shell
or kwin, which put virtualized drivers on a deny-list when running in
atomic context to make them fallback to legacy kms and avoid this issue.

Signed-off-by: Zack Rusin <zackr@vmware.com>
Fixes: 681e7ec73044 ("drm: Allow userspace to ask for universal plane list (v2)")
Cc: <stable@vger.kernel.org> # v5.4+
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: virtualization@lists.linux-foundation.org
Cc: spice-devel@lists.freedesktop.org
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231023074613.41327-2-aesteve@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_plane.c          |   13 +++++++++++++
 drivers/gpu/drm/qxl/qxl_drv.c        |    2 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c |    2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c  |    2 +-
 include/drm/drm_drv.h                |    9 +++++++++
 include/drm/drm_file.h               |   12 ++++++++++++
 7 files changed, 38 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -678,6 +678,19 @@ int drm_mode_getplane_res(struct drm_dev
 		    !file_priv->universal_planes)
 			continue;
 
+		/*
+		 * If we're running on a virtualized driver then,
+		 * unless userspace advertizes support for the
+		 * virtualized cursor plane, disable cursor planes
+		 * because they'll be broken due to missing cursor
+		 * hotspot info.
+		 */
+		if (plane->type == DRM_PLANE_TYPE_CURSOR &&
+		    drm_core_check_feature(dev, DRIVER_CURSOR_HOTSPOT) &&
+		    file_priv->atomic &&
+		    !file_priv->supports_virtualized_cursor_plane)
+			continue;
+
 		if (drm_lease_held(file_priv, plane->base.id)) {
 			if (count < plane_resp->count_planes &&
 			    put_user(plane->base.id, plane_ptr + count))
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -285,7 +285,7 @@ static const struct drm_ioctl_desc qxl_i
 };
 
 static struct drm_driver qxl_driver = {
-	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_CURSOR_HOTSPOT,
 
 	.dumb_create = qxl_mode_dumb_create,
 	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
--- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -182,7 +182,7 @@ DEFINE_DRM_GEM_FOPS(vbox_fops);
 
 static const struct drm_driver driver = {
 	.driver_features =
-	    DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
+	    DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC | DRIVER_CURSOR_HOTSPOT,
 
 	.fops = &vbox_fops,
 	.name = DRIVER_NAME,
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -177,7 +177,7 @@ static const struct drm_driver driver =
 	 * out via drm_device::driver_features:
 	 */
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC |
-			   DRIVER_SYNCOBJ | DRIVER_SYNCOBJ_TIMELINE,
+			   DRIVER_SYNCOBJ | DRIVER_SYNCOBJ_TIMELINE | DRIVER_CURSOR_HOTSPOT,
 	.open = virtio_gpu_driver_open,
 	.postclose = virtio_gpu_driver_postclose,
 
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1611,7 +1611,7 @@ static const struct file_operations vmwg
 
 static const struct drm_driver driver = {
 	.driver_features =
-	DRIVER_MODESET | DRIVER_RENDER | DRIVER_ATOMIC | DRIVER_GEM,
+	DRIVER_MODESET | DRIVER_RENDER | DRIVER_ATOMIC | DRIVER_GEM | DRIVER_CURSOR_HOTSPOT,
 	.ioctls = vmw_ioctls,
 	.num_ioctls = ARRAY_SIZE(vmw_ioctls),
 	.master_set = vmw_master_set,
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -110,6 +110,15 @@ enum drm_driver_feature {
 	 * Driver supports user defined GPU VA bindings for GEM objects.
 	 */
 	DRIVER_GEM_GPUVA		= BIT(8),
+	/**
+	 * @DRIVER_CURSOR_HOTSPOT:
+	 *
+	 * Driver supports and requires cursor hotspot information in the
+	 * cursor plane (e.g. cursor plane has to actually track the mouse
+	 * cursor and the clients are required to set hotspot in order for
+	 * the cursor planes to work correctly).
+	 */
+	DRIVER_CURSOR_HOTSPOT           = BIT(9),
 
 	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
 
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -227,6 +227,18 @@ struct drm_file {
 	bool is_master;
 
 	/**
+	 * @supports_virtualized_cursor_plane:
+	 *
+	 * This client is capable of handling the cursor plane with the
+	 * restrictions imposed on it by the virtualized drivers.
+	 *
+	 * This implies that the cursor plane has to behave like a cursor
+	 * i.e. track cursor movement. It also requires setting of the
+	 * hotspot properties by the client on the cursor plane.
+	 */
+	bool supports_virtualized_cursor_plane;
+
+	/**
 	 * @master:
 	 *
 	 * Master this node is currently associated with. Protected by struct


