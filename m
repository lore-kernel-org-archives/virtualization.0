Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029341B29E
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43D99813F9
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 12:37:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43D99813F9
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ha0qC2StWvTl
	for <virtualization@lists.linux-foundation.org>;
	Mon, 20 Nov 2023 12:37:45 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B3398813F0
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 12:37:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3398813F0
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwoRDEd_1700483856;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VwoRDEd_1700483856)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 20:37:37 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	ast@kernel.org,
	horms@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v4 1/4] virtio-net: returns whether napi is complete
Date: Mon, 20 Nov 2023 20:37:31 +0800
Message-Id: <4497004c8ba06fdb621689e40c2f801c493c83ea.1700478183.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1700478183.git.hengqi@linux.alibaba.com>
References: <cover.1700478183.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rx netdim needs to count the traffic during a complete napi process,
and start updating and comparing samples to make decisions after
the napi ends. Let virtqueue_napi_complete() return true if napi is done,
otherwise vice versa.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d16f592c2061..0ad2894e6a5e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -431,7 +431,7 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
 	}
 }
 
-static void virtqueue_napi_complete(struct napi_struct *napi,
+static bool virtqueue_napi_complete(struct napi_struct *napi,
 				    struct virtqueue *vq, int processed)
 {
 	int opaque;
@@ -440,9 +440,13 @@ static void virtqueue_napi_complete(struct napi_struct *napi,
 	if (napi_complete_done(napi, processed)) {
 		if (unlikely(virtqueue_poll(vq, opaque)))
 			virtqueue_napi_schedule(napi, vq);
+		else
+			return true;
 	} else {
 		virtqueue_disable_cb(vq);
 	}
+
+	return false;
 }
 
 static void skb_xmit_done(struct virtqueue *vq)
-- 
2.19.1.6.gb485710b

