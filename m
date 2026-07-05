Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD836BCD7;
	Sun,  5 Jul 2026 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783274812; cv=none; b=bnq7HmhdFmW+SSy6faLyRCSE4JdsfE3RkMq5TpP+f7RaUS/wLhsrNts0HH+EEjcvdKZwx3lqPGgvCu29tF8yrGJKW7lO6L6f/3IITtdFHB1YT7D+GMdeuyzNw46feqymz8Tp20/6BKxaXyXi5ONItlhZa1oBOrTnFU3K8hOgpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783274812; c=relaxed/simple;
	bh=Ez2+EThfmqgMtAmwPSfQ9SRIOUlh0cUZtjgC2IvrPXQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JK4tKrO6UIkQU/QbgAuqCCa0OEWVmlqrhkn2Z/+S7D/+L+2WcOv7R/i2uIddePmzNn8c+XOMiIIji8BQpwHM5yffy7LpQ+3cMRRXUHNmEpwZr2wpJrEqfCQ8qOtm4qg0MdkfkJ/SZe0VYPJHjfe4jg4uoYFyivw1uPCk5OHqU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FrlFD/6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FrlFD/6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E461F000E9;
	Sun,  5 Jul 2026 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783274810;
	bh=TnBHeOa2oVuO4jBRzty1pOjyZUlumlxkSr7f+Vy6VGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FrlFD/6uFzd+WyOUFjPLviDQHunz6k5lN31su0IbN+E5iIpfhjbhW3mLexSzThiBy
	 H7rpiWp2v30ss1ayIT096OB+sik9Vims6OZ80m3uI9vfEFN5hYdyI4N/kRm6aCYHIp
	 C64Jy7Y8O1zFhVcDv50m2F+jFdeZrKmdLK2gKtVw=
Date: Sun, 5 Jul 2026 11:06:49 -0700
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
 linux-mm@kvack.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v3] mm: page_reporting: allow driver to set batch
 capacity
Message-Id: <20260705110649.bd30f742c78801a76137c53b@linux-foundation.org>
In-Reply-To: <20260705050445-mutt-send-email-mst@kernel.org>
References: <444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com>
	<20260705011635.9974cac7f0defec9961e85c4@linux-foundation.org>
	<20260705042313-mutt-send-email-mst@kernel.org>
	<20260705013956.36f649b5cb13409d9088838a@linux-foundation.org>
	<20260705044139-mutt-send-email-mst@kernel.org>
	<20260705015116.bdf3335e9a955f057a6d9c5d@linux-foundation.org>
	<20260705050445-mutt-send-email-mst@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Jul 2026 05:06:27 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> > -stable maintainers have been asked not to do that - only backport
> > patches which have an explicit cc:stable.
> 
> Out of curiousity, is this specific to -mm?

Not sure.  I have vague memories of being told "we added MM to the
list", but perhaps I made that up.

Sasha, it MM the only subsystem which requires explicit cc:stable
for patches to be backported?

Thanks.
