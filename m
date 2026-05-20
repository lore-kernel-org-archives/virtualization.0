Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895C3A3E9C
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272622; cv=none; b=gasDwv6qjtemQQXrNIWRVGD4vTr7AMx+3oNNY4+G8DRKiSymu3w3mE8Ncs0P80agSIbnEWWah4YWJbFdPIk+Kb1zKqkGQ8nZgwbHXHu8ZDEnJNRZWqz9yDwY0XgkF2l98ApV9VcPGGsZKf4sAFfZF1bxY590CiP1uFjtH7rMGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272622; c=relaxed/simple;
	bh=buFAK622RUf2B99NU5lPay+j4O6wt+YVG6kZtAFnMGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mjGDifiJ8hpw2prQelMeNOiABORwegIkxi3ZWPszpFgret6DyyqQef8TjcIlwk7lcX92bWl0DSyCnCwmBosdBr7xux4PhVrYxwB+iQnw4fzBYvqc6JoO9uX9n7NCYc3duNdX/YnTk27HqsTrCrqIpRyIlDmJ0Ofl2yZGi4IU/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f15b7f48543511f1aa26b74ffac11d73-20260520
X-CTIC-Tags:
	HR_CC_CHARSET, HR_CC_CHARSET_NUM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME
	HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:458f69c0-8246-461d-9447-c485a63d6094,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:458f69c0-8246-461d-9447-c485a63d6094,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:1aeb9567a38d2aff9bf5a5fc5380f29c,BulkI
	D:2605201823297I8PVFTJ,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f15b7f48543511f1aa26b74ffac11d73-20260520
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1216649932; Wed, 20 May 2026 18:23:28 +0800
From: Li Wang <liwang@kylinos.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] virtio_net: drop redundant err assignment in virtnet_probe()
Date: Wed, 20 May 2026 18:23:09 +0800
Message-Id: <20260520102309.281616-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

err is initialized to -ENOMEM at the start of virtnet_probe(), and no
code path between that and the devm_kzalloc() failure can change
err. Assigning -ENOMEM again before goto free therefore is redundant.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 drivers/net/virtio_net.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..1fbafca90e4c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6853,10 +6853,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 				rss_max_indirection_table_length));
 	}
 	vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
-	if (!vi->rss_hdr) {
-		err = -ENOMEM;
+	if (!vi->rss_hdr)
 		goto free;
-	}
 
 	if (vi->has_rss || vi->has_rss_hash_report) {
 		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
-- 
2.34.1

