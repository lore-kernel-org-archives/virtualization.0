Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6313BAFA
	for <virtualization@lists.linux.dev>; Fri,  5 Jul 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165062; cv=none; b=aqH3I7zHYLQZCSOO4HWvuNvTQqz0BGw/yTHgFJ+Sh1PsiurGtcvq8fTL9fg+A5KjMPasJ9TSahDZFxiBr1bhZAPd5a/OsaZWTTyQJkEDCT/ZBPRntawBOVBiRmFYq75RaHSbCjlDlzVhm/N+X1Wssg7GkeCe4NIf31GPR1q9Ol8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165062; c=relaxed/simple;
	bh=Fzi/O6YZYtHlVtl2VrP3N2ElqF3UTFAQZmkmgIfy980=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TgWhEEJaSCFPMVcKi1aZv44gDGWHoFdbzIJzGVxAspBVHSY4iXJ+zEpDLP/W2QMhumDvvlimLYgrLCHXk6HGqCmAKF8JhegHw5IgkXjA37F68aXe+A9wfxwR/DzeETrzAPbN0XH5e26lkNMarn9aKR22tK6jsrbZgyzdfrTlYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r7wF2VLs; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r7wF2VLs"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720165056; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dU3e3Uapmtc0Kjj0kDaJfbALXvzgvjcPudGOI+QovmU=;
	b=r7wF2VLsf+hfS+EPUniXzSwaehkTlWyhLXq/umgpjRqjCbhyHFg71S35DQSKwiZXrJnriBPIuMS7YuYJBYZfXIJB6n9oDYtmSlPGZHO3dI8ra5CAZAxZ03ftlxa1Gea2dwZJ0BklJBu+TnUW13/iBWuQttabKst/jv8JtwuksjM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9uE.cg_1720165054;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9uE.cg_1720165054)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 15:37:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
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
Subject: [PATCH net-next v7 00/10] virtio-net: support AF_XDP zero copy
Date: Fri,  5 Jul 2024 15:37:24 +0800
Message-Id: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: bfc652b69f2c
Content-Transfer-Encoding: 8bit

v6:
    1. start from supporting the rx zerocopy

v5:
    1. fix the comments of last version
        http://lore.kernel.org/all/20240611114147.31320-1-xuanzhuo@linux.alibaba.com
v4:
    1. remove the commits that introduce the independent directory
    2. remove the supporting for the rx merge mode (for limit 15
       commits of net-next). Let's start with the small mode.
    3. merge some commits and remove some not important commits

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

On the other hand, Virtio-Net does not support generate interrupt from driver
manually, so when we wakeup tx xmit, we used some tips. If the CPU run by TX
NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU. If it
is also the local CPU, then we wake up napi directly.

This patch set includes some refactor to the virtio-net to let that to support
AF_XDP.

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

## maintain

I am currently a reviewer for virtio-net. I commit to maintain AF_XDP support in
virtio-net.

Please review.

Thanks.

v3
    1. virtio introduces helpers for virtio-net sq using premapped dma
    2. xsk has more complete support for merge mode
    3. fix some problems

v2
    1. wakeup uses the way of GVE. No send ipi to wakeup napi on remote cpu.
    2. remove rcu. Because we synchronize all operat, so the rcu is not needed.
    3. split the commit "move to virtio_net.h" in last patch set. Just move the
       struct/api to header when we use them.
    4. add comments for some code

v1:
    1. remove two virtio commits. Push this patchset to net-next
    2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xsk: support tx
    3. fix some warnings







Xuan Zhuo (10):
  virtio_net: replace VIRTIO_XDP_HEADROOM by XDP_PACKET_HEADROOM
  virtio_net: separate virtnet_rx_resize()
  virtio_net: separate virtnet_tx_resize()
  virtio_net: separate receive_buf
  virtio_net: separate receive_mergeable
  virtio_net: xsk: bind/unbind xsk for rx
  virtio_net: xsk: support wakeup
  virtio_net: xsk: rx: support fill with xsk buffer
  virtio_net: xsk: rx: support recv small mode
  virtio_net: xsk: rx: support recv merge mode

 drivers/net/virtio_net.c | 770 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 676 insertions(+), 94 deletions(-)

-- 
2.32.0.3.g01195cf9f

