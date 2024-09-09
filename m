Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776B210E4
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847380; cv=none; b=Yxt8XeL1yxDYr0IGyiRG+06V2KXpgjc2yXXGbvdid6giuekK/ozLHnX4FzI92FT9DIwMtIQOJ4QoskVohCN8gKTn7oLpYJpTH3bLliorySIAEkenBQlIuBE+nHV8MD0Ipc34KF8iGlu/n2Nb5YPDU7t5Fpb7nu7JgPWD3sttENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847380; c=relaxed/simple;
	bh=7/6gyxcweF78Fjvy/O/QlpRmVVa60Z+0o2DI85aQcUo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUIfHlqmIip02Resbs4gQqngRNFPc34A98rMK2EffLDyHJvfjzzp15nN10oNmC2NJnAsTjdFCt+DYYnRYwG7yfTmNlrO9qTX+EqfZZt0iEtXBClTOaeQaMlb6xpnjLODzWAADpH+2FNCRijJi7dex0oa9eMOgtlPTTkpiYTBGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSKiypKL; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSKiypKL"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E966401D8
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZe0pJtVB1ON for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Sep 2024 02:02:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 48314401C2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48314401C2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KSKiypKL
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48314401C2
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725847375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUQqKbxzWXipVdkbA2+5Zzkiohl4zLF2jPmYXNJwL9s=;
	b=KSKiypKLrxU3j2bQXaWpwMW35+5Kns2rBcmZpNAteMIkyyQLnbAIDdt+NQqhH0vmtUbtcD
	YK5n+H8c5y2plU/FFz+I24gSugNwd9oNWXkyVFDIcym+f5lYsL5ZtDZxHKKyFEO9pP+MC+
	tqhGR1vk4elQGwnBjIOBnJdQQla1NTs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-dbXyhr2mNs2jntQsUSC6Xw-1; Sun,
 08 Sep 2024 22:02:52 -0400
X-MC-Unique: dbXyhr2mNs2jntQsUSC6Xw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53BBB19560BC;
	Mon,  9 Sep 2024 02:02:50 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 321CE1956086;
	Mon,  9 Sep 2024 02:02:45 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RESEND PATCH v1 7/7] vhost: Add new UAPI to support change to task mode
Date: Mon,  9 Sep 2024 10:00:45 +0800
Message-ID: <20240909020138.1245873-8-lulu@redhat.com>
In-Reply-To: <20240909020138.1245873-1-lulu@redhat.com>
References: <20240909020138.1245873-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add a new UAPI to support setting the vhost device to
use task mode. The user space application needs to use
VHOST_SET_ENFORCE_TASK to set the mode. This setting must
be set before VHOST_SET_OWNER is set.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c      | 16 +++++++++++++++-
 include/uapi/linux/vhost.h |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 838bce29a98b..8fd19a1489e0 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2340,14 +2340,28 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 {
 	struct eventfd_ctx *ctx;
 	u64 p;
-	long r;
+	long r = 0;
 	int i, fd;
+	bool enforce_task;
 
 	/* If you are not the owner, you can become one */
 	if (ioctl == VHOST_SET_OWNER) {
 		r = vhost_dev_set_owner(d);
 		goto done;
 	}
+	if (ioctl == VHOST_SET_ENFORCE_TASK) {
+		/* Is there an owner already? */
+		if (vhost_dev_has_owner(d)) {
+			r = -EBUSY;
+			goto done;
+		}
+		if (copy_from_user(&enforce_task, argp, sizeof(enforce_task))) {
+			r = -EFAULT;
+			goto done;
+		}
+		enforce_kthread = !enforce_task;
+		goto done;
+	}
 
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..9853d62d2d34 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,6 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+#define VHOST_SET_ENFORCE_TASK _IOW(VHOST_VIRTIO, 0x83, bool)
 #endif
-- 
2.45.0

