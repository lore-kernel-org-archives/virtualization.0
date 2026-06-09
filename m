Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3936F918
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781038872; cv=none; b=l9XlXBHPw4nHsE6Jzl84UJk5533csZhSBUIVdEDnvOFnIgV7a2nRcprhUWRxP7CXQy3ItHfCTciM65m0xLc/HmcqEOP7ezpxVzl3DHgGe2+fFODNBgox7e9kxqothwrf8rIa8/Dum1UKGSA36pzOiddtcD/QAWWE/Z4W3qg3eC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781038872; c=relaxed/simple;
	bh=VS1fojAadH5LM2pjMyTnwu5WrIXvP+3MgWwVuP33wPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rTKfqk8R6MTaUlq+o03OqvZI+EqhpVKKiqbWesHxNqNFEfR8G0OISm5IGkVQEJr2W230RRi7eTXDIzZOMGp3yqM5Iy7WlFm5KF7/USQQbMZ95e+E7q4o2Ovnghokn9IfisXZHSz+Gi0bP2rxzo0gVThg6DT66Cwvi7w7m7kGmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pc6iAmv1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pc6iAmv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781038869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Om/173xa6nAXXlawHrWQ0qeVuAob6cSlyHSyIFpCw4=;
	b=Pc6iAmv1fLWH74AGTT9KqnYaFqx8lrYNNSFU9h2W7I9+aNDRQE6i/+5660EFOJGBbGlpMY
	RrryO7j1Bq7uB9+Q9bIbWeLu+rnepjhkk0gX+668C8nXdS62U7QlTM7XG8fdcyYZ7qBDxV
	OhES06+5FSTdiwsQoIyjflum9pGvLiw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-iHRPjclYNI2yElvwzOGY_Q-1; Tue, 09 Jun 2026 17:01:06 -0400
X-MC-Unique: iHRPjclYNI2yElvwzOGY_Q-1
X-Mimecast-MFC-AGG-ID: iHRPjclYNI2yElvwzOGY_Q_1781038865
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a786f987so65900595e9.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 14:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781038865; x=1781643665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Om/173xa6nAXXlawHrWQ0qeVuAob6cSlyHSyIFpCw4=;
        b=kK+ruMvJl1OpX9vWZ40OlzuiYsd8yqa1nHOD5oCTGlU0gnBNV3SXAgssFpXVH2mvg4
         zL28DaV6wpLBUUCB0bPvy2lXnbeZwdnkk51yQglnOO3yYVUv1mgj8hhtmp/8lxj4aWdW
         HsJwrcnEgxcd+4h0tPSib4zNkpxe9gaz00k7SZtGvUfLKC6hRUgIIIC9WnrJwzZ/Eqet
         klZqwJZA7liq+IQ1hXFp9gvCkxhqH2hR7Rx1x52FBaHXIezDK4B1k9n1xRjNQNxn8a5d
         e2Hwgb59zFiXt564uz6E/ydccBim7ZlGWvvYyaYdKBj+mWbttJIl1YVDAWEuvRzwiyU+
         f7dA==
X-Forwarded-Encrypted: i=1; AFNElJ+ngZxB/OLgFKSN568WXlk2qA37zWoLfYB8ME+n7ppEUNwR+QV4vgjq/KCo5WChXyWt1A98ShxArNJYWxrfCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDt8m8nQBOd1MnSxzLGVKsFQEFwl2QwoyUYc0LLC0Z7jHxq8gI
	cFl1q3vqbD85bxcW0+kWon74a9KbNUX2rqBoTb3zuvsDfjpPmMyM185iY3uFGccyUhtm1J5Rf8F
	KmcPuN5ru1jcuaBjLXgeMnlDtkQXrkponDvcKOipPGwnZcTGfQgNl8p/T7yZKEwJ7XdER
X-Gm-Gg: Acq92OEJAcOgUJdCr3kHpOefDUz3c43v85EFq2x88yX5qy5FfOtT5DlRRviwq82Ue0T
	o3WrgjMNdEwk25i91H9ZykbeMPGRSx9z4fJPhmbo+3y/S5G3i9pFQ8kJiADE3VFU/uavUmoUzxl
	7u3zkK5FXjTwU1AaaTMiYkAacpqF1d24SASw+QEBe2RMNMmoherquUEEw6b24s1ck4PIBLGa+sT
	jL0V5X2h82/kTqBSV+unrdCQBictLWtOJbSCMFn5jsMlo27H4y4gnaIRyYEDy72HhtYAOGJhMQD
	wQ2oQBqgHD/LxxlU3gbFQaAEP+1Z7IVVVtoR3mqMPZJXrZmiRKHOsnFrzdS1miimboZHMhMSJUT
	i8lJEvOBJSBtGJVgviDe8R5trgCQjBzKWaQqle4AHQbEcNV5wgqaMcg==
