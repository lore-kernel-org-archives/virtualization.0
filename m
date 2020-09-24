Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A01C4727E
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:23:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE36C23600
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP9a/jX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE36C23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C7B0B84103;
	Thu, 24 Sep 2020 03:23:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5hg19HY7BCLy; Thu, 24 Sep 2020 03:22:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B4FC86AC4;
	Thu, 24 Sep 2020 03:22:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0458EC0889;
	Thu, 24 Sep 2020 03:22:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6471AC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5071B2D002
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XrMdl37Oxll7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:22:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 924BD237C8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600917775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roAbV6FPOAWx9gZkzOd8DWSbxuYMFGVoYNhpPWU7Hyw=;
 b=UP9a/jX4f1Uexret2Hxew3+RorGic4zxtZP3BgL9BQm5nsIDYANFEyARUoAU/uic7ucauU
 1/mG6FHhFu//FQt1ScnoUqKLKR5cKo/jt8FheGuEq0yeA3zIcYyLTWMXjV8hhvbWk42B1g
 +xzfYHJQwa3Qc1Tdr0tAkhopemMIFXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-H6YhDPIZMa6CiLbp26wgHw-1; Wed, 23 Sep 2020 23:22:53 -0400
X-MC-Unique: H6YhDPIZMa6CiLbp26wgHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAD14186DD2C;
 Thu, 24 Sep 2020 03:22:51 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF28D3782;
 Thu, 24 Sep 2020 03:22:35 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH 06/24] vhost-vdpa: switch to use vhost-vdpa specific IOTLB
Date: Thu, 24 Sep 2020 11:21:07 +0800
Message-Id: <20200924032125.18619-7-jasowang@redhat.com>
In-Reply-To: <20200924032125.18619-1-jasowang@redhat.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: lulu@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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
 drivers/vhost/vdpa.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 74bef1c15a70..ec3c94f706c1 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -40,6 +40,7 @@ struct vhost_vdpa {
 	struct vhost_virtqueue *vqs;
 	struct completion completion;
 	struct vdpa_device *vdpa;
+	struct vhost_iotlb *iotlb;
 	struct device dev;
 	struct cdev cdev;
 	atomic_t opened;
@@ -514,12 +515,11 @@ static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
 
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
@@ -681,7 +681,7 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 	struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
-	struct vhost_iotlb *iotlb = dev->iotlb;
+	struct vhost_iotlb *iotlb = v->iotlb;
 	int r = 0;
 
 	r = vhost_dev_check_owner(dev);
@@ -812,12 +812,14 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 
 	r = vhost_vdpa_alloc_domain(v);
 	if (r)
-		goto err_init_iotlb;
+		goto err_alloc_domain;
 
 	filep->private_data = v;
 
 	return 0;
 
+err_alloc_domain:
+	vhost_vdpa_iotlb_free(v);
 err_init_iotlb:
 	vhost_vdpa_cleanup(v);
 err:
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
