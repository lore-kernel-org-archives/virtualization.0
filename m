Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132D2E403
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953838; cv=pass; b=Z6l2SvLex+xmsWNIK7ftqeKHJfy3cqwrBdkDrJ2iVWDz1VKHvbAmFEuA4UfAdiWUBKN0YMhv9/2r4W8fY7CivxHfYCL7elUuOxwilsoJl7mBNZgRdK/1YL3my5fKGwEcQTC11qkQshzrZMntOK+HuGbA36giUQEZZrMh0fVz1rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953838; c=relaxed/simple;
	bh=leXL0YOUGKS3mkm5UCH4AbWyYSEzGeXYl5rNKD1s/sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVSeiOfnYNUVfhM1MEFdCfZm4wEhQIPKFoL4lSYQuWmPx0p0tlnkCLUnDero4leo3Ta0G2xjL5StSToXzESP4MZ1moNVDBZCsTNp9gQNC6mAll8E4x9ZKSEbemyIfC0HYI7Z5Xt49Ptylrb8V0nZysQ76xHCTwDU8Gh+9hCugBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=J0rSfn1O; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="J0rSfn1O"
ARC-Seal: i=1; a=rsa-sha256; t=1742953821; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UBdJktvaB2aVHmIgmMGueJcXiP5a7HCF5tEltKL/WFHeRz1iI0CkQbYGhTxLpVPcEzXxDgcRlJhUB8WcqrvrhpkFxdTUUo0CtkVr1Co45i+iMOYSp5xGTiFRnVq8gvRDjJZQR3JXXv6Q/zZ1sFz+t8j9ycN9Rs6G1hfI6D7riyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742953821; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MMqG/V3rFBVDqfrlMRzLq3y3NkP6nqJWgulgefkL1Ms=; 
	b=NqqM9XssXvh8+U6O2CQUiZGKBAnxPf/9Y2W5hI2ijIbzoykLD+ljnC8bNp3sAXlibLic2bjKaKZ7QQPi85HkZQubsg1RYN8CxqLCTQms6eD0NGW2E+J9CkmcbzdhQx9W64yOD+DdIj+jq7HKPwPbiZfW+WiQaBCnpt2lr8x6NqU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742953821;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MMqG/V3rFBVDqfrlMRzLq3y3NkP6nqJWgulgefkL1Ms=;
	b=J0rSfn1O/VAPJvNE8CxPB44G+yu35g+sYeaPe90ijc+fUjecuH6Kal9jgR66/pL+
	ygknO4RbtIHtQlMBsDm0u386inWJiBOBU6v/kZNnS7vD0WBmWt991ysdaGtGGIB3fz8
	Z66RIb6W5U3vt0h28vR6DCdK31QR7jXV9qdyrSCc=
Received: by mx.zohomail.com with SMTPS id 1742953819782444.3851239137857;
	Tue, 25 Mar 2025 18:50:19 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1 1/2] drm/virtio: Don't attach GEM to a non-created context in gem_object_open()
Date: Wed, 26 Mar 2025 04:49:01 +0300
Message-ID: <20250326014902.379339-1-dmitry.osipenko@collabora.com>
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
index dde8fc1a3689..90c99d83c4cf 100644
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

