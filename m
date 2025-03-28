Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57092914
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156299; cv=none; b=f6sQlRcS0K0M40AfVNOalbL+Ce3G+JFsTwRUKSk+yTuDC+06M1rM4XFlQcxV499mjkIMggCYvdIwSZBxnO4G8mbRwsiRx8Xk8Y3bRyK+7HLTmXVUzczGZFXrwt+WA6E7Jp16pqAtzIxE2SKB3xVo2ihdkPXG9UCHm9+5IQB4+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156299; c=relaxed/simple;
	bh=rg0331/HCZNBz8afZ83IRC/xl06pHQpnFDX9W2DuPh4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5jL2nIzmU7glJ5pDioZ54eX+OqeD7BuZFnfPtPJF4vWQbhNv712fb0oNZiqoXf7YIeFD1y+xVmJSJ9VykrTezpqW9qaun1vP4eZ9L+DJvt92r0kAdEEPoWL97TA5yEQF1gaVfvRxmPow/dx2zQfAfj4/pocPdp0IFxqHH3h3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhTN6ehc; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhTN6ehc"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FDF740B0A
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:04:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SodJn3rMs6lD for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Mar 2025 10:04:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C906B40426
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C906B40426
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UhTN6ehc
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C906B40426
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743156295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOsU3m3SY4rtF1PFvdPMYDeuuXLw2NBc5ORrRS7hWak=;
	b=UhTN6ehcDHnktWKfkAucbhp86Jcb9Gj23o+/yz0BhW/Iyml5BvHpnNGoTrKgmV6etOeND/
	Mjn0z/i6oMQ1b7le40f/5MEvMGoNG1mHOFt+BlATEr7f7/IJ7Y2eAXR+b0WD/xuf+Hyyzv
	W8BDuC4U3bA6Y+9hm6vNdVzNZSIaHpw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-V8LuV9uAMcGaTf_wpigGpQ-1; Fri,
 28 Mar 2025 06:04:54 -0400
X-MC-Unique: V8LuV9uAMcGaTf_wpigGpQ-1
X-Mimecast-MFC-AGG-ID: V8LuV9uAMcGaTf_wpigGpQ_1743156293
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F074180AF57;
	Fri, 28 Mar 2025 10:04:53 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE8AE19541A5;
	Fri, 28 Mar 2025 10:04:48 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
Date: Fri, 28 Mar 2025 18:02:48 +0800
Message-ID: <20250328100359.1306072-5-lulu@redhat.com>
In-Reply-To: <20250328100359.1306072-1-lulu@redhat.com>
References: <20250328100359.1306072-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Abstract vhost worker operations (create/stop/wakeup) into an ops
structure to prepare for kthread mode support.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 63 ++++++++++++++++++++++++++++++-------------
 drivers/vhost/vhost.h | 11 ++++++++
 2 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 20571bd6f7bd..c162ad772f8f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &worker->work_list);
-		vhost_task_wake(worker->vtsk);
+		worker->ops->wakeup(worker);
 	}
 }
 
@@ -706,7 +706,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 
 	WARN_ON(!llist_empty(&worker->work_list));
 	xa_erase(&dev->worker_xa, worker->id);
-	vhost_task_stop(worker->vtsk);
+	worker->ops->stop(worker);
 	kfree(worker);
 }
 
@@ -729,42 +729,69 @@ static void vhost_workers_free(struct vhost_dev *dev)
 	xa_destroy(&dev->worker_xa);
 }
 
+static void vhost_task_wakeup(struct vhost_worker *worker)
+{
+	return vhost_task_wake(worker->vtsk);
+}
+
+static void vhost_task_do_stop(struct vhost_worker *worker)
+{
+	return vhost_task_stop(worker->vtsk);
+}
+
+static int vhost_task_worker_create(struct vhost_worker *worker,
+				    struct vhost_dev *dev, const char *name)
+{
+	struct vhost_task *vtsk;
+	u32 id;
+	int ret;
+
+	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
+				 worker, name);
+	if (IS_ERR(vtsk))
+		return PTR_ERR(vtsk);
+
+	worker->vtsk = vtsk;
+	vhost_task_start(vtsk);
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0) {
+		vhost_task_do_stop(worker);
+		return ret;
+	}
+	worker->id = id;
+	return 0;
+}
+
+static const struct vhost_worker_ops vhost_task_ops = {
+	.create = vhost_task_worker_create,
+	.stop = vhost_task_do_stop,
+	.wakeup = vhost_task_wakeup,
+};
+
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
-	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
 	int ret;
-	u32 id;
+	const struct vhost_worker_ops *ops = &vhost_task_ops;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
 		return NULL;
 
 	worker->dev = dev;
+	worker->ops = ops;
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
-	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
-				 worker, name);
-	if (IS_ERR(vtsk))
-		goto free_worker;
-
 	mutex_init(&worker->mutex);
 	init_llist_head(&worker->work_list);
 	worker->kcov_handle = kcov_common_handle();
-	worker->vtsk = vtsk;
-
-	vhost_task_start(vtsk);
-
-	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	ret = ops->create(worker, dev, name);
 	if (ret < 0)
-		goto stop_worker;
-	worker->id = id;
+		goto free_worker;
 
 	return worker;
 
-stop_worker:
-	vhost_task_stop(vtsk);
 free_worker:
 	kfree(worker);
 	return NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 19bb94922a0e..98895e299efa 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -26,6 +26,16 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+struct vhost_worker;
+struct vhost_dev;
+
+struct vhost_worker_ops {
+	int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
+		      const char *name);
+	void (*stop)(struct vhost_worker *worker);
+	void (*wakeup)(struct vhost_worker *worker);
+};
+
 struct vhost_worker {
 	struct vhost_task	*vtsk;
 	struct vhost_dev	*dev;
@@ -36,6 +46,7 @@ struct vhost_worker {
 	u32			id;
 	int			attachment_cnt;
 	bool			killed;
+	const struct vhost_worker_ops *ops;
 };
 
 /* Poll a file (eventfd or socket) */
-- 
2.45.0

