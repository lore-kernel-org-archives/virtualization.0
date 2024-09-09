Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C511C68F
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847329; cv=none; b=h+/VcihVt1hiB77yVgzQLfc1X5e/x/FdtHZ840MyH100WOHSDOqnuFUZEfn71CJ369Jt54oA+pWkOydgQr5ULeuOoVs8uGhutD3dILJY+f9KwL1ftT3RsVI6/T9ICqM6w0a0qxIAiGbggpI15gP/+9wbm7W/uzy4WAwYfUzOOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847329; c=relaxed/simple;
	bh=1jyVcSPfekZqM9Yp6FkpCVLNycaGSQ/72IfGmPj7gDs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDjuP5NJvVpU/SF8qT5ZDCIX7ngppzQKWksDvqqyD4R7xvrIrX8FnS1HMbeTkeEDPsFeYWLRfxTGUO8uxQIKNpyG3O1RxKz6jOz7iEUKNAF2ksvpLNmdWYVxDeWG3hVCBMy0AnOG6OXS9cRdWF2S+/904eMC7HYxwl9Gwubbf5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7t/oiZa; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7t/oiZa"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A11DC40169
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-HwTXQEk2Q7 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Sep 2024 02:02:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A73074015F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A73074015F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J7t/oiZa
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A73074015F
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725847325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16JoM8Mgvw7U3L3TUK8QhKHLZmzZfWIlUgzLKKumFcc=;
	b=J7t/oiZakekAQOiBoNkAEb44aBZddOoagebVkX6fme7NNUIw7CRC5Dr7esYT4nFUpwfwTl
	QgneWXDy3YpSOQzL0ycbILUhvV6NqgNkKrJgbhIyhtmTYdNxBIKEUZm/seVnsE9oVf/FJN
	SHzW14+P+PmqFq3dhQvTRA4MVX3lZC0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-yAVCFQQIMTmmWZ1b1D7XxQ-1; Sun,
 08 Sep 2024 22:02:03 -0400
X-MC-Unique: yAVCFQQIMTmmWZ1b1D7XxQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB6961956057;
	Mon,  9 Sep 2024 02:02:02 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0433A1956086;
	Mon,  9 Sep 2024 02:01:58 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RESEND PATCH v1 2/7] vhost: Add kthread support in function vhost_worker_queue()
Date: Mon,  9 Sep 2024 10:00:40 +0800
Message-ID: <20240909020138.1245873-3-lulu@redhat.com>
In-Reply-To: <20240909020138.1245873-1-lulu@redhat.com>
References: <20240909020138.1245873-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Added back the previously removed function vhost_worker_queue() and
renamed it to vhost_worker_queue_khtread(). The new vhost_worker_queue()
will select the different mode based on the value of the parameter.

The old function vhost_work_queue()  was change to support task in
commit 6e890c5d5021 ('vhost: use vhost_tasks for worker threads')
changed in
commit f9010dbdc ('fork, vhost: Use CLONE_THREAD to fix freezer/ps regression')
and also was change the name of function to vhost_worker_queue() in
commit 0921dddcb5 (vhost: take worker or vq instead of dev for queueing)

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 30 ++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index be43181af659..ab4608fcf86b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -236,8 +236,8 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
-static void vhost_worker_queue(struct vhost_worker *worker,
-			       struct vhost_work *work)
+static void vhost_worker_queue_task(struct vhost_worker *worker,
+				    struct vhost_work *work)
 {
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
@@ -249,6 +249,32 @@ static void vhost_worker_queue(struct vhost_worker *worker,
 	}
 }
 
+static void vhost_work_queue_kthread(struct vhost_worker *worker,
+				     struct vhost_work *work)
+{
+	if (!worker)
+		return;
+
+	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
+		/* We can only add the work to the list after we're
+		 * sure it was not in the list.
+		 * test_and_set_bit() implies a memory barrier.
+		 */
+		llist_add(&work->node, &worker->work_list);
+
+		wake_up_process(worker->task);
+	}
+}
+
+static void vhost_worker_queue(struct vhost_worker *worker,
+			       struct vhost_work *work)
+{
+	if (enforce_kthread) {
+		vhost_work_queue_kthread(worker, work);
+	} else {
+		vhost_worker_queue_task(worker, work);
+	}
+}
 bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
 {
 	struct vhost_worker *worker;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..c7f126fd09e8 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -27,6 +27,7 @@ struct vhost_work {
 };
 
 struct vhost_worker {
+	struct task_struct	*task;
 	struct vhost_task	*vtsk;
 	struct vhost_dev	*dev;
 	/* Used to serialize device wide flushing with worker swapping. */
-- 
2.45.0

