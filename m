Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD63DDDAF
	for <virtualization@lists.linux.dev>; Thu,  4 Jun 2026 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557186; cv=none; b=iCORTjeDqbHBrG1x+cFFmA8qlTOrhChqcGS48HArEaj5s8HtzFJfw5IK0Lg9cBHJ1R6TI9mbEVLGXuWNWqtXlzbtE6SpHol/eQjWtkcOQSgrQ/UJL5zlJbbnAcYZs83rJQy/gdXWn46eZNc0VUsnG/9yk02ze9BJgZTIm/dHQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557186; c=relaxed/simple;
	bh=w8Z3WWew1vUiTEhNRp6ZBwW6gbTLPwJzjTuAWxDUVfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eyfaxbssGAAw3AiWoqwfOxNOXsQBNVAWpV0p4sVEl46aw8TDGL1r1gLZYhS9IDeBM54Nu4Tfmf/UvFyxGY7uwCgTwh8VgE2FEG92Q9CNVd/lnbBqJHJ+q9IIg/51J2fbKAw7Z7ahtTNJn1R7kThx6VOcobo7pJQDp2nbINRLC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mkDIeNHV; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mkDIeNHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hi
	UR13d5dBzF8Im0U4deIlQbQWkcyNiC9aoy5hCFBUg=; b=mkDIeNHVQy4O7w4t/S
	XA37GGo2LzrOq9wfN4voJbwLzOnnqDMzey1xTKHNsJ0f231DEDxlhD2iArJZIa9l
	m/pr4Mht8f4zINLYhtcSV6ar7aOH75QfPlG+dg2w5Hp/3m+CBl5BlrKcuB9yMnh8
	CXP/xIEpOk/TTLBcJDSyoj1ws=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3kWdLJSFq_opjBQ--.18375S2;
	Thu, 04 Jun 2026 15:12:12 +0800 (CST)
From: liuqiangneo@163.com
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com
Cc: gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH] drm/virtgpu: Use ERR_PTR for fb_create callback error return
Date: Thu,  4 Jun 2026 15:11:58 +0800
Message-ID: <20260604071202.138235-1-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3kWdLJSFq_opjBQ--.18375S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4kKryxWrykKrWfGw4UArb_yoWfGrc_Gr
	1UXr9rXryakF1v93yUAa1rXryIvas8CFs7Z343tr93tw1DAwn7X3srZr4xX3W5Wr4UKFZx
	Aa1rWFn7Aan3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8a9aDUUUUU==
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC4Aw-oGohJUwXVgAA3Q

From: Qiang Liu <liuqiang@kylinos.cn>

The fb_create callback returns an error code encoded with ERR_PTR()
on failure. This lets the caller see the actual error code instead of
just a generic failure.

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 44ffffec550f..85ea252c658e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -344,7 +344,7 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	if (ret) {
 		kfree(virtio_gpu_fb);
 		drm_gem_object_put(obj);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return &virtio_gpu_fb->base;
-- 
2.43.0

