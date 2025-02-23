Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C883720CCCC
	for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325316; cv=none; b=gSgkWZJU+AYN49mmcSw6hOBR/Ky1RbSO0j3G/uOkU35Qr6sukbBxZIwvSFypBnESqDEm6TVNH2jj+Ray7inuSPD0Cv67L/WAzT83Yc3ifQlMlwEHbb4EYD2YP64CCWH+RDVdwDqqctBsthyn+dCJ8hYglB8pQEN6hS4zPUyXJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325316; c=relaxed/simple;
	bh=ZGGr8CpUC2KsJpl4JTjnc3CvTn1h9z7S+oOYdP7bE20=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qt+RDLxlNkDeWACPZu2ZUulk7B7J3Gv+HPkxksST+EAYEaE99YzzRgU8xeOf/7CU0SZoS4nAdyq1XWQXW1DOjUTD5xGQwL365mkZYsW6OZeVUW0A+4lBUPtcjWa+MElzqt4F9shUk5SyaaQ7E0FoPD5P5m428EjGL7IUzeVEGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ffkj0MM/; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ffkj0MM/"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61EC4403DA
	for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 15:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LY2rGnOiH1Mj for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Feb 2025 15:41:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 06A9C403A2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06A9C403A2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ffkj0MM/
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 06A9C403A2
	for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740325312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvywjBt9qiVEE9rGZyn5DkXXMEjJbM4TB/T7cbHYBEo=;
	b=Ffkj0MM/C4SAaRHKIe2Jr3MWTR9rGMGiFgZzHHyIT2Jh52qe7wDwjD1mrszn6Co+vJUBVT
	LcE7BP2Kbc4rHU1IOUARYFbkR9Fj9SFd1mQXW//AVFy/f3OlkheJzAF9wqdIgsBp6G+Y8L
	m2shsbUG94RRkffL38NU/jK2nE3KAGc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-B0X9Vo8lOo6-dJW4ojwo4g-1; Sun,
 23 Feb 2025 10:41:47 -0500
X-MC-Unique: B0X9Vo8lOo6-dJW4ojwo4g-1
X-Mimecast-MFC-AGG-ID: B0X9Vo8lOo6-dJW4ojwo4g_1740325304
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9510519783BA;
	Sun, 23 Feb 2025 15:41:44 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EEEE1800359;
	Sun, 23 Feb 2025 15:41:39 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 6/6] vhost: Add check for inherit_owner status
Date: Sun, 23 Feb 2025 23:36:21 +0800
Message-ID: <20250223154042.556001-7-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-1-lulu@redhat.com>
References: <20250223154042.556001-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The VHOST_NEW_WORKER requires the inherit_owner
setting to be true. So we need to add a check for this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 45d8f5c5bca9..26da561c6685 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1017,6 +1017,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 	switch (ioctl) {
 	/* dev worker ioctls */
 	case VHOST_NEW_WORKER:
+		/*
+		 * vhost_tasks will account for worker threads under the parent's
+		 * NPROC value but kthreads do not. To avoid userspace overflowing
+		 * the system with worker threads inherit_owner must be true.
+		 */
+		if (!dev->inherit_owner)
+			return -EFAULT;
 		ret = vhost_new_worker(dev, &state);
 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
 			ret = -EFAULT;
-- 
2.45.0

