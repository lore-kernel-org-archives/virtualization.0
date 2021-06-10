Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7713CC48BE5
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458B861403
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458B861403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1856483C77;
	Thu, 10 Jun 2021 08:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tMxjgtChhuGh; Thu, 10 Jun 2021 08:22:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B804583490;
	Thu, 10 Jun 2021 08:22:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91382C000D;
	Thu, 10 Jun 2021 08:22:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E6ABC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33EDB60834
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C_2-Arfhguu1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44861606F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:48 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=21; SR=0; TI=SMTPD_---0Ubx5.Io_1623313336; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Ubx5.Io_1623313336) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Jun 2021 16:22:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v5 15/15] virtio-net: xsk zero copy xmit kick by
 threshold
Date: Thu, 10 Jun 2021 16:22:09 +0800
Message-Id: <20210610082209.91487-16-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

After testing, the performance of calling kick every time is not stable.
And if all the packets are sent and kicked again, the performance is not
good. So add a module parameter to specify how many packets are sent to
call a kick.

8 is a relatively stable value with the best performance.

Here is the pps of the test of xsk_kick_thr under different values (from
1 to 64).

thr  PPS             thr PPS             thr PPS
1    2924116.74247 | 23  3683263.04348 | 45  2777907.22963
2    3441010.57191 | 24  3078880.13043 | 46  2781376.21739
3    3636728.72378 | 25  2859219.57656 | 47  2777271.91304
4    3637518.61468 | 26  2851557.9593  | 48  2800320.56575
5    3651738.16251 | 27  2834783.54408 | 49  2813039.87599
6    3652176.69231 | 28  2847012.41472 | 50  3445143.01839
7    3665415.80602 | 29  2860633.91304 | 51  3666918.01281
8    3665045.16555 | 30  2857903.5786  | 52  3059929.2709
9    3671023.2401  | 31  2835589.98963 | 53  2831515.21739
10   3669532.23274 | 32  2862827.88706 | 54  3451804.07204
11   3666160.37749 | 33  2871855.96696 | 55  3654975.92385
12   3674951.44813 | 34  3434456.44816 | 56  3676198.3188
13   3667447.57331 | 35  3656918.54177 | 57  3684740.85619
14   3018846.0503  | 36  3596921.16722 | 58  3060958.8594
15   2792773.84505 | 37  3603460.63903 | 59  2828874.57191
16   3430596.3602  | 38  3595410.87666 | 60  3459926.11027
17   3660525.85806 | 39  3604250.17819 | 61  3685444.47599
18   3045627.69054 | 40  3596542.28428 | 62  3049959.0809
19   2841542.94177 | 41  3600705.16054 | 63  2806280.04013
20   2830475.97348 | 42  3019833.71191 | 64  3448494.3913
21   2845655.55789 | 43  2752951.93264 |
22   3450389.84365 | 44  2753107.27164 |

It can be found that when the value of xsk_kick_thr is relatively small,
the performance is not good, and when its value is greater than 13, the
performance will be more irregular and unstable. It looks similar from 3
to 13, I chose 8 as the default value.

The test environment is qemu + vhost-net. I modified vhost-net to drop
the packets sent by vm directly, so that the cpu of vm can run higher.
By default, the processes in the vm and the cpu of softirqd are too low,
and there is no obvious difference in the test data.

During the test, the cpu of softirq reached 100%. Each xsk_kick_thr was
run for 300s, the pps of every second was recorded, and the average of
the pps was finally taken. The vhost process cpu on the host has also
reached 100%.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
---
 drivers/net/virtio/virtio_net.c |  1 +
 drivers/net/virtio/xsk.c        | 18 ++++++++++++++++--
 drivers/net/virtio/xsk.h        |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/virtio_net.c b/drivers/net/virtio/virtio_net.c
index 9503133e71f0..dfe509939b45 100644
--- a/drivers/net/virtio/virtio_net.c
+++ b/drivers/net/virtio/virtio_net.c
@@ -14,6 +14,7 @@ static bool csum = true, gso = true, napi_tx = true;
 module_param(csum, bool, 0444);
 module_param(gso, bool, 0444);
 module_param(napi_tx, bool, 0644);
+module_param(xsk_kick_thr, int, 0644);
 
 /* FIXME: MTU in config. */
 #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index 3973c82d1ad2..2f3ba6ab4798 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -5,6 +5,8 @@
 
 #include "virtio_net.h"
 
+int xsk_kick_thr = 8;
+
 static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
 
 static struct virtnet_xsk_ctx *virtnet_xsk_ctx_get(struct virtnet_xsk_ctx_head *head)
@@ -455,6 +457,7 @@ static int virtnet_xsk_xmit_batch(struct send_queue *sq,
 	struct xdp_desc desc;
 	int err, packet = 0;
 	int ret = -EAGAIN;
+	int need_kick = 0;
 
 	while (budget-- > 0) {
 		if (sq->vq->num_free < 2 + MAX_SKB_FRAGS) {
@@ -475,11 +478,22 @@ static int virtnet_xsk_xmit_batch(struct send_queue *sq,
 		}
 
 		++packet;
+		++need_kick;
+		if (need_kick > xsk_kick_thr) {
+			if (virtqueue_kick_prepare(sq->vq) &&
+			    virtqueue_notify(sq->vq))
+				++stats->kicks;
+
+			need_kick = 0;
+		}
 	}
 
 	if (packet) {
-		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
-			++stats->kicks;
+		if (need_kick) {
+			if (virtqueue_kick_prepare(sq->vq) &&
+			    virtqueue_notify(sq->vq))
+				++stats->kicks;
+		}
 
 		*done += packet;
 		stats->xdp_tx += packet;
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index fe22cf78d505..4f0f4f9cf23b 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -7,6 +7,8 @@
 
 #define VIRTNET_XSK_BUFF_CTX  ((void *)(unsigned long)~0L)
 
+extern int xsk_kick_thr;
+
 /* When xsk disable, under normal circumstances, the network card must reclaim
  * all the memory that has been sent and the memory added to the rq queue by
  * destroying the queue.
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
