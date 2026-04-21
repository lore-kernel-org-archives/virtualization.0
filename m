Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D033624A5
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790265; cv=none; b=VhMH507vxX8ugNs8k0L8i8La0ZysUVlN2JiKHdJcHj0xnqvweAwcZSkFvvirh4FEkWNm7I8kHdpEpJvXkgehUeEgPZlbeZd7QHtQc8+DEazx1+8YnntRemNo0NcOOdPZbxBeGq2/yFbuLUE3CWH7qRFUXlG136gwKtwXN6cMJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790265; c=relaxed/simple;
	bh=nHbyyL+JwBHUFNdS4PC2FknmeNxS4dsJza3FacSs6cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6SjnJTntek75Hk+aH3YBeEx+Ms1PFEJ4TrIzzcgw9/LcY+i32bcW0unMfJ4JP7zqQZa5TFurHQsxVM1zauvlX5fkpVSeewz8OSt+2bIW7p+ujWqByPHv2jesMAeaXtylSE8KAcQrd11ZvyZtqVCy1lg8zeth2uevvdfVEa74zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=B/coaByF; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="B/coaByF"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d65f4073bfso599667985a.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776790263; x=1777395063; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kRy357BEYeRJOQyV21O6a1nlzehotRQ1w1skfD7cr0=;
        b=B/coaByFxAzR/J3ihWdctw/ZVDZjULLKp6FY/HzStTH4hmO727+pP0F8ZXY2BrAHeu
         g2U/N3pDCwZUpCCfUsP7qYr5flR1R02/w4qavyC/bdhHu/JQxF9es34QfA7n41nTNzhT
         yvTmm6Fc226YspV4ieyudVKakgE3Oe2LXp+cMKxloWq7HlDytq950GLtW83Nmswp80QP
         SEXCbVgcSxqFkYmxuan4BEoUsM1pX4h/aEvxEMu3Z26HnbC7oBXlLeW+o86YXi2I76a6
         OhjeWNu7LObEiq1a9tx+95BmU/dkAWiOoeQM1FQEsleKqOuJKuoSUPiZ4+nIRhmyCO5b
         0XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790263; x=1777395063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kRy357BEYeRJOQyV21O6a1nlzehotRQ1w1skfD7cr0=;
        b=eBtj8WvNcQT7xQOmOyvHMlrLqM5UrXG1HWj0w2YMSadvKXmCroknRd6l22m6K3hmx6
         1VhSrjlGi1saQSu7ep9Qr/ipCSqvGZwEyyiothfeapw2O3o9v2suZC7EHy0yqBJLX0i4
         VkGNIVF+11HFcaAvQRu3nQ31nOSG0HfH5r8KVkDAed5kWnr1Z0WXQ4iQIcVdNrZztuG9
         TSpH8BfU7bk5kYkRDy7mBi82ic+CYrIzvGXlBuUCyUNZY9/XrGhEZUd896PbLkzZ5opW
         cjtAkFtBCjXom+bmlBNyL8Z8YluYVI+QMOf2mgKvwIRv3IDZNyxLs7UwjF/gNN3O9Q0j
         0+Yg==
X-Forwarded-Encrypted: i=1; AFNElJ8o8IpdnYNQrY4wO2+FFrX0PU/xh8eIhTHpP11GYGtJxVzqNnkmp4vEpgCpIhegpqiLlpXTVjI4T1FCeEP4YA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyX2oXeZKQ4LinOKlny/jQzzuBoGTEV6NddnG08+hRTBJDbTAZZ
	WWrQKwXpY2naLRf787mDMwnZ0d4Zp5BhL5nD3aqBR2RxS7lL3huKYaOBFk56C4cIAWc=
X-Gm-Gg: AeBDietd1qK6Ot8tWK+pbPQ3y+aqA+U8nMdLYnhxUq5/xCVpc7EBoa703SasTjFHZOT
	RiyhgM0XZs+aJcIzX33fBA8HZ9lxXhOAKMlzaMECr68iQqvdVOtwOH9Tdj+f6F87TFsjUTO33bm
	2D86O+1SX8fTnVEz0cIi7FcYzt/3seN27hOIDFIO6kkUnR5kzoIBr62HTsPITP29Fqzd/EklelN
	e/G/w5VYW7QR3yeclBoDUAZO+8gp3TJx366HHV3EB2mFXlVcCnVSkV7hkfYeyrLPkF4UeWDaDz6
	ROag7GL6ZRXgu4H69cv+ctwzHywtHdZZziqbN3X86j0/3/HTqmouU7mBEDfo4AaQiU3ueTYJDB4
	cgh3vy8OQggwGaIPkqe5AHR7i+Yh4lozklVzNpJVGA39Mzoi+zwRd4zpJns6y/334jbaDSjdCUY
	1pAlCteELcgPZpHZ9YlGxOfbMqzDQ9/ClOtkrD+3puMBLEaCQGbsyavUl3DOBjYHxSfN8fV7/+Z
	9koSo58RcqFFRB9n8l6u/FtwkDKqGM=
X-Received: by 2002:a05:620a:40d2:b0:8c6:b247:4c with SMTP id af79cd13be357-8e78f059609mr2654868085a.2.1776790262990;
        Tue, 21 Apr 2026 09:51:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-246-228-50.washdc.fios.verizon.net. [71.246.228.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d93c2fffsm1070867785a.36.2026.04.21.09.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:51:02 -0700 (PDT)
Date: Tue, 21 Apr 2026 12:51:00 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Message-ID: <aeeq9MUrqL6f47Y-@gourry-fedora-PF4VCD3F>
References: <cover.1776689093.git.mst@redhat.com>
 <c199e47d-b2fd-42f3-9e50-c47c848dc72f@kernel.org>
 <20260420192037-mutt-send-email-mst@kernel.org>
 <aebjG-qMLr0joG61@gourry-fedora-PF4VCD3F>
 <20260421090341-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421090341-mutt-send-email-mst@kernel.org>

On Tue, Apr 21, 2026 at 09:06:00AM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 20, 2026 at 10:38:19PM -0400, Gregory Price wrote:
> > 
> > Can we leave folio_zero_user() callers the same, but add a PG_zeroed
> > check in folio_zero_user() that skips the zeroing (but not the cache
> > flush) and clear the PG_zeroed bit?
> > 
> > Is this feasible?
> 
> I do not see how - this would require leaking the page flag out of the
> buddy allocator.
>

Right, but you're leaking that bit of information out one way or another
- whether it's a page-flag or something else (pghint_t) you have the
same lifecycle problems (when does it become invalidated? how long can
it be trusted for?).

I suppose at least with (pghint_t) the data (in theory) falls out of
scope and doesn't live with the page - but guaranteed it just ends up
polluting more and more interfaces.

I'm seeing why David's suggest to plumb __GFP_ZERO correctly makes
sense, it's really the only feasible approach here that doesn't generate
a staleness problem with whatever information you try to leak out.

~Gregory
