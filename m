Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385334575A
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970706; cv=none; b=HM8RfCPMUMOiJK6Gu+wqKgy9mgEACi/pq1rdSAQ9U2N2ekFSa4+OdVS8axmfdMEp/p63dGPCgVZSw1iC9TX5XDMrhsqaZxnRr4BbUCIkwk1m7dO+Q3/fTziLMMNmdxWNa5apfaC8x1pI8j40hAgBUTCI093NixExH94MyGRQXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970706; c=relaxed/simple;
	bh=khCzcX8EHEIkWBj/FiSPOZVVK4O1q4782W4oYNETP30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJ28DSwU68rReRtLfE20zZw1G4u3+/r2bRIvDAal6VObbHuqCTebr2F01k/BznKrNKOKEmEBWnP1f8MK9frtdRBoYXG6rfE89TtU5n6iJV/I0xv4z6Dj5ckrs2JmvxQyfQQKXr2v1HxUFkG+/NS29n5S2ou+TRpfbdZjoUnRoZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqdyiQdc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqdyiQdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765970698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IR90zvwtlGu1kNgK8+5PQ9pZR4Ny/J1mNtZRGeYkK4U=;
	b=VqdyiQdcw8B31b+B2OL0xmpGWhii4Ag4WG168GNSthHHSojrUpXEXeDa2oXlDpF6Rg/Vnl
	PDSN1i9a/grvi9MAeUQA4UmjImlyW32oeNWgFRvoIUfS9OswoQLT7BnhM34wic5k4Ow7cj
	UpKOoTFXFFXiTxtTztRu8xk6DfBvAXA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-M2Am3ypsMLSuVCFbSI31tA-1; Wed,
 17 Dec 2025 06:24:55 -0500
X-MC-Unique: M2Am3ypsMLSuVCFbSI31tA-1
X-Mimecast-MFC-AGG-ID: M2Am3ypsMLSuVCFbSI31tA_1765970694
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 002601956094;
	Wed, 17 Dec 2025 11:24:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DD1C180045B;
	Wed, 17 Dec 2025 11:24:50 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v10 8/8] vduse: bump version number
Date: Wed, 17 Dec 2025 12:24:14 +0100
Message-ID: <20251217112414.2374672-9-eperezma@redhat.com>
In-Reply-To: <20251217112414.2374672-1-eperezma@redhat.com>
References: <20251217112414.2374672-1-eperezma@redhat.com>
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

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 786ab2378825..15860bd331a6 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2163,7 +2163,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (api_version > VDUSE_API_VERSION)
+		if (api_version > VDUSE_API_VERSION_1)
 			break;
 
 		ret = 0;
@@ -2230,7 +2230,7 @@ static int vduse_open(struct inode *inode, struct file *file)
 	if (!control)
 		return -ENOMEM;
 
-	control->api_version = VDUSE_API_VERSION;
+	control->api_version = VDUSE_API_VERSION_1;
 	file->private_data = control;
 
 	return 0;
-- 
2.52.0

