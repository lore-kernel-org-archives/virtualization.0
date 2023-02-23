Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FA1C636D7
	for <virtualization@archiver.kernel.org>; Thu, 23 Feb 2023 07:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7DF98137D;
	Thu, 23 Feb 2023 07:06:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7DF98137D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=As4/CRjT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id InHQua2_Z7Vi; Thu, 23 Feb 2023 07:06:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1FB328136F;
	Thu, 23 Feb 2023 07:06:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FB328136F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBA1DC0032;
	Thu, 23 Feb 2023 07:06:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A034C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 07:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C31D8137D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 07:06:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C31D8137D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JsFqlHFx3qjV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 07:06:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 085278136F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 085278136F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 07:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677135971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8n/Wv6kU7iSp+dPiMj/81T7Py6OyQC7ue6nMiAoTAs=;
 b=As4/CRjTjHZC1TUs9mApgwwkGEkVNmbryhdq01x3AcDZ2thfzdZ+vvPATTnWNs3sdDZYkh
 +pTfJSse8kiK0D6nLRb6UqOGahl3SHpCqZbipL8D4dB0d0YTs5+f/YAd5jnlhmDhyYzNNy
 aosKc1wxLZVATSE4GR5OjrT/qSpSttA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-399-2bdnA39JMZqemUl8Vfa2Pg-1; Thu, 23 Feb 2023 02:06:08 -0500
X-MC-Unique: 2bdnA39JMZqemUl8Vfa2Pg-1
Received: by mail-wm1-f72.google.com with SMTP id
 e22-20020a05600c219600b003e000facbb1so4651103wme.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 23:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j8n/Wv6kU7iSp+dPiMj/81T7Py6OyQC7ue6nMiAoTAs=;
 b=hlECk0pppCfQf8eFOQCbtvkQvvptMQaUj81+fZ9bqax8TxSSGSzi8dp1dpKXz1wK6d
 2mJSGqMTd7lQmD68PzRU1AMoJ+DK7tOoofkKzeAW6AvxvY3XdPJXKEZfXBH3OYnSaP7g
 oflxlPD9Ryeza+otNXE7dU4oT+G6ZCOUbLIVgRAsOTeiBoloa+zZ2IKAa4CvyFQPLguZ
 knCnv5DD65WXsUsRf33n9Iram/fz2ARFBcQ74NCzBsaWRy187ipIR3fz1VO9HdJ93wVE
 6cXac+3nFFmaWO1yz735l0XXss9uPBsXkfGvlNgz68QXmIQItvJFlDTVmIGxqs0ZO8M9
 XRuQ==
X-Gm-Message-State: AO0yUKW2uoan+uQUi6rb5zucNeZXnOBQg7tiluTUlaXyGm66vmhWhSds
 rgti6EH+g0vYo9qX05sxVAvYXiZZ8ueRopNxnRdenkiGE/4Du1MGpPFZ9er4wLHwpWRR34NnYzc
 40pZsscXZZDwUv0zapK5s09DwOSQscLEIt8HHEpXnxQ==
X-Received: by 2002:a05:600c:70a:b0:3df:eecc:de2b with SMTP id
 i10-20020a05600c070a00b003dfeeccde2bmr2662947wmn.11.1677135967123; 
 Wed, 22 Feb 2023 23:06:07 -0800 (PST)
X-Google-Smtp-Source: AK7set9kWHaMSO72DiFEqLeHQCXNe9kA/HmTOUXVMAe2UhB1KXGu+g3pDG7XYUK9hZYW8K7uthiIbQ==
X-Received: by 2002:a05:600c:70a:b0:3df:eecc:de2b with SMTP id
 i10-20020a05600c070a00b003dfeeccde2bmr2662902wmn.11.1677135966702; 
 Wed, 22 Feb 2023 23:06:06 -0800 (PST)
Received: from redhat.com ([2.52.2.78]) by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c19c700b003e21f20b646sm11912450wmq.21.2023.02.22.23.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Feb 2023 23:06:06 -0800 (PST)
Date: Thu, 23 Feb 2023 02:05:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes
Message-ID: <20230223020356-mutt-send-email-mst@kernel.org>
References: <20230220194045-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230220194045-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stable@vger.kernel.org, bagasdotme@gmail.com, elic@nvidia.com,
 zyytlz.wz@163.com, hch@lst.de, m.szyprowski@samsung.com,
 almasrymina@google.com, sfr@canb.auug.org.au, anders.roxell@linaro.org,
 eperezma@redhat.com, liubo03@inspur.com, yangyingliang@huawei.com,
 lkft@linaro.org, colin.i.king@gmail.com, kangjie.xu@linux.alibaba.com,
 sammler@google.com, leiyang@redhat.com, bhelgaas@google.com,
 suwan.kim027@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 liming.wu@jaguarmicro.com, dmitry.fomichev@wdc.com, sebastien.boeuf@intel.com,
 mie@igel.co.jp
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Linus,

