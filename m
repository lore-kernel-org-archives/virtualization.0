Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E625349B1F
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296612; cv=none; b=dgS9ul6E8k6OToTa1JAvH1Tty63Dv7PeD3B9yyWSGBMC2TeF4eYY7vQZtlHLZm019+qD2p7Ue1wj8WhYzD66SewozaiVDxLpIx/bIirI8iKIHqlEGo1d9rl7rGH06MXxS1GAPG1pFqQFF5xYjL69DpeoKIU27oR5cI87tYnUEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296612; c=relaxed/simple;
	bh=Oh/XpTidoQghNh59ad6G5XHAWHK7Oz8h0TNkk9miBPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTDHik/A73A3rEdOt9wMyJZ/ZdPW3p9Ik7aJmpZRxQBo8GrxpMRNVxPXdR8ZogdQqL4li9qUu2OShpW+2iY0exIDiGyMv5XzsVttLT+p6lOlrJt/BI7U2xBdRHdxE4Ap2sBl4Ozl5ooLVMErr9cNV2He15cXxY16rnr0q1iaMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1cc5b50a5d8611f1aa26b74ffac11d73-20260601
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_UNTRUSTED
	SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9141a37e-99f4-4c68-bf0c-8f204331b8a1,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:9141a37e-99f4-4c68-bf0c-8f204331b8a1,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:f5e781a86ea50dcfb8d7a5270d7ec517,BulkI
	D:2606011450037SPS48DF,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1cc5b50a5d8611f1aa26b74ffac11d73-20260601
X-User: lihongtao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <lihongtao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2054400866; Mon, 01 Jun 2026 14:50:01 +0800
From: Hongtao Lee <lihongtao@kylinos.cn>
To: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Hongtao Lee <lihongtao@kylinos.cn>
Subject: [PATCH] drm/qxl: fix local_gobj leak in qxl_gem_object_create_with_handle
Date: Mon,  1 Jun 2026 14:49:32 +0800
Message-Id: <20260601064932.227375-1-lihongtao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If drm_gem_handle_create fails, the reference count of local_gobj
will never be released, resulting in a leak of local_gobj.

Fixes: f64122c1f6ad("drm: add new QXL driver. (v1.4)")
Signed-off-by: Hongtao Lee <lihongtao@kylinos.cn>
---
 drivers/gpu/drm/qxl/qxl_gem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
index 4939b57a2a48..2bdff4cee952 100644
--- a/drivers/gpu/drm/qxl/qxl_gem.c
+++ b/drivers/gpu/drm/qxl/qxl_gem.c
@@ -99,8 +99,10 @@ int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
 	if (r)
 		return -ENOMEM;
 	r = drm_gem_handle_create(file_priv, local_gobj, handle);
-	if (r)
+	if (r) {
+		drm_gem_object_put(local_gobj);
 		return r;
+	}
 
 	if (gobj)
 		*gobj = local_gobj;
-- 
2.25.1

