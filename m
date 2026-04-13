Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FC395DAA
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117980; cv=none; b=L6OaYaCwwBBdvU7g7+6wHPGz/U0XF/zuscnyYsVEvNqPPwrQ31IrI8gRvqGe79SVRtPrnabfVfIwyuhMAjuGb2NMdAWq3WqBzufwU/V1uMwCRXCtQhMswofICjh70DwG7O/FnTtTozExa5+w1LX4Xi3cMG+nUa02DrENcyUOELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117980; c=relaxed/simple;
	bh=DdgDRShweXjgZSgIzGzYFtkdi33XsXHHMEEIHYPBuRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TwsJf1zAQj4PrWTHgQ66sCKf3wRur7u7hM1bfV+PukrG2QZvGg9tVAoZHGhSMo2Lx5luBo/HShDF77WeGTUPZUv8ayTjbQjW91SZWpUarQ796v/1o+ho0ismE/4KhNlrwi7f2ulV6rR7zAZp6Bjd2v8HHehj/SK+Ua+L4/05UD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2P2lLxd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2P2lLxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776117977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfJQhARp+lP8r+vkCYvvsXWeLcc1Y6WmdUdr9tFdDHw=;
	b=G2P2lLxd9UK309SRVOocrZSAomeBUgWmahf7bGKKXDzbjN+SiBd800boMU0wXgyY2RyVvr
	u/487mrWA/zewhzs+RiSz813KdKpblacw3TWVZpEMCTTE2ruFwenyfyQeZquCcbCJqdO3s
	uqQAToxQiyX/5THG4za3TMhzY1Wb6Vs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-UFNN3J-hOBmO0a05U7rPcg-1; Mon, 13 Apr 2026 18:06:16 -0400
X-MC-Unique: UFNN3J-hOBmO0a05U7rPcg-1
X-Mimecast-MFC-AGG-ID: UFNN3J-hOBmO0a05U7rPcg_1776117975
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d70e3e4e7so1733748f8f.1
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 15:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776117975; x=1776722775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfJQhARp+lP8r+vkCYvvsXWeLcc1Y6WmdUdr9tFdDHw=;
        b=pjW2KcjRAAsiFP7uPQWsfPHFilZWvuU8g50KvwVLq+BIUdhPNSWVpBPIHcJL/ZCKBr
         tReSGaFZZS0bXpaKG3hcAqPuOcGIqtwWNJQJWiXY2jQfaUZeONCr1CLprgqgyH0+Xx22
         vco4G6jPTDj80VuuesR8rJtfU1R5LMT/HtT6IWeRfd72dkad3g6ApjUsNuHIcheq9z9Z
         LWDq1qYonsGscJN0d5JJzRUfQzwMDWUYZsjfie8AKRSpze+ZYtFo77GK3HAnVLGUn3ps
         TdBgtnt1mkKuFdeTrb/uj0E+l1N3C2EjZdgZ/jyeSLcz0J0S5RQifdTn6MoM4zo/s/Lg
         6NOQ==
X-Forwarded-Encrypted: i=1; AFNElJ832P2h29fCPD1HAJHAIP8syFt+PMBHKGFL9LteeBo7hDtZHYosdesi/WRpJ/MforMfvqKuFFbqk3mWuHk+8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzTYFoQNLS6HyIAksMrBMjd73ogIDYD6wdwYFoE7Rs7WiH7ZTN
	YT+/lUPMwE4OlSFUBsCRBAeyf7dwnJPokQ77ThnKFDXAkUHAiRJmbEVZ7anoZPCXEyxCMG3rm3g
	DwhWJ3AEIATJzRKjNPejt/acUoPGaC/6KsOImO4dIMDGMSETIMq9N+pZn+IbLVfP8et/R
X-Gm-Gg: AeBDiet410xpGYEmfXqJSM2wX1OIXqSvahL1qVWxdMa2XN+e8sBwp7NgFlj3B4czJf5
	WXeBhFI+89VgsdpXIUbsFWJENIwMpCR8WRaZq5UQ+mFvYwWlkmn2QSH4uDo0Rvm3kminrn+FAKR
	uzoVaqjp3uWldxCL7D4F6Mide4WGZbVHhIFydiGZOdl3pJUwXShJnEvXqyzRlqeblPXLr30Dl1C
	67FqmLXMlzAoJWF+9Ww24yHvS3+lDLYj+6iHl3G00thixujApig1NEIx6MjcbZqReSxYLS8towM
	ruuer0FvQ9GJiI69/pSRQCgGzsX2kF129dLuU1e2A+OAlxs4CukV6/jinIyjcPn6r0KN4UZ2RQT
	kY7/PyltiRXz4NJMxpfsZIMvikS4E99EzG8TPUWP8f+g=
X-Received: by 2002:a05:6000:26c8:b0:43d:77a8:3baa with SMTP id ffacd0b85a97d-43d77a83d14mr8700615f8f.3.1776117975072;
        Mon, 13 Apr 2026 15:06:15 -0700 (PDT)
X-Received: by 2002:a05:6000:26c8:b0:43d:77a8:3baa with SMTP id ffacd0b85a97d-43d77a83d14mr8700591f8f.3.1776117974630;
        Mon, 13 Apr 2026 15:06:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6a1203b8sm31868585f8f.16.2026.04.13.15.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 15:06:14 -0700 (PDT)
Date: Mon, 13 Apr 2026 18:06:10 -0400
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
Message-ID: <20260413180303-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: LIu0tgB8xEuVzBoNPFeU_fqChnGu8a3TlAo2wCA-2AM_1776117975
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 11:05:40AM +0200, David Hildenbrand (Arm) wrote:

...

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

I looked at this a bit, and I think the issue is that the buddy
allocator doesn't do the arch-specific cache handling.
So allocating it is a fundamentally different thing from GFP_ZERO which
is "zero a kernel address range".

So I don't get how you want to do it.

> 
> -- 
> Cheers,
> 
> David

