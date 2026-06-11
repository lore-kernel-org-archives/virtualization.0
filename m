Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6481253B58
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 05:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781156650; cv=none; b=dvj649vwffJh4gjw/DjRNXM1QKNhcU5Ck/WcQnRnS1bBh8iRlctzTwKDduKStLO7yH/4SnQY7K+I/XTHilIRTNIehIul6tz+0SNK422tpthUzHSE94U04agO87ohsmZt5X/FqN4OfNEjYJBn9kaCPWpsvGQl9M75P0xAAn/Ery8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781156650; c=relaxed/simple;
	bh=UwRtGHsN3Bx4NetuLULXGLKQezx/xbasW8xE7DkvNm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uwdGqwyVg4nAlAN8Eu4yezErBIvgifgGNG/1FZdLSawPPBedokz5ri8tm3pR+T2Dbsv0Ni46sSD33jQaLGFT8m3l86KXlUiN5/wa3BRfIRzW/9TJYbiNePPWnOGdxgn1UPE0xCqGl5FSKkeZxHMFvQRB7DEhD5NgEPk5IQ8CMBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHCupS4+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHCupS4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781156645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4nnNFS8Cjiou/AxpB5/aNpa5nrhgheHR12Lh4z+m4I=;
	b=HHCupS4+v9tFnn+niF6LbCY95iQS1/9KDAwq995/qipRA18nczAYYwQwrEhIm/jy1jn1sQ
	5A9PkTU5s9Uu7wVmDzmi9HAdcdzp2779LYWExNxbLBQJRkpt1UPi2Z0Fh8uZje15FAxEHM
	cFA+Rx81MKb8WyRiBGyE1iKQ0SUv+rA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-KfspU-sANVuymDBndt5G7A-1; Thu, 11 Jun 2026 01:44:02 -0400
X-MC-Unique: KfspU-sANVuymDBndt5G7A-1
X-Mimecast-MFC-AGG-ID: KfspU-sANVuymDBndt5G7A_1781156642
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso35229545e9.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 22:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781156641; x=1781761441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4nnNFS8Cjiou/AxpB5/aNpa5nrhgheHR12Lh4z+m4I=;
        b=VWu2YVVQ5kf9zaZSnCXj28sPoTeUmgnRKc1g2wqmek2F3LHxLOtzC3i9RAaGjgBgKX
         dwgUJvEKIOE/3qKlciqNyObxczeGqddWz/J8pz8B8/TRZHK0cQaA+bHMZrulJ2+dGI3l
         43gpLurMkM6N0O0fqcOUh3HK1lNc1c93nCGQLaZCaX7XPABVADGqN0YE7J+yVsxX85kf
         CS8gM6+7zRTbJdaGtwRAjDGJG22FVoi8D5M+a81NkQ/RtSJrNM8oOMQCZ5E6lfcPdcAl
         GRdP7Irp402Mx5DUIQouXbNKhEcWQSXwmkgsEL1aWPCP+epi3YYyMyIr1qrAzn9Ugb0G
         GswQ==
X-Forwarded-Encrypted: i=1; AFNElJ8u0LDEvvZIr6h95HtTSpGpDBGnglxsnez5GMH5Lg9ivHKF3f0q8rBKxfRxxEWN9q13Yv2Jai0LtXmezkTQPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHXxfwaajAVguwHeEnSYlNOUZ7CC/qQmOeVdIiFzeqExZeoKM+
	yQhOxQPR1P71QnqUaxbXph1SedICxGgRkXduNhZhoWfUWJUZNnBXe+oQu6Sc2fsRNH1qE8irXk9
	pcOJQl6jOAzVWVtgmCUrlL6r9WTZrnnv6++NXIwXspFeY1ynVxZzv0R4zrVAGyeUicBK/
