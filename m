Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF335C181
	for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259067; cv=none; b=TUqunEYvkBX8ghO5gQRmKPkp/GngH2Xn+95SOfg26byUgzPFRK0GZVn1xxAUpW6tkpG9dYk3oMyKiVbSmX7TndNI4PLQlcfTtSntIXMK7Og9ki9YBe75J7VzKHoePYEg9mtb3wdXfi4b+MeFSvZmOAeGR7dQZ+nKjtmrLrAfYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259067; c=relaxed/simple;
	bh=rJAdK/ogPRx5IKWx8AL6KURRAQlzWUx657ZfddCtzh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eQ4JkoV62n2dm4vjDmIxKn+WaBt1OFceD1KxJr48DEgiZB0l1Dcqc3JsoRt15dq+plMO3q7WBOfWVH4Cl6NaiCu0gWuQlAm3EUg/zNhUq80ov39lvt1wy0Oa4GOiHh2oMDKKnh/0mSp7rJX/e+HT9KQHQW57lfD9d6Q5tJk0FZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dc16db76269c11f1a21c59e7364eecb8-20260323
X-CTIC-Tags:
	HR_CC_CHARSET, HR_CC_CHARSET_NUM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME
	HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:337ae9fa-fd2e-44d4-a02f-0eea6ed5c4da,IP:15,
	URL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-15
X-CID-INFO: VERSION:1.3.11,REQID:337ae9fa-fd2e-44d4-a02f-0eea6ed5c4da,IP:15,UR
	L:0,TC:0,Content:-5,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACT
	ION:release,TS:-15
X-CID-META: VersionHash:89c9d04,CLOUDID:3459a9c1411b80ab212c4f690e93f732,BulkI
	D:260323174418J3AROAJ5,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dc16db76269c11f1a21c59e7364eecb8-20260323
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1571188595; Mon, 23 Mar 2026 17:44:17 +0800
From: Li Wang <liwang@kylinos.cn>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH 1/3] virtiofs: Only parse the out header if the request expects a reply in virtio_fs_request_complete()
Date: Mon, 23 Mar 2026 17:43:15 +0800
Message-Id: <20260323094317.46302-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of req->out.h may be undefined when FR_ISREPLY is not set.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/virtio_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2f7485ffac52..dec2c5a30e4e 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -789,7 +789,8 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	struct folio *folio;
 
 	args = req->args;
-	copy_args_from_argbuf(args, req);
+	if (test_bit(FR_ISREPLY, &req->flags))
+		copy_args_from_argbuf(args, req);
 
 	if (args->out_pages && args->page_zeroing) {
 		len = args->out_args[args->out_numargs - 1].size;
-- 
2.34.1

