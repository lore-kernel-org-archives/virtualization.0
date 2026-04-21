Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83AC1F151C
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779070; cv=none; b=hOXkS4cmMSVL0AY+xRt7/9CdZ88NSq+7Ia0vPhIHPTKOO0KaaYNv2koWuY5gcIVUkU3kim2k6wq3Tf/DinsMeGkocFqAtrB5XR8t7EiiYqateOX8hDKDoroPVvr3EwWtz8zr1Z3CzZpx0NRQvnwuJlfSD4uy1W2fkgzXaayi2YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779070; c=relaxed/simple;
	bh=3nKXHQhetipDN0ysN2eJ6ywPnlDZZjVs8c4yD24Ezp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ONEPuvPp2eu+ZHvnq0Y/KaYvPO86P5Ap7P8Yot7DWVtfDlUcjGTt3j4mKNgeYB0YJq99dQf3xSpvGb8B7HXNs+eFxtDmL/jHvWGBWV+AOL4nTTpKVUD1rxy/+GKQwEObOURW0q0SvxFCuVM7DOrHFFaVmxpQXncAFV/ZEB+vgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pszcy0YL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pszcy0YL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776779068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7eTbL6D9GOrwEMsjXolvuGX1Lg2q3QX/lZ1+KzGMn9M=;
	b=Pszcy0YLeULZa2st8t6fgN21AM56OEZo3qjzuRItSDnqlUejPdfUKHzw+zv4OBw8wdzZxK
	JvfjTUeGfazhYTZ4JidAwKHxkeIE4Xm+K0co7yK5ZguZPaMNlGRtqi0UgxrNeO19MQUqYz
	IXanY+JHQj8ReaatJTL8OBF6o6xaGNE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216--GRNu0AWMRW8Ou-gaPqIPw-1; Tue, 21 Apr 2026 09:44:24 -0400
X-MC-Unique: -GRNu0AWMRW8Ou-gaPqIPw-1
X-Mimecast-MFC-AGG-ID: -GRNu0AWMRW8Ou-gaPqIPw_1776779059
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d3eec9bcso27757595e9.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 06:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779058; x=1777383858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eTbL6D9GOrwEMsjXolvuGX1Lg2q3QX/lZ1+KzGMn9M=;
        b=lluHEJQVOp1q0gSnzg+QuNwkQVsudIJkV96ip/1V/SWoYc60uPKNVy/F+gTcLD6NtF
         /JSOkzKTTi4bLyVsaAWwxFha6rUGHQN8789OgO9ZKXk6V/4SZz6sUjcdM1dovXSUuNv0
         ymQtPcQ/2D5FECKlJrSOzn20O3yoNg3Ei7wkYjPdRYDDYMkhsjGq5tuEua/3Ykn/T6gX
         KK0sexci4L+UBLTj2h/YlSDv/WNtsn4YNyewfnt43OLYmiboISHa4ucTFfc32KlFRIiL
         liuFoM8IkX4Io4ruqE7Xi21im27uui7iLtE6xe8i5EgTJ+cP2tm0DeQm+TN9dNGDGkSC
         1FlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EwJOO1f9DQgDAGlXIqwJ7cXbmlURZ1MooskJvGuwX0W7Uhjvpb2LH3itdnmhG1RmfNZdx7cVAWmP4+HmRGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyjwg+H6h3or2c5YIVE/ML7J9+njqq4UPthn0OFPn3g5Ee3MLPJ
	0dqZ8QFmdD527V1RT4nb9weVZD9MvkMz+HyzDzdJ4oXWlED1dd2nz7e1Rn6RrUPopd0nkD2xSLx
	e9+VEEUZgxkjkwZJaBl/iaLFP5JzZ46XH9n6FjTWznaIclPkbhDih9p0DC6eQRG7y8+tt
