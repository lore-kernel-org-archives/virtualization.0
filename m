Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C871E9B3B
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740926066; cv=none; b=knitevvJpwRiNkxMF3/eUSdwapDr5Lo4ZhrZDUsI70HowNtDAnnJhz83OM276xlRT1fTAW6FQFBhls3dFSLGdOGi2QkIuP7JweOTtLhnNQpNLcqlcduAnwDTdZKHMwg8Nz0VRewZq1ctY3MPNHjW/Bni4cnTPQl/1+ZHuhIJXso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740926066; c=relaxed/simple;
	bh=gQlhwm/UPdHEl0lHZ6zSydcD82rexseS8D8eO4RMhFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGsmOnaUmxeu08ZjJObzxVbo9F/7LXRNRzs2fYiTiQmAx5g/lpWuyVCT1GwM/3dza7Emr1gIJpVYMisPwxR6eAxbAwuhW8C5mDp4c1izrAPlN6vzkOYgHBieI+CYeTe6A+jLhMuY1YxsOGAPbPcfKymZhcqTaFQEnlDZkpUAUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RA2qnqKz; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA2qnqKz"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE05260750
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:34:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BAnhb7eQpjka for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Mar 2025 14:34:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DE76560690
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE76560690
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RA2qnqKz
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DE76560690
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740926062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9IP3Rzux+HyTZ69cLNkjXI40jyB7zRAK3/LInKHI/I=;
	b=RA2qnqKzWunEB7t4MKbDJ685n11DBwCWz7k0SU8IChZfMFfnFBqQURa/u6ma1vX7plizzn
	RK+gpkqH1qjFAens3pmvlMKDZytmMu1b9bjr5O9GPxgDz9SO42KDWnrMHpswAxfECckRVz
	PvNeiOzFRqoJjUWU177m5kLurfpTAek=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-sjnB76YwPnuKazIwHqJraw-1; Sun,
 02 Mar 2025 09:34:09 -0500
X-MC-Unique: sjnB76YwPnuKazIwHqJraw-1
X-Mimecast-MFC-AGG-ID: sjnB76YwPnuKazIwHqJraw_1740926048
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 508AB1954B1F;
	Sun,  2 Mar 2025 14:34:08 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.49])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9747195395A;
	Sun,  2 Mar 2025 14:34:03 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 6/8] vhost: uapi to control task mode (owner vs kthread)
Date: Sun,  2 Mar 2025 22:32:08 +0800
Message-ID: <20250302143259.1221569-7-lulu@redhat.com>
In-Reply-To: <20250302143259.1221569-1-lulu@redhat.com>
References: <20250302143259.1221569-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add a new UAPI to configure the vhost device to use the kthread mode
The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
to choose between owner and kthread mode if necessary
This setting must be applied before VHOST_SET_OWNER, as the worker
will be created in the VHOST_SET_OWNER function

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c      | 22 ++++++++++++++++++++--
 include/uapi/linux/vhost.h | 15 +++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index be97028a8baf..ff930c2e5b78 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1134,7 +1134,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
 	int i;
 
 	vhost_dev_cleanup(dev);
-
+	dev->inherit_owner = true;
 	dev->umem = umem;
 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
 	 * VQs aren't running.
@@ -2287,7 +2287,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		r = vhost_dev_set_owner(d);
 		goto done;
 	}
-
+	if (ioctl == VHOST_FORK_FROM_OWNER) {
+		u8 inherit_owner;
+		/*inherit_owner can only be modified before owner is set*/
+		if (vhost_dev_has_owner(d)) {
+			r = -EBUSY;
+			goto done;
+		}
+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
+			r = -EFAULT;
+			goto done;
+		}
+		if (inherit_owner > 1) {
+			r = -EINVAL;
+			goto done;
+		}
+		d->inherit_owner = (bool)inherit_owner;
+		r = 0;
+		goto done;
+	}
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
 	if (r)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..547b4fa4c3bd 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,19 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/**
+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device
+ *
+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
+ *
+ * When inherit_owner is set to 1(default value):
+ *   - Vhost will create tasks similar to processes forked from the owner,
+ *     inheriting all of the owner's attributes..
+ *
+ * When inherit_owner is set to 0:
+ *   - Vhost will create tasks as kernel thread
+ */
+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
+
 #endif
-- 
2.45.0

