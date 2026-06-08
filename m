Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D93D5676
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933523; cv=none; b=GlabxJmgxuhLchiwGE4BC2dCSsrakLF8IMi9JJLCiGYltIWB7HTU1rbOkhPKgm8M2Ai28F1qjqNl8ytynPdv4ASKqo27n9lNEuteeggGHGQIBM6FNMmEadm8+w8bZXp5u3aGOn4woq8yYur6B3N6NXKh5Hd44WRrGJ8nhSmYsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933523; c=relaxed/simple;
	bh=iYBksY+Dfyg7W8PHaVj7pKYc7D0TFLXdyIJhMlRH53Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH7ZiNjflcMemV23dDi6w46pIcDu9AvM1MxDR1jIlbjg/GzVfPwjoZChbrjYwXLlGnOeDG2vtQYGc1qW4AK49B9iup/3csX12SWS/PefT41qVKMeibbdmWZ7RvhacUwSaUvPkSh9kWkWt/PqHXueTMrKB4MrC727GqrQFAIw9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rN9K9cvs; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rN9K9cvs"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91578c374ecso371039185a.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780933521; x=1781538321; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1AEJD1gijFxE19tzaU+lK+SRdJdZGcBz2s9WNZ86i0=;
        b=rN9K9cvsbc3IeY4/8Cx28Ei8srs6amzDyBgFHgjK5xb3heeu2pcc80xbc6BSuvCQGZ
         VNSclob/7njrel+zt2lhFInmbNHhmESs4MH5oKN0gBbZmgIPvoTl8hcqzBlfyf6AFoaY
         Dh+7zUW2dcgR9pT8Ky+/E1KJ18BgYSDvn4j/yVnrwD4zd4Zeqd9w0Nm8Th1c9E79Wlgy
         517ZYDygzFHfw5zl+DiZGhXt+/c1TrCYFubzgPci+IBKiCR5xtJq4dSqdJ8RxGvsqLnW
         wv3kOfdilp1aEf2cl9XzOPmf6xENYjG/qpy6rRtbxlgScSGqSt55Rht3VAca8iiiqXK0
         TpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933521; x=1781538321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1AEJD1gijFxE19tzaU+lK+SRdJdZGcBz2s9WNZ86i0=;
        b=NVKtbK7thXrjgIz9YRAa65+E9iv1Geto6wd6ICzJTufBT9AN3cnZ7GoaX0LFS1xfQt
         pkaEPaOH9HSeaaSbCQW8/n96AFxcb7hbk8m8FXdQtGn3fDhYZreQK3Y29cByzbvSsqum
         bH2TM+YBz2InlDEqRDyY6wcwoyd2mKYr/liIqIwl5iC0bpfnqt3SLGx3GfYs8+mqSIq0
         sBlT+T/LLoLvhJKMyO71Yeyu6LynUFpAEcFtEWmGm/M7OHGObxOAuFXMayCcCqu4S9nr
         JX7NTvU7cvI/hFQ+e4InHSYKEv5vdh3S/Zt1URcrVPhUpnnUHTgjlBJVbwrbvZk138y5
         jYSw==
X-Forwarded-Encrypted: i=1; AFNElJ/BZwzq4FY0TelFy97TWetO0X5GWAQUaRA2rZmD/A0TyGKtmeKJC52kreTh3D5bHDOgKQfAWV0czvjTZwt1rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIYozqrY7S6GlnujwaK+wZ37ri42L2bMcIVsCbQVpMPwoNAgkO
	WWXzZkXHkts5j0sD5KDy8l5U5iHaj76/i2dbf0LQoQreD76KJs7acSfJi1rcfiQdnAE=
X-Gm-Gg: Acq92OEKXzXX1hZnrL824AsGrKETRCPQ1mcqzn6NLXp6JBzPMyLBRWM/0FariOW7vmd
	/CNF7jscfecfrZQAoQ+dlL5LXkuGwza7/OaayK/rDqkLX40XEk/MXGAT9dhTY7cNlFN4+tkwOwh
	CKun3szEUMNJI/lQdg0/K3OF3/mjnFxLFwDAs415mWJ+KQ9FF0lCeq7lC30bx7ejSDJHDCqg2O4
	e8TV/E6QKMXGc2oWb7Vj0DrbpSdgTLivE0gNZNugtohOT03Trdi24SlRgA/VIKHSPRz9mEGyNn0
	+GgTjrxtK8nYemC6yhLK3cq31JdpTiFoXmmJbKk1YGPALgpO7jyFYW4PlAHTwa5J+qvTTMsdf6L
	RMbMLWC2KQ1wXhqEiMXZHFXm0u3N/xzmhbzckO+R/kGZWYh/zy6xeNzpzuN/hm95j4SQYGTbyTD
	7dRo9m//DbmxKZVAyvbwAFlUIPqS+Qal8+sF1kaxVqCF+W8j1Hq0ByBxfjq1zFbsAt8JfrP35+N
	zBCksTn6tC8KpE+lA==
X-Received: by 2002:a05:620a:1d02:b0:8ee:bae8:2bb8 with SMTP id af79cd13be357-915a9d5784cmr2593487085a.36.1780933521234;
        Mon, 08 Jun 2026 08:45:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a21f871sm1787135885a.12.2026.06.08.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:45:20 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:45:18 -0400
From: Gregory Price <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: Re: [PATCH v10 00/37] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <aibjjsoeEcvXobCw@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <8d5d2fa3-a60c-4d04-b3bf-7a8fe89cb1a0@kernel.org>
 <e54f9b79-b6b4-4911-86ac-48b61889765a@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e54f9b79-b6b4-4911-86ac-48b61889765a@kernel.org>

On Mon, Jun 08, 2026 at 01:13:42PM +0200, Vlastimil Babka (SUSE) wrote:
> On 6/8/26 13:02, Vlastimil Babka (SUSE) wrote:
> > On 6/8/26 10:33, Michael S. Tsirkin wrote:
> >> Further, on architectures with aliasing caches, upstream with init_on_alloc
> > 
> > It seems those are niche architectures so we can ignore that part for perf
> > purposes; the other reason why user_alloc_needs_zeroing() would be true is
> > booting with init_on_alloc.
> 
> OK I misread how user_alloc_needs_zeroing() works wrt init_on_alloc, as it's
> negated. But you're changing that anyway to skip that user zeroing, right?
> 
> "
> This series eliminates that double-zeroing by moving the zeroing
> into the post_alloc_hook + propagating the "host
> already zeroed this page" information through the buddy allocator.
> "
> 
> So relying on "everything in buddy is zeroed" would still work I'd think.
> 

This regresses for anything that previously didn't zero on free or
alloc, which is most kernel allocations.

I think the scope of this set has increased too much based on early
feedback to fix the userland-initiated allocations piece along with the
balloon/reporting/double-zero piece.  That's making all of this
difficult to continue following.

~Gregory
