Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1771A31E85A
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934025; cv=none; b=lPWTmXqs1atgY/2D/IHI0dZ1BwByje3E8n7kfgKYdglxijyPnSQfD701Tpbfv3DiWHvbk8uJgG7Th5KFhsLmdwYfInIECYsR7p682otrYDkeKfEOw5f8O4gkV8RaKqc9P//sDsgrSrNnKzooWzpnbUxXIv6DFK+McsdI82WShP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934025; c=relaxed/simple;
	bh=eHM9J9p6LiPDM1cCsLghpx82/BPSwbww5tvhH9MP7GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnCSD7lr3MeevhNyieDnEC1AVDREcMGlaqFjlOmxmD69ed5OtfjH5kz5a9DQwfr8nxbfWjEqmf6NbCu6eqt88nDV/Oq8r12w1/sM80Nj/3nyq5j/gsjTyRN5GAzHfHkWzyewXWOdiaMYbh1T8BnWEatlHM/kzLXR5L9ORgNeHsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=p1pQSMuZ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="p1pQSMuZ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-91578122305so750936285a.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780934023; x=1781538823; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TE9J+WgrCGKOabTk6u8XUcIRp2nQnN2zdp+a9uxxJ3k=;
        b=p1pQSMuZ4I2vRoInVR/ztLxb3S0L1DZVmw8J6BhW6Fr7G5Ez4A/Rr1Uxi3yDMW0OPW
         6zMR0/jaQvXVdbRPbTcPIsfp3gsAJ5+/Mge+Uxi/1B/gyt+1NX0aEwTn3lnFVCxpp1Dz
         OM0Ey91uSvXmwyrRkCLei6JMs8eqvhhg0wSueEECeCJaaoTNrDjpgMd8BJzj0kanzzaD
         zqSX5dGccqtaNHGIT01lm1nZ1C0hhunN4t6HKmKLNh4GVo9Im7D8ImOXK1MnNl4ockl9
         tR+bsKIAnUEfsDkA/cuHYhNWqVVH+nzMknTj0qAJFDN2neGfAvemeEPlaq1YOTOWuLRa
         Gwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934023; x=1781538823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE9J+WgrCGKOabTk6u8XUcIRp2nQnN2zdp+a9uxxJ3k=;
        b=WKeIBe61Lm0hM2RpN7IeLvjJGu7dIoYqwg83+GhZP0bZ7cAPLFZLSetldWwIJwsKEV
         RGaQOMPynwa6Lin1bO/Syy50KShBKc7xankl6p9Bma60EELS/LnHYItcWjLGxcT5CKt+
         azLgK1kImpsscV72BHXW3AyYXDWPN/HN4f2D/Hhj5s/Jpg08k4bRUpO84pxfpIC1L4Ug
         o3iXbU1ytpKJLA23Sv5OOOYWYXzvhVOTpiqWFS8CqY2tbMS0XNWuMRw05ihbpTSIii54
         AnH6xX8JU8KKDC1G+uN9mOFOhfrH3C6ZFM+L3OxgWMQ+LfhDAIBcx11FJ62TqiVMwH08
         lG4g==
X-Forwarded-Encrypted: i=1; AFNElJ8IJkvkM0dAvXqr3uFwi0jlGgIx6h5kzqV+CfZpWWxrvAl4Vwxm4o2zeQ+CG1vyJSmbBGxnoocJ/krVGXJfEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKSgE3nyLh/D0n9HV2/eBOMc5+sw3pEXL/DECvvzo9mhknw9D8
	O5G5iyMVGpTFxhZzmavKDKvuSPoVa0o7w+Ju747J/SJyPHwIfkMtLlZYdRYd7G4Pr70=
X-Gm-Gg: Acq92OG5VtFqA7nOVmGWZnSLZLZys0clId2qoA8XDMyc2ELo1aFDczgi/3bqHFXHUji
	AH/QOUwmI6ujPlc+KFRjRJqlVtq73Fgaf8zEvNM7idGCfRuQj6bYETqsxKrwXKs2d/j+nZu17N4
	3YAs+dRS5t3DSaM9iugglAc8QrglzP7uOHc/GuzXKrTe+tV6D/EXpVZHwsyjU4iktyTRuA68tq5
	NS5YjNN/0RTYuqWm8OAhL12u2nHMMMZx1ujV23zdTufvkSYc7uDjcy6U3e/nZc1W2Duy7vRQ6dT
	A8bo05cIdXAkwOTtnt4YfFGilD9SeTvP8uv/KnEyfptmL/jAzWuoQhRuw6sksbZ7vm8iL3xCSM8
	ly2m5X/38dRg4wbWSCFuYurDzGLkuyB/M+2MX2bDqsWykxmiNnF8erZOCiowcIpTujCMgheccYV
	IJ7zDR+f6GSIwX9EuvgAQwT5GXXUeE/7UpgkKPUuml1Hom2C0VLeGUGIkz5MjDnGJwvfkSSGkLx
	dZevlPVgvn61j9dJA==
X-Received: by 2002:a05:620a:a407:10b0:915:745a:70fe with SMTP id af79cd13be357-915a9d763c3mr1868020985a.28.1780934023069;
        Mon, 08 Jun 2026 08:53:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37bcd6sm1798163585a.25.2026.06.08.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:53:42 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:53:40 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v10 12/37] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <aiblhJv_BvMn_8XY@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
 <aiacZ6_7SG3nvVjM@lucifer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiacZ6_7SG3nvVjM@lucifer>

On Mon, Jun 08, 2026 at 12:23:07PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 08, 2026 at 04:36:38AM -0400, Michael S. Tsirkin wrote:
> 
> > +			 * user_addr != USER_ADDR_NONE implies sleepable
> > +			 * context (user page fault).
> 
> Can you safely assume that? Also inferring which context we are in from this
> parameter seems risky.
> 
> It seems to me that you're now making it such that kernel developers:
> 
> - Have to know when and when not to specify a user address, and under what
>   circumstances we might consider that to be mapped.
> 
> - Need to know to do this correctly for aliasing architectures or have silent
>   correctness issues.
> 
> - Need to take context into account when specifying this.
> 
> We definitely need to find a simpler way to do this!
>

This feedback was poked at in earlier versions.  There's a tension
between keeping the old interface as-is, having explicit interfaces
for something like this, and the state of a page inside the
allocator vs outside.

Double-plus complicated by the fact that we're trying to reason about
two allocators at once:  host and guest.

It seems it has gotten a bit more complicated since then (I missed this
"sleepable context" bit, not sure if it was there on prior versions).

If `user_addr` is now implying anything other than exactly: "This needs
to be zeroed / caches flushed", then this is bad.

~Gregory
