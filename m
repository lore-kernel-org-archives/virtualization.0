Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C079346AE3;
	Sat, 15 Aug 2026 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786774593; cv=none; b=IN0Y+ay2NkE8m2IzSFb1pISWVQelMKW0VzH006KKviohhDvhPrB6sIivu6oFv4hS6iu7lp1s4dcIn3cwA+ihzocu+bXSjrTmNMqizJMEa6/0U0QRzz5pndQPLQ+vM2AiQOgPOnCkJzuiKVI1Ibz9vys08wL5eWZlv8DfXr/IxK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786774593; c=relaxed/simple;
	bh=IvccXk+JHDQI/jPZIKIPAYAFAKVkdiqnwotIh+CixBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M3yvP2TJLFvjws+QrXzyh+63J2Pic335eNOpIY+h9l6SOLItUgD/XEcek4z8ym//B6+cI6ZlAGGJDEaeudkPoineyDd++RZtrOv16NtCB1rRnDs9BwpkVPKIfLwxAnrrZzEj+22PdrJhCxalNMRrRxgPdXfEJhOmW93W/eIbVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEwUY1oG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEwUY1oG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D12E5C19425;
	Sat, 15 Aug 2026 06:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786774592;
	bh=IvccXk+JHDQI/jPZIKIPAYAFAKVkdiqnwotIh+CixBI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OEwUY1oGw305MxYPeNlU9Ww+UykOdGB1z2MVN06pfnD8tEEVHCkzCefH7GtvTEbBG
	 epkJgYlwmIeNx1E50RT7bJ8oWZv7BvzlqIr+xSF4/QL9ipCrQQAt9k2ShXVBhzXUi3
	 U10486rV2px/wEEC+qXbEBI+b3bQN4rziUpTJDLEDrjSoT/5DeBx/fHW7IHZRESFFs
	 cKvPdo/P/9/ufnwvcxDhvSu3Uep0axPoG5aWCYyUUkVHetgAVu6zEsT1/PhpfzwjxN
	 mDnL7Oufpmeeig4MAqYvF/QGqBosTlL+MQ65OI1NTA9GgZmBEMzv4Xb6DE3J30x5o5
	 Rp91rajQd7N8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA4BC5DF67;
	Sat, 15 Aug 2026 06:16:32 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sat, 15 Aug 2026 14:16:29 +0800
Subject: [PATCH] drm/virtio: fix object leak when drm_gem_handle_create()
 fails
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-virtgpu-gem-create-leak-v1-1-a4e9fb18caa3@outlook.com>
X-B4-Tracking: v=1; b=H4sIADwEgGoC/x3MywqDMBBG4VeRWXcgiSjBVyldhORvOnipTFQE8
 d0buvwW51xUoIJCQ3OR4pAi36XCPhqKn7BksKRqcsb1xtuOD9EtrztnzBwVYQNPCCP73pmutTG
 1yVOtV8Vbzv/5+brvH6YzuTppAAAA
X-Change-ID: 20260815-virtgpu-gem-create-leak-8620531cd3d8
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=+H0YnFkWSIHfk+tlYOEarUiRI6w/1HSszt61Rigu8cs=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrAYW+5uftEubcjyFuTgt3/zke+oxsVxm+uVlDR+Ov
 ntW9q28+EhHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATOQpEyPDrUf3jI7cUH64
 fFbIp5JoqZAteyWnsL588s7K8dfODL1N5gx/+Na1zvoZ8zu24c3ia81MGx8VnU913n714DxV74R
 lktKVvABoRU6s
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

virtio_gpu_gem_create() owns the reference taken by
virtio_gpu_object_create(). On the drm_gem_handle_create() error path it
calls drm_gem_object_release() instead of dropping that reference.

drm_gem_object_release() is the inverse of drm_gem_object_init() and does
not touch the reference count or call obj->funcs->free(), so it is only
correct as the last step of a destructor, as in
virtio_gpu_cleanup_object(). Using it here leaves the bo at refcount 1
with no remaining reference, so virtio_gpu_free_object() never runs and
the shmem pages, sg table and virtio_gpu_object are leaked. Since
virtio_gpu_object_create() has already set bo->created,
VIRTIO_GPU_CMD_RESOURCE_UNREF is not queued either, leaking the host-side
resource and the resource id.

drm_gem_handle_create_tail() drops the handle reference on all of its
internal error paths, so the caller only has to drop its own. Use
drm_gem_object_put(), matching the success path below.

Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 66c3f6f74e9c..d2f0b8a3f172 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -45,7 +45,7 @@ static int virtio_gpu_gem_create(struct drm_file *file,
 
 	ret = drm_gem_handle_create(file, &obj->base.base, &handle);
 	if (ret) {
-		drm_gem_object_release(&obj->base.base);
+		drm_gem_object_put(&obj->base.base);
 		return ret;
 	}
 

---
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
change-id: 20260815-virtgpu-gem-create-leak-8620531cd3d8

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


