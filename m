Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358C2C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 05:54:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1AA860E76
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 05:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1AA860E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA2DD8105B;
	Mon, 13 Sep 2021 05:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GDU5LLDnE1uc; Mon, 13 Sep 2021 05:54:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6732380EF2;
	Mon, 13 Sep 2021 05:54:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A594C000F;
	Mon, 13 Sep 2021 05:54:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08B59C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC3FE608B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:54:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OARpOKyG6GzU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:54:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 479C560849
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631512479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEx0s8/aKXt0XKMD6l6fHz2qIfkUzAG/Tkrbj3E9G4I=;
 b=eM0Av0kNRcOZl4aOwRvf+0dr5GSmxpbpnULfc/6GuDUEfC5IbXJHBW35qdk7sc0ByVVfed
 lpQvNgBmWaiW08h9vLzaSzYsC+T3yWyvcE+72hmwHGAQqB60KXi44I1cJzfcEljPD83Req
 CG7Q7ba81xjXnkEUwyxDUi/iRma8spU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-Mr5BwugGMlCO3EwREBRr5A-1; Mon, 13 Sep 2021 01:54:37 -0400
X-MC-Unique: Mr5BwugGMlCO3EwREBRr5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30A808145FF;
 Mon, 13 Sep 2021 05:54:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-146.pek2.redhat.com
 [10.72.13.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 615D15F706;
 Mon, 13 Sep 2021 05:54:33 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 3/9] virtio-console: switch to use .validate()
Date: Mon, 13 Sep 2021 13:53:47 +0800
Message-Id: <20210913055353.35219-4-jasowang@redhat.com>
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: f.hetzelt@tu-berlin.de, david.kaplan@amd.com, Amit Shah <amit@kernel.org>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

This patch switches to use validate() to filter out the features that
is not supported by the rproc.

Cc: Amit Shah <amit@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/char/virtio_console.c | 41 ++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7eaf303a7a86..daeed31df622 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1172,9 +1172,7 @@ static void resize_console(struct port *port)
 
 	vdev = port->portdev->vdev;
 
-	/* Don't test F_SIZE at all if we're rproc: not a valid feature! */
-	if (!is_rproc_serial(vdev) &&
-	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
 		hvc_resize(port->cons.hvc, port->cons.ws);
 }
 
@@ -1981,6 +1979,29 @@ static void virtcons_remove(struct virtio_device *vdev)
 	kfree(portdev);
 }
 
+static int virtcons_validate(struct virtio_device *vdev)
+{
+	if (is_rproc_serial(vdev)) {
+		/* Don't test F_SIZE at all if we're rproc: not a
+		 * valid feature! */
+		__virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_SIZE);
+		/* Don't test MULTIPORT at all if we're rproc: not a
+		 * valid feature! */
+		__virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_MULTIPORT);
+	}
+
+	/* We only need a config space if features are offered */
+	if (!vdev->config->get &&
+	    (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
+	     || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -1996,15 +2017,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 	bool multiport;
 	bool early = early_put_chars != NULL;
 
-	/* We only need a config space if features are offered */
-	if (!vdev->config->get &&
-	    (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
-	     || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
-		dev_err(&vdev->dev, "%s failure: config access disabled\n",
-			__func__);
-		return -EINVAL;
-	}
-
 	/* Ensure to read early_put_chars now */
 	barrier();
 
@@ -2031,9 +2043,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 	multiport = false;
 	portdev->max_nr_ports = 1;
 
-	/* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
-	if (!is_rproc_serial(vdev) &&
-	    virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
+	if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
 				 struct virtio_console_config, max_nr_ports,
 				 &portdev->max_nr_ports) == 0) {
 		multiport = true;
@@ -2210,6 +2220,7 @@ static struct virtio_driver virtio_console = {
 	.driver.name =	KBUILD_MODNAME,
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
+	.validate = 	virtcons_validate,
 	.probe =	virtcons_probe,
 	.remove =	virtcons_remove,
 	.config_changed = config_intr,
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
