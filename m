Return-Path: <SRS0=OlB3=FH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F38C4361A
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:05:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB82207AE
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB82207AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 13FF4879EE;
	Thu,  3 Dec 2020 17:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z5uHmqsdfH7p; Thu,  3 Dec 2020 17:05:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 00358879F0;
	Thu,  3 Dec 2020 17:05:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4F74C163C;
	Thu,  3 Dec 2020 17:05:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A51D3C0FA7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 90342876FA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JyuWNb8trgXo
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2D5E887705
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607015120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v1KF529Mba23/W7kJBq6xiW7t1MnwSejIHh9OVbZeTI=;
 b=dc9ZhtfsFfDDH7NFlA4vMhkCLp4ptxVYOu/F0z3lod4EgRenm8nTD/2Eh8yS6+CXtI14Km
 bpWtl5BsOWo99HUVkkrsZfWTImGVpf+e9+hNZzXMIqQjjoRCjFO28rvT5Iv0CydfsfpgrF
 1++vmNT3GLZujwsCH4MVlWeBheZpUu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-g15nm-3fP5uf8RSQQoMMbQ-1; Thu, 03 Dec 2020 12:05:17 -0500
X-MC-Unique: g15nm-3fP5uf8RSQQoMMbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0224210054FF;
 Thu,  3 Dec 2020 17:05:15 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com
 [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8269C5D6AC;
 Thu,  3 Dec 2020 17:05:12 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 00/19] vdpa: generalize vdpa simulator
Date: Thu,  3 Dec 2020 18:04:52 +0100
Message-Id: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

This series moves the network device simulator in a new module
(vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
module, allowing the possibility to add new vDPA device simulators.

For now I removed the vdpa-blk simulator patches, since I'm still working
on them and debugging the iotlb issues.

Thanks to Max that started this work! I took his patches and extended a bit.

v1: https://lists.linuxfoundation.org/pipermail/virtualization/2020-November/050677.html
v2: https://lists.linuxfoundation.org/pipermail/virtualization/2020-November/051036.html

v3:
 - avoided to remove some headers with structures and functions directly
   used [Jason]
 - defined VHOST_IOTLB_UNLIMITED macro in vhost_iotlb.h [Jason]
 - added set_config callback in vdpasim_dev_attr [Jason]
 - cleared notify during reset [Jason]

Max Gurtovoy (2):
  vdpa_sim: remove hard-coded virtq count
  vdpa: split vdpasim to core and net modules

Stefano Garzarella (17):
  vdpa: remove unnecessary 'default n' in Kconfig entries
  vdpa_sim: remove unnecessary headers inclusion
  vhost/iotlb: add VHOST_IOTLB_UNLIMITED macro
  vdpa_sim: remove the limit of IOTLB entries
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

 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 105 ++++++++++
 include/linux/vhost_iotlb.h          |   2 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 301 +++++++--------------------
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 171 +++++++++++++++
 drivers/vhost/iotlb.c                |   3 +-
 drivers/vdpa/Kconfig                 |  16 +-
 drivers/vdpa/vdpa_sim/Makefile       |   1 +
 7 files changed, 368 insertions(+), 231 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
