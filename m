Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470721B19E
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156269; cv=none; b=Wlm3rqBEAAKGatGM8BR6giP1jeKvpux/JhjQApJlBENQUnEou4rTz+grZLXSUvftQQswq2B8XduTmp2OGQ+S2kfT4/5xfWRSkK23bwfw5oAt8vQMebPsgiRo4ysouteopBaWX3/eG1wLXkyhP0hXC0euihcvHvMgH32hJzVZr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156269; c=relaxed/simple;
	bh=YUc7c9MXgNwcjHIY/6Aj5gIGWVEuIKPw42UQXK+Og6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXjwWDYSM2M/0NijcK6CFvjwqKWDJtrVdE0l/65h2a24vOUfP15DOaSo1GPlnMmNGDnWG3gl4LEhc2YzQ3HF7bl0DxsZxBV/FE00zwC8gUBrsuEd/y+REs8RKjn15Wftsfy4MlJqz6sDEM2xu3SDgAAfLUPNFo1/luErY1ogVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWZ9of6k; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWZ9of6k"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 937944F0BA
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ECc1G7Iqibl3 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Mar 2025 10:04:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E0FA94EFF3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0FA94EFF3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XWZ9of6k
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E0FA94EFF3
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743156264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Sc1dvTB3dN9eSkDmtrVWCVhuubTwR7VYeyfTnHnq6Y=;
	b=XWZ9of6k8z4K7r12i8iW2mXh7z+uX+nRH3JQUgG2ywrR3BU7rigIMz8MPWaOD2ZQndzOuT
	npi0rkvDnrKA/zW3ujcXRKGASnsZbUOPZ21LghlM1T8IKgzu6qpvVyRTAjIu5GPwbKjGrQ
	RnaQVN8Usavb/algKe41pgsbls1FylQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-m6STFpomMGS1OwcxcNGOzA-1; Fri,
 28 Mar 2025 06:04:21 -0400
X-MC-Unique: m6STFpomMGS1OwcxcNGOzA-1
X-Mimecast-MFC-AGG-ID: m6STFpomMGS1OwcxcNGOzA_1743156260
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E6E8196B36E;
	Fri, 28 Mar 2025 10:04:20 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB7C330001A1;
	Fri, 28 Mar 2025 10:04:15 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 2/8] vhost: Reintroduce vhost_worker to support kthread
Date: Fri, 28 Mar 2025 18:02:46 +0800
Message-ID: <20250328100359.1306072-3-lulu@redhat.com>
In-Reply-To: <20250328100359.1306072-1-lulu@redhat.com>
References: <20250328100359.1306072-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index 250dc43f1786..9500e85b42ce 100644
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

