Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222AB3C7697
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601521; cv=none; b=uVAjsq1nXQFbwbi+e/95aNpud/ExVDQctShDoVQjYMyj/4TX8nl3y6SQV5ncHM6ZdJa5O0cP9FYDchcdGjox+hkMlva4p/PxnnQWYh/3gKmX/Jk3HmXUAQwGzJ2k4/TkSoLX0LPhxVVeRMoO/bch5cJfJ30wBTNLZabCQ5DVMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601521; c=relaxed/simple;
	bh=mFetL9IY8I56RXGEOxBcuN5Aswd7wGUXfiI2cWEQz1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UVTA5OoxysKMOvpMPBZI2zGpYhXldz4+enZITHgvi25iCzS5pLe/brac56U3l2IYvtDNhyiZvAHMnf1ADNoRM0p0s9HkUxYMYuimq1jY84/o5rrgzB+Uw2GrlAtVyyYnTl4EwYStgkdl88u7huy6tZMvBD6JdRq0kDQI6BxWL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeIJBkw2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeIJBkw2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778601516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJW4f8tXo6Lfw2obSKyz1GioGSG/zB4IqguSnk2BuqQ=;
	b=PeIJBkw2++2FsHg1LRSRKHyaeWtpPa05VL0aCXgw7igSpm2jg5uK8xKdfi2Tj79zwRVvE0
	IfhISITcTs5KX4Ea/d8mq98ub4tLED34z1dC/mSSfVjhFxD6pSoDZOkKj/SvgEOlMqU0qU
	9zYU3xguq4sxOgoRz+u1fbe6jRxM51s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ahauIIXiNFSTI75sYIaqGg-1; Tue, 12 May 2026 11:58:35 -0400
X-MC-Unique: ahauIIXiNFSTI75sYIaqGg-1
X-Mimecast-MFC-AGG-ID: ahauIIXiNFSTI75sYIaqGg_1778601514
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fc8dd6be2so580195e9.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 08:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601514; x=1779206314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJW4f8tXo6Lfw2obSKyz1GioGSG/zB4IqguSnk2BuqQ=;
        b=Xt6UJkBZIwSIBVnJXzx1zfA4UBbz61slZaClQ8dWgsT1WktxtCku/l0xi6E/jDfXgu
         i9Dj4UnzYAy6Iqdo/94G90U9WjrRgO8vNS881uQQGNlYR7SIp00VKjVKQ2zOGUEJfVsW
         PPd5s0c+59MPzGe4eAjnJVN0zxJFIiokfGo79kqDnh8Dh5TWFJDzVkUXeHTKsq7Q2U9T
         RzNxgU4WpLy1rjZTjQ6Iw4UFLZs1LcDJELzRcO3MZ8aZ9oAIO1DG1esQR4ltai5UUL7D
         bA8oWKgfs3aJ1MJeyAnJyW7GCzsvkWvNIToMBWCdmxCKsfe+Q2id2RJ1vx8wRJT11sFV
         ZdjA==
X-Forwarded-Encrypted: i=1; AFNElJ+vnDyZ8XXp4oBytcwfHD3CHZausdb1yZZ0u9aJNkEgg3xy9eIQDapG+8ERMr4aVLa3vYdVyh7yrU5NZq2hRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWVBjxr6VKi2jUwBxh+XOsZv4y2Mk+SIY0il5th1IMmCi2yBlz
	vW8K09TEAhvMF1npVgjRIMSn18AelmlBwpZ6I4mFIHUwsmxwaUhHWktaH65/j2NUstFY68tnBxY
	A46DT/VsxU3uYHioOqG4ynmmR9YPQBdLecMnGxojWfN1OKUFFWVZmXymUBtWwmmK4VWl6
X-Gm-Gg: Acq92OF1xProNlDqg16uX4jubSY/QFzonlSU8J+TzD/T+a+UIi0j29h6kET0Twrx1uw
	YjAT4EWkKQ6q+U+koUxMG4c0QoyoMdeKb9s0GDHBrsR7XjdJftHqRNhQ3mBvSkYqASuEZNCjzYO
	ACz80OyB4HkbIfRFQukOpxQ7NjtNPUPxpq8BSc7rmQv90kCVFvhvEeyx/xqk1rwE7zYw6EMDlbc
	KYvOaIKcbNyONNkpUTzpO+atJJLA0QEpKElwU5HxEtihxWpiwg92fs/mTYFY11hHKKlMKR8WFiz
	we4pYUoqd1kJ05vPYz84aE2GcWGP4Y419RoulYyOaTuy9eE3IRP61wcQMePpWcA2/uJj4BigX31
	7/uneG6/zzvGuloXJkTFrmO9pt/49ULmOTOQXcTGH
X-Received: by 2002:a05:600d:e:b0:489:ad:7b5b with SMTP id 5b1f17b1804b1-48e706d24e3mr228848235e9.24.1778601513785;
        Tue, 12 May 2026 08:58:33 -0700 (PDT)
X-Received: by 2002:a05:600d:e:b0:489:ad:7b5b with SMTP id 5b1f17b1804b1-48e706d24e3mr228847285e9.24.1778601513245;
        Tue, 12 May 2026 08:58:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f4247fasm29156585e9.9.2026.05.12.08.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:58:32 -0700 (PDT)
Date: Tue, 12 May 2026 11:58:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
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
Message-ID: <20260512115805-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <a09c1848702368c3545b980c17101b5185ab774d.1778489843.git.mst@redhat.com>
 <agNNkvRK128bYhrf@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agNNkvRK128bYhrf@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dmpyRXztndBaiK9bjXE93zIZPAd6j54BmMAcK0xUu-s_1778601514
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 11:56:02AM -0400, Gregory Price wrote:
> On Mon, May 11, 2026 at 05:03:35AM -0400, Michael S. Tsirkin wrote:
> > When two buddy pages merge in __free_one_page(), preserve
> > PG_zeroed on the merged page only if both buddies have the
> > flag set.  Otherwise clear it.
> > 
> > The merged page would inherit PG_zeroed, and a later __GFP_ZERO
> > allocation would skip zeroing stale data in the non-zero half.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> > Assisted-by: cursor-agent:GPT-5.4-xhigh
> > ---
> >  mm/page_alloc.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index bd3b909cacdf..d70c9ba6b329 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -940,10 +940,14 @@ static inline void __free_one_page(struct page *page,
> >  	unsigned long buddy_pfn = 0;
> >  	unsigned long combined_pfn;
> >  	struct page *buddy;
> > +	bool buddy_zeroed;
> > +	bool page_zeroed;
> 
> If you want to play some code golf, i think you can get away with a
> single bool here:
> 
>     bool zeroed;
>     zeroed = PageZeroed(buddy);
>     zeroed &= PageZeroed(page);
> 
>     if (zeroed)
>         __SetPageZeroed(page);
> 
> ~Gregory

Does it matter? It makes my head hurt.

-- 
MST

