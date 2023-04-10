Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81055C76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 11:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 065D981F27;
	Mon, 10 Apr 2023 11:29:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 065D981F27
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=pHUTQCfU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GweR3q7Is17o; Mon, 10 Apr 2023 11:28:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5D46D81E3E;
	Mon, 10 Apr 2023 11:28:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D46D81E3E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 360F8C0037;
	Mon, 10 Apr 2023 11:28:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DC75C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD0FF400A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:28:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD0FF400A6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=pHUTQCfU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id itwi0WUCujyU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:28:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 381DF40A84
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 381DF40A84
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:28:56 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id v9so9220435pjk.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 04:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681126135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ciKrq/Yl42ou0lRDT5MfvrbGiLHmmyRP4TLMhDsCh3E=;
 b=pHUTQCfUpVOzEVF3sbeGEFofvk8HKR084Iuw9uH3ue1A1DXQkdvSN7E1r/f0nsyBHv
 12OZBvKgalq4gXCq+/xdu1ZYptVV+6nl4eLwujelCO1/slbckVk5Nds8t2ciDnEmkp6l
 9iXB1xsuI7Bp3t2r6PGF/ZhXm/YJnGCRdID0OSkNLqwPn41oMdnaqxRyv715xL69+Y4w
 G2ZKpwHWawQ5Hx4ZMIcJ42tmPn1cS6oWcf74xcoGBFZOM3y2TakpG1YszImHJOseHHZN
 808esbtEb4eYLyNDVXhHLmPB/930ezbU9cbnW4cHD1wi8L5T+cVl1gB0Ok22EKca4RM/
 vNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681126135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciKrq/Yl42ou0lRDT5MfvrbGiLHmmyRP4TLMhDsCh3E=;
 b=iPycQ9nV+E+aohXnTj71pOlLm+VX3loPEM+UN2zhvoPR5WRansmXDfBXpeJREUh5ly
 Erg1CX6muMNv/+SopKZYdheMXotwK6gR56XzI3zPTo7yXuQeaQvlHwop6KpeWK6PPEpu
 XpMkJefgBIu0T9bcEF0PqahqtIhFl4XNwkYBKMveS/RwJbETYg7m8mV6F8ZMWxbYU7OC
 DNVS1gFJ6kmRTQLdsefyQyvp4X2lTie+hwett7m+zqXeB9sL2895QQu5Fl9w14Q85+rG
 DDJtqzcAzJ8N8FG498Kt16Aw0Rkzt/vDrMRMHh93/N49l5B1HUMKoUMm3bWfvyaVT5F6
 Z8+A==
X-Gm-Message-State: AAQBX9dseYbOVtwWjUYA0gnXBaftUz4M79LsokjWb0zmHSpSP8A+L1Ms
 Br12UG7Doy/vxInFN2LWzcT01A==
X-Google-Smtp-Source: AKy350ZpKKAzldtZX1peVNJtayz/p4zL8IKT/lEfnP6SxlT3XHUUF2eamZZCkR+RV1yHIP6Ue5NOqQ==
X-Received: by 2002:a17:902:e852:b0:1a5:684:7fda with SMTP id
 t18-20020a170902e85200b001a506847fdamr15595169plg.59.1681126135587; 
 Mon, 10 Apr 2023 04:28:55 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a1709027c8b00b0019c919bccf8sm7575052pll.86.2023.04.10.04.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 04:28:55 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring changes
Date: Mon, 10 Apr 2023 20:28:45 +0900
Message-Id: <20230410112845.337212-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410112845.337212-1-mie@igel.co.jp>
References: <20230410112845.337212-1-mie@igel.co.jp>
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
 tools/include/linux/types.h   |  1 -
 tools/virtio/linux/compiler.h |  2 ++
 tools/virtio/linux/kernel.h   |  5 +----
 tools/virtio/linux/module.h   |  1 -
 tools/virtio/linux/uaccess.h  | 11 ++---------
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 051fdeaf2670..f1896b70a8e5 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -49,7 +49,6 @@ typedef __s8  s8;
 #endif
 
 #define __force
-#define __user
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
diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
index 9dfa96fea2b2..5cf39167d47a 100644
--- a/tools/virtio/linux/module.h
+++ b/tools/virtio/linux/module.h
@@ -4,4 +4,3 @@
 #define MODULE_LICENSE(__MODULE_LICENSE_value) \
 	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
 		__MODULE_LICENSE_value
-
diff --git a/tools/virtio/linux/uaccess.h b/tools/virtio/linux/uaccess.h
index 991dfb263998..cde2c344b260 100644
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
+	__chk_user_ptr(__pu_ptr);		\
 	WRITE_ONCE(*(__pu_ptr), x);				\
 	0;							\
 })
@@ -22,7 +17,7 @@ static inline void __chk_user_ptr(const volatile void *p, size_t size)
 #define get_user(x, ptr)					\
 ({								\
 	typeof(ptr) __pu_ptr = (ptr);				\
-	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
+	__chk_user_ptr(__pu_ptr);		\
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
