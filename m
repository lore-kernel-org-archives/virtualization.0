Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05313E41A;
	Sun,  5 Jul 2026 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783241479; cv=none; b=u40ACcZNTHaxEzguWEcemh66rOQy3bUYrkF5j7FuuP1cvS7B5mQew4+8fXgKrqBCsE3pA5JDlX9BIT4DaZJyBgO2Si3FfUwKIIp9D78iWFf8YY8SPOd+w8aBwM4WJeMkWdPqjs91nhPK8330GEYMApoXvWoIOC5E6o545jD+3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783241479; c=relaxed/simple;
	bh=igz0zo5QFVdefR8yil0ahphFSXBWp1UyVdi2BSHtOgc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IsHIZkR+LMcP3a2Y5vgnL+xIfeuNeRsCwJwheDPo+nnZn3ukccVGsSCPHwaaeLJ7wVB1mFDBzBuRz3qS77UXTIrpssPdUNBuf2Mn0OisNBOjZeG5cNRhFYT7zDTIhj6PVWQHqvgUZXVcS5G5Ezmx5vJ6nKLnFoNBKvpHhRJOh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jWPJ6rU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jWPJ6rU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE181F000E9;
	Sun,  5 Jul 2026 08:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783241477;
	bh=XFER0JTg0MnvGdQz+yRx4LxJwuvQANRQsRUh9Fc5KHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jWPJ6rU+KuF+lWRTG1lcB6g/hZQ6vFezaj4DZPhhOK3qmpJeMnsgdSKr9WR09wtKD
	 bnLMQmH1utE+UBm04kzhAvs+55vHp2EtBMNxsl+TzmrXF2dShdCa5O77l3C2o3Jzcm
	 mE6wMzXSZPPmZH7qr3ZbnQ2zIvjiFO6EvLhffQAc=
Date: Sun, 5 Jul 2026 01:51:16 -0700
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
Message-Id: <20260705015116.bdf3335e9a955f057a6d9c5d@linux-foundation.org>
In-Reply-To: <20260705044139-mutt-send-email-mst@kernel.org>
References: <444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com>
	<20260705011635.9974cac7f0defec9961e85c4@linux-foundation.org>
	<20260705042313-mutt-send-email-mst@kernel.org>
	<20260705013956.36f649b5cb13409d9088838a@linux-foundation.org>
	<20260705044139-mutt-send-email-mst@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Jul 2026 04:42:38 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Sun, Jul 05, 2026 at 01:39:56AM -0700, Andrew Morton wrote:
> > On Sun, 5 Jul 2026 04:25:53 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > > > If capacity is 0 or exceeds PAGE_REPORTING_CAPACITY, it defaults
> > > > > to PAGE_REPORTING_CAPACITY.  The 0 check and the clamping is done in
> > > > > page_reporting_register(), before the reporting work is scheduled,
> > > > > so we never get division by 0.
> > > > 
> > > > Thanks.  What's the priority here?  Should we fix 7.2?  Earlier?
> > > 
> > > If possible, I'd like it in 7.2, have a setup like this (small
> > > queue is useful for perf testing).
> > > It's very early in the cycle and the code seems straight forward...
> > > I judge the chances of breaking anything is tiny because
> > > it just failed probe previously.
> > 
> > No probs, I moved this to the the mm-hotfixes-unstable queue.  No cc:stable.
> 
> I suspect the Fixes tag will make their AI pick it anyway. But hey.

-stable maintainers have been asked not to do that - only backport
patches which have an explicit cc:stable.

So should I add one?
