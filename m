Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE8392C3D
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714960; cv=none; b=HkXd0mERSUZc3wBNcJr8+K4gYQxbzIKdoVaxNGBsHdCBtq19xCbBzG0/fW6iHJppuOT318p1el8Fq+xFIrqzuAXOVfksFbIeC8qJOo5RkAd1KkFEtcMLEALJwc/OEiTPmKVBbTPiMojHVH189jSlRvsJQEPBvIYZMk0BICnCgXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714960; c=relaxed/simple;
	bh=epeYZJKmJEyEKFK4D/WW8l8OB0uwtne8cu+lAHSRqXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SbLpxiZ0evwRp5cmTnOaeMSzFVfkMaE/96XM0otRIc3bLXVjICKXvrJmxF0Z6eJPvaeQIC9YIZ1GlgOkMVh6BiDchB17ZTsRInza213IGQBu/HgBJ+6exKBU790Z5MOv4IGIAkmynjJYviqVuCQ6RvYGyMdnJ36Mr2SblSFepv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ephJ37MO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ephJ37MO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778714958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izvY07KqS+wf5+fN6802J9TRTtuhLJpx997g9sZkIas=;
	b=ephJ37MOXlflLCJdNeO0M+4A7r0qyj5SsjDuimd+uc3gkVDvkDjZ35bj2828tg+nWIp4qP
	EvtqObbxdPj/U7ZwXktmlgf7+1x+QtcOLstFlSU9s8S6kHqdhdNORK+OiEPwbU+0opUo+o
	WLiAbqHkE4ZcVMVxTKOuddDELit7Ezc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-lkoVI1pSN8yt9MlPuZV7bw-1; Wed, 13 May 2026 19:29:17 -0400
X-MC-Unique: lkoVI1pSN8yt9MlPuZV7bw-1
X-Mimecast-MFC-AGG-ID: lkoVI1pSN8yt9MlPuZV7bw_1778714956
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44d9ace59efso4869732f8f.1
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 16:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778714956; x=1779319756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izvY07KqS+wf5+fN6802J9TRTtuhLJpx997g9sZkIas=;
        b=tXEfFt8R+SHlA+FMNnCSXfvwamXWWPlf5upa0jILTBjwn8vnqAUUqn/ryCHuHVdNf9
         7a47ot8QnWBcXGIDfWjHcz/prEjn2PRjFOAgQEFrb/la3eURg3e6fnFgxkY6yerkV4tz
         t0gIFuYNiIeXTG9G2+2ZwKV2f2aVa09YptlGAwO60FfEuITSVGku6UjFqHpM/3qTOCc3
         JP5/mnZ8VTcv97Nj0gt2az5OONjlH1VSbxcUP8IJ6O9/tsU1KwcLi8dd3SgN0mf0Swzn
         5Zws4aRruTypBaaxV8JuKxhxhhnLuebslcNgRGNQvQpt1zIb6GNkFNpACxdo0qt90gSJ
         tamg==
X-Forwarded-Encrypted: i=1; AFNElJ90Q5I1PPOY/ArL5RW60hPUWF17AQZ6p4pw4QKumNPGF3gml7MNuT+5C0g7gUcuEfj03xRtbKACryIIRC/UKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxfQd+3tVZ/sfjPhy/Bbnsv1SkjGuGqrE9vzKL58nx+QTm6KtP
	vneEF7cYoqRJ5sztBUdIQJ0CHcCnaESHHX//eEb5PvnpHRACeFD05HAA/dD7/ojMNgVsZ10Yel3
	QpVDMhe4JTATLNVHYPM6oPeJ0PI8eM5Tmwzsrzvq2EhMcSMejbBCtJ8B1xdCcAVutgrKf
X-Gm-Gg: Acq92OH0Ow2yNOnfc3Z+bGJ7souOOzktmwKC+mdbeUEoRSjJHhdaWU6ZikpdCtK9fdX
	x4T8UDW3HqFMbzyzX5fPXVEW9fJ4Nh2PaMCw9QyDR/nTeVkZSm5kfU8wgQfZbmG4AF1O/Qbk+e6
	JUG6QFP2VvcJlJq2NLCaM6hUx8YGk19eX3GY5b100Hiv25ZacDwumUy5tSs7L5GnNtooAbdG0JJ
	yanF2lVs4BMuS7zsITH85KWNNIejRmNTPIrsuun8oueBiqGZZlMun3IxQ12PeJUvK9My26MaObx
	vDK/DXK3eUonuNgARVcHlOwdAclTNQajJ8y7sMNw16jnmVIddmuwSsY7mR3xexg23fBhT/xQyAX
	FuXRW8bu5iEotQufCANHZYRl3xld3qYXTMUYrE7Bbh1WN9chdKes=
X-Received: by 2002:a5d:5d87:0:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-45c59cce4demr8601859f8f.37.1778714955722;
        Wed, 13 May 2026 16:29:15 -0700 (PDT)
X-Received: by 2002:a5d:5d87:0:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-45c59cce4demr8601791f8f.37.1778714955170;
        Wed, 13 May 2026 16:29:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2ffdfsm2070342f8f.15.2026.05.13.16.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:29:14 -0700 (PDT)
Date: Wed, 13 May 2026 19:29:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v7 00/31] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <20260513192734-mutt-send-email-mst@kernel.org>
References: <cover.1778616612.git.mst@redhat.com>
 <e7e9b30f-ee5c-44c4-b377-d70156be41e9@kernel.org>
 <agSoDnbk5rjx9yM1@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agSoDnbk5rjx9yM1@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F6UON01emCNm8ayBUagcnFxUIaohnOPabVHbdDHo4mc_1778714956
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2026 at 12:34:22PM -0400, Gregory Price wrote:
> On Wed, May 13, 2026 at 09:36:06AM +0200, David Hildenbrand (Arm) wrote:
> > 
> > Please wait at least a week before sending out new versions of this size.
> > 
> > It's just a lot of noise in people's inbox, and as raised, a lot of people won't
> > manage to review this before next month.
> > 
> 
> Also I wasn't even done reviewing what you had previously sent lol.

Sorry thought you were.

> I can only spare so much time each week on upstream patch review :]


You certainly invested more than a fair share on this one, thanks a lot!

> (This is also the pot calling the kettle black, I am guilty of doing
>  this same thing so uh... lesson learned, sorry David and Andrew!)
> 
> ~Gregory

Ya I clearly overdid it. I'll wait at least a week. Thanks!

-- 
MST

