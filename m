Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15773655E4;
	Sun,  5 Jul 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240799; cv=none; b=doWmzSnDB6J1Y6ZhbRs9hf0JG7VEzZulU19Eg2ONbRuimkzHeiI6sia3PIwg9d6y0HQ7/mMCsnhcioP4fzOpu7FttmtZyLarZfhgR0Pi6b6VzflA9hb3rygynXDHSom/iFVnsDGOPjAWu4f8Og2r9Iq/STfjTYWfvDdgms61dB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240799; c=relaxed/simple;
	bh=4xEcEPknYUbkI6kTo0cW2fV/a/PMkEwNZV5FTV4cX3w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FsVkUGb4e7upzWioSYlBmC0s9atflzvHRPjuZqSKk1o/PkzFKg9/1tTXQ3y97gckHZa8RmboRbX+CEWyA7Zo0nVrU/3F81UFSv5JMvuw3a1aZ89D4upZleSGOcze+0vLJcHswdNIxoZcZFUQZZWVeDgANmxozj+wxPHqH7fMaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pTEETO77; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pTEETO77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C981F000E9;
	Sun,  5 Jul 2026 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783240797;
	bh=YFdQjwdHm8s+vHN/5MHawb3/x/oHy6pumzw7hVOvzHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=pTEETO77aHcDFsjbd4iTtSYUfUth2BiGf8su0ImDVfmrn8KQnSQaH2CQywMLI9xun
	 16o+SZpaD6rjwVLFpN4P3ebQoVIVqtcRO0GDs5wWKhgc2p6fQOC7oQC6ChavHrZ9CH
	 GGeo7d9SP40VOLPuVttlb+UU01s5BeA4YNC1h/N8=
Date: Sun, 5 Jul 2026 01:39:56 -0700
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
Message-Id: <20260705013956.36f649b5cb13409d9088838a@linux-foundation.org>
In-Reply-To: <20260705042313-mutt-send-email-mst@kernel.org>
References: <444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com>
	<20260705011635.9974cac7f0defec9961e85c4@linux-foundation.org>
	<20260705042313-mutt-send-email-mst@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Jul 2026 04:25:53 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> > > If capacity is 0 or exceeds PAGE_REPORTING_CAPACITY, it defaults
> > > to PAGE_REPORTING_CAPACITY.  The 0 check and the clamping is done in
> > > page_reporting_register(), before the reporting work is scheduled,
> > > so we never get division by 0.
> > 
> > Thanks.  What's the priority here?  Should we fix 7.2?  Earlier?
> 
> If possible, I'd like it in 7.2, have a setup like this (small
> queue is useful for perf testing).
> It's very early in the cycle and the code seems straight forward...
> I judge the chances of breaking anything is tiny because
> it just failed probe previously.

No probs, I moved this to the the mm-hotfixes-unstable queue.  No cc:stable.
