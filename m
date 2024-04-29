Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ACA3D96A
	for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385670; cv=none; b=a81dvd3SdQVEcq1gygwVFfvHxXjyu6SQtigP3fsmBAhKp489vqdQJHv/NAuw/U3fmjNksVqHOPiAeUfC4pL+6Dy3QQmYGoa5Qd/Xi6oZeBWE9ufKKBkV7BSfdzIhmXLRAzfZ30jgj7c+1HOJY5/XkiW8rnh+7zY3JnJqM+T7OAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385670; c=relaxed/simple;
	bh=wPCxHih6c1vg4MIhCKlt1UClyyDOfohtXqvQUkMZ+Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iB8rPxQBGPvt5tq47qZhPYAtcbr/nmemphJSwzXRJ12GkYS1KhpsrKewAedOr8oMJU+9k8roBwW9mSeH0jFDbMPV6g3MTL5TcxT8porlOs+hRAQb8xvasZb/5UXpM1dfVE25Fswlojhxg/JPJq6GyhDYARDAcC1GLRKV0EQth40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdaL0bgJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdaL0bgJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714385668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVxg8KMA7vvgaacJi4UzbU3rBDHOjF9aejTpYpkSnrY=;
	b=BdaL0bgJbGQttAXI9rgdJa1cVrlEVOIv/78cNezd/+Z/BK4m8x7M7isGqLbMMdkDvJCQkM
	nXFewo7gsxds62qS497ujvgYhBawfQFPAZc7yb9dsEup8sg6nf3rJhvBiFUIEDjAAptjHq
	kEL30qiAFUgAU9dCOgfquZbmTzrdATw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-1Oyf9mrDPxefgbDRlG6VsQ-1; Mon, 29 Apr 2024 06:14:24 -0400
X-MC-Unique: 1Oyf9mrDPxefgbDRlG6VsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75E8F8032FA;
	Mon, 29 Apr 2024 10:14:24 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A6111C060D0;
	Mon, 29 Apr 2024 10:14:22 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 4/4] vhost: Reformat vhost_{get, put}_user()
Date: Mon, 29 Apr 2024 20:14:00 +1000
Message-ID: <20240429101400.617007-5-gshan@redhat.com>
In-Reply-To: <20240429101400.617007-1-gshan@redhat.com>
References: <20240429101400.617007-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Reformat the macros to use tab as the terminator for each line so
that it looks clean.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 60 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4ddb9ec2fe46..c1ed5e750521 100644
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

