Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A31A2C0B
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 01:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784511934; cv=none; b=r/iNIFe3VAkGze5GeSQFTqKdVHGTZv/lXjpP93G7Qyx8y0P+M0jAoevmgAsXbJW24CJQOG2Chx+3CsVNyCgjBCqtYWeUPAEozP3Tg0Mjr+1xUj5I9UmfYP2gZEYmNQStgZ96HVuBz7EKCy6xBLsBP8dd1vplHBdCgrPyM5pdgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784511934; c=relaxed/simple;
	bh=TcUTU6KUeyc85lS+CmhEnG9mAPDncuDfyKhnFwBD3v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlnxUvLdc+8ptxBPMxmljCPegVGVb3CZ3pvv379HBn108Mx48+RTlsgjrRpUNrRw8WfAgcP4zMRQ54tuFPTdxnNxgGaAfoB2cvIgWIv/6CUYVZ/Zu+pvA982GIqm+QhaJmdRJ/vQeFd5sYQ7tvFLl1R+z8gm8aAXx4y4NzMPfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aef0cf2e83dc11f1aa26b74ffac11d73-20260720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7e3be762-4c5f-4616-9ece-5db897dd086a,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:7e3be762-4c5f-4616-9ece-5db897dd086a,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:467a629bc8b23324f18d21987e2b5685,BulkI
	D:2607200945284KZMCPXS,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|136
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aef0cf2e83dc11f1aa26b74ffac11d73-20260720
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 878527352; Mon, 20 Jul 2026 09:45:27 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	virtualization@lists.linux.dev
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/virtio: Fix control typo in trace agent comment
Date: Mon, 20 Jul 2026 09:45:06 +0800
Message-ID: <20260720014506.90012-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a misspelling of "control" in the trace agent controller description.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 tools/virtio/virtio-trace/trace-agent-ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio-trace/trace-agent-ctl.c b/tools/virtio/virtio-trace/trace-agent-ctl.c
index 39860be6e2d8..9577579e86da 100644
--- a/tools/virtio/virtio-trace/trace-agent-ctl.c
+++ b/tools/virtio/virtio-trace/trace-agent-ctl.c
@@ -84,7 +84,7 @@ static int wait_order(int ctl_fd)
 }
 
 /*
- * contol read/write threads by handling global_run_operation
+ * control read/write threads by handling global_run_operation
  */
 void *rw_ctl_loop(int ctl_fd)
 {
-- 
2.43.0

