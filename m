Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3AD3932DB
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780921; cv=none; b=HrOunuFemVpCkhd7NOtkdv87gw4c8SfiWmaMnGNW4dzSM1qpuE2HnU9zIBHeAi1RUHUyiERd31zizWSq5ldfsZSqtQnOY5r2tPQPTGV+R+5p8l+rvOPkZWwMu7sjHILg2xw2KjmRBKPzmFEesePg0Pz4ivhF7Nu0Zgz+MUNhYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780921; c=relaxed/simple;
	bh=HjW+RLRDUfCUAiTz4pYpZUQzoV0gW6WfCm46LXjIiao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG2YXigwW8qIUju0ZPafeXyfCtC68nsfn0cVpzoYfk6NX+TdBlRPWNxnUSbkYyZUvj5YLuvSfFudoNZJ2iP04TJNc/KRgGl9zojq61a0OMrD4evgu4nbnsRzr+y2sL90ZnaxqNE1CHuHh1Ku0BTMaCCOoA9Qxq56EUc2EtK7Ddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HaVodlwv; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HaVodlwv"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d6ab4476eso77152131cf.2
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778780919; x=1779385719; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cPQd8ZpfahwERRbvKiOm18yc/xSSB5/jBy80Q6IlfE=;
        b=HaVodlwvX2U0KOdUmnoOPx4hvZY3knLsfmrCF+cMs23IYjHF84Ixd2h4+VegzQCZAm
         X2Npve0GMWlkCoK1KVXB3XUdeYVoECXKzxTLMoNbkKI95tynkkLKd6Z8XKt95NU9wgS4
         GmwOEDagUkye4KZBLB4rpc1pno8gaF83pfGfW33RKwmtp60tP90U+il2SWd2/jimL7fL
         jSYzTzzI/h7nfBxt2kBVP+I0zJ3ISeB+cBDbFtGD+3uMDe3KHpIiNjLTC523qSm7TzWK
         X47F8SPdzflhu+Z56v0/st491ZDgx6/zOaoe1EqxwlfQB17e8iQuyNJgpUlnVxAHB1vx
         Xvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780919; x=1779385719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cPQd8ZpfahwERRbvKiOm18yc/xSSB5/jBy80Q6IlfE=;
        b=CbQJhIgzl4VPL0kcenTgEwLLaeIUQ/9f6R+qxlQPERPOxq5gTzPWxmeQQGLjRjnAPf
         DCXndQwtdI+gEpKKRkWO+9qz847UAwbS2jmbzCtFI6bJU7DTYWPVzr26mYyxg7Dg3NLc
         3FD8iPVpPu0Xr5Kqx0ghxUVwD0/Kn2IIehkDdvj1Enmf5YMxw6mV9L8RVIFsx0wzviSc
         SfR83GVPeuGD/0jqk3SIaSMw1w71C9rjeQ4SEkd2Vbr/uuO/HuNxB9tZsXDoCzZbWs0u
         auRmDeL2Yv78VhyibBz0HhEdSq/uNtTRQJQKgGgVyfX+oLwl8iK5hVEPj/VBTnZCvRI9
         lXzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kGkqMkbd955B9Zt2ldgyaA8PQ39pY3S8NPNo1xUA5Op0mifgKidIN3CHQYv4gSYbn1n/ia5V3IeBvimz3JQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywxsqm1pxQyUKMURRmB08kAIM4kpbNyVYOqYSUkgmU86WcakPW4
	FUoA5alVJADeCrGfpurfzdTf+kz28mmAcyFDDa7kvfHr2QRlEC8nipaSsv+iRyrQ7Qc=
