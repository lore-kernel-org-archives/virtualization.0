Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0339B952
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785705; cv=none; b=t9ABXL4/MLFbOoOg7pAJ8PiTYM6hD7Jb1ZPKbDCAmMGOJQdudgXPH9ZstQSxYHH1gG5UsX4sHFuQ33CWN9ujrhc8LcM+/9TGLth0bBLNk5ouhO+mD/j7PMzAuTLzchwrsC1J6SKWM9h2hnVVYRASpN4xsxpaJnKKyaww7HOEKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785705; c=relaxed/simple;
	bh=YPbB8kaYOpNPhNCkPvBdMTch1YgCmXjdWlb24weNuqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TmKCKKFw9nyjaCKGC5ABTTYGDVLpg3FXOatu1J21SQueFjVNkLl/0dCaGeeJvI2ytNTU5G2VHbULFiE9koEPrMYr/G1aZPHhWlzoZLtOHLo0QF4dxsYW86nnHt/O5bd0Jk4V7+aq9gZu2j7/LZpltOFn1Qxs5bIMZQAe/QzNnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WmO7DKJb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmO7DKJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778785703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2xKMY0TqKrMt3bc3tXaYFIaskKaQVgiNDhgsdldGKxw=;
	b=WmO7DKJbfZSfnQYgFHcA3+qhIw1DDUbW8NtKkl19akqL05uzeX0G7j/UneI8CY9TI6AIOz
	AICaJH+mFxI4VJHXZcQrE+NlcfdMspnIOV5xo+e2g4xrcr3xhzcET6UfZqCEDijkCw/gJV
	CuBmKTCV8hIm1V7xpdjG9a26ipmLh9Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-yl_8QiXwNyWVnhgGjoYkZA-1; Thu, 14 May 2026 15:08:22 -0400
X-MC-Unique: yl_8QiXwNyWVnhgGjoYkZA-1
X-Mimecast-MFC-AGG-ID: yl_8QiXwNyWVnhgGjoYkZA_1778785701
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45e55c44ac1so524020f8f.0
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 12:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778785701; x=1779390501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xKMY0TqKrMt3bc3tXaYFIaskKaQVgiNDhgsdldGKxw=;
        b=K9P0feR+dZaBoelpTpiEdlPUR30NtqQazwin5rrFG8u503xPakvRcCVVc43k1vF2rl
         hNbnLFmMx82F2rirB6o10rJuDY0s/n2dFqY+7QKXAcA6WRVLtZWr2O5HtzoPORHIUMnx
         YdaM9YGcOL690vbpubFNcXWwROFbTvWMJode3ZxULsMSf+Q8LMhhfqkaLPL68wi3oaD8
         aIQmydd3IkC2UdQXk+eAg3Yk3V9C0m2i41i/jMVENRP8YtOEJWUTqKUEimgUtf2Ou7ZX
         S7xBdqCm2X2Htq0OyE2B69xMva8wMPuIZW/N1H5hFmQjiYILvvwH8awyaTjsM6dWSEp9
         cfRg==
X-Forwarded-Encrypted: i=1; AFNElJ+EkPv8qzd0CODpb77hrI8KPTP2xx1f7m/UBZTIVyiuUn2uF0xgcOzhqJxFa4JppIfgPerEZ8tRRVzBN8SEBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF17m6/2qDVZ9AiUlyLJ9irBk/FMimzwB4N0iEH/Fo0+d/jn2J
	ecZsHDwPCz/U2fLyd+4+vAv2ySwQTdINSDD99U8ARaBpiVqXvU5KVyBX4HXdR6KjwNRGEFPiNEF
	VRAfLdOWUFYDAuVLP7m1nIw4m1DwbCz5j/UyPbnJi7o0FMNeA3+nQ886Zh1xGVGPQ31kS