On Mon, Feb 20, 2023 at 07:40:52PM -0500, Michael S. Tsirkin wrote:
> The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d82=
1a:
> =

>   Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)
> =

> are available in the Git repository at:
> =

>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_=
linus
> =

> for you to fetch changes up to deeacf35c922da579637f5db625af20baafc66ed:
> =

>   vdpa/mlx5: support device features provisioning (2023-02-20 19:27:00 -0=
500)
> =

> Note: dropped a patch close to the bottom of the stack at the last
> minute so the commits differ but all of these have been in next already.
> The dropped patch just added a new query ioctl so not interacting with
> anything else in the pull.
> =

> ----------------------------------------------------------------
> virtio,vhost,vdpa: features, fixes
> =

> device feature provisioning in ifcvf, mlx5
> new SolidNET driver
> support for zoned block device in virtio blk
> numa support in virtio pmem
> VIRTIO_F_RING_RESET support in vhost-net
> more debugfs entries in mlx5
> resume support in vdpa
> completion batching in virtio blk
> cleanup of dma api use in vdpa
> now simulating more features in vdpa-sim
> documentation, features, fixes all over the place
> =

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> =

> ----------------------------------------------------------------


Did I muck this one up?  Pls let me know and maybe I can fix it up
before the merge window closes.

Thanks!


> Alvaro Karsz (4):
>       PCI: Add SolidRun vendor ID
>       PCI: Avoid FLR for SolidRun SNET DPU rev 1
>       virtio: vdpa: new SolidNET DPU driver.
>       vhost-vdpa: print warning when vhost_vdpa_alloc_domain fails
> =

> Bagas Sanjaya (3):
>       docs: driver-api: virtio: parenthesize external reference targets
>       docs: driver-api: virtio: slightly reword virtqueues allocation par=
agraph
>       docs: driver-api: virtio: commentize spec version checking
> =

> Bo Liu (1):
>       vhost-scsi: convert sysfs snprintf and sprintf to sysfs_emit
> =

> Colin Ian King (1):
>       vdpa: Fix a couple of spelling mistakes in some messages
> =

> Dmitry Fomichev (1):
>       virtio-blk: add support for zoned block devices
> =

> Eli Cohen (6):
>       vdpa/mlx5: Move some definitions to a new header file
>       vdpa/mlx5: Add debugfs subtree
>       vdpa/mlx5: Add RX counters to debugfs
>       vdpa/mlx5: Directly assign memory key
>       vdpa/mlx5: Don't clear mr struct on destroy MR
>       vdpa/mlx5: Initialize CVQ iotlb spinlock
> =

> Eugenio P=E9rez (2):
>       vdpa_sim: not reset state in vdpasim_queue_ready
>       vdpa_sim_net: Offer VIRTIO_NET_F_STATUS
> =

> Jason Wang (11):
>       vdpa_sim: use weak barriers
>       vdpa_sim: switch to use __vdpa_alloc_device()
>       vdpasim: customize allocation size
>       vdpa_sim: support vendor statistics
>       vdpa_sim_net: vendor satistics
>       vdpa_sim: get rid of DMA ops
>       virtio_ring: per virtqueue dma device
>       vdpa: introduce get_vq_dma_device()
>       virtio-vdpa: support per vq dma device
>       vdpa: set dma mask for vDPA device
>       vdpa: mlx5: support per virtqueue dma device
> =

> Kangjie Xu (1):
>       vhost-net: support VIRTIO_F_RING_RESET
> =

> Liming Wu (2):
>       vhost-test: remove meaningless debug info
>       vhost: remove unused paramete
> =

> Michael S. Tsirkin (3):
>       virtio_blk: temporary variable type tweak
>       virtio_blk: zone append in header type tweak
>       virtio_blk: mark all zone fields LE
> =

> Michael Sammler (1):
>       virtio_pmem: populate numa information
> =

> Ricardo Ca=F1uelo (1):
>       docs: driver-api: virtio: virtio on Linux
> =

> Sebastien Boeuf (4):
>       vdpa: Add resume operation
>       vhost-vdpa: Introduce RESUME backend feature bit
>       vhost-vdpa: uAPI to resume the device
>       vdpa_sim: Implement resume vdpa op
> =

> Shunsuke Mie (2):
>       vringh: fix a typo in comments for vringh_kiov
>       tools/virtio: enable to build with retpoline
> =

> Si-Wei Liu (6):
>       vdpa: fix improper error message when adding vdpa dev
>       vdpa: conditionally read STATUS in config space
>       vdpa: validate provisioned device features against specified attrib=
ute
>       vdpa: validate device feature provisioning against supported class
>       vdpa/mlx5: make MTU/STATUS presence conditional on feature bits
>       vdpa/mlx5: support device features provisioning
> =

