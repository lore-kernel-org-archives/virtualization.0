Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C81F610
	for <virtualization@lists.linux-foundation.org>; Sat, 27 Jan 2024 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706396105; cv=none; b=QmVQUgKQG8RNEv4AMXV2kz7TunKG9ZkiMqg7xuDyNCIYg3KwmjlD9IfPORpej2kvvdIYsY/984qvy0l6KFoFNB2qMe9KgSbhHhjodEWZ/FcAPMlUcINj+Z4HA2h6mTw9l82u2m7QNLm6Go/XWWXhOQLXP3voplM3aP9SdvpIWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706396105; c=relaxed/simple;
	bh=vLZCdNFQJnOQTttc+EZzhjcVTLGWZOHDENswMgg+bgQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RKO4EarL4wGcVrRjEsQ9dVq9wXApwDQyYPRc4tl897ZHEWgE2+VubPabNe9u//+oKT6zVF+50G6SKDWzNEuxAUcREK4hhHZ+cuJjPyg6e0sbmu1gyuy9NUUhfT37iOTZey6wjA5lfI3pDWT39v8HbbfkDAHn79jgZ3Baz0TQnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sO4kskzv; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sO4kskzv"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E5F84176D
	for <virtualization@lists.linux-foundation.org>; Sat, 27 Jan 2024 22:55:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E5F84176D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sO4kskzv
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tPm8Wru79nyq
	for <virtualization@lists.linux-foundation.org>;
	Sat, 27 Jan 2024 22:55:02 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3EC754176A
	for <virtualization@lists.linux-foundation.org>; Sat, 27 Jan 2024 22:55:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EC754176A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EBCF561383;
	Sat, 27 Jan 2024 22:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896C0C433F1;
	Sat, 27 Jan 2024 22:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706396100;
	bh=vLZCdNFQJnOQTttc+EZzhjcVTLGWZOHDENswMgg+bgQ=;
	h=Subject:To:Cc:From:Date:From;
	b=sO4kskzv1mbyCuTmdwwQvT3+wL/0d0/JHr0fcnbFKBgBk/tnGp5zSXbbgyaJEuyo7
	 6Xnp6viu1c6FqBsq7Cej8SdgpSsNSvaZq2RY09nLAgR16zfvq3ckIBSCjey2pDRDJF
	 QczIsLSK+eazbSJfeitmrdyOX30kgId6rVyMfwF8=
Subject: Patch "drm: Disable the cursor plane on atomic contexts with virtualized drivers" has been added to the 6.6-stable tree
To: airlied@linux.ie,airlied@redhat.com,contact@emersion.fr,daniel@ffwll.ch,dri-devel@lists.freedesktop.org,gregkh@linuxfoundation.org,gurchetansingh@chromium.org,hdegoede@redhat.com,javierm@redhat.com,kraxel@redhat.com,maarten.lankhorst@linux.intel.com,mripard@kernel.org,olvaffe@gmail.com,pekka.paalanen@collabora.com,spice-devel@lists.freedesktop.org,tzimmermann@suse.de,virtualization@lists.linux-foundation.org,zackr@vmware.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:54:58 -0800
Message-ID: <2024012758-blend-luminous-46d4@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    drm: Disable the cursor plane on atomic contexts with virtualized drivers

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-disable-the-cursor-plane-on-atomic-contexts-with-virtualized-drivers.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 4e3b70da64a53784683cfcbac2deda5d6e540407 Mon Sep 17 00:00:00 2001
From: Zack Rusin <zackr@vmware.com>
Date: Mon, 23 Oct 2023 09:46:05 +0200
Subject: drm: Disable the cursor plane on atomic contexts with virtualized drivers

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
@@ -283,7 +283,7 @@ static const struct drm_ioctl_desc qxl_i
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
@@ -229,6 +229,18 @@ struct drm_file {
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


Patches currently in stable-queue which might be from zackr@vmware.com are

queue-6.6/drm-disable-the-cursor-plane-on-atomic-contexts-with-virtualized-drivers.patch
queue-6.6/drm-allow-drivers-to-indicate-the-damage-helpers-to-ignore-damage-clips.patch
queue-6.6/drm-virtio-disable-damage-clipping-if-fb-changed-since-last-page-flip.patch
