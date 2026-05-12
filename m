Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C753D0BE5
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603721; cv=none; b=rbCg6NKNW/y/l1UbyQmgQrKADHU8afgtbKHOblmExFYiYABhcGL0B1ca7bBXuF1GYrNoFWX75oKS1zuUUMaMnY7nx9m0DdYaouiHwDZC9gOjiiJaYffV0ndBwFtf8knEsxLcXme62103T/9ZieG9SEI8Tv3/bOucKPAM7tP5fbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603721; c=relaxed/simple;
	bh=toIc/eGnHpz4oNmG4SoUoA8H0T58hi7Ie/JgIxH78hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oEV+mQYe5+orkbKQs7oY9lSuR3ebbTagLV3tYnyS4hDgHiqRiv37dwWLCtMwvSAttGOxfaEk78k9LJMOYUkM+shNN5cyltp61cM6jw7YvynYbzfnvOZBbHD7oK+uCb2N2NH3bIHfhdC1QBcgVvuBxvE5Projp63+7XPrqmwIaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUO6HLgg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUO6HLgg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778603717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fcCfUoqbPzi0QdWN4h/jl5Vlg/FOqMT66yAiEmc3y1Y=;
	b=jUO6HLggSTbaJ7vvRveIgwkFXyim6PjRlkAgP7wZHBhu1pKnNrsD2FPGIhjuUcVS/BiO81
	QQ21JOKoXbNRjCP6PG1pgi6JSvXWh/RTDB9GjNp7B4hfa8z1aVgc4Ur0ys0+lL/gdtHkBZ
	Mq52KEsEsP2I8VsbjZ468rEFKFK+QPY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-uX0VtkAWMe2LUtc2rA3YbA-1; Tue, 12 May 2026 12:35:16 -0400
X-MC-Unique: uX0VtkAWMe2LUtc2rA3YbA-1
X-Mimecast-MFC-AGG-ID: uX0VtkAWMe2LUtc2rA3YbA_1778603716
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8eb04352924so1108577885a.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 09:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778603716; x=1779208516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcCfUoqbPzi0QdWN4h/jl5Vlg/FOqMT66yAiEmc3y1Y=;
        b=gnWYxTSozk1zEZ8237EjrO6+jbkOkHr+F/olp3n+qUSULJEd7FTWsNsCxZO8VPK1J6
         HlvtlpTN3XNoZIKU2h8ce0q1FjWdvvGZGje/F9kXkU6yzk+Oo742wpF/EQVl5Dm2rYvX
         RxWSvfTDwrnbBUzaMog/gh9vss5RBH2grDTFy50/9+LFnj9aVYESt8y9V2+8sRjGQJdV
         56LdEDjvWMzaHwIbenUi5GpVWSeEhz0AZTgI8zOAC1IKMkyBovoLPTZxy7sHEyIX/m4t
         qEa0mJcnTgFox3J9kCZecZ2RKsQN6NVeMC9b59if/6aaV3FekMH0vUnfUjL4DuHh6vKs
         2fwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8tycg0VgS3oH96DQLjsZCdVZHu3leRYlVx6H+0V4MBRLewP/qPYHu8Bvh7HPfZ4h55T0bE2B/wG9p8Jfvzew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze4JybqWcQPGmh8k/e+hRXNnBovZp6ucSUGwvQFOArs6P2Lj/d
	duVyrrpOtRqHwSImh0J5nziu45PNpEqA44A7vcLux8XOryiXuDSoGoDnqsu9/UQ3Ub0bAQMpDCG
	WwlUaHkreQeu2sUFZNJUPlz07sQRnbMMXkUHeWsLtcHGaJzPZGqj4v4xKpFQexKX99+gx
X-Gm-Gg: Acq92OGf3/7e9QpDX1zqJQ8H4c3JR/PZBNHqk3apOeDquico1W+srmffXAArTN7cdit
	oMj+uXqiaP96BMBOCB3jn1TdRjUqrddLURLpLodHSXtE53qAepiWHFCwyLVN/5wLqzqUWKMednw
	4U+xdPdA1MUd8C6El8esA9oMN/Ojlp9CNx5obfsc2NiHGRi3FojpB29dBWsc86h0axBRjhYgp1a
	pfG0PwocAXb8qBht7v8wC/6PdZNpNkt9hHudS5B6uLgePcp/PULgmkh6TxEfbpIo1UXVjmYLB7p
	dVm58Ok/IO4lOqWENN/TNU0vcrL28Z2z8nOhHaZ2xahdq6sIaVcEMcNyXQy8NPFsQnF2WX3TswS
	Ddcb0MUrYIKEDZSwPhXotXQUbQYvZoMVDLEZVPupZ
X-Received: by 2002:a05:620a:bc8:b0:8f4:3895:25da with SMTP id af79cd13be357-90cfd3510fbmr518773585a.25.1778603715447;
        Tue, 12 May 2026 09:35:15 -0700 (PDT)
X-Received: by 2002:a05:620a:bc8:b0:8f4:3895:25da with SMTP id af79cd13be357-90cfd3510fbmr518761985a.25.1778603714550;
        Tue, 12 May 2026 09:35:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8e9b24asm1430902685a.18.2026.05.12.09.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:35:13 -0700 (PDT)
Date: Tue, 12 May 2026 12:35:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: Re: [PATCH resend v6 14/30] mm: hugetlb: use __GFP_ZERO and skip
 zeroing for zeroed pages
Message-ID: <20260512123246-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <fe1d24d4deafe0f5d1a9c51fcc040d9561c8592a.1778489843.git.mst@redhat.com>
 <agIFq63QZugkWcXJ@gourry-fedora-PF4VCD3F>
 <20260511174337-mutt-send-email-mst@kernel.org>
 <agKVIjvNwVajYwjz@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agKVIjvNwVajYwjz@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9dR_LOLKONdeklMxo1brGPBi7vikKpyjQ_4VrvG02Os_1778603716
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 10:49:06PM -0400, Gregory Price wrote:
> On Mon, May 11, 2026 at 05:47:48PM -0400, Michael S. Tsirkin wrote:
> > On Mon, May 11, 2026 at 12:36:59PM -0400, Gregory Price wrote:
> > > 
> > > This feels like a very odd pattern:
> > > 
> > >   1) ask for __GFP_ZERO
> > >   2) Have to check whether it was actually zeroed
> > > 
> > > Seems like the zeroing piece should just be sunk in if you're going to
> > > ask for __GFP_ZERO anyway.  And in that case, maybe just `bool zero` as
> > > an argument, rather than GFP (to avoid future overloading of flags).
> > > 
> > > ~Gregory
> > 
> > Heh. The reason is that it either allocates from buddy - using gfp flags
> > or from the pool, in which case it zeroes.
> > 
> > We could even avoid the bool - just test __GFP_ZERO inside
> > alloc_hugetlb_folio. Would that be better?
> > 
> 
> Hard to know until we see the full shape of things, but it seems
> reasonable if we can eliminate one or both new arguments that this would
> be a good thing and the logic should just be sunk into hugetlb.
> 
> ~Gregory


BTW it does mean we need to use vmf->real_address there as user_addr
as opposed to vmf->address which is HP aligned.
I guess I'll switch everyone to use real_address then, for consistency.


-- 
MST

