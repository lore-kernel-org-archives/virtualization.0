Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641C200106
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791683; cv=none; b=Fg/cysFABFyt4wmS+xVySu06n0tEBh/NBTWWOTEZauaYhuEou1zQBlLU34WBMOoKyrUFr5vj821ffB0lVqxq5o+pwP8qz9qVN0xDTyM4l0P+GEV1kq9kEfJErWssVMysuyR4IH9bF2QBcr09sj+rnQftPkPUmTZmF9pVtZliBGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791683; c=relaxed/simple;
	bh=M49i9Z80LvRN1KH00nCqmQiLAV5d1TcbHzx3zh4khGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKW+GDhnL8tM3kdH43ELRzYgPyEtmkIXfv1Y46guaElyvShmsnl+goxWIwo9Ahy++TX50RjbiuxX1euCoQ8YGXjNKi474MFVgcVffgSbxK6gBpSKpqZGpUos8UZ+0x8yR026gdsdcwsL+smXkXr26KhjX0/VlOiL2+OF0w9ZrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvEb9Lbu; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvEb9Lbu"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A921E4074E
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CI1Lk2lDRG3Q for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 07:28:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C168F400CF
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C168F400CF
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hvEb9Lbu
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C168F400CF
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m4NUSQOwh8h3S2yfP06X/nb4pg21Jt9eMtwUyyXqBQ=;
	b=hvEb9LbuYa6PsyJRfKycrFF43B6eG9+kY9jde3HGDXdvqVB51o3RBPLFSDoDRvFFbXuuZj
	oHwRYykoFxbA/MuXYYSrgzZA1IceSWV2IiP7D2PELy10C55euWf1XSrzj+KBig2jJ+uPjP
	DfUZURD75CUiml2QspTQWT+fxEBD+8A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-p_ZQeHAjNgOwXe-RNXUbxQ-1; Tue,
 05 Nov 2024 02:27:56 -0500
X-MC-Unique: p_ZQeHAjNgOwXe-RNXUbxQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCC5519560AB;
	Tue,  5 Nov 2024 07:27:54 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B52F1956086;
	Tue,  5 Nov 2024 07:27:50 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 6/9] vhost: Add kthread support in function vhost_worker_destroy()
Date: Tue,  5 Nov 2024 15:25:25 +0800
Message-ID: <20241105072642.898710-7-lulu@redhat.com>
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

The function vhost_worker_destroy() will use struct vhost_task_fn and
selects the different mode based on the value of inherit_owner.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8b7ddfb33c61..c17dc01febcc 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -718,12 +718,14 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 static void vhost_worker_destroy(struct vhost_dev *dev,
 				 struct vhost_worker *worker)
 {
-	if (!worker)
+	if (!worker && !worker->fn)
 		return;
 
 	WARN_ON(!llist_empty(&worker->work_list));
 	xa_erase(&dev->worker_xa, worker->id);
-	vhost_task_stop(worker->vtsk);
+	worker->fn->stop(dev->inherit_owner ? (void *)worker->vtsk :
+					      (void *)worker->task);
+	kfree(worker->fn);
 	kfree(worker);
 }
 
-- 
2.45.0

