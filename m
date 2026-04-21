Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988234321A
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790783; cv=none; b=ijpmQO2ilEBbG/kgGZ4ILUf/XtFZ0WEuiVsbXEOBDO4mw4UirW310x8WzKuc0sQVU8RFsSsTNiDBf+jOYg4EqrqvpdDTR+U9uqQwdNTwvAUIvb2p/74ObHGzp7ohbD2x+h/bbzqj4t6kaaVJBNtyKaOztqxmxeJs5AJje+uQU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790783; c=relaxed/simple;
	bh=wr52/3mYI2JPnWPtcPr63RV9bzNblLuMfeskzqToVu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=h5ZEoiSNzmWBgZD0ERRB8EKojUPESSl6cikizAfKkobbCdKWuYBEJU1yuZHJlb3QiyxB9TBKkvyU7K7ILxnx2Rwuzv4EwwPtyaFS/RCSTPo0T9DnXuYlqcCiDuo+R7K9wY87Tj99z3dqMnEXIjzXdgy5vKpcrveCyl+ypQ/si98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXDn6oMJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXDn6oMJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776790781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dc7z9eFec98ao+dc2Vh1ZPzSBnM7NHud5P8tRM1qhHs=;
	b=aXDn6oMJAiL8Z3mAB7IS8qpzjk7pfxd6Pj+9y5nOMEarwEyzGLkwIhIFEmEhC64TmflH11
	0aWe5PfnnuC6yHoE4shH938Tqdaaff3JjgadwMNVtwfo+hY/txylLDonR3C0/r9HfNgDIk
	YR045eQpRYdQmXbHtToD5bCJNjyOg0w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-rUp61eUtMRap_MNp_2Bg0Q-1; Tue, 21 Apr 2026 12:59:39 -0400
X-MC-Unique: rUp61eUtMRap_MNp_2Bg0Q-1
X-Mimecast-MFC-AGG-ID: rUp61eUtMRap_MNp_2Bg0Q_1776790777
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a55ecc32cso7365075e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 09:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790777; x=1777395577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dc7z9eFec98ao+dc2Vh1ZPzSBnM7NHud5P8tRM1qhHs=;
        b=kTOUaOkVjVaZJqO6xJSaj1kG/v+lHdDZxr55TltnEOjeNIVZ292WGqK9FUACfA+j+s
         eoNlO3bepF9IDZEe4VajCTLyLuSjAYic7Rv2BUPORul5F06JI9uPouR50BdrooA7wz/P
         Cj8bsykr3E40Gq9W3xc2Y2/iBgX980rZo3jnibFq7iZn3NOSzuo5/2yaIvSCuZQkSazO
         rXpZBMQwp5yjixgtzSQt5lTej1qLzxpinOA2k/4eAmbgrsqd5iwGqRu4oVpacIEuTkQk
         MU64KqUh8up8eHqakJACaydtBaSvao0gkIpf6qEeSDROemxRjyDp3R5N7Tcvt2V3VE3M
         l3Tg==
X-Forwarded-Encrypted: i=1; AFNElJ+TjTyxxSFC7VWezDO8T+rMnqfncK7rQFlTu8XA9lpIIwCchzsTqhS1EEAkZmkALa0Eg2rTB+M/gXxQLoo0eg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4sTU1LnWT6bUHy2CmxnNE/qtGMwfh9Jqh8mBiLN8IiGJOWikm
	xPLI9gU4iHcr3zhFt0N120Rlkf8DKEwyVaWf0IYJRofnvDBkvk6OtFaQ8qHXHpKgamEh8ezmHeB
	ScZ1qBF+jZSeym2KyejnzPtzKITpXaqp0tl+NHrGS2w0dJcjuGxOBCUNcq9syhZbeTpyA
X-Gm-Gg: AeBDieud6Jtl5arNkSDElONsTi4FHl7MvrWcPO76Wfjfpdl6XID0LBr05Yv6cLlEk2i
	eouuTASkvb8aCJOmTCZpT1tZD4O+WsjdwaOxC65Jz3mNBorlCULKY2wbn+nBygnrjMhjm45/Sin
	PTQAIzklRV4BdEQ79VoNU7f+kTa2svPRGK/bNZpSOcPSxJlDFRTHxFBP4c2t7Cd0fnIpJko31Vi
	mHgBIRJ5WLTPBs4gy9jX1fpvWPobA/sCp5blu9En+cDsrhvtJT1HV5GJohDjbRzu7qxQ+sT57pt
	n3QrfnLQKelz6u7fYLKWL7o0RG3cwQxjdMnRh6a14zFW+Cz3jRW7WrfG5jlaRdd7W1Iv9NZlTer
	90ImkjSlPLkOFhQ9yi8WY8bVqriKpHF0sPVQ6MCErjF/7mFhDdIqtdg==
X-Received: by 2002:a05:600c:1993:b0:489:e696:836f with SMTP id 5b1f17b1804b1-489e69686a7mr110733715e9.10.1776790776721;
        Tue, 21 Apr 2026 09:59:36 -0700 (PDT)
X-Received: by 2002:a05:600c:1993:b0:489:e696:836f with SMTP id 5b1f17b1804b1-489e69686a7mr110733065e9.10.1776790776231;
        Tue, 21 Apr 2026 09:59:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm350387875e9.12.2026.04.21.09.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:59:35 -0700 (PDT)
Date: Tue, 21 Apr 2026 12:59:32 -0400
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
Message-ID: <20260421125842-mutt-send-email-mst@kernel.org>
References: <cover.1776689093.git.mst@redhat.com>
 <c199e47d-b2fd-42f3-9e50-c47c848dc72f@kernel.org>
 <20260420192037-mutt-send-email-mst@kernel.org>
 <aebjG-qMLr0joG61@gourry-fedora-PF4VCD3F>
 <20260421090341-mutt-send-email-mst@kernel.org>
 <aeeq9MUrqL6f47Y-@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aeeq9MUrqL6f47Y-@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wh16fAY3bFGCgp7rjtx7fx7kyGE7N6-uNKyaRsIyCh4_1776790777
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2026 at 12:51:00PM -0400, Gregory Price wrote:
> On Tue, Apr 21, 2026 at 09:06:00AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Apr 20, 2026 at 10:38:19PM -0400, Gregory Price wrote:
> > > 
> > > Can we leave folio_zero_user() callers the same, but add a PG_zeroed
> > > check in folio_zero_user() that skips the zeroing (but not the cache
> > > flush) and clear the PG_zeroed bit?
> > > 
> > > Is this feasible?
> > 
> > I do not see how - this would require leaking the page flag out of the
> > buddy allocator.
> >
> 
> Right, but you're leaking that bit of information out one way or another
> - whether it's a page-flag or something else (pghint_t) you have the
> same lifecycle problems (when does it become invalidated? how long can
> it be trusted for?).
>
> I suppose at least with (pghint_t) the data (in theory) falls out of
> scope and doesn't live with the page - but guaranteed it just ends up
> polluting more and more interfaces.
> 
> I'm seeing why David's suggest to plumb __GFP_ZERO correctly makes
> sense, it's really the only feasible approach here that doesn't generate
> a staleness problem with whatever information you try to leak out.
> 
> ~Gregory

OK, v3 with that incoming.

