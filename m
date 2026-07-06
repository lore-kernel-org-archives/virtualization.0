Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C7420893;
	Mon,  6 Jul 2026 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342876; cv=none; b=D3SSzXKYTeqKpwNLNvUwTDKhhU7+U3MHlT1VNOs9eIJW2rNoKIeFrBF7C0aRbUlHo8TD4VmHGvk4Ryjk+3N1cl2uQ9RMgkzD00R4q+kniEITVkeRo4j/pExSnr+/Oy8Uxb/Abtom5gmvHzw9zYrencT5Mz9hofceM7/o4wKiSvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342876; c=relaxed/simple;
	bh=rnJUphAw4oXINZXdwB0begMlecnqSCc5MaxOswXT6DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKjqXL+ExoAWBg3Z4U0NhltusbQIh0JjPq/y2EyGSITP97Vy13rF4Tb+Alf94GGmyj8duC318lxrT2bKSKGWi72iNhJGIxo4yZPF0ABtMCBlHz9HX4s3kl/U27Em12MrtSQ0luVPXt4/RXQlt4amtoIlsCypiHT1VilR7V1z3cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdubb/ld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdubb/ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFC61F00A3A;
	Mon,  6 Jul 2026 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342875;
	bh=OJidZz22+JDX734AvsvghP5/wyv0jm9tSJVNzE1YIRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jdubb/ldgnPcXWuJg/PGhYP2/ItNuHyjLnqiq0zuWN0Ee5jtChzaOXMb4R8x1nR2E
	 0BXzaRyotFMDUOQaE8C5tu/w1Es4x7i49K3xxYXBCIIUawtPsrS6lJzJvcpQG2gCey
	 JGK0xnriB7hwda1nIKj2htHngQO1rc6Duc5FQyYYwReJ+oESVcM5XEQzEOzHdCH6lx
	 L3Wj8p9pq/dB4WXdT53ehGA1oBfURA1MoZhiwE9Wq3bzXawRqiU8yVkUqXJKDkhS8e
	 nOjHPGUcKSm3K+lY4Pfc3K1v4DyGcFP4+7vgokoIQ0SX1lRIYmkNtY812RYqL2wFr9
	 Wvuj83TAe1I8g==
Date: Mon, 6 Jul 2026 09:01:14 -0400
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <akunGsm92phrfbco@laps>
References: <444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com>
 <20260705011635.9974cac7f0defec9961e85c4@linux-foundation.org>
 <20260705042313-mutt-send-email-mst@kernel.org>
 <20260705013956.36f649b5cb13409d9088838a@linux-foundation.org>
 <20260705044139-mutt-send-email-mst@kernel.org>
 <20260705015116.bdf3335e9a955f057a6d9c5d@linux-foundation.org>
 <20260705050445-mutt-send-email-mst@kernel.org>
 <20260705110649.bd30f742c78801a76137c53b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260705110649.bd30f742c78801a76137c53b@linux-foundation.org>

On Sun, Jul 05, 2026 at 11:06:49AM -0700, Andrew Morton wrote:
>On Sun, 5 Jul 2026 05:06:27 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> > -stable maintainers have been asked not to do that - only backport
>> > patches which have an explicit cc:stable.
>>
>> Out of curiousity, is this specific to -mm?
>
>Not sure.  I have vague memories of being told "we added MM to the
>list", but perhaps I made that up.
>
>Sasha, it MM the only subsystem which requires explicit cc:stable
>for patches to be backported?

There are a few more. We maintain the list here:

	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list

-- 
Thanks,
Sasha
