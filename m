Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE5DC4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 07:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C161A611A5;
	Thu, 10 Mar 2022 07:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GEceBJb2rN0Q; Thu, 10 Mar 2022 07:52:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1FED9611B6;
	Thu, 10 Mar 2022 07:52:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB169C0012;
	Thu, 10 Mar 2022 07:52:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53087C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 07:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2ECE440609
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 07:52:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BJHWBNM0LZm5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 07:52:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FBBF404CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 07:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646898739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=d/kJbw1ceOFiXhO5YIO+i0r0c+TxsMqa/iGcWfOLU3I=;
 b=hP3OK/FXs2Dx6KTyJo5svUPnIYuRmuOP5qWXW4jUGrBekMr9Xw733pREgaHUFGQjvHRo8u
 8fjlG4PyULa/eo+a4fnoG62gVEv4KbKwIJ+DORBbqpOVzKKIIj21S3TWjItrTmsUrxaHjX
 2FoFEvIGlje2zXBc8sRCF2buvRiGyhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-5l8F3TN-PgeNTt8YBimUDQ-1; Thu, 10 Mar 2022 02:52:17 -0500
X-MC-Unique: 5l8F3TN-PgeNTt8YBimUDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A65FD51DC;
 Thu, 10 Mar 2022 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-194.pek2.redhat.com
 [10.72.13.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D69437A220;
 Thu, 10 Mar 2022 07:52:13 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com
Subject: [PATCH] vhost: allow batching hint without size
Date: Thu, 10 Mar 2022 15:52:11 +0800
Message-Id: <20220310075211.4801-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Anirudh Rayabharam <mail@anirudhrb.com>, Eli Cohen <elic@nvidia.com>
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

Commit e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb
entries") tries to reject the IOTLB message whose size is zero. But
the size is not necessarily meaningful, one example is the batching
hint, so the commit breaks that.

Fixing this be reject zero size message only if the message is used to
update/invalidate the IOTLB.

Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entries")
Reported-by: Eli Cohen <elic@nvidia.com>
Cc: Anirudh Rayabharam <mail@anirudhrb.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 082380c03a3e..1768362115c6 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1170,7 +1170,9 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 		goto done;
 	}
 
-	if (msg.size == 0) {
+	if ((msg.type == VHOST_IOTLB_UPDATE ||
+	     msg.type == VHOST_IOTLB_INVALIDATE) &&
+	     msg.size == 0) {
 		ret = -EINVAL;
 		goto done;
 	}
-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
