Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE163A4538
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067853; cv=none; b=slqJ1WRIui3DJnkUM9MOc1g+ElehVQ4mlyz5wZsVCKJ6+HAQAhe5hEXs96xcw0oqRZEZT3TXzNnt0NH/ithugykj7P6GpHvxbynCGAj61GMtAfU/fW1EBfXhfzci8EfbiNuU9r+YhySYGXATdRVOy+I2p2nvGwCNmxHOuvLzZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067853; c=relaxed/simple;
	bh=GEunZ9UcB09fSEmuMjlxeLs2Xmd5ksXd1isCdjy3oSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e8pWEMVIvCrW2wAlhEi/0qQUPbWpGAlsLhh+/Ot5EjMSpEHc5xiEtHT0fzdbLJrda3djmG2YsnLb1vZPcP8sSywr6HvvSFbcIHz+qJ7P//hi/Sz6zt6Ddz55XYu8jmsR75P0iPfLJITJnOnf7ZpwG1P7inayQR0t0Nc6S0lOiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QimhEpKY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QimhEpKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776067851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OaQMCi5HMfp/OHds/BFFbF3BJqhYWZNHL69rqmLc+L4=;
	b=QimhEpKYn4IQUcwcnHLjdMxc9iTfIcbxXrwfvg16zuLp0nRbmj+wiEKWmxr790JZGCzwJC
	gjKzZH9duU/JCZQAC+ydepL6UYLCcjEvJ//DCKYYmlsGDsGyekdwNHlPaVjfc9w+zEYzQ2
	Bfko8lXqpk1c8FnF4ofSY35Y5aGcFLE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-5X7JWudBOuin6d6v9znwlQ-1; Mon, 13 Apr 2026 04:10:49 -0400
X-MC-Unique: 5X7JWudBOuin6d6v9znwlQ-1
X-Mimecast-MFC-AGG-ID: 5X7JWudBOuin6d6v9znwlQ_1776067848
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d70e3e4e7so1022086f8f.1
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 01:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067848; x=1776672648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaQMCi5HMfp/OHds/BFFbF3BJqhYWZNHL69rqmLc+L4=;
        b=pOo/Ac9kAfZCFHEvk6PCD9Jv/kNzKKpw+CC9G0Ez1hSjEQCO9ut+WdorQAU8eYfpMj
         /Mn8MLc4qgZ6OspC5g2xMzcFuvq7eWoSweqnTZzz6B21qy43v8zC5lWHpcnKkeqyNq49
         f9TmUfG5TpZ+3ICuiZ1VFpME86hgZeyWCXnvt8F1wav1zjSzrvNrEPqv/ny0YUy2LTkk
         vaWLedWfbNpwz3x1291ne7eCI5XKtxYkgiSzyNheMc96lDNcxNqIbNFH4kvZRuwWTWRr
         509ZfjH+HdfAHWD3orcg1q4lZiBZRxMYS3XK4UYHLB0H39FbBIypCPXqYFc9dWyURft2
         9MVA==
X-Forwarded-Encrypted: i=1; AFNElJ/LFQGty8xaBakOKcqw84LiiMnKWEK473yPrDCbVF215//ioyA5nKQfRK5Dx2SsJF247wqBApLHe/p3oRZl5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnZNyHcqRK8V3IBiQYJl5MHKGJHBnWo3Xz5ztDWA3Wfh9OYpx4
	gcjKUxfLYaxseuT/K28dOo3wPcJIO7Em8p/wRlIFYdd14dEaZ0lcj46hPtV3Qhhcjv+lfZfiY10
	azrbD5t5Cv5knFkiw7y9nU06OI3o4/y9uW0iFjLv1Eh+ra8uFMLCiURlb/t/+C7NyprmG
X-Gm-Gg: AeBDieuRcxoQJgTqQjE6eTqJOZ26ZeA8c5gnL+qaYHGQvenkHI5munnZRAruEmwUCXK
	QLheYj/uAriE9U5GE24m67Q4WzYFlGUEABqLUkm9h8Rn7StdWEaylPNvkTWJnBxTUdXzQL6wdeU
	jUM/BV/qdN38t6YsXyuixf1V0icfaOIypYoc3Y/fa9nNaNCF8Jh/fSZy4rPneSn2ozsRvD6wWl2
	UhrtC8grD2dmne63WibfN+wR2MdxtcVTmg2730G13+ohIEBCBOANCdhhTmPHpYlLopG3pyKxDwC
	hj/xkxyQbYA6wLYuKegpjn3h2Vjvaz1NyTxhr3GGH7BaIseUGL7j+P9zCoyBKesoheQ/lS8bziR
	Y4tUm0Zf53vnzeAZ+/IlKHcffvocM/XEDeZi3tO6h6Ag=