X-Received: by 2002:a05:600c:1907:b0:490:b99c:9337 with SMTP id 5b1f17b1804b1-490c25a0800mr343765725e9.10.1781038865148;
        Tue, 09 Jun 2026 14:01:05 -0700 (PDT)
X-Received: by 2002:a05:600c:1907:b0:490:b99c:9337 with SMTP id 5b1f17b1804b1-490c25a0800mr343765005e9.10.1781038864641;
        Tue, 09 Jun 2026 14:01:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm66817831f8f.3.2026.06.09.14.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:01:01 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:00:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
Message-ID: <20260609165829-mutt-send-email-mst@kernel.org>
References: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
 <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
 <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
 <FB250C43-790E-4AB0-BD40-74665FC601A0@nvidia.com>
 <38C84F23-E881-4DB2-86BA-93F39D44AE1B@nvidia.com>
 <20260609162437-mutt-send-email-mst@kernel.org>
 <4BA276D9-9EB9-4E2A-8A05-657ACACFF227@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4BA276D9-9EB9-4E2A-8A05-657ACACFF227@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pchl08nKyRN75JOq9f3nwfvKhLJ8GVICVdeORVcpbDM_1781038865
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 04:54:01PM -0400, Zi Yan wrote:
> On 9 Jun 2026, at 16:34, Michael S. Tsirkin wrote:
> 
> > On Tue, Jun 09, 2026 at 02:52:47PM -0400, Zi Yan wrote:
> >> On 9 Jun 2026, at 14:39, Zi Yan wrote:
> >>
> >>> On 9 Jun 2026, at 14:38, David Hildenbrand (Arm) wrote:
> >>>
> >>>> On 6/9/26 20:10, Andrew Morton wrote:
> >>>>> On Tue, 9 Jun 2026 06:12:49 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>>>>
> >>>>>> TestSetPageHWPoison() is called without zone->lock, so its atomic
> >>>>>> update to page->flags can race with non-atomic flag operations
> >>>>>> that run under zone->lock in the buddy allocator.
> >>>>>>
> >>>>>> In particular, __free_pages_prepare() does:
> >>>>>>
> >>>>>>     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> >>>>>>
> >>>>>> This non-atomic read-modify-write, while correctly excluding
> >>>>>> __PG_HWPOISON from the mask, can still lose a concurrent
> >>>>>> TestSetPageHWPoison if the read happens before the poison bit
> >>>>>> is set and the write happens after.  Will only get worse if/when
> >>>>>> we add more non-atomic flag operations.
> >>>>>>
> >>>>>> Fix by acquiring zone->lock around TestSetPageHWPoison and
> >>>>>> around ClearPageHWPoison in the retry path.  This
> >>>>>> serializes with all buddy flag manipulation.  The cost is
> >>>>>> negligible: one lock/unlock in an extremely rare path
> >>>>>> (hardware memory errors).
> >>>>>>
> >>>>>> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> >>>>>> in this file operate on pages already removed from the buddy
> >>>>>> allocator or on non-buddy pages (DAX, hugetlb), so they do not
> >>>>>> need zone->lock protection.
> >>>>>
> >>>>> Sashiko is saying this doesn't do anything "Because
> >>>>> __free_pages_prepare() executes entirely locklessly".  Did it goof?
> >>>>>
> >>>>> https://sashiko.dev/#/patchset/df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com
> >>>>
> >>>> Battle of the bots: it's right.
> >>>
> >>> Yep, __free_pages_prepare() changes the page flag without holding
> >>> zone->lock.
> >>
> >> __free_pages_prepare() works on frozen pages and assumes no one else
> >> touches the input page. To avoid this race, memory_failure() might
> >> want to try_get_page() before TestClearPageHWPoison(), but I am not
> >> sure if that works along with memory failure flow.
> >>
> >> Best Regards,
> >> Yan, Zi
> >
> >
> >
> > Actually memory failure already plays with this down the road no?
> >
> > So maybe it's enough to just SetPageHWPoison afterwards again?
> >
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index ee42d4361309..4758fea94a96 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -2415,6 +2415,7 @@ int memory_failure(unsigned long pfn, int flags)
> >  	if (!res) {
> >  		if (is_free_buddy_page(p)) {
> >  			if (take_page_off_buddy(p)) {
> > +				SetPageHWPoison(p);
> >  				page_ref_inc(p);
> >  				res = MF_RECOVERED;
> >  			} else {
> >
> >
> > and maybe in a bunch of other places in there?
> 
> You mean for fear of losing HWPoison flag in the earlier TestSetPageHWPoison(),
> just set it again here?

Yea.

> Why not do it after get_hwpoison_page(), since that
> is the expected page flag?

It's still in the buddy at that point right? I'm worried buddy might
poke at flags.

> Miaohe probably can give a better answer here.
> 
> 
> Best Regards,
> Yan, Zi

