Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7578CC433F5
	for <virtualization@archiver.kernel.org>; Thu, 23 Dec 2021 07:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EDE84401B7;
	Thu, 23 Dec 2021 07:48:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zu7HBKhVTiat; Thu, 23 Dec 2021 07:48:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3EF2A400B5;
	Thu, 23 Dec 2021 07:48:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 224A3C002F;
	Thu, 23 Dec 2021 07:48:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1740AC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 07:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05D8781A73
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 07:48:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jn-oPuSNacxg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 07:48:42 +0000 (UTC)
X-Greylist: delayed 00:05:17 by SQLgrey-1.8.0
Received: from mxus.zte.com.cn (mxus.zte.com.cn [20.112.44.237])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDD3581A4E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 07:48:42 +0000 (UTC)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxus.zte.com.cn (FangMail) with ESMTPS id 4JKMcp4jBMz9wMT7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 15:43:22 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4JKMcg6mC1z6FK87
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 15:43:15 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4JKMcX0KgVz6DjmB;
 Thu, 23 Dec 2021 15:43:08 +0800 (CST)
Received: from kjyxapp03.zte.com.cn ([10.30.12.202])
 by mse-fl1.zte.com.cn with SMTP id 1BN7eYfH012388;
 Thu, 23 Dec 2021 15:40:34 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-cloudhost8.localdomain (unknown [10.234.72.110])
 by smtp (Zmail) with SMTP; Thu, 23 Dec 2021 15:40:34 +0800
X-Zmail-TransId: 3e8861c427f1016-c1630
From: Yi Wang <wang.yi59@zte.com.cn>
To: mst@redhat.com
Subject: [PATCH] vdpa: regist vhost-vdpa dev class
Date: Thu, 23 Dec 2021 15:31:45 +0800
Message-Id: <20211223073145.35363-1-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 2.33.0.rc0.dirty
MIME-Version: 1.0
X-MAIL: mse-fl1.zte.com.cn 1BN7eYfH012388
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at 10-207-168-7 with ID 61C42899.000 by FangMail milter!
X-FangMail-Envelope: 1640245403/4JKMcp4jBMz9wMT7/61C42899.000/192.168.250.138/[192.168.250.138]/mxhk.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 61C42899.000/4JKMcp4jBMz9wMT7
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
 drivers/vhost/vdpa.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index fb41db3da611..90fbad93e7a2 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1012,6 +1012,7 @@ static void vhost_vdpa_release_dev(struct device *device)
 	kfree(v);
 }
 
+static struct class *vhost_vdpa_class;
 static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 {
 	const struct vdpa_config_ops *ops = vdpa->config;
@@ -1040,6 +1041,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 	v->dev.release = vhost_vdpa_release_dev;
 	v->dev.parent = &vdpa->dev;
 	v->dev.devt = MKDEV(MAJOR(vhost_vdpa_major), minor);
+	v->dev.class = vhost_vdpa_class;
 	v->vqs = kmalloc_array(v->nvqs, sizeof(struct vhost_virtqueue),
 			       GFP_KERNEL);
 	if (!v->vqs) {
@@ -1097,6 +1099,14 @@ static int __init vhost_vdpa_init(void)
 {
 	int r;
 
+	vhost_vdpa_class = class_create(THIS_MODULE, "vhost-vdpa");
+	if (IS_ERR(vhost_vdpa_class)) {
+		r = PTR_ERR(vhost_vdpa_class);
+		pr_warn("vhost vdpa class create error %d,  maybe mod reinserted\n", r);
+		vhost_vdpa_class = NULL;
+		return r;
+	}
+
 	r = alloc_chrdev_region(&vhost_vdpa_major, 0, VHOST_VDPA_DEV_MAX,
 				"vhost-vdpa");
 	if (r)
@@ -1111,6 +1121,7 @@ static int __init vhost_vdpa_init(void)
 err_vdpa_register_driver:
 	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
 err_alloc_chrdev:
+	class_destroy(vhost_vdpa_class);
 	return r;
 }
 module_init(vhost_vdpa_init);
@@ -1118,6 +1129,7 @@ module_init(vhost_vdpa_init);
 static void __exit vhost_vdpa_exit(void)
 {
 	vdpa_unregister_driver(&vhost_vdpa_driver);
+	class_destroy(vhost_vdpa_class);
 	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
 }
 module_exit(vhost_vdpa_exit);
-- 
2.27.0
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