X-Gm-Gg: Acq92OGpWsJzo+yYuhIgkr8st+lEzVdD7Ahx0PqJPBQdOyan8gq9YZb9YpnJBHbQq+f
	3L5NUJnP17IVHp5Wg5prUFQArafj6IrbQSL9CO1QwqdwZ8dam/OwX79bJCg86RaLRFhiIgOoJAx
	e4QJPWlcknaNjj+NqTKta+UxCZPa8fcp5nUvH6Wvuro/HQByXAWZ9xS8hZOWPRjitlMZ2JrwfZB
	7V+hog17DgsqT7zKqN+NSp3kYbWrlHprRb8O7krZ4VaSAKG1/W49DuPTPFgGJrFpMVEy39ibeXa
	Z6c1r4rugeuDFc+wdWhj+r9ZziMKeXcS/LArAQ28yH4Wm6GqjzPerkUBHJbXn381COfd0MxFDE2
	/sCRe0Nj9iomxeC2NikzZQX47N5C53JNVbaPi38zZCQXlC9RSWjfvrQ==
X-Received: by 2002:a05:600c:8b44:b0:48f:e3e7:3d39 with SMTP id 5b1f17b1804b1-490e55b5511mr10517595e9.11.1781156641520;
        Wed, 10 Jun 2026 22:44:01 -0700 (PDT)
X-Received: by 2002:a05:600c:8b44:b0:48f:e3e7:3d39 with SMTP id 5b1f17b1804b1-490e55b5511mr10517005e9.11.1781156640945;
        Wed, 10 Jun 2026 22:44:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e532c778sm19957795e9.14.2026.06.10.22.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 22:44:00 -0700 (PDT)
