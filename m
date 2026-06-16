Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69B125C80E;
	Tue, 16 Jun 2026 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613229; cv=none; b=VURqt3KWyj8k76UULP1jfjdeZxw4JKkrKWvYBQEyd/w8nKaNldmPZSYl7lPm4ELQ/a1j4z00UKvcKepSc4QMjqvhkUFfdpgTgoupvDmycNl96htXp2xw2jNZtzyqiRquZmFRu06o+ociNgZV3//Pt9XQxC66teLmawqjQzNMYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613229; c=relaxed/simple;
	bh=Xx7x/Snf0e0hjFZEbiJqPFXeazWQyL3Yt9/i8g7XwWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwyaLPj3X+Spc2lhF+hZhCUdkXgMSIt1Ywim5EfLtU+K38X34G40h6ue8WR4p3KyxS8Q8q1Klu+aiMmEUpAI+RlQQplvOjsTfU7URuIqQKgD3QvVSWVrA8z0d1zaOBlxpZY8K/o8WRBilbWemH2mWLOe1LvrdFCZ5pNycFUKoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDvvcfiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDvvcfiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30201F000E9;
	Tue, 16 Jun 2026 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613228;
	bh=hHAVFB73luDZxdK2LYVDgp+cJ/BWXMvwZneaVOyU228=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZDvvcfiJuXdct13oivP6Ibr4dQsugvcEuBznpOWUtBf0Zk3QJHQ2gAJJGwFfGEos5
	 pNAs4JAb6CZsQcNIDMbIzOb6gL5Rw/NMUZEmQJIaWSeRQSajm5B91hhEuhMHNPJGoU
	 yWKuO6MFS0jTeT7b4SgaiTDnI9b2AJFXudevLDZHpXXEDQDwaiP7KCNBpOwEc9gp4c
	 EIq32Mo2pCwgzOQZL9Kzw6dfNFc4QOCugcUw8QHl2x6SR4iFezmMo4Ac5V+/M07zxq
	 Aj0eEts5o+NFQMDAdll3g9WOfYNz9e4s2XxULmpdzzElAAvdKo+EAJHfkkDfjrQlEt
	 gmEh7ks4B0dsA==
Message-ID: <feee7831-aa82-4f02-b5e4-cffe7818dc65@kernel.org>
Date: Tue, 16 Jun 2026 14:33:43 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] virtio-balloon: add stats push mode
To: Gregory Price <gourry@gourry.net>, virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 hannes@cmpxchg.org, surenb@google.com, peterz@infradead.org,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com
References: <20260513165006.2790857-1-gourry@gourry.net>
 <20260513165006.2790857-3-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260513165006.2790857-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 18:50, Gregory Price wrote:
> When doing aggressive overcommit of VMs on a single host, a pull
> model of stat retrieval is problematic if a guest becomes some form
> of unresponsive.  In particular, it's difficult to discern the
> difference between a hung guest and a slow guest - and why the
> guest is experiencing that.
> 
> Add VIRTIO_BALLOON_F_STATS_PUSH feature that allows the host to
> configure the guest to push stats on a timer instead of the default
> pull model.
> 
> The host sets stats_push_interval_ms in the balloon config space:
>   0     = disabled (pull-only, default)
>   N > 0 = guest pushes stats every N milliseconds
> 
> The push mode reuses the existing stats VQ, same buffer format,
> same tags. The host can change the interval at runtime by updating
> the config field.
> 
> Push mode provides two advantages over pull:
>   1. Guest liveness detection: in pull mode, the host cannot
>      distinguish a slow guest from a hung guest without implementing
>      its own timeout tracking. In push mode, the absence of expected
>      stats buffers is an implicit liveness signal; if the guest
>      fails to push within the expected interval, the host can
>      conclude it is unresponsive.
>   2. Latency-sensitive consumers (e.g., memory pressure response
>      loops) receive fresh stats at a guaranteed cadence without
>      the host needing to poll.
> 
> STATS_PUSH requires STATS_VQ; the driver clears STATS_PUSH during
> feature validation if STATS_VQ is absent. When push mode is active,
> the pull callback is suppressed to avoid racing on buffer submission.
> 
> The pull model remains available and is the default.

I don't quite see the big benefit here, really: either it's a timer in the
hypervisor or a timer in the VM. A slow VM will, in either model, delay the
update of stats.

If you need some "liveness detection", is virtio-balloon stats updates really
the right mechanism?

I don't quite understand the "Latency-sensitive consumers" problem. If the VM is
slow, it is slow and will mess with latency-sensitive consumers in either way?

-- 
Cheers,

David
