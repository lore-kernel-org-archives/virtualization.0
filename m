Received: from outbound.baidu.com (mx21.baidu.com [220.181.3.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8F4B781724
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 03:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782704271; cv=none; b=bspSZXlc/eaxK9fINI4oFlxDQ96FxlpJanywKeDAQhHNJSA9SJHlTZUA2bVkGBjrCdT8xqjysA/iWykBExxhGNP9oGNanhSLx5axfECVbdpkljjBglN7imExYA5T/NcqJydqtaEYLwztsig31xo6yzbj94VPx5KKLnMbgffsP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782704271; c=relaxed/simple;
	bh=82pOYs77GOgaxG9XkMhx2y9Krx4k5hxZ5mX2aD7RVzU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ERszC+dpqd31M/j7rrC0zop6GeRRc5Xgltr4YrxVr761JGXpYOHw2BTwUdfE/ShnBeK5AoDxbm9b0dfNpkhdrc9XU0cD0iO0fRKcQzs5aierA/iLzL7BKaPElqSbv/4P9nAjSGdaZKChsbNyHg2C7BcG3jcOKFMQKem/kSy9YHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=enE74pLW; arc=none smtp.client-ip=220.181.3.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="enE74pLW"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: David Hildenbrand <david@kernel.org>, "Michael S . Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_mem: fix hardcoded 'vm' variable in bbm iteration macros
Date: Mon, 29 Jun 2026 11:37:38 +0800
Message-ID: <20260629033738.2617-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1782704267;
	bh=ObvGsEe7GvPy+T13gncp+ofh+YINEJ+aCrLm12hdWHI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=enE74pLWxzTkJj558ZHDAjpVTsmFibLABGemx2WcPoHfTmgpDiYFIrndNbxT59+Wk
	 Oe5hv/Ii378MZr/tkb8nuGxJWXFO7AzbdhbiuhKR/gQ8uJQgK+Fvvan8PN6lqWxCns
	 EBcNXd2SLKh1Kynn24j70vqK/wfa/LxMlQ4qG1JXIcLakPek6vJNuaFRIDSQ/xNQNM
	 +NQewdRkI2rx3nojZ+j9nrGAR3E0rzVBV4mVYiudXR4LrCoJ3U1bxWo6UX4pw3csay
	 8hyFrjjZXCHErgLJyXA76CJ/Fg9YXMDXZV02t+NVu/AqpHWHzexw3NBehcqGPU02O3
	 v7kMOYwD93s7Q==

From: Li RongQing <lirongqing@baidu.com>

virtio_mem_bbm_for_each_bb() and virtio_mem_bbm_for_each_bb_rev()
accept a '_vm' parameter to allow callers to pass any variable name
referring to the virtio_mem instance. However, the 'for' loop
initializer and part of the loop condition use the bare name 'vm'
instead of the macro parameter '_vm':

All current call sites happen to pass a variable named 'vm', so the
bug is latent and does not cause a regression today. Nevertheless,
the macros are formally broken: any future caller using a different
variable name would silently capture the outer 'vm' from the
enclosing scope, leading to incorrect iteration bounds.

Fix by replacing all bare 'vm->' references inside the macros with
the '_vm' parameter, and wrap in parentheses following kernel macro
hygiene conventions.

Fixes: 4ba50cd3355d ("virtio-mem: Big Block Mode (BBM) memory hotplug")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/virtio/virtio_mem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 11c4415..82a285c 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -423,14 +423,14 @@ static int virtio_mem_bbm_bb_states_prepare_next_bb(struct virtio_mem *vm)
 }
 
 #define virtio_mem_bbm_for_each_bb(_vm, _bb_id, _state) \
-	for (_bb_id = vm->bbm.first_bb_id; \
-	     _bb_id < vm->bbm.next_bb_id && _vm->bbm.bb_count[_state]; \
+	for (_bb_id = (_vm)->bbm.first_bb_id; \
+	     _bb_id < (_vm)->bbm.next_bb_id && (_vm)->bbm.bb_count[_state]; \
 	     _bb_id++) \
 		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
 
 #define virtio_mem_bbm_for_each_bb_rev(_vm, _bb_id, _state) \
-	for (_bb_id = vm->bbm.next_bb_id - 1; \
-	     _bb_id >= vm->bbm.first_bb_id && _vm->bbm.bb_count[_state]; \
+	for (_bb_id = (_vm)->bbm.next_bb_id - 1; \
+	     _bb_id >= (_vm)->bbm.first_bb_id && (_vm)->bbm.bb_count[_state]; \
 	     _bb_id--) \
 		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
 
-- 
2.9.4

