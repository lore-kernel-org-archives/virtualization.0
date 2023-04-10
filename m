Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99C6C77B70
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 12:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3593141675;
	Mon, 10 Apr 2023 12:00:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3593141675
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c46DTXfD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-h-FRBJIrzN; Mon, 10 Apr 2023 12:00:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 593C34162C;
	Mon, 10 Apr 2023 12:00:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 593C34162C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35102C0037;
	Mon, 10 Apr 2023 12:00:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C890C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 12:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4711A81F00
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 12:00:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4711A81F00
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c46DTXfD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mo2606eZUYT5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 12:00:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D57381EE1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D57381EE1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 12:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681128042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uYbUcWzmnC6xP9q2tfvKVDk2jXko1XUr34Hbcal4y6Q=;
 b=c46DTXfDGc9bYVLb3/ZrdT15FvjRSnOgyFugoL000545hnFhtlEnnlrKwVhX1K1bI1hCoO
 hQHRQmp1qCTvRMEyRyCjAa7PoDz5BpnRHzKlcL8nCV4/7LpaDaeGHpyJ3hGMqNy6p0JiMr
 dzl0N/YjrrGlTBBaNgEVqkDdEvNFo1k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-YBbyXSYaMQ6Eh6IRjucAKQ-1; Mon, 10 Apr 2023 08:00:38 -0400
X-MC-Unique: YBbyXSYaMQ6Eh6IRjucAKQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 u12-20020a05600c19cc00b003f07be0e96bso1770529wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 05:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681128037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYbUcWzmnC6xP9q2tfvKVDk2jXko1XUr34Hbcal4y6Q=;
 b=07U5yVN6Alhm4N+o9+0XqKvxq9eyxaz1AcrQZU+9UuJdlnUA0DRQbE7RryvdVgJpFo
 s3EBt81XKq1ZRTxIb7nzDUwICgvUAD/xol3smBGlA+qcU3uhzcvhn09DV724Ubcok0Dn
 zbSPtdBloNsmOlTddeRuXF1OyZkQN6gZ40h/89j22DonrIr969Ff6Op+8ahXW/O32Vb6
 q2z0B0roqxrcwqmRY3UTGsI74gOx+x4Suf88t22o37rGE+SrM8GOQbdxZPrqHHznCZtZ
 KTIN9L+sqwFuD7jYxrTp5c4CBKht6riZkm64gmyKp1eVNr+E4VJfx+Rnqi90gAN9d2P0
 Z4Pw==
X-Gm-Message-State: AAQBX9cV3m1apxv0DBIyMbg0S41fjnQo2wZbKRTekc9pzdAV4OA6tVV1
 WKBGY1Bq7LlFX9v63t8GngfHgoPe2L7HX/UunEdGNTxfQXVYG7XF1DBSKvB/cuN0GuxY/WEzogu
 g8sCNDVxhwjkxzwxoXkQBlu5HDzWn7kDHTgVleHNz0g==
X-Received: by 2002:a7b:cd87:0:b0:3ee:19b4:a2e6 with SMTP id
 y7-20020a7bcd87000000b003ee19b4a2e6mr7360853wmj.19.1681128037673; 
 Mon, 10 Apr 2023 05:00:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350a/ArrmW82/z+jHxJ0CUCu9vS40m/5App8/Nk02/y7YrRf//bQIyH2736FsQOU3Nm36El47iQ==
X-Received: by 2002:a7b:cd87:0:b0:3ee:19b4:a2e6 with SMTP id
 y7-20020a7bcd87000000b003ee19b4a2e6mr7360831wmj.19.1681128037322; 
 Mon, 10 Apr 2023 05:00:37 -0700 (PDT)
Received: from redhat.com ([2.52.31.213]) by smtp.gmail.com with ESMTPSA id
 q5-20020a7bce85000000b003ede3e54ed7sm13521872wmj.6.2023.04.10.05.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 05:00:36 -0700 (PDT)
Date: Mon, 10 Apr 2023 08:00:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring
 changes
Message-ID: <20230410080014-mutt-send-email-mst@kernel.org>
References: <20230410112845.337212-1-mie@igel.co.jp>
 <20230410112845.337212-2-mie@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <20230410112845.337212-2-mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
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

