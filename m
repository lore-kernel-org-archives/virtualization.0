Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F619269D18
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784511891; cv=none; b=nQkvpJvRTmyvAFhy8Cz3MNiQO3/uiQcVOtq1sfT1+0Y6vCNfsXEsmRaCAEcyA/bk/vil9rTILwgiB/7vLNathcR7Pn/b39Hfqi9NUHBTENSt/ZUQrmTM52IV9RFhr5O4KiB8i7pupoKanPZ/gTi1QtQLZUH2ZUkhQjLrMzKtDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784511891; c=relaxed/simple;
	bh=nLduh6UdssmlYKM+YlSAjaAFXMNCcVD2DymTVDY3etc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aaWt664VMuJ91f6pzWkEUWMZLB+EBv/8S7kW7x1MfGf4Vjkwn8I0z/Ew4nfcsuh6PLMTT3dSyQZ6A1boboDgSz0mA4TcARSWF+HUPNZX59M8EMPepNeY93y1nAoYimUqSAF48zcoONEvj6coxLKj3ZNh4rZvLaI/DgzYmX7tBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 94712ee683dc11f1aa26b74ffac11d73-20260720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ed83b07c-53f0-4fbb-b88e-3c4cf4120b75,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:ed83b07c-53f0-4fbb-b88e-3c4cf4120b75,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:8ce0d1e95a17bcfa71a4d38b0a21132a,BulkI
	D:260720094443HI1UAQ5S,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|136
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 94712ee683dc11f1aa26b74ffac11d73-20260720
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 488842144; Mon, 20 Jul 2026 09:44:43 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	virtualization@lists.linux.dev
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/virtio: Fix userspace typo in vringh test comment
Date: Mon, 20 Jul 2026 09:44:21 +0800
Message-ID: <20260720014421.89345-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a misspelling of "userspace" in the vringh test description.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 tools/virtio/vringh_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 5ea6d29bc992..84961b9ab5ff 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Simple test of virtio code, entirely in userpsace. */
+/* Simple test of virtio code, entirely in userspace. */
 #define _GNU_SOURCE
 #include <sched.h>
 #include <err.h>
-- 
2.43.0

