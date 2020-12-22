Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C74C433E0
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 08:31:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F8B224F9
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 08:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F8B224F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CF4A320134;
	Tue, 22 Dec 2020 08:31:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a0hk1VdHqZj5; Tue, 22 Dec 2020 08:31:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1E763214EC;
	Tue, 22 Dec 2020 08:31:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B492C1825;
	Tue, 22 Dec 2020 08:31:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3383C0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9DC6585FC7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:31:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id On-7zNKDPjFy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:31:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D241D85FC3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608625907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WoEGZEowYO96BAO0eOM0n/UUR242urezSyPqGgvq0g=;
 b=g7QVCeYc+qDUftiiqZiYQMar1WdfHjf/HWyOcEbNEnJMb5scZKnS/F7Ba3eV71Nb3ohtOh
 Xx0NtZHYFinb+pM8HbaOkQ2YgVE1vm/aedUyD/JtcTHYOOtp1kB4sRwqNshmtYmZq3SEVe
 fUqjavMfs3UgUi2XqX0xJ04x6KEQ8Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-wqzghbuGNi6tQ04mWrWqPA-1; Tue, 22 Dec 2020 03:31:43 -0500
X-MC-Unique: wqzghbuGNi6tQ04mWrWqPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5972800D53;
 Tue, 22 Dec 2020 08:31:41 +0000 (UTC)
Received: from [10.36.113.220] (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DD431002382;
 Tue, 22 Dec 2020 08:31:35 +0000 (UTC)
Subject: Re: [RFC PATCH 3/3] mm: support free hugepage pre zero out
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
 Liang Li <liliangleo@didiglobal.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Liang Li <liliang324@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
References: <20201222074910.GA30051@open-light-1.localdomain>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <585791f4-4b41-5e73-296e-691d5478a915@redhat.com>
Date: Tue, 22 Dec 2020 09:31:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201222074910.GA30051@open-light-1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On 22.12.20 08:49, Liang Li wrote:
> This patch add support of pre zero out free hugepage, we can use
> this feature to speed up page population and page fault handing.
> 
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: David Hildenbrand <david@redhat.com>  
> Cc: Michal Hocko <mhocko@suse.com> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Liang Li <liliang324@gmail.com>
> Signed-off-by: Liang Li <liliangleo@didiglobal.com>
> ---
>  mm/page_prezero.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/mm/page_prezero.c b/mm/page_prezero.c
> index c8ce720bfc54..dff4e0adf402 100644
> --- a/mm/page_prezero.c
> +++ b/mm/page_prezero.c
> @@ -26,6 +26,7 @@ static unsigned long delay_millisecs = 1000;
>  static unsigned long zeropage_enable __read_mostly;
>  static DEFINE_MUTEX(kzeropaged_mutex);
>  static struct page_reporting_dev_info zero_page_dev_info;
> +static struct page_reporting_dev_info zero_hugepage_dev_info;
>  
>  inline void clear_zero_page_flag(struct page *page, int order)
>  {
> @@ -69,9 +70,17 @@ static int start_kzeropaged(void)
>  		zero_page_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
>  
>  		err = page_reporting_register(&zero_page_dev_info);
> +
> +		zero_hugepage_dev_info.report = zero_free_pages;
> +		zero_hugepage_dev_info.mini_order = mini_page_order;
> +		zero_hugepage_dev_info.batch_size = batch_size;
> +		zero_hugepage_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
> +
> +		err |= hugepage_reporting_register(&zero_hugepage_dev_info);
>  		pr_info("Zero page enabled\n");
>  	} else {
>  		page_reporting_unregister(&zero_page_dev_info);
> +		hugepage_reporting_unregister(&zero_hugepage_dev_info);
>  		pr_info("Zero page disabled\n");
>  	}
>  
> @@ -90,7 +99,15 @@ static int restart_kzeropaged(void)
>  		zero_page_dev_info.batch_size = batch_size;
>  		zero_page_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
>  
> +		hugepage_reporting_unregister(&zero_hugepage_dev_info);
> +
> +		zero_hugepage_dev_info.report = zero_free_pages;
> +		zero_hugepage_dev_info.mini_order = mini_page_order;
> +		zero_hugepage_dev_info.batch_size = batch_size;
> +		zero_hugepage_dev_info.delay_jiffies = msecs_to_jiffies(delay_millisecs);
> +
>  		err = page_reporting_register(&zero_page_dev_info);
> +		err |= hugepage_reporting_register(&zero_hugepage_dev_info);
>  		pr_info("Zero page enabled\n");
>  	}
>  
> 

Free page reporting in virtio-balloon doesn't give you any guarantees
regarding zeroing of pages. Take a look at the QEMU implementation -
e.g., with vfio all reports are simply ignored.

Also, I am not sure if mangling such details ("zeroing of pages") into
the page reporting infrastructure is a good idea.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
