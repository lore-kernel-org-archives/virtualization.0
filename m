Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73721ABA6
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156262; cv=none; b=cFWnAA9SxcW/XV0yw4mXK+V4QHxZH8vlG0Gxtu91GrhGdYwDsTEJAUbvURLCiHU1rGuN21qS44VWsqffB5suwwNLpjdRStCjM6K1ogtjwfuB3kEupxp4q6foa9mdCNWTZeH3K+S0zJ8QA1e7CRmHpez8PdK4KH4JLLOz8MQBCNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156262; c=relaxed/simple;
	bh=C/xAItdObRhE+7CYDvFZUYp59fIC72o7p9syeQ2nR0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ke5J1EH06KvZMcNDnZSPQ5jp5nXEha6eIMLumvYI/t6Rh0e/dxlsHiDU6Ul2dvT8CkeQOUQhE2q+Dd9aAzROVrnQNZ9SY5bjUDB1ORkdqSgsLI9hcZUKd5E7NSS4Ztp4Imfk7zJaeqYXDn6CYLLssdB/714DPt3A1C5Pxn8QLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eo+LWplz; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eo+LWplz"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30A9E60A79
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jfjYE1TPSsM5 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Mar 2025 10:04:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9143C60790
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9143C60790
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eo+LWplz
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9143C60790
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743156259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGq2Axvzt/J7qgw1KDrXhDAtkMcdMfmrQjoiox/FEqY=;
	b=Eo+LWplzQNuM0r3oV/ELdXtTfGdojaqa4EF0mY2At04DKjfP5lP3oouFc7AUcSX299Tbn5
	I0IVYUoG05EuTH5yuU/HZZr1A9JNwj4dIGhBsPigXIHCD8asdmz7bjlEa35bWigmUZN25D
	yv/brm/nCpfDF7ZjKgNthkGm67DEOEI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-kgUX-GweNkS1Jx_ECWbkaw-1; Fri,
 28 Mar 2025 06:04:16 -0400
X-MC-Unique: kgUX-GweNkS1Jx_ECWbkaw-1
X-Mimecast-MFC-AGG-ID: kgUX-GweNkS1Jx_ECWbkaw_1743156255
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E9BB180AF4D;
	Fri, 28 Mar 2025 10:04:15 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84A8430001A1;
	Fri, 28 Mar 2025 10:04:10 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 1/8] vhost: Add a new parameter in vhost_dev to allow user select kthread
Date: Fri, 28 Mar 2025 18:02:45 +0800
Message-ID: <20250328100359.1306072-2-lulu@redhat.com>
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

