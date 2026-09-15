Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6548456E0A;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457988; cv=none; b=jaxjiCpxTgHwRsf2xSx1yB0uz5bhL02KHxx20Izv+ohsQUhyFzYhY5gXUDQsbUVSLOmgGq4Euy07uTn5SIuHtnNYy2+5e7vx6IsZhRjGvpo/KDupdXx5orcS3m3sdhX2v3E8MVmMSJhfE2uUyXz0imYCD5m6fZXAV6c/O6ee2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457988; c=relaxed/simple;
	bh=UdMaaxVxX8faS5D/R59hxfAkCFC0hSCarXqNvw4Plzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n1NzGFgHv0W7Dae1L1MhDKLSQWZFrPhUX7oDk1JtWieww00vSp/xQruP+1v4lFNl5G0Vv/Iy7nUMLPGIcz4F3JG95YoqhmbGnmWtTELUIdcRQEOIL5HTt2kJOWqaUOdxVCThT57z1Jp6Qy1kDr4qZ076S4vsFF1jTX/RVq1c0pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNztBd7H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNztBd7H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59C3AC2BD01;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789457988;
	bh=UdMaaxVxX8faS5D/R59hxfAkCFC0hSCarXqNvw4Plzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UNztBd7HO35GxpuzWbeFV3i+3XTQGaItN9kYkboY3gU+78Lf/k5ffAreYxTLLFHfQ
	 QmEu3CTCotYs3LnqbKBR3j3NKNtmZLtSfNhWqztMKt9K6pywM+SMrh0nNoxvBzk54i
	 ZAoFDU6RjxvHvgAhnf/w9mY+J5fz+rsORBJoL1l09UsNnGICMgcE1B0GmjLHx4OgzV
	 4SfgFH6eq2mtu+TWE5SEN6yuZr6vqotiM1a9OF22xnYNKCrJ/JT35VU18XlyChA4+X
	 BaJyPDQEYbDFHTx3qO/QcrMHfUrjPng2TzO2he9z1ymixNK1axCiizqoxPqrofUaKU
	 3dm1v5yzfndGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C025C88E75;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 15 Sep 2026 15:39:12 +0800
Subject: [PATCH v2 3/4] drm/virtio: fix object leaks in
 virtio_gpu_resource_create_blob_ioctl()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-fixes-v2-3-a0d799e4db66@outlook.com>
References: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
In-Reply-To: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=gmVVZGqljoLUgVlULUlI1tOIf4EBWb5LQtGm6rkt9fE=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBXfnPhTbs/5prpKPvbE5ptnF9Rk6sdnvZlnn9f1d
 72ntLBV9dqOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmEhdHMP/UIW9ipqJV5Km
 /Wd8dGJ5As/5Yxmf/e07u8p8pZM3TFk1g+F/+hy9zXW5bH8spjY/9Crh+vl3g+NVdb1pOWzif47
 n/rrICwBu3U3v
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

virtio_gpu_resource_create_blob_ioctl() calls drm_gem_object_release() on
both the virtio_gpu_resource_assign_uuid() and drm_gem_handle_create()
error paths instead of dropping the reference it owns, so
obj->funcs->free() never runs and the virtio_gpu_object, the resource id
and the host-side resource are leaked.

Use drm_gem_object_put() instead.

Fixes: 897b4d1acaf5 ("drm/virtio: implement blob resources: resource create blob ioctl")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index d16f07abb266..fcdb07a37972 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -557,14 +557,14 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 	if (params.blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
 		ret = virtio_gpu_resource_assign_uuid(vgdev, bo);
 		if (ret) {
-			drm_gem_object_release(obj);
+			drm_gem_object_put(obj);
 			return ret;
 		}
 	}
 
 	ret = drm_gem_handle_create(file, obj, &handle);
 	if (ret) {
-		drm_gem_object_release(obj);
+		drm_gem_object_put(obj);
 		return ret;
 	}
 

-- 
2.51.2


