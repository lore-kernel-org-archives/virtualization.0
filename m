Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B47F36604E
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112337; cv=none; b=U8Uy3+8PUV2KYfhXNIU2HBrN+d1mLkx2oji/DQddJAQETBPsv78UIZguwQ2+raXs5YouHfVGrG7CzJn7S3Y8sw5TIgJTqXnWhLQNsocrKImC4q2A1jVD/c7jwD7ptzTCCPehZhVaFYUIvZbd86zX55rBncJczCJmCXskkGz6Sng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112337; c=relaxed/simple;
	bh=3mpoi8a9u2lmPNM30l3zv4vXYeFva/GaZUe1gaAmh8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tLkULWnOdjolH1f9g320Hjq0gbo/1td6jp68t892Ux539LoMYtO3jBmK9XvYtj+ANcC1Y0H6uQDJ17cKQ2sG9MZmPDR2L+Z230RLmBzG2qjR9uWDljfCYdjoMyOK2kWpj+dvJTgiw5MEb5cDVnmWKdSYHEImpswwMhIyn/dLLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhvEP8kh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhvEP8kh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776112335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWH25+zbxJ7b6HA24/mMxvWwNWDzV+d0yyXTRBBCpp4=;
	b=ZhvEP8khqJ8gLbZ71HT/RpOt+5i2lN7OvPZSOs/lvMU7hgN42guX/14gaHuAuRwh7BslHN
	CC+H48izqxAAmF1my1VUY8Z7zXDoxiBJ6AfPYJ0EZT59ixJ4RMAmT3GIDV9IVL/CFHGXbw
	qaPaFyTiJt1mbHvVjjfJIY89ESxWqs0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-V-LFXtlgMhK7gpikzkYv0A-1; Mon, 13 Apr 2026 16:32:13 -0400
X-MC-Unique: V-LFXtlgMhK7gpikzkYv0A-1
X-Mimecast-MFC-AGG-ID: V-LFXtlgMhK7gpikzkYv0A_1776112332
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d2cd2674so33753775e9.0
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 13:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776112332; x=1776717132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWH25+zbxJ7b6HA24/mMxvWwNWDzV+d0yyXTRBBCpp4=;
        b=VShrPNkPxF3IH8U9A1GbT7KNiT7WAjMofLFEF07UrTbs74GHvjF21n13cLG8MCqbkf
         W3z8aiOjq/OvgVlUdxSMSnpGm7fmmy/gplbCT/rBAB8mBlIFiiu363LPGswzX2cTdLvu
         nzoypx0oqB28s90/qHQXIpz5AjsGMhLjXhylS1bi31YsntwEDP4oYBFbLBqW8sWEWXJG
         2tuzuFKzGrhoQe6k82kIKeJpHqMJmrlwseUMx3FOBZEXJQsOrnuJZQ1FsUEeOWRzb/lR
         MOLkPu1l+IXIRo/LvrFMfzJhpb1AEmCCTrYAgDQD1zzrdWpRE/taYvRyUaVJSHRvXgrT
         TWig==
X-Forwarded-Encrypted: i=1; AFNElJ+JaO3mzoP11hqHOPbB13m87Aw8fuXGQxXKcAQyfq6Qi4nTnk0kPmA6GE9v7FN7upv/BoWMoRs6xxYIgpzdpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ1GLVTWjxhPqT4Hqi2szPA0QV1CZKhRwh3CfTlQdEmOlBxISL
	cFKlZ8elewHPtcFyCa15UDY5sTXbVXmXnqiV/e9ZRFCxFtsozi0Gye8f3DCbzlC7vZbdOXPpUAr
	vGSYLUMlQEKRBUGuZYccHnKPRKxrJWRod4EJl7NVIkIia47O1uqBy8OphsxC09MVD2lWe
X-Gm-Gg: AeBDievJuP/sNokCze/RAI11AKwa15/Kikn3PCRweZfTbovJV2pckJDx1p3Q/+hK/nE
	BuI4mcB6aRWbR6iquSxSTqBJNq1EmVxEE/ti3Nnyn7B5X6gpNf16xUw7BaFp4h6HbgnQiXssr8P
	YSnNygl451Keyr4Y5w+v3lj1WiZthrRtttpxDzSfccFisugOWZJ//kAcwS2G0jWNYINDgiF8I/E
	VVs4rxpm1skyL2NbEmayCXxj4M/MtgfXpxU8sJv7SHkXPnYG+0YFXLdY3s1tAovLOnl8kN8MXqh
	HtiqLOcq3EGGBGuNlVCgO6Y9HlGtLEIzh5EjsZvPzwkrmdSfIbkLZXyGYELIrGtPVpOln7cFOxr
	U3Cw0mRYEXDzXM56KOjFu9L5gzRS/EFJDxrImD8h214c=
