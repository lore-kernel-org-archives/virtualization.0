Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A93D3CF0
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776728033; cv=none; b=u9iVmTgjdRzYD6cQEOdDze3Fxwi0LAV89X4poFKNDSA/hf9+PpmSIBqI3YpClRh2MybUJlG+ucMpQmm0r6053CMs4AXv2mWMrkNqwxKQVkVMQJKR8fL2o7mDC7cl3TJy4l6ZmhVYutzmP8MhigJh6h5eNPZw1NXo25B50FBbzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776728033; c=relaxed/simple;
	bh=yR2/wB5ZyxKUGr0AdiVEcbgQkku+GxQ+Y+qdUpCrdgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TLNIXNF9Wz95vQA/40VUtmjw7ea8oyw4WXuGnpMlykEFKviQN41/BeWyY2v45LTFC5wM4PiQO3s2tBLIo+9KFwCqX9uLZDP0ScsYwDu89GHs+LRaKRuA20WTHJ3mLR8jlp1AAkmGNmeZfuvqO2aBpPbGkFrRGTNVAs3m2d5a71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bktnQaJj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bktnQaJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776728030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Crl5IidACm0/Y50tYB/yaiHCDukvD9pxpf1tedSp32Q=;
	b=bktnQaJjfvJMMGdvs2DWGD9aPHhJhwouGrLDw/H/oWPP8ks5Cy+iJrfZ7N+eESueLRHqm/
	5TywfqPKsXeG9tdLt9aGsv/UO4xDufUSzLtnXhburlIvM4AukiuBLX1SdNtQmDvz/Yi8rW
	t4ihcvO5MNlvLjOgo16V/+JeuHkIJEc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-bBnRj34UPNC7Hh5VSQlQ0w-1; Mon, 20 Apr 2026 19:33:43 -0400
X-MC-Unique: bBnRj34UPNC7Hh5VSQlQ0w-1
X-Mimecast-MFC-AGG-ID: bBnRj34UPNC7Hh5VSQlQ0w_1776728022
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d744128b9so2989325f8f.0
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 16:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776728022; x=1777332822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Crl5IidACm0/Y50tYB/yaiHCDukvD9pxpf1tedSp32Q=;
        b=hWCAxEyDSg0F7lqpMKgJ2kOxW8BUqk3SpHlFh6DzSppFEvQjEoSc6mT6HInNzJpqRu
         sUqy4/z7Y96uFI7RX3f01z5r5lAeumn5td9KJQnOk77Xj0LKKNM7eWWk2aPmDGWmbIx3
         NDVGDx3KVS6n4uaIE+MhNGV/8KS51bPvepO5gQ4I7GHdzVE7osW/GHs1hTJrkZ4hzpqO
         zxlWWe9Av6xQTj4Gvl17GQ/OjK3RRiGochQ9OJENQFcketoJ75+b51T6YwgHfVd4SzQY
         fz5a8UDWYUFVB4WXIS/UaJ4AH6lLifXECEaN8NAy6agiZ+awQjaVwlhFQ1o5PSQxVumz
         FtjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FRpvCetXNfzcig6e8GljE02/5JCijqeIkYeLsZEOYk4xUuje6kIyg2KVYqPQafSI02MFjqYhA1kbqG6GjuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBLluA9aXsrMVNrk6ev0DnbGX0pSoOf7DImZ46bwt4kp4DdH7u
	NQGZSGVDBWPznjCrR7NSg8595UIWQ0HcIdFLQzFTsxOdLX87Yqo7NnmSJAnxBnYXlafXxOKLMqU
	6Ps6HyP2ylVoy/gqgDgckgAmuAguVH/xwV3r/g8c6DP9rAI/KBLjF3xPlMwK+H0ROt5NJ
