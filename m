Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC75352C3C
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035700; cv=none; b=RDowhDeRRW4QBM2B84nTH+l/U23wtqDV8hBDPHybSFb5b+ZGAYZKZlw54C4xbfzYD+7/hr14ioyPHUcf+5d3HyHl0ZXO9xzqIB/cRAVqzW/I0DveovxexF37SyE38YoiJ1lZVho50qO1OHCDkuAaOTTfwdqhN4CfkptSb3bRrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035700; c=relaxed/simple;
	bh=aRhTNbcdgNaPA36R/O4/F4M3VXSutv6ZmcYauBSyGgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pK3L9I4ntxdQXBjPKD0Ta/aN881CXcgwFJsIdOaqmlsaNYPaXi+BEX+9/43/Ov9L+Uu312g5Gw1UuptZvxrO1zaCYXeFtSt5CsbIRcOaFULGwpkBTz8a+jdfFkBR1nEsYZEX3CMmQsWn8WCIELJP3poOCeC6Aq8hA3Rn7s5/RoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6L2DFGO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6L2DFGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781035698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zl9Z0aJ29Hn9v0DTruTbP6W/2+UyB2iIzr0q5S84UYA=;
	b=Y6L2DFGOB5ovTYac4Ib5Mo5Ppk5YBvCkO0WgQb8r+OoqYmyG6Il3qo3HFb1cFSPjhPXYMG
	R4v9z8QZmDpPkiIdzvv+92vWxhODPrXkci6bjHrMbUHYltIQhCtuvZ4FSPUSzpr5bWggbq
	OZIfrXtB5oRI4QuLTefdE1GmxUHl0XI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-2rm2nYaqMVOXq34lBJo2qQ-1; Tue, 09 Jun 2026 16:08:17 -0400
X-MC-Unique: 2rm2nYaqMVOXq34lBJo2qQ-1
X-Mimecast-MFC-AGG-ID: 2rm2nYaqMVOXq34lBJo2qQ_1781035696
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b7959b9fso59923875e9.2
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 13:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781035696; x=1781640496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zl9Z0aJ29Hn9v0DTruTbP6W/2+UyB2iIzr0q5S84UYA=;
        b=M4h+rvFHs5I7eKGuce/9Zk5JQFls1scxKa35Wd7WfQNAr3A5u/nxybGyH4ApFteoFP
         +751PCZpanFWt2eq6BB3i0u6ivVA+IO+ODA2M5nQnj1cSaVSarqYvnL+JZlJUdNl7ZKv
         aX0IMp+xWBcAjsfJ1nz1iWno2EniNEvUhhHzDCFaM8gI3GKxK/JHbMczurUJdXkaTJoj
         xC9myV/SmYAUzZLIqfJmvdn0f8Oi/oVW5A5gM1hbegOZqtvzbkHKTfVa9ndrMoKkLKHe
         NgAOEzpraU7Zmaty0T0bF7h+Xo4COXRNPLdw6EWWBszvfo8n0PNuK6MQKImKaYnQrxaj
         3ZaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EcZfFmAzBtMrsL02kOy8md3MD5aH7GctiKje7GMDUBwvY6ePx5rYKWiVezz8qUbD5uC6MjKb1Cou6mL4dkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC/EVvL4m9X4nm3/HO00sc2z6E1Qi/nIB05cvHlGXgprOvmFA5
	3ZmBwsbsEfN6SMdeolPSkB1VKNT2cf6tdfR9iGMOolsx67q8T5BvOHgqC0IjCyuZy5cmVBcPl5W
	adoxtRoS8yq5XXs2U1wy3TYhPbhCMj/Ktw1VM9JdtbBLByWYwF9rx2mHY9TvzsbZT8Mkp
