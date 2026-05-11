Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2443D51E
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518335; cv=none; b=EeA8jBGnDlgdMddRr7wlo1dl1QhgjKpx7cgJClHlGfutsFWlP6GK551vbD3tgI3mzG3KBfchVuvGz9GxnmnMZX9ZbnMk5+snxcAmD/GMhCArD/nXjtQBU24yQFcs7LyoGUsyvN5fyo5xUfLcyiasCX0m6jjDQh571EzODyZAqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518335; c=relaxed/simple;
	bh=w++Mc6fsfXBYdFsz3+M4dmIRX40lX1nYDeGHE6Q83+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+YrG4IIbhY7lNIsNg6ldOhBBoNW/jmr13YBxmAWUVNeFL2Gyc6622PZtA2qSCgze6a23zUcPh55NdEOYt/oIO1l8d7t6gR3I1vJKEsuWoA/0B5qNl6xpEMhCJ4PhOK1sU6LySyKcJcAWiZjXfZWUa5Qn/2kfvKsVuK4qO6DrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=b1Yv0+a4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="b1Yv0+a4"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e63771d91so46938781cf.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778518333; x=1779123133; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O2xFv/znNeupkUwLf2eAcAA4yCdnf8t4om4s5YlKB70=;
        b=b1Yv0+a4gcT60Mmk0VhFXeGpVYCHwf0R2czka+hEBwWS7vig0z4uSNp9OlQBiT3MPO
         /wTAzDj/DrWS0vL3kkf4F7qMq4Psf5nbHBSkBEd0Wr2C56/bICVLHN7UyO67kscRDOrr
         IKGMdypEU1OSiyN5doyUQaFkIQK5oZyZuGJrEFPEkvB8bRBhqVDezA2gCALzFscYyoUp
         Q7xVwKmyrMHYJobkasaYOi1MOfHsCKc/NT+KmBhgOkgFNxeZpma++4xi/h8h6SeP0HeB
         fMgmHC8P4XrhicTW1zfUuTl1I65mjpIRCqfT8/KaLhz9G7lMKTvd1PzCBHnovSSTML6V
         vXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518333; x=1779123133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2xFv/znNeupkUwLf2eAcAA4yCdnf8t4om4s5YlKB70=;
        b=i89oUJUgRLX1OFLxVC4qkeqHyMibP9UZIY0H3h6uU2Rh2oIjInjN/uzxzoM/dBVejO
         o21M+CrIOJQd9ua+BDBi6pVRpYX5T6X2Br4kugbfvj3xDvjf0HRz07dQQVyR0BQMZcF3
         3wydSm3lWmDG7cI7c+A6bV89zivByb9bmf7q55J3jhnmCjahrzQVXzJ710OeJpGNTb+0
         k4PjcUBqEmAyyTtROk+cRQ/z+zKTBlbA1lljgefgEEVE2FPuprpLgeDazLJxwb46f0b9
         EwjDoZTqD6ljCJnUFQYwNVAqPeIAvzetzjA91Cc5w86uA+DboBCFDT5CuQZcOxHDvsgX
         4sIg==
X-Forwarded-Encrypted: i=1; AFNElJ8tmk0k3TbmUzm9YX7RDTaZma9ocrAqg/y+8giN4DjqjyByIKTrobj39z4TW/A5e2tfyrPeBQLEbX5rJXWsGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw82C0t4b1QpQy8sNMPqo8BRX5T2cb46FtgjgdYR49tNjoGa9H6
	Ac23Pt7TgGVWvNIGQ1uw+6Mc+e1yNpdLOMgL10xIavtOPio4IdUaiczX9IijlDvSAfo=
X-Gm-Gg: Acq92OHcvAxgLlPtxHynJTwxphoOoIJUaq8r+zhQa3/HEj4lNcwkPAGaW/bgYK2I8SP
	0cOGk7ykxbz6evdL8mtFUhTsFbfwk0KpyD5QGVRYSz8sHshr1u7foAcQMqGC6Yk8Du7KOwaEeP5
	ycMWwS++TcKO4BXpiaqSfFGcwh43VCAx+Y609/LruU1YCkYJuGUJ7btSbLHkTnQ9nFe5C8xcXNA
	Y/6XZAHHh/ggm5b75aMCbaHjOhUw9p4d2bCMY2sel3AaVU5PvS72TdWPaUb5+3Ca/oK+tyK5v/w
	aYlzw5bmNXZI63rKek0D4mC3QMuw/fktVVeiYfBWkNjoPvxEn0hMBT/mf7tBaXPmuvD12I+X6pH
	cJCquPXXMuV4pOyxkiVktLG62O8TW1vc9An/C5qb1mNYxvgb+6qmU0wvfToQRfKTHXZnuNFFhP/
	lr/is6hnbxTJpY5wzrK7EhB29AWmB9qtD3+rNmq+++84coye1wrLXdJq3FwBcfKE4aaAX5ZGjFS
	03Q1QpHda2g
X-Received: by 2002:ac8:5704:0:b0:510:141d:9d06 with SMTP id d75a77b69052e-514a0a2a364mr162992381cf.10.1778518333136;
        Mon, 11 May 2026 09:52:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7bf7e4sm94051171cf.17.2026.05.11.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:52:12 -0700 (PDT)
Date: Mon, 11 May 2026 12:52:10 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>
Subject: Re: [PATCH resend v6 03/30] mm: thread user_addr through page
 allocator for cache-friendly zeroing
Message-ID: <agIJOkLhTOsvJs1-@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <9b53972f4854c1064b92cefc464f51949afeb83f.1778489843.git.mst@redhat.com>
 <agH3wceKcPNmixCj@gourry-fedora-PF4VCD3F>
 <20260511114853-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511114853-mutt-send-email-mst@kernel.org>

On Mon, May 11, 2026 at 11:55:40AM -0400, Michael S. Tsirkin wrote:
> On Mon, May 11, 2026 at 11:37:37AM -0400, Gregory Price wrote:
> > On Mon, May 11, 2026 at 05:01:55AM -0400, Michael S. Tsirkin wrote:
> > 
> > > +/*
> > > + * Sentinel for user_addr: indicates a non-user allocation.
> > > + * Cannot use 0 because address 0 is a valid userspace mapping.
> > > + */
> > > +#define USER_ADDR_NONE	((unsigned long)-1)
> > 
> > Ehm, hm.  Does -1 hold as a non-user address across all architectures?
> > 
> > What about in linear addressing / no VM mode?
> 
> this is used on a fault. I don't think there are any faults then?
> But maybe FAULT_ADDR_NONE would be clearer.
>

Meh, naming here is less relevant than the sentinel correctness.

My only concern is really whether -1 could end up being a valid address
in some horrid future timeline and this all going belly up.

Is why I asked about whether this is correct on all architectures.

> > So the trade off is:
> >    a) churn the current interface for everyone
> >    b) add a user_ variant and know people will just get it wrong
> 
> I was also explicitly asked not to proliferate too many new APIs.
>

Yeah simply spelling it out, not asking for a change.  Probably no
better way to go about it.

~Gregory
