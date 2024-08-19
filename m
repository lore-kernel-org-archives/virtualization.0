Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706C163AA7
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059802; cv=none; b=PCgWThUDAVvk0ER/EUDH+TOLgRztsuji0qoKQBno7cX1bgRtzK6GUVZJ4xUJwnifR8Cvyj2cRRVAtGIdeGD7/nRCPbFSQ5a5mPy92K1DwpXOT1CIn5ZVMp58qZYCHV8zUjBKgBuMjIkPUGRpv6PJNwy/dlYX4QiokeA6I0JngTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059802; c=relaxed/simple;
	bh=JqTw+gimEBK2T1Y5GytfqaF/hsyvkel0HokYkqbxXuI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4Wd5mWaVzskWAfnyYGnTmM47yJ3TwZqTZJ6MNHLRZaBalMymfvE+nMfdGILlAR2sGafrT+djeEiB2fZGwJSdKR/gc88XhrQ+ViFxLg60JU+LEZtkc3v6TVewneRJnvKP3wDmsryxMb2lDIV9/qi91Wp93ea0hrjLMz/enf2NEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9Ua7SFE; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9Ua7SFE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DAE9605B1
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQ_boeh5BqRY for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Aug 2024 09:30:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7CC80600B9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CC80600B9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e9Ua7SFE
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7CC80600B9
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724059799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETsgpKbPtWULjBo2gaCD6rFNqT/vhyWhAo8UmZ8FOuk=;
	b=e9Ua7SFE7Ss/CXWisHunm7o1qj0GLZEm4Zyx948WrpWE+YJzL+E5MCZvWe/zQuS+mLbTrL
	TQnoSGEXlbLBu2P6E8p0fdpiWMcCrVDuHWbWU4v6ZdFsxQLoaubnDiDzrupL9+N6NIcSCo
	mch0PvzJhwviy3m+FzrDoK0L3QPq47c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-WYpDt3yrM9eQ0kKKvQkc-w-1; Mon,
 19 Aug 2024 05:29:52 -0400
X-MC-Unique: WYpDt3yrM9eQ0kKKvQkc-w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70FC71954128;
	Mon, 19 Aug 2024 09:29:51 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 648601956054;
	Mon, 19 Aug 2024 09:29:47 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
Date: Mon, 19 Aug 2024 17:27:33 +0800
Message-ID: <20240819092851.441670-8-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-1-lulu@redhat.com>
References: <20240819092851.441670-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add a new UAPI to support setting the vhost device to
use kthread mode. The user space application needs to use
VHOST_SET_USE_KTHREAD to set the mode. This setting must
be set before VHOST_SET_OWNER is set.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c      | 11 ++++++++++-
 include/uapi/linux/vhost.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 0a7b2999100f..d6b71bddc272 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2340,14 +2340,23 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 {
 	struct eventfd_ctx *ctx;
 	u64 p;
-	long r;
+	long r = 0;
 	int i, fd;
+	bool kthread;
 
 	/* If you are not the owner, you can become one */
 	if (ioctl == VHOST_SET_OWNER) {
 		r = vhost_dev_set_owner(d);
 		goto done;
 	}
+	if (ioctl == VHOST_SET_USE_KTHREAD) {
+		if (copy_from_user(&kthread, argp, sizeof(kthread))) {
+			r = -EFAULT;
+			goto done;
+		}
+		use_kthread = kthread;
+		goto done;
+	}
 
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..386fe735da63 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,6 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+#define VHOST_SET_USE_KTHREAD _IOW(VHOST_VIRTIO, 0x83, bool)
 #endif
-- 
2.45.0

