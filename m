Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892D286405
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572356; cv=none; b=qCSNfPtQNgXVh17RavFjKRwrEpCE/OnXtKDMr4DhTb2mo7mfnGdk+mPZozf5ovkq8WfjhId4QJh0RDj2WlwDPt2+io+ANMJiogbusCI5rgXrbTAaOe47+e8LG/D60cpl8GiFO99o8MvnxHi9cGlpILFMoD0Htl3A4v4IRZBSlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572356; c=relaxed/simple;
	bh=ZEwIUft5mx5CW/4ulfS862jC6CLgCDryKYDMnVaFu3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9blXTc8+T9T+cl097OkMZDrXeFWbSPL9PI1nLxzcUODSakr7eXPnkF3qU9/Uambg+jdeZQ8UgY2Ec16UW0taxeM7CCJqzKJX9msgPSGyFfB/BIJdGIlvdVvoVor7MWYW2Gk9QQpyObX8lyooTRUTspRvrXB4d4wqOqvNHL9T7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKZJvxKH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKZJvxKH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768572354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3hDO6t8VeCQA0bPh+vN6I1ffVNFUX+xgA11LjWeZ9k=;
	b=JKZJvxKHyIjlq20HPYS3ED1orzmqtIGNUreZx08c/euL9jrdfvybI4ajK/9GmKHoI83mLB
	ivt1YG1CBKhccYZ64gnIfE6mLUy3Qkdbi+KwzZbb+qFwV0GOqOYvLd+xd2HwlBr+JQACsZ
	ufDIQ3UFgSCnKf2jjEPmvI5IcrlmH9w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-i2IepScKORiHtauSl2Z7ZQ-1; Fri,
 16 Jan 2026 09:05:53 -0500
X-MC-Unique: i2IepScKORiHtauSl2Z7ZQ-1
X-Mimecast-MFC-AGG-ID: i2IepScKORiHtauSl2Z7ZQ_1768572352
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A66E1800378;
	Fri, 16 Jan 2026 14:05:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CEFD30002D6;
	Fri, 16 Jan 2026 14:05:48 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
	linux-kernel@vger.kernel.org,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v14 12/13] vduse: bump version number
Date: Fri, 16 Jan 2026 15:04:54 +0100
Message-ID: <20260116140455.1560491-13-eperezma@redhat.com>
In-Reply-To: <20260116140455.1560491-1-eperezma@redhat.com>
References: <20260116140455.1560491-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Finalize the series by advertising VDUSE API v1 support to userspace.

Now that all required infrastructure for v1 (ASIDs, VQ groups,
update_iotlb_v2) is in place, VDUSE devices can opt in to the new
features.

Assume API version 0 if the VDUSE instance does not call
VDUSE_GET_API_VERSION to maintain compatibility.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v12:
* Assume API version 0 by default if the VDUSE instance does not ask
  (Jason).
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 2727c0c26003..73d1d517dc6c 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -52,6 +52,15 @@
 
 #define IRQ_UNBOUND -1
 
+/*
+ * VDUSE instance have not asked the vduse API version, so assume 0.
+ *
+ * Old devices may not ask for the device version and assume it is 0.  Keep
+ * this value for these.  From the moment the VDUSE instance ask for the
+ * version, convert to the latests supported one and continue regular flow
+ */
+#define VDUSE_API_VERSION_NOT_ASKED U64_MAX
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -2153,6 +2162,8 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 	mutex_lock(&vduse_lock);
 	switch (cmd) {
 	case VDUSE_GET_API_VERSION:
+		if (control->api_version == VDUSE_API_VERSION_NOT_ASKED)
+			control->api_version = VDUSE_API_VERSION_1;
 		ret = put_user(control->api_version, (u64 __user *)argp);
 		break;
 	case VDUSE_SET_API_VERSION: {
@@ -2163,7 +2174,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (api_version > VDUSE_API_VERSION)
+		if (api_version > VDUSE_API_VERSION_1)
 			break;
 
 		ret = 0;
@@ -2180,6 +2191,8 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
+		if (control->api_version == VDUSE_API_VERSION_NOT_ASKED)
+			control->api_version = VDUSE_API_VERSION;
 		if (!vduse_validate_config(&config, control->api_version))
 			break;
 
@@ -2230,7 +2243,7 @@ static int vduse_open(struct inode *inode, struct file *file)
 	if (!control)
 		return -ENOMEM;
 
-	control->api_version = VDUSE_API_VERSION;
+	control->api_version = VDUSE_API_VERSION_NOT_ASKED;
 	file->private_data = control;
 
 	return 0;
-- 
2.52.0

