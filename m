Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0911F33D4E2
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711974; cv=none; b=E776wIa32ACPICHjWE5P23OH1/BdcbunqqDEo/f+iV8cHlS1Lno+2VUEzN9uHhHPzzcvZPeA5F5ZjTwdK/tFmvpz1tJe6Bu0jD1/FlinvZifBHdBXuEhOCCSvMWexX5yag2rnVZJamBQqx7ZkpuFKA0pvZbQCnF9mBhD2/8VCIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711974; c=relaxed/simple;
	bh=uFpL5eRW8+htLVAVbGFETpVE+6W1D2CxV0yn7T6mBEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2fQ3lqOeoTdr0lgQOt7wqoJk+qif9Iv6dinVcR/NQ2daopWustgavblVlnda/fHmAF3EWW/6pLc5D3zOZR3jQiBVBN4zV9hbOe8k6/g7n2M3fodtoMqzz6S/zWsYjwYufPtfN0CVAlmA8f5A7uqURGkekSfk7YrFpsQsAm6K1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dnAQcHF2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnAQcHF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770711972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukQsl7MiUaGkU01iV0sC+F/eoBfXFXSkK4DaVtbp3Yw=;
	b=dnAQcHF2epxbV/flIQVreV+0a1cot8Ec1LMcMHa2hpzqWkEgFvZw5o6mgcgsvTs4e1ydCz
	buwTjVg1datH6xwdnKE1ar63RErSrjgmBiv/UvkzxihFEGPSZIhYNDVobAm0YUS5OBcSWx
	dIXPv1uYibe78XYw6iE8u7ei1WHpKb0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-VTgWqw49PEqIwa33Z1R_LQ-1; Tue,
 10 Feb 2026 03:26:10 -0500
X-MC-Unique: VTgWqw49PEqIwa33Z1R_LQ-1
X-Mimecast-MFC-AGG-ID: VTgWqw49PEqIwa33Z1R_LQ_1770711969
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8196A19560AA;
	Tue, 10 Feb 2026 08:26:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5B491956053;
	Tue, 10 Feb 2026 08:26:05 +0000 (UTC)
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
Subject: [PATCH v2 2/5] vduse: Add API v2 definition
Date: Tue, 10 Feb 2026 09:25:51 +0100
Message-ID: <20260210082554.1582553-3-eperezma@redhat.com>
In-Reply-To: <20260210082554.1582553-1-eperezma@redhat.com>
References: <20260210082554.1582553-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: C4BINAiOFo21NZvY1HkkmVvW5xvtq72vKxV86NYCKTU_1770711969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce the definition for VDUSE API V2.  This version serves as a
gateway for feature negotiation.

The kernel uses this version to determine if the userspace device
supports feature flags. Devices that do not explicitly negotiate API V2
will be blocked from querying available VDUSE features, ensuring
backward compatibility.

The next patches implement the new feature incrementally, only enabling
the VDUSE device to set the V2 API version by the end of the series.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/uapi/linux/vduse.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 361eea511c21..27832d46084c 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -14,6 +14,10 @@
 
 #define VDUSE_API_VERSION_1	1
 
+/* Features support */
+
+#define VDUSE_API_VERSION_2	2
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
-- 
2.53.0

