Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E99D53F
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970023; cv=none; b=tRW4quxqAN+8IX5mA/dnE+LssCUtnGw+zmZLIT4BO2SkGJwlh1QS7TSggnY7I1e6dt9i3NmtzfujNWCrSFEYGEc8m8RYXJ7ClCcuZDnQkCR6c4hc6MVW6pIRXaFj7s1GFkoPjRmTkcwCd36bGLWfEMI2V3G2IDjeamcLxEqKXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970023; c=relaxed/simple;
	bh=mBWxLAoazIrxkLKl3NmxLafF7WHuiWPvgR6hC/3soh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZrE5ct+DG7zNCd47IKAn1U2geifdZCQe/zhovCyEb4g2GRQAG/Q7mWJINKcV191D/86oQArd8LrW6DJDKu69dvqTSoQdiuUnxsN3dHGbt2iZBSc2AFkDGL4pF4ds4kllvvXazxH6KHZ0d0Ucayf4el/VM9IJEcjgHyQR/ia4GAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LW5fqdkG; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LW5fqdkG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730970018; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=h0Ci1gFKuYKlSVUio59hd5wuu025BLwCb9IkBxqQmmA=;
	b=LW5fqdkGCzdqhyod/fe8hp5wdSl6hc8MBnWSqC5x9TJFxD9FFRFgwjwi3290rnosfZnAwe9RjAtwOZYp1KpJ77WCZKpLBUaUGpXTkIwU/rfEH6VAa9N+n73GA6OefxP3mTl1rcDSb6M2IfeNlG7lE6ve6S3SL7VOuJyTKailOu0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIuulOt_1730969704 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 16:55:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 00/13] virtio-net: support AF_XDP zero copy (tx)
Date: Thu,  7 Nov 2024 16:54:51 +0800
Message-Id: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 2634baada01d
Content-Transfer-Encoding: 8bit

v3:
    1. use sg_dma_address/length api to set the premapped sg
    2. remove 'premapped' parameter from the new APIs
    3. tweak the comment of commit #2,#3

v2:
    1. use new api to submit premapped buffer instead of using sgs to pass this info
    2. some small fixes for http://lore.kernel.org/all/20240924013204.13763-1-xuanzhuo@linux.alibaba.com


v1:
    1. some small fixes for http://lore.kernel.org/all/20240820073330.9161-1-xuanzhuo@linux.alibaba.com
        1. fix the title of the commit #2, #3
        2. fix the gcc error for commit #3
        3. use virtqueue_dma_xxxx for tx hdr
        4. rename virtnet_ptr_to_xsk to virtnet_ptr_to_xsk_buff_len
        5. squash #11 in last patch set to #10

================================================================================

## AF_XDP

XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
copy feature of xsk (XDP socket) needs to be supported by the driver. The
performance of zero copy is very good. mlx5 and intel ixgbe already support
this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
feature.

At present, we have completed some preparation:

1. vq-reset (virtio spec and kernel code)
2. virtio-core premapped dma
3. virtio-net xdp refactor

So it is time for Virtio-Net to complete the support for the XDP Socket
Zerocopy.

Virtio-net can not increase the queue num at will, so xsk shares the queue with
kernel.

This patch set includes some refactor to the virtio-net to let that to support
AF_XDP.

## About virtio premapped mode

The current configuration sets the virtqueue (vq) to premapped mode,
implying that all buffers submitted to this queue must be mapped ahead
of time. This presents a challenge for the virtnet send queue (sq): the
virtnet driver would be required to keep track of dma information for vq
size * 17, which can be substantial. However, if the premapped mode were
applied on a per-buffer basis, the complexity would be greatly reduced.
With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
skb buffers could remain unmapped.

We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, this
indicates that the driver has performed DMA mapping in advance, allowing
the Virtio core to directly utilize sg_dma_address(sg) without
conducting any internal DMA mapping. Additionally, DMA unmap operations
for this buffer will be bypassed.

## performance

ENV: Qemu with vhost-user(polling mode).
Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz

### virtio PMD in guest with testpmd

testpmd> show port stats all

 ######################## NIC statistics for port 0 ########################
 RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
 RX-errors: 0
 RX-nombuf: 0
 TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664


 Throughput (since last show)
 Rx-pps:   8861574     Rx-bps:  3969985208
 Tx-pps:   8861493     Tx-bps:  3969962736
 ############################################################################

### AF_XDP PMD in guest with testpmd

testpmd> show port stats all

  ######################## NIC statistics for port 0  ########################
  RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152

  Throughput (since last show)
  Rx-pps:      6333196          Rx-bps:   2837272088
  Tx-pps:      6333227          Tx-bps:   2837285936
  ############################################################################

But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).

Please review.

Thanks.



Xuan Zhuo (13):
  virtio_ring: introduce vring_need_unmap_buffer
  virtio_ring: split: record extras for indirect buffers
  virtio_ring: packed: record extras for indirect buffers
  virtio_ring: perform premapped operations based on per-buffer
  virtio_ring: introduce add api for premapped
  virtio-net: rq submits premapped per-buffer
  virtio_ring: remove API virtqueue_set_dma_premapped
  virtio_net: refactor the xmit type
  virtio_net: xsk: bind/unbind xsk for tx
  virtio_net: xsk: prevent disable tx napi
  virtio_net: xsk: tx: support xmit xsk buffer
  virtio_net: update tx timeout record
  virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY

 drivers/net/virtio_net.c     | 369 ++++++++++++++++++++++++++++-------
 drivers/virtio/virtio_ring.c | 354 ++++++++++++++++-----------------
 include/linux/virtio.h       |  13 +-
 3 files changed, 487 insertions(+), 249 deletions(-)

--
2.32.0.3.g01195cf9f

