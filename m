Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D062DFA46
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881710; cv=none; b=M8VJqTs74k9RTgdiBKibWNsXTNV/yvOqX5oVcwj+mctCzTEKmJf1oPfqnAf/SSogJPZ6JRN0dC447V+g8VQzBo8UgzSb6VeSjL9OAzTdGNWSkMwaF2cUAOLt9ydk/M+zxMhNdwE7i+t9jgT6hMzzv0Wz9oN3kqVVEacjooL/7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881710; c=relaxed/simple;
	bh=TgabKru2NZ2THuko/HMl/zGbuptOnpVacP0GoqGhWH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkUpHja3lGI1IPejGBL+Rv6iTbfF+C7GG3c7sAaQDt3lfnL0bQ5quL31a9RZR3fXKlNNZ1Yq5Jber1PjTLSWz31wXDitoypDvY6GC4Ul3GLR7P8xMPX9b84nNX0A8kQCVHkZUghCuEB0iMxOpMDgolRopacXZr9/PSs+ZF6sDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2SZXiho; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2SZXiho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758881708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQu5rvKno3CIEFHa+u79BfQxrhq8if3HgGYXYb9FXfk=;
	b=H2SZXihoxw+YB6KpMcQZVm0lRsj5HIbykv3k/5t0L/czgHfQ9qu9FWD5VCJgABeCsw8dXO
	Sdj4/2NtUaV0dsbJkJDGVlZn2s0ZyqWlVH7hys//IiXM8S2oaaQGdkPXR/cgqKBQBIo02S
	PTC1fZOfMpLvVy3D9GBnf/96AfJsjmM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-XEb0xz6uOpS6bMHJzw3wew-1; Fri,
 26 Sep 2025 06:15:06 -0400
X-MC-Unique: XEb0xz6uOpS6bMHJzw3wew-1
X-Mimecast-MFC-AGG-ID: XEb0xz6uOpS6bMHJzw3wew_1758881705
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7127B19560A2;
	Fri, 26 Sep 2025 10:15:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.141])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7E11195419F;
	Fri, 26 Sep 2025 10:15:01 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: [PATCH v5 6/6] vduse: bump version number
Date: Fri, 26 Sep 2025 12:14:32 +0200
Message-ID: <20250926101432.2251301-7-eperezma@redhat.com>
In-Reply-To: <20250926101432.2251301-1-eperezma@redhat.com>
References: <20250926101432.2251301-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Finalize the series by advertising VDUSE API v1 support to userspace.

Now that all required infrastructure for v1 (ASIDs, VQ groups,
update_iotlb_v2) is in place, VDUSE devices can opt in to the new
features.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 731de08bb692..7f24a1af6cca 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2165,7 +2165,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (api_version > VDUSE_API_VERSION)
+		if (api_version > VDUSE_API_VERSION_1)
 			break;
 
 		ret = 0;
@@ -2232,7 +2232,7 @@ static int vduse_open(struct inode *inode, struct file *file)
 	if (!control)
 		return -ENOMEM;
 
-	control->api_version = VDUSE_API_VERSION;
+	control->api_version = VDUSE_API_VERSION_1;
 	file->private_data = control;
 
 	return 0;
-- 
2.51.0

