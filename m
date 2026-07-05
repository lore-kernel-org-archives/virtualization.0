Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1472EEE8D
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240967; cv=none; b=d5Zow4aG6X0Iqmn0FpqcSnxmShYKcsrgX0DcWoX4rUVRulKB/YwGoHtkC+m+bMIT9fW/n+VUXkjUMwI9ETwmN6ogAucfqmFwGWWwygwCQ2O/bmP+GM8yFnM5qGhh5xVlVJOGpSRWatfbO89mvFhumh0vabm+KaSDv4LknKZAevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240967; c=relaxed/simple;
	bh=YkfZ9TTKLcaV+a1GgNvPn88+Q5Xhm9TdQgra5w1wGSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rudqrBFEhufPsnviN3QI5n+d3XB71i3x6971DMfNs0FaH8z36PEeT5RbYhycOrk1nns8DF5d1l2eWeGjg8EWU19oc7zUERgQA/kjKLDNfulHNHF3/Fb4Ioa0uaSB4Jc2QSFi6n7UPWDubbDFrrMG5cnCmz3lqE9j+L/bapihBBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwjhqWH2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwjhqWH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783240965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHXtK4FpIqGf3brzahyfCCX92d/AVZ7ZVXjnm2IjYlo=;
	b=KwjhqWH2qDV6rZZW9VZa1Zi1t8DDvVd7Zpdp95MA68Gdn0MNlEh834eMgna84BlUIQiUmA
	EeVbmy2KWzGtAShwp4kxpey8NjKR3iRdmeoAkhJx9VM1UyLyvDPhhJy+Yu8Y2T/H9i9URJ
	hZyx0Kp+1TjcOirVNmxbt7DWukrl94E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-uknTl_U6MZ-KFRaXKAbV-A-1; Sun, 05 Jul 2026 04:42:44 -0400
X-MC-Unique: uknTl_U6MZ-KFRaXKAbV-A-1
X-Mimecast-MFC-AGG-ID: uknTl_U6MZ-KFRaXKAbV-A_1783240963
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4729d2a64efso2124593f8f.0
        for <virtualization@lists.linux.dev>; Sun, 05 Jul 2026 01:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783240963; x=1783845763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHXtK4FpIqGf3brzahyfCCX92d/AVZ7ZVXjnm2IjYlo=;
        b=op/pP7TpGtWPDkxunyQbDa9jkqmOi/jwY4BjR8783SY9myM2xPxVY/Wq4bTLRdzJuO
         gyuflZj8D7Kyu41m5T0M/GVj1uaq0APuPROWHbbI7s2e7DsWw27FtB+M5cqqG5jgOVxi
         Oh7OmONHxBB/A3jJOJ3wbDGaRWuDU2rP/EJyOn9oEsE2DC5i8NSqHA0Tyf/oMRpeFXTH
         sqEwV/tgwTJ4pdLMR0mzrjptPU0IUthnZbaWclFYpBgQSfNr8euDmtcipt2k/dJ0p3Qw
         bbkT1FKbkGRcBGOJeCSHWwGIj4vMvOamKuPaLcmUOBlqkSMbzJ1rWiU4J10aSWyjhvBO
         J62w==
X-Forwarded-Encrypted: i=1; AHgh+RqOxJmdUj+PAyD7mR9ZUZbTc6JyHBLWJB7zY2NxcceA6pV9MBZpCsqr7s1iJHKyW2KdVDYB1PGPe43euMSSTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfEjoatMCtFdyNdlk22mBIBz7Mmll4ertrCVcqP040/ORnwRTg
	e/m9CEubbLmKppLruIa44QAMgpYfQZ8qpTsZbNvyoL9KOYgbS3kS8SKIB+lXXMtdZLc6m631DY7
	93yOmfk+8HgAXExmLr4fwtpaYtXH5kY+c5vhwjwGvHj9O1TBMxnAM53Si7TSQSV7VMwyX
X-Gm-Gg: AfdE7cnbLOM1xlV1GMIRZIGKVuCzUq8siL7s6hjaosqgr3J6PLM89JZg3LbeYGW+2H3
	IKHd93TAlbSsfnlH8LsMjU8AEjdQBFkM0aatPikXu5gIdE+dfq20v6XFqgg90p2ZbVLq7ot3dH+
	tJf9OoPU6wRNQe6SWt9as2gjfqBVrx5SgrEn2XLZamgmzLedHvqjZStscW3WQ06n/9LfNhkgNk4
	pCWL4Ew7QgbEpNOndLURzRDHKoz5HgM4SMtq7VXi/xIzSiP1+VKpBvpUTypEZtCI8lnFd574GCi
	VXkWZVDsq78JXrTLlaovNm10e8GPaV8SaBBchlqhcAj1edMawE4IzQNDUxcn4j1vmf/oSeQNAjN
	WcvKrfuIRn5WoXu3tgzf9iwibSCgJs8OR
X-Received: by 2002:a05:6000:1845:b0:474:88ef:cdec with SMTP id ffacd0b85a97d-47aba8c6a4amr7086538f8f.6.1783240962803;
        Sun, 05 Jul 2026 01:42:42 -0700 (PDT)
X-Received: by 2002:a05:6000:1845:b0:474:88ef:cdec with SMTP id ffacd0b85a97d-47aba8c6a4amr7086499f8f.6.1783240962323;
        Sun, 05 Jul 2026 01:42:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm14266295f8f.36.2026.07.05.01.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:42:41 -0700 (PDT)
Date: Sun, 5 Jul 2026 04:42:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: page_reporting: allow driver to set batch capacity
Message-ID: <20260705044139-mutt-send-email-mst@kernel.org>
References: <444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com>
 <20260705011635.9974cac7f0defec9961e85c4@linux-foundation.org>
 <20260705042313-mutt-send-email-mst@kernel.org>
 <20260705013956.36f649b5cb13409d9088838a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260705013956.36f649b5cb13409d9088838a@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dr2-Pi-TGPw4DaJN66Vslwa-8G4UVyGyuOsK52xU6ck_1783240963
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 05, 2026 at 01:39:56AM -0700, Andrew Morton wrote:
> On Sun, 5 Jul 2026 04:25:53 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > > If capacity is 0 or exceeds PAGE_REPORTING_CAPACITY, it defaults
> > > > to PAGE_REPORTING_CAPACITY.  The 0 check and the clamping is done in
> > > > page_reporting_register(), before the reporting work is scheduled,
> > > > so we never get division by 0.
> > > 
> > > Thanks.  What's the priority here?  Should we fix 7.2?  Earlier?
> > 
> > If possible, I'd like it in 7.2, have a setup like this (small
> > queue is useful for perf testing).
> > It's very early in the cycle and the code seems straight forward...
> > I judge the chances of breaking anything is tiny because
> > it just failed probe previously.
> 
> No probs, I moved this to the the mm-hotfixes-unstable queue.  No cc:stable.

I suspect the Fixes tag will make their AI pick it anyway. But hey.

-- 
MST

