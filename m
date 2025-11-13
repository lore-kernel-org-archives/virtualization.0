Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA31A34DCDF
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035001; cv=none; b=KF9Rg3k0EQMDm4FtQWI7Te2KSt9yZi6VzWD+vutbDtk+TRofS8H2q4X7aB3qIulhpunqz+uJTWjdFYaXSdSxuBNvFY2AUH3MHThxGuFr1JQh9gAZBoZ4Eqkxjy3L30SYwbbtifFYU6g5B8kO7tbLsjO4IPM6Yg5/Rotf/nILtfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035001; c=relaxed/simple;
	bh=vDa/ArHDNygxl8ATzaKQtXkkTbj/f2T+x8SQ0I4O8pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFSJaCEUgcl/RDIW909G07SaX2pbBJUk3+8rIa9sdlJ4X5rQ4xzQ/OPASGKcK3gptU8TPY/g/NavM2mFfn3wVKza5x3rcTQqIeWUpoKdrvx15LZh9kH4IWGkOkxCK0lUfxXy5A/65MNxWW/txvuMFfLiuR/UzXhIhQPlqAFxAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c07aU7E9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c07aU7E9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763034998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97IEgQ7raWJ37uSPdBuA1IEh2oOdlGp2O5eUhoIZhZg=;
	b=c07aU7E9QWQTAxGaKgbZJIQ/tmCjIpVj+e7SruNlFzpsBBZRhp7xIkqGgrBcyY3T+JLrlZ
	eOVHS62RojxZIWAbJokBzIHKyogzcOELeTKWw8iYHGZ10BxYT/AH7m0Dc7yLZ02Y5u4lQd
	BYJAkrKY/kdZDeUkbquBtN1xiWBC1xY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-W2clVaWDNI-HASMAnVhq_w-1; Thu,
 13 Nov 2025 06:56:35 -0500
X-MC-Unique: W2clVaWDNI-HASMAnVhq_w-1
X-Mimecast-MFC-AGG-ID: W2clVaWDNI-HASMAnVhq_w_1763034994
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBAD718AB40A;
	Thu, 13 Nov 2025 11:56:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.122])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D77D119560B9;
	Thu, 13 Nov 2025 11:56:30 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v9 6/6] vduse: bump version number
Date: Thu, 13 Nov 2025 12:55:58 +0100
Message-ID: <20251113115558.1277981-7-eperezma@redhat.com>
In-Reply-To: <20251113115558.1277981-1-eperezma@redhat.com>
References: <20251113115558.1277981-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Finalize the series by advertising VDUSE API v1 support to userspace.

Now that all required infrastructure for v1 (ASIDs, VQ groups,
update_iotlb_v2) is in place, VDUSE devices can opt in to the new
features.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ff95ed56f22d..f5a1bc027ecb 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2188,7 +2188,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;

 		ret = -EINVAL;
-		if (api_version > VDUSE_API_VERSION)
+		if (api_version > VDUSE_API_VERSION_1)
 			break;

 		ret = 0;
@@ -2255,7 +2255,7 @@ static int vduse_open(struct inode *inode, struct file *file)
 	if (!control)
 		return -ENOMEM;

-	control->api_version = VDUSE_API_VERSION;
+	control->api_version = VDUSE_API_VERSION_1;
 	file->private_data = control;

 	return 0;
--
2.51.1

