Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBBA1F0E56
	for <virtualization@lists.linux.dev>; Tue,  1 Apr 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511171; cv=pass; b=lhDae6WIMO6bhimwsNgSyCgYMnir9yOPQ/fSI3z5ee130ElPzmzhn2gY62SDjlTkf7kZQ8aecFLA1mC4kO4OMVoU5SUs9og11Z335sOnQiH6cNnrp3kNdvNTPsyIGJroqKbZfb6QDKmadp6ElEhxZbqAeVruqpfiSAFdCi0t4H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511171; c=relaxed/simple;
	bh=m4DDJRWD3O5j4Ifb7W9vKEAfdZ+yQZJlLz/Na0uicpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQWIrKjYA7wLDN8YauWG5vtla4+OiVSy2WMLvXmWBLaI+4wVlXA8VTQTROkQR3JqR9Vspb8bvsLepwsL4sd9c3S7iVP4yoGN/Bvb0ZDWRL5tTbxxiDZYP/fxE5gPZo5A7MAJX1ObrHcZixeMXyrs4Q/bdOtyoekPyJAO5EP363Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=MXK8HA0W; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="MXK8HA0W"
ARC-Seal: i=1; a=rsa-sha256; t=1743511153; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EBqZ5HCJCUL3CNGfTvGMAFW5hd69p2cDxYGl5C0pH5adsR2LDzbw5YlkDmk6SVCh6WG7PVSZEbxe/5ek7ByJmqtv0DOg0GVm1btZq/yOchRMinAqFRLd6R3p05OIXl/SCgaK6xgzZokiyqd95d6vhS3I9uYQYZ1bGvsLrnmCkX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743511153; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KYw/wFSISeadrIKTK5nd5AHNKKQw3bKBlfJXdtAH8jA=; 
	b=VBVO81nsev+0dtjGYe2BJr0fw8EHQPiuRRENgBm9Jdcjyh9tYOspr6Te6wm9uLXypJb3H3KKmBmKxTX6GMScNWsjHN2bo8XG3E9bYSuimhtEUblTUHSYHHD9WlXDa1kZrsuFBmQ8npneAeLmNeVTlDrpVfFMf3OVnB6R6/DEzD8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743511153;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KYw/wFSISeadrIKTK5nd5AHNKKQw3bKBlfJXdtAH8jA=;
	b=MXK8HA0Wg5L3218AA7GV7pmL8jRBBcbgd+1Cn6Tzc8iLaMNjpjs95ofCpY537bOc
	EUlg1Lm43B1GMuSGAKnYNonw8UexkLjCPen8NZpB792f+a4p7a9xSDxuddS40axV0Lx
	TDguMriWiQaXreoSs3IGS0siCl6P2Q5QZ1flBkZk=
Received: by mx.zohomail.com with SMTPS id 1743511148517505.586650767228;
	Tue, 1 Apr 2025 05:39:08 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v2 1/2] drm/virtio: Don't attach GEM to a non-created context in gem_object_open()
Date: Tue,  1 Apr 2025 15:38:41 +0300
Message-ID: <20250401123842.2232205-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The vfpriv->ctx_id is always initialized to a non-zero value. Check whether
context was created before attaching GEM to this context ID. This left
unnoticed previously because host silently skips attachment if context
doesn't exist, still we shouldn't do that for consistency.

Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default param if context_init is supported")
Cc: <stable@vger.kernel.org> # v6.14+
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 5aab588fc400..3d6aa26fdb53 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -115,13 +115,14 @@ int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 	if (!vgdev->has_context_init)
 		virtio_gpu_create_context(obj->dev, file);
 
-	objs = virtio_gpu_array_alloc(1);
-	if (!objs)
-		return -ENOMEM;
-	virtio_gpu_array_add_obj(objs, obj);
+	if (vfpriv->context_created) {
+		objs = virtio_gpu_array_alloc(1);
+		if (!objs)
+			return -ENOMEM;
+		virtio_gpu_array_add_obj(objs, obj);
 
-	if (vfpriv->ctx_id)
 		virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx_id, objs);
+	}
 
 out_notify:
 	virtio_gpu_notify(vgdev);
-- 
2.49.0

