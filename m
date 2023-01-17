Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8165BC677F1
	for <virtualization@archiver.kernel.org>; Tue, 17 Jan 2023 15:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F28EE81EAE;
	Tue, 17 Jan 2023 15:16:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F28EE81EAE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OuhR+DOn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kglTWWYq_LWW; Tue, 17 Jan 2023 15:16:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8DA9781462;
	Tue, 17 Jan 2023 15:16:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DA9781462
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77BADC0032;
	Tue, 17 Jan 2023 15:16:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E909C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6892141622
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6892141622
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OuhR+DOn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OPW3Onc8mmVx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 630CD4160A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 630CD4160A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673968611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=smNNRaeV0+/HRXen5xw9CFj2kNpy5x+VFPv/e/OcsJU=;
 b=OuhR+DOnopXjqzZnmY+fCD2SppPf7mcv8LtkNHC1JFeHxOodbK0916mAS9xHO2yQQBzJDf
 mqLcJOu61TeQHlDRhEM73L1aqW3lFjcJZElrufSWQn1GvLUcuj8o9O89lZOai051I65FZo
 Xa3z668idU2cIVHmoN4xonUUlj0qhRM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-5HCBiZ2QOC-SunYOPDLNSw-1; Tue, 17 Jan 2023 10:16:40 -0500
X-MC-Unique: 5HCBiZ2QOC-SunYOPDLNSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 297E82804158;
 Tue, 17 Jan 2023 15:15:22 +0000 (UTC)
Received: from qualcomm-amberwing-rep-06.khw4.lab.eng.bos.redhat.com
 (qualcomm-amberwing-rep-06.khw4.lab.eng.bos.redhat.com [10.19.240.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCFA640C6EC4;
 Tue, 17 Jan 2023 15:15:21 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 0/2] vhost/net: Clear the pending messages when the backend is
 removed
Date: Tue, 17 Jan 2023 10:15:16 -0500
Message-Id: <20230117151518.44725-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: lvivier@redhat.com
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

When the vhost iotlb is used along with a guest virtual iommu
and the guest gets rebooted, some MISS messages may have been
recorded just before the reboot and spuriously executed by
the virtual iommu after the reboot. This is due to the fact
the pending messages are not cleared.

As vhost does not have any explicit reset user API,
VHOST_NET_SET_BACKEND looks a reasonable point where to clear
the pending messages, in case the backend is removed (fd = -1).

This version is a follow-up on the discussions held in [1].

The first patch removes an unused 'enabled' parameter in
vhost_init_device_iotlb().

Best Regards

Eric

History:
[1] RFC: [RFC] vhost: Clear the pending messages on vhost_init_device_iotlb()
https://lore.kernel.org/all/20221107203431.368306-1-eric.auger@redhat.com/

Eric Auger (2):
  vhost: Remove the enabled parameter from vhost_init_device_iotlb
  vhost/net: Clear the pending messages when the backend is removed

 drivers/vhost/net.c   | 5 ++++-
 drivers/vhost/vhost.c | 5 +++--
 drivers/vhost/vhost.h | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
