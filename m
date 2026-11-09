Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191586;
	b=V/PRmR52e4FFGDA1eY0ZW2drExZwj1pSEkbISRXWJiiW1KUTqwltGE5OhpVdu+R+7Oej
	 BDpqlV5/k3j12NF1XXL1FVAjJzFQF9dEQK6R0xCwt48DvwpfVOcyv9x+xzhRSg8NkD1yf
	 uVlkDME6Q/Ibl2wYab9ksh0Aqx/xorzhMfXQahBuKROT42TTxz0HVpduAjloahbJAHlTI
	 rej8sCWGN58yorqB2isLKuda/KMSDWl3LPbKvY+h+1QKqxwOEgLRT7IPle7vLJsx/BhbM
	 llFVgpOksk8mQFKK/75Oj5pc+L0WEC9k0ArNkCpW64lr8e+2pqjKVZSHReJD/i3ip2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191586;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kB3IFpQ0ZIO1cp7bsYqiegxOLRHS/D0OEp5d5P2E9bs=;
	b=kjHZ7A+mhSu/zfyQOLrKNBBflH9Kn7RNY58j8bAiIRwH2QuwQtFIfhzBvA6nIcDyiqRh
	 yJ6D9cCpk9if6WG1H4/obw/+nOdCGVcj8WzBCxvTPelTxY6ax8NDZhpV9B6m02d1fQcpQ
	 sAOt+brP7s4oIWsVZKjZlYs+JClwIYEUY6N2rlTlnjL3HXou4SGNfZGcZWoWKRBXEqLA5
	 HyEcJrk3Q8wjfkIEcVkJViXcAOi5qhSPslUeSrzlLpgsKfEcMCLhf6Ilz+T62ZiDGGML4
	 vQC1YGWIvzs1xHKB5NPbMLq0xMWJIX5t1vv96glkVhDPdnKTGNYlk6a4GVVz7RBPpUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ojX0EpIo;
	arc=none smtp.remote-ip=91.218.175.74
Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9953606A325
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 02:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9953606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ojX0EpIo
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=nmqRaiM/EiJNizjn79AmK4k2MmWrkYTwEz2GWquosKA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794191583; v=1; x=1794796383;
 b=ojX0EpIoXW4Q3WWoKTSHFyYfVB5/NGKPMoZkCmCbZqBScUyhu6sLm3yjkz3APWW4PPjlGsGs
 08BhfDJF0/bIs+cEwtmQZ/pXWdCFPiZK/kLkGbfQD3yI047xH2MZMmKuO4QwBQXVhNIdwf/A+O3
 H3ZmjPkz0bDxno5X6rlhxv2w=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id fa418301c63af391;
	Mon, 09 Nov 2026 02:33:03 +0000
X-Mizu-Trace-ID: fa418301c63af391
X-Migadu-Flow: FLOW_OUT
Message-ID: <c6bf9ef4-5a61-4f4f-ab39-11d1ddf59d64@linux.dev>
Date: Mon, 9 Nov 2026 10:32:01 +0800
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, akpm@linux-foundation.org, dgilbert@interlog.com,
 mkp@kernel.org, loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
 vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
 jgg@ziepe.ca, kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
 James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
 phasta@kernel.org, joro@8bytes.org, will@kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com,
 robin.murphy@arm.com, mason@kernel.org, aesteve@redhat.com,
 harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to
 memcg
To: "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-3-cui.tao@linux.dev>
 <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
 <CABdmKX0nCB2hT+iMh=BB-nC=fUBPof8YvjvO-gtEw+zcHZgvZA@mail.gmail.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <CABdmKX0nCB2hT+iMh=BB-nC=fUBPof8YvjvO-gtEw+zcHZgvZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello，Christian，T.J.

在 2026/11/7 01:25, T.J. Mercier 写道:
> On Fri, Nov 6, 2026 at 5:23 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 11/6/26 14:18, Tao Cui wrote:
>>> From: Tao Cui <cuitao@kylinos.cn>
>>>
>>> udmabuf pins the pages of a memfd and hands them out as a dma-buf.  The
>>> data pages keep the accounting of the memfd they were instantiated in,
>>> but the bookkeeping around them does not: the page pointer array and
>>> the pinned_folios array, both sized by the buffer page count, plus the
>>> transient folios array sized by the memfd folio count, are plain
>>> GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
>>> memory, and size_limit_mb defaults to INT_MAX.
>>>
>>> Charge the three kvmalloc allocations so the creator pays for the
>>> metadata it induces.  The system heap in the same subsystem already
>>> accounts its buffer allocation;
> 
> Only if the mem_accounting param is set to true. We (Android)
> currently depend on it being disabled because system heap buffers
> don't have a single owner for their entire lifetime (ownership often
> changes immediately after they are allocated), and the kernel doesn't
> have the ability to switch who is charged for the buffer memory quite
> yet. Albert is working hard on it at the moment.
> 
> Could you update the message to note the mem_accounting param pls?
> 
>>> the data pages here stay with the
>>> memfd.
> 
> memfd / udmabuf is a little special because it uses shmem for the
> backing store, which is already tracked by memcg under all conditions
> (except hugetlb). We don't currently use udmabuf, so the lack of memcg
> charge transfer for udmabuf is not an issue. But once we get charge
> transfer working for the system heap it'd be good to follow up with
> udmabuf.
> 
>> T.J. needs to take a look here, but I fear that this might break uAPI.
> 
> Thanks for looping me in Christian. The buffer allocations cost
> gigabytes, but these metadata arrays are only 4MB per 1GB of buffer,
> so I don't expect charging them to break anyone. Leaving them
> uncharged is an accounting gap though, since someone could spam many
> udmabufs from the same memfd and only pay for the memfd pages once. So
> this change is ok with me.
> 
>> A lot of the DMA-buf resources are intentionally not charged against memcg.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> With the commit message updated to mention the mem_accounting param:
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
Thanks, Christian，T.J.

I'll update the commit message to clarify the mem_accounting parameter
and pick up your Reviewed-by tag in v2.

Tao

