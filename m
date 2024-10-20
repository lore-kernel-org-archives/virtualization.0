Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A736BB5B
	for <virtualization@lists.linux-foundation.org>; Sun, 20 Oct 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729465445; cv=pass; b=nfRGXkmCcJWETA9PGgOPjN8PwuwWelxZejhpaFd38l8kAVqyzIbvoKLxSDkwdh2fCLovOSsZtH8l5lCRXx1DVnQ3SU8HJ+Jb5KvzCFpZZtkfE/oLoG9KMvyIB3fJbiIzAc1anKiHzP31k3nFnpzizXLuv8cEiZq8se/vT2KGWZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729465445; c=relaxed/simple;
	bh=cFvRMMbZpdGCd3ouDPfPl4aO3ygjCeX7AU39EQDtAbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzWEU/qXNzodFmcxjtjHu5o+pWjWN8xrcrts+M6jYgLhUPjUmnhRmNKX2tOn4ZR1uFQBCK7zr5urnG7nQFATbx4zK09MHJiImN31Fd1L13lDmonPOUH3m1r8ljNgSlcnsp6n436bla3SlATrjFlxgRX5+LitFHLTU7Gf3YA/qP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ZnZ5Hu/H; arc=pass smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ZnZ5Hu/H"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA02780B9F
	for <virtualization@lists.linux-foundation.org>; Sun, 20 Oct 2024 23:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.789
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KxdqhkU-_T-H for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Oct 2024 23:04:03 +0000 (UTC)
X-Greylist: delayed 904 seconds by postgrey-1.37 at util1.osuosl.org; Sun, 20 Oct 2024 23:04:03 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3E3A080BA0
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E3A080BA0
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ZnZ5Hu/H
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.112; helo=sender4-pp-f112.zoho.com; envelope-from=dmitry.osipenko@collabora.com; receiver=<UNKNOWN> 
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E3A080BA0
	for <virtualization@lists.linux-foundation.org>; Sun, 20 Oct 2024 23:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1729464530; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d2WFfHEHA0Xx31UrFydpEFfccdsBUKikdaczwif03n9Dflha03mJib4ob4W28sz7wiWKDOth5bw5Wrx+MwlHPfrWXpno0s53rq/KMiRshIBQ0Zy1WE1E9M5lTWVPm9b5NCL8Mot/3n0pL4ayUkCA6MkaiSG326JinAhJjN+xKh8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729464530; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7LvLwytRtn5CBeDLReQUVN22EMuJFh+Y13/Wh+lWpKk=; 
	b=f2Is/tkUUD2NvABkJ7golLcVp/IVjMjeAYp/4o7jAmih9X8Z7Lgwl0RnzIvb1XdcFFp2qmlPozy2/7FWnUNEQ0XL+6z5HmoWDlco/mnNHzvFtmwjiIxVxLaceBBo184X3pZBVoJ8zCbOegJfvw4TECC7Wvjudu7afrGasbHf/kk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729464530;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7LvLwytRtn5CBeDLReQUVN22EMuJFh+Y13/Wh+lWpKk=;
	b=ZnZ5Hu/Hxunhx5lvJGNHTSOMPo0NRpl4rDkhI9V/emmGAQC9H2jKuzMqck05I+RZ
	dbvkxovMow+M77dVZJW9XYeY6fxaFRAaLqu3y5BEfWd8lSLHax/BCDe37tgNx1YgxNJ
	iLEwY4y+TQfFBEeSnWo5p2tAfZQib6RD53EyuKzU=
Received: by mx.zohomail.com with SMTPS id 1729464528968517.9489015511994;
	Sun, 20 Oct 2024 15:48:48 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1] drm/virtio: Don't create a context with default param if context_init is supported
Date: Mon, 21 Oct 2024 01:47:25 +0300
Message-ID: <20241020224725.179937-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Xorg context creation fails for native contexts that use
VIRTGPU_CONTEXT_INIT because context is already initialized implicitly
when dumb buffer is created. Fix it by not creating default vrend context
if context_init is supported.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 7db48d17ee3a..67f557e058b4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -127,15 +127,17 @@ int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 	/* the context might still be missing when the first ioctl is
 	 * DRM_IOCTL_MODE_CREATE_DUMB or DRM_IOCTL_PRIME_FD_TO_HANDLE
 	 */
-	virtio_gpu_create_context(obj->dev, file);
+	if (!vgdev->has_context_init)
+		virtio_gpu_create_context(obj->dev, file);
 
 	objs = virtio_gpu_array_alloc(1);
 	if (!objs)
 		return -ENOMEM;
 	virtio_gpu_array_add_obj(objs, obj);
 
-	virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx_id,
-					       objs);
+	if (vfpriv->ctx_id)
+		virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx_id, objs);
+
 out_notify:
 	virtio_gpu_notify(vgdev);
 	return 0;
-- 
2.47.0

