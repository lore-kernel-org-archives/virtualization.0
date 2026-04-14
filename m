Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65CE3EC2F3
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180996; cv=none; b=I9Vo16FQp+SSrS16AX+qFRYOYwo3LQWiIv3uEK28AjuAVunAGvfLCTWdcCtbmZdyU2y1B6jtcG+RmVzquS9CZMqJAPWFfNIQgePBg4Z+wjWLW6PQ2qz1GBYuf6GWsUKGMvXKb5+Qrp6BmnepTfRfEkdFjEOXQQ6P5LzcAhv7X+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180996; c=relaxed/simple;
	bh=3YmffK/0JQpT4iHMXS23MCacLAZDLQ6ATuKCcsnM4QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hdZUfS1F8raSe27T5sVwOMryrsAjJV8j+Th7ZXo6DYdGQFqNBtSMNvI+s80zDvcKEsKjp3XAicPGXYj+Rqk/Uv2ju8P4DCq04+atkStoflr5DD8FcEZcsmtXhbtwCnITyUddFI6w1PC30dNBFovDn5oDQl+kYcJed2SYnJbjjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaJE+oUK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaJE+oUK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776180992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVy8CJOeLfr9BmuAq30K7dxK50W2CgA+FeGYnkkdt84=;
	b=MaJE+oUKeI6g8VJmaOygBo+LG6vz0SkDximjKkDG9dlEE/P7YPc8T9fuaZxWWv2loZOBZG
	mL0PBzwvzrwRQlqO9Z+1CI0mywliUsav3u7okEJMuvMtIPFKPQflVvSH++EVTZqQyiwGke
	sOW+xnOIWsF2ov9RLVcGsq6exQ01PvY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-DQHr7VBsNe6LiYg3wrOuuw-1; Tue, 14 Apr 2026 11:36:31 -0400
X-MC-Unique: DQHr7VBsNe6LiYg3wrOuuw-1
X-Mimecast-MFC-AGG-ID: DQHr7VBsNe6LiYg3wrOuuw_1776180990
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c0120047so37606805e9.0
        for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 08:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180990; x=1776785790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVy8CJOeLfr9BmuAq30K7dxK50W2CgA+FeGYnkkdt84=;
        b=rDBe9D2GO8g2Yfpfa+NvfzE7Ryq7aE6D8zN9b0b6faa5JW2i43dGsNHBEXpTkDvN6M
         Vb2asGdfpdN5Wh7o3BUZvrdqaJEjXs62ex0Udn119Xx2JjtEYQie2Z+a9mVTn+2XN6AO
         C02zsCPcgI8soq2nqiYGqFpIwdzQRHn6pLkClo+V+qwEM6VPdzPRGaDXexyciOKQ7dZZ
         it7T8rJfguMTzE+27JN6RDOiuY/DTZtSVvY8hQSbuRffFfBiZ9HFsP+iaNeCh9Txl1oT
         UxwynQnui2ZVZMpUa9EQyBYXp7sU1CyZ+xeGzQt+IrrKsrDWabpA73bzBJ4DBal5SA93
         MGJw==
X-Forwarded-Encrypted: i=1; AFNElJ8GrJMwnAz5rx3jCh2ScJKyOHeaBVIGBGq5cuJxXUWdprJEqdB4JqDCWQcCROqr3JZueB9AO4DyIuWTH+lXRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEnUEwMehHZvGrmm9GZCMqfDE0BvzYz7jRho2XRk4BhKpi9HjI
	D1ADtyhcFG0FrGxIXM0NWh6GRzxOBv1m6qjerH4YtmVlKXBIDMbxTbypc9Vr4iKYeIPvC9S8dcJ
	5mSbxnmjKHRNjZA5I2zGHk7Yco65237w9/wnkNXayt7xUmmJ+synn3FzXOOd0lcKM8xOB
X-Gm-Gg: AeBDievEP/KmClyBh0qrtfZx9tczDfslDad0++WGoaI03lFgjbFDDuIFvbEzOd4gkd1
	q/kQHHwSsxMBY7xiRz11blz7hdFxq5Zklxa0V0y86CD6ZYyRlUjQ4d+tCV7WjhcdkHZJPy0AW6C
	yDH+yqvrAcWbvMniI1JJ5JEetK1e0hqw9ingarm5LcP12wvyolgXGB0vlMAsg8UcJagsl8I+o8k
	hC6+rd2gPrrg09v4zoB6GRCr9Pd6MIkW/aFl6bfwtPyjreUUDxcyENYJKGn40RZV6vNBF7rBkmu
	YNa9lG/3GHp4rgYPuPHIFiRdxNUi223D4fpv7o3nch6kECWzi6kXK++Ho0KaDsZkNXWfAfXdpzD
	0UDsGa/Q7H7K55HRNwsCK2pGirePoumJfp+6iwuQ0kIk=
X-Received: by 2002:a05:600c:a109:b0:488:af7f:7751 with SMTP id 5b1f17b1804b1-488d6836508mr175214385e9.15.1776180989938;
        Tue, 14 Apr 2026 08:36:29 -0700 (PDT)
X-Received: by 2002:a05:600c:a109:b0:488:af7f:7751 with SMTP id 5b1f17b1804b1-488d6836508mr175213895e9.15.1776180989419;
        Tue, 14 Apr 2026 08:36:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e826sm119796545e9.6.2026.04.14.08.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:36:28 -0700 (PDT)
Date: Tue, 14 Apr 2026 11:36:25 -0400
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
Message-ID: <20260414113505-mutt-send-email-mst@kernel.org>
References: <cover.1776033471.git.mst@redhat.com>
 <ea67e39bc3aea1b0b491908f851ffce25154cd26.1776033771.git.mst@redhat.com>
 <2155527a-e077-4b71-80ee-d735f9984f60@kernel.org>
 <20260413163233-mutt-send-email-mst@kernel.org>
 <244c9779-b4a5-4d0f-9eb9-ef0ec873e0f6@kernel.org>
 <20260414062015-mutt-send-email-mst@kernel.org>
 <8900872f-39e1-44ab-8440-e91ce3f0523a@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8900872f-39e1-44ab-8440-e91ce3f0523a@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4oWpm4cNdQ3tmTHOLNEqiPoDltLZd0Z9qqLkVoLkqm0_1776180990
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2026 at 05:32:16PM +0200, David Hildenbrand (Arm) wrote:
> On 4/14/26 12:22, Michael S. Tsirkin wrote:
> > On Tue, Apr 14, 2026 at 11:18:02AM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/13/26 22:35, Michael S. Tsirkin wrote:
> >>>
> >>>
> >>> So here's an only alternative I see: a page flag for when page is in
> >>> buddy and a new "prezero" bool that we have to propagate everywhere
> >>> else. This is a patch on top. More elegant? Please tell me if you prefer that.
> >>> If yes I will squash it into the appropriate patches.
> >>
> >> I'd be interesting to know how this would look without the GFP flag,
> >> when we don't have to leak any of this out of the buddy.
> >>
> >> -- 
> >> Cheers,
> >>
> >> David
> > 
> > But the zeroing takes place outside of the buddy now, it's more
> > "reporting" than "leaking".
> 
> Exposing some buddy internals using questionable GFP flags, however you
> want to call that hack ;)
> 
> > 
> > You mean, moving the zeroing into buddy?
> 
> Yes. Such that it doesn't really matter how we maintain this information
> internally. A page flag is probably still nicer for that purpose.


OK, sure. Let me just finish testing, and I will post.

-- 
MST

