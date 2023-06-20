Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D97EEB64DB
	for <virtualization@archiver.kernel.org>; Tue, 20 Jun 2023 14:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6C5060675;
	Tue, 20 Jun 2023 14:38:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6C5060675
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1/VVDyNP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mtACOccdg2mH; Tue, 20 Jun 2023 14:38:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6BF77606AA;
	Tue, 20 Jun 2023 14:38:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BF77606AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 299FEC007A;
	Tue, 20 Jun 2023 14:38:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE72AC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 14:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AF3E6132E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 14:38:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AF3E6132E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QR8IzCd3Alti
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 14:38:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0BC860BCC
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0BC860BCC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 14:38:16 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C9F0E612CF;
 Tue, 20 Jun 2023 14:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7E2C433C9;
 Tue, 20 Jun 2023 14:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1687271895;
 bh=PAixi759Cz1x+tiJzMc3suOwGcDgCCsJLx/WttsdMWc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1/VVDyNPTy6shHFXNSyLza0tEw+ynXaKDdMVpC6amPiWtuJnqDJBoB4JMvwC/YQ2+
 w8Xtdsc1KhRZsZi2y7msPOArg762c6WPHih7R9DgCoe13wWWGWNbc0CxlZvTDTVot5
 r/A9C1JKzIBSzdIYBP77KaCXWYfT4eQpYrlgvqXc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] virtio_console: make port class a static const structure
Date: Tue, 20 Jun 2023 16:37:58 +0200
Message-ID: <20230620143751.578239-16-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620143751.578239-10-gregkh@linuxfoundation.org>
References: <20230620143751.578239-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3508;
 i=gregkh@linuxfoundation.org; h=from:subject;
 bh=nRhWIu09KBDqvQssi6osu1p4RellAMun0YZOyYbob5w=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDCkTdx4wjtUKP3DdcUau9qOZotND0y2UwqzCIjZG8D/R/
 lgTUX6pI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZyKJdhvn/LtuVmYSmGPKqv
 znJs3T+Pg23RZ4b5+Z4m4We/c2obOEXz/K+WO7lbNfQaAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 virtualization@lists.linux-foundation.org,
 Ivan Orlov <ivan.orlov0322@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>
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

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, remove the class field of the ports_driver_data structure and
create the port_class static class structure declared at build time
which places it into read-only memory, instead of having it to be
dynamically allocated at load time.

Cc: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/virtio_console.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index b65c809a4e97..1f8da0a71ce9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -40,9 +40,6 @@
  * across multiple devices and multiple ports per device.
  */
 struct ports_driver_data {
-	/* Used for registering chardevs */
-	struct class *class;
-
 	/* Used for exporting per-port information to debugfs */
 	struct dentry *debugfs_dir;
 
@@ -55,6 +52,10 @@ struct ports_driver_data {
 
 static struct ports_driver_data pdrvdata;
 
+static const struct class port_class = {
+	.name = "virtio-ports",
+};
+
 static DEFINE_SPINLOCK(pdrvdata_lock);
 static DECLARE_COMPLETION(early_console_added);
 
@@ -1399,7 +1400,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 			"Error %d adding cdev for port %u\n", err, id);
 		goto free_cdev;
 	}
-	port->dev = device_create(pdrvdata.class, &port->portdev->vdev->dev,
+	port->dev = device_create(&port_class, &port->portdev->vdev->dev,
 				  devt, port, "vport%up%u",
 				  port->portdev->vdev->index, id);
 	if (IS_ERR(port->dev)) {
@@ -1465,7 +1466,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 
 free_inbufs:
 free_device:
-	device_destroy(pdrvdata.class, port->dev->devt);
+	device_destroy(&port_class, port->dev->devt);
 free_cdev:
 	cdev_del(port->cdev);
 free_port:
@@ -1540,7 +1541,7 @@ static void unplug_port(struct port *port)
 	port->portdev = NULL;
 
 	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
-	device_destroy(pdrvdata.class, port->dev->devt);
+	device_destroy(&port_class, port->dev->devt);
 	cdev_del(port->cdev);
 
 	debugfs_remove(port->debugfs_file);
@@ -2244,12 +2245,9 @@ static int __init virtio_console_init(void)
 {
 	int err;
 
-	pdrvdata.class = class_create("virtio-ports");
-	if (IS_ERR(pdrvdata.class)) {
-		err = PTR_ERR(pdrvdata.class);
-		pr_err("Error %d creating virtio-ports class\n", err);
+	err = class_register(&port_class);
+	if (err)
 		return err;
-	}
 
 	pdrvdata.debugfs_dir = debugfs_create_dir("virtio-ports", NULL);
 	INIT_LIST_HEAD(&pdrvdata.consoles);
@@ -2271,7 +2269,7 @@ static int __init virtio_console_init(void)
 	unregister_virtio_driver(&virtio_console);
 free:
 	debugfs_remove_recursive(pdrvdata.debugfs_dir);
-	class_destroy(pdrvdata.class);
+	class_unregister(&port_class);
 	return err;
 }
 
@@ -2282,7 +2280,7 @@ static void __exit virtio_console_fini(void)
 	unregister_virtio_driver(&virtio_console);
 	unregister_virtio_driver(&virtio_rproc_serial);
 
-	class_destroy(pdrvdata.class);
+	class_unregister(&port_class);
 	debugfs_remove_recursive(pdrvdata.debugfs_dir);
 }
 module_init(virtio_console_init);
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
