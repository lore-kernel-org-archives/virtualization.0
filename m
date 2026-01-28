Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40C33D51D
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604355; cv=none; b=PaYDiXWra33Azy8lqrOjCn7xg97pWbON3KP5XmyNg6ypyjf33MHKmYhPs4dmr6MAJ7qlVXRPtFMmqcIal8w95h16n18RTmn4eMcgFDfD0Iab9CheNu7nARnUXv5RK64bEtFUiVnhA8gV+Or7fm9deSJMIXOLBc/5j8Tix1Pxbak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604355; c=relaxed/simple;
	bh=C8DivxRRg8E3jNAOaDJgWJW4bb7VflNyrM3SCd6jm4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StFhYOphx5bb2qumBPqVL4rtg2ELsT6nQHz+JSR9cURIdZzEmVhWzdNr/0V3kWKlKx9IdG0rsEsm6cS0FFLomH68id2l0oV1oKWYaC6OcZJjWhXYIG0L/pRYo2Wa8pXRvkqlidebyfk5SWuTjoSzhPKL1Pk6nGpm5vnSefrDG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aH97i1l4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aH97i1l4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769604353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IBjYw3BhrBWMRTseZ9M3Gp4FTwThD/kWjxbEDJtfBo=;
	b=aH97i1l4dnUi0q/dPBES99EL/PkuymblktRbdHjxCyxAdfcwSvzfqvj8yr+GvGXhAboSWV
	v/7O5jR3YUyGrHVSpHGKftsKdstcSq+vk0wAcUs37S2DWj/CF+Y2KqSc8aFIDd4TLU3V7D
	7idSzxst6egRlRy2+QLxVyakACkB/B0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-Wq0W4mVnOPSbWsxFuYq6cQ-1; Wed,
 28 Jan 2026 07:45:49 -0500
X-MC-Unique: Wq0W4mVnOPSbWsxFuYq6cQ-1
X-Mimecast-MFC-AGG-ID: Wq0W4mVnOPSbWsxFuYq6cQ_1769604348
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF6B81944B0C;
	Wed, 28 Jan 2026 12:45:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.239])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AE6530001A2;
	Wed, 28 Jan 2026 12:45:44 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 4/6] vduse: add VDUSE_GET_FEATURES ioctl
Date: Wed, 28 Jan 2026 13:45:22 +0100
Message-ID: <20260128124524.875271-5-eperezma@redhat.com>
In-Reply-To: <20260128124524.875271-1-eperezma@redhat.com>
References: <20260128124524.875271-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/vduse.h         |  7 ++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 551ccde0b856..e7da69c2ad71 100644
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
@@ -1977,6 +1980,19 @@ static bool vduse_validate_config(struct vduse_dev_config *config,
 			 sizeof(config->reserved)))
 		return false;
 
+	if (api_version < VDUSE_API_VERSION_2) {
+		if (config->vduse_features) {
+			dev_dbg(vduse_ctrl_dev,
+				"config->vduse_features with version %llu",
+				api_version);
+			return false;
+		}
+	} else {
+		if (config->vduse_features & ~vduse_features)
+			return false;
+	}
+
+
 	if (api_version < VDUSE_API_VERSION_1 &&
 	    (config->ngroups || config->nas))
 		return false;
@@ -2237,6 +2253,18 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 		ret = vduse_destroy_dev(name);
 		break;
 	}
+	case VDUSE_GET_FEATURES:
+		if (control->api_version < VDUSE_API_VERSION_2) {
+			dev_dbg(vduse_ctrl_dev,
+				"VDUSE_GET_FEATURES ioctl with version %llu",
+				control->api_version);
+			ret = -ENOIOCTLCMD;
+			break;
+		}
+
+		ret = put_user(vduse_features, (u64 __user *)argp);
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index dea89ed281a7..1f68e556cbf2 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -37,6 +37,7 @@
  * @vq_align: the allocation alignment of virtqueue's metadata
  * @ngroups: number of vq groups that VDUSE device declares
  * @nas: number of address spaces that VDUSE device declares
+ * @vduse_features: VDUSE features
  * @reserved: for future use, needs to be initialized to zero
  * @config_size: the size of the configuration space
  * @config: the buffer of the configuration space
@@ -53,7 +54,8 @@ struct vduse_dev_config {
 	__u32 vq_align;
 	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
 	__u32 nas; /* if VDUSE_API_VERSION >= 1 */
-	__u32 reserved[11];
+	__u64 vduse_features;
+	__u32 reserved[9];
 	__u32 config_size;
 	__u8 config[];
 };
@@ -67,6 +69,9 @@ struct vduse_dev_config {
  */
 #define VDUSE_DESTROY_DEV	_IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_MAX])
 
+/* Get the VDUSE supported features */
+#define VDUSE_GET_FEATURES	_IOR(VDUSE_BASE, 0x04, __u64)
+
 /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
 
 /**
-- 
2.52.0

