Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CA371CEE
	for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253740; cv=none; b=Ew23iBQDH+phC0jGOgewUiibVdWQdNh5kIkZ0RFn+k9PFbiRQVNO1ARuQNOI9NrN/+lsmo0gQhTpFaJp/+0DVdJGvU0OrhXzZZ6nBTU19l2KTl4AvI9eXo9bWTD7UoR2BBXB1YfbUs5hUqp5kUrj6CvzQ57xTBGKfK/4nqMp0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253740; c=relaxed/simple;
	bh=xEpagjC+ESFiVSiy6V/kk8Mx1Sqha4yNdnTcjZcElO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=djDjr5aS7ARaFeBDzdOEEfV7mKNy2Kk25N2J2YqgVq5BD0x2UDHd+gxT37XTY70BSkFyf8rMVRhfWOu2YyqlcTkOMiO0XsgXmufSd6Dn4G0RBnMmApqAc1Qx2a3uep1sA7MOm49r4Xb9nD1gPCXnxcxqW+WNa2JG75bIvK6wPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 73b08aac269011f1a21c59e7364eecb8-20260323
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
X-CID-O-INFO: VERSION:1.3.11,REQID:aa7f9f52-97d6-4e9d-a741-f0857b60e7cd,IP:15,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.3.11,REQID:aa7f9f52-97d6-4e9d-a741-f0857b60e7cd,IP:15,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:89c9d04,CLOUDID:d34907b49ed43b6d0de7be9f2f9e5875,BulkI
	D:260323161529THU1LDD5,BulkQuantity:0,Recheck:0,SF:19|38|66|72|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 73b08aac269011f1a21c59e7364eecb8-20260323
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 309912490; Mon, 23 Mar 2026 16:15:28 +0800
From: Li Wang <liwang@kylinos.cn>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] [PATCH v2] virtiofs: Strengthen FUSE protocol validation for server responses
Date: Mon, 23 Mar 2026 16:14:54 +0800
Message-Id: <20260323081455.38007-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. We should not trust the length value provided by the server;
2. Only replies have an out header/argbuf data to parse;
3. Some minor refinements for performance and log throttling.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/virtio_fs.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2f7485ffac52..c3f7f472f517 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -759,23 +759,31 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 }
 
 /* Verify that the server properly follows the FUSE protocol */
-static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
+static bool virtio_fs_verify_response(struct fuse_req *req)
 {
+	unsigned int num_out, cap;
+	struct fuse_args *args;
 	struct fuse_out_header *oh = &req->out.h;
 
-	if (len < sizeof(*oh)) {
-		pr_warn("virtio-fs: response too short (%u)\n", len);
+	if (!test_bit(FR_ISREPLY, &req->flags))
 		return false;
-	}
-	if (oh->len != len) {
-		pr_warn("virtio-fs: oh.len mismatch (%u != %u)\n", oh->len, len);
+	if (unlikely(oh->unique != req->in.h.unique)) {
+		pr_warn_ratelimited("virtio-fs: bad reply unique %llu (expected %llu)\n",
+					oh->unique, req->in.h.unique);
 		return false;
 	}
-	if (oh->unique != req->in.h.unique) {
-		pr_warn("virtio-fs: oh.unique mismatch (%llu != %llu)\n",
-			oh->unique, req->in.h.unique);
+	args = req->args;
+	num_out = args->out_numargs - args->out_pages;
+	cap = sizeof(req->out.h);
+	cap += fuse_len_args(num_out, args->out_args);
+	if (args->out_pages)
+		cap += args->out_args[args->out_numargs - 1].size;
+	if (unlikely(oh->len < sizeof(*oh) || oh->len > cap)) {
+		pr_warn_ratelimited("virtio-fs: bad reply len %u (cap %u)\n",
+					oh->len, cap);
 		return false;
 	}
+
 	return true;
 }
 
@@ -841,7 +849,7 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		virtqueue_disable_cb(vq);
 
 		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
-			if (!virtio_fs_verify_response(req, len)) {
+			if (test_bit(FR_ISREPLY, &req->flags) && !virtio_fs_verify_response(req)) {
 				req->out.h.error = -EIO;
 				req->out.h.len = sizeof(struct fuse_out_header);
 			}
-- 
2.34.1

