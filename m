Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D7D3D47B0
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162137; cv=none; b=m8vwxhe9vxorV0jupI8pkHPDcKG+6jHOU3rEUJIRszJQ8b6dulUYvYVdKHYkr5tRxX19Is2M3M0abHGKJsV4Z9tyINg01U67N2XuJRsksEqnWDdYXIpGRPdu6XXWfTMvPA/hO8YPcQt5KJQ/2P9bb5S0y/i5TCJMoDkIJY0JI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162137; c=relaxed/simple;
	bh=xILvyVtg9LF65+dVUQ70weH6IfOdBLvSQOgd6Pwdrvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Fsi+SH5JQ7GiUk8A+Ryp3Cdw490BGVFAStjrHExvBDkLsfbeRi7zHZlYDHN8nXVE8hywEh1ut2X9EVPG2DQTXCqQvOp/RltLjVC59Vlxr46IxEy+wujyzmYJQmnyqCcPA+JOSJDoLVAzcgsUGWGn1klJVv0HXE7WLvU9Ck7no3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTc9XV9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTc9XV9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BckpnXSCVQvxxavP5rvqgYmN6kasGEX6+ue3Zi6tRyM=;
	b=TTc9XV9u/mjd7Ckij7YmmggErysPO4ECfQ5iMlUrAgfcN4qJjyp8w/Aft3fC7zM4UxzELH
	fvkLh/BUb8tWsUeaaP40oPMY0t3qDTdGzUtO68Qy4Vx28xe1IdMzCbxamvnVAqq1h+hX5y
	V33RgYH7sWFZKGYYrTrwFEQnefd9aUk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-PSYTAWauM52hpjqqqBOkdA-1; Tue, 14 Apr 2026 06:22:08 -0400
X-MC-Unique: PSYTAWauM52hpjqqqBOkdA-1
X-Mimecast-MFC-AGG-ID: PSYTAWauM52hpjqqqBOkdA_1776162127
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43ea7a5da42so189929f8f.1
        for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 03:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162127; x=1776766927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BckpnXSCVQvxxavP5rvqgYmN6kasGEX6+ue3Zi6tRyM=;
        b=AkgdNDs+u0AZ3XfYkhx9GEMqK99iICX057ofvfX+2zMPJkkygoJMkqRNDvFwXtNAMF
         xlL4IjFyNjvR9uoK1YcPl1ra69fZMa9tIpz729d5mn290gXKZ9TkyRzcoaw4QL7OmKJE
         AjYDVdv3uF+kVGp1L5cVqtGNc/cxx/AoQRiXpw3DKjsgCjpYUE+FdiKZg/zhrWkfJ8i1
         AI4+uAojyl8QZ3PcuLq5OPdl7vTkW9vSY2odYliGBbNGvfLcVARuL5gSXxQFBeocO6AT
         tZFDIpjYzuVvtGBrgx+9yFbAxZFsuOgmHnmcUs9di8CzNm9UlVYSPZHOF1rEvZgPN9Eu
         MmXg==
X-Forwarded-Encrypted: i=1; AFNElJ/dkScGpYxYRoL9EznXLxamzXt863Ps+Uga62WS7e6AfHMurAQ7kgDp17DxcHnVrqbD+LHRUTfIyfaELxGEEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6TZbY8fKEsdYy6Bp8a4KFdSbPSWVxvKncPRsjXykaLDkrn5LL
	d7rYpb84MZRWWmjlpX024g0HhZbAuz9njB2+wC174G7GV1OLtIGJ8nO5Et5tE0It5EkqCy6o1LO
	zBt3uhqII667BiZCu7jvngiCQm88F+sBR37aOyBltLWWRTh1LbgwadnNosiSX5Nzj0Ihp
X-Gm-Gg: AeBDietE2o6dkkUoMBbnlD8EFtXzGldM6adA901KT2qXm1S1KzCsnwz5Ee3Q0MgWlmX
	KeIt7Tb7dKBXtKHdU7VU3cTBPQMGwec78phq4y1GbZpeRYiDwcHo7/IKvk35/+EhjfvH5lk2rYe
	plpKDeAFDwyKDcRH4wuxk2x+dagn+mtS6cod7w6ucbP0/IPvovH0PY5qLBKN3IAGNO5F+Sv2JM3
	3nx5sRkBxyi9zcyg1TgGtQkYJAzdBptVP1qLyDeTYS5IhhWDDA3tB6UrBCVvHwAFa4KLno39VI7
	qQo+KAOLuDKPx+I0XzQSfoMYm4SGGv+uUrnAdYk2q1KvCciYXS1AxMcl9C/98bMt1i5UDzVggZD
	bIgCv1oDOwojRfKJhNSZJSZ6EEj6VlP1f1Puf1XP290w=
X-Received: by 2002:a05:600c:c094:b0:488:cc72:5497 with SMTP id 5b1f17b1804b1-488d6ad5ed3mr156716775e9.31.1776162126935;
        Tue, 14 Apr 2026 03:22:06 -0700 (PDT)
