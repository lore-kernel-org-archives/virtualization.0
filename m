Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B132360ED6
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603546; cv=none; b=Z6F6YVpYWed17gRI7d3WzA2JYUIOA+ivJa6lSHS1BGU97hqip0iHAy3diCKwE+sG69c+GDitp1Y8AmyMq4XYGWj3KKE3YChsaTZ8ol3nXSKZHzYENf+bg6CSa6s7Y8Yham/uI3Vio37zYvEshHXeLzTVd3sVZhWQ8fkBB334M0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603546; c=relaxed/simple;
	bh=JRKdZeY+vE61wMluB5D7aDBZ1E8VEWRJfkASzlOm6KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdIxgiUnW7d/xTDKwp95YeUBI1be/q4c2a/9SCYa3IqtJQ4+dJ2tIhTDtheKDSqyDChCLERIF08dgBiD03Ldw1pkfY8xDbkheFiFAyts9hZBhLwLdCBVVyGfjjOtj2bPerVnYFKaEoAseLHqjAdkSyvO8n88r2U4ZQbE12sv9fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TYRY5XSz; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TYRY5XSz"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-515226c0cdbso5202171cf.3
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778603543; x=1779208343; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUBFCivNGlkf0q4LVho8uONOLnLA2U/Jo+KB+lWOcJQ=;
        b=TYRY5XSz13MeJ4tiw3GhJsHoBDOOIWkKSLa3BnezBdfFQviAFacWZkedcvDDZvuKIq
         421qP4MGGa5tid+ns6COVKrdHo84Vq8Ma/vWcFI6xJeZh4TzOGxdJxd9+4K+zkbHv3kv
         z4/HBlPsemyi5QNT8EaN26jUCL2RX70FtKx8Oo0gukfAXquxIgKwsiEWJsoD/A/+u1ty
         Hky8Pe/ku3xVkFBfLzz390HgwzhLHA7YYA7F42h0tfKx/ErPj8Jfwr/RZyWjUNHz31oM
         cdeQ8IZCyPPKiDacO1CDsT9AvW/SVF8uSt5eFS3BCxyqpiJ9FhnyW4uOj4ZD15ey95/F
         OYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778603543; x=1779208343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUBFCivNGlkf0q4LVho8uONOLnLA2U/Jo+KB+lWOcJQ=;
        b=AVn8udBF+4PHKE5LX8y1AR2RiVK41Sg3ruqMo3HK7iNezvfY+4mp64ywm+XDFYgav/
         iolAlFY3mueXXPtg8YAYXZrNTNckFPL2LDiWxprMVDACCOQg+HAxAEjHImMERJAS/6lx
         YSeEDPETs2814misq1WplDeMrU+YAh+/MyXdeUZdhTcqq+tIX2Gd8xwB6fecp93b4S+D
         5bOefgaKaLcipDsvwleJOcv/XVzqceGxO53n24vk7QZHIDwbmOqpGzYLAD59RVwbaWZN
         dwXDGJsSJxGFEr6BMbzMS6Kbvdskk+sqXA/Z0miD13d0uKDnwq4/a6MCj09vOUqA5mpi
         o6NQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NPwx3ipB//7gdN1Un27nluw/XqfBLF3oAGGCYaVFVSecxG6XoCk/u8cpNSYh2GocWbcgqLpwIII7axbIt1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwkKj7fJ0WSBgMyCXknTYNZchqjtGccB4Z7MwvK3O4pCYik0DZ
	Qo0JK4s59HLJMIUI5oSXV87Nh6Yn8/XkDyAeqXs4y0oOWDJY8k55u4vXnAroHYKpJBM=
X-Gm-Gg: Acq92OFzfuK9bhgKln4D4yXqDL9ZoFrX/qWDggWJ2d2dnYfpMI9QnrWbi6BI8txhEof
	FFL7Mqu7n9jg/fvVRC0csPOVFGyfqhCa4K3FmdClN8UOVc0GUjOhEdyQklClGQB7Zg/hrIFiTUT
	c1hIBxh2Iy4WMHGs+se/EuD3PK4EQNLSZFKlr1G47oI4pIG7asj/dXiAm//xsP4n6b5EyIMV/Jr
	B4y2ppvniBv9KtOtnbDeC8/ZBMzfcKQArAOBBqU2qlD7kreABFCkNDhrD7Q7KRwZjV55wFWAmat
	5U5yv7zOYHAYiUv9DHtLXtw6iSXJun8na3Wga6I3ZRlIlwONJBUfOhOcEz3z+OjgKEIQRhDRCVT
	774qDVRm3a+JyIlsno7hnbUy9UWBpOIg/6upAVC4HZjLTWnlodSTguDQXVMzALrfROPJKM0yPQb
	JJgLgBlLWlbAYvfE6+jJ0+/0K20Nb/+8U/cJQIA7mfDcCm+dxob9O7vnkIyn/4zfqv1lIoKQfJR
	03OQxufOSte
X-Received: by 2002:a05:622a:14e:b0:50e:5e8d:87d2 with SMTP id d75a77b69052e-514d1c1fb5cmr54799371cf.1.1778603543444;
        Tue, 12 May 2026 09:32:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e68a963sm123339831cf.13.2026.05.12.09.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:32:22 -0700 (PDT)
Date: Tue, 12 May 2026 12:32:20 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH resend v6 20/30] mm: page_alloc: clear PG_zeroed on buddy
 merge if not both zero
Message-ID: <agNWFPBTBszcq5GP@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <a09c1848702368c3545b980c17101b5185ab774d.1778489843.git.mst@redhat.com>
 <agNNkvRK128bYhrf@gourry-fedora-PF4VCD3F>
 <20260512115805-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512115805-mutt-send-email-mst@kernel.org>

On Tue, May 12, 2026 at 11:58:27AM -0400, Michael S. Tsirkin wrote:
> On Tue, May 12, 2026 at 11:56:02AM -0400, Gregory Price wrote:
> > On Mon, May 11, 2026 at 05:03:35AM -0400, Michael S. Tsirkin wrote:
> > > When two buddy pages merge in __free_one_page(), preserve
> > > PG_zeroed on the merged page only if both buddies have the
> > > flag set.  Otherwise clear it.
> > > 
> > > The merged page would inherit PG_zeroed, and a later __GFP_ZERO
> > > allocation would skip zeroing stale data in the non-zero half.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Assisted-by: Claude:claude-opus-4-6
> > > Assisted-by: cursor-agent:GPT-5.4-xhigh
> > > ---
> > >  mm/page_alloc.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index bd3b909cacdf..d70c9ba6b329 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -940,10 +940,14 @@ static inline void __free_one_page(struct page *page,
> > >  	unsigned long buddy_pfn = 0;
> > >  	unsigned long combined_pfn;
> > >  	struct page *buddy;
> > > +	bool buddy_zeroed;
> > > +	bool page_zeroed;
> > 
> > If you want to play some code golf, i think you can get away with a
> > single bool here:
> > 
> >     bool zeroed;
> >     zeroed = PageZeroed(buddy);
> >     zeroed &= PageZeroed(page);
> > 
> >     if (zeroed)
> >         __SetPageZeroed(page);
> > 
> > ~Gregory
> 
> Does it matter? It makes my head hurt.
>

Less code generally means less bugs, but this is more style nits than
anything.  Either way

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
