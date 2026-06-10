Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F4371067
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076951; cv=none; b=ljgQ0V5hq6tSqft1peg7ZeQIOIK9SWi80BCH4Q+ZGNr7TNzIvJT3NYbtqXQ1iYa5LsJiqDFe90KTYrEPfsXdIaqXzh5CWqlz+4XFpmTWLTp+Aj/Gv+IgPJBV2VdpoTVsBvuGcJ3lHCaTS+PApqij4B01yv7gNw+WGqJX8NjjzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076951; c=relaxed/simple;
	bh=RyGue1uoNkTxGhwWeHgIqe/l8UCU/NN1IJGM8emsVyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gRQuLUjPrqWTeAwiIzuPtwPVCJffbjjNG+UtKt7B7LoGN4wL43iqOMufm6ERrqikkrIk2mPX8nZbeTMYEUMnKBvUSsQOa88HcVt1T7EY+gA/Sydgylu9IH84Vjwl5v0cVSjbgP/w/JTx4YWUh3DrRKbJBdVYEAZ/dJ9rVr39VzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCfyZmvw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCfyZmvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781076949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UWlNJsELOJGMZ+FI7OsgS8pm8RymJ32pYzeA2rVYtbA=;
	b=LCfyZmvw5CVYSdQfxElWEUXG9mfRK5l/XavNTvWcHjKeamjtbmttwueUFLXjtelho9pV7q
	Ozgd9RKWmiApXJWb842XpI/1x59pe8p3YlopDEQBw8cm/3MfaGsh4b/qsFJ6g/ypcRxN15
	Sr5wFxSH1ycyJRmP9NGeiq+WPuWBoEI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-FeoBXITYOy27XIbFzXxfjw-1; Wed, 10 Jun 2026 03:35:46 -0400
X-MC-Unique: FeoBXITYOy27XIbFzXxfjw-1
X-Mimecast-MFC-AGG-ID: FeoBXITYOy27XIbFzXxfjw_1781076945
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490afe64f26so31850055e9.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 00:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781076945; x=1781681745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWlNJsELOJGMZ+FI7OsgS8pm8RymJ32pYzeA2rVYtbA=;
        b=iCZ3qbWVtcY5EwVDT73ReuqsZfg+vZh4h0qcPcl917E2b8MvgcrL2xp3FSySxGrykI
         Mbz5BD4k1cuSZ89GktojTVyXxUD1sRzWKfZgBK3h2Kfg68ZJPN5BsOV+BGwyjchAZLmR
         zbN7aSq0+Zb4Oks0umwuhPHUgtZHlfpS4Bl0ZwJUTzOK+ljPzNEDcWZ28bHPxsTEv2d/
         HVPHn+tsTmj51WITZuqAy2ZmJazgdFoNVSPRGmXPYju25QJJf+K6BErANrXJPt8ilfF0
         whAXCoIUluy5vA597Sbb8EFVnvsuGVx8pCYvkrhlO8fV6ry8kNzLFvT92V4mBJtiuVgV
         SDUw==
X-Forwarded-Encrypted: i=1; AFNElJ/q05KjfPFgU7hxtuFhUhwJ2e4xr5VDNKCmhSfCuFBcpVK/X/6yoL5fwAEv5aOoqVxY2xloaWEDFl+BZWZGvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOVNu9o1JEEd2UL/TsYxQK8O5ZilfROP9avKtzpRO6Srx16yk1
	i/emtsiL8w3if55jBDFULXe79BOJqtcTIEDEMx5sYT2IgSMDPr7ASNSH9igTxV94V83MEdvxSEp
	2h1Pzhb8lXurViZjiYBq5GC5/jEBgw12tUJuOevMRfsiJit4hKUryTLz8XwFEjMMKWASp
X-Gm-Gg: Acq92OHdUvnAYs+4y4/d0fWpH8pM39eiEIkXfAoOVBsv5OwCugNzJiUFlzc3Jkl/Wjo
	YEnDmKezZ0xPsYnrD6lE6azfqgKw8TEEhinw0x4GvFDTVvsOFHMVsK4s7V37b13hsaP1Ot5HcND
	aabV7NMRD1HImL7gpak75MX6rUKWEyg2nc4X94H0Nv8JSAswvfGhHqNvkAQd94+baeO7ljXIMFw
	eIoBNpAJw1GPL93Pb/bm6yNtUNsxD3oCGvgxsbIxwkyIAURT4qAPonB89Vc6MAkVGvY7itAW1rd
	YTZUUs6PibNXApidLUw0tsFUGDUEppcP8QjecMF30IHVtvp4HzEPpuxpKI21NaIHS0VZmpW3D93
	uAvNVl72oZDNE7tksp9uiSOI+3tefJYswJPHA9gu/NtXl9s89P+zKZw==
X-Received: by 2002:a05:600c:3588:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-490c2cf5433mr343576425e9.11.1781076944750;
        Wed, 10 Jun 2026 00:35:44 -0700 (PDT)
X-Received: by 2002:a05:600c:3588:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-490c2cf5433mr343575795e9.11.1781076944181;
        Wed, 10 Jun 2026 00:35:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm627725935e9.1.2026.06.10.00.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 00:35:43 -0700 (PDT)