X-Gm-Gg: Acq92OHYgV+nY6nvm6Qn6M78q1caREpF6JmzSjLsoYpE3AnHnku9V2r8ig0AClZomAW
	vuE1GF3B73aLuSlu90rUSjVLBNdc5Ghl48R6noSrwq3dvq+Vxb9rYaJ5ZTzgoIxOmV3iFpsttsk
	WPXmRw86qpNGppquBXsxd4ph8YQqCK5WDLq9uvYuaeaUEMjrG4slOHXESa9urZrfkaOj6HMJToQ
	eUsThUchMW9GCSSYVKW3STPe/L0pEXu5ibKYKp73jZCMQnpuRUUYwhWjTTiF2j5pqaokRi3dja9
	Sq0dyakDFttqqiuG7GmKgxpL5tfQnZu4VjUdmom7xEX+UXD8Q6gwve1bTgPltcJ3ES78ySvHd9j
	uyLG3ASUleTV/l/P15/6l3LCsAT++8kVp4YRR+0QLOqrZiugN7PdKLg==
X-Received: by 2002:a05:600c:8216:b0:490:c2a3:23cf with SMTP id 5b1f17b1804b1-490c2a323f0mr333475315e9.34.1781035695695;
        Tue, 09 Jun 2026 13:08:15 -0700 (PDT)
X-Received: by 2002:a05:600c:8216:b0:490:c2a3:23cf with SMTP id 5b1f17b1804b1-490c2a323f0mr333474535e9.34.1781035695117;
        Tue, 09 Jun 2026 13:08:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm68785532f8f.17.2026.06.09.13.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:08:14 -0700 (PDT)
Date: Tue, 9 Jun 2026 16:08:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH splitout] mm: page_reporting: allow driver to set batch
 capacity
Message-ID: <20260609160506-mutt-send-email-mst@kernel.org>
References: <b25ea6c63503f24c8b5b64910a44dc03b5aa610d.1781020302.git.mst@redhat.com>
 <aihRBTaTUmgYmZfX@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aihRBTaTUmgYmZfX@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hcFQoTfaAA-58Wyt1a-tYHh0kd-vaWITAZTQQqGopJ0_1781035696
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 01:44:37PM -0400, Gregory Price wrote:
> On Tue, Jun 09, 2026 at 11:53:20AM -0400, Michael S. Tsirkin wrote:
> > --- a/mm/page_reporting.c
> > +++ b/mm/page_reporting.c
> > @@ -174,10 +174,10 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
> >  	 * list processed. This should result in us reporting all pages on
> >  	 * an idle system in about 30 seconds.
> >  	 *
> > -	 * The division here should be cheap since PAGE_REPORTING_CAPACITY
> > -	 * should always be a power of 2.
> > +	 * The division here uses integer division; capacity need
> > +	 * not be a power of 2.
> >  	 */
> > -	budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);
> > +	budget = DIV_ROUND_UP(area->nr_free, prdev->capacity * 16);
> > 
> 
> Initial look - is there a div-by-0 here?  I noticed the old check
> prevents this from being (0 * 16), but i don't see (on first pass)
> the same check anywhere.
> 
> Unless this line below always forces the above to be a
> PAGE_REPORTING_CAPCAITY if it's set to 0.

It does, does it not?

> > +	if (!prdev->capacity || prdev->capacity > PAGE_REPORTING_CAPACITY)
> > +		prdev->capacity = PAGE_REPORTING_CAPACITY;
> > +
> 
> It's worth making this corner condition a little more obvious.
> 
> The code intends for 
> 
> if (capacity == 0)
>   capacity = PAGE_REPORTING_CAPACITY
> 
> but that's not reflected in the changelog as a default value.
> 
> When happens if a driver sets (capacity=0) either on purpose (???)

what would the purpose be? if you don't want reporting do not register.

> or
> because there's a bug (???)

exactly ??? since where are we practicing defensive programming in kernel
APIs?

> and then page_reporting.c forces it up to
> 32?
> 
> There's something to improve here.
> 
> ~Gregory


So I'll update the commit log to mention PAGE_REPORTING_CAPACITY.
And maybe a comment near capacity field?
Should be enough?

-- 
MST

