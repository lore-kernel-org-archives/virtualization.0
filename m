Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE822FE12
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849161; cv=none; b=nNUyL7LDBhCThg35LJqUZnEXnY0NHzeQ5T5piKMX8+Lcf3or7zImlIBDg8ieC9SdrS6dERf413mcGXm2cAiwLLrvF37/1TixyZQXefVf6GC+9LESx6HYVlJCxj9mJUWgwGs7WpqFlTzcp8woXeSW1j4fZAPQTE0X6HP8IzSrMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849161; c=relaxed/simple;
	bh=YOfWaYqxdg6bK9f7Uz3VKPypKGPg3DU2DtQ1pCaatEA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMHimxlKr4FRq4smSN6gnL64p0rwdG+w+k5HfFaqZk2Hst55mPagTxZ5EP3MHsiph/TrXok65Lshg3S6JcBueJ77ECxTGpqH0b6b4bfWUSumF+coyG6Qtv89Q6nteEi7EJzRU2v0p19C5G5FkSsuBoOOe1LjW88bmThqAUzVyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDHqBCe+; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDHqBCe+"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6368260A67
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:45:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IErEmldaP88k for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 16:45:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A061D60A61
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A061D60A61
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LDHqBCe+
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A061D60A61
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cFVaqbbEd48elKSFqv37dUABY9S1RJqNxZsF1midck=;
	b=LDHqBCe+Ul9/9vOv+seNLGNswPSjKudA9odo4QJYNZRTbCZFiokQ3uLO927pb3RrZuT0re
	Y5AVJ+8cJkzWFrHcOOlKeZnNM/pS5ZjNxf5id2BHXuvpbonuUm07DivyTo13iRS00wO8Kb
	jdS1NqUztmx2brY8LOhl388//dT97fE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-yhwMGRfEMTaFixChVawAGA-1; Tue,
 10 Dec 2024 11:45:53 -0500
X-MC-Unique: yhwMGRfEMTaFixChVawAGA-1
X-Mimecast-MFC-AGG-ID: yhwMGRfEMTaFixChVawAGA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7D64195609D;
	Tue, 10 Dec 2024 16:45:52 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BD8E19560A2;
	Tue, 10 Dec 2024 16:45:48 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 5/8] vhost: Add kthread support in function vhost_worker_queue()
Date: Wed, 11 Dec 2024 00:41:44 +0800
Message-ID: <20241210164456.925060-6-lulu@redhat.com>
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

The function vhost_worker_queue() uses a function pointer in
vhost_worker, which is initialized based on the inherit_owner
value.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 0175bbf4d8b3..d1aec41bcd56 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -237,13 +237,16 @@ EXPORT_SYMBOL_GPL(vhost_poll_stop);
 static void vhost_worker_queue(struct vhost_worker *worker,
 			       struct vhost_work *work)
 {
+	if (!worker)
+		return;
+
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &worker->work_list);
-		vhost_task_wake(worker->vtsk);
+		worker->task_wakeup(worker);
 	}
 }
 
-- 
2.45.0

