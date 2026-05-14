Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF56386C3C
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781077; cv=none; b=W0hf6KhI3fFs0rI3yDbUBz4gWfQ5BR6wUz52//NfZQz+kYqyi20OTRd+U6mkqKAodjyoVQgyZVF+hzC0UyqgmH3z4Jf9NPWjZWcngQVkfDVUUtOLAP1sPjAiAmDQccipeGofvkwahl1OslW9tg44f+uAOUS1x6rVw/Yu6yLy1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781077; c=relaxed/simple;
	bh=l+aJoAElI1thH38hKvFEkIMTdNzPvUFJEYjBMS4q0vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YmwyI9uzRhU17kkl5Bx0DO9occpNh8NTOX1IPz4/pKNIIyxC5CPGCQ6SbJin3OFzHwI7nqR7lumzPhXrlRGh1IpsqFVYcYkCrRQ5Q2GtV/fO0M3doBAlEvRhP1BMYYLDbO+pKv7ERnz16JDEFpHe/G0znS7cULoKkSY5ot4vBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWMUxW0R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWMUxW0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778781075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tLvXfaK1++cjWp5ZEXW7FRO6EgPicPNmdS5WYRImnOM=;
	b=GWMUxW0R6zYXABA0r/vGj6iIABMsTC622KlXZ2sOInTibHQa3URHPRKNXyPNhboQxCa0i1
	PioMVOp7DV0MBfewC4T/HY3346+29HNF9CZIZVQiotOkdSsWsZtI3qz6OELrVyb/mbjpEL
	kjkfvaL+TkIRG4G0z1olsWo9foaP0wg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-jVgtNBPzOAaB_Xw3r1WMqg-1; Thu, 14 May 2026 13:51:14 -0400
X-MC-Unique: jVgtNBPzOAaB_Xw3r1WMqg-1
X-Mimecast-MFC-AGG-ID: jVgtNBPzOAaB_Xw3r1WMqg_1778781073
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43fe791a398so7495037f8f.0
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 10:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778781073; x=1779385873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLvXfaK1++cjWp5ZEXW7FRO6EgPicPNmdS5WYRImnOM=;
        b=SEQ3hBPMCd+4yCTiZN51omczLwoPgDEWpnwuOT9V9Fm29yscBOvmMgvwrdzEmvk/Qu
         zpSCUhUvR4YodW7MyvYdGHetvPs7CAGeq9EkJi1Fzx7s7AVwSK2KMjn7wuDdfDC9RFJn
         GJEW3GnUWnw+7pYzSQIqLj1ZD00uoaXEusXvxMDxBH/z4xEgBuNb67j/3UazraXJggME
         LtD47gwOB/QuGBHGUnhz4eZfMZw0c6jeIe9by1Xz9r+WhNabXBBku+MUr1mA6LZayOu6
         uk6kQsVTmMTcCZwzqi20YxzDWdfFPQbqcpn9C3XJAQ6qrC/0e/zQPHGadXM5f1nY/a+G
         GYiA==
X-Forwarded-Encrypted: i=1; AFNElJ/ssuWEP7HGj4TRa79auyugOdUhfsVXibV1Ux6CMvN/4uoL3sjIYrtr3jUgr+ljYWD4GvHNE4i1SAywKchSxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeL3XYznGnnBPDungCHYAvHYFDVYoXef5CrHzu25eyE0n94hip
	OagBg38ciKxF+xMRUMOFVog4pQcd0KDv0QTPYHyt+Otn6COw7zZ+1IC/sZhMfMDXVhdaL/FJddO
	p+gBDHHQEWvoNn+oFqs5SPmly7biP/gKxOStHP0rH7Lk0Dmj6uu6ZfJQbxEh1o42R/XBN
