Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963D23BF9C
	for <virtualization@lists.linux-foundation.org>; Sat, 31 May 2025 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748685512; cv=none; b=DviwpIwHhn2l1tGZUbqMSGYKcU3nlU0goLnkqBhE0Qc0D/HkclDxrAExOYxiwY7xwHGkkwVqUOiCnWPeR3sSRWdAHttKL0zAOfqOjmlgBlFqTifLI6WMdWSvgCZQZl6vArPyhNIV9rdHHD66AyPPselyUcRDR2fPs4LjH0OKikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748685512; c=relaxed/simple;
	bh=MH2G2hfDbvU36nbcXul/7o/guuWSQyBF7jNQJARY0eE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwtqHVny/JJ5OKsXIG8Di4iTJK2BK4ScM+O1Ze3oVKnTDlA+7zHXiivHgDZdnXLWPN666FkyywtqK51xFD7FJaIg10tkCfK1GJTL1/3HA0b5O72sOZiMMe/W0LjIHPW6GxrEEzOKAgQ7a8xp2GtMr7OROj+A1uiDabWBSR+PYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bw6PoCFw; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bw6PoCFw"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46B29606D6
	for <virtualization@lists.linux-foundation.org>; Sat, 31 May 2025 09:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iNbCFL_4pTYa for <virtualization@lists.linux-foundation.org>;
 Sat, 31 May 2025 09:58:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 85C6C60771
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85C6C60771
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bw6PoCFw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 85C6C60771
	for <virtualization@lists.linux-foundation.org>; Sat, 31 May 2025 09:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748685507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QVzfJTKlAfS/h4/7JwNwWZ1w2FS+9cWThTFrETjmZk=;
	b=bw6PoCFwbrqtEP06rQZJIYlkc3pkhO2sqePoJjN8icTHInU1CC7nifVEEB9tjoVaw9kqf+
	wNAFxk6T7Uz5bRVZDBF0ZFEB7utfUq3CUIeDi3sJfEa4H4PDKZNsPSoR9VCXjofKXoEluU
	+2JcNNTHgqeIjXgfogZWWeVE/uCg+ss=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-O6hR8a-POuaRKRIkNYS4ZQ-1; Sat,
 31 May 2025 05:58:25 -0400
X-MC-Unique: O6hR8a-POuaRKRIkNYS4ZQ-1
X-Mimecast-MFC-AGG-ID: O6hR8a-POuaRKRIkNYS4ZQ_1748685504
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 894621800446;
	Sat, 31 May 2025 09:58:24 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99DF3180049D;
	Sat, 31 May 2025 09:58:20 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH RESEND v10 3/3] vhost: Add new UAPI to select kthread mode and KConfig to enable this IOCTL
Date: Sat, 31 May 2025 17:57:28 +0800
Message-ID: <20250531095800.160043-4-lulu@redhat.com>
In-Reply-To: <20250531095800.160043-1-lulu@redhat.com>
References: <20250531095800.160043-1-lulu@redhat.com>
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
index 2d2909be1bb2..cfa60dc438f9 100644
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
+	dev->inherit_owner = inherit_owner_default;
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

