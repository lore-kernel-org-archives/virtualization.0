Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296194;
	b=WY2GhIf+jL/GjeLzv6pxytdQZZl6jpueKUlo9Ua2sZKEsw2mGZ8GDWMyAhaIQpYFfJLE
	 DcT0Uhe5ewujT+4HAnV+t9DxBdNqyXyukQVX1tJdvzM4FCFKJfCDo5+UlcKBtTR57nEfd
	 BG6ix1smm1PJ6g4pXrQ1t6J6MZ4+gkc2JqoV0LN2Lg1w30floibh+d09Zr0zM8d2L0nB0
	 qEgNQBI+jRWdkqFClrbPrtyANmBRBmG58qcBOf1v4F2+nZ6jurylVQA6TmLK3GBaK+C6X
	 0GawBQi4l8bS39xIik9Ra22mHcKLLeUFwnqYDH8YkpSEnmx90wI30ZoHMaeUMWS9Y2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296194;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QQphr5euVsYvR57wxTaQJrr/VmZFbUsWVLJgzTq93eA=;
	b=TyYkujC5833J3p4xR3zlazg+26JMEHyBhwMWXCyYt3nq1WrkfmZsUrwGMaFd/ylLgRm6
	 xGzbzkRXJMw8hxf/4MVxTbrFUPM3KYGRMFkGe5KhbT6KkaewjYfhUIzAOwmgoIAqAGLQO
	 vNSIcKRDBxG4sWmDT88r1bTrFj4jl3LHa32pmnWX1QudPw9PA8TAlNW2V70Aqx+UzSl7T
	 VYVQDSGmEV+UDLrmJe093rJynrWohn93hw0DmouJrUUTb6GqGGEstVMWFbsvrj7dLukiN
	 JbEXMuaX9TLC1UAhy7iKEdF+EYSiRmply90nwOs1xfAb8rXMqYCoF/bIYNqyKAzuJKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=faDfODPK;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BB360A260D
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 07:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67BB360A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=faDfODPK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=faDfODPKGCL0NiCe7ruPNzlVNMD4hbQVfyDslV67WGRRk6+leMiHWdWw+tEly6OPTmK/dhHH7G7OV
	 nVIOcLvwqUg9LPG2v5Oa8vznochR+NlHxAc8+hHC63QDAp7zENIabDM2ooy5HfWEqmS7Zx/QfWWoyf
	 2Op59Q4aNQ/Z3eKM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af2c97f78b-c9cfc;
	Tue, 10 Nov 2026 15:36:32 +0800 (CST)
X-RM-TRANSID:2ee56af2c97f78b-c9cfc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af2c970885-ab73e;
	Tue, 10 Nov 2026 15:36:32 +0800 (CST)
X-RM-TRANSID:2ee36af2c970885-ab73e
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/2] virtio_net: Disable AF_XDP pools on queues above curr_queue_pairs
Date: Wed, 11 Nov 2026 00:30:01 +0900
Message-ID: <20261110153003.23731-3-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153003.23731-1-yanhaishuang@cmss.chinamobile.com>
References: <20261110153003.23731-1-yanhaishuang@cmss.chinamobile.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With an XDP program attached, virtnet_xdp_set() adds nr_cpu_ids queue
pairs for XDP_TX and raises curr_queue_pairs and real_num_rx_queues to
match. virtnet_xsk_pool_enable() accepts any queue below
curr_queue_pairs, so an AF_XDP zero-copy socket can be bound to one of
them.

When the program is removed, the queue count goes down again while the
pool stays bound to the driver. When the socket is closed afterwards,
virtnet_xsk_pool_disable() rejects the queue with -EINVAL, and the core
frees the pool anyway:

  WARNING: net/xdp/xsk_buff_pool.c:160 at xp_disable_drv_zc+0x1ee/0x260
  BUG: KASAN: slab-use-after-free in xp_alloc_batch+0x930/0xb40
  Read of size 8 at addr ffff8880028eb400 by task ksoftirqd/0/14
   xp_alloc_batch+0x930/0xb40
   try_fill_recv+0xb27/0x26e0

as rq->xsk_pool still points to it and the queue is refilled from it.

The device going away with XDP attached, e.g. on hot-unplug or driver
unbind, ends the same way without an explicit removal:
unregister_netdevice_many_notify() removes XDP before the xsk notifier
unbinds the socket, so the pool is disabled on a queue above
curr_queue_pairs there as well.

Removing XDP must not fail, so let virtnet_xsk_pool_disable() accept
any queue the driver has, below max_queue_pairs. The receive and send
queues above curr_queue_pairs still exist, so they are unbound as usual.

This was pointed out by the Sashiko review of v1 of this series, and
reproduced in QEMU by binding a socket to an XDP queue and then either
removing XDP and closing the socket, or unbinding the device from
virtio_net.

Fixes: 09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4f5d8812f75b..f9d227060375 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6030,7 +6030,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	struct send_queue *sq;
 	int err;
 
-	if (qid >= vi->curr_queue_pairs)
+	/* Removing XDP can leave the pool on a queue above curr_queue_pairs */
+	if (qid >= vi->max_queue_pairs)
 		return -EINVAL;
 
 	sq = &vi->sq[qid];
-- 
2.43.0



