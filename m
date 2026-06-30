Received: from outbound.baidu.com (mx20.baidu.com [111.202.115.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848AE299927
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795736; cv=none; b=EObJB4dYnlgL0Am62vuJ070Aak/ZfTEPlWegwCcII0Fr1DBev5doh5NxsmcG3NHIRxDg13/ScoqKyNDziBELY61oEMSMf62W4JP3G2uEjelkdMtGKNQztbu3yRsgUm9kWARrF/C0jrr6hGmnz5LbodmsGVEBPlcoaaiZGlO8hcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795736; c=relaxed/simple;
	bh=OkiZFf5CzVRp4+/LGGSfiPdpxdnJIPRDxhcZIH5nOCY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oxqHQcWnEQLJZq02ikbSHt7mvM8TWTeW4J7vEUDjg1VJqGwWL1Wn+vv8ds7zFDjklIqQGoBLysOrrm5sgbgUptrv/SuxqOIhL/YcwYkzdEktMWtTQDTDGoJljOr5ApWL126/dIFx/ktrEi+TGXTTdUK3ZdKOfOhyDcrjI4wOoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=mw+FLgho; arc=none smtp.client-ip=111.202.115.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="mw+FLgho"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: David Hildenbrand <david@kernel.org>, "Michael S . Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v2] virtio_mem: fix hardcoded 'vm' variable in bbm iteration macros
Date: Tue, 30 Jun 2026 12:59:52 +0800
Message-ID: <20260630045952.2188-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc14.internal.baidu.com (172.31.4.12) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1782795602;
	bh=qJJIYCHO+t3AFM9u2YeN//KfUnYWWc9YJwl+4wfDh/U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=mw+FLghor0B3ld1lHEWAtg0W/gZVlBGLGQ2vRugnOOPITbvlYPZ4rZKRnL8bu/mbR
	 VuqDlml+DslZkJfyGwLKcai/YmdYMFcK8KXZ9FkArX34MOPgSu4C0MR7t2OKzuG3IE
	 V4gD1tKIlaH6/RsfvRATlNTcuQg/gBjHZ0n1+576EKI/s/Q9hDtaqXhMGw+mZEvP7u
	 lgfDdP6U+CtWLtudeMXtBGld1+RqsgNiHeuJO8neHDQOmZU5JXeb2dGc4uqU299S30
	 OSwricuP13ib1AJZAKcC9gnofs6p26786W092pgGWwIGRpIEMbz3MCgpFXpxg0Sbj8
	 J/cdPqNNrZmAA==

From: Li RongQing <lirongqing@baidu.com>

virtio_mem_bbm_for_each_bb() and virtio_mem_bbm_for_each_bb_rev()
accept a '_vm' parameter to allow callers to pass any variable name
referring to the virtio_mem instance. However, the 'for' loop
initializer and part of the loop condition use the bare name 'vm'
instead of the macro parameter '_vm'.

Fix by replacing all bare 'vm->' references inside the macros with
the '_vm' parameter, and wrap in parentheses following kernel macro
conventions.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
diff with v1: drop the Fixes tag, since there is no user-visible bug

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

