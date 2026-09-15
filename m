Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6F450403;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457988; cv=none; b=DYKE8AFuMw+9ggLDSiLEJrYjGjHJ5AdmQjZIgWdHSUWXv/FMQoQpcTYl6mcW1oiYIJYzou/4f63fS9HxXl8ILPvlPUs5EfCpdKZwbgJ2bSqdoKFsfl2meqrhvRIEB4H7QDuAaSjmzxYR4KFWtPDSCoTOHTn08ZL885AIeeqqMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457988; c=relaxed/simple;
	bh=6fo5j/URbptwFWsGgDE9ZiP3GKDoDXqEGDTugblfI/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fblj+HjSMVSARfJkmXbwS3rGhn4R0g3F48mP2xhT5iiK5KTaY4gwGHueOu2UqUIp1Gi5UlVQ69gOy3qK1367iKbev/moMM3Mqy8goBCjc9Y+9TxPGV6jJ1qUeJfgMqbVbaKgGM6hiYVGJAsIgcjz3629qYZIo/uWXY2bNooNEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFev8jtx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFev8jtx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CFACC2BCFD;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789457988;
	bh=6fo5j/URbptwFWsGgDE9ZiP3GKDoDXqEGDTugblfI/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iFev8jtxhxc8Jd6+QKIOAd5Wboh+WFTneCKnHnWlETKyK4JQqqKOqsZ//9fbwE4GI
	 kST6h16G5tda7RVRM0qHSBDvxEUmEmeosWc1v/okSjTHQknIIpLFea6O5SKspDQuDX
	 TRGF13j0UXVqu++E55v65AbpIMjEL4b0cthhwyzSzRi+MYW5vYM16CJz/yqPUWGfym
	 Eeqs3fFti4PAFY8kFfXEXBK98yXC8sbyeDGeRV0Vk5pXUDOqnG/r14j1g9lKj+rifN
	 R0CgUJTrGdMCobJqKPGghMjY+JRfBqXEYPpqHopnOa3l5kYR1zXHftAWYwSFo0UPF/
	 zXlvsp1cwcW9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8A1C88E7F;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 15 Sep 2026 15:39:11 +0800
Subject: [PATCH v2 2/4] drm/virtio: fix object leak in
 virtio_gpu_resource_create_ioctl()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-fixes-v2-2-a0d799e4db66@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=m9jMk2dRPc6AaiI3AVPl+UojmE+4LGbux5+Vah67Nqs=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBXfHBPs65bwXWR+u6xj6uQVj7za7fo/TU8pbY++L
 GwfU3TLeUNHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATKROmOGvAEfF0y4mk+Tt
 SgoMc04u8JrP8+qRptWDX8Fml8KSHp7jY2T4+K5N6a3YDpFmx9xnDXd37RG7uv5fu3rx0uzMHwl
 zt6bzAgADT0zZ
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

virtio_gpu_resource_create_ioctl() calls drm_gem_object_release() on the
drm_gem_handle_create() error path instead of dropping the reference it
owns, so obj->funcs->free() never runs and the virtio_gpu_object, its
pages and sg table, the resource id and the host-side resource are
leaked.

Use drm_gem_object_put() instead.

Fixes: 62fb7a5e1096 ("virtio-gpu: add 3d/virgl support")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d8e4ccdb7c1..d16f07abb266 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -185,7 +185,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 
 	ret = drm_gem_handle_create(file, obj, &handle);
 	if (ret) {
-		drm_gem_object_release(obj);
+		drm_gem_object_put(obj);
 		return ret;
 	}
 

-- 
2.51.2


