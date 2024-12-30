Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA891AAE13
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562752; cv=none; b=iSgYN76GiGJqNBRcEh9eyX3fBOMs4GqgJGzirtlCJk4dVLYHCuFCx7Gs1dOgQpjkI/DflOKl+SUZTO64IZgfh8QVNCtvML7E/Dg4bzVxjhQCawV4eMCIqS/dNRW7OPHR2ubNnY6XM2xv43GqEwL6LUNpklBVJRXMHwZ8IfvvVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562752; c=relaxed/simple;
	bh=OGzW+SnQ3xR3XeDgv9+sPtHgQMdqMojO7S8Pp2pmps0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWzj+6yXGuYOSjIgi/D5PIJngOHXMddOLe3i0nePMBTLtxOvOO+WzMUyGjncat9/G6uTNopQvUOJ9Sno+DiYAX3xN30ueJ61h8Vc5sFSaN0ohJN4Sf69wMBz+o2Clof+PvhK93o05mpSRGnKJAQlobNK/sxbqcxUzshtsu2iqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUfq9Xjj; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUfq9Xjj"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F609405ED
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pd8evETypSfw for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Dec 2024 12:45:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2D3EC405E7
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D3EC405E7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VUfq9Xjj
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2D3EC405E7
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOLNm7RgGjm+/oknkrmt1JKCoXNQL051GSrtvQZUvKg=;
	b=VUfq9Xjj+7PJhaJCpjvFZ1Uk+ULoxQv+pBlLOf6WA1paKdtrx7/ENvsopCV0N03oF8x0Nu
	4U0Je7gyp5C0ZRwkgpddAInVuyjUC6D2zp2fJye2pUes1z9QVpbmWThcsnSvSQniJfzRSn
	nnuFxFUuFFJA2hOQn5nwkLS89l5x654=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-Bsm6_zAdMOCXSGDiO3J0Jw-1; Mon,
 30 Dec 2024 07:45:45 -0500
X-MC-Unique: Bsm6_zAdMOCXSGDiO3J0Jw-1
X-Mimecast-MFC-AGG-ID: Bsm6_zAdMOCXSGDiO3J0Jw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7977519560B1;
	Mon, 30 Dec 2024 12:45:44 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 759C419560A2;
	Mon, 30 Dec 2024 12:45:40 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 5/6] vhost: Add new UAPI to support change to task mode
Date: Mon, 30 Dec 2024 20:43:52 +0800
Message-ID: <20241230124445.1850997-6-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-1-lulu@redhat.com>
References: <20241230124445.1850997-1-lulu@redhat.com>
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
 include/uapi/linux/vhost.h | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index ff17c42e2d1a..47c1329360ac 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2250,15 +2250,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
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
index b95dd84eef2d..f5fcf0b25736 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,23 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/**
+ * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vhost device
+ *
+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
+ *
+ * When inherit_owner is set to 1 (default behavior):
+ *   - The VHOST worker threads inherit their values/checks from
+ *     the thread that owns the VHOST device. The vhost threads will
+ *     be counted in the nproc rlimits.
+ *
+ * When inherit_owner is set to 0:
+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
+ *     implementation, which may be preferred by older userspace applications that
+ *     do not utilize the newer vhost_task concept.
+ */
+
+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
+
 #endif
-- 
2.45.0

