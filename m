Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21591332601
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777429; cv=none; b=UXITaoNr9sJfzFbErgrR5yz75AuqFN5E4kXQ1TYXawIB6R+MIvPBcOLxi1EKzuiIygL+RwfVRgpHxG5/C1aHwDZ/smtATOlV7Ykcl4P4KfopVNO+CMUUwIQtg+kru1X6qqQJCpJbKuhxpEokkvWajgDXWGZG/edwjNLS3EtjLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777429; c=relaxed/simple;
	bh=tsLqZiwjUJtIdKfBlq0p4NcSlwdMs+tVFNkf98uSOkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bGDWW9qTxH6hPN9BZML67VjjMreCZporL9Yve4K2MuGDS3b/D0oMXiCgokR/mRp/0rq3iuhaJh/tsc1gNj4Fv+rkqhegkWm5RzlOlSjPcdt5sgRDbEY3JnufCu7arFKCUxQAaDCBqzuUAppYq9zlbfBbPsZYe21q60YfXxwVgIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7T5ho1k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7T5ho1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776777427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCbA5QUc8U2QOBCnKS0mrwkrQW2ZBzuy6UlJpM8eO7s=;
	b=Q7T5ho1kR1a9dLcFhR/W1QCm4XAEnFfLMAGnTuM12LV155qGAFR4YEyOqCRTu/afeDh6bN
	wa1qIbVdRxV/vSQZ7zjQixb7cWsVUxWZ9J2yBoRl5jDjOpy7Z23BqnHs0s0NU0LL+brwPO
	5etovK4R3JhuY0byvFMy2HEl3cgs9fE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-6578OmkKOaSAyBQM75ICBA-1; Tue, 21 Apr 2026 09:17:06 -0400
X-MC-Unique: 6578OmkKOaSAyBQM75ICBA-1
X-Mimecast-MFC-AGG-ID: 6578OmkKOaSAyBQM75ICBA_1776777424
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38e936cabf2so21941501fa.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 06:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776777424; x=1777382224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCbA5QUc8U2QOBCnKS0mrwkrQW2ZBzuy6UlJpM8eO7s=;
        b=nPrGFzUWhdVA1xGHoSfWx4sLOeA25E7tTcnKNHZI901Y1RK68tUoA2uVeogDHL7b+/
         +BZdnuhB7QoMUu9lJc4nr4TbuKVqYZPZXd3iB0v46gf9mnT44Gn9Bw7xdQS55u9CCMtS
         6KOZZYNL1DfZx22UFzlQz7sVos3N77LnEUS4fQcdEwEfN1SzTQjqdaRC5wJnAjUrFU6w
         ClhqgVZd3ccVBnfOoKDz3wZUnFCYefUNT9NByUrDgUcTcWShbdrSGxfiSyw3/rGyeIdv
         PSCQ251OU6Gk0pRkP/yqtPB3p0hepuQ8mAjfkvmeeb5DFalfiJIe0bpErORfzjksafRF
         5yqA==
X-Forwarded-Encrypted: i=1; AFNElJ8XrIyamgO0OQp3eMM7z4QiiFuZEpZ61oz7/OwVl0lFXV58WGzGt3xNJOjOmwnMvl5pgU4kAbT3NYruVRcEVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdKM01I6tAG60/3xpaR4CUyKqDGOg2ayghtbzsGhmYewgNoK8y
	ny/6XyvwskaUy9LqJM7+L0Q3+g9dy9fjDtHivglLqnZg8qftWwtuQxShZsIE8JhFJHdoqcFGups
	ziZnrkEGagNYiA4LY3cmc7sLZmK66/wP1SfJLaHJKf7Tfa3BObCvn3lgzd3N+tl78Mjtz
X-Gm-Gg: AeBDietdV/SOidRx1yzZy4uSD/5bnXJymisG5RWq5fsgTco0ueGuoE9GEgY2UbUHlX0
	Vv+N9UcP8iLFgvSNFCcsy9Wd47REnlWbPfYLsJEbU7AyobxCrKmjltZDn9do5DRuL7fY3YC35sm
	lPbElI7Ok3zAzPmI5BVFlHwgiB5XsbHPcrqP2/K/3cr4xw04kVlKmhhtldcz32Lv41XppVqWNCU
	prBUCG/SAroZbi1Kxy/dYiYLGsLW0w644VtGFz30lqmtL9rL2gWXAM4qRBkxrSh4H09cubtw7JC
	86YznbuPZrWDbH3Jg5TKRvbMAVZFIr/FNi6+FoJq8hb5noPdSdyBLdMAPRa+IBpImqX9Mm1cyIZ
	s2ECWJTv1fT4dPpvBIA70bDQPsicr434+7xG+UEzzZwR64aRu0UhCvA==
X-Received: by 2002:a05:651c:1ca:b0:38e:a842:52f1 with SMTP id 38308e7fff4ca-38ec7834d76mr57004921fa.11.1776777424230;
        Tue, 21 Apr 2026 06:17:04 -0700 (PDT)
X-Received: by 2002:a05:651c:1ca:b0:38e:a842:52f1 with SMTP id 38308e7fff4ca-38ec7834d76mr57004791fa.11.1776777423636;
        Tue, 21 Apr 2026 06:17:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb716751sm32721331fa.29.2026.04.21.06.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:17:02 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:16:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH RFC v2 17/18] mm: add free_frozen_pages_hint and
 put_page_hint APIs
Message-ID: <20260421091546-mutt-send-email-mst@kernel.org>
References: <cover.1776689093.git.mst@redhat.com>
 <c7094de807c0e963526686e1d245bc76193b1a92.1776689093.git.mst@redhat.com>
 <5f76af6e-9818-42ea-a305-c0fc1d920dca@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5f76af6e-9818-42ea-a305-c0fc1d920dca@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rmvqt7LvStyAbyL_9z0U0s-iFG354EaNStS8lrGpmBY_1776777424
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2026 at 12:56:00PM +0200, David Hildenbrand (Arm) wrote:
> On 4/20/26 14:51, Michael S. Tsirkin wrote:
> > Add free_frozen_pages_hint(page, order, hints) to free a page
> > while marking it as pre-zeroed when PGHINT_ZEROED is set.
> > The PG_zeroed flag is set after __free_pages_prepare so it
> > survives on the free list.
> > 
> > Add __folio_put_hint(), folio_put_hint(), and put_page_hint()
> > wrappers for the put_page path.
> 
> Can we defer that change?

We can - it's a dependency of the balloon deflate, which you asked
me to implement. I'm more interested in reporting, myself.


> Putting a page with a hint, when there might still be other users of the
> page is a weird interface.

The hint is just ignored in this case.

> In the long term, all balloon pages (PG_offline pages) will be frozen
> pages, and definitely not folios.
> 
> Frozen pages don't have a refcount.
> 
> It would then be sufficient to have the single owner of the page call
> something like free_frozen_zeroed_page().
> 
> Now, to convert balloon pages to be frozen requires some more work,
> primarily to balloon migration handling, unfortunately. I have it on my
> todo list, but it will take a while.
> 
> -- 
> Cheers,
> 
> David

