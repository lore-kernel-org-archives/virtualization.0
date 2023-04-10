Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80ACC76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 10:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EF74610E7;
	Mon, 10 Apr 2023 10:58:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6EF74610E7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aXcycqtu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ONvE_Yxfg8oa; Mon, 10 Apr 2023 10:58:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B72E760ACA;
	Mon, 10 Apr 2023 10:58:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B72E760ACA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FE22C0036;
	Mon, 10 Apr 2023 10:58:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FBD3C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7480B80C0E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:58:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7480B80C0E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aXcycqtu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jkfifAjofWh1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:58:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 441B480C08
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 441B480C08
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681124309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glOAAMls6WC16IZVydxUU2GkS2QJLlWvNTuOfRiQfL8=;
 b=aXcycqtu4JK4OmP9vdbAduF3rcKyL1o0HNwcegLnB2mZoGmUuYDY/4XnlwfJ9WAj0B8yOP
 iebl5kkO+QC1u56S8AovrannVUInQqSltMQ9tHE06C6HVE/hADT/GcksnHAZxeeJ2NKAIU
 orr/O734MwUHy8wEge3AI7xGnKSEXII=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-juiARHdlNi2ahvzXzZk7vw-1; Mon, 10 Apr 2023 06:58:28 -0400
X-MC-Unique: juiARHdlNi2ahvzXzZk7vw-1
Received: by mail-wr1-f70.google.com with SMTP id
 r4-20020adfa144000000b002db44581302so573216wrr.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 03:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681124307;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=glOAAMls6WC16IZVydxUU2GkS2QJLlWvNTuOfRiQfL8=;
 b=0RxotQMI8RUG3TVwFXQAX1L1lsU3LHxeo6Wv1QkGEN1NHaaCBsiN2cJB08oNKplmdg
 xVLmmP3wPAZM13xLVkgvrsmJdo6bKc7/yvccY78Csl92Ys2YLTcr6bLpj1qoM7/lZl+G
 KHZau/EfTFoHVkszkO/9WSy48uT3Z1UL3lKPXcGijrmpP6iEaXuCob17FziB/xZ7M7j2
 vDZ2sq+Ry4lyUrj5UUezrhe7aXxRc3vkHEPkn60jRKUUORN5AERAcsZb/+cs++n8+6YP
 DDHu12uGdmtKD1DluFO3Nwog6CJQLgN9O/NjPwlZSBI0AwqBx40JI3suvNT/ioKjY21D
 e2cg==
X-Gm-Message-State: AAQBX9ekBMfGI0In22bv9NkvWVg8dTMcxpWeByJYksGhHmeghAwuOtaz
 rY+uPxg93jKoVFQjQ0ZXKU3qsMx2/ExKjlayklZdkqWwa9nJ/USkCYhtvJKlrncMTd7mz1wTi0x
 CUnlZKdB0gOs5YrnQNy+VbDrftNuFmGK593FBMoCSlA==
X-Received: by 2002:a5d:464b:0:b0:2f2:4790:fccc with SMTP id
 j11-20020a5d464b000000b002f24790fcccmr1018181wrs.46.1681124306904; 
 Mon, 10 Apr 2023 03:58:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350bd4fswTngv9D8LVrb2rgueB7iNvpSrMfQhv6Yla9+QGzfcDApE0HVt8YaNSvpM/0ua8VPkHg==
X-Received: by 2002:a5d:464b:0:b0:2f2:4790:fccc with SMTP id
 j11-20020a5d464b000000b002f24790fcccmr1018171wrs.46.1681124306593; 
 Mon, 10 Apr 2023 03:58:26 -0700 (PDT)
Received: from redhat.com ([2.52.31.213]) by smtp.gmail.com with ESMTPSA id
 n5-20020adfe345000000b002efb139ce72sm8423812wrj.36.2023.04.10.03.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 03:58:26 -0700 (PDT)
