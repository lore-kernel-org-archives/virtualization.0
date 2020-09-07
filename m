Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C065C433E2
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 10:44:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A6520738
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 10:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+5E/3yD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A6520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 60A6D859D5;
	Mon,  7 Sep 2020 10:44:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9yfeJW3ZW4f0; Mon,  7 Sep 2020 10:44:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 68A1C84C33;
	Mon,  7 Sep 2020 10:44:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57CC9C0052;
	Mon,  7 Sep 2020 10:44:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DF38C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 03B2C8664B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7YXJuvSij1jF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:43:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 337CF86044
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599475437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c1vAH2sOnIecyBuC1bgws2niE0JgFrbZ244nIj8c+DU=;
 b=c+5E/3yDO70ZbiPkNa4L/2zeH2iwZBcd7wMROQUnARLBqwCuoRIH1UmMPM9MaCyL6hygbc
 /gKJh82BFaNuxRl/5qRvxwWHSpVbUVADcKZ4Q86TFfCxKrtESJvR0mnPyo1Wvcb10B72Sf
 om54B/+N5s8aC/YlCJ5Iy8E+eQPqFIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-uykzQjHlNiu2lD-lNSLY4w-1; Mon, 07 Sep 2020 06:43:54 -0400
X-MC-Unique: uykzQjHlNiu2lD-lNSLY4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA64E1084CA6;
 Mon,  7 Sep 2020 10:43:52 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-108.pek2.redhat.com [10.72.12.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BEAA60C0F;
 Mon,  7 Sep 2020 10:43:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-vdpa: fix backend feature ioctls
Date: Mon,  7 Sep 2020 18:43:43 +0800
Message-Id: <20200907104343.31141-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Eli Cohen <elic@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 lulu@redhat.com
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
