Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBB34CFC5
	for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259067; cv=none; b=DiSR7fB+K4cylZLo+2cUNAocSExaPfiyDB/VA51LSOPdN7Nv4eCMjAWfHNVP+fArxNaty1DdXsD278RyFE5Vxc2asBSQIBzwOdPI865NKwkFlB+hy+Pv41t3rNqYQ4CLVLBJ53V6hAvqyrst8pM0kDHWeV1TTmt1rux624omG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259067; c=relaxed/simple;
	bh=8BK4qVinyfVk3p6PxoeRFaivBMDuhw3x6tfbO4/wpX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTaIpEvZ+ElRDJdv8hlugC8GdTVGQ0v5xf7+dWwL2HyipK/CremtKu5BzaKcc62d6Cy3JrhriBpSuKAR7Ho3ejIPBvUABlGYuLDKAHcmYCe7YIG3cvcyU3oLbdpIYrcgS2cdU5980G1WHRdyZHFXCix9fZGI1f/iWy67vcrIajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dcba1f52269c11f1a21c59e7364eecb8-20260323
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
X-CID-O-INFO: VERSION:1.3.11,REQID:0e0ea955-6b2c-468c-88ef-e7306e975c81,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.11,REQID:0e0ea955-6b2c-468c-88ef-e7306e975c81,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:89c9d04,CLOUDID:0a7fb020f2746505abbb7d7e08eb11f4,BulkI
	D:2603231744185YVK77XQ,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dcba1f52269c11f1a21c59e7364eecb8-20260323
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 890510056; Mon, 23 Mar 2026 17:44:18 +0800
From: Li Wang <liwang@kylinos.cn>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH 3/3] virtiofs: Distinguish between 1 and negative return values in send_forget_request()
Date: Mon, 23 Mar 2026 17:43:17 +0800
Message-Id: <20260323094317.46302-3-liwang@kylinos.cn>
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

If virtqueue_add_outbuf() returns negative error codes other than
-ENOSPC and -ENOMEM, allow subsequent requests to proceed,
aligning with the comments in send_forget_request().

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/virtio_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bf043e698e0d..7b283db76f3f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -652,6 +652,7 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 			kfree(forget);
 			if (in_flight)
 				dec_in_flight_req(fsvq);
+			ret = 0;
 		}
 		goto out;
 	}
-- 
2.34.1

