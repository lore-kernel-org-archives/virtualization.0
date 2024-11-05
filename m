Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003620011B
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791687; cv=none; b=qKFFyqPo3uI1POLJ+V68+tuhL/T0KfJ0xTW4EhhQFE+lkbbDybbYYCpQMgXlcjjLL+IIwpW98HPE0iQ474+gRYnWh6PQOVTSQYIkbR+mMzN120DUtJs7eZ21NpIZpZHT+AD52zoQTRdfsZAiGB+l8Mnu5xaCYg+FLLeH4zJsxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791687; c=relaxed/simple;
	bh=0QdkBtKjMzdIS7SqrchG9JRhfPNterDTSKj/TM/P8mg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edPcch0o7bVbSJkh7cad/RTv7C8IqDSdt46gsljL9wwsbn8iBAUJzWwIflAyTD3tdeOIE6la9R3qkNAbD2fdjOqOR4AsRH2e9p0fMQrBMoiPd5e1DwoCEQZ93i59HQ/40iaDPrg/UbPT/z1fhtVEc3VjVEtRKBmcAbPU/GSBuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayY8RUKT; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayY8RUKT"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 539D780E4A
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 847UoB4CFxrf for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 07:28:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 85AD680DBB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85AD680DBB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ayY8RUKT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 85AD680DBB
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9eokZY2fqQ9vuKBZvQW4V7mmsdAb7yocXzqh175Di8=;
	b=ayY8RUKT8mF+IIp0It0WzOI9U35OLMtXFgJH6juAM+d0M0iRwc/boj5gDBIAbohTl5bjmJ
	oFaTf5v25/aicAKPzUrnvhx4GOwbBHOr6H6EqmQpxDYlPC88NbJNvAEGzNqMq2Kp0RYtkY
	jE5rqoZBZ37JFgUl7Yskp5/xXOMWHSM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-drmJyLkFOAOKSnWYvp1LDA-1; Tue,
 05 Nov 2024 02:28:01 -0500
X-MC-Unique: drmJyLkFOAOKSnWYvp1LDA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C58C1955EE6;
	Tue,  5 Nov 2024 07:28:00 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B15971956086;
	Tue,  5 Nov 2024 07:27:55 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
Date: Tue,  5 Nov 2024 15:25:26 +0800
Message-ID: <20241105072642.898710-8-lulu@redhat.com>
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

Add a new UAPI to enable setting the vhost device to task mode.
The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
to configure the mode if necessary.
This setting must be applied before VHOST_SET_OWNER, as the worker
will be created in the VHOST_SET_OWNER function

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c      | 15 ++++++++++++++-
 include/uapi/linux/vhost.h |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c17dc01febcc..70c793b63905 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 {
 	struct eventfd_ctx *ctx;
 	u64 p;
-	long r;
+	long r = 0;
 	int i, fd;
+	bool inherit_owner;
 
 	/* If you are not the owner, you can become one */
 	if (ioctl == VHOST_SET_OWNER) {
@@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		if (ctx)
 			eventfd_ctx_put(ctx);
 		break;
+	case VHOST_SET_INHERIT_FROM_OWNER:
+		/*inherit_owner can only be modified before owner is set*/
+		if (vhost_dev_has_owner(d))
+			break;
+
+		if (copy_from_user(&inherit_owner, argp,
+				   sizeof(inherit_owner))) {
+			r = -EFAULT;
+			break;
+		}
+		d->inherit_owner = inherit_owner;
+		break;
 	default:
 		r = -ENOIOCTLCMD;
 		break;
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

