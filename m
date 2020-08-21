Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0587C433DF
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 09:28:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E6D207DA
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 09:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfpJYSGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E6D207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A237B885FF;
	Fri, 21 Aug 2020 09:28:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H6KwWAgoREKK; Fri, 21 Aug 2020 09:28:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A9B4885D0;
	Fri, 21 Aug 2020 09:28:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BCE7C0889;
	Fri, 21 Aug 2020 09:28:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42038C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 09:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2F0181FEAE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 09:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BCMgvNUvAumc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 09:28:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 753A81FD90
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598002109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc; bh=I+BEhjcX4SAr8jSjnZvZnUPdx/ThUX5bf8qM1MA/oeM=;
 b=CfpJYSGHnD1//ihp8X4Zg+nmmV+V/9qr030+5re+2ABpUE4GFIrAMjXdkcQf1ly3+5ltYs
 oHNyppNyYCNjAQT4PIpx9Hsgdku50FOPEYycq96e5XDWwa5EivZEZ7N5RucufxLgx8cF95
 1lCS2vw2u4+/fImmV7frg9XVgEHZchs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-dG8vhwgIPHWsKBs9P1Whog-1; Fri, 21 Aug 2020 05:28:25 -0400
X-MC-Unique: dG8vhwgIPHWsKBs9P1Whog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A0A680EF8D;
 Fri, 21 Aug 2020 09:28:23 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96E387191C;
 Fri, 21 Aug 2020 09:28:15 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] vDPA: API for reporting IOVA range
Date: Fri, 21 Aug 2020 05:28:10 -0400
Message-Id: <20200821092813.8952-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, gdawar@xilinx.com,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi All:

This series introduces API for reporing IOVA range. This is a must for
userspace to work correclty:

- for the process that uses vhost-vDPA directly to properly allocate
  IOVA
- for VM(qemu), when vIOMMU is not enabled, fail early if GPA is out
  of range
- for VM(qemu), when vIOMMU is enabled, determine a valid guest
  address width

Please review.

Changes from V1:

- do not mandate get_iova_range() for device with its own DMA
  translation logic and assume a [0, ULLONG_MAX] range
- mandate IOVA range only for IOMMU that forcing aperture
- forbid the map which is out of the IOVA range in vhost-vDPA

Thanks

Jason Wang (3):
  vdpa: introduce config op to get valid iova range
  vhost: vdpa: report iova range
  vdpa_sim: implement get_iova_range()

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 12 ++++++++++
 drivers/vhost/vdpa.c             | 41 ++++++++++++++++++++++++++++++++
 include/linux/vdpa.h             | 15 ++++++++++++
 include/uapi/linux/vhost.h       |  4 ++++
 include/uapi/linux/vhost_types.h |  9 +++++++
 5 files changed, 81 insertions(+)

-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
