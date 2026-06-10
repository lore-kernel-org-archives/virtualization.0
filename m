Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAEB346791
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126296; cv=none; b=Zj6fukQgjpisY5hZq9CCJKQnVJRlN2vrJ2/MEQId7xzzRboL9+coJTUVDLKIqqZLXnSkxpCe6HY0Rb20zSDzIUIqPAc9YMxMhq+bWcPPFN34IclZ3lFboetug9kPhJMOl4cpUNjwS5qI+3phtjlR2YWJLhTL6+MDIltOnASZ1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126296; c=relaxed/simple;
	bh=/1CUq2+O38rI14K5Yj8B6yUaUKgKxhRDUztCse8ZPhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fZnQf/cyXiWwjArtpf2rUyDeHgCF20WPg8CnACdkQagmm+YNJ1326HFY+vLbmocX3l/TucfAGMNR1EO6MJOHgQG5ERKet+Q5Ob79aGTpJeHSKyeAUl7kQ1r4Zc+7ucPfkiy1DsGUYrEyDhSYc68fF4A+Qawo4U9jL52M65bcZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1y9bHA1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1y9bHA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781126294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogxStp8nRv8cnMLFF2j3tzHwMzkF6jWJBUj8HHORbZk=;
	b=P1y9bHA1ucic8rGmmhDWTfgUg6AYkfkj7a1J83gElS4N+tilF2Hed4MDblUSRZa1BZBqu8
	5B6jNNkmhqRaTSpUn6cVFEHirHxGn834CpXnfzydCIwgu3z4lul2lFet5NZgEnSoXqOImN
	jerFc+T/Dl3tZFRnHzziy8AAf3r2t3c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-zZ-8MEjDPhqfQ1l_CZdoGw-1; Wed, 10 Jun 2026 17:18:12 -0400
X-MC-Unique: zZ-8MEjDPhqfQ1l_CZdoGw-1
X-Mimecast-MFC-AGG-ID: zZ-8MEjDPhqfQ1l_CZdoGw_1781126291
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45eee3f9f03so6945053f8f.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 14:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781126291; x=1781731091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogxStp8nRv8cnMLFF2j3tzHwMzkF6jWJBUj8HHORbZk=;
        b=YJiKYrvQgs/eoTewDYwDjM6aY4O2rmCb4QIkF+o6dOAUwEg2zSbqYKevobinUv31Aw
         aGB0vXwUvJxvDmwO+88rMjHQgoASG20HqbFzgyhvSvhF3ss2vOcY6rTO8VPT/O5gniTh
         mXj8/byI90ZajdDkh9ls0cZ35jHys+0GcQbWE9t3dCkNVrvdSswYSjACc+9HTAp191Hv
         H4L0U28JItEAWe3CY6xIalrv20Iey2JxbGzzD0BCpgGWbs/bblIOEviTTJZ1Ug4XLtdF
         5/heLDYN1O0YDp58icnwk4bPckyAgXgy4FrikICJ8BL8/olY0zj50hE85ppxqqnEoVFj
         XWpA==
X-Forwarded-Encrypted: i=1; AFNElJ+dUmT6GULnZaXci7ojuYVN/iRbYc41NSVU79af0/empEkoFa088gXS5OUAMM/tGJ2OIBGzYWCQDBlg0K84kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqDQGnD0Uea50iM4OKQe5Lv49QChZzMBStP+q0Xf5WYTUKgt3L
	xF+zdePXhAovp8W0QZxH8h8RGXeeswcMNA3qzxUAUC1XuMCqEzvGsoZQ9+AiMqeuYL2RQS/PpEs
	3zyNw01xhgR2gW6K7jMRMxhkWFD0LbaZDuIAXNNI+EW4iKYFBG/Z03eTZG7coC8XAH5Wo
X-Gm-Gg: Acq92OEmzvYmzNGqwuMmyF0lZbMb7kj02ZzUUj/b7i4rdeqFIIHbuJxkToOhpBsMoHl
	fA0zWRuZ83j/QdicoYCF4mg4YT6ye+6ZFKTlZfgxtddWajn/YiDvbRFP9Ih1rN9sbujlY6ufoAH
	beVzSYzJpU+7seIAiRNEPZQ7HYr0vdg2AqGaAqeZthVSmlY6OO9x2m9NXLVkcpUObOSbBLGxOUx
	b+sHPkBoBYfcRmvQvY2qZpJMEFexZ3Fle8WvjI0qyS91rC6xUlnM/PlvaQiukG9bPEQBs7jr5XW
	FCNi0TIEN9Ii3aaG361Ex+rDBIG8Yjf99zf8KM61mFMlmDv7+iSAQYznAgeLYQizVzelqwuLCTp
	yzBCyeDtdFxV/G5ahHBgcU4YEi1vcTl93Hu8kDRM2tI60kO0sd6MGnA==
X-Received: by 2002:a05:6000:b91:b0:45e:f266:f4cb with SMTP id ffacd0b85a97d-46030506089mr31518414f8f.22.1781126290788;
        Wed, 10 Jun 2026 14:18:10 -0700 (PDT)
X-Received: by 2002:a05:6000:b91:b0:45e:f266:f4cb with SMTP id ffacd0b85a97d-46030506089mr31518369f8f.22.1781126290292;
        Wed, 10 Jun 2026 14:18:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46059346676sm13505910f8f.26.2026.06.10.14.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 14:18:09 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:18:04 -0400
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
Message-ID: <20260610171646-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: 47CIqdA_RaDHUrDq5y_553kQjW0S4SPVSEZ_N3LMOVU_1781126291
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


To clarify do you not agree repeating SetPageHWPoison is enough for
this? And if not, do you have suggestions on how to fix this race?

Thanks a lot,

-- 
MST