Date: Mon, 10 Apr 2023 06:58:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [PATCH] tools/virtio: fix build caused by virtio_ring changes
Message-ID: <20230410064435-mutt-send-email-mst@kernel.org>
References: <20230410092419.302932-1-mie@igel.co.jp>
 <20230410054259-mutt-send-email-mst@kernel.org>
 <cd2619b1-5d0b-1e7e-12bd-bcb9dcb5c533@igel.co.jp>
 <a7332e82-27f6-8acd-2ff2-498eb66ea6e7@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <a7332e82-27f6-8acd-2ff2-498eb66ea6e7@igel.co.jp>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Apr 10, 2023 at 07:56:13PM +0900, Shunsuke Mie wrote:
> =

> On 2023/04/10 19:00, Shunsuke Mie wrote:
> > =

> > On 2023/04/10 18:46, Michael S. Tsirkin wrote:
> > > On Mon, Apr 10, 2023 at 06:24:19PM +0900, Shunsuke Mie wrote:
> > > > Fix the build dependency for virtio_test. virtio_ring requires
> > > > container_of_const() and struce device.
> > > > =

> > > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > > ---
> > > > =A0 tools/include/linux/container_of.h | 36
> > > > ++++++++++++++++++++++++++++++
> > > > =A0 tools/virtio/linux/compiler.h=A0=A0=A0=A0=A0 |=A0 3 +++
> > > > =A0 tools/virtio/linux/kernel.h=A0=A0=A0=A0=A0=A0=A0 |=A0 5 +----
> > > > =A0 tools/virtio/linux/module.h=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> > > > =A0 4 files changed, 41 insertions(+), 4 deletions(-)
> > > > =A0 create mode 100644 tools/include/linux/container_of.h
> > > > =

> > > > diff --git a/tools/include/linux/container_of.h
> > > > b/tools/include/linux/container_of.h
> > > > new file mode 100644
> > > > index 000000000000..06e293b7cfda
> > > > --- /dev/null
> > > > +++ b/tools/include/linux/container_of.h
> > > > @@ -0,0 +1,36 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef _LINUX_CONTAINER_OF_H
> > > > +#define _LINUX_CONTAINER_OF_H
> > > > +
> > > > +#include <linux/build_bug.h>
> > > > +#include <linux/stddef.h>
> > > > +
> > > > +/**
> > > > + * container_of - cast a member of a structure out to the
> > > > containing structure
> > > > + * @ptr:=A0=A0=A0 the pointer to the member.
> > > > + * @type:=A0=A0=A0 the type of the container struct this is embedd=
ed in.
> > > > + * @member:=A0=A0=A0 the name of the member within the struct.
> > > > + *
> > > > + * WARNING: any const qualifier of @ptr is lost.
> > > > + */
> > > > +#define container_of(ptr, type, member) ({=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 \
> > > > +=A0=A0=A0 void *__mptr =3D (void *)(ptr);=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
> > > > +=A0=A0=A0 static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|=A0=A0=A0 \
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __same_type(*(ptr), void),=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "pointer type mismatch in =
container_of()"); \
> > > > +=A0=A0=A0 ((type *)(__mptr - offsetof(type, member))); })
> > > > +
> > > > +/**
> > > > + * container_of_const - cast a member of a structure out to the
> > > > containing
> > > > + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 structure and preserve the con=
st-ness of the pointer
> > > > + * @ptr:=A0=A0=A0=A0=A0=A0=A0 the pointer to the member
> > > > + * @type:=A0=A0=A0=A0=A0=A0=A0 the type of the container struct th=
is is embedded in.
> > > > + * @member:=A0=A0=A0=A0=A0=A0=A0 the name of the member within the=
 struct.
> > > > + */
> > > > +#define container_of_const(ptr, type, member) \
> > > > +=A0=A0=A0 _Generic(ptr,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
> > > > +=A0=A0=A0=A0=A0=A0=A0 const typeof(*(ptr)) *: ((const type
> > > > *)container_of(ptr, type, member)),\
> > > > +=A0=A0=A0=A0=A0=A0=A0 default: ((type *)container_of(ptr, type, me=
mber)) \
> > > > +=A0=A0=A0 )
> > > > +
> > > > +#endif=A0=A0=A0 /* _LINUX_CONTAINER_OF_H */
> > > =