Date: Thu, 11 Jun 2026 01:43:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Zi Yan <ziy@nvidia.com>, "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: Re: [PATCH splitout] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Message-ID: <20260611013644-mutt-send-email-mst@kernel.org>
References: <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
 <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
 <FB250C43-790E-4AB0-BD40-74665FC601A0@nvidia.com>
 <38C84F23-E881-4DB2-86BA-93F39D44AE1B@nvidia.com>
 <20260609162437-mutt-send-email-mst@kernel.org>
 <4BA276D9-9EB9-4E2A-8A05-657ACACFF227@nvidia.com>
 <20260609165829-mutt-send-email-mst@kernel.org>
 <dd8d89be-9c73-8ff7-7d44-9705bddeda4d@huawei.com>
 <20260610171646-mutt-send-email-mst@kernel.org>
 <14537566-94d9-eac5-2636-35f925a9d159@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <14537566-94d9-eac5-2636-35f925a9d159@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DbnOM8oGdM_mLt5VszlbrHamlEfWktPLq4mtNMgT_g4_1781156642
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2026 at 11:35:36AM +0800, Miaohe Lin wrote:
> On 2026/6/11 5:18, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2026 at 03:24:30PM +0800, Miaohe Lin wrote:
> >> On 2026/6/10 5:00, Michael S. Tsirkin wrote:
> >>> On Tue, Jun 09, 2026 at 04:54:01PM -0400, Zi Yan wrote:
> >>>> On 9 Jun 2026, at 16:34, Michael S. Tsirkin wrote:
> >>>>
> >>>>> On Tue, Jun 09, 2026 at 02:52:47PM -0400, Zi Yan wrote:
> >>>>>> On 9 Jun 2026, at 14:39, Zi Yan wrote:
> >>>>>>
> >>>>>>> On 9 Jun 2026, at 14:38, David Hildenbrand (Arm) wrote:
> >>>>>>>
> >>>>>>>> On 6/9/26 20:10, Andrew Morton wrote:
> >>>>>>>>> On Tue, 9 Jun 2026 06:12:49 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>>>>>>>>
> >>>>>>>>>> TestSetPageHWPoison() is called without zone->lock, so its atomic
> >>>>>>>>>> update to page->flags can race with non-atomic flag operations
> >>>>>>>>>> that run under zone->lock in the buddy allocator.
> >>>>>>>>>>
> >>>>>>>>>> In particular, __free_pages_prepare() does:
> >>>>>>>>>>
> >>>>>>>>>>     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> >>>>>>>>>>
> >>>>>>>>>> This non-atomic read-modify-write, while correctly excluding
> >>>>>>>>>> __PG_HWPOISON from the mask, can still lose a concurrent
> >>>>>>>>>> TestSetPageHWPoison if the read happens before the poison bit
> >>>>>>>>>> is set and the write happens after.  Will only get worse if/when
> >>>>>>>>>> we add more non-atomic flag operations.
> >>>>>>>>>>
> >>>>>>>>>> Fix by acquiring zone->lock around TestSetPageHWPoison and
> >>>>>>>>>> around ClearPageHWPoison in the retry path.  This
> >>>>>>>>>> serializes with all buddy flag manipulation.  The cost is
> >>>>>>>>>> negligible: one lock/unlock in an extremely rare path
> >>>>>>>>>> (hardware memory errors).
> >>>>>>>>>>
> >>>>>>>>>> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> >>>>>>>>>> in this file operate on pages already removed from the buddy
> >>>>>>>>>> allocator or on non-buddy pages (DAX, hugetlb), so they do not
> >>>>>>>>>> need zone->lock protection.
> >>>>>>>>>
> >>>>>>>>> Sashiko is saying this doesn't do anything "Because
> >>>>>>>>> __free_pages_prepare() executes entirely locklessly".  Did it goof?
> >>>>>>>>>
> >>>>>>>>> https://sashiko.dev/#/patchset/df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com
> >>>>>>>>
> >>>>>>>> Battle of the bots: it's right.
> >>>>>>>
> >>>>>>> Yep, __free_pages_prepare() changes the page flag without holding
> >>>>>>> zone->lock.
> >>>>>>
> >>>>>> __free_pages_prepare() works on frozen pages and assumes no one else
> >>>>>> touches the input page. To avoid this race, memory_failure() might
> >>>>>> want to try_get_page() before TestClearPageHWPoison(), but I am not
> >>>>>> sure if that works along with memory failure flow.
> >>>>>>
> >>>>>> Best Regards,
> >>>>>> Yan, Zi
> >>>>>
> >>>>>
> >>>>>
> >>>>> Actually memory failure already plays with this down the road no?
> >>>>>
> >>>>> So maybe it's enough to just SetPageHWPoison afterwards again?
> >>>>>
> >>>>>
> >>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >>>>> index ee42d4361309..4758fea94a96 100644
> >>>>> --- a/mm/memory-failure.c
> >>>>> +++ b/mm/memory-failure.c
> >>>>> @@ -2415,6 +2415,7 @@ int memory_failure(unsigned long pfn, int flags)
> >>>>>  	if (!res) {
> >>>>>  		if (is_free_buddy_page(p)) {
> >>>>>  			if (take_page_off_buddy(p)) {
> >>>>> +				SetPageHWPoison(p);
> >>>>>  				page_ref_inc(p);
> >>>>>  				res = MF_RECOVERED;
> >>>>>  			} else {
> >>>>>
> >>>>>
> >>>>> and maybe in a bunch of other places in there?
> >>>>
> >>>> You mean for fear of losing HWPoison flag in the earlier TestSetPageHWPoison(),
> >>>> just set it again here?
> >>>
> >>> Yea.
> >>>
> >>>> Why not do it after get_hwpoison_page(), since that
> >>>> is the expected page flag?
> >>>
> >>> It's still in the buddy at that point right? I'm worried buddy might
> >>> poke at flags.
> >>
> >> Since __free_pages_prepare() executes entirely locklessly, the only way to ensure
> >> HWPoison flag won't be lost might be only set hwpoison flag iff we can make sure
> >> pages are not on the way to buddy...
> >>
> >> Thanks.
> >> .
> > 
> > 
> > To clarify do you not agree repeating SetPageHWPoison is enough for
> > this? And if not, do you have suggestions on how to fix this race?
> 
> Do you mean repeating SetPageHWPoison on every branch?

Right.

> Is it possible
> to make __free_pages_prepare changes page->flags atomically or this race
> is specified to memory_failure?
> 
> Thanks.
> .


Adding an atomic op on every fast path page allocation is, I am
guessing, going to slow down Linux measureably.

Doing it for the benefit of memory_failure, which is the slowest of
slow paths, seems unpalatable, to me.

Neither am I sure it's the only racy place -
grep for __SetPage and __ClearPage - all these have the same issue, I
suspect.

At the same time, I'm not an mm maintainer. If you disagree, try to
upstream a change converting all non atomics in mm to atomics, and see
what others say.

-- 
MST

