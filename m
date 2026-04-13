Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADDD394464
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112648; cv=none; b=cj7DxjYiexxXwGOHxYl3nqYAM0+1Fe/+BkdwN7mcGbWfjod9oMjVAQeqRKSgzHyBkxJVx7MhrGu7stgyFBbB8PYMEIgoioBEwlZeP2akKkeOtzTCkydpy4NodUKmGy/BE8STLhrWgTwchGJiok5IpNtXlgfAcT8cZizsLZYSFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112648; c=relaxed/simple;
	bh=3UOTDcLdkNpvNQuTboJmVRuKOVO/Ckh+7yVmvV9A5Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VhfyzGtbC3SxXkhE7ONmWrA+/3hK2QH9+3q6QsvhZp/c5JFHc2LS4VLl8ntXEvTyOiFHxn2sboEOh4U3ZCXN1+eNK6JNu3t4xCu3XPDxPsJ6wCz+LELeK/7Lknl6LjsEZM2VimOkq0SUL3zPOOFzcztcKrfQKwM8ag0bbY7StR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALw5sTnQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALw5sTnQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776112646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x+jn9tzh7nhmbt6+qjsG4Y4k6+ZRmcZ6RnPQ8R+vTBg=;
	b=ALw5sTnQdoqAdF/wpCLGxP9wlqfchag8mgrV8Ee5CALFvOxpRGc0o3lHhLWyvfr88Qh2wp
	9jG60kaGr9izzjINuD0fFnwiI0kDaahVUbyLP9mqqZ1o/lToSaVyy1bUUyXtJwCUfx8z5n
	VvU6x71NYsy24qu6RUGynttKCIBJL3g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-q4diLBm_OuyArDgnj3KmmA-1; Mon, 13 Apr 2026 16:37:25 -0400
X-MC-Unique: q4diLBm_OuyArDgnj3KmmA-1
X-Mimecast-MFC-AGG-ID: q4diLBm_OuyArDgnj3KmmA_1776112644
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7757463eso703214f8f.0
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 13:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776112644; x=1776717444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+jn9tzh7nhmbt6+qjsG4Y4k6+ZRmcZ6RnPQ8R+vTBg=;
        b=olnMmhAGpMVFq6PDkX2kP0eyZFJQjOxIVkXVc5Z2Wpv3Fv7VsfTxUxdZvR/0pA2SsW
         a5HIt8pwpTED0WaseJqjEnohbbY+UKruB894KRbvIgqhNPuBdiLv334QrFe6AwI6gfC2
         8isI91msA+eZyPyG/w2BkzDoxIXegmwsLXYyKqtpsPZGGhwPFll12w6VIqb/q+oE3wQi
         d3J5fuVNJvX1ZCa6ybmREmJzNl7TeO5qpcX1mXNxBnzNtPw+Y57mw0eWxOde/R4vfue2
         o+QSriNAfZ+eT5TLuWRt9MTYDBT3l25XS8POLncaKHEmGssjfKrd7dN1DCVv7l4tgdB2
         bw4g==
X-Forwarded-Encrypted: i=1; AFNElJ+gZXQg5Xswqe4VzgVZ9uRtiaLGCXWWR9GiP0tB7TklnykMjlpsbshtvnlz8zEmlxQ0nER6hRqpjE3cXCDJaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyYJ5Vysbfcfi1O/KOa9a1VY4h77wjGt7bt5q9JRr7HGAXFzFK
	lbkFrjZAWUiq7cZ77BkkSst4pnO+b7rwP3s6zLoklZRV2hXvI9r3wWQzQmrUqNv8tvw4Et1Fo99
	ABYcCu7fin3ByNncMMbjpuLAtEDtxR/ktDF2qsq3hDfyO8B/CInqDClthB/tr4YF2TV5S
X-Gm-Gg: AeBDieu4ZSC5hPijFZZ08SCa7UaUYwC8ye3e+WiSEOWP7DdcCiwHF8A5DiQl5XC9syg
	mTrPWDuHSo3iuUTLId6vDp9ksugnIci5tpmpJSxYHysNG172YbdrKW2fSKLwGTyd4DmSWtsZ71D
	h2y9KUbeySymKtHQS82RQ+GMeGhYPG7mJiwQISpu4yRsO1Tes+TWZOi6CqfWD73jEx1+NAD80zm
	9b4PziHUJBzn6tWS+OkKqLHqfUDdacqVW/I4C7w1AAxrDcpH9ZjNAnygLViUEsWempyRFLGpNy/
	3zQIx/KQqirLgvtg12wVFZCOy1VBx+bZ0Ltp4mzyBimhkkcAPlhpyr39cawuaEXX6B7GvTmehOC
	yqyBoYeBu6Zlhg3vFL0499kDXiE4xu2w54OjmGk3KS04=
X-Received: by 2002:a5d:5f44:0:b0:43c:f926:1fa with SMTP id ffacd0b85a97d-43d594ad27fmr26223981f8f.0.1776112643657;
        Mon, 13 Apr 2026 13:37:23 -0700 (PDT)
X-Received: by 2002:a5d:5f44:0:b0:43c:f926:1fa with SMTP id ffacd0b85a97d-43d594ad27fmr26223952f8f.0.1776112643201;
        Mon, 13 Apr 2026 13:37:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ea5f26274sm283900f8f.1.2026.04.13.13.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 13:37:22 -0700 (PDT)
Date: Mon, 13 Apr 2026 16:37:19 -0400
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
Message-ID: <20260413163644-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: 413Cz8GQuwvhbowLmUrNEhMhVXQrkVYB0LoDqazyVic_1776112644
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
> 
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
> 
> -- 
> Cheers,
> 
> David

I admit I only vaguely understand the core mm refactoring you are suggesting.

-- 
MST

