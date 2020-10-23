Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCF4C55179
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 15:39:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51A120E65
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 15:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ato4djox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51A120E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 32863873D9;
	Fri, 23 Oct 2020 15:39:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r_fu2m_dtm0k; Fri, 23 Oct 2020 15:39:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AFB5086EC0;
	Fri, 23 Oct 2020 15:39:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84615C088B;
	Fri, 23 Oct 2020 15:39:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DD12C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EAFF52107F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:39:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2adD-KkUWV29
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:39:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 3058E2079D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=J409roG8zhXcXXCErK007R3MrYblBFNCZHcPyX0EW1c=;
 b=ato4djoxJfdL0DPdufQLUuA2IuDBu0X8yUSJyklvDkNC6173YgfMrb8eJggCJjth2SQWkM
 X8oija8Vnn9wN8n8oxEfeN5QNNaZY0NDcsm/k5flYvWWPYxf0sE3w/6DgmjuTF3juHA0JO
 wlB54QYgwWpzWbEi7i5wcSqJR7F0rmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-WxrfRJEEOtWeuf0CbspCdA-1; Fri, 23 Oct 2020 11:38:56 -0400
X-MC-Unique: WxrfRJEEOtWeuf0CbspCdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8F7E80400B;
 Fri, 23 Oct 2020 15:38:53 +0000 (UTC)
Received: from redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 948346EF5D;
 Fri, 23 Oct 2020 15:38:34 +0000 (UTC)
Date: Fri, 23 Oct 2020 11:38:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vhost,vdpa,virtio: cleanups, fixes
Message-ID: <20201023113832-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: pankaj.gupta.linux@gmail.com, pmorel@linux.ibm.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
 rikard.falkeborn@gmail.com, virtualization@lists.linux-foundation.org,
 li.wang@windriver.com, borntraeger@de.ibm.com, stable@vger.kernel.org,
 tiantao6@hisilicon.com, elic@nvidia.com, lingshan.zhu@intel.com
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

Was holding out for a couple of big new features including vop and rpmsg
support for 1.0, but it looks like they won't make it in time.
virtio i2c might be ready soon but that's a new driver so
if it's ready soon it's probably ok to merge outside the merge
window ... we'll see.

The following changes since commit bbf5c979011a099af5dc76498918ed7df445635b:

  Linux 5.9 (2020-10-11 14:15:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 88a0d60c6445f315fbcfff3db792021bb3a67b28:

  MAINTAINERS: add URL for virtio-mem (2020-10-21 10:48:11 -0400)

----------------------------------------------------------------
vhost,vdpa,virtio: cleanups, fixes

A very quiet cycle, no new features.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (1):
      MAINTAINERS: add URL for virtio-mem

Eli Cohen (3):
      vdpa/mlx5: Make use of a specific 16 bit endianness API
      vdpa/mlx5: Fix failure to bring link up
      vdpa/mlx5: Setup driver only if VIRTIO_CONFIG_S_DRIVER_OK

Li Wang (1):
      vhost: reduce stack usage in log_used

Pierre Morel (2):
      virtio: let arch advertise guest's memory access restrictions
      s390: virtio: PV needs VIRTIO I/O device protection

Rikard Falkeborn (3):
      virtio-balloon: Constify id_table
      virtio_input: Constify id_table
      virtio-mem: Constify mem_id_table

Stefano Garzarella (1):
      vringh: fix __vringh_iov() when riov and wiov are different

Tian Tao (1):
      vhost_vdpa: Fix duplicate included kernel.h

Zhu Lingshan (1):
      vhost_vdpa: remove unnecessary spin_lock in vhost_vring_call

 MAINTAINERS                       |  1 +
 arch/s390/Kconfig                 |  1 +
 arch/s390/mm/init.c               | 11 +++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++--
 drivers/vhost/vdpa.c              |  9 +--------
 drivers/vhost/vhost.c             |  5 +----
 drivers/vhost/vhost.h             |  2 +-
 drivers/vhost/vringh.c            |  9 +++++----
 drivers/virtio/Kconfig            |  6 ++++++
 drivers/virtio/virtio.c           | 15 +++++++++++++++
 drivers/virtio/virtio_balloon.c   |  2 +-
 drivers/virtio/virtio_input.c     |  2 +-
 drivers/virtio/virtio_mem.c       |  2 +-
 include/linux/virtio_config.h     | 10 ++++++++++
 14 files changed, 65 insertions(+), 22 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
