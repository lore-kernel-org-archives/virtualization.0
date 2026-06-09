Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379036AB49
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037271; cv=none; b=pQW/T/bXEtk3i7O50grlJLlbyiy2/m1pr1hknlpjfwqylMRE3TLTOFHTT/5mRdicAs+Po0ELC0gxfa7BVG3pkcQukTsz49H0y2Oaiv5mzKdxXQdBeK38ZjscsnEvjg6Kzq89mrm25/MCDyhH+lTMucLdXOA3BgaNKjL027WxLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037271; c=relaxed/simple;
	bh=hjSZjdNFzDS0RV1P33YK5xgjgw9GO7Zw7S51A9EFG2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZjPva79yJ5WPwA5cthsDe+b0vfS3u8La+r6g+eDQrIG8/Z0WkZ6etS3DBofBIVbn7odO5SOcCEI7T92j+QVwp5ziI39SngdDstht01tQFxKtipB8EsafnYFCPonoNlXCABF8FRLAoj+kP3zHucVruGOpwNzIWns71reKTEPjL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iN9QJQlh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iN9QJQlh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781037269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mpHDCXlfPC40orLRXh0LNnJgWxWBHHqm2OypJ1ZmuY=;
	b=iN9QJQlhpjoVm5lQDiDmG8Mdy+bEZFeq4clyfIaj3wI2aqq+3/19LlwVeDl3ZZNgpZj/FI
	nTEk0viUKbFROk1GUFdoWP56vKJrKh/0JOVdlgmr54V0pXoNzUKiv9Kgk6Qt8nR5pVBiYq
	Zjvngm2DwamzMiJkewUO2qJ5fTthQtk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-uy3MDCd5Oyi5UU9iYHrJBQ-1; Tue, 09 Jun 2026 16:34:27 -0400
X-MC-Unique: uy3MDCd5Oyi5UU9iYHrJBQ-1
X-Mimecast-MFC-AGG-ID: uy3MDCd5Oyi5UU9iYHrJBQ_1781037267
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490abeb7298so62416445e9.2
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 13:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781037266; x=1781642066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mpHDCXlfPC40orLRXh0LNnJgWxWBHHqm2OypJ1ZmuY=;
        b=PQzvSSDkjWmY33GQ1Ka8K91l8vBdr9aD+uaBXkPopOc7pOKbYxjapn+CMjfEiw8YKw
         XIniG/AVVcSetHU9OS2Ut9TlVdRzgGssLj8/RE5mlkpqwnr3+mt3eEcW2ZBrdoqNwrXu
         w4XF5xep0+NUu6Q5wfQxOb5BxZiSZzjRZ2AyLG2WPbIKcrPZWdCtwXAS5NfTKmGfLG+H
         HY5FoNjZEP34GsnEaeZzy6yvodhlAYYoN+GbKeqvspAquCM0e+e0RgP+ms3WH0U3l34v
         TuG9P1R0OLn8APXgc+/wTR6Vi+mjgeW+38osUpJWzC0aamY0nhTtLrHgFPZ9gGen2UvV
         ahvg==
X-Forwarded-Encrypted: i=1; AFNElJ/9JoYTr7GWbjAQKUGV0rcF0PtuqM1Ql+qCx2zipPwiVbkkDIiHA5MfoBthH/JepG20wAtFSm/f+MUHq8g1qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfQroolTfz9fX89ZbCjg1WDGycWZH3Uy7lF5SZdeJX88cuBuHg
	YpkUEJNK8zUrhHWjPV02spwCa/DDgUI5uH9mXpmnVi8+J7OImHUtvLRoye8Rp1haRIaTiBVIcw1
	2w9tBNHMYEF5Mkvz1s3vl6WF0xy7PXY4IITQmQYxEjkormXqjpjApFskTphKY5d+B1eQm
