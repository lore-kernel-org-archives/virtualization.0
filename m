Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB73ACEFE
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042457; cv=none; b=W7j0NxUdGm0QaxSA4sfmkM0PgCReUcsTVklx8a3ul4Z/xev+08G/YAXLXmba6AU5EOTVkH/RL8kvI2KoQ1ZGKE5WhZPJHcRIuHeOmN7QEn4E4pasfOdobtS1aneeWkaX2i9qCCSITwUWTaHcJ29Bg+E6GfB03dZ8u+/87YdyFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042457; c=relaxed/simple;
	bh=NZCVF6uuDzwGVwSqQjUsmpGpjI4eZDHZSW3uzzeX8tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nd3Ydtt3I0OMobYc6sBldNxEHr3gUD4DatAnk/XouCyIZ5l0sn1L6bAShl5zuoxwW+logQiaR5l3SVYHC+yr+UgCJtq6TZOwkU/qfPhx8NSu92och1s8XHCr1Q/jkxCfg0xQOYmw0Jvf3aGhu8UJQMGwjj4HJuMCv0U8/qXVLqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnL83uor; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnL83uor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781042455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9i2Af7K5yNSnpzmJpY557qOnqur0hKTAqhtHYtV96bo=;
	b=WnL83uorJe5/0TV41f6nH6Cg7sgwtlUPR3rs6AGj5Nofq13xV79EeDvYfjwwokaTC+IGEQ
	5i6NRF+MJVYx5QhXRGsgYOiiUo7GPCZsOEHGDHbVn6y04Ij6QbUU9nLgBUw63+zePEXCSj
	h/fLDApyh4/Xlcip3wQSuJBJbPr2obM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-v_iVTRFuPe-op5lPNJocRA-1; Tue, 09 Jun 2026 18:00:53 -0400
X-MC-Unique: v_iVTRFuPe-op5lPNJocRA-1
X-Mimecast-MFC-AGG-ID: v_iVTRFuPe-op5lPNJocRA_1781042452
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso48373575e9.2
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 15:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781042452; x=1781647252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i2Af7K5yNSnpzmJpY557qOnqur0hKTAqhtHYtV96bo=;
        b=V8psHOelxP0DxNhpAEJaGYofl+YN0mj5nhRYmCifvm/SU8cDz2AUwqSR1xGbyi8HLr
         YXLgApBhe58ggfuBQGJOCcjX9rgUmjyqvlVteqA+muLCsUZj1Gg6WaXv7kwZ5pE3Kdan
         id+i3ipxPSpbl3Bfzw2qKsMUgHrz4ZWZB25kC8EYnY7zQR/2fE1z8oY4kjQUfznxKYjs
         AIQzxzur8xomXO1s41Hg+4rNXpZ54j5RuhTU1GEbRgHXre5u+S2hqGE+VA6qFaOYszr1
         dYMcgXWJnPeoaU/66R9pqUJUvKTfDVjsgMQQpotbvrypX9J4kHtvlGLc9ZpPhe5Lkklm
         Yy4w==
X-Forwarded-Encrypted: i=1; AFNElJ+D3uLo1kMqBaWKIN5Jq8RAd0sCxlY/cPsQ/hFLJHp4i2/0dUJjmeZT3eUV5tTXS8kNyV47++qCQyz72A3i5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxk51pMto1rUdPgzR3hcoh08KjPByT5Trnvf9v7TkZ3jNwk2TZ1
	TOBzFntflYSVwsbuXi7sE/kDkNB3uOvUOHjWcphhhdt7qPhWWrMohI0EE7t3JeaFOlKLWVWrqvj
	OSw3hWH2ehml33s9MSqTkR8lf1IqgPpa94y0IRFitLw1i7FGSknKnXvCqOTkP/Pf4FyqN
X-Gm-Gg: Acq92OHS8fzSAZXIm+7h3zNEiK65Mc8DKe3YlkF2AkBPgD+AKvDrIKJbj5cvkrYzVw6
	Ehi/HP26E7IYnCKRBWz5QH0CN3bdPIuiaFPvtIIdty3L4Qn8Rmq+Q0MBRU360ADL1gh8HRbtq9d
	ZlS0wJyOCjzqmKNq+J6O8JTgV6SJlejDhaEkN3irLDKqQoSwUqSuJYFxhrt+MAyTMGhIBacvnSq
	g8JbkwJ4yzFUrBtUcosDJz1x0UbzEq5BS4d1toUzyLJbf8ee1zjpFBj8k4GRErt7FXz9KoIPmih
	CU5RMUe8pwUhXBvPvpHCSVvE34XpKzuzEqIje6ExWv545V1UGYTt55JFOyW/g/luv/DcLGDsDqX
	iW/J77ELlLTFmFdKHez0KuZ3YgFsFOQAqMbuZBupj+ss/ozScrB7Mrg==
