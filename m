Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65FD12C487
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347614; cv=none; b=lbNi7m0z6dnTrAHED/HL/Ldn2kfLuj2edyC0oy20TJV3FNvTrQfBXUWc+o9lVLYBlzJnAhOwGJ5Ab+NpmtqHUGiPlW70aHWGEmRWL5PIFnt4bGkIYzZAJHnKCQMBr92+mH2ZZL22lmDuNQx8IsdQt4yWo2rvg40vAd7f8A8OZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347614; c=relaxed/simple;
	bh=DQTcuRJ6jV+KHtqCB34fEC2WDqRthotEQh0eyz/EF8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3RpETetztT0yMdRZ/EE+Pv7866si1kgKaXQh17hjX068WT59UQZ5hGDZ7jse0YbB2MeusxG1DosDpVDDoVuTEy8kpStVwC5L3qIVUJqUF/dUM/NfdUDdxwj42YSBfP5yWuWKNJipGlR7PAZId8claUnRvLi6OLK9gSukxyYi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUHyJHGI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUHyJHGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715347613; x=1746883613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQTcuRJ6jV+KHtqCB34fEC2WDqRthotEQh0eyz/EF8M=;
  b=TUHyJHGIwaniR3nxAIbzEs5GzQ3UggRRrcNeHGFXoNx6/iPRUfc7kD2E
   Ui8UbhUEyG8EqtSkmWjXR8GfOXx++A27B+iPjuS09xn2VftYCQZKYgX1X
   e6s0KjBeBWuvaAEGq0cV/FkRH1al0Nn4gvWpeMoNF/Udda1bDVYvVdxn8
   YUD6fY08530PrA6bAV/cT1wj4Blsh5SAZToOGI3YHJuUQeAyUhFAHky1x
   787kDnmvPpqKsIds+SH08HFC6vM9/pO0M6UbTnWzQJrqby2b7kF/hObLX
   qWQzDH28/EO4ALoASfRhb97M0ZgMbSe80MfMLfRcrrJ4E6ZE3oF7ChOh+
   g==;
X-CSE-ConnectionGUID: 5l3kj/jzSWqjjFS+Rrk0GQ==
X-CSE-MsgGUID: U+pFaPaoTbiih3TPyqXGrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11489601"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11489601"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:26:52 -0700
X-CSE-ConnectionGUID: G6i9VGmWQdWNsv+qrGnAxg==
X-CSE-MsgGUID: H/U/M+ufSq6ZU5gbYQ8jUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67089443"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:26:49 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	virtualization@lists.linux.dev
Subject: [RESEND 6/6] drm/virtio: switch to struct drm_edid
Date: Fri, 10 May 2024 16:26:09 +0300
Message-Id: <ed6e76a9e94816789ca9caf8775d6a6156877496.1715347488.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1715347488.git.jani.nikula@intel.com>
References: <cover.1715347488.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Prefer struct drm_edid based functions over struct edid.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

Cc: David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 10 ++++------
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c      | 12 ++++++------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index ad924a8502e9..64baf2f22d9f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -164,11 +164,9 @@ static int virtio_gpu_conn_get_modes(struct drm_connector *connector)
 	struct drm_display_mode *mode = NULL;
 	int count, width, height;
 
-	if (output->edid) {
-		count = drm_add_edid_modes(connector, output->edid);
-		if (count)
-			return count;
-	}
+	count = drm_edid_connector_add_modes(connector);
+	if (count)
+		return count;
 
 	width  = le32_to_cpu(output->info.r.width);
 	height = le32_to_cpu(output->info.r.height);
@@ -369,5 +367,5 @@ void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
 		return;
 
 	for (i = 0 ; i < vgdev->num_scanouts; ++i)
-		kfree(vgdev->outputs[i].edid);
+		drm_edid_free(vgdev->outputs[i].drm_edid);
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index bb7d86a0c6a1..64c236169db8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -179,7 +179,7 @@ struct virtio_gpu_output {
 	struct drm_encoder enc;
 	struct virtio_gpu_display_one info;
 	struct virtio_gpu_update_cursor cursor;
-	struct edid *edid;
+	const struct drm_edid *drm_edid;
 	int cur_x;
 	int cur_y;
 	bool needs_modeset;
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index b1a00c0c25a7..0d3d0d09f39b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -741,21 +741,21 @@ static void virtio_gpu_cmd_get_edid_cb(struct virtio_gpu_device *vgdev,
 		(struct virtio_gpu_resp_edid *)vbuf->resp_buf;
 	uint32_t scanout = le32_to_cpu(cmd->scanout);
 	struct virtio_gpu_output *output;
-	struct edid *new_edid, *old_edid;
+	const struct drm_edid *new_edid, *old_edid;
 
 	if (scanout >= vgdev->num_scanouts)
 		return;
 	output = vgdev->outputs + scanout;
 
-	new_edid = drm_do_get_edid(&output->conn, virtio_get_edid_block, resp);
-	drm_connector_update_edid_property(&output->conn, new_edid);
+	new_edid = drm_edid_read_custom(&output->conn, virtio_get_edid_block, resp);
+	drm_edid_connector_update(&output->conn, new_edid);
 
 	spin_lock(&vgdev->display_info_lock);
-	old_edid = output->edid;
-	output->edid = new_edid;
+	old_edid = output->drm_edid;
+	output->drm_edid = new_edid;
 	spin_unlock(&vgdev->display_info_lock);
 
-	kfree(old_edid);
+	drm_edid_free(old_edid);
 	wake_up(&vgdev->resp_wq);
 }
 
-- 
2.39.2

