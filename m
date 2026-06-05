Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5A305677
	for <virtualization@lists.linux.dev>; Fri,  5 Jun 2026 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625726; cv=none; b=IXOTsFni7s0K8LbbJPI6jgaBryff/v6+WFtCscKSsTTEvNunSYlw5aQBirudknuE+RZ16DpNiZDfJj2b4X/48WfQWtgh5ug5dobw+Y4N3jVwn3FNUn2BahsjmQQnYXDlKbhOX6HAFPAFGyLUbX7QtRs28vjErPoDjdVoieU7PHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625726; c=relaxed/simple;
	bh=bohjQ9jZ2ClPVwKHNimprZaljP7TAA1qrQVeNj8lr9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYVFJAi9aE8icImbfk478UDlZ2rbTR6+oeouEQdX9xmdPVO1hTVX9hon9zPtpbtLba7KBlpPlQ/0QuuI++/1+lfo1xcNA+0hE5C2YuAliuf73n7QBnEDgf6AFNSRSNMvJITtUcbtaovXwn7x6XcfSGgFSavntkMkKvl/zKlP9Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 60e36cea608411f1aa26b74ffac11d73-20260605
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9294a2a0-cfb0-4b4b-a7a0-bb67836f8ba2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:952cd51ce2734c5f02b4ff67503fb143,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 60e36cea608411f1aa26b74ffac11d73-20260605
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 331705679; Fri, 05 Jun 2026 10:15:10 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	linux-kernel@vger.kernel.org,
	longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] tools/virtio: check mmap return value in vringh_test
Date: Fri,  5 Jun 2026 10:14:45 +0800
Message-ID: <20260605021446.1611-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In parallel_test(), the return values of mmap() for both host_map and
guest_map are not checked against MAP_FAILED. If mmap() fails, the
subsequent code will dereference the invalid pointer, leading to a
segmentation fault.

Add MAP_FAILED checks after both mmap() calls, using err() to report
the error and exit, consistent with the existing error handling style
in this file (e.g., the open() call on line 149).

Fixes: 1515c5ce26ae("tools/virtio: add vring_test.")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 tools/virtio/vringh_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index b9591223437a..8cc5ca6c7cca 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -159,7 +159,12 @@ static int parallel_test(u64 features,
 
 	/* Parent and child use separate addresses, to check our mapping logic! */
 	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (host_map == MAP_FAILED)
+		err(1, "mmap host_map");
+	
 	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (guest_map == MAP_FAILED)
+		err(1, "mmap guest_map");
 
 	pipe_ret = pipe(to_guest);
 	assert(!pipe_ret);
-- 
2.43.0

