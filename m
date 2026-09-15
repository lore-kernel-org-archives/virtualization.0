Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF25456DE9;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457988; cv=none; b=bcBabjsD1dCA8prtpz+lnD7kV99wLmgSW8NR2dXQTuuSYOno27KBj6tj6plWTSpvXZhAgmiCc6j0FZbM9eWWzBvZVwK6QqTtPwHwLPj+wCXYBoLVejCqqcNDUMA41DtRtWGsGzFUjQW547iPqAmDlXN+nFykmfAXjq5ZU7WeYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457988; c=relaxed/simple;
	bh=+ZvUBVLlnhme8yqiJiZGAghhi2ab0L3qh0DBTz3gBa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmnlHZEWI5LD5JXVxRGtCcOrZjYb8zavNpsqfWhFxSex6W2QA7lz+xEZ0Bieh0fW7OqHxN2DkUPiEOMLA3mpdduP6o4hGx9Qyi9/P/jAc6aBzVfi8Z1qP/k39iC9chXpGbo/W1kubaMrA4LcNUpONmg+NY7FwQYcu+fzubfTJq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0+E1yHH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0+E1yHH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D6B4C2BCF6;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789457988;
	bh=+ZvUBVLlnhme8yqiJiZGAghhi2ab0L3qh0DBTz3gBa8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=B0+E1yHH48qchnNwHAAiruot/yaYCnDDcg4y30hw7e9uIYrXz3wkWnNssapl8E+/W
	 StenjhKwFr2urjYijKuft8ZuEmg2tLQyouhD9hOroVdIU/DvfPG27L+g3UxTcAal4R
	 80SkZuRnvV8DfNS7VghLTsGmV94EqnQ2wFnkoMjJJeayFWTnCiOG4od0NdMurjWmT7
	 0OofXkRlemfzzPUhU9y9JKu13rCd/kUnxiEzdcE5RvGwt2dJu5q1SGuWyawbaT+4tJ
	 rbOSkf1EbAxE3rB7qA94ootxLiwYqUtjvhXGfneQ+Rcbe6Tn5oWEA2lLhhZ+D/X1R0
	 E2IFjlm/ryN4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A72BC88E7D;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 15 Sep 2026 15:39:10 +0800
Subject: [PATCH v2 1/4] drm/virtio: fix object leak when
 drm_gem_handle_create() fails
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-fixes-v2-1-a0d799e4db66@outlook.com>
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
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=IqwDkc74tOO8lL0END3OA/+gXOd16vqiITrIyypWgKA=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBXfHLs+KjxL9dt8d+0PB7/+Evm4I+b64b5Kl+9wp
 hxdaLFCIKOjlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJjLrAsNf6TO1WakrPQrn
 L5mwUmC7vvTxoltXQrRSNm7+1/7/p7SCESPDnNQNBzzsWTZG1sdf9RE7w/n7vq2zRUjo/eAjE5u
 WlRUzAgAcwkvq
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
 

-- 
2.51.2


