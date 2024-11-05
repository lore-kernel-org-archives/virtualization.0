Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2671FEFC9
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791677; cv=none; b=I3YsOFYGDY/iVPQWaQ/mIPLgtCDS+QxlL9altaxEtqeM9UCZ0b2ALOmKTUFuZXgK8/Pdkr5gpKN4goF5FkcS9uvogUdpTxMv938EPrnf8Z4caeYA+6HjGkKj7SFcZsNyxRg8/JBk5MSUJQrjt4wuYW386Dt3zlYrsVXt6FrQshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791677; c=relaxed/simple;
	bh=+38GjQ5iNed2+14XtChEVV9Ul7oBJUOLzQdRTNmOgpQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sat179OyB+NAPq7/MIYWLXoRm/yyhGIQPHA+TZpMl6mZuu616D2Uo9CPC6YVhuJnBP7Q/rj+Z/BW/sR9rpbCh2vMnWyUFMHPVxbA5d0B2FMHagFSlIdBd5HinWK0In5q0KsZfNFvxxrkUQNImMEr3ZQ/GuqL835kaKSMaNJWkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYXsOIvx; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYXsOIvx"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01D0D80DB5
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C0-a5C04Wqo0 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 07:27:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5463480DAF
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5463480DAF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TYXsOIvx
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5463480DAF
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPknO6DVyO1LjLhZHYo5oROtWHiUqkzRt9HMN0ycP2A=;
	b=TYXsOIvxwmu9XSPwwwHW6oMO3Qgo+ocWSyfXLwzLf7AfpPshRRy4/Hg2tWZFAP08mxoB0P
	tFlCE1q9OvH4++ghtAS5orLLLhD2IRkhrdjdrblOiuIPWYrf+ufKuZUse+JY7oLrpMuKC8
	0I/1271BTwE0rJ9BJIZfh2pZeQuwwyw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-18RcnFfyPAuvZxSF-A6PBg-1; Tue,
 05 Nov 2024 02:27:50 -0500
X-MC-Unique: 18RcnFfyPAuvZxSF-A6PBg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6BC719560A2;
	Tue,  5 Nov 2024 07:27:49 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64CC91956086;
	Tue,  5 Nov 2024 07:27:44 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 5/9] vhost: Add kthread support in function vhost_worker_queue()
Date: Tue,  5 Nov 2024 15:25:24 +0800
Message-ID: <20241105072642.898710-6-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-1-lulu@redhat.com>
References: <20241105072642.898710-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The function vhost_worker_queue() uses vhost_task_fn and
selects the different mode based on the value of inherit_owner.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 603b146fccc1..8b7ddfb33c61 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -238,13 +238,18 @@ EXPORT_SYMBOL_GPL(vhost_poll_stop);
 static void vhost_worker_queue(struct vhost_worker *worker,
 			       struct vhost_work *work)
 {
+	if (!worker && !worker->fn)
+		return;
+
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &worker->work_list);
-		vhost_task_wake(worker->vtsk);
+		worker->fn->wakeup(worker->dev->inherit_owner ?
+					   (void *)worker->vtsk :
+					   (void *)worker->task);
 	}
 }
 
-- 
2.45.0

