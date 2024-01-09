Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121283715E
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYCCA41i"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88FF342155
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:10:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88FF342155
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PYCCA41i
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8-cZIENXkO-G
	for <virtualization@lists.linux-foundation.org>;
	Tue,  9 Jan 2024 11:10:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D8C5342142
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:10:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8C5342142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704798637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtHMmViNUHkBlyTq+yA+WPFdZXCFstzRWGlzClhIP3k=;
	b=PYCCA41ieWMRoCWHKSpEHcvus9dLOhgIyIuj3n8G0UZ5tq/S6yWE66HlPxm537W6lzUHfy
	2D2MTE2eos7H63XBb/DWB1KZDRGVW6xsnXgEr0iq1MvbfffnG/7gczA7VQJ4beBmtgoAml
	BQUi3LC/nQSs4PWIHuus+3x+A3ungLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-wdiVT_Z_ML2xKOwrFtk9Cw-1; Tue, 09 Jan 2024 06:10:33 -0500
X-MC-Unique: wdiVT_Z_ML2xKOwrFtk9Cw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AE47106CFF5;
	Tue,  9 Jan 2024 11:10:33 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 194B4492BE6;
	Tue,  9 Jan 2024 11:10:30 +0000 (UTC)
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
Subject: [PATCH v7 1/3] vduse: validate block features only with block devices
Date: Tue,  9 Jan 2024 12:10:23 +0100
Message-ID: <20240109111025.1320976-2-maxime.coquelin@redhat.com>
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

This patch is preliminary work to enable network device
type support to VDUSE.

As VIRTIO_BLK_F_CONFIG_WCE shares the same value as
VIRTIO_NET_F_HOST_TSO4, we need to restrict its check
to Virtio-blk device type.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0ddd4b8abecb..a5af6d4077b8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1671,13 +1671,14 @@ static bool device_is_allowed(u32 device_id)
 	return false;
 }
 
-static bool features_is_valid(u64 features)
+static bool features_is_valid(struct vduse_dev_config *config)
 {
-	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
+	if (!(config->features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
 		return false;
 
 	/* Now we only support read-only configuration space */
-	if (features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE))
+	if ((config->device_id == VIRTIO_ID_BLOCK) &&
+			(config->features & BIT_ULL(VIRTIO_BLK_F_CONFIG_WCE)))
 		return false;
 
 	return true;
@@ -1704,7 +1705,7 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
 	if (!device_is_allowed(config->device_id))
 		return false;
 
-	if (!features_is_valid(config->features))
+	if (!features_is_valid(config))
 		return false;
 
 	return true;
-- 
2.43.0

