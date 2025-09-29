Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDA30DD22
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164779; cv=none; b=eefw17QC92Y/zn+XuUUEqmivLjguTYdL6GkxOOeHt0USLHYyXOb+htUSrBUmcCv+WLHVes898fc6APuJi8TQuzF9p24nw87VU9n24SgpLo9vk9WsvIlFuiMTztrKvhxt6txxmbkFXigyVXlRjVFZ9yQO9fvjbj2zfINNLNNSK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164779; c=relaxed/simple;
	bh=PlumWwYxtc0GQ7tohl4epRIChlgVf2VW0fgGi9uMCW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNmBWNSuy1qgrEVV5FZA4doZlnnmcIpjGT5oZyr9wkJ0XGYqk5eLQbBmadwkBVbnSsWXjmAE5ktWNU8QDOx2hmjPGS8UHp7LvH/S7VeKJXx5FqDpVCSl2K6cm1R2ABJpQFDYOdDJlHSbpqEIkGqjQEduIDeI/jmnFqt9yBzp+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNgoh6k7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNgoh6k7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759164776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7M03ujhvZHvkFMBrQm/mEextRhEbDdn/kXWRAKJo6NA=;
	b=gNgoh6k7v+b1gK2YFCRuR4JqgVCVwm4m7n3pZtpftoGb/u5coKH+OCcKpfBV4RGgkm75Wp
	7avg35USp7+XvllIdBTm6xGNGb61R+NNDa+39wAboMPSuZgKyjXXEPziaMndJEa8H05CFR
	t0q3M5h6JcFH/DMmRPMKXH9uS7uZIYw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-7NpN2vjRMI-jE1Ai0IfPDw-1; Mon,
 29 Sep 2025 12:52:54 -0400
X-MC-Unique: 7NpN2vjRMI-jE1Ai0IfPDw-1
X-Mimecast-MFC-AGG-ID: 7NpN2vjRMI-jE1Ai0IfPDw_1759164773
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24949180057B;
	Mon, 29 Sep 2025 16:52:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.47])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74F8E300061D;
	Mon, 29 Sep 2025 16:52:48 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v6 7/7] vduse: bump version number
Date: Mon, 29 Sep 2025 18:52:13 +0200
Message-ID: <20250929165213.2896034-8-eperezma@redhat.com>
In-Reply-To: <20250929165213.2896034-1-eperezma@redhat.com>
References: <20250929165213.2896034-1-eperezma@redhat.com>
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

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 7287084842a7..6c74282d5721 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2167,7 +2167,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (api_version > VDUSE_API_VERSION)
+		if (api_version > VDUSE_API_VERSION_1)
 			break;
 
 		ret = 0;
@@ -2234,7 +2234,7 @@ static int vduse_open(struct inode *inode, struct file *file)
 	if (!control)
 		return -ENOMEM;
 
-	control->api_version = VDUSE_API_VERSION;
+	control->api_version = VDUSE_API_VERSION_1;
 	file->private_data = control;
 
 	return 0;
-- 
2.51.0

