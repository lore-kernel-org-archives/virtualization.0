Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72215ECF1
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059792; cv=none; b=LZxCXy4H6xFlwjEJv36pEmfZUXnTStcQ9yJCfGWtd8g7kGlrNRU7CZKaMNrIvj+8BN2JAq+lpo3DzESiQkT+cVIDWUqvuFo9y1SklJQYIORYMxaXZqvqQZabFszQMpBdsUL58R/vn/CHw9eD6GpyXtKLWhCSAFoFbu2xomSH9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059792; c=relaxed/simple;
	bh=rKPlVLjhcIie/HzEaIKoKUFnl9YWoub0/1tLzlUDYw8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7IM8Kd8ViVarSDME72qEO1Q07Pq0ZVtXVMDb/a7zQBoOvLCIypaL225Rxf0IDvz1YMNLvRblXch2wRmvSATzNZrUGOSfT2vokMppRz/srsyGIx5O/ZjfJmU5wdjQ5UU4xASjJyBn8uPscnXbHpOEi72fpKuCtXmV9PHpqSBt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLaVe4gW; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLaVe4gW"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61BBF402A7
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o34MbNtbXcFz for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Aug 2024 09:29:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 54C24401F6
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54C24401F6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLaVe4gW
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 54C24401F6
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724059788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzn2/qpEe9PAQb6Wft4arxClH7AS+j9JaAKqQeQEjbw=;
	b=YLaVe4gWbRiIF5PCk3KYFCuegQREKhUiutuctDNMT2QKXpb0hhKXprPXmSK57JlSjYVc45
	kwhev2NNHTeZk39YHssqpETqsXEmmbr9mKF3MAFSZ2WFaaVqEv5ufClggKH57kghPY7ezp
	RyqvyXhxaE3M7zYOMkTG7tCRib3UvaQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-6r7lOoMRMzm6VKOwD4bUnA-1; Mon,
 19 Aug 2024 05:29:44 -0400
X-MC-Unique: 6r7lOoMRMzm6VKOwD4bUnA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC74F1955BFE;
	Mon, 19 Aug 2024 09:29:43 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7F0A1956054;
	Mon, 19 Aug 2024 09:29:40 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RFC 5/7] vhost: Add the cgroup related function
Date: Mon, 19 Aug 2024 17:27:31 +0800
Message-ID: <20240819092851.441670-6-lulu@redhat.com>
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

Add back the previously removed cgroup function to support the kthread
The biggest change for this part is in vhost_attach_cgroups() and
vhost_worker_cgroups_kthread(). This is because of the change in
struct dev->worker_xa.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 593f9521f51d..66ccda81f073 100644
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
@@ -648,6 +649,57 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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
+static int vhost_worker_cgroups_kthread(struct vhost_worker *worker)
+{
+	struct vhost_flush_struct flush;
+	struct vhost_attach_cgroups_struct attach;
+
+	attach.owner = current;
+
+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
+	vhost_worker_queue(worker, &attach.work);
+
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
+	vhost_worker_queue(worker, &flush.work);
+	wait_for_completion(&flush.wait_event);
+
+	return attach.ret;
+}
+
+static int vhost_attach_cgroups(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	unsigned long i;
+	int ret;
+
+	/*
+	 * Free the default worker we created and cleanup workers userspace
+	 * created but couldn't clean up (it forgot or crashed).
+	 */
+
+	xa_for_each(&dev->worker_xa, i, worker) {
+		ret = vhost_worker_cgroups_kthread(worker);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
-- 
2.45.0

