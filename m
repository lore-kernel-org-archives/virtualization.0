Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CAD34D3B5
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041476; cv=none; b=ta3zCD4KGlJixqaYrKIWQjUDbGOL2wAZhWlVyL7THkPEK5cSdYyxAY4g09hXTJV2gvhvzSoS2e7NoWCqWUutX291duLGt6MBt5a/0pIF+VCE511Qq+l9aV5OBCtGBxHAAK8xZR+EDhghAkn6/ctDcbJUxiDGQJ3JIxTDTU1sBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041476; c=relaxed/simple;
	bh=ngWxxhFZyG95B9mFBhRcs3m6fn2rrKlD8/SIsytvgog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hky/90kJGUrIa3Ku/R09tD6pCJcR4JoOZkarNJ8tB8MeXYtpAPa/7q3wFiqtvXbK4bq4j+hSlSFKWBb9RN0ZcI9iR8Vbq5Eeg3yjHPtmG6gduzfpie8byBNmLMfvN2TCVEuIlUr+huhYshVj83L8MFsHjEYEg5YfCK+Y6ttKZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ub8bfAGA; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ub8bfAGA"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9157f7c1c0eso604089885a.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781041474; x=1781646274; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aD/5zoYJey3JVZwJskUEOWQGpMW2wHY02NSSmxoYtHs=;
        b=Ub8bfAGAwlg35NSuKraJVcImPBK44kYhy8NYbAg+koI8hvIMFFOX0ZVLQUWeiuVKTB
         LZ6oWfxS7JCRGvt3Ejg5+Lx/JVI6K4iXJtIytxJ90CMNiJu/1vBVph0Mnk9Suv0awdlC
         jQ4Wwcp8O46I7oYoAi5TL6XgqCdfBQsYJ5qU6CHegv9YUZTCfEvQ0GgQlvd1MifaPo71
         8vz+UEJB69KdRQjasZOMaysx4JskHxx4lFnrORbC2BMX1pqo0brJd9Ypv5AeddRA1LiD
         //TFeIyptdwNbNg4S/N5BrEYlEpRQRt/syDn5FzgeXpr0hos3P710Hu89RiEokv+FqW/
         PU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041474; x=1781646274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aD/5zoYJey3JVZwJskUEOWQGpMW2wHY02NSSmxoYtHs=;
        b=A/hJpsa0uyCVwZX3cVVTQg89etbVyiof5POXIas1Tx7H05jPAH5lWe4FUGNpjbD6rp
         niYDP92C/zmYkxr7lW1Vd1R3rKH4OSnbB9oCP5MhHOTQvvgx7LBGFwuZVPK2J2rAtdtu
         /KT88MQZUtUywtpNLMQQ8rAbyDDzl6PvmcrmJeNsMBeLUmjFMNbIPe1zPcjAix5f4LdP
         NdRpJhCZGWmt0QRUPq2k3Kw0Kgn8nSCfmT3ai3GY+oDqylLXCbvLopM9Z5aOxuDSKDgX
         t8XvvKqNtCM09mCN+zm5lFGN10hEXDU2NMLA+ToL0Sxt6BqKkEPdIfw8q82s3NHOlW66
         k5OQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SVE/g/l1q0i38i4zDLoRkm1jpi+fN3CobIOOCCvWTXNaFDZ5WQ2/gHT6S04AQlx6USAXG0uNlx+8Ypy2UPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyZ9V5g22ToCWcooVSLVaTn6yf5EH2eZZfOwvKscEKEJh0AgMr
	dm62MyDc/nUXVAAHEqRY1+IKeYstb+Zdi97uPQ0sfBlr4TR/tONolJIEXqjyU71sr+0=
