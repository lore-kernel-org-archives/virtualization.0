Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2733FF1C1
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859917; cv=none; b=BlDwqX5ui8bJvjNX9DHqDkjVWgOmD4XfURTnxczom2EktiybOJpvFYRl6z7XDU40bcUd1U2IDOhGP1Uctmc+zUKg2Jz76SjSWLXKnJwBmBXLEogKo4qEAODvvKew53oVBy7Lthzj9Mpdf3JW87op7oM3ND3VM53VeD5yYHfErJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859917; c=relaxed/simple;
	bh=9rXKEqxtzfmDQWqxkjEZdy4XXZNMoYLm7lH5AYwmn6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BDg8KJ2SeauaVgIekmjWNShtp9IBqc6tugk3cfEL0EV1AUfhm5kW5JwRRzx81bsZa2EM+WsfcjGpeAIi2qpbCsRJFet6kYsvCbHuF/mnNpj599szPXsNyHxBY4AicQp6acmXmzyR0DLiJ1GiZlRQ/Fzd+7hJf8ggM9W7j+ldoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeiQc64P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeiQc64P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778859915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bRJQWnIR/vMJOWlGH40eGCuLKFeHnLlb7//zEsKwBIQ=;
	b=PeiQc64Pkgu3rFm2Yp1eMcH8b04E8ifzdZhdhnYzw1WJIr8WDECHViJTNr4KcjnaQs0HlB
	JDN32C9Ai26slcUvqwYV9H80ggsUuv+zl+bFRsKMNH6BD+dng4Y0uDV444bNcrOSrojXkq
	aiTl+k1InpiTXqq6KBwVY4qL2L+CUr4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-59qwUlTVM-e2kgkDCB5pvg-1; Fri, 15 May 2026 11:45:13 -0400
X-MC-Unique: 59qwUlTVM-e2kgkDCB5pvg-1
X-Mimecast-MFC-AGG-ID: 59qwUlTVM-e2kgkDCB5pvg_1778859913
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48ff0eb77b5so5320915e9.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 08:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859912; x=1779464712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRJQWnIR/vMJOWlGH40eGCuLKFeHnLlb7//zEsKwBIQ=;
        b=OkRJ8hxIbLJSMrW4f1bPx04EzmNVpiTeN4pQ5f+UbBdNrVVhb9JDGb8Vc/w1KBAITi
         DTEoRggvP3sEF/LzfQqIPKTya9fKwJqW9PRktZYUoGKzjYkE5mlf1ubRw5H1IpidQDnP
         i54yFfN1jVxubX5uiQFToNVY+HIPYkGD0UPaaNYUUQfFAZfonWvME0U8LHABFdJ43WPX
         DwO7BjPvuQd86F3JVf76UViDMVDv7kOTseT+w7X9gUCYeJqrLQNPKqh9dN1YI1e8r2gJ
         qirPLkW/4Le5+N83zRmaPpPB+GTFRpjQ8IGeWhnNDd7rLotZqowGhHhqEgSi5XFbK3nx
         tqxg==
X-Forwarded-Encrypted: i=1; AFNElJ9V43xRtJVJTDYVfkvQQDBhr+J1CWdcsB8beU3SMQXkVw0srUk1NIIw97vnweQ9w+Dil6U6IiSJS9kODEDbKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyX6qRqhRqFKnydvS4iK0A2ye8bGSxJbGB6QUP+qzZUWHX6175y
	DG2L8801wmgdBCHeug6IgZUdQXVRNveoAAp4zMDwfJj61sMj+68HydF53OsldVLFgljDINytelt
	iidU5MWoqTAeOrR/x91o+ZynO2r0ugtjQq9Lvn2oK6qwgQoL2VZK8JJygFJI6s2V9gwI7
X-Gm-Gg: Acq92OG7Nm9V5JVG/aGIle4Unfe//3JkkzNzB5aP/zkfqAH0XAmqGD+34OvJzIaFNw8
	4QApK9NO+VGtndoOkeABpA/WxYcMBfOf4J/GUvVRwNSDUqqotUWJsyRLh0bFbTvCYHA745WzvmG
	6q64U7og2T6D9LdfD8bQquHYDROzBi4hJgPhRdav8JDB+4axkAQN9NBiyN5yFj+gvs0TwxjYSE2
	TRKr8UpX0kxQf0hQEPKYEL2RELamcG1b33Y3IQKhWy++OFegGiblEW75bQxd0SBSQmWvQ0qS7rR
	pMSko/pswiiTi4Yh/rfDavpuIgbU7HFKWRKXiMlhkl+9B5dwRLoSm1lz4dwoX3BlakDrTAvvYSE
	jxCt0TLNjkVFJVI8oRa+wHvuNSL++kw8ie5Gvg3tL
