Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878EF363C77
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116276; cv=none; b=FF0rKNrhuE0xP9vMw9f+LWtExWawO0S502y+hTB7vdhC/bYecvop+tm9lOhNBiYrB2o8g7QrrmXbA8+9rIPCSOSX97xcctb+TSe29LK6VZXctuF0x57Awlc+oc5e4GAlcuBfdHmDG+eviuRMC/gtV8Q/qp6NZ02e8NoVzSSj13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116276; c=relaxed/simple;
	bh=+REFOP9fZuODX/fES3ySGttDUJLG0sFlGek/PVIurD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sw+2O/W3+TAvc0rII9Z4u8aUobSWpogor24s3Ea5tFWKx/EWMMb8cV0UqWgFlxUYDTO+UesXPdh5xVaWEKUanjC+RBOG6eNJ8mXQCcwQ6DjcpuoO1SBRhzyLEWnRMgI6zZS3dcczQL0AxGswCW2Gzne8yDnIY9oOrV2bOB2MPXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaL8YLjw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaL8YLjw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776116273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zypwX4nPzqqGkby3h4xchNBDXe75SXkmhVGTD+QMyg0=;
	b=EaL8YLjwvXOf54KGa4pS0NHbqBi5qBWJ5Dnc191FDHzAtYk4LHhfY9Jm+BHNelPhE24w70
	jGaAwgHTPSXKAquPAqwC8YbpLTfOnQo+2GJFgHu/0iPM79jf8ZPqJne6r78r6VtaWqhOmf
	8VrpM9vHCEgVTU0KgIGaH4oGFgyABEI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-RotfXPt1OZyUUEJFX0feoQ-1; Mon, 13 Apr 2026 17:37:52 -0400
X-MC-Unique: RotfXPt1OZyUUEJFX0feoQ-1
X-Mimecast-MFC-AGG-ID: RotfXPt1OZyUUEJFX0feoQ_1776116271
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d705eaa64so2008197f8f.0
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 14:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776116271; x=1776721071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zypwX4nPzqqGkby3h4xchNBDXe75SXkmhVGTD+QMyg0=;
        b=nbkoXuTomLHS8otAnLgHFehzUqjyJaykkdAt0dwAhxs2BW8naDdBNC6DhEeM4r7LnN
         6wXQa+p+Ai5I43FDqTsSzJ+RxxKfAGhhjGRIsER++YZq+vvWdoffBlf+flLftzcK2Iqw
         nWM3yge03rs1QputkraV8FpsYusB+3te4g9IWZ30Rw9YSYPmxsrHNAKm9T7zKB9I12hp
         PGXAbuUdFV34SuUDClloJF89LX/dpZS5f0/Ev7TjxUQzoZJhxw0BhXUVOW56agch0AWp
         C1lSOR5FtNpSqbDVkY64w1A3E84iBdV45yxNm16ByW29IHs6uXjSVvnqREEW4YIhhvhS
         Wp8g==
X-Forwarded-Encrypted: i=1; AFNElJ9ASF9X6Pg+cz41ml3FHtggq0yAKNhHDH2LFV4JuMCE2RXAPJyN7kqH30yhokA1K0atujbvcad3F8IroGb6rA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5xffZpd12f1/c8WzTvL9JnktM/40ZuIqj3i10+zpEfxIduke7
	a4jy8wgsAIdZWvtjvcCZaIU0w2BOjtJRwfHbNXR3hgpEiePpXF8T0+bILCq8bR1t6XKGWAsNV3V
	OwQZjZF8oBb6bxRB35lUf4+dxr9vcpTrZRByTv+rjnEdjhFP6wH6TmXbmcL/7Yka2Wheq
X-Gm-Gg: AeBDiesnR54Onm7yVT88cwJXKgGShEuqBcqKR3cqP4TkqbckVEn+I3nOPlC7FT1eiq/
	ZZhVqNF+j0Gn7qs40OlzIfSexeJ8qmMDzEBvRBTknU2rj3ZAY8s4J4AziYGfHi2FrBh7gAK8X6p
	olsMlgj5CsIQg8ayiCiZgNERyu1fBGtp4xW5bl3FV3UDoLHkjN6qvNc4Fo3klYoYeObH/5LEIik
	xI4BKK58plFJi0WD35usd8U8BX7R7pbtbCodx+ItkdiJCNDMtc8YPjktXsR5sGVmFrp+PutSNfH
	kWZnmdbZIfNg0YCGM5m1y1YYJcU+FHZNPpyAzk+zRVYuJpNa3GrWdkHJC5M6WFjhSgdLmpn/wjw
	kpPnfPgEiON8SAnNy57Y+o4GAuWMUrSu0WMYrPZqkLsw=