X-Gm-Gg: AeBDievTC1XJmON+xlVnKgW1i8sQg0fOKC3EDFkE7kEfFUtWAD5a46o0wUDRpLkx3bn
	Oxde+pnIHAWlT0KY1UXqP8spM2oGKG5ghT6POhtwzle+gXjSLwfU0ic9ZTs29w6r4pNineJNg3u
	K+nEZDQdjtTRbFmcDVOH/QviWfPTbe1N8cC7u4hz37AeynMIX8znCYj0PMe929qGxk0yKXu3JSO
	OTcu7MaJm0JIpQo2zDWfVEptXmmW2Akgu0n2AOra33IQhIFPrTQzraLpou5NGKd/VdptqYWrSj+
	SPtdFhKIWBbhdiYfyn4qg7rK69J9Y4gJwQLk5qmKMJw+DMTCUK0fFDSPqUo+ZNvb1P4eVhV07MO
	KKqWx1GS2JWmEaXZbpdvMJSJpfp7aAidXs8987y1u19y2kcwZAyvuxA==
X-Received: by 2002:a05:600c:468c:b0:48a:56d5:16f2 with SMTP id 5b1f17b1804b1-48a56d5179amr32738435e9.7.1776779058398;
        Tue, 21 Apr 2026 06:44:18 -0700 (PDT)
X-Received: by 2002:a05:600c:468c:b0:48a:56d5:16f2 with SMTP id 5b1f17b1804b1-48a56d5179amr32737835e9.7.1776779057878;
        Tue, 21 Apr 2026 06:44:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7b2716sm117377525e9.30.2026.04.21.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:44:17 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:44:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH RFC v2 17/18] mm: add free_frozen_pages_hint and
 put_page_hint APIs
Message-ID: <20260421094049-mutt-send-email-mst@kernel.org>
References: <cover.1776689093.git.mst@redhat.com>
 <c7094de807c0e963526686e1d245bc76193b1a92.1776689093.git.mst@redhat.com>
 <5f76af6e-9818-42ea-a305-c0fc1d920dca@kernel.org>
 <20260421091546-mutt-send-email-mst@kernel.org>
 <2a41dd0c-7ad8-4d34-8bab-a713e16c3b29@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2a41dd0c-7ad8-4d34-8bab-a713e16c3b29@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ylvrsn_qw8ZSbkOq5_jP6nhPfv1JfPXo7jPC1YFnB2Y_1776779059
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2026 at 03:30:53PM +0200, David Hildenbrand (Arm) wrote:
> On 4/21/26 15:16, Michael S. Tsirkin wrote:
> > On Tue, Apr 21, 2026 at 12:56:00PM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/20/26 14:51, Michael S. Tsirkin wrote:
> >>> Add free_frozen_pages_hint(page, order, hints) to free a page
> >>> while marking it as pre-zeroed when PGHINT_ZEROED is set.
> >>> The PG_zeroed flag is set after __free_pages_prepare so it
> >>> survives on the free list.
> >>>
> >>> Add __folio_put_hint(), folio_put_hint(), and put_page_hint()
> >>> wrappers for the put_page path.
> >>
> >> Can we defer that change?
> > 
> > We can - it's a dependency of the balloon deflate, which you asked
> > me to implement. I'm more interested in reporting, myself.
> 
> Just to be clear, I said:
> 
> "I'd assume ordinary inflating+deflating of the balloon would also end
> up with pre-zeroed pages. We'd just need a (mm/balloon.c -specific)
> interface to tell the buddy that the pages are zeroed."
>
> So while I think there will be value in that in the futur once we
> figure out a clean interface, I don't recall asking you to implement that?


Right. you also said:

	Not blocking, but I don't want something that is too coupled to
	free-page reporting optimizations in the buddy. The comment above
	MAGIC_PAGE_ZEROED triggered my reaction.

so I interpreted this as meaning "it's nice to have (not blocking), but
you either need to implement this to demonstrate that indeed, it is not
too coupled, or prove in some other way that it is not too coupled".


> 
> -- 
> Cheers,
> 
> David

