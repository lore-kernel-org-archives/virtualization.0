Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E9283138
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Jun 2025 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749454500; cv=none; b=ZLzmIkEE8DO+TROomwP/FVhm47g0Epu1/vi9UTD7cYkTLRcyPlo+FjRVJpCEMS7+SCoG7sz4DoENwwIYgeqAcanV9shEgk5bwJBkczheKrvnqC/8BZAwINs9/uBQl9CDoTh4fKPSFfBgGFKUzHMjGZUBN+6S7z1BSeVmM8oRrXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749454500; c=relaxed/simple;
	bh=0vQ6N7iSJnD4P+9/KJRL22ef5jUU7oxYx6yBbjj9pHQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVS/U1rmAMSmzUwujbqh/T8MYJBAlVVXkRpWcsvbqSNbAMUmptKzorT68PckYdxUCzvEtzRHiOYr4YEmnvtesEe8dApx8HsaU5YqsEoFtypW2IfxfJsfts7RNUiNi5TbAl7nAnp4AtFcoN5V1N49KCSIxf7c58NhATrYb6ER9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W69T8KZw; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W69T8KZw"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7ACBB8175F
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Jun 2025 07:34:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PD1tJRCAM7aE for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jun 2025 07:34:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A929B815CC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A929B815CC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W69T8KZw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A929B815CC
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Jun 2025 07:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749454496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ha5cwWF1J5azN7tjHTmIZDXO2H/0tX5X1ldzABYBepU=;
	b=W69T8KZwf5kNfhFuJxr5RtaaKx1c7g7hkE/FFZ7ZQ1D9M7toTmitRMWYV45RnrDMso4bNj
	5M8/KrAd9p0/ZpKf39TAWWgdgCnVwd/FjKjMFeMvJ8hkGfP2/ORfxUsT3ONaLAk0QwV/tO
	v8Wc2JhwxQMlkCOst7dR713nHZKewQY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-Ez1jdxpFOfyoxJ1DxF1xyQ-1; Mon,
 09 Jun 2025 03:34:52 -0400
X-MC-Unique: Ez1jdxpFOfyoxJ1DxF1xyQ-1
X-Mimecast-MFC-AGG-ID: Ez1jdxpFOfyoxJ1DxF1xyQ_1749454491
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 039FB195608B;
	Mon,  9 Jun 2025 07:34:51 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2449419560AB;
	Mon,  9 Jun 2025 07:34:46 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v11 3/3] vhost: Add configuration controls for vhost worker's mode
Date: Mon,  9 Jun 2025 15:33:09 +0800
Message-ID: <20250609073430.442159-4-lulu@redhat.com>
In-Reply-To: <20250609073430.442159-1-lulu@redhat.com>
References: <20250609073430.442159-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This patch introduces functionality to control the vhost worker mode:

- Add two new IOCTLs:
  * VHOST_SET_FORK_FROM_OWNER: Allows userspace to select between
    task mode (fork_owner=1) and kthread mode (fork_owner=0)
  * VHOST_GET_FORK_FROM_OWNER: Retrieves the current thread mode
    setting

- Expose module parameter 'fork_from_owner_default' to allow system
  administrators to configure the default mode for vhost workers

- Add KConfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL to
  control the availability of these IOCTLs and parameter, allowing
  distributions to disable them if not needed

- The VHOST_NEW_WORKER functionality requires fork_owner to be set
  to true, with validation added to ensure proper configuration

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/Kconfig      | 17 +++++++++++++++
 drivers/vhost/vhost.c      | 44 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h | 25 ++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 020d4fbb947c..49e1d9dc92b7 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -96,3 +96,20 @@ config VHOST_CROSS_ENDIAN_LEGACY
 	  If unsure, say "N".
 
 endif
+
+config CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
+	bool "Enable CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL"
+	default n
+	help
+	  This option enables two IOCTLs: VHOST_SET_FORK_FROM_OWNER and
+	  VHOST_GET_FORK_FROM_OWNER. These allow userspace applications
+	  to modify the vhost worker mode for vhost devices.
+
+	  Also expose module parameter 'fork_from_owner_default' to allow users
+	  to configure the default mode for vhost workers.
+
+	  By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL` is set to `n`,
+	  which disables the IOCTLs and parameter.
+	  When enabled (y), users can change the worker thread mode as needed.
+
+	  If unsure, say "N".
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 37d3ed8be822..903d9c3f6784 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -43,6 +43,11 @@ module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
 static bool fork_from_owner_default = true;
+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
+module_param(fork_from_owner_default, bool, 0444);
+MODULE_PARM_DESC(fork_from_owner_default,
+		 "Set task mode as the default(default: Y)");
+#endif
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
@@ -1019,6 +1024,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 	switch (ioctl) {
 	/* dev worker ioctls */
 	case VHOST_NEW_WORKER:
+		/*
+		 * vhost_tasks will account for worker threads under the parent's
+		 * NPROC value but kthreads do not. To avoid userspace overflowing
+		 * the system with worker threads fork_owner must be true.
+		 */
+		if (!dev->fork_owner)
+			return -EFAULT;
 		ret = vhost_new_worker(dev, &state);
 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
 			ret = -EFAULT;
@@ -1136,6 +1148,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
 
 	vhost_dev_cleanup(dev);
 
+	dev->fork_owner = fork_from_owner_default;
 	dev->umem = umem;
 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
 	 * VQs aren't running.
@@ -2289,6 +2302,37 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		goto done;
 	}
 
+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
+	u8 fork_owner;
+
+	if (ioctl == VHOST_SET_FORK_FROM_OWNER) {
+		/*fork_owner can only be modified before owner is set*/
+		if (vhost_dev_has_owner(d)) {
+			r = -EBUSY;
+			goto done;
+		}
+		if (copy_from_user(&fork_owner, argp, sizeof(u8))) {
+			r = -EFAULT;
+			goto done;
+		}
+		if (fork_owner > 1) {
+			r = -EINVAL;
+			goto done;
+		}
+		d->fork_owner = (bool)fork_owner;
+		r = 0;
+		goto done;
+	}
+	if (ioctl == VHOST_GET_FORK_FROM_OWNER) {
+		fork_owner = d->fork_owner;
+		if (copy_to_user(argp, &fork_owner, sizeof(u8))) {
+			r = -EFAULT;
+			goto done;
+		}
+		r = 0;
+		goto done;
+	}
+#endif
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
 	if (r)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index d4b3e2ae1314..e51d6a347607 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,29 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/**
+ * VHOST_SET_FORK_FROM_OWNER - Set the fork_owner flag for the vhost device,
+ * This ioctl must called before VHOST_SET_OWNER.
+ * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
+ *
+ * @param fork_owner: An 8-bit value that determines the vhost thread mode
+ *
+ * When fork_owner is set to 1(default value):
+ *   - Vhost will create vhost worker as tasks forked from the owner,
+ *     inheriting all of the owner's attributes.
+ *
+ * When fork_owner is set to 0:
+ *   - Vhost will create vhost workers as kernel threads.
+ */
+#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
+
+/**
+ * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
+ * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
+ *
+ * @return: An 8-bit value indicating the current thread mode.
+ */
+#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
+
 #endif
-- 
2.45.0

