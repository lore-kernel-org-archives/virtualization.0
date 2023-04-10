Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A66FC76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 18:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C86336101E;
	Mon, 10 Apr 2023 18:40:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C86336101E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=D1v1HtL/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YTWyIQ8R8WGg; Mon, 10 Apr 2023 18:40:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3CDCE60B70;
	Mon, 10 Apr 2023 18:40:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CDCE60B70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D6ECC0036;
	Mon, 10 Apr 2023 18:40:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C56ABC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 18:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 918D760E71
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 18:40:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 918D760E71
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f-nUJAbU8z2X
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 18:40:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF42460B70
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF42460B70
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 18:40:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C74B060FE9;
 Mon, 10 Apr 2023 18:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A647C433D2;
 Mon, 10 Apr 2023 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1681152038;
 bh=CEumz/eTP+jhMBEKqKdxMNZV4N36XqtpwtVfHVW/X10=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D1v1HtL/Wi1mNHXkHrp00OaWyjInAa/gwzaylMhwUSREq64rDgN1HHTnRWYDNptBF
 1Neu/xkVQu6TPjERkV5ASRz/hraMMlcK62khJEPMvE7/i7USlsuCXbB8/ZDsET84My
 GQ8xPxhVBuEgBrFgwnjALPgYI1D8EAI4afo1SpTc=
Date: Mon, 10 Apr 2023 20:40:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring
 changes
Message-ID: <2023041055-provided-antiquely-bbdb@gregkh>
References: <20230410112845.337212-1-mie@igel.co.jp>
 <20230410112845.337212-2-mie@igel.co.jp>
 <20230410080014-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230410080014-mutt-send-email-mst@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
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

On Mon, Apr 10, 2023 at 08:00:33AM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
> > Fix the build dependency for virtio_test. The virtio_ring that is used from
> > the test requires container_of_const(). Change to use container_of.h kernel
> > header directly and adapt related codes.
> > 
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> 
> This is only for next right? That's where container_of_const
> things are I think ...

container_of_const() is in 6.2.


> 
> > ---
> >  tools/include/linux/types.h   |  1 -
> >  tools/virtio/linux/compiler.h |  2 ++
> >  tools/virtio/linux/kernel.h   |  5 +----
> >  tools/virtio/linux/module.h   |  1 -
> >  tools/virtio/linux/uaccess.h  | 11 ++---------
> >  5 files changed, 5 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> > index 051fdeaf2670..f1896b70a8e5 100644
> > --- a/tools/include/linux/types.h
> > +++ b/tools/include/linux/types.h
> > @@ -49,7 +49,6 @@ typedef __s8  s8;
> >  #endif
> >  
> >  #define __force
> > -#define __user

Why is this needed?

> >  #define __must_check
> >  #define __cold
> >  
> > diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
> > index 2c51bccb97bb..1f3a15b954b9 100644
> > --- a/tools/virtio/linux/compiler.h
> > +++ b/tools/virtio/linux/compiler.h
> > @@ -2,6 +2,8 @@
> >  #ifndef LINUX_COMPILER_H
> >  #define LINUX_COMPILER_H
> >  
> > +#include "../../../include/linux/compiler_types.h"

While I understand your need to not want to duplicate code, what in the
world is this doing?  Why not use the in-kernel compiler.h instead?  Why
are you copying loads of .h files into tools/virtio/?  What is this for
and why not just use the real files so you don't have to even attempt to
try to keep things in sync (hint, they will always be out of sync.)

> > +
> >  #define WRITE_ONCE(var, val) \
> >  	(*((volatile typeof(val) *)(&(var))) = (val))
> >  
> > diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> > index 8b877167933d..6702008f7f5c 100644
> > --- a/tools/virtio/linux/kernel.h
> > +++ b/tools/virtio/linux/kernel.h
> > @@ -10,6 +10,7 @@
> >  #include <stdarg.h>
> >  
> >  #include <linux/compiler.h>
> > +#include "../../../include/linux/container_of.h"

Either do this for all .h files, or not, don't pick and choose.



> >  #include <linux/log2.h>
> >  #include <linux/types.h>
> >  #include <linux/overflow.h>
> > @@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
> >  	free((void *)addr);
> >  }
> >  
> > -#define container_of(ptr, type, member) ({			\
> > -	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
> > -	(type *)( (char *)__mptr - offsetof(type,member) );})
> > -
> >  # ifndef likely
> >  #  define likely(x)	(__builtin_expect(!!(x), 1))
> >  # endif
> > diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
> > index 9dfa96fea2b2..5cf39167d47a 100644
> > --- a/tools/virtio/linux/module.h
> > +++ b/tools/virtio/linux/module.h
> > @@ -4,4 +4,3 @@
> >  #define MODULE_LICENSE(__MODULE_LICENSE_value) \
> >  	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
> >  		__MODULE_LICENSE_value
> > -

This change has nothing to do with what you said was happening in this
patch :(

Please be more careful.

> > diff --git a/tools/virtio/linux/uaccess.h b/tools/virtio/linux/uaccess.h
> > index 991dfb263998..cde2c344b260 100644
> > --- a/tools/virtio/linux/uaccess.h
> > +++ b/tools/virtio/linux/uaccess.h
> > @@ -6,15 +6,10 @@
> >  
> >  extern void *__user_addr_min, *__user_addr_max;
> >  
> > -static inline void __chk_user_ptr(const volatile void *p, size_t size)
> > -{
> > -	assert(p >= __user_addr_min && p + size <= __user_addr_max);
> > -}
> > -

What does this function have to do with container_of()?


> >  #define put_user(x, ptr)					\
> >  ({								\
> >  	typeof(ptr) __pu_ptr = (ptr);				\
> > -	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
> > +	__chk_user_ptr(__pu_ptr);		\

Why are you trying to duplicate in-kernel .h files?

This all doesn't look ok, sorry.

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
