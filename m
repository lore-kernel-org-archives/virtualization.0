Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D1017BCC
	for <virtualization@lists.linux.dev>; Wed,  5 Jun 2024 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595654; cv=none; b=JEby/CeMi01HRN7L8WKs5vSv3M22XdmYTy1KPHGk+0dwLrVAJP2lj8Y0csjWOhOaVhf7kbaU5btKenhONzCpRvrr/GBsx32etf9WiVAnC8k/coOyxnrfr2/wR5g27uqkzxBxccZyZlCKar0h0AKxp46pMGI6kE4PMTr8W/26/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595654; c=relaxed/simple;
	bh=TXGHJ2+hUM24/BjFwCP02SOE7NoVVnR3kdLEdqV7maw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RkE4x6pkvxnRjFpCxKKcr5fBIT9+fYnpDQWvpJHAofQFMtkd3nAdDPUpsWkBzJ/gZxeOTtXU74I9ZDHZzlQXu9nzzJFHeIPJSf9LKPIhpVBC3RCOHEq1ihp9JKf8atZnFx1yjKT+VhH9mxO8CxMA2RyfEKlxXlJtgKHHlLwfsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 10030d24234311ef9305a59a3cc225df-20240605
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ce8cb58e-4250-420b-b5d4-48e8eb6962e6,IP:25,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-INFO: VERSION:1.1.38,REQID:ce8cb58e-4250-420b-b5d4-48e8eb6962e6,IP:25,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:20
X-CID-META: VersionHash:82c5f88,CLOUDID:c97b73ac3a0f892bfe4b6f8a75eb25d4,BulkI
	D:240605215401EJAVI5UO,BulkQuantity:0,Recheck:0,SF:38|24|72|19|44|66|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-UUID: 10030d24234311ef9305a59a3cc225df-20240605
X-User: cuitao@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 151872135; Wed, 05 Jun 2024 21:54:01 +0800
From: cuitao <cuitao@kylinos.cn>
To: mst@redhat.com,
	jasowang@redhat.com,
	virtualization@lists.linux.dev
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	linux-kernel@vger.kernel.org,
	cuitao <cuitao@kylinos.cn>
Subject: [PATCH] tools/virtio: Use the __GFP_ZERO flag of kmalloc to complete the memory initialization.
Date: Wed,  5 Jun 2024 21:52:45 +0800
Message-Id: <20240605135245.14921-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the __GFP_ZERO flag of kmalloc to initialize memory while allocating it,
without the need for an additional memset call.

Signed-off-by: cuitao <cuitao@kylinos.cn>
---
 tools/virtio/linux/kernel.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 6702008f7f5c..9e401fb7c215 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -66,10 +66,7 @@ static inline void *kmalloc_array(unsigned n, size_t s, gfp_t gfp)
 
 static inline void *kzalloc(size_t s, gfp_t gfp)
 {
-	void *p = kmalloc(s, gfp);
-
-	memset(p, 0, s);
-	return p;
+	return kmalloc(s, gfp | __GFP_ZERO);
 }
 
 static inline void *alloc_pages_exact(size_t s, gfp_t gfp)
-- 
2.25.1

