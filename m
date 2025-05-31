Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C1239E84
	for <virtualization@lists.linux-foundation.org>; Sat, 31 May 2025 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748685120; cv=none; b=uTup4JLlbXcz8UYuMK8lgWBwc2eziaP6bvKxccmQ9cEW2PxcsBCluWYa0MrMlmVL7orc+dnWpw/vNo+gvkqIV0CZ86DRupaOv5rpvavJPbesIdNMlNgQ84TAulUy9Ynnt1zhVK4a8bvDD+7ZcBxwMTO7uqh4s8NsH+qQuc2Onbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748685120; c=relaxed/simple;
	bh=mw/Qer8CeHGw4edMlvresJ7xkZve9Gz7YMI12DPZe2E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEe5fkjwwxoQ+lzuKi6pFyU8HqeBKzbOAOuMaa5aPT8g5lQQENwBQ9NjvRxmGzMYBVIjZ6Uwixvv7XrSETd+ovs+Nu7NQucQIRBHluC7oncvYe6Y09OM+H9xyPFStnEkh5kcQ+DpAmIPzDlXGRUxkebTkVaW2LhMHK0Ec6HS8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUntj5Co; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUntj5Co"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DB1D40BC8
	for <virtualization@lists.linux-foundation.org>; Sat, 31 May 2025 09:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 543GK3KoeFtL for <virtualization@lists.linux-foundation.org>;
 Sat, 31 May 2025 09:51:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E926840BB5
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E926840BB5
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WUntj5Co
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E926840BB5
	for <virtualization@lists.linux-foundation.org>; Sat, 31 May 2025 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748685116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrPgdD64vKDtkpdzZC+la9VolCi4JsMi5slKhfemFX0=;
	b=WUntj5CoqiJIZ+nEUBqDrty7EeJzWpZhCnqG7FgJKdqMTYzvwRoDrMINRWYfxJTcr1j0FP
	5aRbJLuClhktWEKzY2T5pCrMOTSNEFbdr6CAfkxDWzlXvEK377Z6BZk0QwIKp7ehCg6tFB
	ZfDwqMbOvC+UvvajPVVFlKg9z2kzF+k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-QjWVvrC3MwKxOniWVVTuQg-1; Sat,
 31 May 2025 05:51:54 -0400
X-MC-Unique: QjWVvrC3MwKxOniWVVTuQg-1
X-Mimecast-MFC-AGG-ID: QjWVvrC3MwKxOniWVVTuQg_1748685113
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E34718004A7;
	Sat, 31 May 2025 09:51:53 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A9DF1800371;
	Sat, 31 May 2025 09:51:48 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v10 1/3] vhost: Add a new modparam to allow userspace select kthread
Date: Sat, 31 May 2025 17:47:03 +0800
Message-ID: <20250531095135.159582-2-lulu@redhat.com>
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

The vhost now uses vhost_task and workers as a child of the owner thread.
While this aligns with containerization principles, it confuses some
legacy userspace applications, therefore, we are reintroducing kthread
API support.

Add a new module parameter to allow userspace to select behavior
between using kthread and task.

By default, this parameter is set to true (task mode). This means the
default behavior remains unchanged by this patch.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c |  5 +++++
 drivers/vhost/vhost.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3a5ebb973dba..240ba78b1e3f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+bool inherit_owner_default = true;
+module_param(inherit_owner_default, bool, 0444);
+MODULE_PARM_DESC(inherit_owner_default,
+		 "Set task mode as the default(default: Y)");
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
@@ -552,6 +556,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
+	dev->inherit_owner = inherit_owner_default;
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..c1ff4a92b925 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -176,6 +176,16 @@ struct vhost_dev {
 	int byte_weight;
 	struct xarray worker_xa;
 	bool use_worker;
+	/*
+	 * If inherit_owner is true we use vhost_tasks to create
+	 * the worker so all settings/limits like cgroups, NPROC,
+	 * scheduler, etc are inherited from the owner. If false,
+	 * we use kthreads and only attach to the same cgroups
+	 * as the owner for compat with older kernels.
+	 * here we use true as default value.
+	 * The default value is set by modparam inherit_owner_default
+	 */
+	bool inherit_owner;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
 };
-- 
2.45.0

