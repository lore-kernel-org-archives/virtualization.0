Return-Path: <SRS0=bDZb=GJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9ACC433E0
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 18:42:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9F823125
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 18:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9F823125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 85599868A2;
	Wed,  6 Jan 2021 18:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id acIXVqmoHzgu; Wed,  6 Jan 2021 18:42:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7953A8688F;
	Wed,  6 Jan 2021 18:42:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C945C0891;
	Wed,  6 Jan 2021 18:42:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D28ADC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 18:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AFD6C86D06
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 18:42:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CclG2csH61LK
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 18:42:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
 [209.85.166.54])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A2CE986BD4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 18:42:33 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id i18so3690792ioa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Jan 2021 10:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LXbQyuhu8MJhuWLpzCR+mt3CN6/MAbyKTSN+t0WIyKg=;
 b=pybeZ3LJXJM520ZUF/lF5e+DMV6pDbodJA58CCMaXrvOWT5plLY3BDk1bQ9mWsRHkA
 dog0zUHHVZCTLKeYETnRnjTcjxsh5rjMh8MhP4MeuxUu7CeQRNT2+qO6nupBj+E4gDxd
 hHi58oRS9SQ+cTjV6NVNnuWf86EW8PljAr8VdQx3ZB2EKpSKRXTpb/OgR4EjFDQDyqzF
 eVt5uwZFLdvcruoeERL3XwixAfem1OQu7bPo0MXcHQ30/mzs3jVLk2mtDWmdrnGqejic
 DuOxaeRtcVYVPUqN8w1QGzTZoYgFFaoJxPs1ibjxiNqqM2BKCKwabhlCrGaorooqMeJB
 VS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LXbQyuhu8MJhuWLpzCR+mt3CN6/MAbyKTSN+t0WIyKg=;
 b=WVXkukQo7QeZj7Za5rKzjnanRNl7ei2eocsZAsXJtpzt7q+bclKE1qjKM20ZW7aBMH
 08yJC/r3QZOdx+9gG0eGsvgnMAd6s6LOacVPhcCYtmsRqW6fDDvSN6kdcy8B1vAb/Wz+
 6iUTjwCfGIExLXLxLniCJKvYW1aD1dXqszHIc+tclKhEp4xir9gJJKh1lT9lGkyqh4FI
 Ub5fJ6AhZpR/RTxDcYhZAGPHBFj5PLCu5XHAmJjHyOfjFfNngvK5iwYtlf27UUOSEuwe
 ab70U02LaSv7d+seCXn3oXcFyxFSaOLvVcEPDrjwgDUuI2Pn1D5W8XA+LnAS2cFX1w//
 7qaA==
X-Gm-Message-State: AOAM533/Dh+96GHXi7o4JAzwRx16x3XIYTcNXT8uh2pmtbtqxRGaPyuX
 qhEBdmTLrPiLbZDbbMoWnzqWig3x4JnbkPCMBZM=
X-Google-Smtp-Source: ABdhPJyN/Evfh7mW0ZqQGsTY+XA0zAm54YpbvgTzjeZ7QhrWyhnrpWN32WMF1Veb8fQE7eCDA0PMoXG2OfLo6jzPXM0=
X-Received: by 2002:a5d:9a82:: with SMTP id c2mr3913038iom.38.1609958552867;
 Wed, 06 Jan 2021 10:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20210106034806.GA1146@open-light-1.localdomain>
In-Reply-To: <20210106034806.GA1146@open-light-1.localdomain>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 6 Jan 2021 10:42:21 -0800
Message-ID: <CAKgT0UffrUeLm0VFxW5S3rOqQit4vEPhmnEW17nGtA7yy5M3ow@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm: let user decide page reporting option
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, 
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Andrea Arcangeli <aarcange@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, 
 Liang Li <liliangleo@didiglobal.com>, Mike Kravetz <mike.kravetz@oracle.com>, 
 linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
 virtualization@lists.linux-foundation.org
Cc: Liang Li <liliang324@gmail.com>
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

