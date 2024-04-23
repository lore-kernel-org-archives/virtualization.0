Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054221A0D
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842673; cv=none; b=FIftScP6zY8vkouWnzIazZgdipAXjDwdQ286IoJJuGbxHWyfGmeC5HlzlZoY5UAiyOCsF0iSRARzxg6bZpfX3NVZAige6eYZt5VfBeMmUXxD52eUwiRlSAfLVmM1hC1O2mgPs8fgJhC8FTpeNIbSpmkhkDWCOTZZsyJOW1llB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842673; c=relaxed/simple;
	bh=5MVVIcDipqgJAk3mCYyyzSHu50ImzAuTrQ9oKbZbq3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OILiDGxD883XSDrUR4RrZtFZ+l4ab5uF5nwRonXrLiLP4DZ8v1rS3puXcwRsYhcp1VuqSoNbww8I0kCRspTYEVJ+WPINg5giHEchbcF/SMobcICnW4NaXUSHBRvKKaO8JFq6bl9SMA1BV4zZZu5K2Rx3JQRFeaVcCxw1kWBDF9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyye18At; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyye18At"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713842671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtMGrJ3CLLK0RMLaaz/XukLZE22bi0+EJWg0qr8z6dw=;
	b=eyye18AtjV1XZVRTMVp2vACyR4SE7OpJVf8m0Ov97uXq72o0g+Fp7GLVj7pQA+VRCfxlM0
	A2/PiceKNaNtNdF51g1iboMNcmx+CU2OFS7YhfhOxn2csJduWeImnt6WJUn4mwtZwU/4so
	NRwIsRRZg87Q4w0EiAK3HpIMafxeMF0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-NjVT6l0HMT-_YCt94dPB7Q-1; Mon,
 22 Apr 2024 23:24:26 -0400
X-MC-Unique: NjVT6l0HMT-_YCt94dPB7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 615C11C068C0;
	Tue, 23 Apr 2024 03:24:26 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FA181BDAA;
	Tue, 23 Apr 2024 03:24:23 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH 4/4] vhost: Reformat vhost_{get, put}_user()
Date: Tue, 23 Apr 2024 13:24:07 +1000
Message-ID: <20240423032407.262329-5-gshan@redhat.com>
In-Reply-To: <20240423032407.262329-1-gshan@redhat.com>
References: <20240423032407.262329-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Reformat the macros to use tab as the terminator for each line so
that it looks clean.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 60 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a3de9325175f..3be19877f9df 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1207,21 +1207,22 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	return __vhost_get_user_slow(vq, addr, size, type);
 }
 
-#define vhost_put_user(vq, x, ptr)		\
-({ \
-	int ret; \
-	if (!vq->iotlb) { \
-		ret = __put_user(x, ptr); \
-	} else { \
-		__typeof__(ptr) to = \
+#define vhost_put_user(vq, x, ptr)					\
+({									\
+	int ret;							\
+	if (!vq->iotlb) {						\
+		ret = __put_user(x, ptr);				\
+	} else {							\
+		__typeof__(ptr) to =					\
 			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
-					  sizeof(*ptr), VHOST_ADDR_USED); \
-		if (to != NULL) \
-			ret = __put_user(x, to); \
-		else \
-			ret = -EFAULT;	\
-	} \
-	ret; \
+						sizeof(*ptr),		\
+						VHOST_ADDR_USED);	\
+		if (to != NULL)						\
+			ret = __put_user(x, to);			\
+		else							\
+			ret = -EFAULT;					\
+	}								\
+	ret;								\
 })
 
 static inline int vhost_put_avail_event(struct vhost_virtqueue *vq)
@@ -1252,22 +1253,21 @@ static inline int vhost_put_used_idx(struct vhost_virtqueue *vq)
 			      &vq->used->idx);
 }
 
-#define vhost_get_user(vq, x, ptr, type)		\
-({ \
-	int ret; \
-	if (!vq->iotlb) { \
-		ret = __get_user(x, ptr); \
-	} else { \
-		__typeof__(ptr) from = \
-			(__typeof__(ptr)) __vhost_get_user(vq, ptr, \
-							   sizeof(*ptr), \
-							   type); \
-		if (from != NULL) \
-			ret = __get_user(x, from); \
-		else \
-			ret = -EFAULT; \
-	} \
-	ret; \
+#define vhost_get_user(vq, x, ptr, type)				\
+({									\
+	int ret;							\
+	if (!vq->iotlb) {						\
+		ret = __get_user(x, ptr);				\
+	} else {							\
+		__typeof__(ptr) from =					\
+			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
+						sizeof(*ptr), type);	\
+		if (from != NULL)					\
+			ret = __get_user(x, from);			\
+		else							\
+			ret = -EFAULT;					\
+	}								\
+	ret;								\
 })
 
 #define vhost_get_avail(vq, x, ptr) \
-- 
2.44.0

