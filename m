Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74B1AB6C8
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562756; cv=none; b=Jkvz9H3cL0zWkI/2pg0NeXNot+u0OpWy0RSYDkCcAYWmmhvuPsWjIhZ0BXVvgtdZUMkX0wL7n/Ogf71GyuJyx9StN4dq3nM8p/AdUoEJMnv7b2Q/dN8P+CRWB8SYYsl/sXuWrKF/AGIMaifJ5MLWGuHlTd/9mV39whRMwr3ToOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562756; c=relaxed/simple;
	bh=ya0jLzzyRV4JPRzvVhGgoWSL9yvZjTh8Fu2M3ibVj+k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+QH6q0aKOGyTaOQTcJZixQy3UVph1+K3EaigX/bVilvGbkaKDOjH+qX5qt9kpaFu92/fOUQuoo4JEEjlUEGXQwIOKxXk2xq0eCLB9UVS4bC/u92ResDQj9YGfSoFGk2a1GWeWyO9L9oKISRH1WX16u+ur95TEi3Uyj1mPYMjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEVdY35s; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEVdY35s"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65FE2805A3
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNcBRQJlF-s7 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Dec 2024 12:45:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 98DDF8059C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98DDF8059C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hEVdY35s
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 98DDF8059C
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xX4qyypEHsNe4ER87SJ3OZmlnLp0lW0wrG4GS+lDAg=;
	b=hEVdY35s3g+5YngV62wKR8yXz9L6kDnRdoCUDveRnP468IWFbGyubsDQKxwHcSERtSlB4g
	wdgjUDxKQKIWHQFY0Y5jojbA161QRYJhKD46EyrfckdguW5WLn7Duazqos94CQThRC21qy
	zVvIuGUNf+MpEQVC+LXw730lLj8b92Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-I1gdlmexNoqjr8Xbbmryxw-1; Mon,
 30 Dec 2024 07:45:50 -0500
X-MC-Unique: I1gdlmexNoqjr8Xbbmryxw-1
X-Mimecast-MFC-AGG-ID: I1gdlmexNoqjr8Xbbmryxw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B5361956055;
	Mon, 30 Dec 2024 12:45:49 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DC3C19560A2;
	Mon, 30 Dec 2024 12:45:44 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 6/6] vhost_scsi: Add check for inherit_owner status
Date: Mon, 30 Dec 2024 20:43:53 +0800
Message-ID: <20241230124445.1850997-7-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-1-lulu@redhat.com>
References: <20241230124445.1850997-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The vhost_scsi VHOST_NEW_WORKER requires the inherit_owner
setting to be true. So we need to implement a check for this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/scsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 718fa4e0b31e..0d63b6b5c852 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2086,6 +2086,14 @@ vhost_scsi_ioctl(struct file *f,
 			return -EFAULT;
 		return vhost_scsi_set_features(vs, features);
 	case VHOST_NEW_WORKER:
+		/*
+		 * vhost_tasks will account for worker threads under the parent's
+		 * NPROC value but kthreads do not. To avoid userspace overflowing
+		 * the system with worker threads inherit_owner must be true.
+		 */
+		if (!vs->dev.inherit_owner)
+			return -EFAULT;
+		fallthrough;
 	case VHOST_FREE_WORKER:
 	case VHOST_ATTACH_VRING_WORKER:
 	case VHOST_GET_VRING_WORKER:
-- 
2.45.0

