Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506727B340;
	Sun,  5 Jul 2026 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239397; cv=none; b=Nbs2pjpaVAXCDh/WH4AKKOuUhwya0T+zTsbqcxFajJPleTQACdOyvIKn9I9qnQGx6L2wxZrRAZFDj0NyiIA/N0+ZCCxC+TVOlMO9IDdv3Ywsk/UaVHm2lXRgfg6zlLOFNsYR/VWcFY2ATs5rGjYayIgFgfjMNN5robSXs0b5LfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239397; c=relaxed/simple;
	bh=/MStALqltiGci1GOC/mH6UWroyPj1pg2zP1qxSvRoIw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I0qzr5RYpi9pdWuTKopghQYr3BFUgXgDcN7dLYgWs0Wa1hhsYiX1MKsJAqpsQ4oD0aFNIJ9cKXADOV1qs00aQVU0WtZryDNuTJ2Dn8MH6mCOV4D+hxbOhof2WyrD0Qk9PhuWgsbMEQ9+iPvMNdIqIV1T/msW3F3XfY9vSoXQX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RygF87UJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RygF87UJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC43D1F000E9;
	Sun,  5 Jul 2026 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783239396;
	bh=zizsnsWJL3/EpRjgM4/piAB0Nix3kO/XS+7rXU99wzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RygF87UJr7ykgVkWEn2BGjPORrY/BmHa64iKdVNhgnFrqKQLqvUci1BlM/Bsnlvbg
	 DbVapVBxkSjp1Br4euzoZBdHMEY2XyRia5BIASYsSh7R8mocbuMti2OChwfPR3kX2R
	 ts0yuLTfSWIa9TyxZPsHMwv1iJ5BQj3qjMNX0zFM=
Date: Sun, 5 Jul 2026 01:16:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, "David Hildenbrand (Arm)"
 <david@kernel.org>, Gregory Price <gourry@gourry.net>, Zi Yan
 <ziy@nvidia.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Lorenzo Stoakes
 <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Alexander
 Duyck <alexander.h.duyck@linux.intel.com>, virtualization@lists.linux.dev,
 linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: page_reporting: allow driver to set batch
 capacity
Message-Id: <20260705011635.9974cac7f0defec9961e85c4@linux-foundation.org>
In-Reply-To: <444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com>
References: <444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Jul 2026 02:25:13 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> At the moment, if a virtio balloon device has a page reporting vq but
> its size is < PAGE_REPORTING_CAPACITY (32), the balloon driver fails
> probe.
> 
> But, there's no way for host to know this value, so it can easily
> create a smaller vq and suddenly adding the reporting capability
> to the device makes all of the driver fail. Not pretty.
> 
> Add a capacity field to page_reporting_dev_info so drivers can
> control the maximum number of pages per report batch.
> 
> In virtio-balloon, set the capacity to the reporting virtqueue size,
> letting page_reporting adapt to whatever the device provides.
> 
> Capacity need not be a power of two.  Code previously called out
> division by PAGE_REPORTING_CAPACITY as cheap since it was a power
> of 2, but no performance difference was observed with non-power-of-2
> values.
> 
> If capacity is 0 or exceeds PAGE_REPORTING_CAPACITY, it defaults
> to PAGE_REPORTING_CAPACITY.  The 0 check and the clamping is done in
> page_reporting_register(), before the reporting work is scheduled,
> so we never get division by 0.

Thanks.  What's the priority here?  Should we fix 7.2?  Earlier?

It seems that Sashiko has found a pre-existing issue, a hard-to-hit
error path thing:

	https://sashiko.dev/#/patchset/444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com