X-Gm-Gg: Acq92OEubmaFepDnTdNu9oJv0GXICshfjZAF+UJHHGei8NNoVMo6vASu6WnJ7X9ieZU
	16JzhorGLx9HYpInrK+qzWLR5S4+uZmGObjdPTw7ZmboXmHXUFkqJLfbw09fi6lDnJmChhZlLtG
	OHw2X34jg8ZVuAicNSP8k8x7cTv9wO+Sdm7+2veNaSkqwmTv9YpJi1zUymDUxXQh/N9EwOgD71v
	/e0aIN1rTEjFvDzWYwGT3YDM23ochgkRuQNTxmo1vSD0jmW1uaBJoSV37xqJ0qATJdmamNhC5Xz
	Hz5uJrDVXOWAClNP3w/9NpTJzThp+ntHjVXQGwRR9fnWuR1Ny3Z6McD56Xhw1iAfkydMxI5zjyE
	hog65+YKp8ZuhDtescfn2YpBG/1aY89tkuOsnUAUk
X-Received: by 2002:a05:6000:24c5:b0:45b:d2ff:4d4f with SMTP id ffacd0b85a97d-45e5c612fa3mr65130f8f.40.1778781072803;
        Thu, 14 May 2026 10:51:12 -0700 (PDT)
X-Received: by 2002:a05:6000:24c5:b0:45b:d2ff:4d4f with SMTP id ffacd0b85a97d-45e5c612fa3mr65053f8f.40.1778781072253;
        Thu, 14 May 2026 10:51:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm8568047f8f.8.2026.05.14.10.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:51:11 -0700 (PDT)
Date: Thu, 14 May 2026 13:51:06 -0400
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
Message-ID: <20260514135050-mutt-send-email-mst@kernel.org>
References: <cover.1778616612.git.mst@redhat.com>
 <feab82b370b3e66b58b9cfbc1efaf26fe6061d2f.1778616612.git.mst@redhat.com>
 <agW3JyLAwVsCZ2qR@gourry-fedora-PF4VCD3F>
 <20260514104735-mutt-send-email-mst@kernel.org>
 <agXrCinY2HmJmhT6@gourry-fedora-PF4VCD3F>
 <20260514113337-mutt-send-email-mst@kernel.org>
 <agXtOeuYNin9nYN8@gourry-fedora-PF4VCD3F>
 <20260514114637-mutt-send-email-mst@kernel.org>
 <agYK9JKFInSwKSZm@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agYK9JKFInSwKSZm@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MpwfZ9pXE_J2rDKaXPczTG83uIXIhKq9cZZ9IpeI1aA_1778781073
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2026 at 01:48:36PM -0400, Gregory Price wrote:
> On Thu, May 14, 2026 at 11:47:19AM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2026 at 11:41:45AM -0400, Gregory Price wrote:
> > > On Thu, May 14, 2026 at 11:34:14AM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, May 14, 2026 at 11:32:26AM -0400, Gregory Price wrote:
> > > > > > > 
> > > > > > > Maybe mildly out of scope but worth asking:  Are there other flags that
> > > > > > > should be retained/propogated on a split?  If so, rather than pass
> > > > > > > was_reported, should we just take a temporary copy of the page flags and
> > > > > > > pass them all in?
> > > > > > > 
> > > > > > > ~Gregory
> > > > > > 
> > > > > > 
> > > > > > Not that I can see, no.
> > > > > > 
> > > > > 
> > > > > You do this exact thing again later :]
> > > > > 
> > > > > https://lore.kernel.org/linux-mm/9a22e0f9bbe1278913754db6df76e291a006181a.1778616612.git.mst@redhat.com/
> > > > > 
> > > > > ~Gregory
> > > > 
> > > > I mean yes, reported and zeroed) Just zeroed does not exist at this
> > > > stage in the series.
> > > >
> > > 
> > > More of a forward looking question: if we already know we're adding
> > > was_reported and was_zeroed, maybe we should just pass the page flags
> > > through entirely and let expand() check them instead of passing it
> > > through individually.
> > > 
> > > We end up doing something similar with post_alloc_hook later as well, so
> > > I'm wondering if there's a general improvement that can be made here.
> > > 
> > > ~Gregory
> > 
> > sure, will do. do you want a bitwise thing for type safety? or just a
> > long?
> >
> 
> Can probably just do like:
> 
> flags = stable_page_flags(page);
> 
> plumbing...
> 
> expand(..., buddy_flags) {
> 	if (test_bit(PG_reported, buddy_flags))
> 		...
> 	if (test_bit(PG_zeroed, buddy_flags))
> 		...
> }
> 
> or whatever makes sense.
> 
> ~Gregory

right, that's clear.

