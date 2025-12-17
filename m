Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11E32573A
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970674; cv=none; b=EB+zqGIQ7vgS2Vl7w5gTTCilWXgcioLDyofoRLvX0XyhXfsHIOBgiVmDsj6eV/9HHT0CY2z6oW7Qb8xOw61571JYm5LxSywivf8VahSV+xFRXZ6gxr3bRLqdw5rnQSYeaWiTHOoKnqOz0WKAIYeDdAe/E60KL8LOeeZyGH3XCwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970674; c=relaxed/simple;
	bh=5ECYxaYeBJVIOWeqy/iDdDa/H00cLiMfLM4EhoJhPCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUx9uWCpWCsb3InJxOVoVKg2846ERup0dLpIrns8DTByWA+l2R/9fjdWIHr8FVfchbbQLU4XdOgK4U5nqs1s9SmTjyjNEbJqquXoCd43ytVHPFJlcO4NoukV+G/7GwXUalHPiApChpm/gkQh2NK3cm0JW+Hpzw8x4Hcfrb1SKrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=be4qoz1q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="be4qoz1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765970669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5hO8Psqd6yn9uKa/WLE0Q8XbzNZAyPQD8caCcDa5fs=;
	b=be4qoz1qmu04nmPjA3sDYcwOcUg93dU1xyDGYiXg/9Ndgcx8PwVMtQvl1lj2Snh3/wzYis
	epV+gxV0RmjoLUSsRdQnKwbsgXIqla4TdgYSq/h2H4yBNmjnFh0HZHq+8ZGMlkKnmePpbo
	p6dFqrzmfFofWsSrSdYbxhBCWQk5Y88=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-M-yN3yq3O6eWjd8qp_mwMw-1; Wed,
 17 Dec 2025 06:24:26 -0500
X-MC-Unique: M-yN3yq3O6eWjd8qp_mwMw-1
X-Mimecast-MFC-AGG-ID: M-yN3yq3O6eWjd8qp_mwMw_1765970665
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F32F0180028B;
	Wed, 17 Dec 2025 11:24:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 781D5180045B;
	Wed, 17 Dec 2025 11:24:21 +0000 (UTC)
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
Subject: [PATCH v10 1/8] vduse: add v1 API definition
Date: Wed, 17 Dec 2025 12:24:07 +0100
Message-ID: <20251217112414.2374672-2-eperezma@redhat.com>
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

This allows the kernel to detect whether the userspace VDUSE device
supports the VQ group and ASID features.  VDUSE devices that don't set
the V1 API will not receive the new messages, and vdpa device will be
created with only one vq group and asid.

The next patches implement the new feature incrementally, only enabling
the VDUSE device to set the V1 API version by the end of the series.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
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
2.52.0

