Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA43D6477
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776771; cv=none; b=TT2nFf5v5lirzKTcHxCMvKkKZxDTEI2lArQCQusmm2Vzd5sjhWTSFWaryqryLwn+GOKJltRWcCaZovFBfO1VZWgSsuAAr+dldkomJbsX+6s3720eOU7BKEXHnTiqcJF5qxWRflDbhqFPYnu1OMzGc6X8uX1m68LkvV0dRUW/IiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776771; c=relaxed/simple;
	bh=lh1FcXOPpS+yPvMhZ11/X62M6aZEU5IC4SqKzlJLlWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sVwWkVoCfSrhLOBjzsr5xc7VNojNSVg+bJp+UAC88IVr+SPGOfDlc9A8V8uSnWSAwvZAQx9kcxZNwD6aMGunEANNK5Jg2Vv0vp6mCwh58sS8CeC+IQYXQFs3dDzWTPmKCWqPXnIYeY7rnz2GXsDMQbhqyMDo+iPnuoWhOL1mVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUBJWQVe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUBJWQVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776776769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1rvnWiWbaVtbuakXF1GY3gyQym0BGWKhGhCncv/qMI=;
	b=BUBJWQVeI2Je5QmyNLyPlZYUIzN4rH7WVfjQVv9HlSRFMIGvOjoZnYeYTVI5/B1yEH7Set
	98ph3lMwbgZsQGFxBhgQJuHrkOMPpn11azC5Gm9z7WHdk2S4Ric3KuQYfA7+XsgVW6O4Wa
	GFbXwjoEMzlRfCziKEUj66ZPSH/Ui18=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-uSvcOGFwPPqGRkmpsPv2-g-1; Tue, 21 Apr 2026 09:06:06 -0400
X-MC-Unique: uSvcOGFwPPqGRkmpsPv2-g-1
X-Mimecast-MFC-AGG-ID: uSvcOGFwPPqGRkmpsPv2-g_1776776765
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7757463eso2890489f8f.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 06:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776776765; x=1777381565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1rvnWiWbaVtbuakXF1GY3gyQym0BGWKhGhCncv/qMI=;
        b=Leu+mtXMq+tcR0oCEFhBjW7ysyIyzYFQ4QblyxYi2GJkXzNie7+sfdTiuK6xHwv1YU
         u3eu9vxlDcetTWw0REiVNQWbjZSKh1H9Pa9zZrpbjm6M8cuLUtcNw+NMFpNBbcVkS7/r
         NOSKL4ObJaqcWxKGxvc7KuyFFagCPJH9G7avb/bn3i1cgRbTwhbJSQvvFmy67jeBLspZ
         Pj+C3Axk49w31ObG+6fElRz8srBMv8OXZ/v5zZEULcnp8FKmDC+UsCV370SI+gF2EaKf
         6L/P6MrF6+7gPTOfv/PamnLgwa7hAw1rU+/2s/y40YvPIlRl93L9qddbWzNd/AQcRVi4
         OSrw==
X-Forwarded-Encrypted: i=1; AFNElJ+Oajn7gmzeCDohmCRZmI0vcH2+oLOR0XUjfkVgSw6WMIOyQaERN1kU1THNnfUBqaxyw+8myf/mcXOIsisArA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZA6uUiKv4CRKVlf8xmXCDc+yzivkjoVTP8vNFtzKvdgSRPj4Q
	pmkzKmABC75M7e1SB0RMGhivISWnoE4ivMkIYTDaZqHa8bmqwpvYuFkzXbdP2dwh3SHvxKpZs8b
	N2YsCppjr7dKJClSEak2Kxti6VA4z9KDaO+1lAuM78TLQvoVJcu2GdGhTpoHu+x1CCAdp
