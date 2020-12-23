Return-Path: <SRS0=+X4x=F3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428DDC433E0
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 12:25:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8472246B
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 12:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8472246B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 630B02DAFA;
	Wed, 23 Dec 2020 12:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4sYezewY2WDq; Wed, 23 Dec 2020 12:24:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 839F12D9B5;
	Wed, 23 Dec 2020 12:24:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66D97C1787;
	Wed, 23 Dec 2020 12:24:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 374D0C0893
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 12:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 21B3A2DAFA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 12:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RedPbTuzqPt8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 12:24:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id A2AAC2D9B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608726295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=0UNmcgKiAU5Ao1EWHMSNYvqkNdmnpc0OSfrJWGti+po=;
 b=IMvFAIplD+9/ww8I4Sn0BBcHPG2FfLwLi9JKfObkZgNTje8HBy7yqraxJ9LUa2sMqPItEW
 Bf1S6XeWVnxko7TV6SpT266o187QpknzVkBCZET99SJKl+sZb3VVw9GJI4a+lTXf5H+6Zf
 IMsYbt+SAMaErZuALjzLCjT0KqvPFV0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-sQ5q646-N1-IAnGQ4rkxVg-1; Wed, 23 Dec 2020 07:24:53 -0500
X-MC-Unique: sQ5q646-N1-IAnGQ4rkxVg-1
Received: by mail-wm1-f69.google.com with SMTP id r1so3050718wmn.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 04:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=0UNmcgKiAU5Ao1EWHMSNYvqkNdmnpc0OSfrJWGti+po=;
 b=iQflsRJ7jmvDkmHbjcch25ASBzT5zz7CYbAEduENCkO+52kFN1vEkrPyRgz6J4Oinz
 AWIA8yNoBUwyYiJ0Dnj/KYbve0RWBQk9QGaWAIg5xiwGkpm09WsIbQWLOuWaPxfPxf90
 p0xBMv+gq/E2xcZdwKSBjAYLRvxJL9mec3RqCawdzqNIQHOg6hIGR00uUbJSZjttPLEt
 o6twmu5iIY6ObYgxFDfyiVrnbG573dSOBBq1iD6a9LHpR5UdV83aB71wrU8woufun1Ze
 /BLEnALePMcQy1jTQgRWbkD1xfdUCxW3Ix4eEXiDUj6qJg8sRBL5wiKF78ILSK3iZPSD
 TMzw==
X-Gm-Message-State: AOAM530sGF4raaBWi7XfgteNtItss9GSvjJnrHgkjgY9idvoxs+unTOT
 wsaE4HOec85QNpynaKULQB5LTYfaz/wg21K8SXwr25Hd7ICdqODSk+1azf5t6h/jjhyWcWJww2Z
 vSY8T7aHRA1yH95MUChrTnvApRO+Ak6O0GbKXIqb6dA==
X-Received: by 2002:a5d:5181:: with SMTP id k1mr28572206wrv.226.1608726292451; 
 Wed, 23 Dec 2020 04:24:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnplIWRt16fzmwKMP8PwnlFgcdIWksMaeKxiGfFwfPmRzkFhUmLY7vWPm5sRt5yZ7jOcB35A==
X-Received: by 2002:a5d:5181:: with SMTP id k1mr28572175wrv.226.1608726292284; 
 Wed, 23 Dec 2020 04:24:52 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id z3sm36346271wrn.59.2020.12.23.04.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 04:24:51 -0800 (PST)
Date: Wed, 23 Dec 2020 07:24:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vdpa: features, cleanups, fixes
Message-ID: <20201223072448-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: peng.fan@nxp.com, richard.weiyang@linux.alibaba.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, zhangchangzhong@huawei.com,
 elic@nvidia.com, file@sect.tu-berlin.de, robert.buhren@sect.tu-berlin.de,
 mst@redhat.com, hulkci@huawei.com, dan.carpenter@oracle.com,
 christophe.jaillet@wanadoo.fr, tiantao6@hisilicon.com, mhocko@kernel.org,
 osalvador@suse.de, mgurtovoy@nvidia.com, pankaj.gupta.linux@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, info@metux.net
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

