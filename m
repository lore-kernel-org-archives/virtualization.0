Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5030DD1B
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507478; cv=none; b=PLRAFduUSfLJMUZE23wtsE/gO2mgu3IorrXsp2baaqpK2HrrjOyqf9uq3W8UlZ3iUCG+fOpGSzmF9S1Cks4bRcwIiS62nNUl1Xi2xNGyXoPMrAo0tqZSMDWqF18/+ffoizB92TZ1v4S29vj5gtX6lTrQ3x24Q0dz0xM/MfuNSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507478; c=relaxed/simple;
	bh=w2x9ThFG/3oIaisD6f6vvsQ8qKWULGWziBs21QqVWAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWwdX2pi5hY0palhiR8vDlEGcuRZ8ziZ5RZzCEVd2y6WzWA1wd4SKzErO0GWlahv0YghitWDFZnhtt+CKw/mch0AUOst+LxeilsZ2Mch4yo0LgY7WRLTPD8NvwHIQmLB9rFVpjXAe8euTF7ji65/3rui5nquayG4QVsVKgrjVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7deRLou; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7deRLou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755507476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3PG84EHC3mShb3Y0J40UmsNIyZdZBlJ04AfluOXhawc=;
	b=W7deRLouPblEUumvFGm7iOCZYsIbmNsNv7mM9Mp4whE+EMK7VHo+DvPNGozXnMrxtvQ624
	82HD8yV3e/ODALoZwaFUbQ3JED65Bh3nOqO00H2YRfkEwVH3gk3LGhCF3YKfmjhThLP8h5
	OgQDE8IchM1cV98TsBwUS3cq4XHnL5Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-lhbsMwHQMziFeZbFk0XgFw-1; Mon,
 18 Aug 2025 04:57:52 -0400
X-MC-Unique: lhbsMwHQMziFeZbFk0XgFw-1
X-Mimecast-MFC-AGG-ID: lhbsMwHQMziFeZbFk0XgFw_1755507471
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E94661954B2D;
	Mon, 18 Aug 2025 08:57:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.213])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8361180028B;
	Mon, 18 Aug 2025 08:57:46 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	jasowang@redhat.com,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC v3 7/7] vduse: bump version number
Date: Mon, 18 Aug 2025 10:57:11 +0200
Message-ID: <20250818085711.3461758-8-eperezma@redhat.com>
In-Reply-To: <20250818085711.3461758-1-eperezma@redhat.com>
References: <20250818085711.3461758-1-eperezma@redhat.com>
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
index de9550fd1cc8..dbabb1e527bf 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2143,7 +2143,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (api_version > VDUSE_API_VERSION)
+		if (api_version > VDUSE_API_VERSION_1)
 			break;
 
 		ret = 0;
@@ -2210,7 +2210,7 @@ static int vduse_open(struct inode *inode, struct file *file)
 	if (!control)
 		return -ENOMEM;
 
-	control->api_version = VDUSE_API_VERSION;
+	control->api_version = VDUSE_API_VERSION_1;
 	file->private_data = control;
 
 	return 0;
-- 
2.50.1

