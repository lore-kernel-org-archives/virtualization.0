Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7554AE81DFF
	for <virtualization@archiver.kernel.org>; Fri,  6 Oct 2023 14:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E26D9616B5;
	Fri,  6 Oct 2023 14:31:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E26D9616B5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uPKWiP1S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s4YIT9SS8XF5; Fri,  6 Oct 2023 14:31:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 50CCD60E8A;
	Fri,  6 Oct 2023 14:31:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50CCD60E8A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20E6FC0039;
	Fri,  6 Oct 2023 14:31:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA751C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Oct 2023 14:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F6A461456
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Oct 2023 14:31:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F6A461456
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zcu4NoPI-WSx
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Oct 2023 14:31:00 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF84760E8A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Oct 2023 14:30:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF84760E8A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id D7C14B8298C;
 Fri,  6 Oct 2023 14:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CBAC433C8;
 Fri,  6 Oct 2023 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1696602654;
 bh=2fhphZG6bxXgGCz3VDXIQ9daJxLkRB/ZDJs2CpCzMAY=;
 h=From:To:Cc:Subject:Date:From;
 b=uPKWiP1SV4F7vTV3NT7BFtFzwcQaeWdCBLCOV7OOb+f4Ej+Zp4DvxjkEFs3IP63q8
 f0++zS91i5/o3Zvq5y54lKvmrWDZyTx3CoD/xMGvhFQgPjNYijut7ku4760DFdtZ51
 VByWkE+Jjp9fUUi5hCdDr/U9OTOHRuW5jKfh2vm4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vduse: make vduse_class constant
Date: Fri,  6 Oct 2023 16:30:44 +0200
Message-ID: <2023100643-tricolor-citizen-6c2d@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4498;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=2fhphZG6bxXgGCz3VDXIQ9daJxLkRB/ZDJs2CpCzMAY=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDKkKUsKfim/9VthzaaV8576syabXTz60elDWo58ssdto1
 tWH81bv74hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJ/PvIsGA2Q//D46VTpjgt
 jDCa/9T47L7VU/MZ5sqvOssbtz3o0NRDOnUHeJXvPpI78AwA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>
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

Now that the driver core allows for struct class to be in read-only
memory, we should make all 'class' structures declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at runtime.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++--------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index df7869537ef1..0ddd4b8abecb 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -134,7 +134,6 @@ static DEFINE_MUTEX(vduse_lock);
 static DEFINE_IDR(vduse_idr);
 
 static dev_t vduse_major;
-static struct class *vduse_class;
 static struct cdev vduse_ctrl_cdev;
 static struct cdev vduse_cdev;
 static struct workqueue_struct *vduse_irq_wq;
@@ -1528,6 +1527,16 @@ static const struct kobj_type vq_type = {
 	.default_groups	= vq_groups,
 };
 
+static char *vduse_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
+}
+
+static const struct class vduse_class = {
+	.name = "vduse",
+	.devnode = vduse_devnode,
+};
+
 static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
 {
 	int i;
@@ -1638,7 +1647,7 @@ static int vduse_destroy_dev(char *name)
 	mutex_unlock(&dev->lock);
 
 	vduse_dev_reset(dev);
-	device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
+	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
 	idr_remove(&vduse_idr, dev->minor);
 	kvfree(dev->config);
 	vduse_dev_deinit_vqs(dev);
@@ -1805,7 +1814,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 
 	dev->minor = ret;
 	dev->msg_timeout = VDUSE_MSG_DEFAULT_TIMEOUT;
-	dev->dev = device_create_with_groups(vduse_class, NULL,
+	dev->dev = device_create_with_groups(&vduse_class, NULL,
 				MKDEV(MAJOR(vduse_major), dev->minor),
 				dev, vduse_dev_groups, "%s", config->name);
 	if (IS_ERR(dev->dev)) {
@@ -1821,7 +1830,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 
 	return 0;
 err_vqs:
-	device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
+	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
 err_dev:
 	idr_remove(&vduse_idr, dev->minor);
 err_idr:
@@ -1934,11 +1943,6 @@ static const struct file_operations vduse_ctrl_fops = {
 	.llseek		= noop_llseek,
 };
 
-static char *vduse_devnode(const struct device *dev, umode_t *mode)
-{
-	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
-}
-
 struct vduse_mgmt_dev {
 	struct vdpa_mgmt_dev mgmt_dev;
 	struct device dev;
@@ -2082,11 +2086,9 @@ static int vduse_init(void)
 	int ret;
 	struct device *dev;
 
-	vduse_class = class_create("vduse");
-	if (IS_ERR(vduse_class))
-		return PTR_ERR(vduse_class);
-
-	vduse_class->devnode = vduse_devnode;
+	ret = class_register(&vduse_class);
+	if (ret)
+		return ret;
 
 	ret = alloc_chrdev_region(&vduse_major, 0, VDUSE_DEV_MAX, "vduse");
 	if (ret)
@@ -2099,7 +2101,7 @@ static int vduse_init(void)
 	if (ret)
 		goto err_ctrl_cdev;
 
-	dev = device_create(vduse_class, NULL, vduse_major, NULL, "control");
+	dev = device_create(&vduse_class, NULL, vduse_major, NULL, "control");
 	if (IS_ERR(dev)) {
 		ret = PTR_ERR(dev);
 		goto err_device;
@@ -2141,13 +2143,13 @@ static int vduse_init(void)
 err_wq:
 	cdev_del(&vduse_cdev);
 err_cdev:
-	device_destroy(vduse_class, vduse_major);
+	device_destroy(&vduse_class, vduse_major);
 err_device:
 	cdev_del(&vduse_ctrl_cdev);
 err_ctrl_cdev:
 	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
 err_chardev_region:
-	class_destroy(vduse_class);
+	class_unregister(&vduse_class);
 	return ret;
 }
 module_init(vduse_init);
@@ -2159,10 +2161,10 @@ static void vduse_exit(void)
 	destroy_workqueue(vduse_irq_bound_wq);
 	destroy_workqueue(vduse_irq_wq);
 	cdev_del(&vduse_cdev);
-	device_destroy(vduse_class, vduse_major);
+	device_destroy(&vduse_class, vduse_major);
 	cdev_del(&vduse_ctrl_cdev);
 	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
-	class_destroy(vduse_class);
+	class_unregister(&vduse_class);
 }
 module_exit(vduse_exit);
 
-- 
2.42.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
