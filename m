Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E21BC76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 19:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A9B040376;
	Mon, 10 Apr 2023 19:44:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A9B040376
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PGLBnnK9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VTvbHtZGf5IN; Mon, 10 Apr 2023 19:44:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9658F408C0;
	Mon, 10 Apr 2023 19:44:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9658F408C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 666ECC0037;
	Mon, 10 Apr 2023 19:44:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AEABC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5879F6FEEE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:44:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5879F6FEEE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PGLBnnK9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mufQJtfJaM9r
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:44:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E76AD6FE98
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E76AD6FE98
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681155848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7DwxFRRO+N9t4iCO4EwBINDyFHIhmYzbeXLYYi5MfE=;
 b=PGLBnnK9/pey2BvNTp/hOdRmxFZEsXb7F0xoC1bpC7iYNKAE3Mv/OA/gc/8sAZINi5+6Rf
 sDpMyqk/97Aa9ZLEf9O0gv853iwpAtPYxQ597zEtRWKamSBMsZR9VEXCOiodtxzLAHpQHm
 ggPswr9Izy8Nwf63ipd25U2DU0U7wOA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-BotenH_wOzK-O2IuuylawA-1; Mon, 10 Apr 2023 15:44:06 -0400
X-MC-Unique: BotenH_wOzK-O2IuuylawA-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg22-20020a05600c3c9600b003ef6ee937b8so342874wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 12:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681155845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7DwxFRRO+N9t4iCO4EwBINDyFHIhmYzbeXLYYi5MfE=;
 b=5vneA4tnkMyX5eQkE4aU+K9j/2z0DnTX7xOBLoqJ86V9wuib6g/tAwCqxetMZ7+/c0
 K1fl+k4keeLmuTbSkL3xuUCwxmVG7biI9KyWXBNESmTy3+t9WVzuxrifTbtJIWhl2TZN
 pWFPeMFic7pSm7Z8iKuiKwKcF/SG/5ZCpgu8niLg38iQGW1vuI9oO87jPILqdL8mypqZ
 hV92lesb+VS2TcBxJMQpNHdU1eTm3KlRSg6s64exXFjmOXxoPaYsLUeO4t1gAIw+LGwO
 J5TdRujEyRwzmReqAael5HH7wIK6Rq2Fb/C8q/9DfL12FpZXEmVvMiCyLlCHLWwzoR+K
 EUDA==
X-Gm-Message-State: AAQBX9evYVD2F5r7+VBB0+82xjAx8TTzNAsAno+3gNzdtdie0j4/nqBM
 hAtm1xrnNPUInXlmOto+X4DJBnjHWbWmk9EPpVluh6sOpbsGJ0aBPceU8OPLm1D5Kl2kQ0yD1xP
 632BZrRILUcIA3orbAoZSVws1kopCE3Gdu5PtQ7AuTg==
X-Received: by 2002:a5d:6b45:0:b0:2d9:eb77:90d2 with SMTP id
 x5-20020a5d6b45000000b002d9eb7790d2mr7201242wrw.70.1681155845245; 
 Mon, 10 Apr 2023 12:44:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350blHNuy+UJSBM/NhrqzKW2ktWbHKUdAfus2M3moACxyrbqG/jq+3UEjLAf9q3Um9GQ7CVrVEw==
X-Received: by 2002:a5d:6b45:0:b0:2d9:eb77:90d2 with SMTP id
 x5-20020a5d6b45000000b002d9eb7790d2mr7201229wrw.70.1681155844915; 
 Mon, 10 Apr 2023 12:44:04 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 u5-20020adff885000000b002c70851fdd8sm12508607wrp.75.2023.04.10.12.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 12:44:04 -0700 (PDT)
Date: Mon, 10 Apr 2023 15:44:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring
 changes
Message-ID: <20230410154035-mutt-send-email-mst@kernel.org>
References: <20230410112845.337212-1-mie@igel.co.jp>
 <20230410112845.337212-2-mie@igel.co.jp>
 <20230410080014-mutt-send-email-mst@kernel.org>
 <2023041055-provided-antiquely-bbdb@gregkh>
MIME-Version: 1.0
In-Reply-To: <2023041055-provided-antiquely-bbdb@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Mon, Apr 10, 2023 at 08:40:34PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 10, 2023 at 08:00:33AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
> > > Fix the build dependency for virtio_test. The virtio_ring that is used from
> > > the test requires container_of_const(). Change to use container_of.h kernel
> > > header directly and adapt related codes.
> > > 
> > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > 
> > This is only for next right? That's where container_of_const
> > things are I think ...
> 
> container_of_const() is in 6.2.


Absolutely but the patch switching virtio to that is not there.


> 
> > 
> > > ---
> > >  tools/include/linux/types.h   |  1 -
> > >  tools/virtio/linux/compiler.h |  2 ++
> > >  tools/virtio/linux/kernel.h   |  5 +----
> > >  tools/virtio/linux/module.h   |  1 -
> > >  tools/virtio/linux/uaccess.h  | 11 ++---------
> > >  5 files changed, 5 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> > > index 051fdeaf2670..f1896b70a8e5 100644
> > > --- a/tools/include/linux/types.h
> > > +++ b/tools/include/linux/types.h
> > > @@ -49,7 +49,6 @@ typedef __s8  s8;
> > >  #endif
> > >  
> > >  #define __force
> > > -#define __user
> 
> Why is this needed?
> 
> > >  #define __must_check
> > >  #define __cold
> > >  
> > > diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
> > > index 2c51bccb97bb..1f3a15b954b9 100644
> > > --- a/tools/virtio/linux/compiler.h
> > > +++ b/tools/virtio/linux/compiler.h
> > > @@ -2,6 +2,8 @@
> > >  #ifndef LINUX_COMPILER_H
> > >  #define LINUX_COMPILER_H
> > >  
> > > +#include "../../../include/linux/compiler_types.h"
> 
> While I understand your need to not want to duplicate code, what in the
> world is this doing?  Why not use the in-kernel compiler.h instead?  Why
> are you copying loads of .h files into tools/virtio/?  What is this for
> and why not just use the real files so you don't have to even attempt to
> try to keep things in sync (hint, they will always be out of sync.)

Because it's doing a very weird hack: building some kernel
code into a userspace binary, used for just for testing.
This is all not part of kernel build intentionally, no
one is supposed to use this binary in production, but
it was helpful in finding bugs in virtio core in the past
so I keep it around.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
