Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8201C683
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845807; cv=none; b=O5Qn7t6KT6GKWutK9spGRehgrfk9S5lpOf6dvCrEjMNrWn8JFNQjpCK/6qZ79PbTnUG5hiyP13LWKeAVk/3r06bEcQaZcrDRlXXVG/iZ1xKktwmAAUP2/UgL4PCwPG6xOsLKMnSXCgTtcHaa0TmGT7Aht1FSEwLxyxoHAUBv6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845807; c=relaxed/simple;
	bh=q60zYy1/Faf6jVVm6utx8YjJpmwhDSnklipNz1Xc/VQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bv+H5/R5W4wT2ckr5BrFqwC8k0oW4mWCNajYuUVp8WsN3pXQn37kTeIMPNgtSLh/Kq+XPiti3HK3mPdlpBNZZINObhsRv/RABUAgAmEi/iKfRAlvll3Wugmyn9hH3W5rPeDF9TZV0HyusH/86INPy7tNAxI0RF9G2ytQjdJTkBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtYFbFE0; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtYFbFE0"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A142400D3
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 01:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SbLopRvIIh_C for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Sep 2024 01:36:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7DF74400BA
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DF74400BA
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OtYFbFE0
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7DF74400BA
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 01:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725845803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kaz4nYOPB8CgQNt7ZV4Ttw3NVtlnR/6nzex43AvYrI=;
	b=OtYFbFE0ksS2gWHwWWhXMjOe9wGtaKJWrAfM31U0ipS9uWvK1Tlb5yVrrRK5CEY4N/nbt/
	nDGYg5wxWxmZxErQGoWNT3eHm6fEWAUexgkQ6aIOOhmOObz4vupdsbKAKvBFoRe6zRP8GB
	6YndrDECurrfyOOVREKGIiS2z3ZAByk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-1JVi5RVQNTOLgcDQ6raXIA-1; Sun,
 08 Sep 2024 21:36:40 -0400
X-MC-Unique: 1JVi5RVQNTOLgcDQ6raXIA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C8BE1953963;
	Mon,  9 Sep 2024 01:36:39 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F085619560AF;
	Mon,  9 Sep 2024 01:36:34 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v1 6/7] vhost: Add kthread support in function vhost_worker_create
Date: Mon,  9 Sep 2024 09:33:45 +0800
Message-ID: <20240909013531.1243525-7-lulu@redhat.com>
In-Reply-To: <20240909013531.1243525-1-lulu@redhat.com>
References: <20240909013531.1243525-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Split the function vhost_worker_create to support both task and kthread
       
Added back the previous old function vhost_worker_create and rename it to
vhost_worker_create_khtread to support the khtread.

The new vhost_worker_create will be selected which to use based on the
value of the parameter.

the old function vhost_worker_create was change to support task in
commit 6e890c5d5021 ('vhost: use vhost_tasks for worker threads')
also changed in
commit 1cdaafa1b8b ('vhost: replace single worker pointer with xarray')
commit c011bb669dd ('vhost: dynamically allocate vhost_worker')

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 55 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f05545b125f0..bf1e971cb06f 100644
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

