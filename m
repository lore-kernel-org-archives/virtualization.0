Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ADE234985
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849123; cv=none; b=U1/5bLNdPgc+cjVcusMmSsVU8mLfPl4cgdtL+0zrvUjBlHZBVKLsDyWnfjiXezt6EizdQjyoOu+2ewDf8rSoY8/pNvdtme794N8RL+jT1ZabfvuVcNLfu3/XMx2G268wbpgMNq5zGuy5eTMLqX2TH9FBKnBz41a1/jrIsVVu2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849123; c=relaxed/simple;
	bh=O+1OQtxPQvHz6+B0oFWBYj6LQgh9U+Y2ejH4TMx9peE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkcAqekyilg+4lMWwCDKYXwREr1Kx6KQ5nauch54K/KYrcgt1TSYA30gzN7jTEXqtkTOT9RifQSSDJYZFkQ4ceOQt6bPaMbtF9/L0Ks2vfK8gLjKce2cVmD3sK3LfX5e2ZJX+O3Z1mhYFQJqPU/CiS4856j0wDuaDbSyTAYG6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asd2pUCv; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asd2pUCv"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DB774088A
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:45:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sTAMJ0n251jF for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 16:45:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9CB684086C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9CB684086C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=asd2pUCv
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9CB684086C
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaqtC4zyNMItOw1ucAQ9VH5Gv6VtefAKsvYHMah+ZGg=;
	b=asd2pUCv+tmOsDojQ9A0m9xqvnIGyUPNVjec4BPApkWRuP0F/4IMdYoPFO09jbkvJ09N01
	ylPNrrboGXF3ywYvGyPqgbMTQmnvyr/Fhy7UeFQm2zIF75P+aopcC8T++ryqgGCoLNb7tT
	1l0DaiEAwNndHrqPQhYZDEfaEaWUydY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-FvSuTkfGMTiMtPFHRedEbQ-1; Tue,
 10 Dec 2024 11:45:16 -0500
X-MC-Unique: FvSuTkfGMTiMtPFHRedEbQ-1
X-Mimecast-MFC-AGG-ID: FvSuTkfGMTiMtPFHRedEbQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D583D1955F3C;
	Tue, 10 Dec 2024 16:45:14 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E03819560A2;
	Tue, 10 Dec 2024 16:45:10 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 2/8] vhost: Add the vhost_worker to support kthread
Date: Wed, 11 Dec 2024 00:41:41 +0800
Message-ID: <20241210164456.925060-3-lulu@redhat.com>
In-Reply-To: <20241210164456.925060-1-lulu@redhat.com>
References: <20241210164456.925060-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add the previously removed function vhost_worker() back
to support the kthread and rename it to vhost_run_work_kthread_list.

The old function vhost_worker was change to support task in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
change to xarray in
commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index eaddbd39c29b..1feba29abf95 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	__vhost_vq_meta_reset(vq);
 }
 
+static int vhost_run_work_kthread_list(void *data)
+{
+	struct vhost_worker *worker = data;
+	struct vhost_work *work, *work_next;
+	struct vhost_dev *dev = worker->dev;
+	struct llist_node *node;
+
+	kthread_use_mm(dev->mm);
+
+	for (;;) {
+		/* mb paired w/ kthread_stop */
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (kthread_should_stop()) {
+			__set_current_state(TASK_RUNNING);
+			break;
+		}
+		node = llist_del_all(&worker->work_list);
+		if (!node)
+			schedule();
+
+		node = llist_reverse_order(node);
+		/* make sure flag is seen after deletion */
+		smp_wmb();
+		llist_for_each_entry_safe(work, work_next, node, node) {
+			clear_bit(VHOST_WORK_QUEUED, &work->flags);
+			__set_current_state(TASK_RUNNING);
+			kcov_remote_start_common(worker->kcov_handle);
+			work->fn(work);
+			kcov_remote_stop();
+			cond_resched();
+		}
+	}
+	kthread_unuse_mm(dev->mm);
+
+	return 0;
+}
+
 static bool vhost_run_work_list(void *data)
 {
 	struct vhost_worker *worker = data;
-- 
2.45.0

