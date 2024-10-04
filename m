Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312F4501E
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728007204; cv=none; b=O25k0ZYEfAsFf53EmiCi11qteJkPNCp5cRvBO0Do4Ow+rlODFuuRg63U/MLvMBcGEhVXdYOcDS2XeV2Zxm8K3H2+yaOLGfDzmfTXkt4rCxZjJ0vRdihkV10E8vtR2AV5dweAY31d7K6KDWPMKjtL8HvxzqWqv2blr1Pmevun734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728007204; c=relaxed/simple;
	bh=BjJr59mp9uuv2YmTKWyzhnhDDsNGKnGb+2hQDETXr2M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6Ls7cQ/pPhOyjqb+DYK0GiegfHiCyZg5C9G2eP46yDBqN6WpyX59enyQvMSL4MO18Dn2gRPXjjs/a/+2HbiXW8Vcv9Ml8MBiAyVRR35zvt3qZ/+avXGwtrngRaU53jgk9hEu6TeN6Z+CiAqAzQSJvAGPNZW4D2sEd2kuMdQGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLB2ml5F; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLB2ml5F"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 307CA84153
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 02:00:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HLAYYlee0qCD for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Oct 2024 02:00:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 500ED84149
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 500ED84149
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KLB2ml5F
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 500ED84149
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728007201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocgoI1lOofS6GZhyj4LGKPzfRZFIHFLkb07SAt9nUao=;
	b=KLB2ml5FVmJAgz3av93EmcKXTu575EcUBO77s/DwUcPkmPNAaUH82FXgdfMURQ7Qa8jhGp
	7BN0wSDS5vVvk3XViyaSYiJBJqBUMHCR6s2OvGC1vKzd5k+jX/mcpEOjMtjvq7DtM7NYY9
	+24Ytx28d6RHOS3i/mIwKZ18kcCkwlw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-311buRSkN1GuMCITReGcrQ-1; Thu,
 03 Oct 2024 21:59:59 -0400
X-MC-Unique: 311buRSkN1GuMCITReGcrQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44F0719560B2;
	Fri,  4 Oct 2024 01:59:58 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2BF219560A3;
	Fri,  4 Oct 2024 01:59:54 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 3/7] vhost: Add kthread support in function vhost_workers_free()
Date: Fri,  4 Oct 2024 09:58:17 +0800
Message-ID: <20241004015937.2286459-4-lulu@redhat.com>
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

Added back the previously removed function vhost_workers_free() and
renamed it to vhost_workers_free_khtread(). The new vhost_workers_free()
will select the different mode based on the value of the parameter.

The old function vhost_workers_free was change to support task in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
also changed in
commit a284f09effea ("vhost: Fix crash during early vhost_transport_send_pkt calls")
change to xarray in
commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 52 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index ad359d4b725f..fed6671c1ffb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -648,8 +648,21 @@ static void vhost_detach_mm(struct vhost_dev *dev)
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
@@ -660,7 +673,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 	kfree(worker);
 }
 
-static void vhost_workers_free(struct vhost_dev *dev)
+static void vhost_workers_free_task(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	unsigned long i;
@@ -675,10 +688,36 @@ static void vhost_workers_free(struct vhost_dev *dev)
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
+	if (enforce_inherit_owner)
+		vhost_workers_free_task(dev);
+	else
+		vhost_workers_free_kthread(dev);
+}
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
@@ -846,7 +885,10 @@ static int vhost_free_worker(struct vhost_dev *dev,
 	__vhost_worker_flush(worker);
 	mutex_unlock(&worker->mutex);
 
-	vhost_worker_destroy(dev, worker);
+	if (enforce_inherit_owner)
+		vhost_worker_destroy_task(dev, worker);
+	else
+		vhost_worker_destroy_kthread(dev, worker);
 	return 0;
 }
 
-- 
2.45.0