Date: Wed, 10 Jun 2026 03:35:37 -0400
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
Message-ID: <20260610033441-mutt-send-email-mst@kernel.org>
References: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
 <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
 <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
 <FB250C43-790E-4AB0-BD40-74665FC601A0@nvidia.com>
 <38C84F23-E881-4DB2-86BA-93F39D44AE1B@nvidia.com>
 <20260609162437-mutt-send-email-mst@kernel.org>
 <4BA276D9-9EB9-4E2A-8A05-657ACACFF227@nvidia.com>
 <20260609165829-mutt-send-email-mst@kernel.org>
 <dd8d89be-9c73-8ff7-7d44-9705bddeda4d@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <dd8d89be-9c73-8ff7-7d44-9705bddeda4d@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bGlml3-3rBCpQQMS-kT0R6vDYx3c28ae51Phda_RJxI_1781076945
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 03:24:30PM +0800, Miaohe Lin wrote:
> On 2026/6/10 5:00, Michael S. Tsirkin wrote:
> > On Tue, Jun 09, 2026 at 04:54:01PM -0400, Zi Yan wrote:
> >> On 9 Jun 2026, at 16:34, Michael S. Tsirkin wrote:
> >>
> >>> On Tue, Jun 09, 2026 at 02:52:47PM -0400, Zi Yan wrote:
> >>>> On 9 Jun 2026, at 14:39, Zi Yan wrote:
> >>>>
> >>>>> On 9 Jun 2026, at 14:38, David Hildenbrand (Arm) wrote:
> >>>>>
> >>>>>> On 6/9/26 20:10, Andrew Morton wrote:
> >>>>>>> On Tue, 9 Jun 2026 06:12:49 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>>>>>>
> >>>>>>>> TestSetPageHWPoison() is called without zone->lock, so its atomic
> >>>>>>>> update to page->flags can race with non-atomic flag operations
> >>>>>>>> that run under zone->lock in the buddy allocator.
> >>>>>>>>
> >>>>>>>> In particular, __free_pages_prepare() does:
> >>>>>>>>
> >>>>>>>>     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> >>>>>>>>
> >>>>>>>> This non-atomic read-modify-write, while correctly excluding
> >>>>>>>> __PG_HWPOISON from the mask, can still lose a concurrent
> >>>>>>>> TestSetPageHWPoison if the read happens before the poison bit
> >>>>>>>> is set and the write happens after.  Will only get worse if/when
> >>>>>>>> we add more non-atomic flag operations.
> >>>>>>>>
> >>>>>>>> Fix by acquiring zone->lock around TestSetPageHWPoison and
> >>>>>>>> around ClearPageHWPoison in the retry path.  This
> >>>>>>>> serializes with all buddy flag manipulation.  The cost is
> >>>>>>>> negligible: one lock/unlock in an extremely rare path
> >>>>>>>> (hardware memory errors).
> >>>>>>>>
> >>>>>>>> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> >>>>>>>> in this file operate on pages already removed from the buddy
> >>>>>>>> allocator or on non-buddy pages (DAX, hugetlb), so they do not
> >>>>>>>> need zone->lock protection.
> >>>>>>>
> >>>>>>> Sashiko is saying this doesn't do anything "Because
> >>>>>>> __free_pages_prepare() executes entirely locklessly".  Did it goof?
> >>>>>>>
> >>>>>>> https://sashiko.dev/#/patchset/df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com
> >>>>>>
> >>>>>> Battle of the bots: it's right.
> >>>>>
> >>>>> Yep, __free_pages_prepare() changes the page flag without holding
> >>>>> zone->lock.
> >>>>
> >>>> __free_pages_prepare() works on frozen pages and assumes no one else
> >>>> touches the input page. To avoid this race, memory_failure() might
> >>>> want to try_get_page() before TestClearPageHWPoison(), but I am not
> >>>> sure if that works along with memory failure flow.
> >>>>
> >>>> Best Regards,
> >>>> Yan, Zi
> >>>
> >>>
> >>>
> >>> Actually memory failure already plays with this down the road no?
> >>>
> >>> So maybe it's enough to just SetPageHWPoison afterwards again?
> >>>
> >>>
> >>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >>> index ee42d4361309..4758fea94a96 100644
> >>> --- a/mm/memory-failure.c
> >>> +++ b/mm/memory-failure.c
> >>> @@ -2415,6 +2415,7 @@ int memory_failure(unsigned long pfn, int flags)
> >>>  	if (!res) {
> >>>  		if (is_free_buddy_page(p)) {
> >>>  			if (take_page_off_buddy(p)) {
> >>> +				SetPageHWPoison(p);
> >>>  				page_ref_inc(p);
> >>>  				res = MF_RECOVERED;
> >>>  			} else {
> >>>
> >>>
> >>> and maybe in a bunch of other places in there?
> >>
> >> You mean for fear of losing HWPoison flag in the earlier TestSetPageHWPoison(),
> >> just set it again here?
> > 
> > Yea.
> > 
> >> Why not do it after get_hwpoison_page(), since that
> >> is the expected page flag?
> > 
> > It's still in the buddy at that point right? I'm worried buddy might
> > poke at flags.
> 
> Since __free_pages_prepare() executes entirely locklessly, the only way to ensure
> HWPoison flag won't be lost might be only set hwpoison flag iff we can make sure
> pages are not on the way to buddy...
> 
> Thanks.
> .

Right so here after take_page_off_buddy it's ok, for example.

-- 
MST

