Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983754767
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728007245; cv=none; b=a8Pi26+NF9ON1UTrHN2Jyd2r8B/vsZhdycU1DZWvsTAARcZhchdsitTpDnsInYNZZKr0t05HdxCSeWcixNVw3BAZ31XIwEpupW0TNRZBjCOjz7E7vCeZLlNl1mX1H1qvGcv5Yb17NbWKWxGVtSm5WeGiSYS5I0k4WGuPioYTLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728007245; c=relaxed/simple;
	bh=gM+UhBnXUXjuBqKMUIBkJEkaZoSzsbYH910Eh3g1cjY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8U01JHikYdBPCrcml2E4uu59dIp51bJ8KNZTHZwCyBymY+9n7Un6YhPZEUDuDyDX9UUBZa91rxF7iUsmW4J+0v+oMEL+VvZSpO25ShAGjjcifjofEfpS8pi2mx3+eySxXTlJH5BnnxRNgGot9g4Em2QGQ4sLmx/OKIfiBEUCRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eocWnYT+; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eocWnYT+"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D30AE84149
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 02:00:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J9y5TkCA-Pp2 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Oct 2024 02:00:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 26C09840A2
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26C09840A2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eocWnYT+
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 26C09840A2
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 02:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728007242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubHS+/4Up+CXlv+MFQxp5V5OJdlnjpJuzakK52oVNZ0=;
	b=eocWnYT+1KD5Y1295R/UU0Gx3AWfRBg4E7VL6I6zAb6hTPQ/7+h6mJuM1iTh+Uq8BQWtTd
	P3Rzz2pMn0oZwi5mco5kGWb925/apy9TC64SF9+EETfuLK8PoOFvgMfb4iAT3vJy85BL/F
	NNpdzgrFDYTf42mUoeBAXulODojH6cw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-jfNAovzgPhyIIdrDehespw-1; Thu,
 03 Oct 2024 22:00:38 -0400
X-MC-Unique: jfNAovzgPhyIIdrDehespw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99D9A195608A;
	Fri,  4 Oct 2024 02:00:37 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EC3C19560A2;
	Fri,  4 Oct 2024 02:00:33 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 7/7] vhost: Add new UAPI to support change to task mode
Date: Fri,  4 Oct 2024 09:58:21 +0800
Message-ID: <20241004015937.2286459-8-lulu@redhat.com>
In-Reply-To: <20241004015937.2286459-1-lulu@redhat.com>
References: <20241004015937.2286459-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a new UAPI to support setting the vhost device to
use task mode. The user space application needs to use
VHOST_SET_INHERIT_FROM_OWNER to set the mode.
This setting must be set before VHOST_SET_OWNER is set.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c      | 18 +++++++++++++++++-
 include/uapi/linux/vhost.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 08c9e77916ca..0e5c81026acd 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2341,8 +2341,24 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 {
 	struct eventfd_ctx *ctx;
 	u64 p;
-	long r;
+	long r = 0;
 	int i, fd;
+	bool inherit_owner;
+
+	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
+		/* Is there an owner already? */
+		if (vhost_dev_has_owner(d)) {
+			r = -EBUSY;
+			goto done;
+		}
+		if (copy_from_user(&inherit_owner, argp,
+				   sizeof(inherit_owner))) {
+			r = -EFAULT;
+			goto done;
+		}
+		enforce_inherit_owner = inherit_owner;
+		goto done;
+	}
 
 	/* If you are not the owner, you can become one */
 	if (ioctl == VHOST_SET_OWNER) {
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..1e192038633d 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,6 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
 #endif
-- 
2.45.0