X-Gm-Gg: Acq92OHvN+cK5liiLpGw58IwZHExyH9QMDF8hOm4UPuVOJd9C2usrfIYYEto+de4lI6
	QABbkuJp44EqTUc0LbFuEUjchAhl28KQqLo7JkKNmiJBWiqALrzJtu2W6/nwV+TfM6ydRMec1Hh
	POyWDhOGXSZHGlZSeMfrQwgSxLB6PnTeBgKmFBeoRknk2OrDGcXEVSii2OTq7uLcYHOPxieUQxl
	61O6Vn6b9TTs4bI7XVH0HBzU5YasQsf+uP4LF8U2XkP1fjAssJtP7hgTHhLYT4B8OwJ3rWGW32o
	1fhdQWKGxAzcPvRnoBwU0mjolq4RjoJ+60eG2KGiF19NZ9j7MHaf1hv1rvEfXzdQD6Dufirr9gd
	9/TonXWYUrtq2KuHYLDKWjVK8P8ax4IyBvXyd/8zR5GMTWdsjasWi9A==
X-Received: by 2002:a05:600c:3f0e:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-490d38c7867mr111793285e9.3.1781037266590;
        Tue, 09 Jun 2026 13:34:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0e:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-490d38c7867mr111792775e9.3.1781037266071;
        Tue, 09 Jun 2026 13:34:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dcab44dfsm1176375e9.2.2026.06.09.13.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:34:25 -0700 (PDT)
Date: Tue, 9 Jun 2026 16:34:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20260609162437-mutt-send-email-mst@kernel.org>
References: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
 <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
 <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
 <FB250C43-790E-4AB0-BD40-74665FC601A0@nvidia.com>
 <38C84F23-E881-4DB2-86BA-93F39D44AE1B@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <38C84F23-E881-4DB2-86BA-93F39D44AE1B@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SKAj9iM9yqfsWtvb-NbhfRovEp572tyzyP0b39msnRk_1781037267
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 02:52:47PM -0400, Zi Yan wrote:
> On 9 Jun 2026, at 14:39, Zi Yan wrote:
> 
> > On 9 Jun 2026, at 14:38, David Hildenbrand (Arm) wrote:
> >
> >> On 6/9/26 20:10, Andrew Morton wrote:
> >>> On Tue, 9 Jun 2026 06:12:49 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>>
> >>>> TestSetPageHWPoison() is called without zone->lock, so its atomic
> >>>> update to page->flags can race with non-atomic flag operations
> >>>> that run under zone->lock in the buddy allocator.
> >>>>
> >>>> In particular, __free_pages_prepare() does:
> >>>>
> >>>>     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> >>>>
> >>>> This non-atomic read-modify-write, while correctly excluding
> >>>> __PG_HWPOISON from the mask, can still lose a concurrent
> >>>> TestSetPageHWPoison if the read happens before the poison bit
> >>>> is set and the write happens after.  Will only get worse if/when
> >>>> we add more non-atomic flag operations.
> >>>>
> >>>> Fix by acquiring zone->lock around TestSetPageHWPoison and
> >>>> around ClearPageHWPoison in the retry path.  This
> >>>> serializes with all buddy flag manipulation.  The cost is
> >>>> negligible: one lock/unlock in an extremely rare path
> >>>> (hardware memory errors).
> >>>>
> >>>> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> >>>> in this file operate on pages already removed from the buddy
> >>>> allocator or on non-buddy pages (DAX, hugetlb), so they do not
> >>>> need zone->lock protection.
> >>>
> >>> Sashiko is saying this doesn't do anything "Because
> >>> __free_pages_prepare() executes entirely locklessly".  Did it goof?
> >>>
> >>> https://sashiko.dev/#/patchset/df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com
> >>
> >> Battle of the bots: it's right.
> >
> > Yep, __free_pages_prepare() changes the page flag without holding
> > zone->lock.
> 
> __free_pages_prepare() works on frozen pages and assumes no one else
> touches the input page. To avoid this race, memory_failure() might
> want to try_get_page() before TestClearPageHWPoison(), but I am not
> sure if that works along with memory failure flow.
> 
> Best Regards,
> Yan, Zi



Actually memory failure already plays with this down the road no?

So maybe it's enough to just SetPageHWPoison afterwards again?


diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee42d4361309..4758fea94a96 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2415,6 +2415,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!res) {
 		if (is_free_buddy_page(p)) {
 			if (take_page_off_buddy(p)) {
+				SetPageHWPoison(p);
 				page_ref_inc(p);
 				res = MF_RECOVERED;
 			} else {


and maybe in a bunch of other places in there?

-- 
MST

