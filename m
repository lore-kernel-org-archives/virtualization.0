Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB5309DD2
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164754; cv=none; b=dCs/MpUbFjw8VCPamK6o+n/QRO8fGaOurBD+GlgdtnJ/2dmBZQkFMMEc9xKUSL6lT3836EUQpFcTRMOZPqNE4+Ld3Unjt66HEh6qxm65ps8qdi5Zu9LF3CSYG0XzJQPdJUx+uiajoPKkArNOn9fEjTUgCYYOCJTpiq5g78hezsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164754; c=relaxed/simple;
	bh=pbBzLjrUvy4Jws3IrdIk6Q8D7H91HuRG6YGPY55CtrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyDYEsT4Msxzn4T4fRYpwhhbwOfGasLY8r6jgczRSsik7Vc8ZNOuAR+w5il7xyerTUx0moIvgGfZbJcAxKGw4d5yjRfU2UZcshlWCjdYBzaNuohDfaNWgF7/d3QYfOwSFtKfjv5vMuwa8l4w8/KbARNSIIvFgdV0pDRfmjBPFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SM5ANNqx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM5ANNqx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759164752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Dg27mnkpxY6+wpImWrHzQoz+UEHN7ql4f1eRWWfzQk=;
	b=SM5ANNqxYa+qPYFxdIBirHlqDbT25wRQMS3R2Zx5/iSTtrS2OF+TSf3Q0o6GmaIg/fPeMx
	2zBczwX1yVmemU0QOZjJjBNS1fAbbLdeq2awUfMHuDcV2Y19ZHcGs833QiNYyoQ5InQMn/
	HP3Du72hGSsykS2Ph0qOGLLinj8+8VA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-vflG7uKDM1ezsRlVLOLMyg-1; Mon,
 29 Sep 2025 12:52:28 -0400
X-MC-Unique: vflG7uKDM1ezsRlVLOLMyg-1
X-Mimecast-MFC-AGG-ID: vflG7uKDM1ezsRlVLOLMyg_1759164747
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB7E71800451;
	Mon, 29 Sep 2025 16:52:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.47])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11F6F30001A4;
	Mon, 29 Sep 2025 16:52:23 +0000 (UTC)
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
Subject: [PATCH v6 2/7] vduse: add v1 API definition
Date: Mon, 29 Sep 2025 18:52:08 +0200
Message-ID: <20250929165213.2896034-3-eperezma@redhat.com>
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

This allows the kernel to detect whether the userspace VDUSE device
supports the VQ group and ASID features.  VDUSE devices that don't set
the V1 API will not receive the new messages, and vdpa device will be
created with only one vq group and asid.

The next patches implement the new feature incrementally, only enabling
the VDUSE device to set the V1 API version by the end of the series.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/uapi/linux/vduse.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 10ad71aa00d6..ccb92a1efce0 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -10,6 +10,10 @@
 
 #define VDUSE_API_VERSION	0
 
+/* VQ groups and ASID support */
+
+#define VDUSE_API_VERSION_1	1
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
-- 
2.51.0

