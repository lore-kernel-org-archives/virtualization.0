Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434133439D
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 06:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770271861; cv=none; b=XRh+YgFfbNlYTnDqAx41Ct0tZppVFaFgUPMAVk9F23kQB+XCoSQ7zLt0WfU514D4wy7Zr6iC2ghpF6Tusqo0KVjVynrPhh5kfhGEY/2svE+ZI5e/1VJ5PCZ2Ef1N/Wg2s8D2ciAtaPrEUkxX1cNbVRu25Z+VZJ+psffg9EZx8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770271861; c=relaxed/simple;
	bh=qLlSk4jrWMDSo61nQufqN59pzS6ZTouScPCXY18T6WY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gMQ83cYJmCva/IJPGxLAP2PLV6Lg9y3JySr3A/DuqtNgQR8ae1uAsLNaK9NxVNx4JOuZ+DtPLlt8msTNrAd6Zge8HBuMeLK/VGqT3vi5Zvl/+powVL44JJmHu4q5QMRAJWb3jPXFQkYQ07zimiOGjw/Aq3xPPjb/7ygSAJOxQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	<virtualization@lists.linux.dev>, <spice-devel@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] drm/qxl: optimize idr_preload allocation flags
Date: Thu, 5 Feb 2026 01:09:06 -0500
Message-ID: <20260205060906.4059-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

idr_preload() is called in a sleepable context before acquiring a
spinlock. Change the allocation flag from GFP_ATOMIC to GFP_KERNEL
to allow direct reclaim and improve allocation success rate under
memory pressure.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/gpu/drm/qxl/qxl_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 2e3200d..dd61d2a 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -423,7 +423,7 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 	uint32_t handle;
 	int idr_ret;
 again:
-	idr_preload(GFP_ATOMIC);
+	idr_preload(GFP_KERNEL);
 	spin_lock(&qdev->surf_id_idr_lock);
 	idr_ret = idr_alloc(&qdev->surf_id_idr, NULL, 1, 0, GFP_NOWAIT);
 	spin_unlock(&qdev->surf_id_idr_lock);
-- 
2.9.4

