Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE421C167
	for <virtualization@lists.linux.dev>; Thu,  7 Aug 2025 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567892; cv=none; b=U0D7+7ntmuy+Dg3hgVO7G1DykjvjJBLpVVrJb9LGe8JW9X0zaPd53Gwbr62Egq47HQeZhrA8xQfrajtNs8zfD10XlJWbWxCwBJk1wEqGHbd0nnNIu2+D+SyOcAN5jnZq2lJR/37O52wn03jWD0x9lIsytb1pWCM97D+3GtN+tG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567892; c=relaxed/simple;
	bh=Mq/AfDbkzeahYi6sN3Rcg3Dlb4puLIjsK36j9gN6tVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rlx6TMEbdJDYxsLhdXnpgg7Hbayx0cs75TmUsZ0htjU5x1KNMv/OEz/d+sce6VASoXgi/jurQM++TXequ4Dtu2HOZMN2Q7zfUca/QK8xjfnxB43VRR5K2Oh1XlHaS72w6Hiuj1id/qg97ly9fCY2oXqyMdE3TPHNvRryDlsZQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOfYhPj9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOfYhPj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754567888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahzdshQiL3Xzni/Jqm6kcPlFcj6smcBvlHHrtbsnZWI=;
	b=EOfYhPj9RVQopygMmMtrPqZ1XyaGhdNwm3WQVy2zoLjYmjjdvtuVjZHS1EvY8a0L9jiZgV
	NF2ZyEQLW/Pp/W3Lqpskh1ibKgLuo4AkfI9pkpCbLw3iEWCdW0nh3FpoGVr5P/RuqkoSAH
	iQ8VzcdLJYQodNAHWvi129xMMwcNuHk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-Oag-_5MMOTyREqWSAkLCtA-1; Thu,
 07 Aug 2025 07:58:05 -0400
X-MC-Unique: Oag-_5MMOTyREqWSAkLCtA-1
X-Mimecast-MFC-AGG-ID: Oag-_5MMOTyREqWSAkLCtA_1754567884
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C68E1956095;
	Thu,  7 Aug 2025 11:58:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 343C230001A5;
	Thu,  7 Aug 2025 11:57:58 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	jasowang@redhat.com,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [RFC v2 1/7] vduse: add v1 API definition
Date: Thu,  7 Aug 2025 13:57:46 +0200
Message-ID: <20250807115752.1663383-2-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-1-eperezma@redhat.com>
References: <20250807115752.1663383-1-eperezma@redhat.com>
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
index 68a627d04afa..9a56d0416bfe 100644
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
2.50.1

