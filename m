Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841CB3C3BE9
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169698; cv=none; b=T7GtrK6latS2hvPEcIqqV0bJ4e7fPMd5aAPWwlpzwG9xIyprfpb+pY9zqjOOT6X93V2AdgNdDrnLZnn6Q//QJT9r1MYwlm4Pe0jXD9MoYtZe6/ZStMaR4f9HuLl7KptI9sQe5ncM6XBEOb4fVHlsO0y5mWtLl0Sm5FLbEun+LhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169698; c=relaxed/simple;
	bh=ncC/iKjULSF6le8tRXIlP7leZiC3yrangGbjJey/sMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZojvSA7p/+GSX6eE6Tb+S+PbajDVjkF0vfybWbqYgWl2DAxNfDxeEpYEX+FAQFzotWpUviGiC3P0bBrC6YZHjPD/ZVO94Uh1TcTq+/cjVgB02V2Zh60mwMf7qknpJQ7D5J4QHT0nZcwj4kFkgPS+1igIb7Ap22WzFyGTMmkGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FP6RULP1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FP6RULP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773169696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVibb6yQ9XHTIlzDSmdiJcpXSy41pi5u06RNTpNQkTA=;
	b=FP6RULP1KhZx+el6okgnkV/7dSudYS6ofhRGrDw9D0wSfBX4vweelkSMcNyIUUuU0ziu27
	k3X1mM80GYqBEXnbioKpF4J+y41b2aNz8MWSIYgIzqxc47Dror30ooDuG8b8UCWiX9ZVBV
	yKp4dUS/IqSSxl+2XX+sGGhdMJE1Px4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-Urv9Ocu_PtWg8W8els8ONQ-1; Tue,
 10 Mar 2026 15:08:15 -0400
X-MC-Unique: Urv9Ocu_PtWg8W8els8ONQ-1
X-Mimecast-MFC-AGG-ID: Urv9Ocu_PtWg8W8els8ONQ_1773169693
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2471C19560A7;
	Tue, 10 Mar 2026 19:08:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.202])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9BA313000223;
	Tue, 10 Mar 2026 19:08:09 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v3 2/3] vduse: add VDUSE_GET_FEATURES ioctl
Date: Tue, 10 Mar 2026 20:07:58 +0100
Message-ID: <20260310190759.1097506-3-eperezma@redhat.com>
In-Reply-To: <20260310190759.1097506-1-eperezma@redhat.com>
References: <20260310190759.1097506-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: RrjCdfV76ukQbHHBl4iUnRf95d0z6ddF_OPcqRgBSzE_1773169693
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an ioctl to allow VDUSE instances to query the available features
supported by the kernel module.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
A simple u64 bitmap is used for feature flags. While a flexible array
could support indefinite expansion, 64 bits is sufficient for the
foreseeable future and simplifies the implementation.

Also, dev_dbg is used for logging rather than dev_err as these can be
triggered from userspace.
---
v3:
* Remove check for API_VERSION < 2
* Add comment about struct vduse_dev_config:vduse_features is only valid
  if VDUSE_GET_FEATURES success.

v2:
* return -EINVAL if ioctl called with version < 2, so userland visible
  reply is kept (Jason).
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
 include/uapi/linux/vduse.h         | 7 ++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d1da7c15d98b..17e0358d3a68 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -52,6 +52,9 @@
 
 #define IRQ_UNBOUND -1
 
+/* Supported VDUSE features */
+static const uint64_t vduse_features;
+
 /*
  * VDUSE instance have not asked the vduse API version, so assume 0.
  *
@@ -2207,6 +2210,10 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 		ret = vduse_destroy_dev(name);
 		break;
 	}
+	case VDUSE_GET_FEATURES:
+		ret = put_user(vduse_features, (u64 __user *)argp);
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 361eea511c21..e9b5f32a452d 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -33,6 +33,7 @@
  * @vq_align: the allocation alignment of virtqueue's metadata
  * @ngroups: number of vq groups that VDUSE device declares
  * @nas: number of address spaces that VDUSE device declares
+ * @vduse_features: VDUSE features
  * @reserved: for future use, needs to be initialized to zero
  * @config_size: the size of the configuration space
  * @config: the buffer of the configuration space
@@ -49,7 +50,8 @@ struct vduse_dev_config {
 	__u32 vq_align;
 	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
 	__u32 nas; /* if VDUSE_API_VERSION >= 1 */
-	__u32 reserved[11];
+	__u64 vduse_features; /* if VDUSE_GET_FEATURES is not EINVAL */
+	__u32 reserved[9];
 	__u32 config_size;
 	__u8 config[];
 };
@@ -63,6 +65,9 @@ struct vduse_dev_config {
  */
 #define VDUSE_DESTROY_DEV	_IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_MAX])
 
+/* Get the VDUSE supported features */
+#define VDUSE_GET_FEATURES	_IOR(VDUSE_BASE, 0x04, __u64)
+
 /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
 
 /**
-- 
2.53.0

