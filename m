Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0AEC433E0
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B774A22C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErOBBwYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B774A22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 747BB85550;
	Mon,  3 Aug 2020 20:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NaFxVYcwXPkZ; Mon,  3 Aug 2020 20:58:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E5F3F851CC;
	Mon,  3 Aug 2020 20:58:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D229BC0050;
	Mon,  3 Aug 2020 20:58:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D58DC004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6D4B385475
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nPIFudp+ROFc
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 616C18555A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eADcXnv6Prf/ROnr8oMM90J2NN3UdejeU8L0/V+Jmmg=;
 b=ErOBBwYMRbi2K63oGxIphhdjzWS1eS+v5jlK2hjT6k0YaXJM6LheK3yFTEHJM9lPbOT/Uy
 TLPhtMtzX2G0CN2oI/vuJltIf4pwLQvahVwkIvBtRgbbDGCu6Lq3VhbVc+ZST6NJG2+G0E
 z0lADD27QfwqtIePJLDKZjqsTd237ps=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-bNzGvYsdOb2gJ6niWK8OCg-1; Mon, 03 Aug 2020 16:58:50 -0400
X-MC-Unique: bNzGvYsdOb2gJ6niWK8OCg-1
Received: by mail-qv1-f71.google.com with SMTP id l18so8578918qvq.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eADcXnv6Prf/ROnr8oMM90J2NN3UdejeU8L0/V+Jmmg=;
 b=Gx51FQ1WW82SElNXgzpfR+uMuGlYpvYO9oyMJbHt2VZbCtfc+513j3zMKeVT+s/krl
 m3ubF8q1xGTkO/oYooSOmCnDcz4LSPHOofBGDL6Bxs97kK+/QCAg9RbifA+pNjY83j8f
 Eiq6NKNnhl5M2eLTpi66HctMjLFkH5TIu7WB7bGuIADxJk15MWWy2kO+uUU62+/8qAir
 G8j2Oar+k7H2g/XLy421jO/0VFx/5mr0t5lVERgDKbI0BVAgpXnABU2dKkhrI2qDlO+s
 FmMEt6qu9SOSYr6NDAkj5zeAtWzR//zv4Cqu/jK7JpGCycl4cCz16n+YD5MRWmLL8ol4
 mNXA==
X-Gm-Message-State: AOAM530ok3nR2NHqze1Y5fp3hWsNs9rYo+rxOSny00XAgEy6keUQZUsf
 UX37AkSpFcNDRwkextGAKXeN68mY3+BIIhsI6NdZpPCd2lOsR9jnMYeNI0T8P3NwhhncfCt7ZuB
 I2M3z1B49zxFp8Bya3JUdOeGycLJxZWvI/D5ozFjzKQ==
X-Received: by 2002:a37:a851:: with SMTP id r78mr9665291qke.419.1596488329775; 
 Mon, 03 Aug 2020 13:58:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8heGLu96UxNsBF036shtdOW0/9vkprVq03ErbRtZKSjOp34w1z+ivlgALOlXR/mUDEBkUDg==
X-Received: by 2002:a37:a851:: with SMTP id r78mr9665273qke.419.1596488329535; 
 Mon, 03 Aug 2020 13:58:49 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id e4sm23451075qts.57.2020.08.03.13.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:58:49 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:58:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
Message-ID: <20200803205814.540410-4-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Currently all config space fields are of the type __uXX.
This confuses people and some drivers (notably vdpa)
access them using CPU endian-ness - which only
works well for legacy or LE platforms.

Update virtio_cread/virtio_cwrite macros to allow __virtioXX
and __leXX field types. Follow-up patches will convert
config space to use these types.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 50 +++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 3b4eae5ac5e3..64da491936f7 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -6,6 +6,7 @@
 #include <linux/bug.h>
 #include <linux/virtio.h>
 #include <linux/virtio_byteorder.h>
+#include <linux/compiler_types.h>
 #include <uapi/linux/virtio_config.h>
 
 struct irq_affinity;
@@ -287,12 +288,57 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
 }
 
+/*
+ * Only the checker differentiates between __virtioXX and __uXX types. But we
+ * try to share as much code as we can with the regular GCC build.
+ */
+#if !defined(CONFIG_CC_IS_GCC) && !defined(__CHECKER__)
+
+/* Not a checker - we can keep things simple */
+#define __virtio_native_typeof(x) typeof(x)
+
+#else
+
+/*
+ * We build this out of a couple of helper macros in a vain attempt to
+ * help you keep your lunch down while reading it.
+ */
+#define __virtio_pick_value(x, type, then, otherwise)			\
+	__builtin_choose_expr(__same_type(x, type), then, otherwise)
+
+#define __virtio_pick_type(x, type, then, otherwise)			\
+	__virtio_pick_value(x, type, (then)0, otherwise)
+
+#define __virtio_pick_endian(x, x16, x32, x64, otherwise)			\
+	__virtio_pick_type(x, x16, __u16,					\
+		__virtio_pick_type(x, x32, __u32,				\
+			__virtio_pick_type(x, x64, __u64,			\
+				otherwise)))
+
+#define __virtio_native_typeof(x) typeof(					\
+	__virtio_pick_type(x, __u8, __u8,					\
+		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
+			__virtio_pick_endian(x, __le16, __le32, __le64,		\
+				__virtio_pick_endian(x, __u16, __u32, __u64,	\
+					/* No other type allowed */		\
+					(void)0)))))
+
+#endif
+
+#define __virtio_native_type(structname, member) \
+	__virtio_native_typeof(((structname*)0)->member)
+
+#define __virtio_typecheck(structname, member, val) \
+		/* Must match the member's type, and be integer */ \
+		typecheck(__virtio_native_type(structname, member), (val))
+
+
 /* Config space accessors. */
 #define virtio_cread(vdev, structname, member, ptr)			\
 	do {								\
 		might_sleep();						\
 		/* Must match the member's type, and be integer */	\
-		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
+		if (!__virtio_typecheck(structname, member, *(ptr)))	\
 			(*ptr) = 1;					\
 									\
 		switch (sizeof(*ptr)) {					\
@@ -322,7 +368,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 	do {								\
 		might_sleep();						\
 		/* Must match the member's type, and be integer */	\
-		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
+		if (!__virtio_typecheck(structname, member, *(ptr)))	\
 			BUG_ON((*ptr) == 1);				\
 									\
 		switch (sizeof(*ptr)) {					\
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