X-Gm-Gg: Acq92OHghRj6zsiTmo9B1Eh7hCGl6v9xeffc0in4alJZibXo9/oCRyxKYreDAk3fehl
	ocJEcvfn/BEF7yrS2UE0Mc1QERr5x9AVttCyCliddjsShXg2X0DIsqli7cptjJR57h5THtnePw3
	g+w6JSAxXLWAsMYW7Jt9/gVjsvSqCTnCPjdI+qUouEZymOz+W6wQgFW7KJDxEdeVNQwXUxRhVP7
	pTE/hw1m5VVmdgK6Ie/Io6Wcpq1norc7fYYXCQKfrrMDLg6JA4rlHjkzU09WcFkiF++zBoBpn5T
	dUHrROv7taIg4Af5QCWzh8e00qnyqwcEIKQ2x/Cu3A7iAAl+9n7voEPUXDt7FPfYSZnD1rqZxiE
	npEYQSYycvuGAlTwMb3PZEFBCeCU7eWIt4cWsPsi+RnRak5j6rQZHfNEOE+ZPI8W7komSYCDDXm
	wI2p/KUzcGfCpCR57DiGWITlDoq6w/NoWNEpapFtSnyx3ntUt9lGgsH7MBpHAzsdntkMbUUiw/R
	i366w9K4+lvImHWBzUhI0brx/Dj
X-Received: by 2002:a05:620a:880e:b0:915:cda5:27ff with SMTP id af79cd13be357-915cda52bcdmr1869020485a.45.1781041474035;
        Tue, 09 Jun 2026 14:44:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381abfsm2275058085a.27.2026.06.09.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:44:33 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:44:31 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH splitout] mm: page_reporting: allow driver to set batch
 capacity
Message-ID: <aiiJPwhn6gF3ILur@gourry-fedora-PF4VCD3F>
References: <b25ea6c63503f24c8b5b64910a44dc03b5aa610d.1781020302.git.mst@redhat.com>
 <aihRBTaTUmgYmZfX@gourry-fedora-PF4VCD3F>
 <20260609160506-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609160506-mutt-send-email-mst@kernel.org>

On Tue, Jun 09, 2026 at 04:08:08PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jun 09, 2026 at 01:44:37PM -0400, Gregory Price wrote:
> > On Tue, Jun 09, 2026 at 11:53:20AM -0400, Michael S. Tsirkin wrote:
> > > --- a/mm/page_reporting.c
> > > +++ b/mm/page_reporting.c
> > > @@ -174,10 +174,10 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
> > >  	 * list processed. This should result in us reporting all pages on
> > >  	 * an idle system in about 30 seconds.
> > >  	 *
> > > -	 * The division here should be cheap since PAGE_REPORTING_CAPACITY
> > > -	 * should always be a power of 2.
> > > +	 * The division here uses integer division; capacity need
> > > +	 * not be a power of 2.
> > >  	 */
> > > -	budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);
> > > +	budget = DIV_ROUND_UP(area->nr_free, prdev->capacity * 16);
> > > 
> > 
> > Initial look - is there a div-by-0 here?  I noticed the old check
> > prevents this from being (0 * 16), but i don't see (on first pass)
> > the same check anywhere.
> > 
> > Unless this line below always forces the above to be a
> > PAGE_REPORTING_CAPCAITY if it's set to 0.
> 
> It does, does it not?
> 
> > > +	if (!prdev->capacity || prdev->capacity > PAGE_REPORTING_CAPACITY)
> > > +		prdev->capacity = PAGE_REPORTING_CAPACITY;
> > > +
> > 
> > It's worth making this corner condition a little more obvious.
> > 
> > The code intends for 
> > 
> > if (capacity == 0)
> >   capacity = PAGE_REPORTING_CAPACITY
> > 
> > but that's not reflected in the changelog as a default value.
> > 
> > When happens if a driver sets (capacity=0) either on purpose (???)
> 
> what would the purpose be? if you don't want reporting do not register.
> 
> > or
> > because there's a bug (???)
> 
> exactly ??? since where are we practicing defensive programming in kernel
> APIs?
>
> > and then page_reporting.c forces it up to
> > 32?
> > 
> > There's something to improve here.
> > 
> > ~Gregory
> 
> 
> So I'll update the commit log to mention PAGE_REPORTING_CAPACITY.
> And maybe a comment near capacity field?
> Should be enough?

I suppose the question is whether capacity=0 should cause a WARN (i.e.
only a bug explains that value), or if capacity=0 means something
special (i.e. use the default) and therefore that should be documented.

I don't know which of these is the case, but if it's the latter than
that deserves a comment yes.

~Gregory
