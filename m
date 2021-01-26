Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5296C433DB
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 10:27:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C858230FF
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 10:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C858230FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A02308668A;
	Tue, 26 Jan 2021 10:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 84cslFTXJyR6; Tue, 26 Jan 2021 10:27:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 247F086765;
	Tue, 26 Jan 2021 10:27:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06CF3C1DA7;
	Tue, 26 Jan 2021 10:27:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04A32C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 10:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E78638668A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 10:27:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ugexS-Xhs+V1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 10:27:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD9EB86695
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 10:27:46 +0000 (UTC)
IronPort-SDR: Xc+XmsatPoxAM3wp30BUP+X0QR0siVauCIZqaoVmriIXyscQF9ZpARwIjTb+ArXW6YKKFxjlUM
 K5YBM5Pf1FMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="166979417"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="166979417"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 02:27:43 -0800
IronPort-SDR: yffOjaFyK84uQH96XXpXml3jmY2vDoQUknjdEB8x3DMHeMzDv9Sg4UCPkgVd1MYae6zN0Ub8pZ
 pBA8xbVkbaHQ==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="504487434"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.127])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 02:27:43 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC v2 0/3] Introduce Vdmabuf driver
Date: Tue, 26 Jan 2021 02:17:32 -0800
Message-Id: <20210126101735.1304158-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com, daniel.vetter@ffwll.ch
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

The Virtual dmabuf or Virtio based dmabuf (Vdmabuf) driver can be used
to "transfer" a page-backed dmabuf created in the Guest to the Host
without making any copies. This is mostly accomplished by recreating the
dmabuf on the Host using the PFNs and other meta-data shared by the guest. 
A use-case where this driver would be a good fit is a multi-GPU system 
(perhaps one discrete and one integrated) where one of the GPUs does not 
have access to the display/connectors/outputs. This could be an embedded 
system design decision or a restriction made at the firmware/BIOS level
or perhaps the device is setup in UPT (Universal Passthrough) mode. When 
such a GPU is passthrough'd to a Guest OS, this driver can help in 
transferring the scanout buffer(s) (rendered using the native rendering 
stack) to the Host for the purpose of displaying them.

The userspace component running in the Guest that transfers the dmabuf
is referred to as the producer or exporter and its counterpart running
in the Host is referred to as importer or consumer. For instance, a
Wayland compositor would potentially be a producer and Qemu UI would
be a consumer. It is the producer's responsibility to not reuse or
destroy the shared buffer while it is still being used by the consumer.
The consumer would send a release cmd indicating that it is done after
which the shared buffer can be safely used again by the producer. One
way the producer can prevent accidental re-use of the shared buffer is
to lock the buffer when it exports it and unlock it after it gets a 
release cmd. As an example, the GBM API provides a simple way to lock 
and unlock a surface's buffers.

For each dmabuf that is to be shared with the Host, a 128-bit unique
ID is generated that identifies this buffer across the whole system.
This ID is a combination of the Qemu process ID, a counter and a
randomizer. We could potentially use UUID API but we currently use
the above mentioned combination to identify the source of the buffer
at any given time for bookkeeping.

v2:
- Added a notifier mechanism for getting the kvm pointer instead of
  sharing it via VFIO.
- Added start and stop routines in the Vhost backend.
- Augmented the cover letter and made some minor improvements.

Vivek Kasireddy (3):
  kvm: Add a notifier for create and destroy VM events
  virtio: Introduce Vdmabuf driver
  vhost: Add Vdmabuf backend

 drivers/vhost/Kconfig               |    9 +
 drivers/vhost/Makefile              |    3 +
 drivers/vhost/vdmabuf.c             | 1407 +++++++++++++++++++++++++++
 drivers/virtio/Kconfig              |    8 +
 drivers/virtio/Makefile             |    1 +
 drivers/virtio/virtio_vdmabuf.c     |  986 +++++++++++++++++++
 include/linux/kvm_host.h            |    5 +
 include/linux/virtio_vdmabuf.h      |  272 ++++++
 include/uapi/linux/vhost.h          |    3 +
 include/uapi/linux/virtio_ids.h     |    1 +
 include/uapi/linux/virtio_vdmabuf.h |   99 ++
 virt/kvm/kvm_main.c                 |   20 +-
 12 files changed, 2812 insertions(+), 2 deletions(-)
 create mode 100644 drivers/vhost/vdmabuf.c
 create mode 100644 drivers/virtio/virtio_vdmabuf.c
 create mode 100644 include/linux/virtio_vdmabuf.h
 create mode 100644 include/uapi/linux/virtio_vdmabuf.h

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
