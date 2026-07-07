Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707153FF1AC
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427126; cv=none; b=rrFyIAa9RNkpiUosYOAA1DsbDSOpycpvS8PKiknxPEVoONN1HeXU8lVXTcD1rb2tGcP3LGMuW8AEguAT4+Tq9/4eMqbogHxWkaVH/y5sUxQKASpwmPwYxM4cIwiCWiwkcTDn4sYCrOKGFkt9aPvRm7A9P79VP4WeBaWA71Wmj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427126; c=relaxed/simple;
	bh=3lxaF+7VCtmsazt4F+3vorTlxgGRgHmjmZx8fIwcd04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzfL6u+IJHnPWSP2NJKmAAoDwSH9llTBGdutJHlW58v2yBYBeTEAgqhBDfAxADL4hmBoMd5HhNYkxaK6BuCGejyp4xDxEZrN8JbW1jFhNCqnOLlFMeFHmB1fgV4GsLMulbaPQhLbua8UmGdWFSAMSQwn7MkTwf155DJtZiMGm1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbGFMJHd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbGFMJHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783427124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBpctdKYVTc/LKOb2bOo3jzpkOLQd99VjfqLAmqB4YA=;
	b=WbGFMJHdaG/1E3rRwvnzkIM4+3csMDpAq1h6IWBJU3jK64i3TTQ0QFZaLPrlavvO6Rb5Xa
	LMEgq3BB7JGQb6GfWYkpAOOU7poKZBepiRTPtkxU/7hm8rM47OH9sMs+ie8mDwK/zTXUdq
	YT5eNP1NFq8y+B0Nqsh6yvpdGOGB5js=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-61NOmIf5OJCdPSXMvvDvTg-1; Tue,
 07 Jul 2026 08:25:21 -0400
X-MC-Unique: 61NOmIf5OJCdPSXMvvDvTg-1
X-Mimecast-MFC-AGG-ID: 61NOmIf5OJCdPSXMvvDvTg_1783427120
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E119A1955D96;
	Tue,  7 Jul 2026 12:25:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA9241800595;
	Tue,  7 Jul 2026 12:25:16 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH v4 3/4] vduse: add VDUSE_SET_FEATURES ioctl
Date: Tue,  7 Jul 2026 14:25:01 +0200
Message-ID: <20260707122502.239022-4-eperezma@redhat.com>
In-Reply-To: <20260707122502.239022-1-eperezma@redhat.com>
References: <20260707122502.239022-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: m6xQYifi-pU4E_cpouuKBX08Oxdx-AdpRBl_-kgvEtw_1783427120
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an ioctl to allow VDUSE instances to set the VDUSE features
supported by the userland VDUSE instance.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v4: New in v4.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
 include/uapi/linux/vduse.h         |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index e1930e38df7a..4d561b9fbf5e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -160,6 +160,7 @@ struct vduse_dev_msg {
 
 struct vduse_control {
 	u64 api_version;
+	u64 vduse_features;
 };
 
 static DEFINE_MUTEX(vduse_lock);
@@ -2349,7 +2350,29 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 	case VDUSE_GET_FEATURES:
 		ret = put_user(vduse_features, (u64 __user *)argp);
 		break;
+	case VDUSE_SET_FEATURES: {
+		u64 features;
 
+		ret = -EFAULT;
+		if (get_user(features, (u64 __user *)argp)) {
+			dev_dbg(vduse_ctrl_dev, "Could not get vduse features");
+			break;
+		}
+
+		ret = -EINVAL;
+		if (features & ~vduse_features) {
+			dev_dbg(vduse_ctrl_dev,
+				"Invalid features in %llx, expected %llx",
+				features, vduse_features);
+			break;
+		}
+
+		ret = 0;
+		control->vduse_features = features;
+		dev_dbg(vduse_ctrl_dev, "Set features %llx", features);
+
+		break;
+	}
 	default:
 		ret = -EINVAL;
 		break;
@@ -2376,6 +2399,7 @@ static int vduse_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	control->api_version = VDUSE_API_VERSION_NOT_ASKED;
+	control->vduse_features = 0;
 	file->private_data = control;
 
 	return 0;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 89aa3b448c0a..f14c965bb7f6 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -66,6 +66,9 @@ struct vduse_dev_config {
 /* Get the VDUSE supported features */
 #define VDUSE_GET_FEATURES	_IOR(VDUSE_BASE, 0x04, __u64)
 
+/* Set the VDUSE features */
+#define VDUSE_SET_FEATURES	_IOW(VDUSE_BASE, 0x05, __u64)
+
 /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
 
 /**
-- 
2.55.0