X-Gm-Gg: AeBDieumaz5eqybovqsKyfAO64Ew5mSRyy7rdJYlbGf7GgOgJ1htkb8oGg/ksuTiKih
	3szQMkBkuumnwY3AxTh883Zw29I+lvgX48Y0WVoMIx4hws7FSpIocsks4C7dMh0PeZDlZEwsoHa
	UDw5goEZaL/OQhMx4vcmANBedNg7hek+HjED4ZB4jcSWieREUtFqyEsO0ep9Hh7S/XrOQBZq7Hj
	6tVSYiCftmQHN3sFrO2gz34g2agVMku1oR1WDsNk0Y7Zw1gTHfzPdngztoqDgr/piR4JYkOqLfg
	77TmhgQksG2Fe/NFPf7fF0qUejMUkyC7ojcDjlP+pdOkJVaCGpPqXfJl489PbefqkXV5xm5WjcL
	Lvjmp38EOjsVwsBQ89mESwTQyAuRwWwWVQD4VCrgp5ZtYvusbNAmYCg==
X-Received: by 2002:a05:6000:2a0d:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43fe407df74mr18663589f8f.15.1776776764980;
        Tue, 21 Apr 2026 06:06:04 -0700 (PDT)
X-Received: by 2002:a05:6000:2a0d:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43fe407df74mr18663537f8f.15.1776776764395;
        Tue, 21 Apr 2026 06:06:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc26a3sm42414615f8f.15.2026.04.21.06.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:06:03 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:06:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH RFC v2 00/18] mm/virtio: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <20260421090341-mutt-send-email-mst@kernel.org>
References: <cover.1776689093.git.mst@redhat.com>
 <c199e47d-b2fd-42f3-9e50-c47c848dc72f@kernel.org>
 <20260420192037-mutt-send-email-mst@kernel.org>
 <aebjG-qMLr0joG61@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aebjG-qMLr0joG61@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LbFZF2dfyaLc4OdiaAvWxiVg9Gw6Oang55iR9ZiEoHE_1776776765
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2026 at 10:38:19PM -0400, Gregory Price wrote:
> On Mon, Apr 20, 2026 at 07:33:38PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Apr 20, 2026 at 08:20:57PM +0200, David Hildenbrand (Arm) wrote:
> > > On 4/20/26 14:51, Michael S. Tsirkin wrote:
> > 
> > > > A lot of churn, and my concern is, if we miss even one
> > > > place, silent, subtle data corruption will result and only
> > > > on some arches (x86 will be fine).
> > > 
> > > Which would *already* be the case of you use folio_alloc(GFP_ZERO)
> > > instead of magical vma_alloc_folio() + folio_zero_user().
> > > 
> > > I don't really see how vma_alloc_folio_hints() -- that also consumes the
> > > address -- is any better in that regard?
> > 
> > By itself, it is not. But the issue is propagating the address from
> > there all over mm. If we miss even one place - we get a subtle cache
> > corruption on non x86.
> > 
> 
> Why does it need to propogate?
> 
> Can we leave folio_zero_user() callers the same, but add a PG_zeroed
> check in folio_zero_user() that skips the zeroing (but not the cache
> flush) and clear the PG_zeroed bit?
> 
> Is this feasible?

I do not see how - this would require leaking the page flag out of the
buddy allocator.


> You don't eliminate the folio_zero_user(), but maybe we shouldn't?
> 
> (a bit naive here - i haven't checked the PG_zeroed lifetime, i did
>  see it overloads PG_private - so this might not be feasible)
> 
> > 
> > I also note that we need a flag for free in order to implement
> > balloon deflate as you asked. Here, I reused the hints.
> > 
> 
> I'd sooner just implement this as
> 
>    ___put_folio(folio, gfp_t)
> 
>    __put_folio(folio) { ___put_folio(folio, NULL); }
> 
> And change the free path to take overloaded gfp flags.
> Some of the existing ones might even be useful as-is.
> 
> It's essentially the same thing, but prevents a bunch of churn and
> saves us a new concept.
> 
> optional gfp flags on free seem like genuinely useful interface for
> certain callers (definitely not all).
> 
> ~Gregory

But we do not have a gfp_t flag meaning "this has been zeroed"
and when I proposed something similar in v1, David hated abusing
gfp flags for what is not an allocation property.


