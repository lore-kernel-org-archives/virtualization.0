Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7953D3BE650
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489816; cv=none; b=NwlPHIorHfXq3/aNFJIfKT8u9BX7TMvVOUrz/f3gnAP7yyXDCQBYyl22uE88h7Kl1jYI878VXevRaXWR98Q6eitvFU1zBIecDgF3LoTRWfzGsm0cnX0eV185yoy7BQSCWULaEq52npXR4bCgKNQbX25FS0ZpQptM1o1m/1q4sn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489816; c=relaxed/simple;
	bh=YnD1FHiZXru8LRZM2pWajLsAH/hxpz4Ki53NfN5H2pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hMU/gfvRdHIbmwg/xPUYRaBN7wSMw+MVncnQb+qzSAocqiRkZtwj5+opb1Q8B5H2aSd+mUgC+kol2atDEk3nF5V3cxGsEEU3F2mU1Nw5rRAkArScFaER+E7eOaOS+vkA1JyKYw1FqgdLCPjouK0267wRWEkstIQ9L8cIjC0MSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ud/2BNUq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ud/2BNUq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnD1FHiZXru8LRZM2pWajLsAH/hxpz4Ki53NfN5H2pc=;
	b=Ud/2BNUqHDKuOciKsJabzLEgAaJ9uZJcYBVZW9GSIHOCljwLH8doDh+9z7T82KdT1ZPVg9
	sxVikpF/bBMYaP+c+Q95C5M48cF1BGqcwZmIo39x7I67vHqf+uPVcqMwZzCdJiZiDNlcXl
	6w6QP3qD37ssxdRUZwyQhCiIlQRkbjw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-t-YMSd1QMbKzbzNwSZUdsQ-1; Mon, 11 May 2026 04:56:53 -0400
X-MC-Unique: t-YMSd1QMbKzbzNwSZUdsQ-1
X-Mimecast-MFC-AGG-ID: t-YMSd1QMbKzbzNwSZUdsQ_1778489812
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43ff19e54beso2865569f8f.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489812; x=1779094612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnD1FHiZXru8LRZM2pWajLsAH/hxpz4Ki53NfN5H2pc=;
        b=Z3Eg/D2mnfMTP+YwEfBOBN0WXCeJR1HGiIiILkIgoC8hc2r+BoBYxRAazKXUlR3biF
         X81ADFbInbse0FwO2XWKy4Lo+9NkJDerd9iad/1MAQG9M1QL66W8W9gfmuk9QFnC/yDh
         A3PTd14rKAVhWwI2bQ7Na5ESYVUsGcEkVBsc5WhDPUHkbIeZGrALoHyDtMHih9Vqb5ic
         fIWTDc8NCgcSXC2+iFuepKP+sE2gQoLIxNDprtwDE2tiCKHI8qZnWp0h5eB3ICS/P0P7
         ncjeEZCd/p2AkHzmywjTgXDtXB1Q0AZaOOr105o1uJb74PCRZqvAyv8Jy/5XUkZrbdBm
         lN3g==
X-Forwarded-Encrypted: i=1; AFNElJ/NhDusE1L1h4y5e3BkGVtN6WigHRH+xM6NQsidboTs/bpchDrsg3YbLLVT30lFKmJv3R9J2ay6tYXrsIhRpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOT7G/AQFha/eVnxCCbA7nZkLOW8eMaJTQGBLnwHgS9Bvdai3E
	h47qfSV8MfKM2VhrV+f1pZ40oKSId3j03tFaMoDHBRS2don/iB59L0mRIz6jsq6tDuUu3IzXrqI
	gfW/4zTe59V3qP3heU0DtbbJyTLO+HG12jbdTRvRaKfHNn+xvaz0DK1tREul4SRuMAlED
X-Gm-Gg: Acq92OG4w2bzZSICcyAN70rzzemuq5rPClg32WsoTdQZI9sDuwmC5lgSfAkvoUkS38A
	t5rpPFplI9fjY0Nk3E+HUerj/coJL+wTrQ4Vgiglew8mmcrOXACMn/iVPP0gFELU31TMLIEUboN
	2jBooWy+1TnuMTYQWn626MU05xfA/FJXhLZH/32KqZRMqcV049GDM54hUcQqE86p7lAm+ZBN3HL
	eKJeLYJxoecaWSd6ZP5Tzpk1u6fCW0lj7HbN6+uj88Z7ijMZlNL/FGX/tZscuBSX7vLUbjO0LCW
	7+9xhAPEm/aZJh8sKP7JF0zOZ/nrQIWEJW8FFGurprqXc/NtEVokOMqalpc7eDY458v7d+8B4/m
	W7Lm7rcfTMGPluh+x7NlsgzwQO6gBb42130jUnJdR
X-Received: by 2002:a05:600c:8908:b0:48e:6275:27ec with SMTP id 5b1f17b1804b1-48e676b6393mr136866535e9.24.1778489811987;
        Mon, 11 May 2026 01:56:51 -0700 (PDT)
X-Received: by 2002:a05:600c:8908:b0:48e:6275:27ec with SMTP id 5b1f17b1804b1-48e676b6393mr136865715e9.24.1778489811408;
        Mon, 11 May 2026 01:56:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6daf496bsm82521785e9.4.2026.05.11.01.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:56:51 -0700 (PDT)
Date: Mon, 11 May 2026 04:56:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
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
	Gregory Price <gourry@gourry.net>,
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
Subject: Re: [PATCH v6 00/30] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <20260511045608-mutt-send-email-mst@kernel.org>
References: <cover.1778488966.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778488966.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8su5kzjK00WCLonf_H8wWIDyQ6V7Y2OLM7eIe1Phhzg_1778489812
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ugh. Had old and new files from git format-patches in the same dir. I
apologize. Pls ignore, will resend.

