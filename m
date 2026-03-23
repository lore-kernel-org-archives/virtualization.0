Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDAC311C32
	for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259067; cv=none; b=TU9E0f/RXQkXsU0ts8UiW2l12bQfkYyO1YAvAFBU9KsujhJgIsTCyKRElkTLI6/e1sTZRXJD0McE1WiYZjvmYHLIBRxJgqQTJlX13tl13l9YmiwWEV5rrg8932Pbl5OMKz078tXtXSXgtCLefU7DUA+ciBV6Mk4WKLLw/cPAwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259067; c=relaxed/simple;
	bh=nbsP56HSK93EH2En1k7PpAwa7t8BLufF22T8eqvjX3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtZu10lnoE7mHzKYLz70U+y3h8e5Cm78g/+4SXYs+yK5ADaobelJmdMPfT1hb33NEimJeo4Ys6D5jkO49lNzStlRLv8nQHN7g6JRBGgirf9/b67ECUqzFla0PtViLwlpwb4St/9po5v34w4PAD9zlr6WYYKkfFCd2KjZas6vvBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dc679e30269c11f1a21c59e7364eecb8-20260323
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
X-CID-O-INFO: VERSION:1.3.11,REQID:5acb0383-1fe8-49ec-8de7-8a8f70941f68,IP:15,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.3.11,REQID:5acb0383-1fe8-49ec-8de7-8a8f70941f68,IP:15,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-10
X-CID-META: VersionHash:89c9d04,CLOUDID:9c416e2cd51e2382c5b9f4b49e80efd7,BulkI
	D:260323174418KTUTO7E6,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dc679e30269c11f1a21c59e7364eecb8-20260323
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 674610884; Mon, 23 Mar 2026 17:44:17 +0800
From: Li Wang <liwang@kylinos.cn>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH 2/3] virtiofs: Allow ENOMEM requests to wait and retry later in send_forget_request()
Date: Mon, 23 Mar 2026 17:43:16 +0800
Message-Id: <20260323094317.46302-2-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323094317.46302-1-liwang@kylinos.cn>
References: <20260323094317.46302-1-liwang@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow ENOMEM requests to wait and retry later,
rather than dropping them.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/virtio_fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index dec2c5a30e4e..bf043e698e0d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -611,7 +611,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 }
 
 /*
- * Returns 1 if queue is full and sender should wait a bit before sending
+ * Returns 1 if queue or memory is full and sender should wait a bit before sending
  * next request, 0 otherwise.
  */
 static int send_forget_request(struct virtio_fs_vq *fsvq,
@@ -638,13 +638,13 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 
 	ret = virtqueue_add_outbuf(vq, &sg, 1, forget, GFP_ATOMIC);
 	if (ret < 0) {
-		if (ret == -ENOSPC) {
+		if (ret == -ENOSPC || ret == -ENOMEM) {
 			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
 				 ret);
 			list_add_tail(&forget->list, &fsvq->queued_reqs);
 			if (!in_flight)
 				inc_in_flight_req(fsvq);
-			/* Queue is full */
+			/* Queue or memory is full */
 			ret = 1;
 		} else {
 			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
-- 
2.34.1