On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
> Fix the build dependency for virtio_test. The virtio_ring that is used from
> the test requires container_of_const(). Change to use container_of.h kernel
> header directly and adapt related codes.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

This is only for next right? That's where container_of_const
things are I think ...

> ---
>  tools/include/linux/types.h   |  1 -
>  tools/virtio/linux/compiler.h |  2 ++
>  tools/virtio/linux/kernel.h   |  5 +----
>  tools/virtio/linux/module.h   |  1 -
>  tools/virtio/linux/uaccess.h  | 11 ++---------
>  5 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> index 051fdeaf2670..f1896b70a8e5 100644
> --- a/tools/include/linux/types.h
> +++ b/tools/include/linux/types.h
> @@ -49,7 +49,6 @@ typedef __s8  s8;
>  #endif
>  
>  #define __force
> -#define __user
>  #define __must_check
>  #define __cold
>  
> diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
> index 2c51bccb97bb..1f3a15b954b9 100644
> --- a/tools/virtio/linux/compiler.h
> +++ b/tools/virtio/linux/compiler.h
> @@ -2,6 +2,8 @@
>  #ifndef LINUX_COMPILER_H
>  #define LINUX_COMPILER_H
>  
> +#include "../../../include/linux/compiler_types.h"
> +
>  #define WRITE_ONCE(var, val) \
>  	(*((volatile typeof(val) *)(&(var))) = (val))
>  
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 8b877167933d..6702008f7f5c 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -10,6 +10,7 @@
>  #include <stdarg.h>
>  
>  #include <linux/compiler.h>
> +#include "../../../include/linux/container_of.h"
>  #include <linux/log2.h>
>  #include <linux/types.h>
>  #include <linux/overflow.h>
> @@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
>  	free((void *)addr);
>  }
>  
> -#define container_of(ptr, type, member) ({			\
> -	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
> -	(type *)( (char *)__mptr - offsetof(type,member) );})
> -
>  # ifndef likely
>  #  define likely(x)	(__builtin_expect(!!(x), 1))
>  # endif
> diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
> index 9dfa96fea2b2..5cf39167d47a 100644
> --- a/tools/virtio/linux/module.h
> +++ b/tools/virtio/linux/module.h
> @@ -4,4 +4,3 @@
>  #define MODULE_LICENSE(__MODULE_LICENSE_value) \
>  	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
>  		__MODULE_LICENSE_value
> -
> diff --git a/tools/virtio/linux/uaccess.h b/tools/virtio/linux/uaccess.h
> index 991dfb263998..cde2c344b260 100644
> --- a/tools/virtio/linux/uaccess.h
> +++ b/tools/virtio/linux/uaccess.h
> @@ -6,15 +6,10 @@
>  
>  extern void *__user_addr_min, *__user_addr_max;
>  
> -static inline void __chk_user_ptr(const volatile void *p, size_t size)
> -{
> -	assert(p >= __user_addr_min && p + size <= __user_addr_max);
> -}
> -
>  #define put_user(x, ptr)					\
>  ({								\
>  	typeof(ptr) __pu_ptr = (ptr);				\
> -	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
> +	__chk_user_ptr(__pu_ptr);		\
>  	WRITE_ONCE(*(__pu_ptr), x);				\
>  	0;							\
>  })
> @@ -22,7 +17,7 @@ static inline void __chk_user_ptr(const volatile void *p, size_t size)
>  #define get_user(x, ptr)					\
>  ({								\
>  	typeof(ptr) __pu_ptr = (ptr);				\
> -	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
> +	__chk_user_ptr(__pu_ptr);		\
>  	x = READ_ONCE(*(__pu_ptr));				\
>  	0;							\
>  })
> @@ -37,7 +32,6 @@ static void volatile_memcpy(volatile char *to, const volatile char *from,
>  static inline int copy_from_user(void *to, const void __user volatile *from,
>  				 unsigned long n)
>  {
> -	__chk_user_ptr(from, n);
>  	volatile_memcpy(to, from, n);
>  	return 0;
>  }
> @@ -45,7 +39,6 @@ static inline int copy_from_user(void *to, const void __user volatile *from,
>  static inline int copy_to_user(void __user volatile *to, const void *from,
>  			       unsigned long n)
>  {
> -	__chk_user_ptr(to, n);
>  	volatile_memcpy(to, from, n);
>  	return 0;
>  }
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
