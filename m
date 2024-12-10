Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B316237A5A
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849171; cv=none; b=OQMenKJ5lZqdzDzRvgYOO9ksT495uhT4jO240F14m3fAQddTUueoReeaktFudG5dHyR6gcpfYd+ef8MrTXee5SDGLfgBxjTqF1Pwd3JIGJVQtPDAE3MVvbnaIpEHA1dvr88/N3M9nfFQYYURbJ6t3Sir80/eM5MqBXsW7bVEZlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849171; c=relaxed/simple;
	bh=r66ZyEa0FFdOQ+sN/Yqfp2P2ct7nMHGpyLZwU1tN0m4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGlMizCdpWUWqog44y55L0M0ELmV5fsivQY0vBxxjMShEF0PH0of4nEuYzSyPlj+DQ7oVrWXvHOGmF7v8lpMFykx1TC8UoljJWS+PaIdpBj6Hvlms8yiTpbnNqCx1HOFDmM8bPw4QX62GVc8R7+//wHnEvukYZWyt+DQMN3q+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVSuRtao; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVSuRtao"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8DE6640BE7
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OpOZc2mmVquD for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 16:46:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8928C40BD5
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8928C40BD5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PVSuRtao
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8928C40BD5
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hDByM3oDkEGXRZwzZgdODbwmAtbhUeP50SV3gbQSuU=;
	b=PVSuRtaopLGK04NaUBQGtXLMEMLZLndbLMX586m9gwJpSNr9Ht1DgXdM1LDLfLxuajFFbO
	M+nAcPnoKEnJzxYAySLMiU/+vHork9aO1o1jwp//nVbnQm4oqLdmnAUMobjZkRjpPM3YW+
	IexMZe8plYJRaftcuUADu7WhjtqiIpk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-oPXyqo6POAybqqfOxKidoQ-1; Tue,
 10 Dec 2024 11:46:04 -0500
X-MC-Unique: oPXyqo6POAybqqfOxKidoQ-1
X-Mimecast-MFC-AGG-ID: oPXyqo6POAybqqfOxKidoQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C1471956088;
	Tue, 10 Dec 2024 16:46:03 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBFBB19560A2;
	Tue, 10 Dec 2024 16:45:58 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
Date: Wed, 11 Dec 2024 00:41:46 +0800
Message-ID: <20241210164456.925060-8-lulu@redhat.com>
In-Reply-To: <20241210164456.925060-1-lulu@redhat.com>
References: <20241210164456.925060-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a new UAPI to enable setting the vhost device to task mode.
The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
to configure the mode if necessary.
This setting must be applied before VHOST_SET_OWNER, as the worker
will be created in the VHOST_SET_OWNER function

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
 include/uapi/linux/vhost.h | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3e9cb99da1b5..12c3bf3d1ed4 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2257,15 +2257,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 {
 	struct eventfd_ctx *ctx;
 	u64 p;
-	long r;
+	long r = 0;
 	int i, fd;
+	u8 inherit_owner;
 
 	/* If you are not the owner, you can become one */
 	if (ioctl == VHOST_SET_OWNER) {
 		r = vhost_dev_set_owner(d);
 		goto done;
 	}
+	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
+		/*inherit_owner can only be modified before owner is set*/
+		if (vhost_dev_has_owner(d)) {
+			r = -EBUSY;
+			goto done;
+		}
+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
+			r = -EFAULT;
+			goto done;
+		}
+		/* Validate the inherit_owner value, ensuring it is either 0 or 1 */
+		if (inherit_owner > 1) {
+			r = -EINVAL;
+			goto done;
+		}
+
+		d->inherit_owner = (bool)inherit_owner;
 
+		goto done;
+	}
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
 	if (r)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..d7564d62b76d 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,22 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/**
+ * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vhost device
+ *
+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
+ *
+ * When inherit_owner is set to 1:
+ *   - The VHOST worker threads inherit its values/checks from
+ *     the thread that owns the VHOST device, The vhost threads will
+ *     be counted in the nproc rlimits.
+ *
+ * When inherit_owner is set to 0:
+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
+ *     implementation, which may be preferred by older userspace applications that
+ *     do not utilize the newer vhost_task concept.
+ */
+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
+
 #endif
-- 
2.45.0

