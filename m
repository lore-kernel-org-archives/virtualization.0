Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743CFC77B61
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 09:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF5E561119;
	Mon, 10 Apr 2023 09:46:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF5E561119
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sn0CmEcd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IZcc5P1IFAR9; Mon, 10 Apr 2023 09:46:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 59D5160E7C;
	Mon, 10 Apr 2023 09:46:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59D5160E7C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 311CAC0037;
	Mon, 10 Apr 2023 09:46:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB26C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 006DD4098F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:46:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 006DD4098F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sn0CmEcd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pwl-KZAMs02g
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:46:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2B61408BD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2B61408BD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681120005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUKnqMQGG9884/VZ+x9wYRorx2PFxtJF40gE4kS2CUs=;
 b=Sn0CmEcdhGzyqrQ484nODuMtJwQVfdELeMpkwDOiodo59vEcYY598d9S+q9Z3kh6/EtFni
 pnPa25/7jIVClivlXnW7YeBWj3hNrIGrGPWcFyxaRGMhVQ9QzkfNxLJD4F8aoxyLxmfvRv
 Slvx+cjPP3+jlCxtfqS5pXRNXDzSZaY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-Z_tkMc-KOz2alz0Gv1aeJQ-1; Mon, 10 Apr 2023 05:46:44 -0400
X-MC-Unique: Z_tkMc-KOz2alz0Gv1aeJQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 v24-20020adf8b58000000b002efb0d72c77so724060wra.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 02:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681120003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUKnqMQGG9884/VZ+x9wYRorx2PFxtJF40gE4kS2CUs=;
 b=WKjOEY7tWYq6shIPeK+g0uADz4QJYtwPjSgQtStLUcBospRwH5PdxcrxJ1tKWXu/o7
 F7DnL2RteAy6pPCzHtzPsNXFLwENPMD+zI9hs37LHfOPM/X5UYHKBGHKtHD+OhOS7q+1
 eD9lVzA8QdLmyS3/DeqAI0lsN9tlOaoSceshw0+3IqR7Mi+W2b/5aG/XnNqtH7FlNwPq
 EfrvPPw+dQSyqmvdAwHBIpfsyk4OfgI+UrW6W3/Pf/Zg/97zfn0kQVrw8AmL5N1+t73P
 SDcqYFoJYFoDphWoYn0qjhYTczcYJORpDsVPvKa4eLWgUMKcrOICoKhVO4cTO7UK0MGJ
 tVzw==
X-Gm-Message-State: AAQBX9dsACC4Z0AYNYeLavC6Bmqd8Ric1q9DKptzUuQRdfIEH4L0KDSc
 IDAbCrHcJBKQFy/R/2BkBLz9HEosGUVyPyF67r/GSpoSqtJlAtCHEkJwsHE7ycka/5VN4y9Nzkl
 6GVieBkP5oWDx83er9nPDxwJuyQP9ywpws1mmKytANg==
X-Received: by 2002:a1c:4c09:0:b0:3eb:2de8:b739 with SMTP id
 z9-20020a1c4c09000000b003eb2de8b739mr6936527wmf.37.1681120002997; 
 Mon, 10 Apr 2023 02:46:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yz2fT9NWgRbXeQa18dRGnweg6kZuzRjdxbvB//hO+uRDL3F6E5geHe+Z0GWDjCUgmQjPJsZQ==
X-Received: by 2002:a1c:4c09:0:b0:3eb:2de8:b739 with SMTP id
 z9-20020a1c4c09000000b003eb2de8b739mr6936511wmf.37.1681120002685; 
 Mon, 10 Apr 2023 02:46:42 -0700 (PDT)
Received: from redhat.com ([2.52.31.213]) by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c4fd300b003ef7058ea02sm17043791wmq.29.2023.04.10.02.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 02:46:42 -0700 (PDT)
Date: Mon, 10 Apr 2023 05:46:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [PATCH] tools/virtio: fix build caused by virtio_ring changes
Message-ID: <20230410054259-mutt-send-email-mst@kernel.org>
References: <20230410092419.302932-1-mie@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <20230410092419.302932-1-mie@igel.co.jp>
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

On Mon, Apr 10, 2023 at 06:24:19PM +0900, Shunsuke Mie wrote:
> Fix the build dependency for virtio_test. virtio_ring requires
> container_of_const() and struce device.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  tools/include/linux/container_of.h | 36 ++++++++++++++++++++++++++++++
>  tools/virtio/linux/compiler.h      |  3 +++
>  tools/virtio/linux/kernel.h        |  5 +----
>  tools/virtio/linux/module.h        |  1 +
>  4 files changed, 41 insertions(+), 4 deletions(-)
>  create mode 100644 tools/include/linux/container_of.h
> 
> diff --git a/tools/include/linux/container_of.h b/tools/include/linux/container_of.h
> new file mode 100644
> index 000000000000..06e293b7cfda
> --- /dev/null
> +++ b/tools/include/linux/container_of.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CONTAINER_OF_H
> +#define _LINUX_CONTAINER_OF_H
> +
> +#include <linux/build_bug.h>
> +#include <linux/stddef.h>
> +
> +/**
> + * container_of - cast a member of a structure out to the containing structure
> + * @ptr:	the pointer to the member.
> + * @type:	the type of the container struct this is embedded in.
> + * @member:	the name of the member within the struct.
> + *
> + * WARNING: any const qualifier of @ptr is lost.
> + */
> +#define container_of(ptr, type, member) ({				\
> +	void *__mptr = (void *)(ptr);					\
> +	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
> +		      __same_type(*(ptr), void),			\
> +		      "pointer type mismatch in container_of()");	\
> +	((type *)(__mptr - offsetof(type, member))); })
> +
> +/**
> + * container_of_const - cast a member of a structure out to the containing
> + *			structure and preserve the const-ness of the pointer
> + * @ptr:		the pointer to the member
> + * @type:		the type of the container struct this is embedded in.
> + * @member:		the name of the member within the struct.
> + */
> +#define container_of_const(ptr, type, member)				\
> +	_Generic(ptr,							\
> +		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
> +		default: ((type *)container_of(ptr, type, member))	\
> +	)
> +
> +#endif	/* _LINUX_CONTAINER_OF_H */


Please just do
#include "../../../include/linux/container_of.h"
instead.


> diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
> index 2c51bccb97bb..ac27b3ea6e67 100644
> --- a/tools/virtio/linux/compiler.h
> +++ b/tools/virtio/linux/compiler.h
> @@ -8,4 +8,7 @@
>  #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
>  
>  #define __aligned(x) __attribute((__aligned__(x)))
> +
> +#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
> +
>  #endif

#include "../../../include/linux/compiler_types.h" instead?

> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 8b877167933d..3cd20cb92649 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -10,6 +10,7 @@
>  #include <stdarg.h>
>  
>  #include <linux/compiler.h>
> +#include <linux/container_of.h>
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
> index 9dfa96fea2b2..e2e791dbd104 100644
> --- a/tools/virtio/linux/module.h
> +++ b/tools/virtio/linux/module.h
> @@ -5,3 +5,4 @@
>  	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
>  		__MODULE_LICENSE_value
>  
> +struct device;


It's not there in include/linux/module - pls put it in the
same here where it is for linux.

> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
