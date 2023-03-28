Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63961C77B60
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F421881B48;
	Tue, 28 Mar 2023 09:28:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F421881B48
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uNtNaC5evUgQ; Tue, 28 Mar 2023 09:28:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6FB2181C81;
	Tue, 28 Mar 2023 09:28:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FB2181C81
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 471BFC0037;
	Tue, 28 Mar 2023 09:28:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0F8BC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88AFA4158E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:28:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 88AFA4158E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KXNJTnIqgikb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:28:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2561411A9
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2561411A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:28:53 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VesbhcT_1679995727; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VesbhcT_1679995727) by smtp.aliyun-inc.com;
 Tue, 28 Mar 2023 17:28:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 00/16] virtio-net: split virtio-net.c
Date: Tue, 28 Mar 2023 17:28:31 +0800
Message-Id: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: e880b402863c
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

Considering the complexity of virtio-net.c and the new features we want
to add, it is time to split virtio-net.c into multiple independent
module files.

This is beneficial to the maintenance and adding new functions.

And AF_XDP support will be added later, then a separate xsk.c file will
be added.

This patchset split virtio-net.c into these parts:

* virtnet.c:         virtio net device ops (napi, tx, rx, device ops, ...)
* virtnet_common.c:  virtio net common code
* virtnet_ethtool.c: virtio net ethtool callbacks
* virtnet_ctrl.c:    virtio net ctrl queue command APIs
* virtnet_virtio.c:  virtio net virtio callbacks/ops (driver register, virtio probe, virtio free, ...)

Please review.

Thanks.

Xuan Zhuo (16):
  virtio_net: add a separate directory for virtio-net
  virtio_net: move struct to header file
  virtio_net: add prefix to the struct inside header file
  virtio_net: separating cpu-related funs
  virtio_net: separate virtnet_ctrl_set_queues()
  virtio_net: separate virtnet_ctrl_set_mac_address()
  virtio_net: remove lock from virtnet_ack_link_announce()
  virtio_net: separating the APIs of cq
  virtio_net: introduce virtnet_rq_update_stats()
  virtio_net: separating the funcs of ethtool
  virtio_net: introduce virtnet_dev_rx_queue_group()
  virtio_net: introduce virtnet_get_netdev()
  virtio_net: prepare for virtio
  virtio_net: move virtnet_[en/dis]able_delayed_refill to header file
  virtio_net: add APIs to register/unregister virtio driver
  virtio_net: separating the virtio code

 MAINTAINERS                                   |    2 +-
 drivers/net/Kconfig                           |    8 +-
 drivers/net/Makefile                          |    2 +-
 drivers/net/virtio/Kconfig                    |   11 +
 drivers/net/virtio/Makefile                   |   10 +
 .../net/{virtio_net.c => virtio/virtnet.c}    | 2368 ++---------------
 drivers/net/virtio/virtnet.h                  |  213 ++
 drivers/net/virtio/virtnet_common.c           |  138 +
 drivers/net/virtio/virtnet_common.h           |   14 +
 drivers/net/virtio/virtnet_ctrl.c             |  272 ++
 drivers/net/virtio/virtnet_ctrl.h             |   45 +
 drivers/net/virtio/virtnet_ethtool.c          |  578 ++++
 drivers/net/virtio/virtnet_ethtool.h          |    8 +
 drivers/net/virtio/virtnet_virtio.c           |  880 ++++++
 drivers/net/virtio/virtnet_virtio.h           |    8 +
 15 files changed, 2366 insertions(+), 2191 deletions(-)
 create mode 100644 drivers/net/virtio/Kconfig
 create mode 100644 drivers/net/virtio/Makefile
 rename drivers/net/{virtio_net.c => virtio/virtnet.c} (50%)
 create mode 100644 drivers/net/virtio/virtnet.h
 create mode 100644 drivers/net/virtio/virtnet_common.c
 create mode 100644 drivers/net/virtio/virtnet_common.h
 create mode 100644 drivers/net/virtio/virtnet_ctrl.c
 create mode 100644 drivers/net/virtio/virtnet_ctrl.h
 create mode 100644 drivers/net/virtio/virtnet_ethtool.c
 create mode 100644 drivers/net/virtio/virtnet_ethtool.h
 create mode 100644 drivers/net/virtio/virtnet_virtio.c
 create mode 100644 drivers/net/virtio/virtnet_virtio.h

--
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
