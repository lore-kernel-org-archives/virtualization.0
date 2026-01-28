Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653CB350A29
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604361; cv=none; b=Rsqd9/jqjgzSA1Mvhj8nx03AxDscYKphsBBGwn7QzHYyqdsNf4jq9vbrgCIat+vmHwPrOCUYSjvDxv4l8IEMGnZuWhOHIYkxx5KJibcYdwjZqubPIZ/26PbI6SjDN2t5F+J2/TxEwcLWBZwpCPyTKEdU4uydCtcTqeHjaGBs3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604361; c=relaxed/simple;
	bh=rub1jVoIla+gOSyGrYmCCuTdBFAqXc9tj6gyirSe1XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ek5B7ygtIC6iQEhQT3EZtEVuKDPywXezN52RYFY3ZWNIfzU+jY/lqQuIo4ma1EUzNGu2VUBXUNL29Sj3ddmXU1k0DX1onrOQ9rP4yArN3Aiw53n6z4reS/YRAHmcte951iRoCL+b7Vb8qagJHYJrLR4hUffKn6a66EDERziLpwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0VD1yq1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0VD1yq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769604359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvdT8XuPcB3wpI0L5PIioOQPTtnMa6o56elsZfgVm+M=;
	b=A0VD1yq1J67mNXHx+Z2ohmm7Qej3DkFlFtol47hf90Pl7sJBtehYJMx7ZokWV/KoaG+Z3E
	9Aihd4L6CPytZIDdRSblPzHGO/5/dVkezTeMGJKFTEVs2rIt0/aLh1yFqfcHsLvQzkUxli
	eUNJmyllaKQhqsp0W79HLk0z+H+doyA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-aJhCInkiOHK0YgBr3qsG5A-1; Wed,
 28 Jan 2026 07:45:57 -0500
X-MC-Unique: aJhCInkiOHK0YgBr3qsG5A-1
X-Mimecast-MFC-AGG-ID: aJhCInkiOHK0YgBr3qsG5A_1769604356
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD277194510A;
	Wed, 28 Jan 2026 12:45:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.239])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5280C30001A2;
	Wed, 28 Jan 2026 12:45:53 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 6/6] vduse: advertise API V2 support
Date: Wed, 28 Jan 2026 13:45:24 +0100
Message-ID: <20260128124524.875271-7-eperezma@redhat.com>
In-Reply-To: <20260128124524.875271-1-eperezma@redhat.com>
References: <20260128124524.875271-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Advertise VDUSE API V2 support to userspace.

With the necessary infrastructure and feature flags in place, VDUSE
devices can now opt-in to the new API and utilize the
VDUSE_F_QUEUE_READY feature.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1d93b540db4d..7b5cae065f8b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2224,7 +2224,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case VDUSE_GET_API_VERSION:
 		if (control->api_version == VDUSE_API_VERSION_NOT_ASKED)
-			control->api_version = VDUSE_API_VERSION_1;
+			control->api_version = VDUSE_API_VERSION_2;
 		ret = put_user(control->api_version, (u64 __user *)argp);
 		break;
 	case VDUSE_SET_API_VERSION: {
@@ -2235,7 +2235,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (api_version > VDUSE_API_VERSION_1)
+		if (api_version > VDUSE_API_VERSION_2)
 			break;
 
 		ret = 0;
-- 
2.52.0

