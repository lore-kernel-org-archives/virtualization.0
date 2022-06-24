Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0BBCCA482
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 02:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B079E84820;
	Fri, 24 Jun 2022 02:56:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B079E84820
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5VSIWVocNQ0h; Fri, 24 Jun 2022 02:56:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 17BCD84808;
	Fri, 24 Jun 2022 02:56:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17BCD84808
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2C2DC0032;
	Fri, 24 Jun 2022 02:56:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89C6BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E22460E7B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E22460E7B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z5L9oQzhluGS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8867360BA1
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8867360BA1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:30 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VHEo97T_1656039381; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VHEo97T_1656039381) by smtp.aliyun-inc.com;
 Fri, 24 Jun 2022 10:56:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v10 00/41] virtio pci support VIRTIO_F_RING_RESET
Date: Fri, 24 Jun 2022 10:55:40 +0800
Message-Id: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Git-Hash: fef800c86cd2
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

The virtio spec already supports the virtio queue reset function. This patch set
is to add this function to the kernel. The relevant virtio spec information is
here:

    https://github.com/oasis-tcs/virtio-spec/issues/124
    https://github.com/oasis-tcs/virtio-spec/issues/139

Also regarding MMIO support for queue reset, I plan to support it after this
patch is passed.

This patch set implements the refactoring of vring. Finally, the
virtuque_resize() interface is provided based on the reset function of the
transport layer.

Test environment:
    Host: 4.19.91
    Qemu: QEMU emulator version 6.2.50 (with vq reset support)
    Test Cmd:  ethtool -G eth1 rx $1 tx $2; ethtool -g eth1

    The default is split mode, modify Qemu virtio-net to add PACKED feature to test
    packed mode.

Qemu code:
    https://github.com/fengidri/qemu/compare/89f3bfa3265554d1d591ee4d7f1197b6e3397e84...master

In order to simplify the review of this patch set, the function of reusing
the old buffers after resize will be introduced in subsequent patch sets.

Please review. Thanks.

v10:
  1. on top of the harden vring IRQ
  2. factor out split and packed from struct vring_virtqueue
  3. some suggest from @Jason Wang

v9:
  1. Provide a virtqueue_resize() interface directly
  2. A patch set including vring resize, virtio pci reset, virtio-net resize
  3. No more separate structs

v8:
  1. Provide a virtqueue_reset() interface directly
  2. Split the two patch sets, this is the first part
  3. Add independent allocation helper for allocating state, extra

v7:
  1. fix #6 subject typo
  2. fix #6 ring_size_in_bytes is uninitialized
  3. check by: make W=12

v6:
  1. virtio_pci: use synchronize_irq(irq) to sync the irq callbacks
  2. Introduce virtqueue_reset_vring() to implement the reset of vring during
     the reset process. May use the old vring if num of the vq not change.
  3. find_vqs() support sizes to special the max size of each vq

v5:
  1. add virtio-net support set_ringparam

v4:
  1. just the code of virtio, without virtio-net
  2. Performing reset on a queue is divided into these steps:
    1. reset_vq: reset one vq
    2. recycle the buffer from vq by virtqueue_detach_unused_buf()
    3. release the ring of the vq by vring_release_virtqueue()
    4. enable_reset_vq: re-enable the reset queue
  3. Simplify the parameters of enable_reset_vq()
  4. add container structures for virtio_pci_common_cfg

v3:
  1. keep vq, irq unreleased

*** BLURB HERE ***

Xuan Zhuo (41):
  remoteproc: rename len of rpoc_vring to num
  virtio: add helper virtqueue_get_vring_max_size()
  virtio: struct virtio_config_ops add callbacks for queue_reset
  virtio_ring: update the document of the virtqueue_detach_unused_buf
    for queue reset
  virtio_ring: remove the arg vq of vring_alloc_desc_extra()
  virtio_ring: extract the logic of freeing vring
  virtio_ring: split vring_virtqueue
  virtio_ring: introduce virtqueue_init()
  virtio_ring: split: introduce vring_free_split()
  virtio_ring: split: extract the logic of alloc queue
  virtio_ring: split: extract the logic of alloc state and extra
  virtio_ring: split: extract the logic of attach vring
  virtio_ring: split: extract the logic of vring init
  virtio_ring: split: introduce virtqueue_reinit_split()
  virtio_ring: split: reserve vring_align, may_reduce_num
  virtio_ring: split: introduce virtqueue_resize_split()
  virtio_ring: packed: introduce vring_free_packed
  virtio_ring: packed: extract the logic of alloc queue
  virtio_ring: packed: extract the logic of alloc state and extra
  virtio_ring: packed: extract the logic of attach vring
  virtio_ring: packed: extract the logic of vring init
  virtio_ring: packed: introduce virtqueue_reinit_packed()
  virtio_ring: packed: introduce virtqueue_resize_packed()
  virtio_ring: introduce virtqueue_resize()
  virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
  virtio: queue_reset: add VIRTIO_F_RING_RESET
  virtio: allow to unbreak/break virtqueue individually
  virtio_pci: update struct virtio_pci_common_cfg
  virtio_pci: introduce helper to get/set queue reset
  virtio_pci: extract the logic of active vq for modern pci
  virtio_pci: support VIRTIO_F_RING_RESET
  virtio: find_vqs() add arg sizes
  virtio_pci: support the arg sizes of find_vqs()
  virtio_mmio: support the arg sizes of find_vqs()
  virtio: add helper virtio_find_vqs_ctx_size()
  virtio_net: set the default max ring size by find_vqs()
  virtio_net: get ringparam by virtqueue_get_vring_max_size()
  virtio_net: split free_unused_bufs()
  virtio_net: support rx queue resize
  virtio_net: support tx queue resize
  virtio_net: support set_ringparam

 arch/um/drivers/virtio_uml.c             |   3 +-
 drivers/net/virtio_net.c                 | 209 +++++-
 drivers/platform/mellanox/mlxbf-tmfifo.c |   3 +
 drivers/remoteproc/remoteproc_core.c     |   4 +-
 drivers/remoteproc/remoteproc_virtio.c   |  13 +-
 drivers/s390/virtio/virtio_ccw.c         |   4 +
 drivers/virtio/virtio_mmio.c             |  11 +-
 drivers/virtio/virtio_pci_common.c       |  32 +-
 drivers/virtio/virtio_pci_common.h       |   3 +-
 drivers/virtio/virtio_pci_legacy.c       |   8 +-
 drivers/virtio/virtio_pci_modern.c       | 157 ++++-
 drivers/virtio/virtio_pci_modern_dev.c   |  39 ++
 drivers/virtio/virtio_ring.c             | 794 +++++++++++++++++------
 drivers/virtio/virtio_vdpa.c             |   3 +
 include/linux/remoteproc.h               |   4 +-
 include/linux/virtio.h                   |   9 +
 include/linux/virtio_config.h            |  38 +-
 include/linux/virtio_pci_modern.h        |   2 +
 include/uapi/linux/virtio_config.h       |   7 +-
 include/uapi/linux/virtio_pci.h          |  14 +
 20 files changed, 1063 insertions(+), 294 deletions(-)

--
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
