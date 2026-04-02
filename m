Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3C3DA7F3
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126688; cv=none; b=D6IBfa/+LpWVhfH0bIsQ/ahWvH/yndlbSYx+NFVpNCBHI10BQfrA3kHUHbLkdXRxkCMVP83D3YXvygi2Qe/L3pstuyQdYrES335HEg5A5NBnoYDF/jL83X1YYv3yJdWk8PD5gGfmaHCSB+dFBBcthfVw1N77letbPjkax2wY7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126688; c=relaxed/simple;
	bh=5PFh6V4gKMSpoESN4wCoiOoII2jBB2X46Gjroqd9iQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkQRK2WNm9G5hkPuPQZ7BdW38FCdKMKwGA2Knyb480xTZwvJ1HLR5Qx6f+GTapTq1Dcf8rL0HqdnzeAj1hPAFKJxgXuCKGLn+Jwz9Rze6zPC3IS3UPZx/jlu9AaFyTy/WRDpVphu+UwB538fqPaGVD19+Ax8IJeN/SnKnfqFx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f2b016fe2e8011f1aa26b74ffac11d73-20260402
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
X-CID-O-INFO: VERSION:1.3.12,REQID:7ca2c72d-27e8-4cdf-a593-f8ba4eb488dc,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:7ca2c72d-27e8-4cdf-a593-f8ba4eb488dc,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:ca62bdcd35601c49de025a87bcae02a7,BulkI
	D:260402184441ODBCS86Z,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f2b016fe2e8011f1aa26b74ffac11d73-20260402
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2063312767; Thu, 02 Apr 2026 18:44:38 +0800
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
Subject: [PATCH v2 3/3] virtiofs: Do not stall hiprio FORGET dispatch after dropping one request
Date: Thu,  2 Apr 2026 18:44:07 +0800
Message-Id: <20260402104407.11495-4-liwang@kylinos.cn>
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

send_forget_request() documents return value 1 as caller should wait;
virtio_fs_hiprio_dispatch_work() treats any non-zero return as a signal to
stop processing the rest of queued_reqs.

When virtqueue_add_outbuf() fails with a non-recoverable error we kfree the
forget but left ret negative, so the worker returned early and stranded
subsequent queued FORGETs.  Return 0 after dropping so the queue keeps
draining.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/virtio_fs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 7e4c3fa6ab57..e5d3d58a760c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -652,6 +652,12 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 			kfree(forget);
 			if (in_flight)
 				dec_in_flight_req(fsvq);
+			/*
+			 * send_forget_request() returns 1 to mean "stop draining
+			 * queued_reqs for now".  A negative value is also non-zero
+			 * and would stall the worker after one dropped forget.
+			 */
+			ret = 0;
 		}
 		goto out;
 	}
-- 
2.34.1

