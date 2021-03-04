Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE81C433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 13:27:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA61364F09
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 13:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA61364F09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F7F243242;
	Thu,  4 Mar 2021 13:27:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sCKV7gYeg_oM; Thu,  4 Mar 2021 13:27:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20D0642FBA;
	Thu,  4 Mar 2021 13:27:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 883C3C0001;
	Thu,  4 Mar 2021 13:27:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 065F0C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 13:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D27126F5B9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 13:27:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kxNrL6G8IEcF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 13:27:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3E426F501
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 13:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614864448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U25hfNafb9SuM5dJFfJmewNpYbdjseyyxBquOrBCTHM=;
 b=XCGEoVtzXt2DFAzUr6G9t+27aW1BQkomKx8JtlFIMR6OeJJUzvIhqvoyCgQqJi80U+eO/Z
 KAVZx7CE58EAZnKvDY9/RzUGszXgWZD1rOn9N4wMwdpzBbCTwG/nziJqZW7NIDKFXqVAof
 I2DXRGzMYE9gfz1Heqvq1Hs0wi5WrNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-P_KvLWMVMT21oGPPTfUxxw-1; Thu, 04 Mar 2021 08:27:26 -0500
X-MC-Unique: P_KvLWMVMT21oGPPTfUxxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1B4D800D53;
 Thu,  4 Mar 2021 13:27:25 +0000 (UTC)
Received: from gondolin.redhat.com (ovpn-114-163.ams2.redhat.com
 [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D3C5175BD;
 Thu,  4 Mar 2021 13:27:24 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC 1/2] virtio/s390: add parameter for minimum revision
Date: Thu,  4 Mar 2021 14:27:14 +0100
Message-Id: <20210304132715.1587211-2-cohuck@redhat.com>
In-Reply-To: <20210304132715.1587211-1-cohuck@redhat.com>
References: <20210304132715.1587211-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

We use transport revisions in virtio-ccw for introducing new commands
etc.; revision 1 denotes operating according to the standard. Legacy
devices do not understand the command to set a revision; for those, we
presume to operate at revision 0.

Add a parameter min_revision to be able to actively restrict use of
old transport revisions. In particular, setting a minimum revision
of 1 makes our driver act as a non-transitional driver.

With the default min_revision of 0, we continue to act as a
transitional driver.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/virtio/virtio_ccw.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 54e686dca6de..0d3971dbc109 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -34,6 +34,16 @@
 #include <asm/isc.h>
 #include <asm/airq.h>
 
+/*
+ * Provide a knob to turn off support for older revisions. This is useful
+ * if we want to act as a non-transitional virtio device driver: requiring
+ * a minimum revision of 1 turns off support for legacy devices.
+ */
+static int min_revision;
+
+module_param(min_revision, int, 0444);
+MODULE_PARM_DESC(min_revision, "minimum transport revision to accept");
+
 /*
  * virtio related functions
  */
@@ -1271,7 +1281,10 @@ static int virtio_ccw_set_transport_rev(struct virtio_ccw_device *vcdev)
 			else
 				vcdev->revision--;
 		}
-	} while (ret == -EOPNOTSUPP);
+	} while (vcdev->revision >= min_revision && ret == -EOPNOTSUPP);
+
+	if (ret == -EOPNOTSUPP && vcdev->revision < min_revision)
+		ret = -EINVAL;
 
 	ccw_device_dma_free(vcdev->cdev, ccw, sizeof(*ccw));
 	ccw_device_dma_free(vcdev->cdev, rev, sizeof(*rev));
@@ -1315,8 +1328,12 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	vcdev->vdev.id.device = cdev->id.cu_model;
 
 	ret = virtio_ccw_set_transport_rev(vcdev);
-	if (ret)
+	if (ret) {
+		dev_warn(&cdev->dev,
+			 "Could not set a supported transport revision: %d\n",
+			 ret);
 		goto out_free;
+	}
 
 	ret = register_virtio_device(&vcdev->vdev);
 	if (ret) {
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
