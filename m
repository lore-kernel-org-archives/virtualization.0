Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DB938758E
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949881; cv=none; b=Es+TdCEN7KfYrnRq3ePb0L7z35ST/L7XbDes/uUvGjwSvKH+h+H8adiNYnIMwpt7FCJ5tz9xdv2hKlgLXsnIIyifwGwpktJ1qF4gDO3eOzV5WhUFqa8fnbaMcwe6lcAduUI8yvEPn7U4kqy4f/fqIreoWPa+VmIz37tEgi6IFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949881; c=relaxed/simple;
	bh=Afz6dk03s4ccCp3YsMkn2AuqSIaK756whnIE9ftF+gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=h2Cgq5Nvyc7zJij1hxlTD8y2V1OxpHxk1LKww796jRAEJHfnDYLquMo2UWJnWvoLanGNR9/ETml9s5+lt3qUwjqIsXNkDSS+akmeZsa4ndzObFJb9DhWMsZVmDj08U1dvvgmGmHTPB1EIicBVRZ4p6JXRfEveXdyy2Ep4HmHE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UzILx/wY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzILx/wY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780949878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vroj8FPw/hBBf0mVIETR1AI/cdAWI1hHo3K6Dubb1Jo=;
	b=UzILx/wYZkIsjcmnvqxQIDIYRxMvyYs5ITjiTTmoAgyFY8qA4+pAUXVC6xojgp8YVj0yb4
	2dS76SEVzD1u+0dnLp0NGZqeDFj1Zr3LWRhl9/W+UKr4F6/+G9HtcIdINzFUPRF+baLGuV
	9oluYH5FrfPHys2ARhHliA1LH+qdfAM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-C0QVvURcNeCxwtX8gf_rTA-1; Mon, 08 Jun 2026 16:17:57 -0400
X-MC-Unique: C0QVvURcNeCxwtX8gf_rTA-1
X-Mimecast-MFC-AGG-ID: C0QVvURcNeCxwtX8gf_rTA_1780949876
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b4d3d3e6so39247545e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 13:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949876; x=1781554676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vroj8FPw/hBBf0mVIETR1AI/cdAWI1hHo3K6Dubb1Jo=;
        b=jgOdjMEl1w2BLmh8K3MrGqyemKAogbV1X0Ji2sZUBCaxIgO5PWvBMCyKQ/K5RyauV9
         sOY3xKok1Pe5zPSDvFy2S5HNz3pEDrqSZU92EZQgUFFZcQgIYCFYJzRcEQ+DYlPub4c6
         hYz4ID3jLU3azN43zz5zELF9THZdHk4ht8lSOga7D/BCuFj9uwfaYrSEPYDVzLGmp0rE
         NlqzrGzm/Tb5+MQov6YEICh0X+wVGing2xJfxhoa6xxWOxk5jjZThjOcizQWOxdn0khx
         ZZv777tIs3zyibIfoT9bed5dv/V3IJ/XacmKbczOv5lxpzvEKLUFZVp59dagb0K32PUg
         C7xw==
X-Forwarded-Encrypted: i=1; AFNElJ8Sj2BKns7JI/wiIagwbXoCdbgleAnfp0vR9n0wKMj3pjZs/fzx2Us7JPjCdl9qxgoePchGAaAqf4NPLMko6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHH/KiL2W9wPsaTlxB4AfgOHX+6kdP02PmJPpFihmEUJRtg7t8
	eCob85HSc5jTy0llpCQkpoB3nCJK2jvynUdoM7UO+Jb3Ghbr2SLu2fVvbqE2Rk6zE0LnxTusjgm
	IaOGNfkY1qTzTvUM/odoJ9BaIGzAlbiWJVOhmWghfpL+jTxGB5z4B0A/PtCDJKscwBPy1
X-Gm-Gg: Acq92OGeHe8WQUm2TcptXsKuPFTlhE2+9ApQrP+ai8xPIPEnGshJD0qyG9DDT4A+T2V
	9uD3/Xh0eXefFPXAxsblB4Y0auBKRqYj+FYgHctLpZ7Vze+dsOugTncL2gq0o/L7FiuXmOtszXM
	YEpKjWcb1pUfmlUbnQQJGc+aQ8bt0IX7QrREqxVZoyxakKoTx2LjSu9u8mRyKhwXI4AchWgFV8J
	SFSA7aUEtJfLD+u6P8E+7wZwPc8JuEXvi6C+dmJZsCQDsY8PvWS6NHlPgRsLTVqsfGkzKu2MHeZ
	eUWq9GFhuK+/38LAVgjffpXhXU0ksz5NQjm0nxLRFpLeccPu4yxjgNhcVCNLiwcHq6BJ5UoRIOL
	1uaYdkAt+ewJD+ToIppKBB1lJLx4Pgl8AoFHthJMgfAWMgWX2gyrHqQ==
