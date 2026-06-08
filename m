Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15F394781
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950668; cv=none; b=fH/bIUctjGKWGfoEQWXq/heLScN+nfPB8T/USP/5spxDz/F6jpgybWjLYJY5pDaVvizB7lJp6i0rO108oZnDjyChQuavOny5EBHLccXBg1XnkN/0YKvkiLXbULWYBlVUQEcWdsN55T+jw84R5pQkz9P7sQE68tR6d/cl3kJLbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950668; c=relaxed/simple;
	bh=7iYFH83TbF30leOdmdvBc9fsaYOMEHsXM4LqnGKwYVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fQPm++X7/RWM1gisYFqaIsK+Ol4M7PN9A8JqK7KEaVUbBuGb4Re+e3DxvWfVgiMq95/w1iRaMMLz8zAQU4YN1TX6zxXiEP+ynayPGEjZykk0ah0Sp2u8QszD6l+1l8v+o/ZhkUMRrZ3QM1uFpPDa/OPDgqrvv6anzAXAcCc5mGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/KolJLl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/KolJLl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780950665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wraIK7t3kueWFe0dHeV0rjdNvan94EJMyKFrwQ1Qu14=;
	b=B/KolJLliIf6U5B24aGQnatz5NNn7eBVkkImhT/Zen1Lm7ZS5ZL3vQDNeOHiPJUfl3gagF
	SLtPU526HBnLwFJ/SESf0BkY3r86orl7DAqUpGEoEWddiaJoVZb/crqr86Cfxw9yde2k6c
	wLmx7phDGfC9ATb8jDgiw2/06qPw7yc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-dFYNl_dNPj-hH9t7hojftw-1; Mon, 08 Jun 2026 16:30:54 -0400
X-MC-Unique: dFYNl_dNPj-hH9t7hojftw-1
X-Mimecast-MFC-AGG-ID: dFYNl_dNPj-hH9t7hojftw_1780950653
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490ae461f8dso35139455e9.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 13:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950653; x=1781555453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wraIK7t3kueWFe0dHeV0rjdNvan94EJMyKFrwQ1Qu14=;
        b=nr5/8H7tfID60zgDBCSrpjSGjtfTJyfhw/BUW7CF0knk/K83bOzok80MuGuRN1Q3zK
         XPfasecF2Hg7PbQnxYed4Wh8lXJnBAV2bd+l2ZF9xIBR3nGZjUFwKdKMbbCLY7i0zHB9
         B7fPLjZYTXlY2SI35pCOCrWggWhd9xr63abHnSW3Ajkwdxs4eJChE9JL3GZyHtOj8Fsz
         W+EgtNRDrxXeu76LuH76hQTjbBQy8eLkg8szTY9ihn0Ra47fbN4tGzMe5xlnbFI92PHa
         BWnhjI/NDp+ad4gLPqB/WoDVAALyJXPT00KBRGkkrHCRx38P7SQ+8ilfgyk2+RAFuxCy
         8pMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HkR5rvygC85zZxQUra+fFJfF0Ye8Lm7WMDoXOyM2zxfn39hIn1IfTHqnam9BCcPFS5R5HdUbDiCBkrMtHSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxotibWanpYgCMl2dJK4amoM6v3NQsLce6xSSL+p2DIulUXOUzR
	jQHHw/OSz555JaOEjMF/AHmZnpUG/rcqc/iqEMMAeFX3KRfL1QfeTHc9NEkmADlKs1FaVq0WPa+
	QeNxLKTCuQOG5EgMQoCvTYTT9d7pyIsGWPbuxlSlelgl05TvQlPApDkkWyy/lRBg5EJ5e
X-Gm-Gg: Acq92OGAopwAxfdoRcpLd7MIRq+FoHNYkaEwy2p+5CtRjad3Qv/+SLF2vvI57PGxUPk
	HXM8XqeeCXOhxbH3UwEzqA73Fi5Fiq1MDzloMMoMOk7X4icp9gZCspNcFvDXzigah7xPa5FtU4I
	TG066GNMRfRGcAJWmtR3w5Po8lHa5UoEiQPGqeCj/uWPg8kNVWe/oWWUy3qn4IebQ/WAzvKrctu
	qS7YGednlfqd/R4qjcqyKOczNogvwswIX/tiAHfkfUl75NqdbJV6GQ1Quyjymk1TgJP9OFiE45v
	4UmpxVHyRPu/+wGLaG35GPDVXTwL621XcJXxc04+e3/ifhN9TsolC++WSdI/Zl76OnfiH1bxWte
	esxkbzyGuNzrGmSD38q2gZZXK78r4pNQAcvbcs1EIgytOcSgF+JxmXw==
X-Received: by 2002:a05:600c:4e55:b0:490:601f:d775 with SMTP id 5b1f17b1804b1-490c259a232mr289729455e9.5.1780950652949;
        Mon, 08 Jun 2026 13:30:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4e55:b0:490:601f:d775 with SMTP id 5b1f17b1804b1-490c259a232mr289729065e9.5.1780950652571;
        Mon, 08 Jun 2026 13:30:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm55339589f8f.0.2026.06.08.13.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:30:52 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:30:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20260608161810-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
 <aiacZ6_7SG3nvVjM@lucifer>
 <aiblhJv_BvMn_8XY@gourry-fedora-PF4VCD3F>
 <20260608154354-mutt-send-email-mst@kernel.org>
 <aicjNRrHYOOBt0Hx@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aicjNRrHYOOBt0Hx@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: snQ9KdxDkdMQPy2T01xd0JSiU2Cwe7TymONT1rWgSHE_1780950653
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 04:16:53PM -0400, Gregory Price wrote:
> On Mon, Jun 08, 2026 at 03:45:58PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 08, 2026 at 11:53:40AM -0400, Gregory Price wrote:
> > > 
> > > If `user_addr` is now implying anything other than exactly: "This needs
> > > to be zeroed / caches flushed", then this is bad.
> > > 
> > > ~Gregory
> > 
> > Well if you do folio_zero_user in a non sleepable context then things
> > are not going to work. So combining e.g. GFP_ATOMIC and GFP_ZERO and
> > user_addr all together is not a good idea.
> >
> 
> Can you say whether (GFP_ATOMIC | GFP_ZERO) w/o user_addr has the same
> issue?

I don't think it is because it does not call folio_zero_user, right?

>  If not, then this subtle complexity is now a tripping hazard.

Yes.

> Is there some combination of arguments here that should just outright
> fail if a user attempts it?

__GFP_DIRECT_RECLAIM at least.

> >
> > You are saying it's bad? It's pretty fundamental to the idea of moving
> > zeroing into the allocator, I feel.
> > 
> 
> I'm saying having to infer that safety state from the cobbling of those
> things together is not a good pattern (at least as-is).

Understood. Don't have a better idea, yet.

> If the introduction of user_addr into the mix is the thing that causes
> us to have to infer safety, then there's an argument the page allocator
> shouldn't handle that operation (in this case: user_addr cache flush).

It's not just the flush, we are also trying to use that to optimize
zeroing.

> 
> Please consider that this is arguably the most fundamental interface in
> in all of mm/.  All we're doing is going through the process of figuring
> out what changes here are reasonable while trying to meet your goal.
> 
> ~Gregory

I don't mind discarding all of this and doing something else completely,
but I dislike it that multiple people are apparently now angry that I
don't address all the contradictory comments at the same time.
I thought just sending a patchset to show how the result looks like
is easier than arguing about architecture, and would be helpful.

I'm not pushing any of the mm rework, I was asked to do it,
myself I just want the ridiculously effective optimization in there.


-- 
MST

