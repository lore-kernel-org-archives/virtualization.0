Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96A357CE1
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159614; cv=none; b=X6n1aFu2fnJQaVmoPBjyvpcp/42adcvYBUir4zd+0SbhCElB2+FiKbe0EgU04q+U+t53CHqrBzt+2fZqSPk66sml5DI3hG0laTLHpYTT5WhGEMqHbF+dIRgRsa7e3kxWjcbx98kQElJnMidx6FoA8KWG5zdHyinAC8YqD3bNbIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159614; c=relaxed/simple;
	bh=9jL6jLKwvJKP3LL/un3n7s6ajRGzkzzu9eCDfq7iaMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UU9/fXh3HWJKCnISsLJ88u1VmpC+SoHaVv9zQnzO+wqO5mPyYPWtmZ/cuaIjfWhkqf5zPzkX1BzaZ5cdkUi8uM9QyQGmF0wjjYUrmXSxdhJsPLqj57kuf2y04xqun+1kELARZ4UImVgaFyzvTxG8/X8vt2UgAffGQGuWIXTRAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bK2Q5NgQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bK2Q5NgQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781159612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nUXcCYB3mg7pVgqNjbUYn7VXuJDevAzArkzYyGeIlRQ=;
	b=bK2Q5NgQX7KJ8knXCUavEgIugaI/ZdjrhqHeWdJUJfmcAMaPJcUZU1lnAOOI7jQ5cJEbNW
	jU5vvsDtNzqWFOnATr+srP/l7UdDGgD92GPnTs9T1TbiLTAhFKpoXprq8sewh0jzHYgelk
	L8CdF+2dwtNZFGsfjxRDV5GWZZ1PNtE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-pEwO8JDjON2zQkdnpywNWQ-1; Thu, 11 Jun 2026 02:33:30 -0400
X-MC-Unique: pEwO8JDjON2zQkdnpywNWQ-1
X-Mimecast-MFC-AGG-ID: pEwO8JDjON2zQkdnpywNWQ_1781159609
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef4931de5so296996f8f.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 23:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159609; x=1781764409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUXcCYB3mg7pVgqNjbUYn7VXuJDevAzArkzYyGeIlRQ=;
        b=AG05vXAWQyQYWsn9USE2dCiumtZ4STgaHWeu1/IyxfRD8atZquzPoAG9grcFHoxacb
         28Wt8nvniAc3f8BBBs8t3nc4bLyaA8T/DDz7LkhGkwIx9dY/FtOqrs/kXTAIbNrrOBXJ
         iafFvTLwRuohOgYfBJzWmgcWyPnJlxV1sojnxxmwlBJ4B+jk+Mario2fO1zw1NFOAY8h
         EClWwy9zG3kKNYsb1sIpAyvMybxFrgcQCeSy8HAtxEAs1pXfNnvUDb0ikDfSYHtA/ZQj
         UB6O/O2AkjbRCR7fqfIB9i3uiKqN99W751YYEIPHEKp7sgljpjk4TxzqXQ/guGyh1jdE
         6R+A==
X-Forwarded-Encrypted: i=1; AFNElJ9fapRGZX2q1MfKl+Mb6fOgo5VwFyM5t0RHf9n3ospSla3mMq9xY0iK9bW1BEJHRjta+URhWA/mcgFserEXQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzP+Q+Jon0ajT+lfsi4zZtZ3ejKiD4eW21tdPJt6zo9KaKBOvf5
	B8wQpusdRYegx5puswvUIq3uUiLG4BIR5Jn50ymESmm0OrxirIuwqPw36OyUMllm+d7czFFvgl+
	UcsTt5F1MnYGfG5HCIC+eJ92p8XPRVKWir8aZU1NZ2jPoklagp7uJXVpCUiWpvzCEHtCE
X-Gm-Gg: Acq92OEPNr+SqvzU6qGoITbM/MqnrVkoJQw1nu3OMmdboax0Aa5YklhgrY1+Mg8J5Yv
	xTwXhVXIGZoB/6nEmM6SMXVLXzlNja7uee8DBYoeRxIPvVOpz2D2AGB9kblhcj1BQPXqC5t0UCv
	QWiDUZPNso8Buj4ZEQsM6/ctGrfp9BIWuWJ+uHM/dXzOcDBAEbU5boXbAOha2iAoM/2THgvnQ0J
	NrW4jm1Aso2BQOUFJxVoHmkNb90h9WCFcFLFjjlItEbwSFUmw2Gbpc/SGL6lpvQf0qoxSazkKPm
	nOSN6g+XNu3hnsVlC148PXj+OagmohG/BEf+Z9NEPZv5H57ctl1XT3yBs1IDctxZYocOsFM85I2
	5jLePR3u5/AfWAiyPp/ckgNhzRwhPAh3xsFAqTHFVo9dn+YTzhceTxg==
X-Received: by 2002:a05:600c:3ba7:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490e52cad04mr12572745e9.2.1781159608698;
        Wed, 10 Jun 2026 23:33:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba7:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490e52cad04mr12571975e9.2.1781159608179;
        Wed, 10 Jun 2026 23:33:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52ac9aasm23585695e9.4.2026.06.10.23.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:33:27 -0700 (PDT)
Date: Thu, 11 Jun 2026 02:33:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Miaohe Lin <linmiaohe@huawei.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
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
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: Re: [PATCH splitout] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Message-ID: <20260611023208-mutt-send-email-mst@kernel.org>
References: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
 <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
 <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tPntgIPZLdnIJAONEDg-afeRT36ZOEhbXRYuHVDH6gc_1781159609
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 08:38:09PM +0200, David Hildenbrand (Arm) wrote:
> On 6/9/26 20:10, Andrew Morton wrote:
> > On Tue, 9 Jun 2026 06:12:49 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> >> TestSetPageHWPoison() is called without zone->lock, so its atomic
> >> update to page->flags can race with non-atomic flag operations
> >> that run under zone->lock in the buddy allocator.
> >>
> >> In particular, __free_pages_prepare() does:
> >>
> >>     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> >>
> >> This non-atomic read-modify-write, while correctly excluding
> >> __PG_HWPOISON from the mask, can still lose a concurrent
> >> TestSetPageHWPoison if the read happens before the poison bit
> >> is set and the write happens after.  Will only get worse if/when
> >> we add more non-atomic flag operations.
> >>
> >> Fix by acquiring zone->lock around TestSetPageHWPoison and
> >> around ClearPageHWPoison in the retry path.  This
> >> serializes with all buddy flag manipulation.  The cost is
> >> negligible: one lock/unlock in an extremely rare path
> >> (hardware memory errors).
> >>
> >> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> >> in this file operate on pages already removed from the buddy
> >> allocator or on non-buddy pages (DAX, hugetlb), so they do not
> >> need zone->lock protection.
> > 
> > Sashiko is saying this doesn't do anything "Because
> > __free_pages_prepare() executes entirely locklessly".  Did it goof?
> > 
> > https://sashiko.dev/#/patchset/df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com
> 
> Battle of the bots: it's right.

Ugh it's bot against human - I remembered we have zone lock
normally in alloc and thought it helps and didn't double check we don't
have it here . The bot wins (

> -- 
> Cheers,
> 
> Davidc

