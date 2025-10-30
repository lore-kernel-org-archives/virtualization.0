Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5CE355020
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818470; cv=none; b=Bd8Fv92RI/WAJx34e0t5uQSOKm+cdlWrZhayIU8yaveJlQMZgbPCfKSofDwLh+WL51MkVzLTtswiLEYr0HkugM0VIDgUQIZUjvT567b9D7Q9xINb3nhzWpMNilgxAB3k3ke9i2semz0FHViVMfn1+YRgp0xukmFJjohvpDfArLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818470; c=relaxed/simple;
	bh=c+mxMT5z9gH3aeZ3AUQmM63qxahQO5qtMwaIuE543SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMVeuEDBj1KFcG0F9G+qvVnBHsWaIrY71XoI6OuvBjQHLW36TzyOSfdr+KDLeyLVRrFILRc9H1uJuY1x9qP3Depi9KOTYPULoyR+TeHD2vC6DpB4FgDolBT1pyKTkA3iLNUgK3sDatyT/UYGOeS5pflar7KUkz6dcLNfqD3ODzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqCqdopE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqCqdopE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761818468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCf9KT46ZQB9zTMljCdPa/5sz1Xm49Tsv7O4mAWJy4U=;
	b=UqCqdopEDen6OIZ3hhKfjyr/AzHpppq5R/+lIjnzOjRP0HgFEPDaqYbxcChkHHTdFXuujO
	Mm1RdGtBJ3qwhlOJHACWYToAdXDfaj7A/06qtkKISxbOXnWgUU+H62ReTrZUhsI3g2wDTz
	7wlNrohmNViOeHAtmV0dz/L0tHriIU0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-5g2qpBbPPi2PIblElQgeUg-1; Thu,
 30 Oct 2025 06:01:01 -0400
X-MC-Unique: 5g2qpBbPPi2PIblElQgeUg-1
X-Mimecast-MFC-AGG-ID: 5g2qpBbPPi2PIblElQgeUg_1761818460
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 742B11834512;
	Thu, 30 Oct 2025 10:01:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3271619560B6;
	Thu, 30 Oct 2025 10:00:55 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	jasowang@redhat.com,
	Cindy Lu <lulu@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 6/6] vduse: bump version number
Date: Thu, 30 Oct 2025 11:00:25 +0100
Message-ID: <20251030100025.95113-7-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-1-eperezma@redhat.com>
References: <20251030100025.95113-1-eperezma@redhat.com>
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
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index c6909d73d06d..7977a1be5ad6 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2166,7 +2166,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (api_version > VDUSE_API_VERSION)
+		if (api_version > VDUSE_API_VERSION_1)
 			break;
 
 		ret = 0;
@@ -2233,7 +2233,7 @@ static int vduse_open(struct inode *inode, struct file *file)
 	if (!control)
 		return -ENOMEM;
 
-	control->api_version = VDUSE_API_VERSION;
+	control->api_version = VDUSE_API_VERSION_1;
 	file->private_data = control;
 
 	return 0;
-- 
2.51.0

