Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBABC4332F
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:53:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B1A6108F
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30B1A6108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECDA8405DF;
	Tue, 12 Oct 2021 06:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2YNGpT5zNzuM; Tue, 12 Oct 2021 06:53:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A9B7C405D0;
	Tue, 12 Oct 2021 06:53:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85A76C000F;
	Tue, 12 Oct 2021 06:53:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2615C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9594402B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8OjGdp2NKspk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 226B8405DA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634021594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEx0s8/aKXt0XKMD6l6fHz2qIfkUzAG/Tkrbj3E9G4I=;
 b=HNMna6g28CxvgMj+4W2qGmYM32aE37Y4lfKsgYnsXCGrWXRoPOTfug5d/Qi7PHGE0RI5E4
 L5bSGVBbZIb2YoWRb46S/seGm++H+LzkEZ0a4rslNMkORlS7b/ITVWZEuQ9kAgZJuVApkY
 +IsGgXfGw35PFcmh5+od1ndM/lPSNHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-DnXh8jXpNJiTYoybPzyYCw-1; Tue, 12 Oct 2021 02:53:08 -0400
X-MC-Unique: DnXh8jXpNJiTYoybPzyYCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB33418A0735;
 Tue, 12 Oct 2021 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-111.pek2.redhat.com
 [10.72.13.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C848E5F4E0;
 Tue, 12 Oct 2021 06:52:40 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 03/12] virtio-console: switch to use .validate()
Date: Tue, 12 Oct 2021 14:52:18 +0800
Message-Id: <20211012065227.9953-4-jasowang@redhat.com>
In-Reply-To: <20211012065227.9953-1-jasowang@redhat.com>
References: <20211012065227.9953-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
