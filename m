Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148A2882C3
	for <virtualization@lists.linux.dev>; Fri,  6 Jun 2025 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210641; cv=none; b=LLcZtXi/5XvE4uqrJxAOrRqmky0Cp96lw0OMdrLGWjTFB+eeoW4evN4VVGTF8YUMpXINzQtzG/y5V1qVe9waQzNlaNwfwkmYZVe17lGtE1NjreYrVCJVbcqOEs2vcoPLVb5f/6qH+XqnMIOZdheIWcND6s4uczU04StlgV3+3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210641; c=relaxed/simple;
	bh=89wxZ3oO4ZH6cCK6mN0JW+yXN+Rr112wSDrBDCPMLAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhD2ku+FXjl27LR7P42sI/4avYN1cuILvm2c6vawNEAgW1nAnM0v4+/93lo7E3i/B9sETf/1TI5pFXLAudZ1h+oaOxwyJEpw2M/qryCxt0EFODyCoe3CL/QSLan4yqkmq8ZpgCVvGu0lVZQRTF5ZwDmjph9n9KQGtOBSt1FkUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYOAST02; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYOAST02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iretUVp3t9mkYjP8n+n5q4o6QbDi952+SZy4PuCS9O8=;
	b=CYOAST02wbrWm3Vo2XwwklwmjAYeh+s66FhrRR7DqRneZ31R5lnZ1Z4upmmYBAekhd0J32
	rOeO3K4tjYnn+mOyFQOGGy6voQS0qSBDXT0EL5lc+5yl1rgVjJ5kZuDkMWjUKp+R9PrgXt
	LGzRJYUXZViJdjakCLmLhFtQeiPpKuM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-UV_7ViRdPh6HGemABi3etQ-1; Fri,
 06 Jun 2025 07:50:38 -0400
X-MC-Unique: UV_7ViRdPh6HGemABi3etQ-1
X-Mimecast-MFC-AGG-ID: UV_7ViRdPh6HGemABi3etQ_1749210637
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD9E5195608E;
	Fri,  6 Jun 2025 11:50:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA36C195E74A;
	Fri,  6 Jun 2025 11:50:32 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: jasowang@redhat.com
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [RFC 4/6] vduse: send update_iotlb_v2 message
Date: Fri,  6 Jun 2025 13:50:10 +0200
Message-ID: <20250606115012.1331551-5-eperezma@redhat.com>
In-Reply-To: <20250606115012.1331551-1-eperezma@redhat.com>
References: <20250606115012.1331551-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This new version reports the translation ASID.  Needed so the device can
support it.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 14 ++++++++++----
 include/uapi/linux/vduse.h         |  7 +++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d51e4f26fe72..151c6d133e76 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -317,7 +317,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev, u8 status)
 	return vduse_dev_msg_sync(dev, &msg);
 }
 
-static int vduse_dev_update_iotlb(struct vduse_dev *dev,
+static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
 				  u64 start, u64 last)
 {
 	struct vduse_dev_msg msg = { 0 };
@@ -326,8 +326,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *dev,
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
@@ -818,7 +824,7 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 	if (ret)
 		return ret;
 
-	ret = vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
+	ret = vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
 	if (ret) {
 		vduse_domain_clear_map(dev->domain[asid], iotlb);
 		return ret;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 3a17a0b4e938..a7c979591b2e 100644
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
2.49.0

