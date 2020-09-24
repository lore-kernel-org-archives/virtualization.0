Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2470C4727F
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:21:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A43323600
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfNmrvwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A43323600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E154B2046A;
	Thu, 24 Sep 2020 03:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o3SryfKKEdLa; Thu, 24 Sep 2020 03:21:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D610522D24;
	Thu, 24 Sep 2020 03:21:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD53AC0889;
	Thu, 24 Sep 2020 03:21:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B569C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 07C4D84B8B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:21:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SJtVXww5nosp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:21:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 09E1C806E9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600917713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1vAH2sOnIecyBuC1bgws2niE0JgFrbZ244nIj8c+DU=;
 b=QfNmrvwJBadRabo8pG733x/M+caGWv6Rz4YK7j+/V5WcSZll9sJP3xp2sva0dbzJ3q2AOj
 L6g29iRyWkeBMUuvIMZQXGuJJsyw4GsQxsABtcdgUw+AX2y5vIy2sHjDwe4OIqqWp9U+uQ
 0xz5cyDe4lcGGxT7RNUBZk2qEsyP4tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-XMWz49fsN5a-IB1C8BEtBQ-1; Wed, 23 Sep 2020 23:21:51 -0400
X-MC-Unique: XMWz49fsN5a-IB1C8BEtBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 269FE801AF7;
 Thu, 24 Sep 2020 03:21:50 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEC8855768;
 Thu, 24 Sep 2020 03:21:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH 01/24] vhost-vdpa: fix backend feature ioctls
Date: Thu, 24 Sep 2020 11:21:02 +0800
Message-Id: <20200924032125.18619-2-jasowang@redhat.com>
In-Reply-To: <20200924032125.18619-1-jasowang@redhat.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: lulu@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com,
 Eli Cohen <elic@nvidia.com>, rob.miller@broadcom.com
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

Commit 653055b9acd4 ("vhost-vdpa: support get/set backend features")
introduces two malfunction backend features ioctls:

1) the ioctls was blindly added to vring ioctl instead of vdpa device
   ioctl
2) vhost_set_backend_features() was called when dev mutex has already
   been held which will lead a deadlock

This patch fixes the above issues.

Cc: Eli Cohen <elic@nvidia.com>
Reported-by: Zhu Lingshan <lingshan.zhu@intel.com>
Fixes: 653055b9acd4 ("vhost-vdpa: support get/set backend features")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 3fab94f88894..796fe979f997 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -353,8 +353,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	struct vdpa_callback cb;
 	struct vhost_virtqueue *vq;
 	struct vhost_vring_state s;
-	u64 __user *featurep = argp;
-	u64 features;
 	u32 idx;
 	long r;
 
@@ -381,18 +379,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 
 		vq->last_avail_idx = vq_state.avail_index;
 		break;
-	case VHOST_GET_BACKEND_FEATURES:
-		features = VHOST_VDPA_BACKEND_FEATURES;
-		if (copy_to_user(featurep, &features, sizeof(features)))
-			return -EFAULT;
-		return 0;
-	case VHOST_SET_BACKEND_FEATURES:
-		if (copy_from_user(&features, featurep, sizeof(features)))
-			return -EFAULT;
-		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
-			return -EOPNOTSUPP;
-		vhost_set_backend_features(&v->vdev, features);
-		return 0;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
@@ -440,8 +426,20 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	struct vhost_vdpa *v = filep->private_data;
 	struct vhost_dev *d = &v->vdev;
 	void __user *argp = (void __user *)arg;
+	u64 __user *featurep = argp;
+	u64 features;
 	long r;
 
+	if (cmd == VHOST_SET_BACKEND_FEATURES) {
+		r = copy_from_user(&features, featurep, sizeof(features));
+		if (r)
+			return r;
+		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
+			return -EOPNOTSUPP;
+		vhost_set_backend_features(&v->vdev, features);
+		return 0;
+	}
+
 	mutex_lock(&d->mutex);
 
 	switch (cmd) {
@@ -476,6 +474,10 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_VDPA_SET_CONFIG_CALL:
 		r = vhost_vdpa_set_config_call(v, argp);
 		break;
+	case VHOST_GET_BACKEND_FEATURES:
+		features = VHOST_VDPA_BACKEND_FEATURES;
+		r = copy_to_user(featurep, &features, sizeof(features));
+		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
 		if (r == -ENOIOCTLCMD)
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
