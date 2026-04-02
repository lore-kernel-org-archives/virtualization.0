Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A8338759C
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126688; cv=none; b=dcUzg0Vi/2gLkSch7xz0OuXZo0g0gS7NruHW4tibD+QBp4hJEtBZdpimKK2jyF4hlJc9DoYG+56chW+ZpSmAj8NxZS2MTNZp6T1wKlE+1He5F2XFtiaxDEHVqad7kNrhtpf8V9UPjLDt2FuRTpXCtlgxp0Blu+wTfsCjBBfxA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126688; c=relaxed/simple;
	bh=WzRe1ElaUiAZDAUD8Z0ySaPxpPd+WFxyUUpzV0o7Zio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZelLLdRO7LL/y+icJSNDU+j2NA+6Q2OCxnz6TLHEQHGWAdflqOGy2sejVOHS08+QxSyHZc29fGgllgSmwL60EzgFtdOVMz3xsgfo/FY0Gwt9Szru6PxVIRkzO3zXC85ThLNo6wn4ReYHKM/1bIhFVTlJymCILxo5khFfJNiG7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f26ba7122e8011f1aa26b74ffac11d73-20260402
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
X-CID-O-INFO: VERSION:1.3.12,REQID:66c2cf4e-e278-4ec1-a7b6-b3b14bee27f6,IP:15,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.3.12,REQID:66c2cf4e-e278-4ec1-a7b6-b3b14bee27f6,IP:15,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-10
X-CID-META: VersionHash:e7bac3a,CLOUDID:92d79792e484e174e3910bbc4cb8855b,BulkI
	D:26040218444103Q64BWE,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f26ba7122e8011f1aa26b74ffac11d73-20260402
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 473390074; Thu, 02 Apr 2026 18:44:38 +0800
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
Subject: [PATCH v2 2/3] virtiofs: Retry hiprio FORGET when virtqueue_add_outbuf() returns -ENOMEM
Date: Thu,  2 Apr 2026 18:44:06 +0800
Message-Id: <20260402104407.11495-3-liwang@kylinos.cn>
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

The -ENOMEM from virtqueue_add_outbuf() under GFP_ATOMIC is typically transient.  
Queue the FORGET on queued_reqs and return 1 so the hiprio worker backs off and 
retries instead of dropping the forget.

This matches the existing -ENOSPC handling and avoids silent loss of
nlookup decrements under memory pressure.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/virtio_fs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bcba1210c797..7e4c3fa6ab57 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -611,8 +611,8 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 }
 
 /*
- * Returns 1 if queue is full and sender should wait a bit before sending
- * next request, 0 otherwise.
+ * Returns 1 if the hiprio queue is full or transient allocation failed and
+ * the caller should wait before submitting the next FORGET, 0 otherwise.
  */
 static int send_forget_request(struct virtio_fs_vq *fsvq,
 			       struct virtio_fs_forget *forget,
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
+			/* Queue full or GFP_ATOMIC allocation failure; retry later */
 			ret = 1;
 		} else {
 			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
-- 
2.34.1

