Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395D36AFD
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaT078Sj"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6D3142155
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:10:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6D3142155
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UaT078Sj
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c6VHZOcgOmJy
	for <virtualization@lists.linux-foundation.org>;
	Tue,  9 Jan 2024 11:10:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 06A0042142
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:10:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06A0042142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704798644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DDFZxrU+9MYVeduyTCL7aynBvhEel3T3b/VCxzLnYk=;
	b=UaT078SjCMzsrZPPCjPd3x6Btmlu0uQE/A0jlWp2zwpEX+TTqfYL8JAccPmYilMbmSZ9cv
	Nxd/VijpWREYvFBzugYp4WwEHuYgnrvMMC6KVKqpmIyYHKt5twegI4AFaWj7UmgIMnIq0S
	BzKPSdSl35nv0M7PWHWXvAv2yCAQLoc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-0VDSwIlePUOcLGfVcmQ_2A-1; Tue, 09 Jan 2024 06:10:37 -0500
X-MC-Unique: 0VDSwIlePUOcLGfVcmQ_2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E4FD85A58B;
	Tue,  9 Jan 2024 11:10:37 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8B765492BE6;
	Tue,  9 Jan 2024 11:10:35 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david.marchand@redhat.com,
	lulu@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v7 3/3] vduse: enable Virtio-net device type
Date: Tue,  9 Jan 2024 12:10:25 +0100
Message-ID: <20240109111025.1320976-4-maxime.coquelin@redhat.com>
In-Reply-To: <20240109111025.1320976-1-maxime.coquelin@redhat.com>
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

This patch adds Virtio-net device type to the supported
devices types.

Initialization fails if the device does not support
VIRTIO_F_VERSION_1 feature, in order to guarantee the
configuration space is read-only. It also fails with
-EPERM if the CAP_NET_ADMIN is missing.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 00f3f562ab5d..8924bbc55635 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -143,6 +143,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
 
 static u32 allowed_device_id[] = {
 	VIRTIO_ID_BLOCK,
+	VIRTIO_ID_NET,
 };
 
 static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
@@ -1686,6 +1687,10 @@ static bool features_is_valid(struct vduse_dev_config *config)
 			(config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
 		return false;
 
+	if ((config->device_id == VIRTIO_ID_NET) &&
+			!(config->features & BIT_ULL(VIRTIO_F_VERSION_1)))
+		return false;
+
 	return true;
 }
 
@@ -1793,6 +1798,10 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	int ret;
 	struct vduse_dev *dev;
 
+	ret = -EPERM;
+	if ((config->device_id == VIRTIO_ID_NET) && !capable(CAP_NET_ADMIN))
+		goto err;
+
 	ret = -EEXIST;
 	if (vduse_find_dev(config->name))
 		goto err;
@@ -2036,6 +2045,7 @@ static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtdev_ops = {
 
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
+	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
 
-- 
2.43.0

