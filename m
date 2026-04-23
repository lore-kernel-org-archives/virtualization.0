Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C856526E173
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951763; cv=none; b=iore/S5iDC0EjMZj1VmwGs/OUo2et18UJcjLyDWdR6L8JVTpKcnx4TGUqnSBZYSwKpW9zUlY6xVOIXSnIzKQRIDK6ujOJ2Aa/rFImjXbsq4HoyZFcCH7cfCSaA3kTzeadUe5SJkuv0HwI1R8eqLDgyBkA64Sejvvpy+OPAzwSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951763; c=relaxed/simple;
	bh=6KH/ThtXPOGPGdSUrvGlCAHA82rT3JIzigfXoEPge1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgFGAyeLsZsG+9jp5lZzmh1W6qepHtcaB11+QGuBjXoVhTGvGr+NcKygdU6yISbtW99jTVCPsa42AUy5/D03yqj0XIATJ0DQVZzPoP9AgKYS1+dTiB8IDmGHRhKQQwuRt4aFCV+IBoYKkt+3lK+vOkP+sWeK0c6MxrvZHg0ow8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OpXmTU0S; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OpXmTU0S"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8dbbc6c16b2so832204285a.0
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776951761; x=1777556561; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0SbK7jHzK0BibVPY47BIZzJ6hwGVNdmSnj/6qVo16wg=;
        b=OpXmTU0SaoHL2azEwIFf6EsK9DbCOV6eG/P/say/Tkn9CLzETyEGPZeuOd0oWdhVe/
         fiC7grsIfg9ORrQZsDj/7qtOP2rowLp1MIdg5ks5gnfWnEZrM5fWdR/AGtiexTaQoRdC
         3h8o/LWtXonARUzy+Im9emvKkNhlEqMoXhb//3JXsOQ2hzbKeTu+RhsZwVvyyiVpDxbR
         otEr5MbZYf8EgZRFbLZzeUvvYZiQdIQ9UJE9GfpqzQdHl8aIbXAjMxlyn96mdvoXYYP2
         7DH7/FlsXu5AkFV42jHQvY7TA8UDLpCc5EgOp7Y2lAdNGjP6JT7FZwKNVnaJ0XmDmmWU
         nc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951761; x=1777556561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SbK7jHzK0BibVPY47BIZzJ6hwGVNdmSnj/6qVo16wg=;
        b=ThHYGevLpZ8iE2EjrbJ9EBsk4FYr9q+LPnVdUWqZGk8Cf71U5GHY9l9hWYDqPDm5Mj
         DiICvQQKdNHWP72CYZtpZanVj501Bxf2MCuJKReOqjA8/ZZ+o+2dOp4EaPZJ0Ig12Ey1
         gS1ju61/Tf/hAQeHdMq91h7ESKlEqBmufldsBKGSQGXW56ly/0FkrBq6S1FOqJ3VTonB
         CNAj6xMqt3L5PcmBVQzH7qGK5szBT9xCM5CLJFUKehYZiVrFba8KTeWU9otVtwTGnHoR
         pfrQeO2ep8+UHbk0X6K3kLB0H7pCn1knbDG9pvdL+vgCUGDL/5Y02jJR/G19NsbkYnif
         EP8g==
X-Forwarded-Encrypted: i=1; AFNElJ+5uk1WNw2+N0U3eooYM8qnVLMEIxrfuds25qkCzLOfG5j4yZS/DdzHDDOUYZZmPlYXFBKlALBRkhORzgIc3A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp9ziKK6aLmVv1kHLDj3tOkvG+OWB1VeZC4T5opjGvbvyixP0w
	NEuQTziw8WFb/aBnZehweTFWHA0SWH08rpsLpZ8YcXBtQsZtpfru7hm63a3G+tibKyg=
X-Gm-Gg: AeBDieu7GUssU0PjK7Guk5NZJtLmCIzFvLbvxHKlt9CmTl+Na7nl54BX3g7I2yByrPU
	4SCBSnYtHlNNN9b7ifOeP3gMub11fwz6M5/iu9ngg+JWMFMr/HRu0KjyzvKUGAbHVTac+QjDamQ
	dEbJ8Xn7Na5SBgPjCH+VHv5RunjZUTW0rgBWEAlw0ocyA1tAL5n3bNz2Z83TgJGPkKqLaM+IC36
	hZAsPbNPuT0o4gqKKJ2Gap4dc+Zcg2bbglQSDD6zH2vL96QAu/pCcV9MqRNaqj5YJCC/8oAqsB3
	W+1peNjo2GM9GblUZYLx24IIUAIK/3RXVEjMtDK0v1bJv7sf5FE4urgvCLmRf2BlZ5GdS+xOtIC
	UxnKe7tZ4Svum72AX8GtbmnymEzwG7ZMxn91Xumnd+xOeAmiANMteuBagyen1s628tJf0Lqxwgx
	/5p/SHhnGuREpfsybsv+euDcinrIGFv7fPOnoWcrd506Pu3PxSp7FILUxh0UpkgmdkGh2cOE/Eu
	YyeagBk+tr4bCCZElB3
X-Received: by 2002:a05:620a:414b:b0:8d9:26ca:7e3 with SMTP id af79cd13be357-8e78d0a865emr3247854085a.41.1776951760527;
        Thu, 23 Apr 2026 06:42:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-246-228-50.washdc.fios.verizon.net. [71.246.228.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac81a9dsm157783036d6.21.2026.04.23.06.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:42:40 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:42:37 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/19] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aeohzbmhQAoOODPm@gourry-fedora-PF4VCD3F>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
 <20260423074433-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423074433-mutt-send-email-mst@kernel.org>

On Thu, Apr 23, 2026 at 07:57:01AM -0400, Michael S. Tsirkin wrote:
> On Thu, Apr 23, 2026 at 11:46:56AM +0200, David Hildenbrand (Arm) wrote:
> > On 4/23/26 06:31, Gregory Price wrote:
> 
> Changes we have to add: 8 changes
> Rename 4 existing APIs adding _user: __alloc_pages,
> __folio_alloc, folio_alloc_mpol, __alloc_frozen_pages + add
> 4 wrapper macros/inlines in gfp.h that forward to the _user variants with
> USER_ADDR_NONE. Roughly 6-8 lines of boilerplate per API.
>

This is essentially what i was proposing.

The result would be more external surface to the buddy (at least 2 maybe
more functions, plus all the _noprof stuff and a bunch of other things).

And then all the callers have to be updated anywhere, and not make it
any harder to mess up.  You either have

    old_interface(..., user_addr);
    /* Churn everything using the old interface */

or

    __internal(..., user_addr) { }

    old_interface(...) {
       __internal(..., NO_USER_ADDR);
    }

    new_interface(..., user_addr) {
       __internal(..., user_addr);
    }

    /* 
     * Update some callsites to use new_interface()
     * mostly a bunch of _mpol() functions but some others
     */

but someone could still just as easily do

    old_interface();
    /* don't fall folio_zero_user() - Bug! */

So it's not like this makes things any harder to mess up.

There is no elegant fix here if we want to do this all inside the buddy.

If the performance increase weren't so blatantly dramatic we could also
consider just not doing this at all.

There's maybe an alternative here in considering a change to the way the
buddy manages zeroed pages - but there's no guarantees we find a pattern
there either.

~Gregory
