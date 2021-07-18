Return-Path: <SRS0=cta8=MK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8D2C636CA
	for <virtualization@archiver.kernel.org>; Sun, 18 Jul 2021 02:09:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B436108B
	for <virtualization@archiver.kernel.org>; Sun, 18 Jul 2021 02:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B436108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C8804053D;
	Sun, 18 Jul 2021 02:09:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m3tQqRZN16LM; Sun, 18 Jul 2021 02:09:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1DDA3401C6;
	Sun, 18 Jul 2021 02:09:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEFAFC001A;
	Sun, 18 Jul 2021 02:09:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C82DBC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Jul 2021 02:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A22C540103
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Jul 2021 02:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Q9FvA-YfFJW
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Jul 2021 02:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 594BB400E3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Jul 2021 02:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626574161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gpM2d5Iuvyh50YGnyAEB1mGNqLkDz1f1Frpy8iBXokw=;
 b=Q8+Pr+1USYC4SWUPvxuW7dULepZC/DGasjIexI3OirO+Aq18CgqxAcetftj3U6vMmB8rhP
 BMMtXHfgnvdb2VnfrRhEvQ9Bj1vj8DgPZHkdfWthXYoGmbAbBcKR4qVCbhrVWxWUl/Qtw0
 GpwcMAQRhuSJxzpzTULT6diFJlwtZlk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-Y3bdXNxiPZCQNYJVVtNMLA-1; Sat, 17 Jul 2021 22:09:19 -0400
X-MC-Unique: Y3bdXNxiPZCQNYJVVtNMLA-1
Received: by mail-wr1-f69.google.com with SMTP id
 p4-20020a5d63840000b0290126f2836a61so7156372wru.6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 19:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gpM2d5Iuvyh50YGnyAEB1mGNqLkDz1f1Frpy8iBXokw=;
 b=AywQQauE/kQ4mWCwKICrepjixuwgWEJ+nOB2Z0SG54JAb5GeXgOfxiCDkYBKzG4Ybp
 UiWjHUVggJhPe+6TYmYFzUeOKJImQZ3JSo90pfQfeY4Ev6h/TYtZ75fv/3Vsaqzj7vvf
 CNaUz6ac1k84jdMHmufJ7sNjIoZtOxgZaa7Pg5M/KGI8b7qsgp+d68voxH6qJ3hUU47F
 Yiv4Jbi1qqhPpP2KX0I+myqbu4V8eECy5P9z/Egcp2p2acX62O8sYY0ZbaW2TiSO+OVU
 rSe8w15vjjT50mQtPlroNW8qvsZx12BjOkZbMaRiqTQYTucIjtEjDGbySSbQb7SlEVj2
 hnjQ==
X-Gm-Message-State: AOAM531E7zLCz7OwVCG6izLV/QnSVIXTq+ktKb/e9NPshr985BuMatvT
 +TpaZhMkE7llVi0UZzZuqYhIunAXq4+AQldc8HsJ+HRtaT3jiZD2+1uUlbH4a7Rn+Reu17dsiIa
 HbKl+5oWTeKKXkYpWy1VXTmp4HawDl/nXpxW0ZAClZg==
X-Received: by 2002:a05:600c:3541:: with SMTP id
 i1mr25022293wmq.135.1626574158617; 
 Sat, 17 Jul 2021 19:09:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAjXutwxw/shIh8se3On5/NgHRsL0GVBZVfCQw0Xr/xWe4iHnIbPhvf8WMAk9eZvm7QX+O3A==
X-Received: by 2002:a05:600c:3541:: with SMTP id
 i1mr25022272wmq.135.1626574158446; 
 Sat, 17 Jul 2021 19:09:18 -0700 (PDT)
Received: from redhat.com ([2.55.29.175])
 by smtp.gmail.com with ESMTPSA id n7sm14590296wmq.37.2021.07.17.19.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jul 2021 19:09:17 -0700 (PDT)
Date: Sat, 17 Jul 2021 22:09:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next 1/2] tools: add missing infrastructure for
 building ptr_ring.h
Message-ID: <20210717220239-mutt-send-email-mst@kernel.org>
References: <1625457455-4667-1-git-send-email-linyunsheng@huawei.com>
 <1625457455-4667-2-git-send-email-linyunsheng@huawei.com>
 <20210705143144-mutt-send-email-mst@kernel.org>
 <cbc4053e-7eda-4c46-5b98-558c741e45b6@huawei.com>
