Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB2CC388F7
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:47:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A612722201
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDSzAIMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A612722201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 68ABE87465;
	Fri, 13 Nov 2020 13:47:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lb-pSBDAekbo; Fri, 13 Nov 2020 13:47:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C38FE8745B;
	Fri, 13 Nov 2020 13:47:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A40CBC0891;
	Fri, 13 Nov 2020 13:47:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F13ABC0800
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CEAD420439
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SupC3qAJ43Zy
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id C6E5220435
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605275247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OfulPYTZhsoQhkiaVeD/pLg5PazzTZIGNLw9gLcaGuw=;
 b=LDSzAIMWnZNLLzLQ6YKlAtN2oKrY8SejuDLaRvN/28BD6fTI2z3xLKRz5ZBP8kwW8PUBzp
 d1R8mGJWNpn+W0Otlr7ZzIKNyrJF2iXrZvvcWaTRAPplvXADrU8jVHOUjk8uyksvm2VbPa
 +qDmfDypdAvtUAqL6dDGmIvCdohLlCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-XlpqqaSlMveemIZAxuAuLA-1; Fri, 13 Nov 2020 08:47:23 -0500
X-MC-Unique: XlpqqaSlMveemIZAxuAuLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0B36809DC4;
 Fri, 13 Nov 2020 13:47:21 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com
 [10.36.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEA8D60C84;
 Fri, 13 Nov 2020 13:47:13 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block device
Date: Fri, 13 Nov 2020 14:47:00 +0100
Message-Id: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Thanks to Max that started this work!
I took his patches, and extended the block simulator a bit.

This series moves the network device simulator in a new module
(vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
module, allowing the possibility to add new vDPA device simulators.
Then we added a new vdpa_sim_blk module to simulate a block device.

I'm not sure about patch 11 ("vringh: allow vringh_iov_xfer() to skip
bytes when ptr is NULL"), maybe we can add a new functions instead of
modify vringh_iov_xfer().

As Max reported, I'm also seeing errors with vdpa_sim_blk related to
iotlb and vringh when there is high load, these are some of the error
messages I can see randomly:

  vringh: Failed to access avail idx at 00000000e8deb2cc
  vringh: Failed to read head: idx 6289 address 00000000e1ad1d50
  vringh: Failed to get flags at 000000006635d7a3

  virtio_vdpa vdpa0: vringh_iov_push_iotlb() error: -14 offset: 0x2840000 len: 0x20000
  virtio_vdpa vdpa0: vringh_iov_pull_iotlb() error: -14 offset: 0x58ee000 len: 0x3000

These errors should all be related to the fact that iotlb_translate()
fails with -EINVAL, so it seems that we miss some mapping.

I'll debug more carefully, in the meantime can you give a first review?

Thanks,
Stefano

Max Gurtovoy (4):
  vhost-vdpa: add support for vDPA blk devices
  vdpa: split vdpasim to core and net modules
  vdpa_sim: remove hard-coded virtq count
  vdpa: add vdpa simulator for block device

Stefano Garzarella (8):
  vdpa_sim: remove the limit of IOTLB entries
  vdpa_sim: add struct vdpasim_device to store device properties
  vdpa_sim: move config management outside of the core
  vdpa_sim: use kvmalloc to allocate vdpasim->buffer
  vdpa_sim: make vdpasim->buffer size configurable
  vdpa_sim: split vdpasim_virtqueue's iov field in riov and wiov
  vringh: allow vringh_iov_xfer() to skip bytes when ptr is NULL
  vdpa_sim_blk: implement ramdisk behaviour

 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 117 +++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 283 +++++----------------------
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 251 ++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 172 ++++++++++++++++
 drivers/vhost/vdpa.c                 |  11 +-
 drivers/vhost/vringh.c               |  16 +-
 drivers/vdpa/Kconfig                 |  16 +-
 drivers/vdpa/vdpa_sim/Makefile       |   2 +
 8 files changed, 628 insertions(+), 240 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
