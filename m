Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE3187849;
	Thu,  9 Jan 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736460473; cv=none; b=Bcz1umdS+jIhfZPOquzVnxnGGu2DOsXgTQ6kMHp902VE+T0RCE+ziuHcMBIx+0rk/S7J5EVD2iW7GxWJ73S8QU2F+HLBtSPiiK0TD6E+SXiSGA/lkZtbnDVwqOlIuhg7vitE8YixE/9l0UwJ5I+fDGMkOKtEo/ihCSs98kGKmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736460473; c=relaxed/simple;
	bh=fSeuNwGv1wlH+8DYv8Ob9vL289mkjYFU7A5gb+aJhbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SIzXZkF1DQb06r4Wo+LiGflxWxEdi6tziLbh2xqSSLotxwvwA4/Gg3tBRjfo9/ojirVOQoksECbgtPxK/0eTJmdNGPxVJ9mAnvPvLRCZUyK5pMET/JXSuQ0vc3//ZrIrjY7gSkAx9yxSwiLAy7bjVSCFok+gSH0SFsGgUUGgkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErAQqZdE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErAQqZdE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B26BC4CED2;
	Thu,  9 Jan 2025 22:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736460472;
	bh=fSeuNwGv1wlH+8DYv8Ob9vL289mkjYFU7A5gb+aJhbs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ErAQqZdEGoSaMt735IbM0OLP5qNIJdz7arEby59R1W17jsKdsc6NEdRlS7ZnCyHh0
	 jcDgl78o8lem3hT+PBCw5IRVXXtBLy4XN71cTcdYjR1GoATq+DIVu+9sQOiv6TL+Qu
	 FQtwjIR+1IAqPazJAHQcdNcfpwIvbIUCHMBEZV8COrTxeiBg/SZPDu3BSQNbILw506
	 lFSxm3uBKXZmJym6DtNCzOsfXN4sOqPjevT87Uk4MsVqziv/1U89dUm9IgiYyUjqTQ
	 0hlEBk2THN3ZyyWIz8kwpCRYOfvYabUjyxSCt5AisJ6qrY37xGvWa2e+XoZiFRnTZf
	 I3o/yswlclkPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B04E7719A;
	Thu,  9 Jan 2025 22:07:52 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Thu, 09 Jan 2025 23:07:51 +0100
Subject: [PATCH] drm/virtio: Align host mapping request to maximum platform
 page size
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-virtgpu-mixed-page-size-v1-1-c8fe1e1859f3@gmail.com>
X-B4-Tracking: v=1; b=H4sIALZIgGcC/xWMQQ5AMBAAvyJ7tkltSPAVcSi27AFNSyPE363jJ
 DPzQOQgHKHNHgicJMq+KRR5BuNit5lRJmUgQ5UpTINJwjH7E1e5eEJv1YhyM1JNQ+1Ka8iNoLU
 P7FT5z13/vh/0keKGaQAAAA==
X-Change-ID: 20250109-virtgpu-mixed-page-size-282b8f4a02fc
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736460471; l=1517;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=lIIbgfeZ3OArzbnTe9ftPQjp52A5SwWq2Us6yyQ7tQ0=;
 b=GRQcjPla8yqP6JTh2Z3QypfIo8fRlvmdI6WroBA0UzI9AhZMUTpbwOaw9hNIUDcWLGZG+FP0F
 m5oIlszkSqaDOhv+fa55vMcxXApmSENNLbgryQUg7vvN+LnGTqHqaue
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

This allows running different page sizes between host and guest on
platforms that support mixed page sizes.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_vram.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
index 25df81c027837c248a746e41856b5aa7e216b8d5..8a0577c2170ec9c12cad12be57f9a41c14f04660 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -138,6 +138,12 @@ bool virtio_gpu_is_vram(struct virtio_gpu_object *bo)
 	return bo->base.base.funcs == &virtio_gpu_vram_funcs;
 }
 
+#if defined(__powerpc64__) || defined(__aarch64__) || defined(__mips__) || defined(__loongarch__)
+#define MAX_PAGE_SIZE 65536
+#else
+#define MAX_PAGE_SIZE PAGE_SIZE
+#endif
+
 static int virtio_gpu_vram_map(struct virtio_gpu_object *bo)
 {
 	int ret;
@@ -150,8 +156,8 @@ static int virtio_gpu_vram_map(struct virtio_gpu_object *bo)
 		return -EINVAL;
 
 	spin_lock(&vgdev->host_visible_lock);
-	ret = drm_mm_insert_node(&vgdev->host_visible_mm, &vram->vram_node,
-				 bo->base.base.size);
+	ret = drm_mm_insert_node_generic(&vgdev->host_visible_mm, &vram->vram_node,
+					 bo->base.base.size, MAX_PAGE_SIZE, 0, 0);
 	spin_unlock(&vgdev->host_visible_lock);
 
 	if (ret)

---
base-commit: 643e2e259c2b25a2af0ae4c23c6e16586d9fd19c
change-id: 20250109-virtgpu-mixed-page-size-282b8f4a02fc


