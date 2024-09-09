Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B61B28A
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847368; cv=none; b=jjZur2Z38BHjxowTACWzr8erc5ckUpVgK6CFGLg1G74ebE4K+qhfCn10FWTwVsq162g1kMUdEEFCFmg2DSavzp/+umjMix0CF0kPrySpIgONY+rR7DBhoM7dzxq1z+9xIhGxDBrvPSzb5or5E3O2Gq+Fd1m8VYIclBD6DKxRlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847368; c=relaxed/simple;
	bh=zqlaRlnd05SD5oB9AsO/uvrsBJ0II+JX0ru8cmar6Gs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSx5y3tsg9WmVt4vWQ9d1pTPz85IvMSnSnJenrAmp7lzP25HhkIRkVBz2zm4b0SfsGf6HEIMjaMr9o2vjC41rrIRZQKE88PcrF9GUIeaNrgdYvVNeT/h5z5G+ZmvFKvao120ndDifLb7YLwLP6kSELlw5+6HqUgY5UqISW2BOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMsJEB6w; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMsJEB6w"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A22DB80EE4
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkYNDFjpMTEF for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Sep 2024 02:02:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B891B80ED4
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B891B80ED4
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HMsJEB6w
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B891B80ED4
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725847364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tabn+YpAyhcfuddzHNvGrDvZ0pmns8bGlBy77mmbWM=;
	b=HMsJEB6wHofy9QaVAbCge4kiwjvnGfexOwJJej+PvUAtR7CUcvxqUkxlMp4p86HPVMKleO
	LFfjX/R3RQz7u56ilpX3XZEU6HkWPm8hVGvVC4WCCkkcq1pXHoZuYE4bsnlF6Wxmpg1gxS
	NDdTS6TlMl4g+duB8Xas2EFewcOtkPg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-nJYzlgIRN5qc9smty4H8sA-1; Sun,
 08 Sep 2024 22:02:41 -0400
X-MC-Unique: nJYzlgIRN5qc9smty4H8sA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87DB41955F10;
	Mon,  9 Sep 2024 02:02:40 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C39001956086;
	Mon,  9 Sep 2024 02:02:35 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RESEND PATCH v1 5/7] vhost: Add the cgroup related function
Date: Mon,  9 Sep 2024 10:00:43 +0800
Message-ID: <20240909020138.1245873-6-lulu@redhat.com>
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

Add back the previously removed cgroup function to support the kthread
The biggest change for this part is in vhost_attach_cgroups() and
vhost_worker_cgroups_kthread(). This is because of the change in
struct dev->worker_xa.

The old function was remove in
commit 6e890c5d5021 ('vhost: use vhost_tasks for worker threads')

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 0bc4f75ae1b9..46b15e9c0693 100644
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

