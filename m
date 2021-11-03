Return-Path: <SRS0=Oeu7=PW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D319C433EF
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 20:43:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4986103B
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 20:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED4986103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98FE8606B3;
	Wed,  3 Nov 2021 20:43:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MmO71GT9NdUV; Wed,  3 Nov 2021 20:43:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 282456062A;
	Wed,  3 Nov 2021 20:43:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B572C0019;
	Wed,  3 Nov 2021 20:43:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C0A6C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 20:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 711D1401BE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 20:43:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u-nUHQN5SNZ7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 20:43:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D1F4400DF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 20:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635972221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ycJtGdUUCpH0aUUTnC/bRRS7vczLyB6170Uz115xpB0=;
 b=DpxDQo0kY3TF9joC3PeNXQanRpJPDP1M7sYuorTG1Jw9feiTP4kX2kRah9YKb7w5vkr/Xn
 ePfcEsM6o5XDo7sMfTKkuR519t45vWSgMg44LFZpdB+Fr4s7JQuOrEgOOig/2HjB0YsXJn
 Cunust1E9tNozVcTdqB555MdAyLl3RU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-IckAVV7FPBi2NlEjRN66Eg-1; Wed, 03 Nov 2021 16:43:39 -0400
X-MC-Unique: IckAVV7FPBi2NlEjRN66Eg-1
Received: by mail-wm1-f69.google.com with SMTP id
 l187-20020a1c25c4000000b0030da46b76daso3286425wml.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Nov 2021 13:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=ycJtGdUUCpH0aUUTnC/bRRS7vczLyB6170Uz115xpB0=;
 b=VrzDY95GZpnAxM0GjUKHCZpGukWv0NMMn0ugpjTGTxRiR3olcySU0lReDTcwD7J7WT
 NAn16u0uRhBiF8b5lkFXNwvc0OHNem07ZwXtKuStNvbgzBTwZYL4Sg+/AngRfRujWmbE
 sFdw4cjOGrivwz0xBhcTvbUeT21PkKgQAn0AOvuwKh/bWGjcFl6vcQdhIp2PdzYywfQk
 M/uR0TZO70XKxTyuLevY8WQJrtBcQDBXszjvDE5cS+59hSvhghfWODfuGMSXtcTfSAHn
 +GSshufdO4LXK4PUKCYbR+lFmlRWkCAoKd1jVmGiTL80ZqN9KQ0tOQ/Q1Ym9cxnl8t1h
 VXTw==
X-Gm-Message-State: AOAM532fYYXIWVeFTZOBgJsaCUW9dbyhUDVH59t8lsUwaxaes06IEFHp
 fTY/On2bzO9+5Y+PD9SLKRgIpwDddVE0QqrXJyKRhkTs+q2WnB+CJ/n2R7SAinnPWGsoSY3MDid
 QU/JcfhsfiUnZok83sM0gE0juXMLh/kqt1bfbfuHekQ==
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr16301043wml.146.1635972217911; 
 Wed, 03 Nov 2021 13:43:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAOxXMQNUWbZpukHMPxGSMFHowFfE8y2JMN+RYHabViAVvjlT9WYHd7lkudlHiVcf5NGesSg==
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr16300998wml.146.1635972217669; 
 Wed, 03 Nov 2021 13:43:37 -0700 (PDT)
Received: from redhat.com ([2.55.17.31])
 by smtp.gmail.com with ESMTPSA id z11sm2978466wrt.58.2021.11.03.13.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Nov 2021 13:43:37 -0700 (PDT)
Date: Wed, 3 Nov 2021 16:43:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vhost,virtio,vhost: fixes,features
Message-ID: <20211103164332-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, peterz@infradead.org,
 viresh.kumar@linaro.org, colin.i.king@googlemail.com,
 linux-kernel@vger.kernel.org, wuzongyong@linux.alibaba.com, elic@nvidia.com,
 paulmck@kernel.org, corentin.noel@collabora.com, zealci@zte.com.cn,
 colin.i.king@gmail.com, lvivier@redhat.com, arnd@arndb.de, amit@kernel.org,
 boqun.feng@gmail.com, pankaj.gupta@ionos.com, stefanha@redhat.com,
 ye.guojin@zte.com.cn, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, lkp@intel.com, mgurtovoy@nvidia.com,
 pankaj.gupta.linux@gmail.com, netdev@vger.kernel.org, gustavoars@kernel.org,
 pbonzini@redhat.com
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

