Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1DA1E7C38
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740926013; cv=none; b=lwStPiMlHHX9+UCAziPqvY+XTWyYsq3H7wXc4SH3YLYsDTi5Y4LAc7wt1H4OG915wtjHrIml0TE267YmU39IM5bn/VmMg5d+aDKMwsJIU910DIvYJrvZ1BjDZdCgUqT07Zb06AlJ7QbNuNj6fbyjKaskLLIxaoCE2TsUlTkQSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740926013; c=relaxed/simple;
	bh=C/xAItdObRhE+7CYDvFZUYp59fIC72o7p9syeQ2nR0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g21vFZeG6lN16xD5mU6Kg/6kwoUHMyKfuxn3LSlgN5X0xsdsaKoun+i4Y2UqenclGngW2jgXhi5NFSpEqZM2zimEswfrbhj2MiE1sr3zam7ie9BMDvEn72ZJl2NUhV+2vF6liG2ulTZe/91dRWiJ6oOMzCCeF+JChuwJY4M8WW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULTefDcm; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULTefDcm"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F418D4167A
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L3hM_E-bU9NK for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Mar 2025 14:33:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org ED53A41655
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED53A41655
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ULTefDcm
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED53A41655
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740926008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGq2Axvzt/J7qgw1KDrXhDAtkMcdMfmrQjoiox/FEqY=;
	b=ULTefDcmGWbdt0cBW1KP+p8/AOh7RypXyce+cNYkbyLZ7/JnZvvzym4rjAaaiQPIpp25wR
	4yY9jJohmTCHBZCxk1jIlDxqpLEf8B3Qi1aR6YDuiC5RyGctQf0h1WTl2N4LMUCBTj4OIY
	5sNwCug5TxkXbZzxE7dWMC6TsFau45U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-8Mwhey9yN2umJaXpiBKHVQ-1; Sun,
 02 Mar 2025 09:33:20 -0500
X-MC-Unique: 8Mwhey9yN2umJaXpiBKHVQ-1
X-Mimecast-MFC-AGG-ID: 8Mwhey9yN2umJaXpiBKHVQ_1740925999
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 098391944F04;
	Sun,  2 Mar 2025 14:33:19 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.49])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 752F21800359;
	Sun,  2 Mar 2025 14:33:14 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 1/8] vhost: Add a new parameter in vhost_dev to allow user select kthread
Date: Sun,  2 Mar 2025 22:32:03 +0800
Message-ID: <20250302143259.1221569-2-lulu@redhat.com>
In-Reply-To: <20250302143259.1221569-1-lulu@redhat.com>
References: <20250302143259.1221569-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The vhost now uses vhost_task and workers as a child of the owner thread.
While this aligns with containerization principles,it confuses some legacy
userspace app, Therefore, we are reintroducing kthread API support.

Introduce a new parameter to enable users to choose between
kthread and task mode.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 1 +
 drivers/vhost/vhost.h | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 63612faeab72..250dc43f1786 100644
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
index bb75a292d50c..19bb94922a0e 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -176,6 +176,15 @@ struct vhost_dev {
 	int byte_weight;
 	struct xarray worker_xa;
 	bool use_worker;
+	/*
+	 * If inherit_owner is true we use vhost_tasks to create
+	 * the worker so all settings/limits like cgroups, NPROC,
+	 * scheduler, etc are inherited from the owner. If false,
+	 * we use kthreads and only attach to the same cgroups
+	 * as the owner for compat with older kernels.
+	 * here we use true as default value
+	 */
+	bool inherit_owner;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
 };
-- 
2.45.0

