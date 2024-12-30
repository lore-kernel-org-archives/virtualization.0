Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC41A706F
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562712; cv=none; b=GTkuVfrsfwrYm1mE6HeJ6F84DfaTAumQVkNP1fvy+r7jFHoE3wv4WrsOgGa4/YuwcaeMWrK6lQ2UkSi86AOPRTWNvEK5ee8dT2EW1uo9jp1BoxYloWWEZyOzSsvLlFwFklpD8PfTlRAF6zbTfUVCPd5Vuee4K22Z2RPjjfNhHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562712; c=relaxed/simple;
	bh=jeWjZGyVq++I2IUyvncBX3PW15I/qkhjeCkZYe2n4iM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK32xMpdwdcuKNOot5DoSZ1KRAw/M5TxY58HM2H1EcTnD1081esSP3mRQ3jMswvAoXOECMcbRYeDbQiSpdcGeX+nwMxj5XxPtkRPVzzOurGZl1FP1K30J6J9r26IuJGZdQaoeYVerdlAzRMWn4xRqxLLpqqZ7Mlqy8Oa3sBoHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeRPSUwt; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeRPSUwt"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B335380F63
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zu9SpltokuTT for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Dec 2024 12:45:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7DA4480FF5
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7DA4480FF5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SeRPSUwt
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7DA4480FF5
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMBEQFgZfioBrCNsFkZVI/KneYN1UfIwkiutolEo20E=;
	b=SeRPSUwtnx+lnrT139aAHKzKoPkvOsj/pMZ8hfwM0bJ6PPsCrVmQUxuNb3VpgAaF4fqfSd
	kpZk1Ed7bz9M8VlmHua5LrdF/RhGY3Yz6ZCqwWBnwil2gMgpJ985pIr+//GFZAgS3mkPeH
	JC6VTAywwgDhGojHjFQCFKvgJ106cIg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-ziJisQehMaCGzvhRWamPew-1; Mon,
 30 Dec 2024 07:45:04 -0500
X-MC-Unique: ziJisQehMaCGzvhRWamPew-1
X-Mimecast-MFC-AGG-ID: ziJisQehMaCGzvhRWamPew
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83CF01956064;
	Mon, 30 Dec 2024 12:45:03 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93C4D1956053;
	Mon, 30 Dec 2024 12:44:59 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 1/6] vhost: Add a new parameter in vhost_dev to allow user select kthread
Date: Mon, 30 Dec 2024 20:43:48 +0800
Message-ID: <20241230124445.1850997-2-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-1-lulu@redhat.com>
References: <20241230124445.1850997-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The vhost now uses vhost_task and workers as a child of the owner
thread. While this aligns with containerization principles, it confuses
some legacy userspace applications. Therefore, we are reintroducing
support for the kthread API.

Introduce a new parameter to enable users to choose between kthread and
task mode.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 1 +
 drivers/vhost/vhost.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473..eaddbd39c29b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -552,6 +552,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
+	dev->inherit_owner = true;
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..c650c4506c70 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -176,6 +176,7 @@ struct vhost_dev {
 	int byte_weight;
 	struct xarray worker_xa;
 	bool use_worker;
+	bool inherit_owner;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
 };
-- 
2.45.0