X-Received: by 2002:a05:600c:c094:b0:488:cc72:5497 with SMTP id 5b1f17b1804b1-488d6ad5ed3mr156716545e9.31.1776162126454;
        Tue, 14 Apr 2026 03:22:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b128dsm194935355e9.2.2026.04.14.03.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:22:05 -0700 (PDT)
Date: Tue, 14 Apr 2026 06:22:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH RFC 2/9] mm: page_reporting: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <20260414062015-mutt-send-email-mst@kernel.org>
References: <cover.1776033471.git.mst@redhat.com>
 <ea67e39bc3aea1b0b491908f851ffce25154cd26.1776033771.git.mst@redhat.com>
 <2155527a-e077-4b71-80ee-d735f9984f60@kernel.org>
 <20260413163233-mutt-send-email-mst@kernel.org>
 <244c9779-b4a5-4d0f-9eb9-ef0ec873e0f6@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <244c9779-b4a5-4d0f-9eb9-ef0ec873e0f6@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pR1k7Z5HdnvGHT6ORT4AnmYxvB8iWvzpwlYJuui-oaY_1776162127
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2026 at 11:18:02AM +0200, David Hildenbrand (Arm) wrote:
> On 4/13/26 22:35, Michael S. Tsirkin wrote:
> > On Mon, Apr 13, 2026 at 10:00:58AM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/13/26 00:50, Michael S. Tsirkin wrote:
> >>> When a guest reports free pages to the hypervisor via the page reporting
> >>> framework (used by virtio-balloon and hv_balloon), the host typically
> >>> zeros those pages when reclaiming their backing memory.  However, when
> >>> those pages are later allocated in the guest, post_alloc_hook()
> >>> unconditionally zeros them again if __GFP_ZERO is set.  This
> >>> double-zeroing is wasteful, especially for large pages.
> >>>
> >>> Avoid redundant zeroing by propagating the "host already zeroed this"
> >>> information through the allocation path:
> >>>
> >>> 1. Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
> >>>    drivers to declare that their host zeros reported pages on reclaim.
> >>>    A static key (page_reporting_host_zeroes) gates the fast path.
> >>>
> >>> 2. In page_del_and_expand(), when the page was reported and the
> >>>    static key is enabled, stash a sentinel value (MAGIC_PAGE_ZEROED)
> >>>    in page->private.
> >>>
> >>> 3. In post_alloc_hook(), check page->private for the sentinel.  If
> >>>    present and zeroing was requested (but not tag zeroing), skip
> >>>    kernel_init_pages().
> >>>
> >>> In particular, __GFP_ZERO is used by the x86 arch override of
> >>> vma_alloc_zeroed_movable_folio.
> >>>
> >>> No driver sets host_zeroes_pages yet; a follow-up patch to
> >>> virtio_balloon is needed to opt in.
> >>>
> >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>> Assisted-by: Claude:claude-opus-4-6
> >>> ---
> >>>  include/linux/mm.h             |  6 ++++++
> >>>  include/linux/page_reporting.h |  3 +++
> >>>  mm/page_alloc.c                | 21 +++++++++++++++++++++
> >>>  mm/page_reporting.c            |  9 +++++++++
> >>>  mm/page_reporting.h            |  2 ++
> >>>  5 files changed, 41 insertions(+)
> >>>
> >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>> index 5be3d8a8f806..59fc77c4c90e 100644
> >>> --- a/include/linux/mm.h
> >>> +++ b/include/linux/mm.h
> >>> @@ -4814,6 +4814,12 @@ static inline bool user_alloc_needs_zeroing(void)
> >>>  				   &init_on_alloc);
> >>>  }
> >>>  
> >>> +/*
> >>> + * Sentinel stored in page->private to indicate the page was pre-zeroed
> >>> + * by the hypervisor (via free page reporting).
> >>> + */
> >>> +#define MAGIC_PAGE_ZEROED	0x5A45524FU	/* ZERO */
> >>
> >> Why are we not using another page flag that is yet unused for buddy pages?
> >>
> >> Using page->private for that, and exposing it to buddy users with the
> >> __GFP_PREZEROED flag (I hope we can avoid that) does not sound
> >> particularly elegant.
> > 
> > 
> > So here's an only alternative I see: a page flag for when page is in
> > buddy and a new "prezero" bool that we have to propagate everywhere
> > else. This is a patch on top. More elegant? Please tell me if you prefer that.
> > If yes I will squash it into the appropriate patches.
> 
> I'd be interesting to know how this would look without the GFP flag,
> when we don't have to leak any of this out of the buddy.
> 
> -- 
> Cheers,
> 
> David

But the zeroing takes place outside of the buddy now, it's more
"reporting" than "leaking".

You mean, moving the zeroing into buddy?

See

https://lore.kernel.org/all/20260413184022-mutt-send-email-mst@kernel.org/


-- 
MST