MIME-Version: 1.0
In-Reply-To: <cbc4053e-7eda-4c46-5b98-558c741e45b6@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: andriy.shevchenko@linux.intel.com, yury.norov@gmail.com,
 nickhu@andestech.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com,
 ndesaulniers@gooogle.com, green.hu@gmail.com, ojeda@kernel.org,
 kuba@kernel.org, akpm@linux-foundation.org, deanbo422@gmail.com,
 davem@davemloft.net
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

On Tue, Jul 06, 2021 at 10:04:02AM +0800, Yunsheng Lin wrote:
> On 2021/7/6 2:39, Michael S. Tsirkin wrote:
> > On Mon, Jul 05, 2021 at 11:57:34AM +0800, Yunsheng Lin wrote:
> >> In order to build ptr_ring.h in userspace, the cacheline
> >> aligning, cpu_relax() and slab related infrastructure is
> >> needed, so add them in this patch.
> >>
> >> As L1_CACHE_BYTES may be different for different arch, which
> >> is mostly defined in include/generated/autoconf.h, so user may
> >> need to do "make defconfig" before building a tool using the
> >> API in linux/cache.h.
> >>
> >> Also "linux/lockdep.h" is not added in "tools/include" yet,
> >> so remove it in "linux/spinlock.h", and the only place using
> >> "linux/spinlock.h" is tools/testing/radix-tree, removing that
> >> does not break radix-tree testing.
> >>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > 
> > This is hard to review.
> > Try to split this please. Functional changes separate from
> > merely moving code around.
> 
> Sure.
> 
> > 
> > 
> >> ---
> >>  tools/include/asm/cache.h          | 56 ++++++++++++++++++++++++
> >>  tools/include/asm/processor.h      | 36 ++++++++++++++++
> >>  tools/include/generated/autoconf.h |  1 +
> >>  tools/include/linux/align.h        | 15 +++++++
> >>  tools/include/linux/cache.h        | 87 ++++++++++++++++++++++++++++++++++++++
> >>  tools/include/linux/gfp.h          |  4 ++
> >>  tools/include/linux/slab.h         | 46 ++++++++++++++++++++
> >>  tools/include/linux/spinlock.h     |  2 -
> >>  8 files changed, 245 insertions(+), 2 deletions(-)
> >>  create mode 100644 tools/include/asm/cache.h
> >>  create mode 100644 tools/include/asm/processor.h
> >>  create mode 100644 tools/include/generated/autoconf.h
> >>  create mode 100644 tools/include/linux/align.h
> >>  create mode 100644 tools/include/linux/cache.h
> >>  create mode 100644 tools/include/linux/slab.h
> >>
> >> diff --git a/tools/include/asm/cache.h b/tools/include/asm/cache.h
> >> new file mode 100644
> >> index 0000000..071e310
> >> --- /dev/null
> >> +++ b/tools/include/asm/cache.h
> >> @@ -0,0 +1,56 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +
> >> +#ifndef __TOOLS_LINUX_ASM_CACHE_H
> >> +#define __TOOLS_LINUX_ASM_CACHE_H
> >> +
> >> +#include <generated/autoconf.h>
> >> +
> >> +#if defined(__i386__) || defined(__x86_64__)
> >> +#define L1_CACHE_SHIFT	(CONFIG_X86_L1_CACHE_SHIFT)
> >> +#elif defined(__arm__)
> >> +#define L1_CACHE_SHIFT	(CONFIG_ARM_L1_CACHE_SHIFT)
> >> +#elif defined(__aarch64__)
> >> +#define L1_CACHE_SHIFT	(6)
> >> +#elif defined(__powerpc__)
> >> +
> >> +/* bytes per L1 cache line */
> >> +#if defined(CONFIG_PPC_8xx)
> >> +#define L1_CACHE_SHIFT	4
> >> +#elif defined(CONFIG_PPC_E500MC)
> >> +#define L1_CACHE_SHIFT	6
> >> +#elif defined(CONFIG_PPC32)
> >> +#if defined(CONFIG_PPC_47x)
> >> +#define L1_CACHE_SHIFT	7
> >> +#else
> >> +#define L1_CACHE_SHIFT	5
> >> +#endif
> >> +#else /* CONFIG_PPC64 */
> >> +#define L1_CACHE_SHIFT	7
> >> +#endif
> >> +
> >> +#elif defined(__sparc__)
> >> +#define L1_CACHE_SHIFT 5
> >> +#elif defined(__alpha__)
> >> +
> >> +#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_EV6)
> >> +#define L1_CACHE_SHIFT	6
> >> +#else
> >> +/* Both EV4 and EV5 are write-through, read-allocate,
> >> +   direct-mapped, physical.
> >> +*/
> >> +#define L1_CACHE_SHIFT	5
> >> +#endif
> >> +
> >> +#elif defined(__mips__)
> >> +#define L1_CACHE_SHIFT	CONFIG_MIPS_L1_CACHE_SHIFT
> >> +#elif defined(__ia64__)
> >> +#define L1_CACHE_SHIFT	CONFIG_IA64_L1_CACHE_SHIFT
> >> +#elif defined(__nds32__)
> >> +#define L1_CACHE_SHIFT	5
> >> +#else
> >> +#define L1_CACHE_SHIFT	5
> >> +#endif
> >> +
> >> +#define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
> >> +
> >> +#endif
> >> diff --git a/tools/include/asm/processor.h b/tools/include/asm/processor.h
> >> new file mode 100644
> >> index 0000000..3198ad6
> >> --- /dev/null
> >> +++ b/tools/include/asm/processor.h
> >> @@ -0,0 +1,36 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +
> >> +#ifndef __TOOLS_LINUX_ASM_PROCESSOR_H
> >> +#define __TOOLS_LINUX_ASM_PROCESSOR_H
> >> +
> >> +#include <pthread.h>
> >> +
> >> +#if defined(__i386__) || defined(__x86_64__)
> >> +#include "../../arch/x86/include/asm/vdso/processor.h"
> >> +#elif defined(__arm__)
> >> +#include "../../arch/arm/include/asm/vdso/processor.h"
> >> +#elif defined(__aarch64__)
> >> +#include "../../arch/arm64/include/asm/vdso/processor.h"
> >> +#elif defined(__powerpc__)
> >> +#include "../../arch/powerpc/include/vdso/processor.h"
> >> +#elif defined(__s390__)
> >> +#include "../../arch/s390/include/vdso/processor.h"
> >> +#elif defined(__sh__)
> >> +#include "../../arch/sh/include/asm/processor.h"
> >> +#elif defined(__sparc__)
> >> +#include "../../arch/sparc/include/asm/processor.h"
> >> +#elif defined(__alpha__)
> >> +#include "../../arch/alpha/include/asm/processor.h"
> >> +#elif defined(__mips__)
> >> +#include "../../arch/mips/include/asm/vdso/processor.h"
> >> +#elif defined(__ia64__)
> >> +#include "../../arch/ia64/include/asm/processor.h"
> >> +#elif defined(__xtensa__)
> >> +#include "../../arch/xtensa/include/asm/processor.h"
> >> +#elif defined(__nds32__)
> >> +#include "../../arch/nds32/include/asm/processor.h"
> >> +#else
> >> +#define cpu_relax()	sched_yield()
> > 
> > Does this have a chance to work outside of kernel?
> 
> I am not sure I understand what you meant here.
> sched_yield() is a pthread API, so it should work in the
> user space.
> And it allow the rigntest to compile when it is built on
> the arch which is not handled as above.

It might compile but is likely too heavy to behave
reasonably.

Also, given you did not actually test it I don't
think you should add such arch code.
Note you broke at least s390 here:
../../arch/s390/include/vdso/processor.h
does not actually exist. Where these headers
do exit they tend to include lots of code which won't
build out of kernel.

All this is just for cpu_relax - open coding that seems way easier.


> > 
> >> +#endif
> > 
> > did you actually test or even test build all these arches?
> > Not sure we need to bother with hacks like these.
> 
> Only x86_64 and arm64 arches have been built and tested.

In that case I think you should not add code that you
have not even built let alone tested.


> This is added referring the tools/include/asm/barrier.h.
> 
> > 
> > 
> >> +

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
