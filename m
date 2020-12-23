Return-Path: <SRS0=+X4x=F3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77220C433DB
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 16:39:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0179320897
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 16:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0179320897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AFA4885C28;
	Wed, 23 Dec 2020 16:39:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUprr4ogCllm; Wed, 23 Dec 2020 16:39:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E2C8085C2E;
	Wed, 23 Dec 2020 16:39:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC713C1787;
	Wed, 23 Dec 2020 16:39:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43A7FC0893
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 16:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3C6D5866D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 16:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uxqMJaUde0nK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 16:39:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
 [209.85.166.49])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1B66A86830
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 16:39:50 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id r9so15585982ioo.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rVatYmYCMQJMPjerzko57jobHUoXj+DHRjujys0dqAg=;
 b=CMoRHJGuB1XkSbypZBbRm5Lmn/sYHKrrdSCLcYKUgSpGp/iIxUWpK7MqDlEpZGZ/ZD
 SMUgmlHBkjZAhgOYfKLrsAQQ2mMDkqHE13F3DRTjxTcGD7l658kjyqkYC81jcTfgm40h
 ngdZ8ggxsn4jQ9lLSvbc41CsNjCnD70y41Fcq+PlRGEb+3XfAxEra5cNugupWtTuptdk
 ZOJocOMNm0WBUDIT6NlQuhYN35JEon7iB0ECIKD+pwOL3niu5vO44NxBWPUa6+gdBhE6
 d31sf7OTkUeHc1/u00+DUii7nWaEIpW5kk/NmXqi4ND+8t/dRs77wgI+xsDHUWMmfyDt
 odyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rVatYmYCMQJMPjerzko57jobHUoXj+DHRjujys0dqAg=;
 b=GrO9+nWAN4H1FF4pPV5nyeC445f+D+YgZ4/eg5d3W4GBDy4ikH3XndDxyaIrFVfkHI
 gJcPchPHiUDc65xWUfKgB4L/16+SHLGquxs270cwi/1Qc8OFnNYB8ayBpxCMXGycPMIx
 Q3DwEtdCO4aMeuh5VCo89rPlx6beeZMOwBTEtgu1N0UdH0ZgMEQnpPjrZQ4ulo+qyYDa
 ScnctfnlhGX5aCf59VuBiXDcT0LojeIhc7Hqen2HHK1VRR+bX8kDK1/WBx0h012uUozc
 7IThs6Qcpi0wIixPlcCcXvdW6/Wb+kHDpf20/nZqn68QOCVe4J4bJJcLylJZlMB3SdTQ
 7c6g==
X-Gm-Message-State: AOAM532fsohXV4RiEiRLXxCjO2Z+PPpyoTR3vZ9UbPI4RiVeCNG1nyEV
 Io39OdHJRcbeWV9pk+0bUSGcd/ektIUC4OcJeco=
X-Google-Smtp-Source: ABdhPJxyAnwmJZzZB1b22WrZzw7BIjDXYDFpaPAmxIgWuUHQ3FHGoOFNR3974ncYPlecPN6dclod2ICJWmOPjDwyEvk=
X-Received: by 2002:a02:5d85:: with SMTP id w127mr23645424jaa.83.1608741587758; 
 Wed, 23 Dec 2020 08:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20201222074656.GA30035@open-light-1.localdomain>
 <CAKgT0Ucs4pv0+rcPi41uNDrav0sgOmLnVaD4NNWkg7=gncidnQ@mail.gmail.com>
 <CA+2MQi_b98v+vS9J+FnovPe5avNv4WSeD2KoQycdQAG4c3Hxpg@mail.gmail.com>
