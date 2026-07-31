Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD0330678
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488558; cv=none; b=AXLoH7qBJR75z4ZYuI4T1qsf1d7yEIn+C9yCDcwuOHFegGI75aH0uajdQyGs5wFIEEswYxeXkn61aBaz0DLTl7mTpi/SeLIc69eMOxbWAmh7qUY49AJ5/4743fCs9ivkXJawgPthoyjGSkcFNNxwXSw2G+UaBSmoLU0YjzWtBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488558; c=relaxed/simple;
	bh=GkbOnGizHmVkpdmAqhZsO/Wx6Wr7RpttkwMZm6H07LI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+MGcXk3oGpyScduAh/LT0u0OPV5dpzkJRm3FGq40WLjaClVXwekuJJCWS7iDC5kJEo7IghfAkHvjc684H2HW7hZTIwjGPJNBPjvaqMEFgfISzjc+FC7pK9rascq5pVAenkqnjy0178jwZhNyJIrZJWDJ56/H1sK7LcB8htpCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aaUVPUMh; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aaUVPUMh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZuF9xjCt2CNH2BQj5jWOWwh2QTh09rtVzZv+3BXi12Y=;
	b=aaUVPUMhamlKFKZ0DgLc6oX4WFVuMZneCQH7yTtlqOV/a1bqSWVJvzfnHfKW6SkD6lOBuU54Y
	/2ZX7eItLm0vU5j0Seq+YdllAh9GlXcTn/5ilYie8ErfooZkVAhr/jYFn6psCjJvYXOhS+Rjc+7
	xALE/1QJMidmHmJNr7XXIfA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hBKbJ1XBTz12LHh;
	Fri, 31 Jul 2026 16:53:00 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id E361540561;
	Fri, 31 Jul 2026 17:02:28 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Jul 2026 17:02:27 +0800
From: Yao Kai <yaokai34@huawei.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<liuyongqiang13@huawei.com>, <jifa@huawei.com>
Subject: [PATCH 2/2] drm/virtio: free control buffer when scatterlist allocation fails
Date: Fri, 31 Jul 2026 17:22:36 +0800
Message-ID: <20260731092236.2262403-3-yaokai34@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731092236.2262403-1-yaokai34@huawei.com>
References: <20260731092236.2262403-1-yaokai34@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemr500006.china.huawei.com (7.185.36.185)

A vmalloc_to_sgt() failure leaks the control vbuffer, its data buffer,
and any GEM references held by vbuf->objs.

The queueing code owns the vbuffer by this point, but the failure path
only unlocks fenced reservations before returning -ENOMEM. No caller
reclaims the unqueued buffer.

Drop the object-array references and free the vbuffer before returning.

Fixes: e1218b8c0cc1 ("drm/virtio: Use vmalloc for command buffer allocations.")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Kai <yaokai34@huawei.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index a470339b6747..7ccc487e3332 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -477,6 +477,8 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 			if (!sgt) {
 				if (fence && vbuf->objs)
 					virtio_gpu_array_unlock_resv(vbuf->objs);
+				virtio_gpu_array_put_free(vbuf->objs);
+				free_vbuf(vgdev, vbuf);
 				return -ENOMEM;
 			}
 
-- 
2.43.0

