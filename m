Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5B21ABCC
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156305; cv=none; b=JaxFL/R6Hjt1IfYa7wDJfq2A+tAxcWGvXrh3WBzuxJVr2neFCa4Iddjg0WBPm1Wr4+GVsLE+fqH5iuCBFrZ1l+aA5l9RaUthPHVxkjAjLu9ceQaB3neVX8E1jZ6EZa5IhduPblqfKxw7C73zjiNDSwoWgPAgm/0ZYx76jMtl9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156305; c=relaxed/simple;
	bh=FDMYH+VuvPX7L7xdXXrSDlUL9wJ9IlCFimDvXX9FoIU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDjh0Un2UmCMXMrz6syyPC+hP4Bm0YETmRHcgwWz+OZm1s9cC0lytAhf4dlg2spHCkegs7C/u64vTFNrNbp0Z3QSWj//TzgqbYcI5CrYbjAVeopmjZkZCCTG6nkT7HJRtZ4x4nzcMFPfVriBjDActABPO7IdsIAxSGZvFHO4414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBsd3rNq; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBsd3rNq"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 134614F0BA
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:05:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z5oza5gIKncj for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Mar 2025 10:05:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 547554EFF3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 547554EFF3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iBsd3rNq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 547554EFF3
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743156302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHLTuC4KWZdovhJ3UQM5fvJjtH+elhHPHMwqnZsGpc4=;
	b=iBsd3rNqe8bafjDUqzR813uuwDiR4C86FWMDS8jOdqA8fyDT50U5R/keidqJIwK1YDyrpf
	09OYwE0O+197Xt3PcwQMCPkEd/0dw2d1RXyXeRaTes3BKT3i/SdLYJF+dep1TgVtowvHb/
	HDwT8ss2GUkUNThqiowr8lF+Q1WIIdc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-_0ImqpH-P8SrawbeHsTSqA-1; Fri,
 28 Mar 2025 06:05:00 -0400
X-MC-Unique: _0ImqpH-P8SrawbeHsTSqA-1
X-Mimecast-MFC-AGG-ID: _0ImqpH-P8SrawbeHsTSqA_1743156298
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C59011801A1A;
	Fri, 28 Mar 2025 10:04:58 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C68419541A5;
	Fri, 28 Mar 2025 10:04:53 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 5/8] vhost: Reintroduce kthread mode support in vhost
Date: Fri, 28 Mar 2025 18:02:49 +0800
Message-ID: <20250328100359.1306072-6-lulu@redhat.com>
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

This commit restores the previously removed functions kthread
wake/stop/create, and use ops structure vhost_worker_ops to
manage worker wakeup, stop and creation. The function
vhost_worker_create initializes these ops pointers based on
the value of inherit_owner

The old function was remove in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c162ad772f8f..be97028a8baf 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -734,11 +734,21 @@ static void vhost_task_wakeup(struct vhost_worker *worker)
 	return vhost_task_wake(worker->vtsk);
 }
 
+static void vhost_kthread_wakeup(struct vhost_worker *worker)
+{
+	wake_up_process(worker->kthread_task);
+}
+
 static void vhost_task_do_stop(struct vhost_worker *worker)
 {
 	return vhost_task_stop(worker->vtsk);
 }
 
+static void vhost_kthread_do_stop(struct vhost_worker *worker)
+{
+	kthread_stop(worker->kthread_task);
+}
+
 static int vhost_task_worker_create(struct vhost_worker *worker,
 				    struct vhost_dev *dev, const char *name)
 {
@@ -762,6 +772,41 @@ static int vhost_task_worker_create(struct vhost_worker *worker,
 	return 0;
 }
 
+static int vhost_kthread_worker_create(struct vhost_worker *worker,
+				       struct vhost_dev *dev, const char *name)
+{
+	struct task_struct *task;
+	u32 id;
+	int ret;
+
+	task = kthread_create(vhost_run_work_kthread_list, worker, "%s", name);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	worker->kthread_task = task;
+	wake_up_process(task);
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0)
+		goto stop_worker;
+
+	ret = vhost_attach_task_to_cgroups(worker);
+	if (ret)
+		goto stop_worker;
+
+	worker->id = id;
+	return 0;
+
+stop_worker:
+	vhost_kthread_do_stop(worker);
+	return ret;
+}
+
+static const struct vhost_worker_ops kthread_ops = {
+	.create = vhost_kthread_worker_create,
+	.stop = vhost_kthread_do_stop,
+	.wakeup = vhost_kthread_wakeup,
+};
+
 static const struct vhost_worker_ops vhost_task_ops = {
 	.create = vhost_task_worker_create,
 	.stop = vhost_task_do_stop,
@@ -773,7 +818,8 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	struct vhost_worker *worker;
 	char name[TASK_COMM_LEN];
 	int ret;
-	const struct vhost_worker_ops *ops = &vhost_task_ops;
+	const struct vhost_worker_ops *ops =
+		dev->inherit_owner ? &vhost_task_ops : &kthread_ops;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 98895e299efa..af4b2f7d3b91 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -37,6 +37,7 @@ struct vhost_worker_ops {
 };
 
 struct vhost_worker {
+	struct task_struct *kthread_task;
 	struct vhost_task	*vtsk;
 	struct vhost_dev	*dev;
 	/* Used to serialize device wide flushing with worker swapping. */
-- 
2.45.0

