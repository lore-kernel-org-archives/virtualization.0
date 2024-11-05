Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD61FF057
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791716; cv=none; b=mbM/Ixc9jDxIapZqepZlPJER8OwHkoEMojx2pVLVShdaY/QG93vW34DiVYSa6wkZ8KXwAHtu1T2SWHi5id7yIbBXVcHGGiUIWV6wonwBtqJUpcjhV4Lf79jZgDgSyz6Fd94sA7FqBvTUHuxdxpthDVcdX0w+nTUSfnL21Ujob0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791716; c=relaxed/simple;
	bh=MX5FZQA4EmsLL2pOoIXNJm9EOZkEs7x6Q7BAjrZW4D4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9nweAdC+kOLjDzVqbTLSbojBuRXaAJEWcZc88sssqVKgk35XZSvZ8FjKno+jDD0XOLEkb6UwsL03qQsZjgXx/p2zVm/ISLoAxy/ojOgM0KLVHtjnbzNqqcU9pj+sxgXOzXJdKxTyMnkJOgZ2o+uCcvxfYfPSefDmksKQJfSgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esFOe+kL; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esFOe+kL"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C96F880DB1
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ySZAWSXw4TNF for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 07:28:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 111DE80DAF
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 111DE80DAF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=esFOe+kL
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 111DE80DAF
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waOIJYR/uf8lM72gcE+nfFRZp8HYpeFxyDV384TmS5E=;
	b=esFOe+kLpuqSkMB8irj9YhMAOb86sdzjZXXsn37JSLppjoQBvbgQqorAT8YjXutjmNLPjr
	4Lswkbu0kI4silPB+v884wEORFXW4pfESAhwcB+7l3jxQEOXnNm3SYSxKTzRtIpzEBeuw2
	xBxj9UhjndctKshzxCRppb3OBUAKHFU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-JVDKDcsiOTSUpOOxeo5f5g-1; Tue,
 05 Nov 2024 02:28:28 -0500
X-MC-Unique: JVDKDcsiOTSUpOOxeo5f5g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A897C1955EAA;
	Tue,  5 Nov 2024 07:28:27 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00BD119560A3;
	Tue,  5 Nov 2024 07:28:22 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 8/9] vhost_scsi: Add check for inherit_owner status
Date: Tue,  5 Nov 2024 15:25:27 +0800
Message-ID: <20241105072642.898710-9-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-1-lulu@redhat.com>
References: <20241105072642.898710-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The vhost_scsi VHOST_NEW_WORKER requires the inherit_owner
setting to be true. So we need to implement a check for this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/scsi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 006ffacf1c56..05290298b5ab 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2083,6 +2083,11 @@ vhost_scsi_ioctl(struct file *f,
 			return -EFAULT;
 		return vhost_scsi_set_features(vs, features);
 	case VHOST_NEW_WORKER:
+		/*vhost-scsi VHOST_NEW_WORKER requires inherit_owner to be true*/
+		if (vs->dev.inherit_owner != true)
+			return -EFAULT;
+
+		fallthrough;
 	case VHOST_FREE_WORKER:
 	case VHOST_ATTACH_VRING_WORKER:
 	case VHOST_GET_VRING_WORKER:
-- 
2.45.0