X-Gm-Gg: AeBDietFgNIW6I2BeAdYvYVHKCjFPgNwO/Li30iRoM0jiotMn4aEoz1ql6XfJamEzRg
	g2kh5utsZ7j0AMIbvkIFfKbx+bLFSuod+m4csxmqCaHMtQR+DdSmqXT3JohZrO3TOgFh74Aitdx
	UFmPRwtbfZqwYRqXBllHiNebhMoE5mkzJJVay+OGA9ySKSok9uAx6elHp6UTBUL48DyzXKaaEwW
	B4p/VKJtZmWinbLSRPve/PhHCFJImzUkdLlwgDR6Rg7QotTRWYmoKN2QiipFkiXPi/hV3nYPMOF
	OVEdfj26ArLWLTKNjMNRU+Fnv8/SjcB+kY2upncg3FAK2WtB4ywsVwjrUNmdMMmHf+pNoHRkqpx
	42io7Zch9S7D0SFWiUTkwstGc24cetV9Fv1cvQ6hf3ZjgpChQsPPneA==
X-Received: by 2002:a05:600c:5294:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488fb73d53bmr206894915e9.4.1776728022104;
        Mon, 20 Apr 2026 16:33:42 -0700 (PDT)
X-Received: by 2002:a05:600c:5294:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488fb73d53bmr206894725e9.4.1776728021660;
        Mon, 20 Apr 2026 16:33:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc558f2sm191637225e9.1.2026.04.20.16.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 16:33:41 -0700 (PDT)
Date: Mon, 20 Apr 2026 19:33:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH RFC v2 00/18] mm/virtio: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <20260420192037-mutt-send-email-mst@kernel.org>
References: <cover.1776689093.git.mst@redhat.com>
 <c199e47d-b2fd-42f3-9e50-c47c848dc72f@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c199e47d-b2fd-42f3-9e50-c47c848dc72f@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nbyCKLm8xPrB2eWnuCenWpz7fmBq1NHh5PBTZOryjJY_1776728022
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2026 at 08:20:57PM +0200, David Hildenbrand (Arm) wrote:
> On 4/20/26 14:51, Michael S. Tsirkin wrote:
> > 
> 
> Hi!
> 
> > 
> > v2 - this is an attempt to address David Hildenbrand's comments:
> > overloading GFP and using page->private, support for
> > balloon deflate.
> > 
> > I hope this one is acceptable, API wise.
> > 
> > I also went ahead and implemented an alternative approach
> > that David suggested:
> > using GFP_ZERO to zero userspace pages.
> > The issue is simple: on some architectures, one has to know the
> > userspace fault address in order to flush the cache.
> > 
> > So, I had to propagate the fault address everywhere.
> 
> As I said, that might not be necessary. vma_alloc_folio() is the
> interface we mostly care about in that regard.
>

I'm not sure I follow what "might not be necessary". We need a fault
address so zeroing can be effective wrt cache. Since you asked that it's
done deep in post alloc hook, the address has to propagate all over mm.


> > A lot of churn, and my concern is, if we miss even one
> > place, silent, subtle data corruption will result and only
> > on some arches (x86 will be fine).
> 
> Which would *already* be the case of you use folio_alloc(GFP_ZERO)
> instead of magical vma_alloc_folio() + folio_zero_user().
> 
> I don't really see how vma_alloc_folio_hints() -- that also consumes the
> address -- is any better in that regard?

By itself, it is not. But the issue is propagating the address from
there all over mm. If we miss even one place - we get a subtle cache
corruption on non x86.



hints are exactly that - if we forget to set them, all that happens
is that we do an extra zeroing. That is all.

> When we just do the right thing with vma_alloc_folio(GFP_ZERO), at least
> vma_alloc_folio() users will not accidentally do the wrong thing by
> forgetting to use folio_zero_user().


Well, it's simply that
1. if you plain forget folio_zero_user you get non zero on all arches
2. we *already* have folio_zero_user in place




> > 
> > Still, you can view that approach here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git gfp_zero
> > 
> > David, if you still feel I should switch to that approach,
> > let me know. Personally, I'd rather keep that as a separate
> > project from this optimization.
> I'd prefer if we extend vma_alloc_folio() to just handle GFP_ZERO for us.

Pls take a look at that tree then. What do you think of that approach?
Better? If you want it in form of patches, I can post them
in private or on list.

Let me know, I don't have a problem with that approach - I tested
it and the performance is the same.  But the issue is that there's lot
of paths that have to propagate the fault address. It took me a while to
even find them all (assuming I found them all).


I also note that we need a flag for free in order to implement
balloon deflate as you asked. Here, I reused the hints.



> But let's hear other opinions first.
> 
> -- 
> Cheers,
> 
> David

