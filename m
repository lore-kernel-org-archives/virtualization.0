Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0FCC76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 08:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9772640B75;
	Tue, 11 Apr 2023 08:51:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9772640B75
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ceIR9II3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emyP7tSROSb9; Tue, 11 Apr 2023 08:51:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1806A40BA0;
	Tue, 11 Apr 2023 08:51:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1806A40BA0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA552C0037;
	Tue, 11 Apr 2023 08:51:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F1C4C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AD4540BA0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:51:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AD4540BA0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ARqF3BH1nWPl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:51:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4F4A40A38
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4F4A40A38
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:51:48 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2465a29476bso434872a91.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681203108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vp0eq9dOyQ9LiZivIOEX8Snc/Vjl4AGDIHEdpoo1Be8=;
 b=ceIR9II3v+3BnB4Ihj+HgwYOHoI8+5mu4QRYxIdgztNjPtegtY9Y75Ta9ZZTRSS7pu
 EO+pJY6xoZUWWjmeUf4kxW9M46nbPhjCVs7fDqbRb6+a2F2KFYWFEjPKenV5o0/tDbzZ
 2hjut1opqvsxh08oA2Xt3H0kaJb3rlZRF25e6F+kYg5yMuaUq5T+mXNvl4fjhSoKYthN
 qoufN0GkwduYauCqzl6ZsBu93Vgc2QcLYaKY4IglahJ8SzWCV1NDHg/aJgyUTq3UjC1U
 5vYY9MsQ9X9fE6S5apJv8YZyP7NziMpKbjXJRVUv3Lz6tPU121KyXV7TjtlGBKNz6cUb
 58aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681203108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vp0eq9dOyQ9LiZivIOEX8Snc/Vjl4AGDIHEdpoo1Be8=;
 b=wey1hH54ebrKADvkT06xBC7tXwQFQBuL6ugR8R7Lg5WhPLfjGzLg0puJsZeVpKenF7
 xJReKTAgf0VzpzTlU9J6K1b0iivI/lQuoZvQKXm6GYfELj5iOSG2jyiW1zdIAbz5ebCk
 L9MqgNX1RqBjtl7m6mhc5axUoHa7xcV1oWggmH2TQphC5HMlkVa4lgxrN7tY7XZTPBjT
 XohHMyMk8air5sEjYTe5VWRc7lPOc66IDXQRO46btlV2S/wfso2E/FFNd8z9qE1YiXym
 DVdDHQyI2LCdG8dLgDxUQs1NV9Wiy/Z0piOxd3o6L0FHK+zIK1USFRocElsHbQ1uYBP8
 JaCg==
X-Gm-Message-State: AAQBX9eGrQx48d8PB2ur/GOvfxrBL9Yruj89l3fB8yCSCFN9N82Sgofm
 ovDGwoN0b8svPXk029qSn4UIhw==
X-Google-Smtp-Source: AKy350bAfcx+pzEv0yDiZQWws7mo/brJGMxwoFip7atePKowBKAgBD/zeU+NkAFS3nD9N+aayYdqDg==
X-Received: by 2002:a62:483:0:b0:637:920c:25fd with SMTP id
 125-20020a620483000000b00637920c25fdmr5495471pfe.17.1681203108285; 
 Tue, 11 Apr 2023 01:51:48 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 e20-20020aa78c54000000b0059085684b54sm9573579pfd.140.2023.04.11.01.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Apr 2023 01:51:48 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 2/2] tools/virtio: fix build caused by virtio_ring changes
Date: Tue, 11 Apr 2023 17:51:39 +0900
Message-Id: <20230411085139.375393-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411085139.375393-1-mie@igel.co.jp>
References: <20230411085139.375393-1-mie@igel.co.jp>
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

Fix the build dependency for virtio_test. The virtio_ring that is used from
the test requires container_of_const(). Change to use container_of.h kernel
header directly and adapt related codes.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes from v2:
- Remove an unnecessary change
- Correct indentations
- Retrieve the __user definition to prevent any unintended side effects

 tools/include/linux/types.h   |  5 +++++
 tools/virtio/linux/compiler.h |  2 ++
 tools/virtio/linux/kernel.h   |  5 +----
 tools/virtio/linux/uaccess.h  | 11 ++---------
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 051fdeaf2670..8519386acd23 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -49,7 +49,12 @@ typedef __s8  s8;
 #endif
 
 #define __force
+/* This is defined in linux/compiler_types.h and is left for backward
+ * compatibility.
+ */
+#ifndef __user
 #define __user
+#endif
 #define __must_check
 #define __cold
 
diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 2c51bccb97bb..1f3a15b954b9 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -2,6 +2,8 @@
 #ifndef LINUX_COMPILER_H
 #define LINUX_COMPILER_H
 
+#include "../../../include/linux/compiler_types.h"
+
 #define WRITE_ONCE(var, val) \
 	(*((volatile typeof(val) *)(&(var))) = (val))
 
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 8b877167933d..6702008f7f5c 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -10,6 +10,7 @@
 #include <stdarg.h>
 
 #include <linux/compiler.h>
+#include "../../../include/linux/container_of.h"
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
diff --git a/tools/virtio/linux/uaccess.h b/tools/virtio/linux/uaccess.h
index 991dfb263998..f13828e0c409 100644
--- a/tools/virtio/linux/uaccess.h
+++ b/tools/virtio/linux/uaccess.h
@@ -6,15 +6,10 @@
 
 extern void *__user_addr_min, *__user_addr_max;
 
-static inline void __chk_user_ptr(const volatile void *p, size_t size)
-{
-	assert(p >= __user_addr_min && p + size <= __user_addr_max);
-}
-
 #define put_user(x, ptr)					\
 ({								\
 	typeof(ptr) __pu_ptr = (ptr);				\
-	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
+	__chk_user_ptr(__pu_ptr);				\
 	WRITE_ONCE(*(__pu_ptr), x);				\
 	0;							\
 })
@@ -22,7 +17,7 @@ static inline void __chk_user_ptr(const volatile void *p, size_t size)
 #define get_user(x, ptr)					\
 ({								\
 	typeof(ptr) __pu_ptr = (ptr);				\
-	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
+	__chk_user_ptr(__pu_ptr);				\
 	x = READ_ONCE(*(__pu_ptr));				\
 	0;							\
 })
@@ -37,7 +32,6 @@ static void volatile_memcpy(volatile char *to, const volatile char *from,
 static inline int copy_from_user(void *to, const void __user volatile *from,
 				 unsigned long n)
 {
-	__chk_user_ptr(from, n);
 	volatile_memcpy(to, from, n);
 	return 0;
 }
@@ -45,7 +39,6 @@ static inline int copy_from_user(void *to, const void __user volatile *from,
 static inline int copy_to_user(void __user volatile *to, const void *from,
 			       unsigned long n)
 {
-	__chk_user_ptr(to, n);
 	volatile_memcpy(to, from, n);
 	return 0;
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
