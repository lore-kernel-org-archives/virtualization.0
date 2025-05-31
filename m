Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914623BD04
	for <virtualization@lists.linux-foundation.org>; Sat, 31 May 2025 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748685132; cv=none; b=ikDOs48v4NOnaJpLcH+efipT8qKIKT8dDlEby7DQ6jZooyAYIbz56jVbgYs7RvA0rJSpKa7J8iS49PL3uGkA0SJfW62j9dczKu9lZXy0kV3L14Adp395/a8UuUXFNXVzoorGRjXcmNjsUD38fWTGC9jhQgBhkORMvK2E7P6l+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748685132; c=relaxed/simple;
	bh=tkHlihPALOeP3kvL2nF1g8VsHMqRk4StgVF01L5qPkY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brbszXSecN1pwcjOINr5FT0qfzNsUgB7hXqDZzF110/zBbryTLs2adLL/ZMwJiKuW+rbBBavuODKh6CL0rKwjYAmm/qQxFIMmRFmQ7Rg+/JPFYJAVs2ma3DJ0Ks0zl6EpqYnI1Bdw85+QPL18jeX4KAwBeXg4zDiI5x38zg1pjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLHmrI1V; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLHmrI1V"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6BE960093
	for <virtualization@lists.linux-foundation.org>; Sat, 31 May 2025 09:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UJmc1h-QM_8m for <virtualization@lists.linux-foundation.org>;
 Sat, 31 May 2025 09:52:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1B9A160771
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B9A160771
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WLHmrI1V
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B9A160771
	for <virtualization@lists.linux-foundation.org>; Sat, 31 May 2025 09:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748685128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXrAvthADTqvlMjxkG4TzthDrm10AjntmLRtuzulA0I=;
	b=WLHmrI1V4BtXZLZBXuLq+xqtyb4nASOQpL7le00yRXrhTi7ILYFBuFd5juTN//xWQLPin6
	HfuwGtvmqjKqEDY/EweEQI90w7ZJHG/0ddhhYiqa5JJcF2eDSpQi6dviaRcCdllgNkXgQQ
	BV3CfeSy2xuXYDlp95sgwGBUHOBxvFk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-krvCGQXNNWKTxc34OjevJg-1; Sat,
 31 May 2025 05:52:04 -0400
X-MC-Unique: krvCGQXNNWKTxc34OjevJg-1
X-Mimecast-MFC-AGG-ID: krvCGQXNNWKTxc34OjevJg_1748685123
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E5F81956089;
	Sat, 31 May 2025 09:52:03 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 590BF1800371;
	Sat, 31 May 2025 09:51:58 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v10 3/3] vhost: Add new UAPI to select kthread mode and KConfig to enable this IOCTL
Date: Sat, 31 May 2025 17:47:05 +0800
Message-ID: <20250531095135.159582-4-lulu@redhat.com>
In-Reply-To: <20250531095135.159582-1-lulu@redhat.com>
References: <20250531095135.159582-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This patch introduces a new UAPI that allows the vhost device to select
in kthread mode. Userspace applications can utilize IOCTL
VHOST_FORK_FROM_OWNER to select between task and kthread modes, which
must be invoked before IOCTL VHOST_SET_OWNER, as the worker will be
created during that call.

The VHOST_NEW_WORKER requires the inherit_owner setting to be true, and
a check has been added to ensure proper configuration.

Additionally, a new KConfig option, CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL,
is introduced to control the availability of the IOCTL
VHOST_FORK_FROM_OWNER. When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set
to n, the IOCTL is disabled, and any attempt to use it will result in a
failure.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/Kconfig      | 13 +++++++++++++
 drivers/vhost/vhost.c      | 30 +++++++++++++++++++++++++++++-
 include/uapi/linux/vhost.h | 16 ++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 020d4fbb947c..300e474b60fd 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -96,3 +96,16 @@ config VHOST_CROSS_ENDIAN_LEGACY
 	  If unsure, say "N".
 
 endif
+
+config VHOST_ENABLE_FORK_OWNER_IOCTL
+	bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
+	default n
+	help
+	  This option enables the IOCTL VHOST_FORK_FROM_OWNER, allowing
+	  userspace applications to modify the thread mode for vhost devices.
+
+	  By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
+	  which disables the IOCTL. When enabled (y), the IOCTL allows
+	  users to set the mode as needed.
+
+	  If unsure, say "N".
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2d2909be1bb2..673c2dc8607b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1022,6 +1022,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 	switch (ioctl) {
 	/* dev worker ioctls */
 	case VHOST_NEW_WORKER:
+		/*
+		 * vhost_tasks will account for worker threads under the parent's
+		 * NPROC value but kthreads do not. To avoid userspace overflowing
+		 * the system with worker threads inherit_owner must be true.
+		 */
+		if (!dev->inherit_owner)
+			return -EFAULT;
 		ret = vhost_new_worker(dev, &state);
 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
 			ret = -EFAULT;
@@ -1138,7 +1145,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
 	int i;
 
 	vhost_dev_cleanup(dev);
-
+	dev->inherit_owner = true;
 	dev->umem = umem;
 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
 	 * VQs aren't running.
@@ -2292,6 +2299,27 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		goto done;
 	}
 
+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
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
+#endif
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
 	if (r)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index d4b3e2ae1314..d2692c7ef450 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,20 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/**
+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device,
+ * This ioctl must called before VHOST_SET_OWNER.
+ *
+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
+ *
+ * When inherit_owner is set to 1(default value):
+ *   - Vhost will create tasks similar to processes forked from the owner,
+ *     inheriting all of the owner's attributes.
+ *
+ * When inherit_owner is set to 0:
+ *   - Vhost will create tasks as kernel thread.
+ */
+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
+
 #endif
-- 
2.45.0

