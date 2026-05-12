Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C9356765
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 02:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554151; cv=none; b=jhPBDflHoi/ONuS3T2Hz7ab0f9dBtIhEes1Dbzf8vLnDXdo/7I3GH7njOGHqAE8JVy2duxWJ51Zy9IFtbtBPEH5FAnld28L476yUDW1kITkNuCX3wFPKhot9mP6R/UscYIjo74EP+dTHAkh+XJ/+qu1T9tyf1l2wnr1TOPhlpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554151; c=relaxed/simple;
	bh=fuQT2rqsnTCIwFqCU9ySXXBL7BsZDUXRJOhM5fhGb+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHfrx5xY61rC5QCaL5+lV2+6SMc1vZiahf4DNd9hd2IQ3iIoiY0cYTkh69qwGZlI68/plGedQMh33RqaT4QvpXlsoLtytFGGxG9eO8wojxbW2cqKnuzO7Y9RPWO49FcxlKEIODhfDC9/vJ7i4SXciPolOaTOMgWPDB9m3BR40RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FyZ4Vt3J; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FyZ4Vt3J"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ee9ec26edaso597569285a.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 19:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778554149; x=1779158949; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2BCFtdY8BstYcwPGt1OMwetfWeUvCIyaDq4u2dkV4Y=;
        b=FyZ4Vt3JhDY8dfy+oCBuidehd/qXVPL4AiyLD9EC7i0fHMgYPo5dVKxL9731Np3Sla
         4QR3pbw4asMnhRk2I0HJcsCSI6nWm+MId8WL0D7Voz2yRgW/4J+QIVCrA0eEsmb/X9hL
         AGhakK1jzsbrX7YqoPmt5G3yxlR0owS5ZOgb0vnupxjCg6T1lhk3pjAWfIKzN5trxFEv
         Cppp3+/ySQ8DgvyO7nMycli9h7l4dXBpppuPnNnTLORPy8pTWDl8VXe7yeE1K9L1/wjW
         OvyHfaDpot4edPrACRk6hbYi3tekAodZbY5voa5YR3eH8gUuwvvtfHtIxt45psPNCW3h
         i2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778554149; x=1779158949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2BCFtdY8BstYcwPGt1OMwetfWeUvCIyaDq4u2dkV4Y=;
        b=pPUxdqLbtyGvU1F3QoZqYK4kNhvZYUVpcOQOvhueOhvPLrniNUIBPBa+ZOjZCO2xa/
         ZOw4fQ11nDIFDdPj8oZGrQIuS5WnC3zEnbyNAgv7muLZSUB7Mo5rmMsKYDNhSbVq0R8T
         XL/TnZKMLfWp733EPkNMODNW4/wYdazhcj4Ng/y0fHVnDbxD6/a7StnUWQs/3OJNmEtg
         WmsqtHDQhZoKw0llcG2SshgFbzb7A7ZtDkFo9ffqwyn33I4kWV7FbvLz6LOqmAoH0d7a
         buYsAJ64tXFA0SZim6MXdziQZW60Sjg4fabIuXkQOvEXDzIFtNbg9qjklyPNVlmNVXq9
         31zA==
X-Forwarded-Encrypted: i=1; AFNElJ+UH61G2UfDt3t0pRhVzg4GdtB3LRXRFLDDnIxOcnlmDnQsJJ5EBvc/4nCD7KuMFG5j1YzZSBRgnuCDLkD8Zw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5O5oVs8O8Uq5NHv6BgGxFyt9PEGBrn/YCLlRdtIPOUfVVXk/M
	E8Hho2ZzNNM2kanrMUFwm8a8eMUKZfbqnnFGwt8xckzDG3s7dKKkv0dbk8O9xAevjE4=
X-Gm-Gg: Acq92OFiySverdNWj+QnWJZukiCO96ywepFNCG5d9NSbcGxhW1kFPyF6iCrUCSEBsn0
	onckY6aONEW4QFAiAUpm8aRZ/z18UxSNjLlHLEenoLaW/mL5od+LBU+k/Vj7vas6tOaTqKpUv0J
	34wERSj5UaSwZEmij1e/d+miGgtOcuguD+XGiQz8BAxDuHtySeDEqb9eR7vXU0c7uVzLA3QMhkK
	od6zVUO4dzyxHw3Us/iA+3wORtOX5IfIbG2oNHB5SfVBNHDyYRknENCyB/f9Pif1zg50P7friUU
	hnYasdCjImbofCpKzBAyCmfmURUh9pjs59gxjushlpvwovR7/5blWxoODHhroqElWqA7ZaIcTfR
	9nS3kqdqbjtrTe+ni1YhFdAzdsEuvyyLTTf0Zgen46HXOV/hLZD7jnJRjfUcGmJdCOWYqEs4EAf
	eJNKUbXPN57lpXb+Hjpg5rdemY5pFVNCe6r6GnYFI2ZTeHourpAziLLIYahPBjUkuwMkoZaBsl2
	biO61FZGyS1
X-Received: by 2002:a05:620a:710c:b0:908:a758:baa7 with SMTP id af79cd13be357-90cfd34a203mr155310885a.35.1778554149388;
        Mon, 11 May 2026 19:49:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04c68sm3293903085a.46.2026.05.11.19.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:49:08 -0700 (PDT)
Date: Mon, 11 May 2026 22:49:06 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Message-ID: <agKVIjvNwVajYwjz@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <fe1d24d4deafe0f5d1a9c51fcc040d9561c8592a.1778489843.git.mst@redhat.com>
 <agIFq63QZugkWcXJ@gourry-fedora-PF4VCD3F>
 <20260511174337-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511174337-mutt-send-email-mst@kernel.org>

On Mon, May 11, 2026 at 05:47:48PM -0400, Michael S. Tsirkin wrote:
> On Mon, May 11, 2026 at 12:36:59PM -0400, Gregory Price wrote:
> > 
> > This feels like a very odd pattern:
> > 
> >   1) ask for __GFP_ZERO
> >   2) Have to check whether it was actually zeroed
> > 
> > Seems like the zeroing piece should just be sunk in if you're going to
> > ask for __GFP_ZERO anyway.  And in that case, maybe just `bool zero` as
> > an argument, rather than GFP (to avoid future overloading of flags).
> > 
> > ~Gregory
> 
> Heh. The reason is that it either allocates from buddy - using gfp flags
> or from the pool, in which case it zeroes.
> 
> We could even avoid the bool - just test __GFP_ZERO inside
> alloc_hugetlb_folio. Would that be better?
> 

Hard to know until we see the full shape of things, but it seems
reasonable if we can eliminate one or both new arguments that this would
be a good thing and the logic should just be sunk into hugetlb.

~Gregory