> Suwan Kim (2):
>       virtio-blk: set req->state to MQ_RQ_COMPLETE after polling I/O is f=
inished
>       virtio-blk: support completion batching for the IRQ path
> =

> Zheng Wang (1):
>       scsi: virtio_scsi: fix handling of kmalloc failure
> =

> Zhu Lingshan (12):
>       vDPA/ifcvf: decouple hw features manipulators from the adapter
>       vDPA/ifcvf: decouple config space ops from the adapter
>       vDPA/ifcvf: alloc the mgmt_dev before the adapter
>       vDPA/ifcvf: decouple vq IRQ releasers from the adapter
>       vDPA/ifcvf: decouple config IRQ releaser from the adapter
>       vDPA/ifcvf: decouple vq irq requester from the adapter
>       vDPA/ifcvf: decouple config/dev IRQ requester and vectors allocator=
 from the adapter
>       vDPA/ifcvf: ifcvf_request_irq works on ifcvf_hw
>       vDPA/ifcvf: manage ifcvf_hw in the mgmt_dev
>       vDPA/ifcvf: allocate the adapter in dev_add()
>       vDPA/ifcvf: retire ifcvf_private_to_vf
>       vDPA/ifcvf: implement features provisioning
> =

>  Documentation/driver-api/index.rst                 |    1 +
>  Documentation/driver-api/virtio/index.rst          |   11 +
>  Documentation/driver-api/virtio/virtio.rst         |  145 +++
>  .../driver-api/virtio/writing_virtio_drivers.rst   |  197 ++++
>  MAINTAINERS                                        |    5 +
>  drivers/block/virtio_blk.c                         |  468 ++++++++-
>  drivers/nvdimm/virtio_pmem.c                       |   11 +-
>  drivers/pci/quirks.c                               |    8 +
>  drivers/scsi/virtio_scsi.c                         |   14 +-
>  drivers/vdpa/Kconfig                               |   30 +
>  drivers/vdpa/Makefile                              |    1 +
>  drivers/vdpa/ifcvf/ifcvf_base.c                    |   32 +-
>  drivers/vdpa/ifcvf/ifcvf_base.h                    |   10 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c                    |  162 ++-
>  drivers/vdpa/mlx5/Makefile                         |    2 +-
>  drivers/vdpa/mlx5/core/mr.c                        |    1 -
>  drivers/vdpa/mlx5/core/resources.c                 |    3 +-
>  drivers/vdpa/mlx5/net/debug.c                      |  152 +++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c                  |  261 +++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.h                  |   94 ++
>  drivers/vdpa/solidrun/Makefile                     |    6 +
>  drivers/vdpa/solidrun/snet_hwmon.c                 |  188 ++++
>  drivers/vdpa/solidrun/snet_main.c                  | 1111 ++++++++++++++=
++++++
>  drivers/vdpa/solidrun/snet_vdpa.h                  |  194 ++++
>  drivers/vdpa/vdpa.c                                |  110 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c                   |  233 ++--
>  drivers/vdpa/vdpa_sim/vdpa_sim.h                   |    7 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c               |    1 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c               |  219 +++-
>  drivers/vhost/net.c                                |    5 +-
>  drivers/vhost/scsi.c                               |    6 +-
>  drivers/vhost/test.c                               |    3 -
>  drivers/vhost/vdpa.c                               |   39 +-
>  drivers/vhost/vhost.c                              |    2 +-
>  drivers/vhost/vhost.h                              |    2 +-
>  drivers/vhost/vsock.c                              |    2 +-
>  drivers/virtio/virtio_ring.c                       |  133 ++-
>  drivers/virtio/virtio_vdpa.c                       |   13 +-
>  include/linux/pci_ids.h                            |    2 +
>  include/linux/vdpa.h                               |   12 +-
>  include/linux/virtio_config.h                      |    8 +-
>  include/linux/virtio_ring.h                        |   16 +
>  include/linux/vringh.h                             |    2 +-
>  include/uapi/linux/vhost.h                         |    8 +
>  include/uapi/linux/vhost_types.h                   |    2 +
>  include/uapi/linux/virtio_blk.h                    |  105 ++
>  tools/virtio/Makefile                              |    2 +-
>  47 files changed, 3536 insertions(+), 503 deletions(-)
>  create mode 100644 Documentation/driver-api/virtio/index.rst
>  create mode 100644 Documentation/driver-api/virtio/virtio.rst
>  create mode 100644 Documentation/driver-api/virtio/writing_virtio_driver=
s.rst
>  create mode 100644 drivers/vdpa/mlx5/net/debug.c
>  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
>  create mode 100644 drivers/vdpa/solidrun/Makefile
>  create mode 100644 drivers/vdpa/solidrun/snet_hwmon.c
>  create mode 100644 drivers/vdpa/solidrun/snet_main.c
>  create mode 100644 drivers/vdpa/solidrun/snet_vdpa.h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
