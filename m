Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19221ECAAA1
	for <virtualization@archiver.kernel.org>; Thu, 15 Sep 2022 08:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF45841025;
	Thu, 15 Sep 2022 08:51:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF45841025
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QaSxQqat
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qCpL_n_UxnFD; Thu, 15 Sep 2022 08:51:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2327B4032A;
	Thu, 15 Sep 2022 08:51:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2327B4032A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E94ECC0033;
	Thu, 15 Sep 2022 08:51:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 728FAC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 08:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E6E9401B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 08:51:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E6E9401B0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QaSxQqat
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id btjaR7xVDatK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 08:51:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9549A401A0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9549A401A0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663231861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GENWxAVvpWd3dVo6dm0mZc+x/Kx2jIgk/iiRb5OOLbg=;
 b=QaSxQqatvdyXaMnAN3CsYZehjKTNrwQJXLzHetQmMy6NyW6+16L73rI6s004mmm3YJsGvD
 SEFIZy7V7f8Na6ppElEDNkog/XOM87Ux+e9kkbuEh1daoaeh9nNJ6b96CdWIPGD25G038V
 JMTOYGvEmWsene8AxijAvoCOLTuwdZc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-dSUG1HUlNtCHrmg3fr2PXQ-1; Thu, 15 Sep 2022 04:50:58 -0400
X-MC-Unique: dSUG1HUlNtCHrmg3fr2PXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92604858F13;
 Thu, 15 Sep 2022 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-201.pek2.redhat.com
 [10.72.12.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 108A91759E;
 Thu, 15 Sep 2022 08:50:51 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 0/3] vdpa: device feature provisioning
Date: Thu, 15 Sep 2022 16:50:45 +0800
Message-Id: <20220915085048.12840-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: lulu@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, wuzongyong@linux.alibaba.com, elic@nvidia.com,
 lingshan.zhu@intel.com
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

Hi All:

Virtio features are neogiated between the device and the drivers. This
allows the mediation layer like vDPA to hide some features from the
driver to faciliate the cross vendor live migration:

vDPA on the source supports feature set X
vDPA on the destination supports feature set Y

Management can simply provision the vDPA instance with features X&Y on
both source and destination to let the vDPA can be migrate-able
between the two vDPA devies with different features support.

This series tries to allow the device features to be provisioned via
netlink to achieve this.

Please review.

Thanks

Jason Wang (3):
  vdpa: device feature provisioning
  vdpa_sim_net: support feature provisioning
  vp_vdpa: support feature provisioning

 drivers/vdpa/vdpa.c                  |  5 +++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
 drivers/vdpa/virtio_pci/vp_vdpa.c    | 16 ++++++++++++++--
 include/linux/vdpa.h                 |  1 +
 include/uapi/linux/vdpa.h            |  2 ++
 5 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
