Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B638DC8
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 11:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3792882664
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 11:42:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3792882664
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.198
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K2TdMn7qIOdH
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Dec 2023 11:42:34 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0EC9B82662
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 11:42:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EC9B82662
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SpfxD4lNyz14M13;
	Mon, 11 Dec 2023 19:42:24 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
	by mail.maildlp.com (Postfix) with ESMTPS id 100F8140517;
	Mon, 11 Dec 2023 19:42:30 +0800 (CST)
Received: from DESKTOP-8LI8G6S.china.huawei.com (10.174.149.11) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 19:42:29 +0800
From: Gonglei <arei.gonglei@huawei.com>
To: <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<lixiao91@huawei.com>, wangyangxin <wangyangxin1@huawei.com>, Gonglei
	<arei.gonglei@huawei.com>
Subject: [PATCH 2/2] crypto: virtio-crypto: Fix gcc check warnings
Date: Mon, 11 Dec 2023 19:42:16 +0800
Message-ID: <1702294936-61080-3-git-send-email-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.8.2.windows.1
In-Reply-To: <1702294936-61080-1-git-send-email-arei.gonglei@huawei.com>
References: <1702294936-61080-1-git-send-email-arei.gonglei@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)

From: wangyangxin <wangyangxin1@huawei.com>

Fix gcc check warnings in W=1 build mode.
Variable cpu not used when CONFIG_SMP not defined.

Fixes: dbaf0624ffa5 ("crypto: add virtio-crypto driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312040315.kPrI1OCE-lkp@int
el.com/
Signed-off-by: wangyangxin <wangyangxin1@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 drivers/crypto/virtio/virtio_crypto_common.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 7059bbe5a2eb..f0340bb7a10b 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -134,10 +134,9 @@ virtcrypto_clear_request(struct virtio_crypto_request *vc_req);
 
 static inline int virtio_crypto_get_current_node(void)
 {
-	int cpu, node;
+	int node;
 
-	cpu = get_cpu();
-	node = topology_physical_package_id(cpu);
+	node = topology_physical_package_id(get_cpu());
 	put_cpu();
 
 	return node;
-- 
2.33.0

