Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915CB2571A7
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745203520; cv=none; b=ktLp00qDkUvHOMtDMz0ajThdibNHfjWrsgicxEfEeuFYT1rkRe/8afyiX7iE08/RWhHObmJ+xcstFFQrM48Xk0AKnnqe4ByJPT+mZlVaBWcgHzYe74Czsyo+5HYRcW0bwoO8a2ktalTZXA+w6YGnI6EeGLwZ9lX6S4RqSPXZAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745203520; c=relaxed/simple;
	bh=sumMjmwZxo0qJvhw7S8ltFSvno0RZA0jV5PI4oksXXk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYZR6u1yAvrQ/1kXpXAyKT4woijERMVbb44V5nUgcDSpCKv2zIxwb9yPaq1YwSmHCqoPgyhX9iKuRn58UkrkeiPizWT6TPR3anhka7oKjH4nGUrUJFBrboX2u5BXYNXUdnk4mQ6EvV+lgN8lxoJwK/pd3vXO/nG6OyVN8vfzrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyqHelUo; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyqHelUo"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A78C608EF
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 02:45:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.39
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5GB2B9IvJkhu for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Apr 2025 02:45:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 60FC260A54
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60FC260A54
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZyqHelUo
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 60FC260A54
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 02:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745203515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NrTRtJXNWtpYPwMS+KZwGlCYM9RXuubPsDXsJSdgeYg=;
	b=ZyqHelUoRxuqZiH8Wdb8SBEM4AWSo+R4QMYumIWgBLzUhJZoTiSptD9Ct6FNY/6KX1axyf
	RE+TvGzNpv/bxDxJ6XfYISxGhf3lUOQ+b2MHrrMhC4glxCCmuXUYOimNEAPfbNZWBbz3by
	CFZ57nVei8G3gSgau16mplN1AV9nKz0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-9UGXHUVXNde3xXFfbvUM-Q-1; Sun,
 20 Apr 2025 22:45:11 -0400
X-MC-Unique: 9UGXHUVXNde3xXFfbvUM-Q-1
X-Mimecast-MFC-AGG-ID: 9UGXHUVXNde3xXFfbvUM-Q_1745203510
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 480301800570;
	Mon, 21 Apr 2025 02:45:10 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33922180175B;
	Mon, 21 Apr 2025 02:45:05 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v9 1/4] vhost: Add a new parameter in vhost_dev to allow user select kthread
Date: Mon, 21 Apr 2025 10:44:07 +0800
Message-ID: <20250421024457.112163-2-lulu@redhat.com>
In-Reply-To: <20250421024457.112163-1-lulu@redhat.com>
References: <20250421024457.112163-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The vhost now uses vhost_task and workers as a child of the owner thread.
While this aligns with containerization principles, it confuses some
legacy userspace applications, therefore, we are reintroducing kthread
API support.

Introduce a new parameter to enable users to choose between kthread and
task mode.

By default, this parameter is set to true, so the default behavior
remains unchanged by this patch.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 1 +
 drivers/vhost/vhost.h | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 63612faeab72..250dc43f1786 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -552,6 +552,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
+	dev->inherit_owner = true;
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..19bb94922a0e 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -176,6 +176,15 @@ struct vhost_dev {
 	int byte_weight;
 	struct xarray worker_xa;
 	bool use_worker;
+	/*
+	 * If inherit_owner is true we use vhost_tasks to create
+	 * the worker so all settings/limits like cgroups, NPROC,
+	 * scheduler, etc are inherited from the owner. If false,
+	 * we use kthreads and only attach to the same cgroups
+	 * as the owner for compat with older kernels.
+	 * here we use true as default value
+	 */
+	bool inherit_owner;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
 };
-- 
2.45.0