The following changes since commit 8bb7eca972ad531c9b149c0a51ab43a417385813:

  Linux 5.15 (2021-10-31 13:53:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 540061ac79f0302ae91e44e6cd216cbaa3af1757:

  vdpa/mlx5: Forward only packets with allowed MAC address (2021-11-01 05:26:49 -0400)

----------------------------------------------------------------
vhost,virtio,vhost: fixes,features

Hardening work by Jason
vdpa driver for Alibaba ENI
Performance tweaks for virtio blk
virtio rng rework using an internal buffer
mac/mtu programming for mlx5 vdpa
Misc fixes, cleanups

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Colin Ian King (1):
      virtio_blk: Fix spelling mistake: "advertisted" -> "advertised"

Eli Cohen (5):
      vdpa/mlx5: Remove mtu field from vdpa net device
      vdpa/mlx5: Rename control VQ workqueue to vdpa wq
      vdpa/mlx5: Propagate link status from device to vdpa driver
      vdpa/mlx5: Support configuration of MAC
      vdpa/mlx5: Forward only packets with allowed MAC address

Gustavo A. R. Silva (1):
      ALSA: virtio: Replace zero-length array with flexible-array member

Jason Wang (10):
      virtio-blk: validate num_queues during probe
      virtio_console: validate max_nr_ports before trying to use it
      virtio_config: introduce a new .enable_cbs method
      virtio_pci: harden MSI-X interrupts
      virtio-pci: harden INTX interrupts
      virtio_ring: fix typos in vring_desc_extra
      virtio_ring: validate used buffer length
      virtio-net: don't let virtio core to validate used length
      virtio-blk: don't let virtio core to validate used length
      virtio-scsi: don't let virtio core to validate used buffer length

Laurent Vivier (4):
      hwrng: virtio - add an internal buffer
      hwrng: virtio - don't wait on cleanup
      hwrng: virtio - don't waste entropy
      hwrng: virtio - always add a pending request

Max Gurtovoy (2):
      virtio-blk: avoid preallocating big SGL for data
      virtio-blk: add num_request_queues module parameter

Michael S. Tsirkin (3):
      virtio_net: clarify tailroom logic
      virtio_blk: allow 0 as num_request_queues
      virtio_blk: correct types for status handling

Pankaj Gupta (1):
      virtio-pmem: add myself as virtio-pmem maintainer

Parav Pandit (6):
      vdpa: Introduce and use vdpa device get, set config helpers
      vdpa: Introduce query of device config layout
      vdpa: Use kernel coding style for structure comments
      vdpa: Enable user to set mac and mtu of vdpa device
      vdpa_sim_net: Enable user to set mac address and mtu
      vdpa/mlx5: Fix clearing of VIRTIO_NET_F_MAC feature bit

Viresh Kumar (1):
      i2c: virtio: Add support for zero-length requests

Wu Zongyong (8):
      virtio-pci: introduce legacy device module
      vdpa: fix typo
      vp_vdpa: add vq irq offloading support
      vdpa: add new callback get_vq_num_min in vdpa_config_ops
      vdpa: min vq num of vdpa device cannot be greater than max vq num
      virtio_vdpa: setup correct vq size with callbacks get_vq_num_{max,min}
      vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
      eni_vdpa: add vDPA driver for Alibaba ENI

Xuan Zhuo (2):
      virtio_ring: make virtqueue_add_indirect_packed prettier
      virtio_ring: check desc == NULL when using indirect with packed

Ye Guojin (1):
      virtio-blk: fixup coccinelle warnings

 MAINTAINERS                            |   7 +
 drivers/block/Kconfig                  |   1 +
 drivers/block/virtio_blk.c             | 178 +++++++----
 drivers/char/hw_random/virtio-rng.c    |  84 +++--
 drivers/char/virtio_console.c          |   9 +
 drivers/i2c/busses/i2c-virtio.c        |  56 ++--
 drivers/net/virtio_net.c               |   4 +-
 drivers/scsi/virtio_scsi.c             |   1 +
 drivers/vdpa/Kconfig                   |   8 +
 drivers/vdpa/Makefile                  |   1 +
 drivers/vdpa/alibaba/Makefile          |   3 +
 drivers/vdpa/alibaba/eni_vdpa.c        | 553 +++++++++++++++++++++++++++++++++
 drivers/vdpa/ifcvf/ifcvf_main.c        |   3 +-
 drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c      | 202 ++++++++++--
 drivers/vdpa/vdpa.c                    | 261 +++++++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c   |   3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c   |  38 ++-
 drivers/vdpa/vdpa_user/vduse_dev.c     |   3 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c      |  12 +
 drivers/vhost/vdpa.c                   |   3 +-
 drivers/virtio/Kconfig                 |  10 +
 drivers/virtio/Makefile                |   1 +
 drivers/virtio/virtio_pci_common.c     |  58 +++-
 drivers/virtio/virtio_pci_common.h     |  16 +-
 drivers/virtio/virtio_pci_legacy.c     | 106 ++-----
 drivers/virtio/virtio_pci_legacy_dev.c | 220 +++++++++++++
 drivers/virtio/virtio_pci_modern.c     |   6 +-
 drivers/virtio/virtio_ring.c           |  90 +++++-
 drivers/virtio/virtio_vdpa.c           |  19 +-
 include/linux/vdpa.h                   |  53 ++--
 include/linux/virtio.h                 |   2 +
 include/linux/virtio_config.h          |   6 +
 include/linux/virtio_pci_legacy.h      |  42 +++
 include/uapi/linux/vdpa.h              |   7 +
 include/uapi/linux/virtio_i2c.h        |   6 +
 sound/virtio/virtio_pcm_msg.c          |   5 +-
 37 files changed, 1781 insertions(+), 298 deletions(-)
 create mode 100644 drivers/vdpa/alibaba/Makefile
 create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
 create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
 create mode 100644 include/linux/virtio_pci_legacy.h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
