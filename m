Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBD392C20
	for <virtualization@lists.linux.dev>; Thu, 16 Apr 2026 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329118; cv=none; b=bNnBpg1KyaLJPgNYwA5S3Njf6Fy/uFOTrH9wnk9myx7bZpVIVIbuWBC+7duZAg0FjqdnOfdNOWe8HtVK8gv1MrBSU79d0rVCdEk/4vwxbrvaZ3jVz7HXFYXbeIHlWSr895nw98XCTOZ/hLy0WkSkY7XAx86bsXcroTuQVt2pot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329118; c=relaxed/simple;
	bh=wbMWrulmEaXtn0IpH9RUnB3WRZ9O9lpS2QKVeNr8y7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aJAdwV15OT448ZpOxUTgSCWjvc4Eb/IxeGxb48RECeTA8GKUfQ9CAQBt5+HFePGFAvqoJWoZ2ILDftJEdiIZCG7Q4P/uvsOmQIwKZ+U5CWwdYjXSTwg5bdfZ3tfcKjC4ieN+pb844zqpUw1OWcl5xcXFWKBX42A2lH/zpnckpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfOx5pcc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfOx5pcc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776329115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/k5i8b178evugSrRqD2BM3wAHP5mDLkDXVGvrRPlfc=;
	b=FfOx5pccr+u7g3ykp0YUy3IpoQZVu2ehNR6hhPnZLgdfL/7dUx/BW3AqQ+mmRyCgPqleqa
	n2W+lblYKYBnqySR2sJ+u+p0ImkYbGEdtzFCJwA9JypotBepQR5hZ5C7THdYhfmb3KxkEo
	kAQfbiq51deF74IKFaG13oQ7q4pbcJc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-SRQ9xrw4OD6MXHiVUeOt-w-1; Thu, 16 Apr 2026 04:45:12 -0400
X-MC-Unique: SRQ9xrw4OD6MXHiVUeOt-w-1
X-Mimecast-MFC-AGG-ID: SRQ9xrw4OD6MXHiVUeOt-w_1776329111
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d744128b9so3488563f8f.0
        for <virtualization@lists.linux.dev>; Thu, 16 Apr 2026 01:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776329111; x=1776933911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/k5i8b178evugSrRqD2BM3wAHP5mDLkDXVGvrRPlfc=;
        b=gCUF9YR8wp7JxDJx7P0d8xyBMDBBg2AWfC0284gAeF4jOFN+3mlqfXGD0/tPJK4YO6
         z77mO3rQ2N8HCKorbT7o2IlBY1MYf3KV3wC4curfZWsr+LSGA9zrL8rEaPkamcsubYce
         ZPIwPpffw6wXYkL+TTkNuGGan1TZiXytIFaVnj52jcYWhm0tTQ+i+9yfHrlt5TWJPRrp
         4rkwSDy+V6vK2gjlw2veQ0Sbf/QwfTN4txMWpEmrS0PxMOdiLUMuDL+2KhlIoHu3nMd/
         cS7Ot5Sb9CCIZ+hTx6T0cgUQBjpejDlMLJLPrpRJcNfigcpHQm3fDvvIGl+GuWPVPNtn
         LUNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WaDapKdyRpoQ7esdRlw6VZC+bGl/YIJnmvlpJ80Zo8B50VC5Moz4ukaZ81MAgfTT7A8vctQPuGxaxQN1YnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxhFe1sM1BiKtbVtsg+LOLx4FeiqZrz1qYvjcdiV1+L103BMpL
	4wfR6PA0IW5UO2+8hbNmV6IiGU5gNtuxnbSpeBxwzufwyLRcr3ePmNWjyYjoWkKnaH6KN9UY60g
	QH4O5AD/UfNLJYrJqh9ReJL9FaAAQD3MP6shwO9OjFO317QnPP5EhYdnPPVLmKz6jpHeF
