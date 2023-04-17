Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802A6C77B61
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 02:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C14E822BF;
	Mon, 17 Apr 2023 02:20:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C14E822BF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=gzd7vt8C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qvqxjehwWvgF; Mon, 17 Apr 2023 02:20:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9C76B822A8;
	Mon, 17 Apr 2023 02:20:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C76B822A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79323C0036;
	Mon, 17 Apr 2023 02:20:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 451B9C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E42D418E3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:20:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E42D418E3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=gzd7vt8C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id It1m3jr9Zc-s
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:20:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB1F64190F
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB1F64190F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:20:54 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 k36-20020a17090a4ca700b0024770df9897so3237840pjh.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1681698054; x=1684290054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHvjQtUaREpSNyWBXjrmpBHAA+Syp+wBJ3S8TK4rHhQ=;
 b=gzd7vt8CRFhl98tPP49VyB5QhIOFyk9OiW0U77waZv3q+sOEbugYPjOn/2iUXm0J9k
 1D5Gl2oUiWxGUgQvVeJL87XGL8ty19ACOYM96FoUlVmfkijsGOt8ZQvXd/IrYy2aAEZs
 RilTj1yls3LrbdYlne7PkVMKt29zbfFYL2YcYLeZ+NG03PPlLhd+gOd7rfgVYj3tUUo1
 U48f/4sql08oEcqAPUAz3Nf2T+jn5RYDLfItg5xyHfbUGZEAQF3qkP4ozcEVAVZYfQ4A
 q3nYU/NllkG0YuHZQMuTAVIDNgcIGrKxCd4LhkgMbO1zPkV0lao/fl10wx3kgHYs5ilP
 i4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681698054; x=1684290054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHvjQtUaREpSNyWBXjrmpBHAA+Syp+wBJ3S8TK4rHhQ=;
 b=CwB5qnmRHt9xfzoIDK5KEljTuN0n6NsyjyBM3LMri36FzRYGbL/UuCYh0pVRTBcTUP
 Iz0xuXJ0Fpd9Su1CtR+o605V+kVIwe9uy1MaBpndqhAEUrw2+F2e9BQt3CosKnCzixgm
 a4bEDiApiMLbd6x35496kcksAXorM09aj+gc0OAulG8eTIGm427auQ4YqvCPVmx0BGod
 NgmZjpy9XJOfvsRDpil0B3HUxe3Y21R+wSfWAXjRAU33vm9TxcJNSSAfmaoTABfpaPEg
 SKhDHNLZeSHDUxMUYzQsTEXmkrT4m0CHv7ZgGypzZQQ+FHMYs+yv6CN+zz0V+cKElGV8
 WRmw==
X-Gm-Message-State: AAQBX9dpIwtkL305zMjnYHLDfjgsPfWs4myzmDK7BxEmkFKyiI/1+2n4
 lYjw2kcu4j7/RVblbn3EvekyUw==
X-Google-Smtp-Source: AKy350aUg/+byQRor+Xmx6jST3kydOARIy/gQeW6fnd1F/PWGpwEXFO2dl8KlBBtOUb75i/bl/lLTw==
X-Received: by 2002:a17:902:d40c:b0:1a6:712c:24c5 with SMTP id
 b12-20020a170902d40c00b001a6712c24c5mr9035249ple.69.1681698053769; 
 Sun, 16 Apr 2023 19:20:53 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a170902e98400b001a68986a3d8sm6195243plb.24.2023.04.16.19.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Apr 2023 19:20:53 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 RESEND 2/2] tools/virtio: fix build caused by virtio_ring
 changes
Date: Mon, 17 Apr 2023 11:20:37 +0900
Message-Id: <20230417022037.917668-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417022037.917668-1-mie@igel.co.jp>
References: <20230417022037.917668-1-mie@igel.co.jp>
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
Changes from v2: https://lore.kernel.org/virtualization/20230410112845.337212-2-mie@igel.co.jp/
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