On Tue, Jan 5, 2021 at 7:48 PM Liang Li <liliang324@gmail.com> wrote:
>
> Some key parameters for page reporting are now hard coded, different
> users of the framework may have their special requirements, make
> these parameter configrable and let the user decide them.
>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Liang Li <liliang324@gmail.com>
> Signed-off-by: Liang Li <liliangleo@didiglobal.com>
> ---
>  drivers/virtio/virtio_balloon.c |  3 +++
>  include/linux/page_reporting.h  |  3 +++
>  mm/page_reporting.c             | 13 +++++++++----
>  mm/page_reporting.h             |  6 +++---
>  4 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 8985fc2cea86..684bcc39ef5a 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -993,6 +993,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>                         goto out_unregister_oom;
>                 }
>
> +               vb->pr_dev_info.mini_order = pageblock_order;
> +               vb->pr_dev_info.batch_size = 16 * 1024 * 1024; /* 16M */
> +               vb->pr_dev_info.delay_jiffies = 2 * HZ; /* 2 seconds */
>                 err = page_reporting_register(&vb->pr_dev_info);
>                 if (err)
>                         goto out_unregister_oom;
> diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
> index 3b99e0ec24f2..63e1e9fbcaa2 100644
> --- a/include/linux/page_reporting.h
> +++ b/include/linux/page_reporting.h
> @@ -13,6 +13,9 @@ struct page_reporting_dev_info {
>         int (*report)(struct page_reporting_dev_info *prdev,
>                       struct scatterlist *sg, unsigned int nents);
>
> +       unsigned long batch_size;
> +       unsigned long delay_jiffies;
> +       int mini_order;
>         /* work struct for processing reports */
>         struct delayed_work work;
>
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 694df981ddd2..39bc6a9d7b73 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -13,6 +13,7 @@
>  #define PAGE_REPORTING_DELAY   (2 * HZ)
>  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>  unsigned long page_report_batch_size  __read_mostly = 16 * 1024 * 1024UL;
> +int page_report_mini_order = pageblock_order;
>
>  enum {
>         PAGE_REPORTING_IDLE = 0,
> @@ -44,7 +45,7 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
>          * now we are limiting this to running no more than once every
>          * couple of seconds.
>          */
> -       schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
> +       schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
>  }
>

So this ends up being the reason why you needed to add the batch size
value. However I don't really see it working as expected since you
could essentially have 1 page freed 4M times that could trigger your
page zeroing logic. So for example if a NIC is processing frames and
ends up freeing and then reallocating some small batch of pages this
could would be running often even though there isn't really all that
many pages that needed zeroing.

>  /* notify prdev of free page reporting request */
> @@ -230,7 +231,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>
>         /* Generate minimum watermark to be able to guarantee progress */
>         watermark = low_wmark_pages(zone) +
> -                   (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
> +                   (PAGE_REPORTING_CAPACITY << prdev->mini_order);
>
>         /*
>          * Cancel request if insufficient free memory or if we failed

With the page order being able to be greatly reduced this could have a
significant impact on if this code really has any value. Previously we
were able to guarantee a pretty significant number of higher order
pages free. With this we might only be guaranteeing something like 32
4K pages which is pretty small compared to what can end up being
pulled out at the higher end.

> @@ -240,7 +241,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>                 return err;
>
>         /* Process each free list starting from lowest order/mt */
> -       for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
> +       for (order = prdev->mini_order; order < MAX_ORDER; order++) {
>                 for (mt = 0; mt < MIGRATE_TYPES; mt++) {
>                         /* We do not pull pages from the isolate free list */
>                         if (is_migrate_isolate(mt))
> @@ -307,7 +308,7 @@ static void page_reporting_process(struct work_struct *work)
>          */
>         state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
>         if (state == PAGE_REPORTING_REQUESTED)
> -               schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
> +               schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
>  }
>
>  static DEFINE_MUTEX(page_reporting_mutex);
> @@ -335,6 +336,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>         /* Assign device to allow notifications */
>         rcu_assign_pointer(pr_dev_info, prdev);
>
> +       page_report_mini_order = prdev->mini_order;
> +       page_report_batch_size = prdev->batch_size;
>         /* enable page reporting notification */
>         if (!static_key_enabled(&page_reporting_enabled)) {
>                 static_branch_enable(&page_reporting_enabled);
> @@ -352,6 +355,8 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
>         mutex_lock(&page_reporting_mutex);
>
>         if (rcu_access_pointer(pr_dev_info) == prdev) {
> +               if (static_key_enabled(&page_reporting_enabled))
> +                       static_branch_disable(&page_reporting_enabled);
>                 /* Disable page reporting notification */
>                 RCU_INIT_POINTER(pr_dev_info, NULL);
>                 synchronize_rcu();

If we are going to use this we are using it. Once we NULL out the
prdev that should stop page reporting from running. We shouldn't be
relying on the static key.

> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> index b8fb3bbb345f..86ac6ffad970 100644
> --- a/mm/page_reporting.h
> +++ b/mm/page_reporting.h
> @@ -9,9 +9,9 @@
>  #include <linux/slab.h>
>  #include <linux/pgtable.h>
>  #include <linux/scatterlist.h>
> +#include <linux/page_reporting.h>
>
> -#define PAGE_REPORTING_MIN_ORDER       pageblock_order
> -
> +extern int page_report_mini_order;
>  extern unsigned long page_report_batch_size;
>
>  #ifdef CONFIG_PAGE_REPORTING
> @@ -42,7 +42,7 @@ static inline void page_reporting_notify_free(unsigned int order)
>                 return;
>
>         /* Determine if we have crossed reporting threshold */
> -       if (order < PAGE_REPORTING_MIN_ORDER)
> +       if (order < page_report_mini_order)
>                 return;

This is another case where it might make sense to look at placing the
code in __page_reporting_notify if we are going to allow this to be a
dynamically configurable value.

>         batch_size += (1 << order) << PAGE_SHIFT;
> --
> 2.18.2
>
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