X-Received: by 2002:a05:6000:2dc1:b0:43d:7a97:78b7 with SMTP id ffacd0b85a97d-43d7a977b07mr6473096f8f.50.1776116270822;
        Mon, 13 Apr 2026 14:37:50 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc1:b0:43d:7a97:78b7 with SMTP id ffacd0b85a97d-43d7a977b07mr6473061f8f.50.1776116270231;
        Mon, 13 Apr 2026 14:37:50 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7cf533b7sm6776966f8f.18.2026.04.13.14.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:37:49 -0700 (PDT)
Date: Mon, 13 Apr 2026 17:37:46 -0400
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
Subject: Re: [PATCH RFC 3/9] mm: add __GFP_PREZEROED flag and
 folio_test_clear_prezeroed()
Message-ID: <20260413172139-mutt-send-email-mst@kernel.org>
References: <cover.1776033471.git.mst@redhat.com>
 <b21b0ba353330f24b9e10ee5bf01b60f32043327.1776033771.git.mst@redhat.com>
 <b258160c-5287-43dd-b56e-268c403b85ea@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b258160c-5287-43dd-b56e-268c403b85ea@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JIGLld2lseMHMFhd06JtdUNeB6KSJDmPTFGEW3qSLAw_1776116271
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 11:05:40AM +0200, David Hildenbrand (Arm) wrote:
> On 4/13/26 00:50, Michael S. Tsirkin wrote:
> > The previous patch skips zeroing in post_alloc_hook() when
> > __GFP_ZERO is used.  However, several page allocation paths
> > zero pages via folio_zero_user() or clear_user_highpage() after
> > allocation, not via __GFP_ZERO.
> > 
> > Add __GFP_PREZEROED gfp flag that tells post_alloc_hook() to
> > preserve the MAGIC_PAGE_ZEROED sentinel in page->private so the
> > caller can detect pre-zeroed pages and skip its own zeroing.
> > Add folio_test_clear_prezeroed() helper to check and clear
> > the sentinel.
> 
> I really don't like __GFP_PREZEROED, and wonder how we can avoid it.
> 
> 
> What you want is, allocate a folio (well, actually a page that becomes
> a folio) and know whether zeroing for that folio (once we establish it
> from a page) is still required.
> 
> Or you just allocate a folio, specify GFP_ZERO, and let the folio
> allocation code deal with that.
> 
> 
> I think we have two options:
> 
> (1) Use an indication that can be sticky for callers that do not care.
> 
> Assuming we would use a page flag that is only ever used on folios, all
> we'd have to do is make sure that we clear the flag once we convert
> the to a folio.
> 
> For example, PG_dropbehind is only ever set on folios in the pagecache. 
> 
> Paths that allocate folios would have to clear the flag. For non-hugetlb
> folios that happens through page_rmappable_folio().
> 
> I'm not super-happy about that, but it would be doable.


I suspect PG_dropbehind (or any flag, e.g. PG_owner_priv_1
that the patch that I sent uses) won't work as-is for
this.  The issue is PAGE_FLAGS_CHECK_AT_PREP:

       #define PAGE_FLAGS_CHECK_AT_PREP \
               ((PAGEFLAGS_MASK & ~__PG_HWPOISON) | ...)

This includes all page flags except hwpoison.  check_new_pages()
verifies that none of these flags are set on an allocated page.

PG_dropbehind is part of PAGEFLAGS_MASK, so if we set it in
page_del_and_expand() to mark a page as pre-zeroed, check_new_pages()
would reject it as a bad page.


I guess we could exclude it unconditionally, but this
looks like a riskier change to me. No?



> 
> (2) Use a dedicated allocation interface for user pages in the buddy.
> 
> I hate the whole user_alloc_needs_zeroing()+folio_zero_user() handling.
> 
> It shouldn't exist. We should just be passing GFP_ZERO and let the buddy handle
> all that.
> 
> 
> For example, vma_alloc_folio() already gets passed the address in.
> 
> Pass the address from vma_alloc_folio_noprof()->folio_alloc_noprof(), and let
> folio_alloc_noprof() use a buddy interface that can handle it.
> 
> Imagine if we had a alloc_user_pages_noprof() that consumes an address. It could just
> do what folio_zero_user() does, and only if really required.
> 
> The whole user_alloc_needs_zeroing() could go away and you could just handle the
> pre-zeroed optimization internally.


It's all rather messy, from what I saw so far there are arch specific
hacks actually around this.


> -- 
> Cheers,
> 
> David

