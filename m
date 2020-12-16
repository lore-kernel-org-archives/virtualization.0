Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53930C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:49:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC57322D6E
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC57322D6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7139886936;
	Wed, 16 Dec 2020 06:49:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EuFWNnA0-A8r; Wed, 16 Dec 2020 06:49:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 02177868A2;
	Wed, 16 Dec 2020 06:49:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E193AC0893;
	Wed, 16 Dec 2020 06:49:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B3BDC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0A3F9868A2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LavCFGUekUF4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:48:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6E778868BC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608101338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1wGiR5ck2yvdjVfO9bdwiXV8Qqssa2OPNn+O4kB1Xw=;
 b=T8KYTVSG+XOG4JmUInnrCwUWoDtQ5IdqF0zK/oMDsE5Sk76NRhME9QiGGb3zkFMkVJR0Y+
 JYhcUWvPiZDLV2xo4JFPzGso/r2h6cSrXS57fas3PGwUce6BudcUVb410LTiugrC4eSu4/
 6+w7R8hDBt7K5TrdUNQjOPyDXEgBH8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-VH7HS5KzPyaQEqQ-QIwKVw-1; Wed, 16 Dec 2020 01:48:56 -0500
X-MC-Unique: VH7HS5KzPyaQEqQ-QIwKVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 858CD801AA3;
 Wed, 16 Dec 2020 06:48:55 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-210.pek2.redhat.com [10.72.12.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7266A10016FF;
 Wed, 16 Dec 2020 06:48:51 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 04/21] vhost-vdpa: switch to use vhost-vdpa specific IOTLB
Date: Wed, 16 Dec 2020 14:48:01 +0800
Message-Id: <20201216064818.48239-5-jasowang@redhat.com>
In-Reply-To: <20201216064818.48239-1-jasowang@redhat.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, lulu@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com, eli@mellanox.com,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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

To ease the implementation of per group ASID support for vDPA
device. This patch switches to use a vhost-vdpa specific IOTLB to
avoid the unnecessary refactoring of the vhost core.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 07f92d48c173..9bcc03d4e68b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -39,6 +39,7 @@ struct vhost_vdpa {
 	struct vhost_virtqueue *vqs;
 	struct completion completion;
 	struct vdpa_device *vdpa;
+	struct vhost_iotlb *iotlb;
 	struct device dev;
 	struct cdev cdev;
 	atomic_t opened;
@@ -526,12 +527,11 @@ static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
 
 static void vhost_vdpa_iotlb_free(struct vhost_vdpa *v)
 {
-	struct vhost_dev *dev = &v->vdev;
-	struct vhost_iotlb *iotlb = dev->iotlb;
+	struct vhost_iotlb *iotlb = v->iotlb;
 
 	vhost_vdpa_iotlb_unmap(v, iotlb, 0ULL, 0ULL - 1);
-	kfree(dev->iotlb);
-	dev->iotlb = NULL;
+	kfree(v->iotlb);
+	v->iotlb = NULL;
 }
 
 static int perm_to_iommu_flags(u32 perm)
@@ -745,7 +745,7 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 	struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
-	struct vhost_iotlb *iotlb = dev->iotlb;
+	struct vhost_iotlb *iotlb = v->iotlb;
 	int r = 0;
 
 	r = vhost_dev_check_owner(dev);
@@ -883,15 +883,15 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 	vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
 		       vhost_vdpa_process_iotlb_msg);
 
-	dev->iotlb = vhost_iotlb_alloc(0, 0);
-	if (!dev->iotlb) {
+	v->iotlb = vhost_iotlb_alloc(0, 0);
+	if (!v->iotlb) {
 		r = -ENOMEM;
 		goto err_init_iotlb;
 	}
 
 	r = vhost_vdpa_alloc_domain(v);
 	if (r)
-		goto err_init_iotlb;
+		goto err_alloc_domain;
 
 	vhost_vdpa_set_iova_range(v);
 
@@ -899,6 +899,8 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 
 	return 0;
 
+err_alloc_domain:
+	vhost_vdpa_iotlb_free(v);
 err_init_iotlb:
 	vhost_dev_cleanup(&v->vdev);
 	kfree(vqs);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
