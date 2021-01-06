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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C90C433E0
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 16:59:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC81D2311E
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 16:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC81D2311E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7D530271D9;
	Wed,  6 Jan 2021 16:59:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cXdIo8IM77O0; Wed,  6 Jan 2021 16:59:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 38C18204CC;
	Wed,  6 Jan 2021 16:59:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A611C0891;
	Wed,  6 Jan 2021 16:59:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BFBEC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 16:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 69F0B85BC4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 16:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S1yTNcnd-NKr
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 16:59:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com
 [209.85.166.180])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9B50D8734E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 16:59:15 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id b10so1850684ilr.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Jan 2021 08:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3EmfUTuYnuTvPsdC4hdIk2/vIKZRsbh5sYgRQoKisdc=;
 b=kBn4N4cJQY1i+4o8/OjUAlYWOoo4zZhtiRIw2uz9KnHglVk+6VWWFzkj8sI7zU+85G
 PhR6dzXAwWuVGiDXkHkXqG9lLgitcz8TlgzkJvMxp1i4rUCgyqFXE9Ipu0kstODAcX0g
 mpayT3d4Uwaaw6k6mNhrite1jm4Oq9cQntsaW1Y/NDC1s0fslrfPs+8GY7jR0km7SESU
 HOndvPqqmkmf8ZhRmj4NZAy6zeYOCS+QTUb2iHWxdUDKZ43BTgQl8IJqXx/tpCi4BmjM
 0tRgZ3kA4x4S2356P19eTh3+DsEr5Fw3USj0OCBf3WQTQIiMZNtObrhY2i+GzQtpW8Z2
 w4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3EmfUTuYnuTvPsdC4hdIk2/vIKZRsbh5sYgRQoKisdc=;
 b=hlRN5oPV5DpUDOgV8PWAt+0W7rBRGawseQ5YMf/XvlX85VhUGPvyMhp7WOlIlPu1LY
 ELR0Ioqmr7QlVBwML06voOkdJ66gAV+3geXljmJQ/Si6Gm8Pg+LUy7XT6edCBD/Qz6aA
 cyAK7MyFpq9vRKwv01smoat+bJX59i1Mm5GJ62SqncHhZaUyusN0/ulvvuHTezV9ChJv
 7anUstbBGZk2RuY5ry5/7DBb4r1LIdHhutaADtNLluyTnywc1RvpkOyQnAuDKTxu+uoX
 IbDPbdtQlt/x1JAX4GiFS8yRTacPPT25tBNxhTnYK7na/nX75heTcP5usapoAfWty2DJ
 Ke8Q==
X-Gm-Message-State: AOAM533qqXMAKAi5fUnhSP9y8gacwizH71Gahl4WZqT77jPCQy6I8ut4
 aCxpIPC+whEcPGNBO0IQjnJXCTkSCmCHKhh4OhE=
X-Google-Smtp-Source: ABdhPJzjwgaxVsHtTZws6cL84ADauyumJ8mJ0Jvu4/J1N8I/u89+8vWMx+nTn/GdpCCaz5MlKXGT+g3VPF3uG37FwtE=
X-Received: by 2002:a92:d8cc:: with SMTP id l12mr4972019ilo.64.1609952354762; 
 Wed, 06 Jan 2021 08:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20210106034715.GA1138@open-light-1.localdomain>
In-Reply-To: <20210106034715.GA1138@open-light-1.localdomain>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 6 Jan 2021 08:59:03 -0800
Message-ID: <CAKgT0Uf=iQ-vzk7woNBsgAOvVD2RS41x9dRC-Y06TCGwykHzSw@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: Add batch size for free page reporting
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

On Tue, Jan 5, 2021 at 7:47 PM Liang Li <liliang324@gmail.com> wrote:
>
> Use the page order as the only threshold for page reporting
> is not flexible and has some flaws. Because scan a long free
> list is not cheap, it's better to wake up the page reporting
> worker when there are more pages, wake it up for a sigle page
> may not worth.
> This patch add a batch size as another threshold to control the
> waking up of reporting worker.
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

So you are going to need a lot more explanation for this. Page
reporting already had the concept of batching as you could only scan
once every 2 seconds as I recall. Thus the "PAGE_REPORTING_DELAY". The
change you are making doesn't make any sense without additional
context.

> ---
>  mm/page_reporting.c |  1 +
>  mm/page_reporting.h | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index cd8e13d41df4..694df981ddd2 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -12,6 +12,7 @@
>
>  #define PAGE_REPORTING_DELAY   (2 * HZ)
>  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
> +unsigned long page_report_batch_size  __read_mostly = 16 * 1024 * 1024UL;
>
>  enum {
>         PAGE_REPORTING_IDLE = 0,
> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> index 2c385dd4ddbd..b8fb3bbb345f 100644
> --- a/mm/page_reporting.h
> +++ b/mm/page_reporting.h
> @@ -12,6 +12,8 @@
>
>  #define PAGE_REPORTING_MIN_ORDER       pageblock_order
>
> +extern unsigned long page_report_batch_size;
> +
>  #ifdef CONFIG_PAGE_REPORTING
>  DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
>  void __page_reporting_notify(void);
> @@ -33,6 +35,8 @@ static inline bool page_reported(struct page *page)
>   */
>  static inline void page_reporting_notify_free(unsigned int order)
>  {
> +       static long batch_size;
> +

I'm not sure this makes a tone of sense to place the value in an
inline function. It might make more sense to put this new code in
__page_reporting_notify so that all callers would be referring to the
same batch_size value and you don't have to bother with the export of
the page_report_batch_size value.

>         /* Called from hot path in __free_one_page() */
>         if (!static_branch_unlikely(&page_reporting_enabled))
>                 return;
> @@ -41,8 +45,12 @@ static inline void page_reporting_notify_free(unsigned int order)
>         if (order < PAGE_REPORTING_MIN_ORDER)
>                 return;
>
> -       /* This will add a few cycles, but should be called infrequently */
> -       __page_reporting_notify();
> +       batch_size += (1 << order) << PAGE_SHIFT;
> +       if (batch_size >= page_report_batch_size) {
> +               batch_size = 0;

I would probably run this in the opposite direction. Rather than
running batch_size to zero I would look at adding a "batch_remaining"
and then when it is < 0 you could then reset it back to
page_report_batch_size. Doing that you only have to read one variable
most of the time instead of doing a comparison against two.

> +               /* This add a few cycles, but should be called infrequently */
> +               __page_reporting_notify();
> +       }
>  }
>  #else /* CONFIG_PAGE_REPORTING */
>  #define page_reported(_page)   false
> --
> 2.18.2
>
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
