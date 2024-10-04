Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD115AC4
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728007202; cv=none; b=td7S11qnreb+btzBnU1rBbrAhJpusAqqpS7VPL1f6s6cRyxSPsTs27cuNKUiBNULVOAXFR3Zw5Fm4r/cgHWjo3eRmgbu1mqr9NYej3G9Nq7lo1VNh8jueBhcTxmALuUS9Nyq8PQ7h9H00En4eNjQD13tiwGOyMGmVyeyXi/twO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728007202; c=relaxed/simple;
	bh=/dwRUtLQMuNrkI7BnDhn0e9yx3Htk8dRbVux8u/QHfc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlwuFPyiQgRdyXKae6SLcuygc/GSJdHxrG2jNguWT2tlx8Y0GMADxYHcGPx8QOwIgHNAGEXBQZ95VDLBB8vkbSb1mWPi7Fb/1pmy0vEwF3gRV+O6xDLPLrsqvmbhcgpWRlaJwm+zNd5aUm/H9Sd5JafOR2vt/nV6ZCelufFTlo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bt6RELeH; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt6RELeH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C864440210
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 02:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cheyegxH5hkK for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Oct 2024 02:00:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B596F401AD
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B596F401AD
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bt6RELeH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B596F401AD
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 01:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728007198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULQjL8SAWvac/iPOoiJqTiPvXj5aDYtkhU+eRT8XVsk=;
	b=bt6RELeHLnwFrTczdoHH1AY/GzCUQ6wgFHQb05SExGRkUPo0YnbrWSLipiSr+bh/5SZUPB
	poMb+hEQe0Fg8fEjp/uewMJdmIcYujp4ZiX3aZPnc24mQPcHz6igRgzV1TLrbv0S9kCjkP
	rhI5j4jClpwnbmuxVOh/0lQbKH7jFhc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-niA-mfUOPLq5XAbh04mlew-1; Thu,
 03 Oct 2024 21:59:55 -0400
X-MC-Unique: niA-mfUOPLq5XAbh04mlew-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A7831955D95;
	Fri,  4 Oct 2024 01:59:54 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E5D519560A3;
	Fri,  4 Oct 2024 01:59:50 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/7] vhost: Add kthread support in function vhost_worker_queue()
Date: Fri,  4 Oct 2024 09:58:16 +0800
Message-ID: <20241004015937.2286459-3-lulu@redhat.com>
In-Reply-To: <20241004015937.2286459-1-lulu@redhat.com>
References: <20241004015937.2286459-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Added back the previously removed function vhost_worker_queue() and
renamed it to vhost_worker_queue_khtread(). The new vhost_worker_queue()
will select the different mode based on the value of the parameter.

The old function vhost_work_queue()  was change to support task in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
changed in
commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
and also was change the name of function to vhost_worker_queue() in
commit 0921dddcb589 ("vhost: take worker or vq instead of dev for queueing")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 30 ++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a4a0bc34f59b..ad359d4b725f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -237,8 +237,8 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
-static void vhost_worker_queue(struct vhost_worker *worker,
-			       struct vhost_work *work)
+static void vhost_worker_queue_task(struct vhost_worker *worker,
+				    struct vhost_work *work)
 {
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
@@ -250,6 +250,32 @@ static void vhost_worker_queue(struct vhost_worker *worker,
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
+	if (enforce_inherit_owner) {
+		vhost_worker_queue_task(worker, work);
+	} else {
+		vhost_work_queue_kthread(worker, work);
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

