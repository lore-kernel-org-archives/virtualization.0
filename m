Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A2EC63697
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:47:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E672222F
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZN+yGDgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E672222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0489987487;
	Fri, 13 Nov 2020 13:47:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ur2OXBgzwkMC; Fri, 13 Nov 2020 13:47:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0332C87516;
	Fri, 13 Nov 2020 13:47:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4345C0891;
	Fri, 13 Nov 2020 13:47:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0538AC0891
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DFE0887465
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QNngTcGiWpLa
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1467C8745B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605275247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUSCXqZfVu5qowPNJ7+Usz2GPpNw0QJvHN5TBNVtPXI=;
 b=ZN+yGDgV8jI5n1dsGxqnrMVHHTdSXMiIAeA6DC5eudT5gBdrlrt6gj4oa75vx3r3oSPDig
 t1iK51OW5V2QxOqXYjdALctHAUuoG7h2mLEeC3Ein7amMgEvbZmFdm2imS+/Ejnuzw5JA8
 r8HOm3Gq/2SXbr4X9H9/5SsHcDslJDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259--0QA5k77MY-frLRzGvAyxA-1; Fri, 13 Nov 2020 08:47:25 -0500
X-MC-Unique: -0QA5k77MY-frLRzGvAyxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D55210066FA;
 Fri, 13 Nov 2020 13:47:24 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com
 [10.36.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5310B60C84;
 Fri, 13 Nov 2020 13:47:22 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 01/12] vhost-vdpa: add support for vDPA blk devices
Date: Fri, 13 Nov 2020 14:47:01 +0100
Message-Id: <20201113134712.69744-2-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
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

From: Max Gurtovoy <maxg@mellanox.com>

Currently only net devices can act as vDPA backends. Add an
infrastructure for block devices will basic feature list that will be
increased in the future.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vdpa.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 2754f3069738..fb0411594963 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -22,6 +22,7 @@
 #include <linux/nospec.h>
 #include <linux/vhost.h>
 #include <linux/virtio_net.h>
+#include <linux/virtio_blk.h>
 
 #include "vhost.h"
 
@@ -194,6 +195,9 @@ static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
 	case VIRTIO_ID_NET:
 		size = sizeof(struct virtio_net_config);
 		break;
+	case VIRTIO_ID_BLOCK:
+		size = sizeof(struct virtio_blk_config);
+		break;
 	}
 
 	if (c->len == 0)
@@ -975,12 +979,13 @@ static void vhost_vdpa_release_dev(struct device *device)
 static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 {
 	const struct vdpa_config_ops *ops = vdpa->config;
+	u32 device_id = ops->get_device_id(vdpa);
 	struct vhost_vdpa *v;
 	int minor;
 	int r;
 
-	/* Currently, we only accept the network devices. */
-	if (ops->get_device_id(vdpa) != VIRTIO_ID_NET)
+	/* Currently, we only accept the network and block devices. */
+	if (device_id != VIRTIO_ID_NET && device_id != VIRTIO_ID_BLOCK)
 		return -ENOTSUPP;
 
 	v = kzalloc(sizeof(*v), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
@@ -998,7 +1003,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 	v->minor = minor;
 	v->vdpa = vdpa;
 	v->nvqs = vdpa->nvqs;
-	v->virtio_id = ops->get_device_id(vdpa);
+	v->virtio_id = device_id;
 
 	device_initialize(&v->dev);
 	v->dev.release = vhost_vdpa_release_dev;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