X-Gm-Gg: AeBDiet7S5GqRCQjh4CyM1CCx2ncvmz5HS3fRn3S6NUZwyPswmwXwchJjOUyoqGaL9f
	Exp6JuZHsAj+kyYcWZfbkeI48Psd8uYrL5e3Wc8+56htkq5sIOyFNfGox/h16SeERLOm2IrqbK/
	5po658ZUW5vtm6QUa0pl1429HZqYTfZGFtjiHkFEtnPiIwGTjZGHxbFm7m8UclblL0zNP84EYjI
	aWeBewQhjSFZpD/YhPnu986F/ii2LqTkB4SYxDuom0zRrjVyhRT0NjDJn7cZQiUmgoLa3D3rKxr
	iWhqM6u9EiHkbmCmgjw/KSE8tfO2rD0ZAL6LLsQUb0Rxul9V/ANCi6YsdV8Y6FFsnWrf8aso4dQ
	jdN23RxQ88r15TEPwu95KC++BNBAeJt/L5P9HagAqxk0=
X-Received: by 2002:a5d:5f53:0:b0:43d:242:b9bb with SMTP id ffacd0b85a97d-43d642711ffmr37714712f8f.18.1776329110881;
        Thu, 16 Apr 2026 01:45:10 -0700 (PDT)
X-Received: by 2002:a5d:5f53:0:b0:43d:242:b9bb with SMTP id ffacd0b85a97d-43d642711ffmr37714647f8f.18.1776329110312;
        Thu, 16 Apr 2026 01:45:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d65asm11893147f8f.4.2026.04.16.01.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 01:45:09 -0700 (PDT)
Date: Thu, 16 Apr 2026 04:45:06 -0400
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
Message-ID: <20260416022758-mutt-send-email-mst@kernel.org>
References: <cover.1776033471.git.mst@redhat.com>
 <b21b0ba353330f24b9e10ee5bf01b60f32043327.1776033771.git.mst@redhat.com>
 <b258160c-5287-43dd-b56e-268c403b85ea@kernel.org>
 <20260413163644-mutt-send-email-mst@kernel.org>
 <da935245-9c75-4cf4-8a42-2c6328bd93f9@kernel.org>
 <20260414062524-mutt-send-email-mst@kernel.org>
 <6fc307da-72b4-4d07-9e34-5e6c0563124c@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6fc307da-72b4-4d07-9e34-5e6c0563124c@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NaBfn3eHcnxSy0oJ60V-0Tp0PYlYivSPEuvGQfuQ0bI_1776329111
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2026 at 05:46:58PM +0200, David Hildenbrand (Arm) wrote:
> On 4/14/26 12:29, Michael S. Tsirkin wrote:
> > On Tue, Apr 14, 2026 at 11:04:04AM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/13/26 22:37, Michael S. Tsirkin wrote:
> >>>
> >>> I admit I only vaguely understand the core mm refactoring you are suggesting.
> >>>
> >>
> >> Oh, I was hoping claude would figure that out for you.
> > 
> > We figured it out together)
> 
> :)
> 
> [...]
> 
> > 
> > 
> > Pretty much what I did, except I felt it is better to change the
> > existing APIs. A bit more churn, but in return there's less of a chance
> > we forget to pass the user address.
> > 
> > Because, if we do, the result works fine on x86 but corrupts memory
> > on other arches.
> 
> Converting everything is probably cleaner long term, But there are many
> instances where we just don't really have an address, or the address is
> irrelevant, because we wouldn't care about the difference when zeroing.
> 
> vma_alloc_folio() is the API to use when we have a VMA + address.
> 
> But yeah, something that is harder to mess up would be nice.

Well ... I am making progress on this but it is very intrusive.

Are we sure we do not want simply this, just maybe renaming
the flags?



For example:
__GFP_PREZERO -> __GFP_ZERO_HINT   -  request a hint that the allocated page is zero

And an API hiding the fact that the hint is in page->private.



Hmm?




> -- 
> Cheers,
> 
> David

