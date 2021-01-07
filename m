Return-Path: <SRS0=voLO=GK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAF4C433E6
	for <virtualization@archiver.kernel.org>; Thu,  7 Jan 2021 17:56:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF5E2076E
	for <virtualization@archiver.kernel.org>; Thu,  7 Jan 2021 17:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF5E2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EEE5686D13;
	Thu,  7 Jan 2021 17:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kH+mjlx5n8Dm; Thu,  7 Jan 2021 17:56:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D540A86CF9;
	Thu,  7 Jan 2021 17:56:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B793EC0891;
	Thu,  7 Jan 2021 17:56:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCE41C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 17:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8416E2041E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 17:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7D31a2KGgu6s
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 17:56:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com
 [209.85.166.176])
 by silver.osuosl.org (Postfix) with ESMTPS id 2D1F3203F8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 17:56:30 +0000 (UTC)
Received: by mail-il1-f176.google.com with SMTP id b10so5577026ilr.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 07 Jan 2021 09:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gIcTJnmCObWJEcPsEVSzZEbUrwSNec8NhE63eBq7ZSM=;
 b=Q2YrzMgiAxkXvm9SqzdMmHt/P1Q3M9VnclkYPlj3KXvMS/VdYP3gLVH9iWfi/tPfJW
 1ohVoytOusKvdsnudhL748xmMxKTx7YBk99jXoeatAdd9FHMFLFk5l7g/TM/KY5snEdF
 l0/qgeWJoRyUQi7Wty/0E0ufwlC4/2sLCis8IhzGwT2j7BZDIcWT6iHKVxizOccE+bDH
 0BdkWOCmUK0CbbhAzv5C6fAenYzSxPe0C3EOIadGWdvl7ABNS/xyzeo8KoUZvz0EaVSK
 5jry93pSQujT1YsqNOeVAY/9W0IB0TYiJtUYwE9AwMoa/JUCLLa7heo9RtcVDBm4m5kE
 mbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gIcTJnmCObWJEcPsEVSzZEbUrwSNec8NhE63eBq7ZSM=;
 b=LkR/FcSOmyM3oRc25xGjpNhm8nno4BpIsTpMiZbT1FY+iSuN0M71vsIuFYeOAqew9y
 23vPQnKicPEKLXw0WldjD3aXjXdw9qcHJkYgMuH4hZsSjj43BNY6YTB/hdxDyl0oadu0
 DhAJ8L/7+dBajivHxXcL0qTnuEvTGnjKJiu3T/eMXDrUuzTKfebLPSGFHUDHj8xHTKKZ
 tKi+twMFPgC8e0CuEnPkfCzCDMGU9nS3oQR07/Bt2TTwg1J6fRB1kKsZl9/FKJthRBXz
 lughv8O/DFijAOIObWea8NS8Uc3Id+bwF/7BjGHU+M3qB0+UwQFMQVky9Fh0s0mbO8Qq
 Cihw==
X-Gm-Message-State: AOAM532ssIfOViNH8BsofKt7wlUTXjC8XnyIejDUPKjLAPwd94TkJgw9
 nvndWUP9aUPhbEno5S3JzFLZPR4dVllRf1y4NC0=
X-Google-Smtp-Source: ABdhPJzpGidOJI6I9ogzE3vbvyp2WNvFouko1ksIuIDvXVu11Iivfx97nwvbu3D+KbJDypKndB70eA+Nz4JBOgdYGZM=
X-Received: by 2002:a92:d592:: with SMTP id a18mr57802iln.64.1610042189444;
 Thu, 07 Jan 2021 09:56:29 -0800 (PST)
MIME-Version: 1.0
References: <20210106035027.GA1160@open-light-1.localdomain>
 <CAKgT0Ue=hXEarqjW-h2G1fODA5UiSjHsKz3FpcyTcaTtQR4iMw@mail.gmail.com>
 <CA+2MQi9MxE_DWW3BHLJbvYDsOppCmfL6AHkdRwtHX0gBDpDebA@mail.gmail.com>
In-Reply-To: <CA+2MQi9MxE_DWW3BHLJbvYDsOppCmfL6AHkdRwtHX0gBDpDebA@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 7 Jan 2021 09:56:18 -0800
Message-ID: <CAKgT0UfQUgZvsw6iQOFuFCGSt1SoU5ij4nC7tsUwbvf4C_0fnA@mail.gmail.com>
Subject: Re: [PATCH 4/6] hugetlb: avoid allocation failed when page reporting
 is on going
To: Liang Li <liliang324@gmail.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Liang Li <liliangleo@didiglobal.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Dave Hansen <dave.hansen@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 virtualization@lists.linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 Dan Williams <dan.j.williams@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>
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

On Wed, Jan 6, 2021 at 7:57 PM Liang Li <liliang324@gmail.com> wrote:
>
> > > Page reporting isolates free pages temporarily when reporting
> > > free pages information. It will reduce the actual free pages
> > > and may cause application failed for no enough available memory.
> > > This patch try to solve this issue, when there is no free page
> > > and page repoting is on going, wait until it is done.
> > >
> > > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Please don't use this email address for me anymore. Either use
> > alexander.duyck@gmail.com or alexanderduyck@fb.com. I am getting
> > bounces when I reply to this thread because of the old address.
>
> No problem.
>
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index eb533995cb49..0fccd5f96954 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -2320,6 +2320,12 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
> > >                 goto out_uncharge_cgroup_reservation;
> > >
> > >         spin_lock(&hugetlb_lock);
> > > +       while (h->free_huge_pages <= 1 && h->isolated_huge_pages) {
> > > +               spin_unlock(&hugetlb_lock);
> > > +               mutex_lock(&h->mtx_prezero);
> > > +               mutex_unlock(&h->mtx_prezero);
> > > +               spin_lock(&hugetlb_lock);
> > > +       }
> >
> > This seems like a bad idea. It kind of defeats the whole point of
> > doing the page zeroing outside of the hugetlb_lock. Also it is
> > operating on the assumption that the only way you might get a page is
> > from the page zeroing logic.
> >
> > With the page reporting code we wouldn't drop the count to zero. We
> > had checks that were going through and monitoring the watermarks and
> > if we started to hit the low watermark we would stop page reporting
> > and just assume there aren't enough pages to report. You might need to
> > look at doing something similar here so that you can avoid colliding
> > with the allocator.
>
> For hugetlb, things are a little different, Just like Mike points out:
>      "On some systems, hugetlb pages are a precious resource and
>       the sysadmin carefully configures the number needed by
>       applications.  Removing a hugetlb page (even for a very short
>       period of time) could cause serious application failure."
>
> Just keeping some pages in the freelist is not enough to prevent that from
> happening, because these pages may be allocated while zero out is on
> going, and application may still run into a situation for not available free
> pages.

I get what you are saying. However I don't know if it is acceptable
for the allocating thread to be put to sleep in this situation. There
are two scenarios where I can see this being problematic.

One is a setup where you put the page allocator to sleep and while it
is sleeping another thread is then freeing a page and your thread
cannot respond to that newly freed page and is stuck waiting on the
zeroed page.

The second issue is that users may want a different option of just
breaking up the request into smaller pages rather than waiting on the
page zeroing, or to do something else while waiting on the page. So
instead of sitting on the request and waiting it might make more sense
to return an error pointer like EAGAIN or EBUSY to indicate that there
is a page there, but it is momentarily tied up.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