X-Received: by 2002:a05:600c:45d1:b0:490:bf13:a1b with SMTP id 5b1f17b1804b1-490c260567bmr335621815e9.26.1781042452008;
        Tue, 09 Jun 2026 15:00:52 -0700 (PDT)
X-Received: by 2002:a05:600c:45d1:b0:490:bf13:a1b with SMTP id 5b1f17b1804b1-490c260567bmr335621065e9.26.1781042451443;
        Tue, 09 Jun 2026 15:00:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dca8fcfbsm4818565e9.1.2026.06.09.15.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:00:49 -0700 (PDT)
Date: Tue, 9 Jun 2026 18:00:43 -0400
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
Message-ID: <20260609180022-mutt-send-email-mst@kernel.org>
References: <b25ea6c63503f24c8b5b64910a44dc03b5aa610d.1781020302.git.mst@redhat.com>
 <aihRBTaTUmgYmZfX@gourry-fedora-PF4VCD3F>
 <20260609160506-mutt-send-email-mst@kernel.org>
 <aiiJPwhn6gF3ILur@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aiiJPwhn6gF3ILur@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N3XcdFRpxEHr6RgjYGMm4uQb-kVwBK6oWEG_1AWVWrU_1781042452
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 05:44:31PM -0400, Gregory Price wrote:
> On Tue, Jun 09, 2026 at 04:08:08PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jun 09, 2026 at 01:44:37PM -0400, Gregory Price wrote:
> > > On Tue, Jun 09, 2026 at 11:53:20AM -0400, Michael S. Tsirkin wrote:
> > > > --- a/mm/page_reporting.c
> > > > +++ b/mm/page_reporting.c
> > > > @@ -174,10 +174,10 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
> > > >  	 * list processed. This should result in us reporting all pages on
> > > >  	 * an idle system in about 30 seconds.
> > > >  	 *
> > > > -	 * The division here should be cheap since PAGE_REPORTING_CAPACITY
> > > > -	 * should always be a power of 2.
> > > > +	 * The division here uses integer division; capacity need
> > > > +	 * not be a power of 2.
> > > >  	 */
> > > > -	budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);
> > > > +	budget = DIV_ROUND_UP(area->nr_free, prdev->capacity * 16);
> > > > 
> > > 
> > > Initial look - is there a div-by-0 here?  I noticed the old check
> > > prevents this from being (0 * 16), but i don't see (on first pass)
> > > the same check anywhere.
> > > 
> > > Unless this line below always forces the above to be a
> > > PAGE_REPORTING_CAPCAITY if it's set to 0.
> > 
> > It does, does it not?
> > 
> > > > +	if (!prdev->capacity || prdev->capacity > PAGE_REPORTING_CAPACITY)
> > > > +		prdev->capacity = PAGE_REPORTING_CAPACITY;
> > > > +
> > > 
> > > It's worth making this corner condition a little more obvious.
> > > 
> > > The code intends for 
> > > 
> > > if (capacity == 0)
> > >   capacity = PAGE_REPORTING_CAPACITY
> > > 
> > > but that's not reflected in the changelog as a default value.
> > > 
> > > When happens if a driver sets (capacity=0) either on purpose (???)
> > 
> > what would the purpose be? if you don't want reporting do not register.
> > 
> > > or
> > > because there's a bug (???)
> > 
> > exactly ??? since where are we practicing defensive programming in kernel
> > APIs?
> >
> > > and then page_reporting.c forces it up to
> > > 32?
> > > 
> > > There's something to improve here.
> > > 
> > > ~Gregory
> > 
> > 
> > So I'll update the commit log to mention PAGE_REPORTING_CAPACITY.
> > And maybe a comment near capacity field?
> > Should be enough?
> 
> I suppose the question is whether capacity=0 should cause a WARN (i.e.
> only a bug explains that value), or if capacity=0 means something
> special (i.e. use the default) and therefore that should be documented.
> I don't know which of these is the case, but if it's the latter than
> that deserves a comment yes.
> 
> ~Gregory

It's the default. Will document.

