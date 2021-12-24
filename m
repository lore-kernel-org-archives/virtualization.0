Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09619C433F5
	for <virtualization@archiver.kernel.org>; Fri, 24 Dec 2021 07:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95FC240150;
	Fri, 24 Dec 2021 07:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePsTYX0bfsRd; Fri, 24 Dec 2021 07:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0291640140;
	Fri, 24 Dec 2021 07:13:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB7CCC001E;
	Fri, 24 Dec 2021 07:13:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AC7FC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Dec 2021 07:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD2E340914
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Dec 2021 07:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5G_QokGqnAtr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Dec 2021 07:13:09 +0000 (UTC)
X-Greylist: delayed 23:29:50 by SQLgrey-1.8.0
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0BD14090E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Dec 2021 07:13:08 +0000 (UTC)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4JKyvP70Xyz4yjZ8;
 Fri, 24 Dec 2021 15:13:05 +0800 (CST)
Received: from kjyxapp05.zte.com.cn ([10.30.12.204])
 by mse-fl1.zte.com.cn with SMTP id 1BO7CqRn066889;
 Fri, 24 Dec 2021 15:12:52 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-cloudhost8.localdomain (unknown [10.234.72.110])
 by smtp (Zmail) with SMTP; Fri, 24 Dec 2021 15:12:52 +0800
X-Zmail-TransId: 3e8861c572f3016-f9693
From: Yi Wang <wang.yi59@zte.com.cn>
To: mst@redhat.com
Subject: [PATCH v2] vdpa: regist vhost-vdpa dev class
Date: Fri, 24 Dec 2021 15:04:04 +0800
Message-Id: <20211224070404.54840-1-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 2.33.0.rc0.dirty
MIME-Version: 1.0
X-MAIL: mse-fl1.zte.com.cn 1BO7CqRn066889
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID
 61C57301.000 by FangMail milter!
X-FangMail-Envelope: 1640329986/4JKyvP70Xyz4yjZ8/61C57301.000/10.30.14.238/[10.30.14.238]/mse-fl1.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 61C57301.000/4JKyvP70Xyz4yjZ8
Cc: wang.yi59@zte.com.cn, Zhang Min <zhang.min9@zte.com.cn>,
 wang.liang82@zte.com.cn, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xue.zhihong@zte.com.cn
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

From: Zhang Min <zhang.min9@zte.com.cn>

Some applications like kata-containers need to acquire MAJOR/MINOR/DEVNAME
for devInfo [1], so regist vhost-vdpa dev class to expose uevent.

1. https://github.com/kata-containers/kata-containers/blob/main/src/runtime/virtcontainers/device/config/config.go

Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
v2: remove redundant vhost_vdpa_class reset and pr_warn, adjust location
    of *vhost_vdpa_class impl and class_destroy.

 drivers/vhost/vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index e3c4f059b21a..55e966c508c8 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -53,6 +53,7 @@ struct vhost_vdpa {
 static DEFINE_IDA(vhost_vdpa_ida);
 
 static dev_t vhost_vdpa_major;
+static struct class *vhost_vdpa_class;
 
 static void handle_vq_kick(struct vhost_work *work)
 {
@@ -1140,6 +1141,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 	v->dev.release = vhost_vdpa_release_dev;
 	v->dev.parent = &vdpa->dev;
 	v->dev.devt = MKDEV(MAJOR(vhost_vdpa_major), minor);
+	v->dev.class = vhost_vdpa_class;
 	v->vqs = kmalloc_array(v->nvqs, sizeof(struct vhost_virtqueue),
 			       GFP_KERNEL);
 	if (!v->vqs) {
@@ -1197,6 +1199,10 @@ static int __init vhost_vdpa_init(void)
 {
 	int r;
 
+	vhost_vdpa_class = class_create(THIS_MODULE, "vhost-vdpa");
+	if (IS_ERR(vhost_vdpa_class))
+		return PTR_ERR(vhost_vdpa_class);
+
 	r = alloc_chrdev_region(&vhost_vdpa_major, 0, VHOST_VDPA_DEV_MAX,
 				"vhost-vdpa");
 	if (r)
@@ -1211,6 +1217,7 @@ static int __init vhost_vdpa_init(void)
 err_vdpa_register_driver:
 	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
 err_alloc_chrdev:
+	class_destroy(vhost_vdpa_class);
 	return r;
 }
 module_init(vhost_vdpa_init);
@@ -1219,6 +1226,7 @@ static void __exit vhost_vdpa_exit(void)
 {
 	vdpa_unregister_driver(&vhost_vdpa_driver);
 	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
+	class_destroy(vhost_vdpa_class);
 }
 module_exit(vhost_vdpa_exit);
 
-- 
2.27.0
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