X-Received: by 2002:a05:600c:8b6e:b0:490:b7a2:8864 with SMTP id 5b1f17b1804b1-490c25237e4mr294515655e9.0.1780949875687;
        Mon, 08 Jun 2026 13:17:55 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6e:b0:490:b7a2:8864 with SMTP id 5b1f17b1804b1-490c25237e4mr294515045e9.0.1780949875120;
        Mon, 08 Jun 2026 13:17:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm327199975e9.2.2026.06.08.13.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:17:54 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:17:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 02/37] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Message-ID: <20260608160954-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <df06b66fe4ff8e925ee0714955abc2183a727b90.1780906288.git.mst@redhat.com>
 <aiaOZoa2vSCz_0wY@lucifer>
 <20260608094153-mutt-send-email-mst@kernel.org>
 <aibMs9DXuhH_5F2Z@lucifer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aibMs9DXuhH_5F2Z@lucifer>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eGSkq-ON4Q6PLe8uJAaVDEpr1qir8PxCp_zXievJm_M_1780949876
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 03:14:51PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 08, 2026 at 09:48:34AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 08, 2026 at 10:43:21AM +0100, Lorenzo Stoakes wrote:
> > > On Mon, Jun 08, 2026 at 04:34:23AM -0400, Michael S. Tsirkin wrote:
> > > > TestSetPageHWPoison() is called without zone->lock, so its atomic
> > > > update to page->flags can race with non-atomic flag operations
> > > > that run under zone->lock in the buddy allocator.
> > > >
> > > > In particular, __free_pages_prepare() does:
> > > >
> > > >     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> > > >
> > > > This non-atomic read-modify-write, while correctly excluding
> > > > __PG_HWPOISON from the mask, can still lose a concurrent
> > > > TestSetPageHWPoison if the read happens before the poison bit
> > > > is set and the write happens after.  Follow-up patches in this
> > > > series add similar non-atomic flag operations as well.
> > > >
> > > > Fix by acquiring zone->lock around TestSetPageHWPoison and
> > > > around ClearPageHWPoison in the retry path.  This
> > > > serializes with all buddy flag manipulation.  The cost is
> > > > negligible: one lock/unlock in an extremely rare path
> > > > (hardware memory errors).
> > > >
> > > > Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> > > > in this file operate on pages already removed from the buddy
> > > > allocator or on non-buddy pages (DAX, hugetlb), so they do not
> > > > need zone->lock protection.
> > > >
> > > > Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > > Can we have Fixes: and Cc: stable and also send this separately please?
> > >
> > > These patches seem like unrelated fixups that you've discovered along the way,
> > > and don't belong as part of the already rather large series, unless I'm missing
> > > something here.
> > >
> > > Thanks, Lorenzo
> >
> > I think you are mising that they are a dependency, not unrelated.
> 
> Then say so.
> 
> > For example, this issue gets worse with the patchset as there are more
> > places that manipulate flags without atomics. No?
> 
> It's your job to make that case, not mine.
> 
> >
> >
> > You are welcome to send this to stable, but I think stable rules
> > preclude theoretical bugfixes.
> 
> It's a dependency but also theoretical?

As in, the race is exteremely hard to trigger and I have no idea if it
triggers for anyone, but it's obvious from reading the code that
theoretically it exists? Yes.

> >
> > As for Fixes: the issue has been there for decades. I wouldn't know
> > what to attribute it for.
> 
> Again, your job.

Alright, if you insist:

Fixes: 6a46079cf57a ("HWPOISON: The high level memory error handler in the VM v7")

now everyone running 2.6 kernels will backport this fix, I presume.


> >
> >
> > I guess I could send these separately, too, why not. Not sure
> > what this accomplishes, but hey.  But is that an ack? You want
> > this fix merged even before the feature?
> 
> I already made the case as to why, as have other maintainers.
> 
> If you need to review what an ack looks like please consult
> https://docs.kernel.org/process/5.Posting.html
> 
> Thanks, Lorenzo

I am merely asking if you want this patch in the set including
all these nits I had to fix.

-- 
MST

