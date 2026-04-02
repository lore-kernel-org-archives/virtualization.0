Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678D3D47BA
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126689; cv=none; b=KGtxVgy/DIsL4c5leUAo8whQzj7yyaf7XaMEEas16wS5EacDFFQOOHwNRxfPX6XzyX4bOaubONYp1j28oOOIFv4UaRXOdUsxxntbTsfG4Z+vfXPIGvuGPsSYCZ6DWZKmmEazYMKE9M9x96krUjx9dxonzshXBzxNLQh8Vi/P91w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126689; c=relaxed/simple;
	bh=XIa89S023CaUoNLWL6GinBrdvk2MjM5r1KO8AotMdxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXObfOEeM+BaWUE75IVHn5EXM65Qro2VOAPh2fR6qojTv9/hxMu7oH8l1FFMVwi/u3E35vq/IdYmcoXGWNT3pC7uoz65NwD+CyArC3wL4cRfGDS0BMvrZJyFIvX0+RUBwfOY5xXN7N/IvCNI4vw5DQXco2VEjA3XCKEvhZ2JdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f223c82a2e8011f1aa26b74ffac11d73-20260402
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
X-CID-O-INFO: VERSION:1.3.12,REQID:65256d18-e980-40df-8c39-445b830bf290,IP:15,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:65256d18-e980-40df-8c39-445b830bf290,IP:15,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:c271b9ba7d1ad6333697e6251a11e643,BulkI
	D:260402184439L5RY49OW,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f223c82a2e8011f1aa26b74ffac11d73-20260402
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1784249598; Thu, 02 Apr 2026 18:44:37 +0800
From: Li Wang <liwang@kylinos.cn>
To: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH v2 1/3] virtiofs: Complete no-reply virtio requests without parsing the out header
Date: Thu,  2 Apr 2026 18:44:05 +0800
Message-Id: <20260402104407.11495-2-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402104407.11495-1-liwang@kylinos.cn>
References: <20260402104407.11495-1-liwang@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUSE requests that do not set FR_ISREPLY never map fuse_out_header or reply
payload into the virtqueue in virtio_fs_enqueue_req(). For example,
for the FORGET requests sent in fuse_force_forget(), req->out.h.len is 
initialized to 0 in fuse_request_alloc(). On completion, copy_args_from_argbuf() 
must not run: it subtracts sizeof(fuse_out_header) from req->out.h.len, 
which will cause an underflow.

Always free the bounce buffer allocated by copy_args_to_argbuf() on the
no-reply path so virtio_fs_enqueue_req() does not leak argbuf.

In virtio_fs_requests_done_work(), only call virtio_fs_verify_response()
when FR_ISREPLY is set.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/virtio_fs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2f7485ffac52..670dd413873b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -789,7 +789,13 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	struct folio *folio;
 
 	args = req->args;
-	copy_args_from_argbuf(args, req);
+	if (test_bit(FR_ISREPLY, &req->flags))
+		copy_args_from_argbuf(args, req);
+	else if (req->argbuf) {
+		/* Bounce buffer from virtio_fs_enqueue_req(); no reply payload to copy */
+		kfree(req->argbuf);
+		req->argbuf = NULL;
+	}
 
 	if (args->out_pages && args->page_zeroing) {
 		len = args->out_args[args->out_numargs - 1].size;
@@ -841,9 +847,11 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		virtqueue_disable_cb(vq);
 
 		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
-			if (!virtio_fs_verify_response(req, len)) {
-				req->out.h.error = -EIO;
-				req->out.h.len = sizeof(struct fuse_out_header);
+			if (test_bit(FR_ISREPLY, &req->flags)) {
+				if (!virtio_fs_verify_response(req, len)) {
+					req->out.h.error = -EIO;
+					req->out.h.len = sizeof(struct fuse_out_header);
+				}
 			}
 			spin_lock(&fpq->lock);
 			list_move_tail(&req->list, &reqs);
-- 
2.34.1

