Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96ECC63697
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 14:50:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4227E20B80
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 14:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNaPY7Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4227E20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C7F9787411;
	Thu, 26 Nov 2020 14:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JOOWe5izcQvO; Thu, 26 Nov 2020 14:50:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6691D873FD;
	Thu, 26 Nov 2020 14:50:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D952C163C;
	Thu, 26 Nov 2020 14:50:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 827ECC0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6E9DB2E242
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lu2ljDMsfl9S
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id E25572E245
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606402238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6pFL40zOfd0tqmsESxpEqmuQVPd0caaEj6DcUiifgB8=;
 b=UNaPY7Dgyvpq9OM1kTle9BRxpZcZEdcHaDkWrD9470/Yy+zDikIwQe67cmAdk0q9yM+CwT
 7BPqEif7xT7im7lIKHwDO14l1yeJU+Bd9Dsl6zj8XoJCmIYd4gfi60gvVHOOzw1gJUVpNO
 ItOtcDpHTw9Oy+5qy6wwqRzR2WdVGP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-KMmRDZWeNl2n_MkIOF3ONA-1; Thu, 26 Nov 2020 09:50:36 -0500
X-MC-Unique: KMmRDZWeNl2n_MkIOF3ONA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 832C6805BFF;
 Thu, 26 Nov 2020 14:50:35 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-252.ams2.redhat.com
 [10.36.113.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77FD65C1BD;
 Thu, 26 Nov 2020 14:50:27 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 04/17] vdpa_sim: remove the limit of IOTLB entries
Date: Thu, 26 Nov 2020 15:49:37 +0100
Message-Id: <20201126144950.92850-5-sgarzare@redhat.com>
In-Reply-To: <20201126144950.92850-1-sgarzare@redhat.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

The simulated devices can support multiple queues, so this limit
should be defined according to the number of queues supported by
the device.

Since we are in a simulator, let's simply remove that limit.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- added VDPASIM_IOTLB_LIMIT macro [Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index ad72f7b1a4eb..40664d87f303 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -46,6 +46,7 @@ struct vdpasim_virtqueue {
 #define VDPASIM_QUEUE_MAX 256
 #define VDPASIM_DEVICE_ID 0x1
 #define VDPASIM_VENDOR_ID 0
+#define VDPASIM_IOTLB_LIMIT 0 /* unlimited */
 #define VDPASIM_VQ_NUM 0x2
 #define VDPASIM_NAME "vdpasim-netdev"
 
@@ -365,7 +366,7 @@ static struct vdpasim *vdpasim_create(void)
 	if (!vdpasim->vqs)
 		goto err_iommu;
 
-	vdpasim->iommu = vhost_iotlb_alloc(2048, 0);
+	vdpasim->iommu = vhost_iotlb_alloc(VDPASIM_IOTLB_LIMIT, 0);
 	if (!vdpasim->iommu)
 		goto err_iommu;
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