X-Gm-Gg: Acq92OH9h58NViatZ1Iqq+X8RoQhQimUanZWih3/W7tV+h8fpyuaqFsHDxPMG3+f4jE
	i15DNGmFpjHasghMsp0FVReGDvi7PjIg5NcCFizOrz23tmTb4A96gVMehtJWfSHPKwCTHmqGYiR
	oK9COzSHK5zjZ2Vtn7MAvSQG9UJO+hwg1Ak3bwc+btQ381g+T44ioRJ5MQ4RuO+nIThmmxGQO2/
	lCsXBuuYR0I1akl9KWr4k6+wn0SL/BykmFUhbHUPfdV9LV97OFFjmIlHi9ABgRDWyVjxfwwCGlM
	jNTSHWqrKIM4eZb+3YKK+KpRXiD5ZsTO9WZGFfb/4L9tX9fUDjaBBsYIFQNzS/nmyuq4E5PYVqM
	jZhUH6Gf7HrN5V2ADA5GEScXcMgrEVblv9hXbEnb0oeqFMvL2zaYQBZ5eP4d8gv2ZZLr37FB8Uo
	uAnxPK3STQ909uS23c/PqtIr3YnQBnz6TRc4128lSJXrXqDquECepcirekn6ycuNnbvsg/j/m37
	ZRpu0ZTrDzr
X-Received: by 2002:ac8:5d89:0:b0:516:4f8e:3004 with SMTP id d75a77b69052e-51659fd9682mr4733571cf.11.1778780919192;
        Thu, 14 May 2026 10:48:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c9093e62c5sm29499476d6.21.2026.05.14.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:48:38 -0700 (PDT)
Date: Thu, 14 May 2026 13:48:36 -0400
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
Subject: Re: [PATCH v7 02/31] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <agYK9JKFInSwKSZm@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <feab82b370b3e66b58b9cfbc1efaf26fe6061d2f.1778616612.git.mst@redhat.com>
 <agW3JyLAwVsCZ2qR@gourry-fedora-PF4VCD3F>
 <20260514104735-mutt-send-email-mst@kernel.org>
 <agXrCinY2HmJmhT6@gourry-fedora-PF4VCD3F>
 <20260514113337-mutt-send-email-mst@kernel.org>
 <agXtOeuYNin9nYN8@gourry-fedora-PF4VCD3F>
 <20260514114637-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514114637-mutt-send-email-mst@kernel.org>

On Thu, May 14, 2026 at 11:47:19AM -0400, Michael S. Tsirkin wrote:
> On Thu, May 14, 2026 at 11:41:45AM -0400, Gregory Price wrote:
> > On Thu, May 14, 2026 at 11:34:14AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, May 14, 2026 at 11:32:26AM -0400, Gregory Price wrote:
> > > > > > 
> > > > > > Maybe mildly out of scope but worth asking:  Are there other flags that
> > > > > > should be retained/propogated on a split?  If so, rather than pass
> > > > > > was_reported, should we just take a temporary copy of the page flags and
> > > > > > pass them all in?
> > > > > > 
> > > > > > ~Gregory
> > > > > 
> > > > > 
> > > > > Not that I can see, no.
> > > > > 
> > > > 
> > > > You do this exact thing again later :]
> > > > 
> > > > https://lore.kernel.org/linux-mm/9a22e0f9bbe1278913754db6df76e291a006181a.1778616612.git.mst@redhat.com/
> > > > 
> > > > ~Gregory
> > > 
> > > I mean yes, reported and zeroed) Just zeroed does not exist at this
> > > stage in the series.
> > >
> > 
> > More of a forward looking question: if we already know we're adding
> > was_reported and was_zeroed, maybe we should just pass the page flags
> > through entirely and let expand() check them instead of passing it
> > through individually.
> > 
> > We end up doing something similar with post_alloc_hook later as well, so
> > I'm wondering if there's a general improvement that can be made here.
> > 
> > ~Gregory
> 
> sure, will do. do you want a bitwise thing for type safety? or just a
> long?
>

Can probably just do like:

flags = stable_page_flags(page);

plumbing...

expand(..., buddy_flags) {
	if (test_bit(PG_reported, buddy_flags))
		...
	if (test_bit(PG_zeroed, buddy_flags))
		...
}

or whatever makes sense.

~Gregory
