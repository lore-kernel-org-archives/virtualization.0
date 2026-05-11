Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD34D9901
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535688; cv=none; b=g0nCtwtHlEGk0lr1RNKDn9eM6PeeVlYRGhZ4kbURNHXUsfa1Jed2dBFUedrxNANxbVkYAkEeauqqrmRFUE/OjisBElLlX6ZzZ2fCWpapwuaSJJV5VmBf0Wd+rlJ4E7hsXyNo97078p7LrqodY/AiNSQkQpzRXZSTUyvciBJYtuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535688; c=relaxed/simple;
	bh=d2w5hCg9C06XCpW7ZBg3UcfYo1ya5VT3hUT2qYWW8eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ksm/BpfVU5Rqm718uGort2tQoTIqoogf5ATsmFJjbWyyJQXHWM+Lv3bH4qo79uwXBqApICJG/cUeSRKw7u7UfO28B302bFbESdJB8d1bH2H+m3pBOcr/6CyUkbMSTXCRwkxkNTnyLoGjur5pZu7c6773PaPlb1Yjof3+RjaUPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRdxYUY7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRdxYUY7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778535685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFdSw06KftojPC2tU8RauboriCWgGTE1Ndjj9VMw300=;
	b=RRdxYUY7pntluLtiaxt8MCS5T/Fh2r2xLvBMDhxkiMt3oQcJVyU5FV5rH/0Xs3AGNDeIGD
	raUMJ047bIedw5y8G//Tzwwo3v968JhI8x9fVuSDau96RjooDarOdH/R4bmsOcs02Hsz5o
	3mAYCmyyBH/oh8QCXdwz5lUphJfkAnI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-rHw6FhB5NX6XYTf4SoqyWw-1; Mon, 11 May 2026 17:41:24 -0400
X-MC-Unique: rHw6FhB5NX6XYTf4SoqyWw-1
X-Mimecast-MFC-AGG-ID: rHw6FhB5NX6XYTf4SoqyWw_1778535683
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e5df296aeso29720305e9.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 14:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535683; x=1779140483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFdSw06KftojPC2tU8RauboriCWgGTE1Ndjj9VMw300=;
        b=TpILE/lYV5jj524LQoKNnQWddDp6ClFQikRbXwcl8zThFVHp8Igobo8AOU00RYYVYF
         IYC3oFtH/TJAcblgnag/CJjf38Xdfv8ckrKu/+PVLwe2CwKqfx/71n63zMe3D+qeJE1z
         mC5sbPGNZw5+W08BxOtFqkr6EeU1RLBbS58fpvLqbDBExEPOO4QgWH1RuEEMxrGnAhF3
         6M4ZBPnfPhCGRKyBsNWpZRoUqdMQfQC+oXibh6o2qyBlj9bjlKBfP8GajRFO4Qmj55+A
         BxoVWxWo8a28ynM+/v/SJMtCqTYFMHGJ+KBq2TPJtZocG4ySUiW44SnIpULV7MLoUO30
         XzRg==
X-Forwarded-Encrypted: i=1; AFNElJ8hs20/6m1qtclSEb5/y+MWP1D6ii5aDg/PNhHSWq3F+izfuDT9vNlQ98Xk7zAEeLSR9inU0kzVBC/anFzMzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDuJaXYfJQYf5XnSLYUWrzcZawsL38E7YE3uWS1onV5cKLlZs2
	/K+k8mShaLWylZ1IeOQQmYN6Gdh62QgHCNhnneyubOT+8DcX0fXqqykh0iYiOwBv+ejKJLWpWI6
	NA43HkS8nJH0tm6OzeFwDBFb3bDdcVSyYl9RdXnF6SvK691yogaunZVhJR+P/uSf7xrp/
X-Gm-Gg: Acq92OFbEbORjLofY/42fpbc7G926YysvKY6a3J1NEb4vxGwj8wbHBClmzSar7oX9Vw
	FGr23TCVbhuxKIi1MXBc5tLkLaA08kS6Jf4iByieeO1Jd+R4/uvRfo0CFBL2DuugH4nBNAF5Pks
	ySPbSfu/fNWGZkWUbWln6qbO+9GkEEO+OQcRC9VhigpHKkR/mQOo8471tFg6yJsVD0fapEYiMg+
	3IBwJeEtVKw8TPl5WAd/1VbEUv64g6cGHVq+5wO8u4tL003PGtkaTpP6nkHgNbrk2MHt2jVaSeK
	lmdEjGCskb1o1duykq6CX1Dzkux4FhOC8l83eFKwu4JAf1x+82+m8Zjr58YqQV8biYqEjhl79Wf
	fx8fjQPSBKP0BWjPKAqa3fT7O2pAJiuYkQb2VSjF4
X-Received: by 2002:a05:600c:8706:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e8e207a4emr15649105e9.7.1778535683193;
        Mon, 11 May 2026 14:41:23 -0700 (PDT)
X-Received: by 2002:a05:600c:8706:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e8e207a4emr15648575e9.7.1778535682514;
        Mon, 11 May 2026 14:41:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9053420csm135965e9.4.2026.05.11.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:41:21 -0700 (PDT)
Date: Mon, 11 May 2026 17:41:16 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH resend v6 10/30] mm: alloc_swap_folio: pass raw fault
 address to vma_alloc_folio
Message-ID: <20260511174032-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <369a08b86f51572b2715a9ec577de27ea98000d3.1778489843.git.mst@redhat.com>
 <agH-PrpY269pyuJQ@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agH-PrpY269pyuJQ@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j1IlKPKXVTO49yd0H0G7WI4ZwVWsxSMl9h696hIuh3c_1778535683
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 12:05:18PM -0400, Gregory Price wrote:
> On Mon, May 11, 2026 at 05:02:39AM -0400, Michael S. Tsirkin wrote:
> > Same change as the previous patch but for alloc_swap_folio:
> > pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
> > 
> 
> Starting to seem like this should all just get squashed into once patch.
> 
> ~Gregory

I mean I was told the patches are too big and too hard to review.
It's just same, independent changes made in several places.
Does it matter if they are squashed or not?

