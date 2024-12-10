Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC7232794
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849128; cv=none; b=ll8MyzQ2kb6Wx4xFZR9kXbnXQCt+tQVUVZcvbPknlfwazHY578h34XHC6Ne0rtOhlm10TylW0FzHZ1l6MEXBxE4VSCVf0lKMXzoGpsv0rcIJgZzcgVDv1pEgKz51tKzX7WwzTqaaxozCXU5IdgCi+6a8rfvbht1Yv160e7PffQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849128; c=relaxed/simple;
	bh=GjvNhNT1bUNL+PcVlyRcZE2ZFweHaD8JxyEhlL1m1vQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4uXmwwjpkZqLl0AbhMH1gr3dW7IYCg+XgYouir9mwThCY5+H+etXP+QJCv4PG8oXI9JGWfmnFYibgpzjBPGSn+LI2zEEf9KZjqklL/d2iRYEJ3hJ5lPTwHCPMb2j8ipFg+LFE05PmTphYYC7p+VNxwfB817lExDlt7uCaZzmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcYD5Xq0; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcYD5Xq0"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9C38817B5
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:45:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKyyLugHq0Ph for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 16:45:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 24887817B1
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24887817B1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WcYD5Xq0
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24887817B1
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rnSWUCg8d3NWTwjzGX7Xro4EhX1KK6nrpYNhJ5J6bk=;
	b=WcYD5Xq0XrLBIBLV5b6e8iixue2ghCJj+kQA/DLPH4APKmf/xPdqt1kivrk1y4OJAKTIJC
	Qnv0kJFMwRMtTY5bxZt/p8a8i+8yY0dvpZ1vDuPNyouQ/hMR4Jg+qyCLt6rWxsWZ2KNPZd
	Q0F7TGN5TOvVec33/0lL48sVcwqS9PM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-8-My8JCHN9aTDXDrybeBcA-1; Tue,
 10 Dec 2024 11:45:21 -0500
X-MC-Unique: 8-My8JCHN9aTDXDrybeBcA-1
X-Mimecast-MFC-AGG-ID: 8-My8JCHN9aTDXDrybeBcA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 425BB1954AF2;
	Tue, 10 Dec 2024 16:45:20 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B003919560A7;
	Tue, 10 Dec 2024 16:45:15 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 3/8] vhost: Add the cgroup related function
Date: Wed, 11 Dec 2024 00:41:42 +0800
Message-ID: <20241210164456.925060-4-lulu@redhat.com>
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

Add back the previously removed cgroup function to support the kthread
The biggest change for this part is in vhost_attach_cgroups() and
vhost_attach_task_to_cgroups().

The old function was remove in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1feba29abf95..812dfd218bc2 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
+#include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
@@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
 
+struct vhost_attach_cgroups_struct {
+	struct vhost_work work;
+	struct task_struct *owner;
+	int ret;
+};
+
+static void vhost_attach_cgroups_work(struct vhost_work *work)
+{
+	struct vhost_attach_cgroups_struct *s;
+
+	s = container_of(work, struct vhost_attach_cgroups_struct, work);
+	s->ret = cgroup_attach_task_all(s->owner, current);
+}
+
+static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
+{
+	struct vhost_flush_struct flush;
+	struct vhost_attach_cgroups_struct attach;
+
+	attach.owner = current;
+
+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
+	vhost_worker_queue(worker, &attach.work);
+
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
+	vhost_worker_queue(worker, &flush.work);
+	wait_for_completion(&flush.wait_event);
+
+	return attach.ret;
+}
+
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
-- 
2.45.0

