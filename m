Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB144CF37
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626549; cv=none; b=aHSr+yj7H/j2mHcN1D8k7PFlmew8RZ09Y+Fp4c5goqc2kIHf6GW2CSNenHKXpTxaWxMUozY6LUDr2bCA0phbrAoXRqlZ6zqkatfwhaY35JWUaQ5OVU9VcLcGTYe5el5SDgMAvKTR9+2kTjmf30mCistiL4m8+axXw9BwwQMtMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626549; c=relaxed/simple;
	bh=iotUnWlrROsEXrmuh+QGUeOVuB3IIDZCIBhPsOGeivI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mPgaq4/xrNLE1RmwgkzNWPjnAu7ejTwZDd87uZ6BKMuzcCjEsQk1RRZA42/Ea+0iV3lV1n0FTHLJMgz3/EHF3USyNTUcDa7moDV5f8aKCYn8/zfyyd04yCTWpZOfPaU++2gw6FBK8uN8DDM/Bp1Thms/LjsXyZ/10iSD2nbRXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpIqh20q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpIqh20q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781626547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fSQ34ivI/Ck5Jq+TGrrZE0Mw5Nd/Xw5eBhLGnI6+rzY=;
	b=WpIqh20qn+ljtVbbaEHC0p7HeQ8wd/vMEWnITOIt0jfRgN0txLILf2eEMSZnN7X+9K9Izb
	WKvyEm2sETa4JDl5rDk2e0m7STbBobp2DN6fMDb867O+tpmQzLX7raUjUY3k3EYNucPDgG
	6hXyGwm5NZLvf0fFIK8ls5y8nOnRoAU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-_7FJdarYNvizqGJEwYx6tg-1; Tue, 16 Jun 2026 12:15:46 -0400
X-MC-Unique: _7FJdarYNvizqGJEwYx6tg-1
X-Mimecast-MFC-AGG-ID: _7FJdarYNvizqGJEwYx6tg_1781626545
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45f3d008865so27922f8f.0
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 09:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626545; x=1782231345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSQ34ivI/Ck5Jq+TGrrZE0Mw5Nd/Xw5eBhLGnI6+rzY=;
        b=c9VAeTIevu/cIUI/jfvT4R7KcmP2OjDiMh68jNrDJxe18F71t4gtnzMJuBEbtfwWQ+
         3SzjJ5os69GvfTadDJP8HXH/G8QaNyEnC3LpCvvyDNfwfSOI8mls2eGyEUZZbSA3r6BY
         I7fIbeptIV/gt3HhIiqKchL2S+esxRPEiw0h3iwM7xgZ6Vx+wQG8e5eopI7e0t2eYevp
         u2FTYP1tK/QvtSdiVbb60ASCrydGvU8+W0O/0rOhhEBGOvDWC49kUrrlm+ofqKIYq1RP
         YRfxAnrOPSSFP+6IbVY1+D85HCde8Q1FueskXaC5nnjHpqO2LxjnCjYbMCREoLOCRqsE
         vgDg==
X-Forwarded-Encrypted: i=1; AFNElJ94JXagweTvwpomcx/W+1kfJ9T15qC9A3GjaC8RUTRzC/bIyZW1tXPuhaG6XZf9OVINGSTTDO022V2L25N4OA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxX5wc3qSV6kdChE3kVHTXxkS186JUOwthN3MSQsL9nXCQ+g6G
	9lZ96x3EURXbU2NFVfplCYuGrcGgmm9rVV3fOkj6xPIpdmGCEoLGXAJWB+taAe7d3ZI2u7q4xbk
	fp9RxKpV6rZsKutDKbgJjnI/AFBrLAUF6RIDUSO2iFX/LdV/nAI9C3otdZTlGk+mpzFSz
X-Gm-Gg: Acq92OEtv8HSp0OfEZLvVJpWNCWBmosoBXa8UJi43OhNlhCShs9cXTb7o4miuoyifz2
	aSTTx8TKPvTRcn2wTbcq5UWyPzXZrkSwyh5P5UJ5lPjZxldEXxMPO4G7zH59Law0U/kmZ49niYM
	Y3dp8FjfHwWnET/Xc6TQI4UDr2n7+MHiPgJSLQRrZujT6SJEUsArqrzh0ji/f7QSN/WrtIr/lDx
	R9eba0gwJxImvyALagJ5jaNYpPE04FosCuRx5s5r8ujHy504V/FzdD/xbC9enZl5McUjHvF1KB+
	AHRcsLy8j7AxS1ofAMcghOJr8yJys9U5pcmkd7e9t9xuZ2MECtDaVExJTOy7o5j2np3t3oHpRg/
	qwUzFTG8gxLs7tkGdk/+tbwCh5Al3oSYt8OgxsVliXNk=
X-Received: by 2002:a5d:6b10:0:b0:455:51cf:9f92 with SMTP id ffacd0b85a97d-4622d7072b7mr429172f8f.18.1781626544605;
        Tue, 16 Jun 2026 09:15:44 -0700 (PDT)
X-Received: by 2002:a5d:6b10:0:b0:455:51cf:9f92 with SMTP id ffacd0b85a97d-4622d7072b7mr429076f8f.18.1781626544025;
        Tue, 16 Jun 2026 09:15:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d70sm46116268f8f.19.2026.06.16.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:15:43 -0700 (PDT)
Date: Tue, 16 Jun 2026 12:15:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: Re: [PATCH splitout] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Message-ID: <20260616120114-mutt-send-email-mst@kernel.org>
References: <dd8d89be-9c73-8ff7-7d44-9705bddeda4d@huawei.com>
 <20260610171646-mutt-send-email-mst@kernel.org>
 <14537566-94d9-eac5-2636-35f925a9d159@huawei.com>
 <20260611013644-mutt-send-email-mst@kernel.org>
 <1b5676ab-0dc5-ef33-9d79-a2bd6090a62d@huawei.com>
 <cbffabdc-42bf-4e67-9d2b-ace9a1e09f29@kernel.org>
 <984d9775-e17c-0231-b021-126b13a9aa42@huawei.com>
 <be1b20ed-5b75-46b8-b7be-3c9b029f016b@kernel.org>
 <d7e97bec-72bf-7d56-3811-6d9c41fefb35@huawei.com>
 <e4e123f3-ef32-417f-8369-ff944b6f358d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e4e123f3-ef32-417f-8369-ff944b6f358d@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n2aZVXkPCJNRGbiwl04UTxxwFFR6g9ipEzpajsSzOds_1781626545
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2026 at 08:56:42AM +0200, David Hildenbrand (Arm) wrote:
> >>
> >>
> >> Assume that we enlighten all non-atomics to grab the rcu read lock, such as
> > 
> > These non-atomics are defined and used because they want to avoid atomic ops overhead?
> > So I'm afraid using rcu read lock in these places would lead to unexpected overhead.
> 
> It should be cheaper than atomics IIUC. Further, I assume that some pages could
> batch over multiple such operations (esp. page freeing path when we process tail
> pages).

Doubt we have the energy to bother with this much.
We'll have to stick them in the bit manipulation macros if memory failure is
configured and be done with it.

-- 
MST