X-Received: by 2002:a05:600c:c0db:b0:489:1ff1:74d3 with SMTP id 5b1f17b1804b1-48fe63223e2mr46155985e9.20.1778859912404;
        Fri, 15 May 2026 08:45:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c0db:b0:489:1ff1:74d3 with SMTP id 5b1f17b1804b1-48fe63223e2mr46154975e9.20.1778859911682;
        Fri, 15 May 2026 08:45:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab527asm79317025e9.11.2026.05.15.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:45:10 -0700 (PDT)
Date: Fri, 15 May 2026 11:45:05 -0400
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
Subject: Re: [PATCH v7 09/31] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <20260515114250-mutt-send-email-mst@kernel.org>
References: <cover.1778616612.git.mst@redhat.com>
 <45d1ea85b574399459a64fdba28fcf04abfa3e7e.1778616612.git.mst@redhat.com>
 <agXS7dMmtJrPhu9W@gourry-fedora-PF4VCD3F>
 <20260514135214-mutt-send-email-mst@kernel.org>
 <agYa9s5B7OWG-kjR@gourry-fedora-PF4VCD3F>
 <20260514150750-mutt-send-email-mst@kernel.org>
 <agc-KFwvSDxEImVt@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agc-KFwvSDxEImVt@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4p-__i4IdNAkg3y4RJuUPEUACMMJSMXwdla5BAbHtMU_1778859913
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2026 at 11:39:20AM -0400, Gregory Price wrote:
> On Thu, May 14, 2026 at 03:08:13PM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2026 at 02:56:54PM -0400, Gregory Price wrote:
> > > On Thu, May 14, 2026 at 02:00:31PM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, May 14, 2026 at 09:49:33AM -0400, Gregory Price wrote:
> > > > 
> > > > There are calls with no __GFP_ZERO but they do not allocate userspace pages.
> > > > 
> > > >   - drm_pagemap.c: GFP_HIGHUSER -- no zero. But this is a DRM device
> > > >     page migration, the page content is preserved from the source.
> > > > 
> > > >   - test_hmm.c: GFP_HIGHUSER_MOVABLE -- no zero. Test driver, pages get
> > > >     content from device.
> > > > 
> > > >   - mm/ksm.c: GFP_HIGHUSER_MOVABLE -- no zero. KSM merges identical
> > > >     pages, content comes from the source page (copy).
> > > > 
> > > >   - mm/memory.c new_folio = GFP_HIGHUSER_MOVABLE
> > > >     - no zero. This is CoW, content is copied from old page.
> > > > 
> > > >   - mm/userfaultfd.c: GFP_HIGHUSER_MOVABLE - no zero. Content comes from userspace via userfaultfd.
> > > > 
> > > >   - arm64/fault.c: __GFP_ZEROTAGS not __GFP_ZERO. MTE tag zeroing, not page zeroing. Page is zeroed separately.
> > > > 
> > > 
> > > Right, so in all of these cases, it would be just as correct to pass
> > > USER_ADDR_NONE I imagine :]
> > 
> > Hmm. Are you sure? Isn't the address used for numa policy?
> > 
> 
> You said "They do not allocate userspace pages" - so wouldn't uaddr be
> USER_ADDR_NONE anyway?

That part was wrong.

> 
> Even if they do allocate userspace pages, they weren't passing
> __GFP_ZERO before, so either:
> 
>   1) They did not depend on the buddy to do zeroing before, and
>      user_addr is just a dead variable in those cases anyway.
> 
>      or
> 
>   2) There is a bug, and they should be zeroing the page.


IIUC, it's neither. Consider CoW: yes we are allocating a new page
for userspace, but no we do not need to zero: we are copying
data on write.



> I just see an interesting hardening opportunity.
> 
> Not suggesting you actually implement this, to be clear, maybe just
> documenting the idea on the thread as a potential follow up.
> 
> ~Gregory