In-Reply-To: <CA+2MQi_b98v+vS9J+FnovPe5avNv4WSeD2KoQycdQAG4c3Hxpg@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 23 Dec 2020 08:39:36 -0800
Message-ID: <CAKgT0Ue2+eV22kAt-DmsTZqRvXGdxQXa8uVEbD0cmmFP22-r5A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm: support hugetlb free page reporting
To: Liang Li <liliang324@gmail.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Dan Williams <dan.j.williams@intel.com>, Liang Li <liliangleo@didiglobal.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Dave Hansen <dave.hansen@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Dec 22, 2020 at 7:39 PM Liang Li <liliang324@gmail.com> wrote:
>
> > > +hugepage_reporting_cycle(struct page_reporting_dev_info *prdev,
> > > +                        struct hstate *h, unsigned int nid,
> > > +                        struct scatterlist *sgl, unsigned int *offset)
> > > +{
> > > +       struct list_head *list = &h->hugepage_freelists[nid];
> > > +       unsigned int page_len = PAGE_SIZE << h->order;
> > > +       struct page *page, *next;
> > > +       long budget;
> > > +       int ret = 0, scan_cnt = 0;
> > > +
> > > +       /*
> > > +        * Perform early check, if free area is empty there is
> > > +        * nothing to process so we can skip this free_list.
> > > +        */
> > > +       if (list_empty(list))
> > > +               return ret;
> > > +
> > > +       spin_lock_irq(&hugetlb_lock);
> > > +
> > > +       if (huge_page_order(h) > MAX_ORDER)
> > > +               budget = HUGEPAGE_REPORTING_CAPACITY;
> > > +       else
> > > +               budget = HUGEPAGE_REPORTING_CAPACITY * 32;
> >
> > Wouldn't huge_page_order always be more than MAX_ORDER? Seems like we
> > don't even really need budget since this should probably be pulling
> > out no more than one hugepage at a time.
>
> I want to disting a 2M page and 1GB page here. The order of 1GB page is greater
> than MAX_ORDER while 2M page's order is less than MAX_ORDER.

The budget here is broken. When I put the budget in page reporting it
was so that we wouldn't try to report all of the memory in a given
region. It is meant to hold us to no more than one pass through 1/16
of the free memory. So essentially we will be slowly processing all of
memory and it will take 16 calls (32 seconds) for us to process a
system that is sitting completely idle. It is meant to pace us so we
don't spend a ton of time doing work that will be undone, not to
prevent us from burying a CPU which is what seems to be implied here.

Using HUGEPAGE_REPORTING_CAPACITY makes no sense here. I was using it
in the original definition because it was how many pages we could
scoop out at a time and then I was aiming for a 16th of that. Here you
are arbitrarily squaring HUGEPAGE_REPORTING_CAPACITY in terms of the
amount of work you will doo since you are using it as a multiple
instead of a divisor.

> >
> > > +       /* loop through free list adding unreported pages to sg list */
> > > +       list_for_each_entry_safe(page, next, list, lru) {
> > > +               /* We are going to skip over the reported pages. */
> > > +               if (PageReported(page)) {
> > > +                       if (++scan_cnt >= MAX_SCAN_NUM) {
> > > +                               ret = scan_cnt;
> > > +                               break;
> > > +                       }
> > > +                       continue;
> > > +               }
> > > +
> >
> > It would probably have been better to place this set before your new
> > set. I don't see your new set necessarily being the best use for page
> > reporting.
>
> I haven't really latched on to what you mean, could you explain it again?

It would be better for you to spend time understanding how this patch
set works before you go about expanding it to do other things.
Mistakes like the budget one above kind of point out the fact that you
don't understand how this code was supposed to work and just kind of
shoehorned you page zeroing code onto it.

It would be better to look at trying to understand this code first
before you extend it to support your zeroing use case. So adding huge
pages first might make more sense than trying to zero and push the
order down. The fact is the page reporting extension should be minimal
for huge pages since they are just passed as a scatterlist so you
should only need to add a small bit to page_reporting.c to extend it
to support this use case.

> >
> > > +               /*
> > > +                * If we fully consumed our budget then update our
> > > +                * state to indicate that we are requesting additional
> > > +                * processing and exit this list.
> > > +                */
> > > +               if (budget < 0) {
> > > +                       atomic_set(&prdev->state, PAGE_REPORTING_REQUESTED);
> > > +                       next = page;
> > > +                       break;
> > > +               }
> > > +
> >
> > If budget is only ever going to be 1 then we probably could just look
> > at making this the default case for any time we find a non-reported
> > page.
>
> and here again.

It comes down to the fact that the changes you made have a significant
impact on how this is supposed to function. Reducing the scatterlist
to a size of one makes the whole point of doing batching kind of
pointless. Basically the code should be rewritten with the assumption
that if you find a page you report it.

The old code would batch things up because there is significant
overhead to be addressed when going to the hypervisor to report said
memory. Your code doesn't seem to really take anything like that into
account and instead is using an arbitrary budget value based on the
page size.

> > > +               /* Attempt to pull page from list and place in scatterlist */
> > > +               if (*offset) {
> > > +                       isolate_free_huge_page(page, h, nid);
> > > +                       /* Add page to scatter list */
> > > +                       --(*offset);
> > > +                       sg_set_page(&sgl[*offset], page, page_len, 0);
> > > +
> > > +                       continue;
> > > +               }
> > > +
> >
> > There is no point in the continue case if we only have a budget of 1.
> > We should probably just tighten up the loop so that all it does is
> > search until it finds the 1 page it can pull, pull it, and then return
> > it. The scatterlist doesn't serve much purpose and could be reduced to
> > just a single entry.
>
> I will think about it more.
>
> > > +static int
> > > +hugepage_reporting_process_hstate(struct page_reporting_dev_info *prdev,
> > > +                           struct scatterlist *sgl, struct hstate *h)
> > > +{
> > > +       unsigned int leftover, offset = HUGEPAGE_REPORTING_CAPACITY;
> > > +       int ret = 0, nid;
> > > +
> > > +       for (nid = 0; nid < MAX_NUMNODES; nid++) {
> > > +               ret = hugepage_reporting_cycle(prdev, h, nid, sgl, &offset);
> > > +
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +       }
> > > +
> > > +       /* report the leftover pages before going idle */
> > > +       leftover = HUGEPAGE_REPORTING_CAPACITY - offset;
> > > +       if (leftover) {
> > > +               sgl = &sgl[offset];
> > > +               ret = prdev->report(prdev, sgl, leftover);
> > > +
> > > +               /* flush any remaining pages out from the last report */
> > > +               spin_lock_irq(&hugetlb_lock);
> > > +               hugepage_reporting_drain(prdev, h, sgl, leftover, !ret);
> > > +               spin_unlock_irq(&hugetlb_lock);
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> > > +
> >
> > If HUGEPAGE_REPORTING_CAPACITY is 1 it would make more sense to
> > rewrite this code to just optimize for a find and process a page
> > approach rather than trying to batch pages.
>
> Yes, I will make a change. Thanks for your comments!

Lastly I would recommend setting up and testing page reporting with
the virtio-balloon driver. I worry that your patch set would have a
significant negative impact on the performance of it. As I mentioned
before it was designed to be more of a leaky bucket solution to
reporting memory and was supposed to take about 30 seconds for it to
flush all of the memory in a guest. Your changes seem to be trying to
do a much more aggressive task and I worry that what you are going to
find is that it will easily push CPUs to 100% on an active system
since it will be aggressively trying to zero memory as soon as it is
freed rather than taking it at a slower pace.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
