Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA63D5679
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427121; cv=none; b=fDcNuTg1M29vgQtNPkqykiR6Pdt+OeESY78Kqxs7g1Y2YFhxiIQ7it6aRnnp/R1oJ0c11UdJqBENIc3RVALB8Wz0pjLbmZprDJW74qjBIHerfy8XtSjOALz98f93oT9fSOSRpQ5tgl1cX7EBiquudVyq8cBn3yG5OTWBNkZWroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427121; c=relaxed/simple;
	bh=xGVue4prjPuwHSp+TWmfPc48xwD98WKLWJkN3Qn/My8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRp2d5ksJD3P2uztSKTE2DA4cgWHm/6XP4vOFdRhbb5r7JyppRReKOFr6J/sFIhvgUBvd6BplaqZ6uPjetwSc7nmGjLHHoEsVHVLMmBfouqj/kDsXkaz6Y6rhOWgDPhwsNljVgyq/f/XOj18eai/lsyNS8KIfKiVzuC23LqFKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMHdlK6/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMHdlK6/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783427119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FjL2+mrQcUXOo48bEv7APPovoqwGDFXoAN5/mmpKnAg=;
	b=jMHdlK6/5FHczceCGXXYHad/u0yQN3l+hKB6FM+8KU7JtfQ+s51ZqDpYYUR/2gBqxxsUVq
	XsXoGHrsyZlIdOyDOxeV+tZRi+xRz5Q1GLrXL3KYnfz8Fxlf8DzqmbXSBqiIqHl7kCunVM
	pI8C46J324k4YlBPvEfChXiija5ZDUs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-kVmRnhC1OwayDaQWb3UUoQ-1; Tue,
 07 Jul 2026 08:25:17 -0400
X-MC-Unique: kVmRnhC1OwayDaQWb3UUoQ-1
X-Mimecast-MFC-AGG-ID: kVmRnhC1OwayDaQWb3UUoQ_1783427116
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E3CD195411F;
	Tue,  7 Jul 2026 12:25:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71DAC18005B5;
	Tue,  7 Jul 2026 12:25:12 +0000 (UTC)
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
Subject: [PATCH v4 2/4] vduse: add VDUSE_GET_FEATURES ioctl
Date: Tue,  7 Jul 2026 14:25:00 +0200
Message-ID: <20260707122502.239022-3-eperezma@redhat.com>
In-Reply-To: <20260707122502.239022-1-eperezma@redhat.com>
References: <20260707122502.239022-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 4YC1oON2vM_W480ftyMQ000cS9FVPtu17F7O3GORfnY_1783427116
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an ioctl to allow VDUSE instances to query the available features
supported by the kernel module.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v4:
* Store the features in VDUSE control instead of vduse device config.

v3:
* Remove check for API_VERSION < 2
* Add comment about struct vduse_dev_config:vduse_features is only valid
  if VDUSE_GET_FEATURES success.

v2:
* return -EINVAL if ioctl called with version < 2, so userland visible
  reply is kept (Jason).
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
 include/uapi/linux/vduse.h         | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 2af5cb5e1ec6..e1930e38df7a 100644
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
@@ -2343,6 +2346,10 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
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
index 361eea511c21..89aa3b448c0a 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -63,6 +63,9 @@ struct vduse_dev_config {
  */
 #define VDUSE_DESTROY_DEV	_IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_MAX])
 
+/* Get the VDUSE supported features */
+#define VDUSE_GET_FEATURES	_IOR(VDUSE_BASE, 0x04, __u64)
+
 /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
 
 /**
-- 
2.55.0

