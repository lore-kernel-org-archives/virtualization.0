Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55533D4FB
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711982; cv=none; b=br6R7uI8JvLkaDY0QsO5DEG3U4dcOUPeaFw19yeU2akJjl3N1CGowgzzzBzIt5SCiIHvosKKfCTO/5uv02OdsPjPpn+eIvOQ2ieAJtsQ07FlgWKQ3xYaShe7SlFjroRRn4jXfr2YEAvjAKSC6akUXmW4sMJpPlo5xLkhoNi1OJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711982; c=relaxed/simple;
	bh=unqhqVHp7bZXZEdJI4VwNyUYZjmIkrfqvaHxOJZwfYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDZ/JtGmxRptg8ipDrzWw4Zx90UHRvCMhtqzyyleDEFaFC25RbRveuHS20I1LT7SgGSvAU2askGeDXmtUtVgv1kjirhDO38kBq1kXdb1FH+D4awuzL+5Ufo21Ir6IuIULnDRgMh8U+gYZ72N1csaNp0HUZtT3aaBMPg0m3f/Do4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2bzoDPN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2bzoDPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770711980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iuzb/x/zpg3bCMsL7dSGMWU2Krr95sWPDBHBtOin3lU=;
	b=C2bzoDPN/ZtpZNMpZPO+UR2p0IVdQm101bpWMA4X4+s+UIjyuFpCuRi3vxm4TdQozOwj11
	wh2Sbf40RbM2NGP6AiF2u9wmzTFntD1Sm5yzmFx5peRpn67LCPpAQ3tFb/M3YmCQU1EZW7
	YsR6dunclZLYRYvq3xa0pfMk3Hueeew=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-ywtaJkyyN7mN6DVkZKkhug-1; Tue,
 10 Feb 2026 03:26:19 -0500
X-MC-Unique: ywtaJkyyN7mN6DVkZKkhug-1
X-Mimecast-MFC-AGG-ID: ywtaJkyyN7mN6DVkZKkhug_1770711978
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FCE11955F23;
	Tue, 10 Feb 2026 08:26:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 568121956053;
	Tue, 10 Feb 2026 08:26:13 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2 4/5] vduse: advertise API V2 support
Date: Tue, 10 Feb 2026 09:25:53 +0100
Message-ID: <20260210082554.1582553-5-eperezma@redhat.com>
In-Reply-To: <20260210082554.1582553-1-eperezma@redhat.com>
References: <20260210082554.1582553-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: vQ_7ds14jK7x3PV55IcD3BOXyg6VexS4bC0-RtY02vU_1770711978
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Advertise VDUSE API V2 support to userspace.

With the necessary infrastructure and feature flags in place, VDUSE
devices can now opt-in to the new API and utilize the
VDUSE_F_QUEUE_READY feature.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 7458cbaed4c7..39e115b8bf44 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2168,7 +2168,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case VDUSE_GET_API_VERSION:
 		if (control->api_version == VDUSE_API_VERSION_NOT_ASKED)
-			control->api_version = VDUSE_API_VERSION_1;
+			control->api_version = VDUSE_API_VERSION_2;
 		ret = put_user(control->api_version, (u64 __user *)argp);
 		break;
 	case VDUSE_SET_API_VERSION: {
@@ -2179,7 +2179,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (api_version > VDUSE_API_VERSION_1)
+		if (api_version > VDUSE_API_VERSION_2)
 			break;
 
 		ret = 0;
-- 
2.53.0

