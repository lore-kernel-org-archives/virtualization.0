Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF915ECE3
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059793; cv=none; b=FX20AO4mrnkMr74yIO1uDr7lCdJJ8JfKwCQdg455toTgk933vL2iPake5dBSf3Z0Ch7OvgOYxXqz7vC4MkfSBbA0xMFi5Gt7tZit7EB+kF8Lw/bnHgm/BEBJAHrBZELPBeKOOVqWa3sNHn/0kAfXW8GvxEWd1l0psVB6ggf9Mrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059793; c=relaxed/simple;
	bh=efxH1sSMf2klEJ3PKsOaBGUtqvILrO2zUnw6BNzKIls=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPPVRo3PpMaZfP10J5+wS0MxF9xN5hFHX8bYNh3eglZgM5Z6dFzu4799gJ5B1Te8VsXWQ34KqaQMoIq4ssT+zio8qizbpWwb5v4cDegeLwn1ewtqvEveAkXQso/ldp5JpRsA6XTFRqcmpfwOziPuxi6wEvKHJaETHRoIAn475yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6ZJCRyA; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6ZJCRyA"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9C3E80A88
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id toeHHStHQLVD for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Aug 2024 09:29:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D3A3F80A67
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3A3F80A67
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z6ZJCRyA
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D3A3F80A67
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724059789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oI5nhMa1kRbv7aaOFKvTmUft8jmCwPzAMkkkRLDVCLg=;
	b=Z6ZJCRyAsY+7cwiExWKA/N7O8s5VijV7DVZOrW4ugZTgCjYJAmy4H8jSuwCNO3shlcK34Z
	WUn6bhj6cFZwrtItXMGTxsdAWOldz3Akf8Nu7OY1PTD7Da1JBIS52v80mEN8EMi+SGfoNI
	KtTNJEyVbBmWsCQ+s4nY8k2tuzmAd94=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-GmO9l7eEPwuZiOAHHJ1JPQ-1; Mon,
 19 Aug 2024 05:29:48 -0400
X-MC-Unique: GmO9l7eEPwuZiOAHHJ1JPQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91BD21954B1A;
	Mon, 19 Aug 2024 09:29:47 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F2191956054;
	Mon, 19 Aug 2024 09:29:44 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RFC 6/7] vhost: Add kthread support in function vhost_worker_create
Date: Mon, 19 Aug 2024 17:27:32 +0800
Message-ID: <20240819092851.441670-7-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-1-lulu@redhat.com>
References: <20240819092851.441670-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Split the function vhost_worker_create to support both task and kthread
       
Added back the previous old function vhost_worker_create and rename it to
vhost_worker_create_khtread to support the khtread.

The new vhost_worker_queue will be selected which to use based on the
value of the parameter.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 55 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 66ccda81f073..0a7b2999100f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -807,7 +807,8 @@ static void vhost_workers_free(struct vhost_dev *dev)
 	else
 		vhost_workers_free_task(dev);
 }
-static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
+
+static struct vhost_worker *vhost_worker_create_task(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
@@ -848,6 +849,50 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	return NULL;
 }
 
+static struct vhost_worker *vhost_worker_create_kthread(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	struct task_struct *task;
+	int ret;
+	u32 id;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return NULL;
+
+	worker->dev = dev;
+	worker->kcov_handle = kcov_common_handle();
+
+	mutex_init(&worker->mutex);
+	init_llist_head(&worker->work_list);
+
+	task = kthread_create(vhost_run_work_kthread_list, worker, "vhost-%d",
+			      current->pid);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
+		goto free_worker;
+	}
+
+	worker->task = task;
+	wake_up_process(task); /* avoid contributing to loadavg */
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0)
+		goto stop_worker;
+	worker->id = id;
+
+	ret = vhost_attach_cgroups(dev);
+	if (ret)
+		goto stop_worker;
+
+	return worker;
+
+stop_worker:
+	kthread_stop(worker->task);
+free_worker:
+	kfree(worker);
+	return NULL;
+}
+
 /* Caller must have device mutex */
 static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 				     struct vhost_worker *worker)
@@ -936,6 +981,14 @@ static int vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 	return 0;
 }
 
+static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
+{
+	if (use_kthread)
+		return vhost_worker_create_kthread(dev);
+	else
+		return vhost_worker_create_task(dev);
+}
+
 /* Caller must have device mutex */
 static int vhost_new_worker(struct vhost_dev *dev,
 			    struct vhost_worker_state *info)
-- 
2.45.0

