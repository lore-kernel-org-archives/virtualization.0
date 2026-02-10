Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6344033D50A
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711978; cv=none; b=XO06YltXoJJuoUStjA+iE6C4+tseOImuS5B/J5IukfvA6myqTQOGBbH4/Vifx284fFAzZPVkjRsKgLIgjxxIMRe2PYqPEq4AekvRI8XDx5CdwuxRGEkujrOtWQZwzvjyEWESoDV8BQYVM+y6uegh1b3IVGlBsJsoKwMg06Je8rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711978; c=relaxed/simple;
	bh=74MZVn7IxdvrPRI+5RAG0362lJCruAXzOxMjv+8PuFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6Ah9FhxjpjSUwVwS89vs5Sho3gG3GXAa3HIoTfj5t0tfCwOMnIw+gQo1MAdhQFpouzi49UHRuF03Qwu6gzlbmGVoDs6QOEQghPTDoqOKLjDNgkhYyl3oYpQB8hisrq2unCNVK+tjlxTc5dlJelWmLRnky3tp9/iwSDRC51+bpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFMp7iQB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFMp7iQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770711976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXkbIk+MRQpozZHZOxnmkVlermPLHnywx/svL09mSpM=;
	b=SFMp7iQBA8qeBqi1uepbsDd6Y97HhXFzBAv92zs248DSorRTy/iwEk1dBaIqptzrQB8MrP
	ro+oWk2mzEjalMmgsNyCCiel0OqDAEOm8Fh+CFY7uOUvB8dy+HKnmr5qLXM1jAjIDkoYUc
	TgIzseS1OU4kpaKGAsa7qqX2aMtjiG4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-DdA4cB3WMzmlkC4ACyfiOQ-1; Tue,
 10 Feb 2026 03:26:15 -0500
X-MC-Unique: DdA4cB3WMzmlkC4ACyfiOQ-1
X-Mimecast-MFC-AGG-ID: DdA4cB3WMzmlkC4ACyfiOQ_1770711974
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FFD51955DC3;
	Tue, 10 Feb 2026 08:26:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07AF41956053;
	Tue, 10 Feb 2026 08:26:09 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2 3/5] vduse: add VDUSE_GET_FEATURES ioctl
Date: Tue, 10 Feb 2026 09:25:52 +0100
Message-ID: <20260210082554.1582553-4-eperezma@redhat.com>
In-Reply-To: <20260210082554.1582553-1-eperezma@redhat.com>
References: <20260210082554.1582553-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Kc2S06M1mAz3wygpOScCygwIC2xcqhEQIyc-wUe5dTE_1770711974
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
v2:
* return -EINVAL if ioctl called with version < 2, so userland visible
  reply is kept (Jason).
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/vduse.h         |  7 ++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d1da7c15d98b..7458cbaed4c7 100644
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
@@ -1947,6 +1950,19 @@ static bool vduse_validate_config(struct vduse_dev_config *config,
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
@@ -2207,6 +2223,18 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 		ret = vduse_destroy_dev(name);
 		break;
 	}
+	case VDUSE_GET_FEATURES:
+		if (control->api_version < VDUSE_API_VERSION_2) {
+			dev_dbg(vduse_ctrl_dev,
+				"VDUSE_GET_FEATURES ioctl with version %llu",
+				control->api_version);
+			ret = -EINVAL;
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
index 27832d46084c..8898d9daa777 100644
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
2.53.0

