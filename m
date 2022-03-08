Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E58C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 12:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75F3A415BA;
	Tue,  8 Mar 2022 12:35:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8hF2HScTfF4d; Tue,  8 Mar 2022 12:35:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 19AAE41757;
	Tue,  8 Mar 2022 12:35:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9DD6C001D;
	Tue,  8 Mar 2022 12:35:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D7F2C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22F3960F40
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2owkXCVwdWoT
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C76A60F3E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:24 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R241e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V6efcTq_1646742918; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6efcTq_1646742918) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Mar 2022 20:35:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 00/26] virtio pci support VIRTIO_F_RING_RESET
Date: Tue,  8 Mar 2022 20:34:52 +0800
Message-Id: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Git-Hash: f06b131dbfed
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

Also regarding MMIO support for queue reset, I plan to support it after this
patch is passed.

Performing reset on a queue is divided into four steps:
     1. virtio_reset_vq()              - notify the device to reset the queue
     2. virtqueue_detach_unused_buf()  - recycle the buffer submitted
     3. virtqueue_reset_vring()        - reset the vring (may re-alloc)
     4. virtio_enable_resetq()         - mmap vring to device, and enable the queue

The first part 1-17 of this patch set implements virtio pci's support and API
for queue reset. The latter part is to make virtio-net support set_ringparam. Do
these things for this feature:

      1. virtio-net support rx,tx reset
      2. find_vqs() support to special the max size of each vq
      3. virtio-net support set_ringparam

#1 -#3 :       prepare
#4 -#12:       virtio ring support reset vring of the vq
#13-#14:       add helper
#15-#17:       virtio pci support reset queue and re-enable
#18-#21:       find_vqs() support sizes to special the max size of each vq
#23-#24:       virtio-net support rx, tx reset
#22, #25, #26: virtio-net support set ringparam

Test environment:
    Host: 4.19.91
    Qemu: QEMU emulator version 6.2.50 (with vq reset support)
    Test Cmd:  ethtool -G eth1 rx $1 tx $2; ethtool -g eth1

    The default is split mode, modify Qemu virtio-net to add PACKED feature to test
    packed mode.


Please review. Thanks.

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

Xuan Zhuo (26):
  virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
  virtio: queue_reset: add VIRTIO_F_RING_RESET
  virtio: add helper virtqueue_get_vring_max_size()
  virtio_ring: split: extract the logic of creating vring
  virtio_ring: split: extract the logic of init vq and attach vring
  virtio_ring: packed: extract the logic of creating vring
  virtio_ring: packed: extract the logic of init vq and attach vring
  virtio_ring: extract the logic of freeing vring
  virtio_ring: split: implement virtqueue_reset_vring_split()
  virtio_ring: packed: implement virtqueue_reset_vring_packed()
  virtio_ring: introduce virtqueue_reset_vring()
  virtio_ring: update the document of the virtqueue_detach_unused_buf
    for queue reset
  virtio: queue_reset: struct virtio_config_ops add callbacks for
    queue_reset
  virtio: add helper for queue reset
  virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
    option functions
  virtio_pci: queue_reset: extract the logic of active vq for modern pci
  virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
  virtio: find_vqs() add arg sizes
  virtio_pci: support the arg sizes of find_vqs()
  virtio_mmio: support the arg sizes of find_vqs()
  virtio: add helper virtio_find_vqs_ctx_size()
  virtio_net: get ringparam by virtqueue_get_vring_max_size()
  virtio_net: split free_unused_bufs()
  virtio_net: support rx/tx queue reset
  virtio_net: set the default max ring size by find_vqs()
  virtio_net: support set_ringparam

 arch/um/drivers/virtio_uml.c             |   2 +-
 drivers/net/virtio_net.c                 | 257 ++++++++--
 drivers/platform/mellanox/mlxbf-tmfifo.c |   3 +-
 drivers/remoteproc/remoteproc_virtio.c   |   2 +-
 drivers/s390/virtio/virtio_ccw.c         |   2 +-
 drivers/virtio/virtio_mmio.c             |  12 +-
 drivers/virtio/virtio_pci_common.c       |  28 +-
 drivers/virtio/virtio_pci_common.h       |   3 +-
 drivers/virtio/virtio_pci_legacy.c       |   8 +-
 drivers/virtio/virtio_pci_modern.c       | 146 +++++-
 drivers/virtio/virtio_pci_modern_dev.c   |  36 ++
 drivers/virtio/virtio_ring.c             | 584 +++++++++++++++++------
 drivers/virtio/virtio_vdpa.c             |   2 +-
 include/linux/virtio.h                   |  12 +
 include/linux/virtio_config.h            |  74 ++-
 include/linux/virtio_pci_modern.h        |   2 +
 include/uapi/linux/virtio_config.h       |   7 +-
 include/uapi/linux/virtio_pci.h          |  14 +
 18 files changed, 979 insertions(+), 215 deletions(-)

--
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
