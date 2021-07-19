Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E75C07E9D
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 11:58:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A94E6113E
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 11:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A94E6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47DB983640;
	Mon, 19 Jul 2021 11:58:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lxY9XEy5-LpE; Mon, 19 Jul 2021 11:58:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BD3DB82A7F;
	Mon, 19 Jul 2021 11:58:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BE5AC001A;
	Mon, 19 Jul 2021 11:58:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0138DC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 11:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E36FE4040D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 11:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X_eXDebnl5Fu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 11:58:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AF3A403DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 11:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626695889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pjiBFtBbN3Tpa6+FO6osoKkB4QfSBpg6c+lRQJCM5pw=;
 b=IlrnW24Tfocx6kwP0vYWcarSpzIrFbT02t7HHGAPx6bm4SOHYKJwzm6014tBKf/hOgyK4G
 teWf8PppFYGiLXjhRXKTzQv/Jry3KJKckALN+0cA7uPDqSgynDYplKAi3/q+QwxCPsMaYX
 l0ZpzPvAzoCasyrrg3/z6NX7JtO1PoI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-NVs-6CoaOLme1CfTKv2Vhw-1; Mon, 19 Jul 2021 07:58:08 -0400
X-MC-Unique: NVs-6CoaOLme1CfTKv2Vhw-1
Received: by mail-wm1-f72.google.com with SMTP id
 j141-20020a1c23930000b0290212502cb19aso5361417wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 04:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pjiBFtBbN3Tpa6+FO6osoKkB4QfSBpg6c+lRQJCM5pw=;
 b=WUrXdb9vkKJz3/PFIngl37wg5moJHoMK4tyTrSR+QU0cCX+5lOwmqfsgEFs+OH3PKS
 ynPxBq1CpADmbQnWV/wNNJ7tJF0kibKxk4emKk983eL3auXyS1tNCUl1g2k07zY10OLc
 ZRLD8xSeqmZ7Yvhn6mat9QxBV6a6+4B/ihBbHR9wmjBZRTUgnLOW1xbDL4+ewgnnu9Qi
 4i3IQegNEKAy2cDf6b5X8cZxJercfNJXNpEgTGaJt/RU/I5ujmVMFdsVom38D+tvsmcF
 NBUYhBcxESZ1sx3d6eg3kIAbMSpIwTBF5pCcTK3EDZZX5bTVw2Er7W1Lrv3KbNn6QChL
 3mnw==
X-Gm-Message-State: AOAM532UR7SR2DgXW6CKs2WkbDwd0NV8KrUxeOnH30bGzlUF4G7cupKO
 EiGZP/UJ4QKPQsA/DWw2y/eCQRxk/sm/4CBTSH5iK/uTgHWrkxDv6cZIJJ/FGg580RbXBG+nJVy
 bhNbsYuHU+7+MXE3eSPFm5QjePjgQC3y8PXDGam1M+g==
X-Received: by 2002:a5d:6ac4:: with SMTP id u4mr29212494wrw.166.1626695887179; 
 Mon, 19 Jul 2021 04:58:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+OAIWZXBnOoLEaejahoNmZdXq7HnXiPt48QZY8Inz4B2bfDo9yCBx/7ow9p4m2kL0QelGZg==
X-Received: by 2002:a5d:6ac4:: with SMTP id u4mr29212465wrw.166.1626695887015; 
 Mon, 19 Jul 2021 04:58:07 -0700 (PDT)
Received: from redhat.com ([2.55.11.37])
 by smtp.gmail.com with ESMTPSA id 129sm16885866wmz.26.2021.07.19.04.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jul 2021 04:58:05 -0700 (PDT)
Date: Mon, 19 Jul 2021 07:58:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next 1/2] tools: add missing infrastructure for
 building ptr_ring.h
Message-ID: <20210719075748-mutt-send-email-mst@kernel.org>
References: <1625457455-4667-1-git-send-email-linyunsheng@huawei.com>
 <1625457455-4667-2-git-send-email-linyunsheng@huawei.com>
 <20210705143144-mutt-send-email-mst@kernel.org>
 <cbc4053e-7eda-4c46-5b98-558c741e45b6@huawei.com>
 <20210717220239-mutt-send-email-mst@kernel.org>
 <5d320b37-18f3-e853-ceb7-21af7ca12763@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5d320b37-18f3-e853-ceb7-21af7ca12763@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: andriy.shevchenko@linux.intel.com, yury.norov@gmail.com,
 nickhu@andestech.com, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Mon, Jul 19, 2021 at 09:40:39AM +0800, Yunsheng Lin wrote:
> On 2021/7/18 10:09, Michael S. Tsirkin wrote:
> > On Tue, Jul 06, 2021 at 10:04:02AM +0800, Yunsheng Lin wrote:
> >> On 2021/7/6 2:39, Michael S. Tsirkin wrote:
> >>> On Mon, Jul 05, 2021 at 11:57:34AM +0800, Yunsheng Lin wrote:
> 
> [..]
> 
> >>>> diff --git a/tools/include/asm/processor.h b/tools/include/asm/processor.h
> >>>> new file mode 100644
> >>>> index 0000000..3198ad6
> >>>> --- /dev/null
> >>>> +++ b/tools/include/asm/processor.h
> >>>> @@ -0,0 +1,36 @@
> >>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>> +
> >>>> +#ifndef __TOOLS_LINUX_ASM_PROCESSOR_H
> >>>> +#define __TOOLS_LINUX_ASM_PROCESSOR_H
> >>>> +
> >>>> +#include <pthread.h>
> >>>> +
> >>>> +#if defined(__i386__) || defined(__x86_64__)
> >>>> +#include "../../arch/x86/include/asm/vdso/processor.h"
> >>>> +#elif defined(__arm__)
> >>>> +#include "../../arch/arm/include/asm/vdso/processor.h"
> >>>> +#elif defined(__aarch64__)
> >>>> +#include "../../arch/arm64/include/asm/vdso/processor.h"
> >>>> +#elif defined(__powerpc__)
> >>>> +#include "../../arch/powerpc/include/vdso/processor.h"
> >>>> +#elif defined(__s390__)
> >>>> +#include "../../arch/s390/include/vdso/processor.h"
> >>>> +#elif defined(__sh__)
> >>>> +#include "../../arch/sh/include/asm/processor.h"
> >>>> +#elif defined(__sparc__)
> >>>> +#include "../../arch/sparc/include/asm/processor.h"
> >>>> +#elif defined(__alpha__)
> >>>> +#include "../../arch/alpha/include/asm/processor.h"
> >>>> +#elif defined(__mips__)
> >>>> +#include "../../arch/mips/include/asm/vdso/processor.h"
> >>>> +#elif defined(__ia64__)
> >>>> +#include "../../arch/ia64/include/asm/processor.h"
> >>>> +#elif defined(__xtensa__)
> >>>> +#include "../../arch/xtensa/include/asm/processor.h"
> >>>> +#elif defined(__nds32__)
> >>>> +#include "../../arch/nds32/include/asm/processor.h"
> >>>> +#else
> >>>> +#define cpu_relax()	sched_yield()
> >>>
> >>> Does this have a chance to work outside of kernel?
> >>
> >> I am not sure I understand what you meant here.
> >> sched_yield() is a pthread API, so it should work in the
> >> user space.
> >> And it allow the rigntest to compile when it is built on
> >> the arch which is not handled as above.
> > 
> > It might compile but is likely too heavy to behave
> > reasonably.
> > 
> > Also, given you did not actually test it I don't
> > think you should add such arch code.
> > Note you broke at least s390 here:
> > ../../arch/s390/include/vdso/processor.h
> > does not actually exist. Where these headers
> > do exit they tend to include lots of code which won't
> > build out of kernel.
> 
> You are right, it should be in:
> ../../arch/s390/include/asm/vdso/processor.h
> 
> > 
> > All this is just for cpu_relax - open coding that seems way easier.
> 
> Sure.
> 
> As Eugenio has posted a patchset to fix the compilation, which does
> not seems to be merged yet and may have some merging conflicts with
> this patchset, so either wait for the Eugenio' patchset to be merged
> before proceeding with this patchset, or explicitly note the dependency
> of Eugenio' patchset when sending the new version of patchset. I am not
> familiar with the merging flow of virtio to say which way is better, any
> suggestion how to proceed with this patchset?
> 
> 1. https://lkml.org/lkml/2021/7/6/1132
> 
> > 
> > 
> >>>
> >>>> +#endif
> >>>
> >>> did you actually test or even test build all these arches?
> >>> Not sure we need to bother with hacks like these.
> >>
> >> Only x86_64 and arm64 arches have been built and tested.
> > 
> > In that case I think you should not add code that you
> > have not even built let alone tested.
> 
> Ok.
> 
> > 
> > 
> >> This is added referring the tools/include/asm/barrier.h.
> >>
> >>>
> >>>
> >>>> +
> > 
> > .


I will merge Eugenio's patchset soon.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
