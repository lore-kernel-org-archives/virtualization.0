Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DAA37D124
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066361; cv=none; b=LY1Ikn1jcRxP2sd8EZthD1HTeIIidJWJ6vcvjyRxTK5cXslyyqMTSwu+nrbMgFpbu+GxTb3dDSJOI/8497soOHOL+OXxVjCVPiryrkb4Li9n0gxdlyoiNIugqi73Y5hIuUdbVdnKCYyKifU/SHQ44PrMCDlUby1Xh0CShWBDYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066361; c=relaxed/simple;
	bh=+/BoZ/5Mhz419XFav3gh2eRJNigBg3v4/Xv7DhhucV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azto0GZ0Y2fS+TRJo+n38hWXv6eTjbA0yEjHjmcqPR3YBuSwo+ZVtjyathLQE/hp4FGFtt0r1eqx8YNNRNtFiqDVGinnaniyl14VSV68k8VmhLiLGiW5fbnieglNqTKnrP8V518/80edypsua/n4KUsOJzJhNFJj5a9xUJQ+wW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d78fa44291ff11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bd8c7a32-b5b8-4dfb-8670-5d7a69013c6a,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:91950fb70802eaac80b89ae02481d9b2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d78fa44291ff11f1aa26b74ffac11d73-20260807
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 664917844; Fri, 07 Aug 2026 09:32:24 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: netdev@vger.kernel.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] virtio_net: refuse XDP queue shrink while AF_XDP is bound
Date: Fri,  7 Aug 2026 09:32:20 +0800
Message-ID: <20260807013220.2130441-2-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807013220.2130441-1-xiongweimin@kylinos.cn>
References: <20260807013220.2130441-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_xdp_set() can lower curr_queue_pairs when an XDP program is
detached.  Unlike ethtool channel updates, that path does not check for
AF_XDP zero-copy pools on the queues being dropped.  A pool can remain
bound on a qid that is no longer covered by curr_queue_pairs, which
breaks later unbind and can leave stale rq/sq->xsk_pool pointers.

Refuse the shrink with -EBUSY while any AF_XDP pool is still bound on a
queue that would become inactive.

Fixes: 09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
v2:
- new patch: block XDP-driven queue shrink while AF_XDP is bound
- replaces the previous series' approach after review

 drivers/net/virtio_net.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d07ccef..3bd220d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6064,6 +6064,21 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	if (!prog && !old_prog)
 		return 0;
 
+	/* ethtool channel shrink is gated on xsk_get_pool_from_qid(), but
+	 * XDP detach shrinks curr_queue_pairs here without that check.
+	 * Refusing the shrink keeps AF_XDP queues active until the socket
+	 * unbinds them.
+	 */
+	if (curr_qp + xdp_qp < vi->curr_queue_pairs) {
+		for (i = curr_qp + xdp_qp; i < vi->curr_queue_pairs; i++) {
+			if (vi->rq[i].xsk_pool || vi->sq[i].xsk_pool) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Cannot reduce queues while AF_XDP is bound");
+				return -EBUSY;
+			}
+		}
+	}
+
 	if (prog)
 		bpf_prog_add(prog, vi->max_queue_pairs - 1);
 
-- 
2.43.0

