Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F120CCCD
	for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325275; cv=none; b=gsk5p2eDeK3WjYs2fLKvtfy4I4YU77xhG5VShcoo8KL/VucBEwl8ZVcM6uKDTjhsY4zG7F0yeg0czhThWLT3A2h78PtjNPtHMEeT+nL9CwRPVelJqmVySnFOBgeUPTop2gFKBzv1eb826zXaEb8F75Z4Za2BLxr6FSGq1bUVmvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325275; c=relaxed/simple;
	bh=mSf1YOOT4rT+xoFBikEdZRvyB8BOLcKa4G4tDStOsjY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlLS/hJNnWm34anihKWqf+PxhnSWEK3BMzJUVceWuRvm6qpUi+qrKlWJAerVKShJ3LSUFIqQm7RhiZZPolklQjG2hFUlfZX+3D+w2J6Oy/WXvh/11DP/y/bWvpNKRFAUtXmgyDnzZVAKMWu4dcGGwBjZEC5UQzTl6CfuMlxm1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFrPbp/8; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFrPbp/8"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82AAE605EB
	for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 15:41:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CQdeUoZ4lpV2 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Feb 2025 15:41:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AF270605F7
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF270605F7
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CFrPbp/8
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AF270605F7
	for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740325271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4frTMdgbHHhGI0JKe/2KXP6ad1stTd1tmXcRu+Jrt+g=;
	b=CFrPbp/8b3zf8USmVT99pDsZ8yaP9KuuuKjePyHUJrBi1GJg+C6iM/O46WRiqAjlEgcysO
	VuBsVMxzezIxQWkHilOkjD8HU8+L6n4nj/MJ40sxOc90QjdvMmrgJF6D9Ll177pLtoldLD
	Jl+2unQlEmBDdL/npTwF32Dzj0PENp0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-9mArNKYWPXWjRLorh-iofg-1; Sun,
 23 Feb 2025 10:41:07 -0500
X-MC-Unique: 9mArNKYWPXWjRLorh-iofg-1
X-Mimecast-MFC-AGG-ID: 9mArNKYWPXWjRLorh-iofg_1740325266
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7B7E18004A7;
	Sun, 23 Feb 2025 15:41:06 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4489619412A3;
	Sun, 23 Feb 2025 15:41:01 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 3/6] vhost: Add the cgroup related function
Date: Sun, 23 Feb 2025 23:36:18 +0800
Message-ID: <20250223154042.556001-4-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-1-lulu@redhat.com>
References: <20250223154042.556001-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add back the previously removed cgroup function to support the kthread
The biggest change for this part is in vhost_attach_cgroups() and
vhost_attach_task_to_cgroups().

Reuse the function __vhost_worker_flush, but in this situation, the
attachment_cnt is 0. Therefore, add a boolean to disable this check.

The old function was remove in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1feba29abf95..adbb957c8b5f 100644
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
@@ -269,11 +270,12 @@ EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
  *
  * The worker's flush_mutex must be held.
  */
-static void __vhost_worker_flush(struct vhost_worker *worker)
+static void __vhost_worker_flush(struct vhost_worker *worker,
+				 bool ignore_attachment)
 {
 	struct vhost_flush_struct flush;
 
-	if (!worker->attachment_cnt || worker->killed)
+	if ((!ignore_attachment && !worker->attachment_cnt) || worker->killed)
 		return;
 
 	init_completion(&flush.wait_event);
@@ -292,7 +294,7 @@ static void __vhost_worker_flush(struct vhost_worker *worker)
 static void vhost_worker_flush(struct vhost_worker *worker)
 {
 	mutex_lock(&worker->mutex);
-	__vhost_worker_flush(worker);
+	__vhost_worker_flush(worker, false);
 	mutex_unlock(&worker->mutex);
 }
 
@@ -620,6 +622,36 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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
+	struct vhost_attach_cgroups_struct attach;
+
+	attach.owner = current;
+
+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
+	vhost_worker_queue(worker, &attach.work);
+
+	mutex_lock(&worker->mutex);
+	__vhost_worker_flush(worker, true);
+	mutex_unlock(&worker->mutex);
+
+	return attach.ret;
+}
+
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
@@ -793,7 +825,7 @@ static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 	/* Make sure new vq queue/flush/poll calls see the new worker */
 	synchronize_rcu();
 	/* Make sure whatever was queued gets run */
-	__vhost_worker_flush(old_worker);
+	__vhost_worker_flush(old_worker, false);
 	old_worker->attachment_cnt--;
 	mutex_unlock(&old_worker->mutex);
 }
@@ -852,7 +884,7 @@ static int vhost_free_worker(struct vhost_dev *dev,
 	 * to zero. Make sure flushes are flushed from the queue before
 	 * freeing.
 	 */
-	__vhost_worker_flush(worker);
+	__vhost_worker_flush(worker, false);
 	mutex_unlock(&worker->mutex);
 
 	vhost_worker_destroy(dev, worker);
-- 
2.45.0

