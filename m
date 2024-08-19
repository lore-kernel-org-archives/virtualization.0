Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3ED15FD16
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059757; cv=none; b=MYofH+7HLAk1MkjokBX7qPYG2h3l6H2BL91aZJAda3JiDLFmZb55UMd8Kqb2tFyDPklHXfFhJ2usFDFecVD17ukrQDFNmvINrX/KopX1lOj0bvtHP+v4xod6Fto/2VKI/tIFmkGGi7oLubu9iD1eD70um+HPSKvowQLPsx3thno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059757; c=relaxed/simple;
	bh=bCcqpKiJI8aKiCcDeYVwFAl69XuQNef0FHW+n9EVc78=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehyT9Z3ANiKWF1SubbrSm5wvEaO0JoKsqBY20YtaxprD/PdlfDk533id97hix94azzvNJAI6mDSPX+NLYG/+IVUBCH6GLg/ij1nLKrLJ6z5XV6loL3qmQjanJ8sUOPihcPt3r1ECamV9zeWf0HFIZJt/m5BT85eTDsVqIEo7NaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLCvQX1k; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLCvQX1k"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E352C605B1
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U0K5lWqJM7SV for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Aug 2024 09:29:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2F453600B9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F453600B9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XLCvQX1k
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2F453600B9
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724059754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTiAXi97N+gpQpGCrSBfOxeh4bPxPDjSj8mY3XZdH4M=;
	b=XLCvQX1k/tpFwL5sDb/MrXPVOYjGG0+Lxdl/0XliOOSN9/oltP945k7fEIoxjUFo9R3FxH
	hdRqbpci6te87eQ2javEV+F79hYcpO06Pcou0O0rXcdqhjGfwTHpJIVW7ej5Uc32myKPKa
	j9TpfdmGoPRJ1peGZ5Ix5kr1wZb7qmM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-zo-vL0JBOyy-nQB-HA3CXg-1; Mon,
 19 Aug 2024 05:29:10 -0400
X-MC-Unique: zo-vL0JBOyy-nQB-HA3CXg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBBA51955D56;
	Mon, 19 Aug 2024 09:29:09 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE8611956054;
	Mon, 19 Aug 2024 09:29:06 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RFC 2/7] vhost: Add kthread support in function vhost_worker_queue()
Date: Mon, 19 Aug 2024 17:27:28 +0800
Message-ID: <20240819092851.441670-3-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-1-lulu@redhat.com>
References: <20240819092851.441670-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Added back the previously removed function vhost_worker_queue() and
renamed it to vhost_worker_queue_khtread(). The new vhost_worker_queue()
will select the different mode based on the value of the parameter.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 30 ++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index da701f6b3f2c..6261c9df468e 100644
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
+	if (use_kthread) {
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

