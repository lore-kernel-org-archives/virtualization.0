Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF363248F70
	for <virtualization@lists.linux.dev>; Thu,  7 Aug 2025 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567913; cv=none; b=Uth+0wdAAAPTNsIuSOcsbOfQ6+YPnczxvwv1DqV3fkT9bREXLjlazJ1GCogiTEDzeth+GmtLsA5hZqBBIVkctEFImSVuzas7pEjWU792m9w6N+9iS5UxZwOh6bnJbpBRBzhyWKB0h6D/67K/5tEXWwqpEDjujkFiE4teGpQ+p6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567913; c=relaxed/simple;
	bh=bw4QieCdPyUE1mT+QXJIz6RfMf6JFswO943BPFYtrzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JA0c1+EO+HBuiVl2aHEK6ldk5FcD1CDXnpLzCxmbJ7+hCU1PGf7oO398t/FnmAEnSd6Ks4HbE/3pv2fVEMdOxMdpoE5X/x964YazbxkUsK4lQ805VanV2gH83Q7Ze41e7zEPCxNxmwYF1IIha7ZPM1GJO4B3WnGVYlotlZH5PiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJyP2eOW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJyP2eOW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754567910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAWEzypwFXNY0V+CvTxfSM1d3goRg1trlUIPl5R5TMM=;
	b=eJyP2eOWv5i1UHD7JMIKy8rd6KNnEouwfq11o3x3M/GMEi4LEj69IVpX0VjTRO7GPOkXJ3
	J/GMEZ0jO2Wppx9HMDaFdIdQd2duuf9PmgxX2akwX9oMT6Ym4QZiNOEX/zKeWJw6YHR4Ww
	gRVncJwngzNCRclPrXLmO6nNYkbfnYY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-N8vLL0QbNjaVgUTx4rtwyA-1; Thu,
 07 Aug 2025 07:58:27 -0400
X-MC-Unique: N8vLL0QbNjaVgUTx4rtwyA-1
X-Mimecast-MFC-AGG-ID: N8vLL0QbNjaVgUTx4rtwyA_1754567906
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 846E019560AA;
	Thu,  7 Aug 2025 11:58:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2D713001456;
	Thu,  7 Aug 2025 11:58:22 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	jasowang@redhat.com,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [RFC v2 6/7] vduse: send update_iotlb_v2 message
Date: Thu,  7 Aug 2025 13:57:51 +0200
Message-ID: <20250807115752.1663383-7-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-1-eperezma@redhat.com>
References: <20250807115752.1663383-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This message lets the kernel notify userspace VDUSE backends about
updated IOTLB mappings for a specific ASID.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 14 ++++++++++----
 include/uapi/linux/vduse.h         |  7 +++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 145147c49930..ac7897068222 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -326,7 +326,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev, u8 status)
 	return vduse_dev_msg_sync(dev, &msg);
 }
 
-static int vduse_dev_update_iotlb(struct vduse_dev *dev,
+static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
 				  u64 start, u64 last)
 {
 	struct vduse_dev_msg msg = { 0 };
@@ -335,8 +335,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *dev,
 		return -EINVAL;
 
 	msg.req.type = VDUSE_UPDATE_IOTLB;
-	msg.req.iova.start = start;
-	msg.req.iova.last = last;
+	if (dev->api_version < VDUSE_API_VERSION_1) {
+		msg.req.iova.start = start;
+		msg.req.iova.last = last;
+	} else {
+		msg.req.iova_v2.start = start;
+		msg.req.iova_v2.last = last;
+		msg.req.iova_v2.asid = asid;
+	}
 
 	return vduse_dev_msg_sync(dev, &msg);
 }
@@ -882,7 +888,7 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 	if (ret)
 		return ret;
 
-	ret = vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
+	ret = vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
 	if (ret) {
 		vduse_domain_clear_map(dev->domain[asid], iotlb);
 		return ret;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index d300fd5f867f..a5f7a5edb8e0 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -349,6 +349,12 @@ struct vduse_iova_range {
 	__u64 last;
 };
 
+struct vduse_iova_range_v2 {
+	__u64 start;
+	__u64 last;
+	__u32 asid;
+};
+
 /**
  * struct vduse_dev_request - control request
  * @type: request type
@@ -369,6 +375,7 @@ struct vduse_dev_request {
 		struct vduse_vq_state vq_state;
 		struct vduse_dev_status s;
 		struct vduse_iova_range iova;
+		struct vduse_iova_range_v2 iova_v2;
 		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
 		/* Only if vduse api version >= 1 */
 		struct vduse_vq_group_asid vq_group_asid;
-- 
2.50.1

