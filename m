Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73E1CE7A81
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 15:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77CE8415AD;
	Mon, 25 Sep 2023 15:07:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77CE8415AD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0_lXsKhBBv5T; Mon, 25 Sep 2023 15:07:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 06F654158E;
	Mon, 25 Sep 2023 15:07:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06F654158E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDEA9C0071;
	Mon, 25 Sep 2023 15:07:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7EA8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 15:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B97FD81F88
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 15:07:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B97FD81F88
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G0N5sSnGcbTh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 15:07:12 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6739F81F61
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 15:07:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6739F81F61
Received: from kwepemd200001.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RvR2Z3LZZzNnmH;
 Mon, 25 Sep 2023 23:03:18 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemd200001.china.huawei.com (7.221.188.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Mon, 25 Sep 2023 23:07:07 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.031;
 Mon, 25 Sep 2023 23:07:06 +0800
To: Herbert Xu <herbert@gondor.apana.org.au>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Topic: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Index: AdnvwZyqMOU4LXJLQHSIVFGYJFXR5Q==
Date: Mon, 25 Sep 2023 15:07:06 +0000
Message-ID: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: "Gonglei \(Arei\) via Virtualization"
 <virtualization@lists.linux-foundation.org>
Reply-To: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Doing ipsec produces a spinlock recursion warning.
This is due to not disabling BH during crypto completion function.

Fixes: 59ca6c93387d3 ("virtio-crypto: implement RSA algorithm")
Reported-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 3 ++-
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 2621ff8a9376..19e2898977d3 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -61,8 +61,9 @@ static void virtio_crypto_akcipher_finalize_req(
 	vc_akcipher_req->src_buf = NULL;
 	vc_akcipher_req->dst_buf = NULL;
 	virtcrypto_clear_request(&vc_akcipher_req->base);
-
+	local_bh_disable();
 	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
+	local_bh_enable();
 }
 
 static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *vc_req, int len)
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index 23c41d87d835..661c1102583e 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -566,9 +566,10 @@ static void virtio_crypto_skcipher_finalize_req(
 					 AES_BLOCK_SIZE, 0);
 	kfree_sensitive(vc_sym_req->iv);
 	virtcrypto_clear_request(&vc_sym_req->base);
-
+	local_bh_disable();
 	crypto_finalize_skcipher_request(vc_sym_req->base.dataq->engine,
 					   req, err);
+	local_bh_enable();
 }
 
 static struct virtio_crypto_algo virtio_crypto_algs[] = { {
-- 
2.23.0


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