X-Received: by 2002:a05:600c:4504:b0:485:3b9e:caa7 with SMTP id 5b1f17b1804b1-488d6864f6dmr201909265e9.23.1776112331895;
        Mon, 13 Apr 2026 13:32:11 -0700 (PDT)
X-Received: by 2002:a05:600c:4504:b0:485:3b9e:caa7 with SMTP id 5b1f17b1804b1-488d6864f6dmr201908795e9.23.1776112331276;
        Mon, 13 Apr 2026 13:32:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5cf2e70sm177712665e9.0.2026.04.13.13.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 13:32:10 -0700 (PDT)
Date: Mon, 13 Apr 2026 16:32:07 -0400
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
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH RFC 1/9] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <20260413163104-mutt-send-email-mst@kernel.org>
References: <cover.1776033471.git.mst@redhat.com>
 <a74ad3652d9bd68c78fbb5360fa7adfd0606689f.1776033771.git.mst@redhat.com>
 <b330143f-f3aa-4f4c-8467-d91102094e8d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b330143f-f3aa-4f4c-8467-d91102094e8d@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DSyU2WaS8Q9QJIS8Rv0yuva9o9muYK9YDPcnNUCpDAI_1776112332
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 09:11:51PM +0200, David Hildenbrand (Arm) wrote:
> On 4/13/26 00:50, Michael S. Tsirkin wrote:
> > When a reported free page is split via expand() to satisfy a
> > smaller allocation, the sub-pages placed back on the free lists
> > lose the PageReported flag.  This means they will be unnecessarily
> > re-reported to the hypervisor in the next reporting cycle, wasting
> > work.
> > 
> > Propagate the PageReported flag to sub-pages during expand() so
> > that they are recognized as already-reported.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> > ---
> >  mm/page_alloc.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 2d4b6f1a554e..edbb1edf463d 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1730,7 +1730,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
> >   * -- nyc
> >   */
> >  static inline unsigned int expand(struct zone *zone, struct page *page, int low,
> > -				  int high, int migratetype)
> > +				  int high, int migratetype, bool reported)
> >  {
> >  	unsigned int size = 1 << high;
> >  	unsigned int nr_added = 0;
> > @@ -1752,6 +1752,15 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
> >  		__add_to_free_list(&page[size], zone, high, migratetype, false);
> >  		set_buddy_order(&page[size], high);
> >  		nr_added += size;
> > +
> > +		/*
> > +		 * The parent page has been reported to the host.  The
> > +		 * sub-pages are part of the same reported block, so mark
> > +		 * them reported too.  This avoids re-reporting pages that
> > +		 * the host already knows about.
> > +		 */
> 
> The comment is a bit excessive. I'd say you can drop it completely.
> 
> > +		if (reported)
> > +			__SetPageReported(&page[size]);
> >  	}
> >  
> >  	return nr_added;
> > @@ -1762,9 +1771,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
> >  						int high, int migratetype)
> >  {
> >  	int nr_pages = 1 << high;
> > +	bool was_reported = page_reported(page);
> >  
> >  	__del_page_from_free_list(page, zone, high, migratetype);
> > -	nr_pages -= expand(zone, page, low, high, migratetype);
> > +	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
> >  	account_freepages(zone, -nr_pages, migratetype);
> >  }
> >  
> > @@ -2322,7 +2332,8 @@ try_to_claim_block(struct zone *zone, struct page *page,
> >  
> >  		del_page_from_free_list(page, zone, current_order, block_type);
> >  		change_pageblock_range(page, current_order, start_type);
> > -		nr_added = expand(zone, page, order, current_order, start_type);
> > +		nr_added = expand(zone, page, order, current_order, start_type,
> > +				  false);
> 
> In MM land we started doing
> 
> /* reported= */false
> 
> 
> This raises a good question: how does buddy merging handle the reported
> flag?
> 
> -- 
> Cheers,
> 
> David


IIUC it doesn't: reported pages are never merged, if a page is merged it has
just entered buddy.

-- 
MST