The following changes since commit 2c85ebc57b3e1817b6ce1a6b703928e113a90442:

  Linux 5.10 (2020-12-13 14:41:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 418eddef050d5f6393c303a94e3173847ab85466:

  vdpa: Use simpler version of ida allocation (2020-12-18 16:14:31 -0500)

----------------------------------------------------------------
virtio,vdpa: features, cleanups, fixes

vdpa sim refactoring
virtio mem  Big Block Mode support
misc cleanus, fixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Christophe JAILLET (1):
      vdpa: ifcvf: Use dma_set_mask_and_coherent to simplify code

Dan Carpenter (3):
      virtio_ring: Cut and paste bugs in vring_create_virtqueue_packed()
      virtio_net: Fix error code in probe()
      virtio_ring: Fix two use after free bugs

David Hildenbrand (29):
      virtio-mem: determine nid only once using memory_add_physaddr_to_nid()
      virtio-mem: more precise calculation in virtio_mem_mb_state_prepare_next_mb()
      virtio-mem: simplify MAX_ORDER - 1 / pageblock_order handling
      virtio-mem: drop rc2 in virtio_mem_mb_plug_and_add()
      virtio-mem: use "unsigned long" for nr_pages when fake onlining/offlining
      virtio-mem: factor out calculation of the bit number within the subblock bitmap
      virtio-mem: print debug messages from virtio_mem_send_*_request()
      virtio-mem: factor out fake-offlining into virtio_mem_fake_offline()
      virtio-mem: factor out handling of fake-offline pages in memory notifier
      virtio-mem: retry fake-offlining via alloc_contig_range() on ZONE_MOVABLE
      virtio-mem: generalize check for added memory
      virtio-mem: generalize virtio_mem_owned_mb()
      virtio-mem: generalize virtio_mem_overlaps_range()
      virtio-mem: drop last_mb_id
      virtio-mem: don't always trigger the workqueue when offlining memory
      virtio-mem: generalize handling when memory is getting onlined deferred
      virito-mem: document Sub Block Mode (SBM)
      virtio-mem: memory block states are specific to Sub Block Mode (SBM)
      virito-mem: subblock states are specific to Sub Block Mode (SBM)
      virtio-mem: nb_sb_per_mb and subblock_size are specific to Sub Block Mode (SBM)
      virtio-mem: memory block ids are specific to Sub Block Mode (SBM)
      virito-mem: existing (un)plug functions are specific to Sub Block Mode (SBM)
      virtio-mem: memory notifier callbacks are specific to Sub Block Mode (SBM)
      virtio-mem: factor out adding/removing memory from Linux
      virtio-mem: Big Block Mode (BBM) memory hotplug
      virtio-mem: allow to force Big Block Mode (BBM) and set the big block size
      mm/memory_hotplug: extend offline_and_remove_memory() to handle more than one memory block
      virtio-mem: Big Block Mode (BBM) - basic memory hotunplug
      virtio-mem: Big Block Mode (BBM) - safe memory hotunplug

Eli Cohen (1):
      vdpa/mlx5: Use write memory barrier after updating CQ index

Enrico Weigelt, metux IT consult (2):
      uapi: virtio_ids.h: consistent indentions
      uapi: virtio_ids: add missing device type IDs from OASIS spec

Max Gurtovoy (2):
      vdpa_sim: remove hard-coded virtq count
      vdpa: split vdpasim to core and net modules

Parav Pandit (2):
      vdpa: Add missing comment for virtqueue count
      vdpa: Use simpler version of ida allocation

Peng Fan (3):
      tools/virtio: include asm/bug.h
      tools/virtio: add krealloc_array
      tools/virtio: add barrier for aarch64

Stefano Garzarella (16):
      vdpa: remove unnecessary 'default n' in Kconfig entries
      vdpa_sim: remove unnecessary headers inclusion
      vdpa_sim: make IOTLB entries limit configurable
      vdpa_sim: rename vdpasim_config_ops variables
      vdpa_sim: add struct vdpasim_dev_attr for device attributes
      vdpa_sim: add device id field in vdpasim_dev_attr
      vdpa_sim: add supported_features field in vdpasim_dev_attr
      vdpa_sim: add work_fn in vdpasim_dev_attr
      vdpa_sim: store parsed MAC address in a buffer
      vdpa_sim: make 'config' generic and usable for any device type
      vdpa_sim: add get_config callback in vdpasim_dev_attr
      vdpa_sim: add set_config callback in vdpasim_dev_attr
      vdpa_sim: set vringh notify callback
      vdpa_sim: use kvmalloc to allocate vdpasim->buffer
      vdpa_sim: make vdpasim->buffer size configurable
      vdpa_sim: split vdpasim_virtqueue's iov field in out_iov and in_iov

Tian Tao (1):
      vhost_vdpa: switch to vmemdup_user()

Zhang Changzhong (1):
      vhost scsi: fix error return code in vhost_scsi_set_endpoint()

 drivers/net/virtio_net.c             |    1 +
 drivers/vdpa/Kconfig                 |   18 +-
 drivers/vdpa/ifcvf/ifcvf_main.c      |   11 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |    5 +
 drivers/vdpa/vdpa.c                  |    2 +-
 drivers/vdpa/vdpa_sim/Makefile       |    1 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  298 ++----
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  105 ++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  177 ++++
 drivers/vhost/scsi.c                 |    3 +-
 drivers/vhost/vdpa.c                 |   10 +-
 drivers/virtio/virtio_mem.c          | 1835 ++++++++++++++++++++++++----------
 drivers/virtio/virtio_ring.c         |    8 +-
 include/linux/vdpa.h                 |    1 +
 include/uapi/linux/virtio_ids.h      |   44 +-
 mm/memory_hotplug.c                  |  109 +-
 tools/virtio/asm/barrier.h           |   10 +
 tools/virtio/linux/bug.h             |    2 +
 tools/virtio/linux/kernel.h          |   13 +-
 19 files changed, 1843 insertions(+), 810 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
