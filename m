Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC311E5B6D
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740926063; cv=none; b=NDwoZfFOf+cO7J6NaBKlZEZ3vjmFWrfrgZQTbuxcOpic2FAkMiBBvNTKfv9nAlPPf7kXoD7zt2FNdzlBPv93zY2+ndUbXcMmXqKKEQHRJfKmSfof8fH7Xal9axWpq1lGtsfWIhT6SFAvdJ6FuK2XAgvrqIilgweQ97T46sZLi+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740926063; c=relaxed/simple;
	bh=rg0331/HCZNBz8afZ83IRC/xl06pHQpnFDX9W2DuPh4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRBKebSvUA3K7GiLAROn7SEc4wcNlmT4nn11BKNtROX2ys5E807ivGCr16M+X1GVPhVRgFyIdKRiFniXz6GsBvWp5w6CO/y8KRlHTwQSvOX2/+cSLYRRPFl9gvsT/X5fBocMoBaeNnfsngn5vt57wo75QzCyRKdpkF8DPfQODuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bu/Zablq; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bu/Zablq"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8043F60750
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id THVY3ZYz1LyZ for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Mar 2025 14:34:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9E41B60690
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E41B60690
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bu/Zablq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E41B60690
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740926059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOsU3m3SY4rtF1PFvdPMYDeuuXLw2NBc5ORrRS7hWak=;
	b=Bu/ZablqXxP06Pj9ZPr7MdqNkgAU4DofnYaRjJ9cyWH6DXYOO9DIyN79E/j296tURVARWB
	4vuPq2fach2sco0mxnlxYKzofdERm2bNCkmLBAPP2qL2wR/E5ltNvfmioClLovezM8MWgk
	/52PiXSO9JvGeLdojP6saDL9ImjS6TQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-ShIiBrarMR2i_YP-vGqbAw-1; Sun,
 02 Mar 2025 09:33:58 -0500
X-MC-Unique: ShIiBrarMR2i_YP-vGqbAw-1
X-Mimecast-MFC-AGG-ID: ShIiBrarMR2i_YP-vGqbAw_1740926037
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A9461954B1D;
	Sun,  2 Mar 2025 14:33:57 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.49])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BED6019560AB;
	Sun,  2 Mar 2025 14:33:52 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
Date: Sun,  2 Mar 2025 22:32:06 +0800
Message-ID: <20250302143259.1221569-5-lulu@redhat.com>
In-Reply-To: <20250302143259.1221569-1-lulu@redhat.com>
References: <20250302143259.1221569-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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

