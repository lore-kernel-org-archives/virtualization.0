Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB9318146
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207672; cv=none; b=Die+hpbYEawMj8O0AmOx/Iiftw584ezKJCeH6+ouzvccFnZ/qZDw2v4bNvhc0dYIC0ZObOlHnYOfWCoI038Eje7w4j7m2VRQIkN/E2ZWMwgKMfaOFvS138oJb17Mi/nxHbvS5TUW/ryLJ1k41mKbw3fkdzOjcLea4KePbGKuI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207672; c=relaxed/simple;
	bh=AK0T2lgXsW3PML7OI8mwLqomjHmP20f2IdEa9WL6nQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5TOAtkivFwLLtkieJcDkGGDWAT/F5ULdPLdOCjnPNbpTxD7N7yYur1nFOc3E4eiDwx4NEr6hla48Jd+Axf/YOKgevakmJM5195dEzbMZE3a8nyeqks6lwTm129X95q3QzanWea7d34fUiCqx6JmCyYkKM9wdC9yONiV8sDoXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feaCFlz3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feaCFlz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756207668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2itpLVm6hA9DzIDQs63bIiz4BfirhpwV7xdbFxqInw=;
	b=feaCFlz3LckPqh3dhNj4nyp3TTFOTPyZw9dOvIOcQdbuJdbVEaXhyLt7ZFVren0e0nMXr0
	Rd7mY23AynV4IpPfYwvIsKjHevC+KknXvPQ4UafFzH7aa4aWj8RGnQBx66Y/7grJZsFTVl
	O+3bxH+C3sCHYBoPTw6PuZdRq0nxt3k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-Ug8pOwnrNreS8oVD53FqMg-1; Tue,
 26 Aug 2025 07:27:45 -0400
X-MC-Unique: Ug8pOwnrNreS8oVD53FqMg-1
X-Mimecast-MFC-AGG-ID: Ug8pOwnrNreS8oVD53FqMg_1756207664
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75C2E180034F;
	Tue, 26 Aug 2025 11:27:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.67])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84B89180028B;
	Tue, 26 Aug 2025 11:27:39 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jasowang@redhat.com,
	Yongji Xie <xieyongji@bytedance.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH 6/6] vduse: bump version number
Date: Tue, 26 Aug 2025 13:27:09 +0200
Message-ID: <20250826112709.1051172-7-eperezma@redhat.com>
In-Reply-To: <20250826112709.1051172-1-eperezma@redhat.com>
References: <20250826112709.1051172-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Finalize the series by advertising VDUSE API v1 support to userspace.

Now that all required infrastructure for v1 (ASIDs, VQ groups,
update_iotlb_v2) is in place, VDUSE devices can opt in to the new
features.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 2fb227713972..e37e0352447e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2122,7 +2122,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (api_version > VDUSE_API_VERSION)
+		if (api_version > VDUSE_API_VERSION_1)
 			break;
 
 		ret = 0;
@@ -2189,7 +2189,7 @@ static int vduse_open(struct inode *inode, struct file *file)
 	if (!control)
 		return -ENOMEM;
 
-	control->api_version = VDUSE_API_VERSION;
+	control->api_version = VDUSE_API_VERSION_1;
 	file->private_data = control;
 
 	return 0;
-- 
2.51.0

