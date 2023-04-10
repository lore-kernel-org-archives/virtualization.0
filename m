Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75B1C77B61
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 09:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A41440017;
	Mon, 10 Apr 2023 09:24:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A41440017
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=XWmBIi7g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UgTPTxOpKZgw; Mon, 10 Apr 2023 09:24:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CF37B408BD;
	Mon, 10 Apr 2023 09:24:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF37B408BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82609C0037;
	Mon, 10 Apr 2023 09:24:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8ADFC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 90BB9610EE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:24:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 90BB9610EE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=XWmBIi7g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nVlwzK7fyzUT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:24:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8270560B43
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8270560B43
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:24:26 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id h24so4339087plr.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681118665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bf5bveb+ux4A6UqkD/1l5g+psrLw8BnlaeaDh2PpD9g=;
 b=XWmBIi7gc16NVFGgnHOQOJSQ+Yvhu3RtDTX+FnMBMfo7p0o/V9vknY67SFTGmwOTEL
 gMHKvguortA40zG42HOvhcHI0zCdfX+ErKzqx06+NPmOJzy4cbc7hUE+zG51OhhT6s1g
 OXOK+80SUGN1J52TdCEXNTYo5wMdcirrw7eNv+cfNLqou5aPk/0mdks33Cj4oK/yJWur
 f37xX5H2gIagX7OHTpu42RmKRwKMCPiXC9Pi3DD+z8kwCBRJCqKsWnzNgmrV6T8zub+0
 k+dBUYcaCSxwUuWGJ5AN2MJuKHT40B4PN1eqIQLlmoVvA5Mx/AqxC/NUCS7+MmAvKGNb
 oqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681118665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bf5bveb+ux4A6UqkD/1l5g+psrLw8BnlaeaDh2PpD9g=;
 b=HYclg9A8L7NETI7TdvD9xyYwa1pJ60AgHfKjZrY4110nwo3w+f60HvXKUgb2ldMLbg
 ++7o82izmL1LjO3ayt312Ex+c6Szi6GXl03FDkxE/JoGdeTczPla0dtlRuXTrE3OrTLO
 5eC8+KqreV7FYWiLp7rkSLUzKiKVhd48QpwxWjC3bgNk7Ucl1saFoAT1RnMZtWRfhGYI
 YB2sUNtBTWiaYMhPjJLoGc9TfVHl6Y0StAo9HkBSK0wPbGOGT8d8dyyITSipfOh/2Jbi
 CGmGsemn3zMryTGBEHeQxD/IdOZfX1SLt6WqrgChuI4oG/6pJAacOSm0xsRp6dTjtQfa
 yQCg==
X-Gm-Message-State: AAQBX9enC4RRI283eqai7HRlWbM0JG7wMk7zkLFHoRcIQtTdsgIxA+3s
 XheOuFX7kOXQy9mK1yldRuwRCQ==
X-Google-Smtp-Source: AKy350YfQaZVFEQLwC/r29BiDxuJxEj2g8fTOfEoogL7h4DUBMApctGUgORL7Ak29eFjlUtBLd6KNQ==
X-Received: by 2002:a17:90a:e7c2:b0:240:1014:a1b3 with SMTP id
 kb2-20020a17090ae7c200b002401014a1b3mr12349661pjb.35.1681118665654; 
 Mon, 10 Apr 2023 02:24:25 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 k91-20020a17090a4ce400b00246b1b4a3ffsm1179217pjh.0.2023.04.10.02.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 02:24:25 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] tools/virtio: fix build caused by virtio_ring changes
Date: Mon, 10 Apr 2023 18:24:19 +0900
Message-Id: <20230410092419.302932-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Shunsuke Mie <mie@igel.co.jp>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Fix the build dependency for virtio_test. virtio_ring requires
container_of_const() and struce device.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 tools/include/linux/container_of.h | 36 ++++++++++++++++++++++++++++++
 tools/virtio/linux/compiler.h      |  3 +++
 tools/virtio/linux/kernel.h        |  5 +----
 tools/virtio/linux/module.h        |  1 +
 4 files changed, 41 insertions(+), 4 deletions(-)
 create mode 100644 tools/include/linux/container_of.h

diff --git a/tools/include/linux/container_of.h b/tools/include/linux/container_of.h
new file mode 100644
index 000000000000..06e293b7cfda
--- /dev/null
+++ b/tools/include/linux/container_of.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CONTAINER_OF_H
+#define _LINUX_CONTAINER_OF_H
+
+#include <linux/build_bug.h>
+#include <linux/stddef.h>
+
+/**
+ * container_of - cast a member of a structure out to the containing structure
+ * @ptr:	the pointer to the member.
+ * @type:	the type of the container struct this is embedded in.
+ * @member:	the name of the member within the struct.
+ *
+ * WARNING: any const qualifier of @ptr is lost.
+ */
+#define container_of(ptr, type, member) ({				\
+	void *__mptr = (void *)(ptr);					\
+	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
+		      __same_type(*(ptr), void),			\
+		      "pointer type mismatch in container_of()");	\
+	((type *)(__mptr - offsetof(type, member))); })
+
+/**
+ * container_of_const - cast a member of a structure out to the containing
+ *			structure and preserve the const-ness of the pointer
+ * @ptr:		the pointer to the member
+ * @type:		the type of the container struct this is embedded in.
+ * @member:		the name of the member within the struct.
+ */
+#define container_of_const(ptr, type, member)				\
+	_Generic(ptr,							\
+		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
+		default: ((type *)container_of(ptr, type, member))	\
+	)
+
+#endif	/* _LINUX_CONTAINER_OF_H */
diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 2c51bccb97bb..ac27b3ea6e67 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -8,4 +8,7 @@
 #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
 
 #define __aligned(x) __attribute((__aligned__(x)))
+
+#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
+
 #endif
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 8b877167933d..3cd20cb92649 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -10,6 +10,7 @@
 #include <stdarg.h>
 
 #include <linux/compiler.h>
+#include <linux/container_of.h>
 #include <linux/log2.h>
 #include <linux/types.h>
 #include <linux/overflow.h>
@@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
 	free((void *)addr);
 }
 
-#define container_of(ptr, type, member) ({			\
-	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
-	(type *)( (char *)__mptr - offsetof(type,member) );})
-
 # ifndef likely
 #  define likely(x)	(__builtin_expect(!!(x), 1))
 # endif
diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
index 9dfa96fea2b2..e2e791dbd104 100644
--- a/tools/virtio/linux/module.h
+++ b/tools/virtio/linux/module.h
@@ -5,3 +5,4 @@
 	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
 		__MODULE_LICENSE_value
 
+struct device;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
