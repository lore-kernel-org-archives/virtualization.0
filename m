Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FCF1AA7AE
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562748; cv=none; b=Ja8L3dIeTFJvYpsvcNwySYWPEGNut+rfOxVx2gdmZ8Ay+ZXmYoUaej1yk5slEf86fSlYy/goyn+l5Mu9LyDdxKVyCr85MgZoC2WMvhQDPjkAENAzvFZ8fP3/xhwx4hjEpL05nWd+Q5WSbU0sHKiPKKfFrptp/6Np3kmZg+rEVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562748; c=relaxed/simple;
	bh=merdHWDONAbu6sbJILjbIpHE9fjKrx85ebbEc61iUxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liPAgEMLcWsi7GeW5T8+nm8/PGXNYBiTrTC9nWKuaGQsw4+iFsvN6GeSI+TSGin+rddJ9oYY2va2klMU7EwYjnQkNyOmRjYVMqtlK6fScg+04Uax1SPY7nXZGPblyo9KMigTk657JmMv0uz4UpkhBHzk7/gni3HGapENyHG7thw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxtNPnbE; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxtNPnbE"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3006D805A3
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FdiLulFtpc4a for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Dec 2024 12:45:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 467D08059C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 467D08059C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TxtNPnbE
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 467D08059C
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWfiK+MXrYcFg+E5mVFexunT6ykM6I0gV5eHLwqgzag=;
	b=TxtNPnbEWq9DO9Y5ZJqgaixY37ZhqGx3lLUVR2HWZPH5qW20ixjGHkjniMxelOKFlMiFfv
	Zk3A7HLab5NYAgddAHSLQbE5ElbDVdbr63BBrqaz4PG+XGf8H1bN4plurhc0P2fC6eAU0R
	erCjWCdp9Z7W9YR3T52xUP9qu2i69yk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-aelkPqn7MMOTV9yEka2DzQ-1; Mon,
 30 Dec 2024 07:45:40 -0500
X-MC-Unique: aelkPqn7MMOTV9yEka2DzQ-1
X-Mimecast-MFC-AGG-ID: aelkPqn7MMOTV9yEka2DzQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B243019560AB;
	Mon, 30 Dec 2024 12:45:39 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F67619560A2;
	Mon, 30 Dec 2024 12:45:35 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 4/6] vhost: Add worker related functions to support kthread
Date: Mon, 30 Dec 2024 20:43:51 +0800
Message-ID: <20241230124445.1850997-5-lulu@redhat.com>
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

Restore the previously removed functions kthread_wakeup and
kthread_stop, and add two new function pointers to wake up and stop
the workers. The function vhost_worker_create will initialize these
pointers based on the value of inherit_owner.

The functions vhost_worker_queue() and vhost_worker_destroy() will
use the function pointer in vhost_worker, which is initialized
according to the inherit_owner value.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 84 ++++++++++++++++++++++++++++++++++---------
 drivers/vhost/vhost.h |  3 ++
 2 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 812dfd218bc2..ff17c42e2d1a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &worker->work_list);
-		vhost_task_wake(worker->vtsk);
+		worker->worker_wakeup(worker);
 	}
 }
 
@@ -698,7 +698,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 
 	WARN_ON(!llist_empty(&worker->work_list));
 	xa_erase(&dev->worker_xa, worker->id);
-	vhost_task_stop(worker->vtsk);
+	worker->worker_stop(worker);
 	kfree(worker);
 }
 
@@ -721,14 +721,36 @@ static void vhost_workers_free(struct vhost_dev *dev)
 	xa_destroy(&dev->worker_xa);
 }
 
+static void vhost_task_wakeup_fn(struct vhost_worker *worker)
+{
+	return vhost_task_wake(worker->vtsk);
+}
+
+static void vhost_kthread_wakeup_fn(struct vhost_worker *worker)
+{
+	wake_up_process(worker->kthread_task);
+}
+
+static void vhost_task_stop_fn(struct vhost_worker *worker)
+{
+	return vhost_task_stop(worker->vtsk);
+}
+
+static void vhost_kthread_stop_fn(struct vhost_worker *worker)
+{
+	kthread_stop(worker->kthread_task);
+}
+
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
-	struct vhost_task *vtsk;
+	struct vhost_task *vtsk = NULL;
+	struct task_struct *task = NULL;
 	char name[TASK_COMM_LEN];
 	int ret;
 	u32 id;
 
+	/* Allocate resources for the worker */
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
 		return NULL;
@@ -736,27 +758,57 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	worker->dev = dev;
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
-	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
-				 worker, name);
-	if (!vtsk)
-		goto free_worker;
-
 	mutex_init(&worker->mutex);
 	init_llist_head(&worker->work_list);
 	worker->kcov_handle = kcov_common_handle();
-	worker->vtsk = vtsk;
+    /*
+     * If inherit_owner is true we use vhost_tasks to create
+     * the worker so all settings/limits like cgroups, NPROC,
+     * scheduler, etc are inherited from the owner.
+     * If false,we use kthreads and only attach to the same
+     * cgroups as the owner for compat with older kernels.
+     */
+	if (dev->inherit_owner) {
+		vtsk = vhost_task_create(vhost_run_work_list,
+					 vhost_worker_killed, worker, name);
+		if (!vtsk)
+			goto free_worker;
+
+		worker->vtsk = vtsk;
+		worker->worker_wakeup = vhost_task_wakeup_fn;
+		worker->worker_stop = vhost_task_stop_fn;
+
+		vhost_task_start(vtsk);
+		ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b,
+			       GFP_KERNEL);
+		if (ret < 0)
+			goto stop_worker;
+	} else {
+		task = kthread_create(vhost_run_work_kthread_list, worker,
+				      "vhost-%d", current->pid);
+		if (IS_ERR(task)) {
+			ret = PTR_ERR(task);
+			goto free_worker;
+		}
+		worker->kthread_task = task;
+		worker->worker_wakeup = vhost_kthread_wakeup_fn;
+		worker->worker_stop = vhost_kthread_stop_fn;
 
-	vhost_task_start(vtsk);
+		wake_up_process(task);
+		ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b,
+			       GFP_KERNEL);
+		if (ret < 0)
+			goto stop_worker;
 
-	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
-	if (ret < 0)
-		goto stop_worker;
-	worker->id = id;
+		ret = vhost_attach_task_to_cgroups(worker);
+		if (ret)
+			goto stop_worker;
+	}
 
+	worker->id = id;
 	return worker;
-
 stop_worker:
-	vhost_task_stop(vtsk);
+	worker->worker_stop(worker);
 free_worker:
 	kfree(worker);
 	return NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index c650c4506c70..63b1da08a2b0 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -27,6 +27,7 @@ struct vhost_work {
 };
 
 struct vhost_worker {
+	struct task_struct *kthread_task;
 	struct vhost_task	*vtsk;
 	struct vhost_dev	*dev;
 	/* Used to serialize device wide flushing with worker swapping. */
@@ -36,6 +37,8 @@ struct vhost_worker {
 	u32			id;
 	int			attachment_cnt;
 	bool			killed;
+	void (*worker_wakeup)(struct vhost_worker *worker);
+	void (*worker_stop)(struct vhost_worker *worker);
 };
 
 /* Poll a file (eventfd or socket) */
-- 
2.45.0

