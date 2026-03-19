Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0242385509
	for <virtualization@lists.linux.dev>; Thu, 19 Mar 2026 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889010; cv=none; b=LhM4J8qSwZLtAoA8EASL2FVmRuLx5cd2hXkbjBRBFUwDQmcW8qxw3RP2Xa551Vj55X1Jsl5OEmOC943IqvJuP3jeMqn3kHoVpzOBdaW044qXQ8bgU2qOMRO8kdy0b47Ul8/qq/sytjiBdV3GLXVeEtl6suROXRRKVQxDjjsvvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889010; c=relaxed/simple;
	bh=bXivs8IXt1WcC0X4WuaLBLSrVtXzJ6R+1TwhLBSFQUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r83yodFo+nJT8K7T889Dc9UcxsJzzBLmx8p7hepk380Pdd33SxjsHiXx2Gowf9PA0Mg2n1pFeszgBmx4s1Lmw5/RJVGLpMncdClo4/nn1B5uLEY4+YU0XACMWkJ+8rO+j2DD9fpWweeZ05s+2iajG5XE9BXTDirykWgAh+Gf2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3fd2dbc6233f11f1a21c59e7364eecb8-20260319
X-CTIC-Tags:
	HR_CC_CHARSET, HR_CC_CHARSET_NUM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME
	HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:9dca0f34-a6b9-4c12-bcbf-31fad11e29a5,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-INFO: VERSION:1.3.11,REQID:9dca0f34-a6b9-4c12-bcbf-31fad11e29a5,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:20
X-CID-META: VersionHash:89c9d04,CLOUDID:b19740625739cf7cbda76a7cc9e0d1ef,BulkI
	D:26031910564090RU6KMI,BulkQuantity:0,Recheck:0,SF:19|38|66|72|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3fd2dbc6233f11f1a21c59e7364eecb8-20260319
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1790803102; Thu, 19 Mar 2026 10:56:38 +0800
From: Li Wang <liwang@kylinos.cn>
To: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] virtiofs: Verify that server properly follows FUSE protocol
Date: Thu, 19 Mar 2026 10:56:09 +0800
Message-Id: <20260319025609.10721-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that server properly follows FUSE protocol, by checking
oh.uniq and oh.len.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/virtio_fs.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 057e65b51b99..c30f6f58664c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -768,10 +768,34 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	struct folio *folio;
 
 	/*
-	 * TODO verify that server properly follows FUSE protocol
+	 * Verify that server properly follows FUSE protocol
 	 * (oh.uniq, oh.len)
 	 */
 	args = req->args;
+	if (test_bit(FR_ISREPLY, &req->flags)) {
+		struct fuse_out_header *oh = &req->out.h;
+
+		if (unlikely(oh->unique != req->in.h.unique)) {
+			pr_warn_ratelimited("virtio-fs: bad reply unique %llu (expected %llu)\n",
+					    oh->unique, req->in.h.unique);
+			oh->error = -EIO;
+			oh->len = sizeof(*oh);
+			goto out;
+		}
+		unsigned int num_out = args->out_numargs - args->out_pages;
+		unsigned int cap = sizeof(req->out.h);
+
+		cap += fuse_len_args(num_out, args->out_args);
+		if (args->out_pages)
+			cap += args->out_args[args->out_numargs - 1].size;
+		if (unlikely(oh->len < sizeof(*oh) || oh->len > cap)) {
+			pr_warn_ratelimited("virtio-fs: bad reply len %u (cap %u)\n",
+					    oh->len, cap);
+			oh->error = -EIO;
+			oh->len = sizeof(*oh);
+			goto out;
+		}
+	}
 	copy_args_from_argbuf(args, req);
 
 	if (args->out_pages && args->page_zeroing) {
@@ -790,6 +814,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 		}
 	}
 
+out:
 	clear_bit(FR_SENT, &req->flags);
 
 	fuse_request_end(req);
-- 
2.34.1

