Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C95FC7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 06:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A52CE81E53;
	Tue, 11 Apr 2023 06:38:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A52CE81E53
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T3UgJh22
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SIjEOiDHdQLb; Tue, 11 Apr 2023 06:38:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2891781E83;
	Tue, 11 Apr 2023 06:38:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2891781E83
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04B56C0037;
	Tue, 11 Apr 2023 06:38:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F1DCC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5BC5A410B5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:38:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BC5A410B5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T3UgJh22
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZICKxBS4A44
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:38:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AF80410B2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AF80410B2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681195082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKDcI1gvQ3K+wzH4N+4hPHJptgLgRNp4guou9vuTChs=;
 b=T3UgJh22Rhd7mBY5qk5fL+OyaXc6NDYG7aMg0aZr0qyAVPt9/T3hFJA7fELeRbIqYLDaEx
 1Wx5EdSIiBsXBqeAcbXzVHg09Nj+eNYOcfJJA5YLgZZ5KStxdIJeMYR1ub//qcQxrqtc1k
 zdIVuFKTuDdzr7s5oHQVW2Nj7LAZTSg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-XK0xwigMPpmnpQil-G_AUw-1; Tue, 11 Apr 2023 02:38:00 -0400
X-MC-Unique: XK0xwigMPpmnpQil-G_AUw-1
Received: by mail-wm1-f71.google.com with SMTP id
 k4-20020a05600c1c8400b003f08ed470c2so656945wms.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 23:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681195079;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKDcI1gvQ3K+wzH4N+4hPHJptgLgRNp4guou9vuTChs=;
 b=VfQUSc3Dy8P/19OUnwAxYFKVM6cT03OQ45E5/V1YjLifwfWfsLvKdoULxvxPzurumQ
 LchAXfw4O5qu8KOs6MzW5lV3cM0UEvsyeUHkPFjjFpXQJcjOl1ssYmwAIjWwgSJg6XHb
 GDvIQvhit7lb0xWzjpw1kLGCt1P/Og2cEDMRHrwZVLR9Efq4FWq0Bj0/AnvC7HqAALb0
 gWOjpYVqP/LOUTHvqj06ebVRT6gczGPG8B4XCVrgk+GUcYve7T66XKRe+Al+5p+IBTBo
 AoUIgO4gYosUO9THqbmxSGELJNj9GvoMW4emU2T3xLSScNSZ64GyyuG75UkT2GA92qI+
 fifw==
X-Gm-Message-State: AAQBX9f0qEieUszzYjkGpfYbURMykvD4k4g0KHEzpwfm4rrQ7Full3Ac
 M21muCGQ+xTAS5Jznqu5DrPkxRBI0C+RyzchnBJ4Hn5zlgpOAGZ6M4ZhfKrPIV9pQNJip2VAueL
 EnbeZBMAel7znKPVG+B3iJd7Sk+I242sbvKIT5eya2Q==
X-Received: by 2002:a05:600c:21c8:b0:3ed:bc83:3745 with SMTP id
 x8-20020a05600c21c800b003edbc833745mr8213664wmj.25.1681195079717; 
 Mon, 10 Apr 2023 23:37:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350YXNewQyOu43+eG068hYZmpbH+ChoY9dkJCHQTitIMFv54+uzJLrVQF3Nod5Uvn4pUYmyhunw==
X-Received: by 2002:a05:600c:21c8:b0:3ed:bc83:3745 with SMTP id
 x8-20020a05600c21c800b003edbc833745mr8213650wmj.25.1681195079399; 
 Mon, 10 Apr 2023 23:37:59 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 p15-20020a1c740f000000b003edc11c2ecbsm15990461wmc.4.2023.04.10.23.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 23:37:58 -0700 (PDT)
Date: Tue, 11 Apr 2023 02:37:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring
 changes
Message-ID: <20230411023026-mutt-send-email-mst@kernel.org>
References: <20230410112845.337212-1-mie@igel.co.jp>
 <20230410112845.337212-2-mie@igel.co.jp>
 <20230410080014-mutt-send-email-mst@kernel.org>
 <2023041055-provided-antiquely-bbdb@gregkh>
 <20230410154035-mutt-send-email-mst@kernel.org>
 <de392fbd-3ffd-466d-cc7f-32f55c03227f@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <de392fbd-3ffd-466d-cc7f-32f55c03227f@igel.co.jp>
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

On Tue, Apr 11, 2023 at 12:25:39PM +0900, Shunsuke Mie wrote:
> 
> On 2023/04/11 4:44, Michael S. Tsirkin wrote:
> > On Mon, Apr 10, 2023 at 08:40:34PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Apr 10, 2023 at 08:00:33AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
> > > > > Fix the build dependency for virtio_test. The virtio_ring that is used from
> > > > > the test requires container_of_const(). Change to use container_of.h kernel
> > > > > header directly and adapt related codes.
> > > > > 
> > > > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > > This is only for next right? That's where container_of_const
> > > > things are I think ...
> > > container_of_const() is in 6.2.
> > 
> > Absolutely but the patch switching virtio to that is not there.
> > 
> > 
> > > > > ---
> > > > >   tools/include/linux/types.h   |  1 -
> > > > >   tools/virtio/linux/compiler.h |  2 ++
> > > > >   tools/virtio/linux/kernel.h   |  5 +----
> > > > >   tools/virtio/linux/module.h   |  1 -
> > > > >   tools/virtio/linux/uaccess.h  | 11 ++---------
> > > > >   5 files changed, 5 insertions(+), 15 deletions(-)
> > > > > 
> > > > > diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> > > > > index 051fdeaf2670..f1896b70a8e5 100644
> > > > > --- a/tools/include/linux/types.h
> > > > > +++ b/tools/include/linux/types.h
> > > > > @@ -49,7 +49,6 @@ typedef __s8  s8;
> > > > >   #endif
> > > > >   #define __force
> > > > > -#define __user
> > > Why is this needed?
> > > 
> > > > >   #define __must_check
> > > > >   #define __cold
> > > > > diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
> > > > > index 2c51bccb97bb..1f3a15b954b9 100644
> > > > > --- a/tools/virtio/linux/compiler.h
> > > > > +++ b/tools/virtio/linux/compiler.h
> > > > > @@ -2,6 +2,8 @@
> > > > >   #ifndef LINUX_COMPILER_H
> > > > >   #define LINUX_COMPILER_H
> > > > > +#include "../../../include/linux/compiler_types.h"
> > > While I understand your need to not want to duplicate code, what in the
> > > world is this doing?  Why not use the in-kernel compiler.h instead?  Why
> > > are you copying loads of .h files into tools/virtio/?  What is this for
> > > and why not just use the real files so you don't have to even attempt to
> > > try to keep things in sync (hint, they will always be out of sync.)
> > Because it's doing a very weird hack: building some kernel
> > code into a userspace binary, used for just for testing.
> > This is all not part of kernel build intentionally, no
> > one is supposed to use this binary in production, but
> > it was helpful in finding bugs in virtio core in the past
> > so I keep it around.
> Would it be possible to switch to in-kernel tests, such as KUnit? If it's
> possible, we could use the kernel headers and implementations as they are,
> and we could address the concerns that Greg raised I think.
> 
> 
> Best regards,
> 
> Shunsuke

I think your patch is fine as is. Using kunit is certainly possible,
but won't be a small project. tools/virtio was always a quick
hack to help experiment quickly, so I'm not worried by it being
broken often - whoever wants to play with it next, fixes it up.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