X-Gm-Gg: Acq92OGWHUSBdfaa/s0x+FXwNrhXCnb8i97iq2JJOmYlwHKaoGFEX2hs08BcRL56aDL
	gAIFirOtqYEivAXKMMarue8NHK7u94RogW4juhVTJds5mLfC01UAfG29ysjDiLp/m/jTohl9tyz
	Wk6vlXc3ZcqLZwDewed34pXJjnD3UBGh07pE+wF0dz1NctOCDWtsMI00rjScDVTz1ZaBIvXDWyv
	TzIChzECc5hcBeX5BkW6Ju2xn5+Pl5MoFgdREHWnrQBqJqNcVhtaIafysXynnAHUE/Nv4eqpuA0
	hn4mFJNcMWmTOgTnoWsl77C5jP0jRpj2YGl0N+k2JHrezbzc15FYuPz4vscQKlQmxNLw5wwYlOf
	aslfM5tB2uGmK5tIjDXf7ATfYXxt2vn9pXuzpHv+H
X-Received: by 2002:a05:600c:1512:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-48fe60ecd67mr4946035e9.9.1778785700694;
        Thu, 14 May 2026 12:08:20 -0700 (PDT)
X-Received: by 2002:a05:600c:1512:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-48fe60ecd67mr4945575e9.9.1778785700166;
        Thu, 14 May 2026 12:08:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm8558986f8f.16.2026.05.14.12.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:08:19 -0700 (PDT)
Date: Thu, 14 May 2026 15:08:13 -0400
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
Message-ID: <20260514150750-mutt-send-email-mst@kernel.org>
References: <cover.1778616612.git.mst@redhat.com>
 <45d1ea85b574399459a64fdba28fcf04abfa3e7e.1778616612.git.mst@redhat.com>
 <agXS7dMmtJrPhu9W@gourry-fedora-PF4VCD3F>
 <20260514135214-mutt-send-email-mst@kernel.org>
 <agYa9s5B7OWG-kjR@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agYa9s5B7OWG-kjR@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PrF6eDJjF3MF39_vj42ClC1_zpDN1S4muvEHZItMyyQ_1778785701
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2026 at 02:56:54PM -0400, Gregory Price wrote:
> On Thu, May 14, 2026 at 02:00:31PM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2026 at 09:49:33AM -0400, Gregory Price wrote:
> > 
> > There are calls with no __GFP_ZERO but they do not allocate userspace pages.
> > 
> >   - drm_pagemap.c: GFP_HIGHUSER -- no zero. But this is a DRM device
> >     page migration, the page content is preserved from the source.
> > 
> >   - test_hmm.c: GFP_HIGHUSER_MOVABLE -- no zero. Test driver, pages get
> >     content from device.
> > 
> >   - mm/ksm.c: GFP_HIGHUSER_MOVABLE -- no zero. KSM merges identical
> >     pages, content comes from the source page (copy).
> > 
> >   - mm/memory.c new_folio = GFP_HIGHUSER_MOVABLE
> >     - no zero. This is CoW, content is copied from old page.
> > 
> >   - mm/userfaultfd.c: GFP_HIGHUSER_MOVABLE - no zero. Content comes from userspace via userfaultfd.
> > 
> >   - arm64/fault.c: __GFP_ZEROTAGS not __GFP_ZERO. MTE tag zeroing, not page zeroing. Page is zeroed separately.
> > 
> 
> Right, so in all of these cases, it would be just as correct to pass
> USER_ADDR_NONE I imagine :]

Hmm. Are you sure? Isn't the address used for numa policy?

> i.e. the user address is irrelevant, and the caller is responsible for
>      sanitization before return if it's relevant.
> 
> Otherwise, passing (user_addr != -1) the buddy takes care of it for you.
> 
> Just an obvious security bonus to all of this, but by no means a
> requirement for your set.  Just an observation.
> 
> > 
> > I'd do this on top if possible.
> >
> 
> Yeah reasonable.
> 
> ~Gregory