X-Received: by 2002:a05:600c:4715:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-488d67e7dd4mr183038885e9.8.1776067848272;
        Mon, 13 Apr 2026 01:10:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4715:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-488d67e7dd4mr183038325e9.8.1776067847773;
        Mon, 13 Apr 2026 01:10:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5344e28sm297869325e9.7.2026.04.13.01.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:10:47 -0700 (PDT)
Date: Mon, 13 Apr 2026 04:10:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH RFC 2/9] mm: page_reporting: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <20260413040143-mutt-send-email-mst@kernel.org>
References: <cover.1776033471.git.mst@redhat.com>
 <ea67e39bc3aea1b0b491908f851ffce25154cd26.1776033771.git.mst@redhat.com>
 <2155527a-e077-4b71-80ee-d735f9984f60@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2155527a-e077-4b71-80ee-d735f9984f60@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VkGYJ4zXL9jPgyEF3OML8bVPDdZ0hVcl46E1V1Sf-40_1776067848
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 10:00:58AM +0200, David Hildenbrand (Arm) wrote:
> On 4/13/26 00:50, Michael S. Tsirkin wrote:
> > When a guest reports free pages to the hypervisor via the page reporting
> > framework (used by virtio-balloon and hv_balloon), the host typically
> > zeros those pages when reclaiming their backing memory.  However, when
> > those pages are later allocated in the guest, post_alloc_hook()
> > unconditionally zeros them again if __GFP_ZERO is set.  This
> > double-zeroing is wasteful, especially for large pages.
> > 
> > Avoid redundant zeroing by propagating the "host already zeroed this"
> > information through the allocation path:
> > 
> > 1. Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
> >    drivers to declare that their host zeros reported pages on reclaim.
> >    A static key (page_reporting_host_zeroes) gates the fast path.
> > 
> > 2. In page_del_and_expand(), when the page was reported and the
> >    static key is enabled, stash a sentinel value (MAGIC_PAGE_ZEROED)
> >    in page->private.
> > 
> > 3. In post_alloc_hook(), check page->private for the sentinel.  If
> >    present and zeroing was requested (but not tag zeroing), skip
> >    kernel_init_pages().
> > 
> > In particular, __GFP_ZERO is used by the x86 arch override of
> > vma_alloc_zeroed_movable_folio.
> > 
> > No driver sets host_zeroes_pages yet; a follow-up patch to
> > virtio_balloon is needed to opt in.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> > ---
> >  include/linux/mm.h             |  6 ++++++
> >  include/linux/page_reporting.h |  3 +++
> >  mm/page_alloc.c                | 21 +++++++++++++++++++++
> >  mm/page_reporting.c            |  9 +++++++++
> >  mm/page_reporting.h            |  2 ++
> >  5 files changed, 41 insertions(+)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 5be3d8a8f806..59fc77c4c90e 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4814,6 +4814,12 @@ static inline bool user_alloc_needs_zeroing(void)
> >  				   &init_on_alloc);
> >  }
> >  
> > +/*
> > + * Sentinel stored in page->private to indicate the page was pre-zeroed
> > + * by the hypervisor (via free page reporting).
> > + */
> > +#define MAGIC_PAGE_ZEROED	0x5A45524FU	/* ZERO */
> 
> Why are we not using another page flag that is yet unused for buddy pages?

Because we need to report the status *after* it left buddy.
And all flags are in use at that point.


> Using page->private for that, and exposing it to buddy users with the
> __GFP_PREZEROED flag (I hope we can avoid that) does not sound
> particularly elegant.

But propagating this all over mm does not sound too palatable, right?
There's precedent with MAGIC_HWPOISON already.
Better ideas? Thanks!

> Also, if we're going to remember that some pages in the buddy are
> pre-zeroed, it should better not be free-page-reporting specific.
> I'd assume ordinary inflating+deflating of the balloon would also end up
> with pre-zeroed pages. We'd just need a (mm/balloon.c -specific)
> interface to tell the buddy that the pages are zeroed.
> 

Indeed, it's also easily possible - it's a separate optimization, though.
Another simple enhancement is including hugetlbfs freelists in page
reporting.
Doesn't need to block this patchset though, right?

> 
> -- 
> Cheers,
> 
> David

