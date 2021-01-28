Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B0EC433E0
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 14:41:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF83164DDE
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 14:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF83164DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6DDCB2043A;
	Thu, 28 Jan 2021 14:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjn8HosF4oSC; Thu, 28 Jan 2021 14:41:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BE38420414;
	Thu, 28 Jan 2021 14:41:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3BE9C0FA8;
	Thu, 28 Jan 2021 14:41:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63BCBC08A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 511C820362
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RXrpyWukhO7H
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id E333F20414
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611844904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3vss1A+o8qGBdSHXfpKJnMfjABPVIgXN4y+fS2IFHc=;
 b=TsLyNmc15S5Vhtvpk2kmrp/Q3KkQ7WMW1Zetmj3F9sZRuoM9hQahFerpXf2edQxXBlfzDh
 eicdd8+H+hviUAqT9HgCabZHOLK6Rq1AIQas1qBsH0ChpvIa7wWkcqsTPkwsBAY6GPwoBA
 m2l9OIWm7m6Uq5M7S7D/jD4pVTeLD8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-RVybKE0iNBiFO21dpPwxnw-1; Thu, 28 Jan 2021 09:41:42 -0500
X-MC-Unique: RVybKE0iNBiFO21dpPwxnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1414EC1A1;
 Thu, 28 Jan 2021 14:41:41 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-219.ams2.redhat.com
 [10.36.113.219])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 720B760875;
 Thu, 28 Jan 2021 14:41:39 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 02/10] vringh: add 'iotlb_lock' to synchronize iotlb
 accesses
Date: Thu, 28 Jan 2021 15:41:19 +0100
Message-Id: <20210128144127.113245-3-sgarzare@redhat.com>
In-Reply-To: <20210128144127.113245-1-sgarzare@redhat.com>
References: <20210128144127.113245-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Usually iotlb accesses are synchronized with a spinlock.
Let's request it as a new parameter in vringh_set_iotlb() and
hold it when we navigate the iotlb in iotlb_translate() to avoid
race conditions with any new additions/deletions of ranges from
the ioltb.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vringh.h           | 6 +++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
 drivers/vhost/vringh.c           | 9 ++++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 59bd50f99291..9c077863c8f6 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -46,6 +46,9 @@ struct vringh {
 	/* IOTLB for this vring */
 	struct vhost_iotlb *iotlb;
 
+	/* spinlock to synchronize IOTLB accesses */
+	spinlock_t *iotlb_lock;
+
 	/* The function to call to notify the guest about added buffers */
 	void (*notify)(struct vringh *);
 };
@@ -258,7 +261,8 @@ static inline __virtio64 cpu_to_vringh64(const struct vringh *vrh, u64 val)
 
 #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
 
-void vringh_set_iotlb(struct vringh *vrh, struct vhost_iotlb *iotlb);
+void vringh_set_iotlb(struct vringh *vrh, struct vhost_iotlb *iotlb,
+		      spinlock_t *iotlb_lock);
 
 int vringh_init_iotlb(struct vringh *vrh, u64 features,
 		      unsigned int num, bool weak_barriers,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 2183a833fcf4..53238989713d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -284,7 +284,8 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 		goto err_iommu;
 
 	for (i = 0; i < dev_attr->nvqs; i++)
-		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
+		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu,
+				 &vdpasim->iommu_lock);
 
 	ret = iova_cache_get();
 	if (ret)
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 85d85faba058..f68122705719 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1074,6 +1074,8 @@ static int iotlb_translate(const struct vringh *vrh,
 	int ret = 0;
 	u64 s = 0;
 
+	spin_lock(vrh->iotlb_lock);
+
 	while (len > s) {
 		u64 size, pa, pfn;
 
@@ -1103,6 +1105,8 @@ static int iotlb_translate(const struct vringh *vrh,
 		++ret;
 	}
 
+	spin_unlock(vrh->iotlb_lock);
+
 	return ret;
 }
 
@@ -1262,10 +1266,13 @@ EXPORT_SYMBOL(vringh_init_iotlb);
  * vringh_set_iotlb - initialize a vringh for a ring with IOTLB.
  * @vrh: the vring
  * @iotlb: iotlb associated with this vring
+ * @iotlb_lock: spinlock to synchronize the iotlb accesses
  */
-void vringh_set_iotlb(struct vringh *vrh, struct vhost_iotlb *iotlb)
+void vringh_set_iotlb(struct vringh *vrh, struct vhost_iotlb *iotlb,
+		      spinlock_t *iotlb_lock)
 {
 	vrh->iotlb = iotlb;
+	vrh->iotlb_lock = iotlb_lock;
 }
 EXPORT_SYMBOL(vringh_set_iotlb);
 
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