> > > Please just do
> > > #include "../../../include/linux/container_of.h"
> > > instead.
> > Okey, I'll do that.
> > > =

> > > =

> > > > diff --git a/tools/virtio/linux/compiler.h
> > > > b/tools/virtio/linux/compiler.h
> > > > index 2c51bccb97bb..ac27b3ea6e67 100644
> > > > --- a/tools/virtio/linux/compiler.h
> > > > +++ b/tools/virtio/linux/compiler.h
> > > > @@ -8,4 +8,7 @@
> > > > =A0 #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
> > > > =A0 =A0 #define __aligned(x) __attribute((__aligned__(x)))
> > > > +
> > > > +#define __same_type(a, b)
> > > > __builtin_types_compatible_p(typeof(a), typeof(b))
> > > > +
> > > > =A0 #endif
> > > #include "../../../include/linux/compiler_types.h" instead?
> > I'll try it.
> > > > diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kerne=
l.h
> > > > index 8b877167933d..3cd20cb92649 100644
> > > > --- a/tools/virtio/linux/kernel.h
> > > > +++ b/tools/virtio/linux/kernel.h
> > > > @@ -10,6 +10,7 @@
> > > > =A0 #include <stdarg.h>
> > > > =A0 =A0 #include <linux/compiler.h>
> > > > +#include <linux/container_of.h>
> > > > =A0 #include <linux/log2.h>
> > > > =A0 #include <linux/types.h>
> > > > =A0 #include <linux/overflow.h>
> > > > @@ -107,10 +108,6 @@ static inline void free_page(unsigned long add=
r)
> > > > =A0=A0=A0=A0=A0 free((void *)addr);
> > > > =A0 }
> > > > =A0 -#define container_of(ptr, type, member) ({=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \
> > > > -=A0=A0=A0 const typeof( ((type *)0)->member ) *__mptr =3D (ptr);=
=A0=A0=A0 \
> > > > -=A0=A0=A0 (type *)( (char *)__mptr - offsetof(type,member) );})
> > > > -
> > > > =A0 # ifndef likely
> > > > =A0 #=A0 define likely(x)=A0=A0=A0 (__builtin_expect(!!(x), 1))
> > > > =A0 # endif
> > > > diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/modul=
e.h
> > > > index 9dfa96fea2b2..e2e791dbd104 100644
> > > > --- a/tools/virtio/linux/module.h
> > > > +++ b/tools/virtio/linux/module.h
> > > > @@ -5,3 +5,4 @@
> > > > =A0=A0=A0=A0=A0 static __attribute__((unused)) const char
> > > > *__MODULE_LICENSE_name =3D \
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 __MODULE_LICENSE_value
> > > > =A0 +struct device;
> > > =

> > > It's not there in include/linux/module - pls put it in the
> > > same here where it is for linux.
> > I understood. I'll add some files that has the definition.
> =

> In vringh.c, 'struct device' is used in virtio_ring.h. Upon investigating
> the preprocessed file, it was
> =

> discovered that 'struct device' is defined in bitmap.h, which is included
> from architecture-specific headers.
> =

> On x86, the nesting includes
> =

> 'linux/module.h' -> ... -> 'arch/x86/include/asm/msr.h' ->
> 'arch/x86/include/asm/cpumask.h' -> 'linux/cpumask.h' -> 'linux/bitmap.h'.
> =

> Could you advise on the appropriate way to include this file?

Let's just add struct device; in virtio_ring.h, make it
self-sufficient.


> > > > -- =

> > > > 2.25.1
> > =

> > Best regards,
> > =

> > Shunsuke.
> > =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
