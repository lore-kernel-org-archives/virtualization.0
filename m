Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CBE17BAF
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 01:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845767; cv=none; b=ZUXUfbDhTBzrY3ktUS3gz05DpAPZrQsxNWyfpo33RLoAI/N6TEumBeQe8OyDOuI2at3hAGNDxFyw9XrctrABcWc6pBIIExUttj+NzrFgHaHAhe3Wcf3244KClLnFf71x60V+O0csZcW7uTbUYKWpbV2VkUxgus+AjTFkTQCefGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845767; c=relaxed/simple;
	bh=1pQYSVQ05pRenwCfIRIlQbmmJntgrvPfEVVFvpU5lOA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfmX8valXTVV1q9ZHPYkZMR4gU6acr9exTlbCDfbz0E46LojhNfwBnBY7/QDFNcSF/1TdZ2p72GlYep7k5A+q5yz7zoweeNgcixvvv6I9sEwMyjf+23luGNHzNYwbwxgeeqQz3U9ODdZdkfhbcMxWsto9WJAskR2ggz49yUdwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mk5lz/Xl; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk5lz/Xl"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D414A6069A
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 01:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7YPkF_w0IYi1 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Sep 2024 01:36:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 06B44605FD
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06B44605FD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mk5lz/Xl
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 06B44605FD
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 01:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725845763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyzWZkYitAKw0qInqxUPaOkmkxHh1NGFvAqmvdgzGAs=;
	b=Mk5lz/Xl3E/EQgbszaUJP2UyOrw9KakQuENp8N1M6jP6BiptxYzeWOb8eMsmXsdRJEqOQF
	g1dRdRYZnSq++D3c2nla/xuc7xVCjLi7/40oxDDS3d7U9ly+mcIuaGkjJBjRIERFgHREXd
	fgd0jYLfWA+drrs/6Bmx1BOaBJFflNU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-inPuApwzPCSEM7r8GuOZxA-1; Sun,
 08 Sep 2024 21:36:01 -0400
X-MC-Unique: inPuApwzPCSEM7r8GuOZxA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2BDB193E8CE;
	Mon,  9 Sep 2024 01:36:00 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E6EC1956086;
	Mon,  9 Sep 2024 01:35:56 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v1 3/7] vhost: Add kthread support in function vhost_workers_free()
Date: Mon,  9 Sep 2024 09:33:42 +0800
Message-ID: <20240909013531.1243525-4-lulu@redhat.com>
In-Reply-To: <20240909013531.1243525-1-lulu@redhat.com>
References: <20240909013531.1243525-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Added back the previously removed function vhost_workers_free() and
renamed it to vhost_workers_free_khtread(). The new vhost_workers_free()
will select the different mode based on the value of the parameter.

The old function vhost_workers_free was change to support task in
commit 6e890c5d5021 ('vhost: use vhost_tasks for worker threads')
also changed in
commit a284f09effe ('vhost: Fix crash during early vhost_transport_send_pkt calls')
change to xarray in
commit 1cdaafa1b8b ('vhost: replace single worker pointer with xarray')

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 52 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 6198c165ab15..411e81a2925a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -647,8 +647,21 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
-static void vhost_worker_destroy(struct vhost_dev *dev,
-				 struct vhost_worker *worker)
+static void vhost_worker_destroy_kthread(struct vhost_dev *dev,
+					 struct vhost_worker *worker)
+{
+	if (!worker)
+		return;
+
+	WARN_ON(!llist_empty(&worker->work_list));
+
+	xa_erase(&dev->worker_xa, worker->id);
+	kthread_stop(worker->task);
+	kfree(worker);
+}
+
+static void vhost_worker_destroy_task(struct vhost_dev *dev,
+				      struct vhost_worker *worker)
 {
 	if (!worker)
 		return;
@@ -659,7 +672,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 	kfree(worker);
 }
 
-static void vhost_workers_free(struct vhost_dev *dev)
+static void vhost_workers_free_task(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	unsigned long i;
@@ -674,10 +687,36 @@ static void vhost_workers_free(struct vhost_dev *dev)
 	 * created but couldn't clean up (it forgot or crashed).
 	 */
 	xa_for_each(&dev->worker_xa, i, worker)
-		vhost_worker_destroy(dev, worker);
+		vhost_worker_destroy_task(dev, worker);
 	xa_destroy(&dev->worker_xa);
 }
 
+static void vhost_workers_free_kthread(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	unsigned long i;
+
+	if (!dev->use_worker)
+		return;
+
+	for (i = 0; i < dev->nvqs; i++)
+		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
+	/*
+	 * Free the default worker we created and cleanup workers userspace
+	 * created but couldn't clean up (it forgot or crashed).
+	 */
+	xa_for_each(&dev->worker_xa, i, worker)
+		vhost_worker_destroy_kthread(dev, worker);
+	xa_destroy(&dev->worker_xa);
+}
+
+static void vhost_workers_free(struct vhost_dev *dev)
+{
+	if (use_kthread)
+		vhost_workers_free_kthread(dev);
+	else
+		vhost_workers_free_task(dev);
+}
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
@@ -845,7 +884,10 @@ static int vhost_free_worker(struct vhost_dev *dev,
 	__vhost_worker_flush(worker);
 	mutex_unlock(&worker->mutex);
 
-	vhost_worker_destroy(dev, worker);
+	if (use_kthread)
+		vhost_worker_destroy_kthread(dev, worker);
+	else
+		vhost_worker_destroy_task(dev, worker);
 	return 0;
 }
 
-- 
2.45.0

