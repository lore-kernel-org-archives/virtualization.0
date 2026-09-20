Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21F1C8604;
	Sun, 20 Sep 2026 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789866737; cv=none; b=jpSLSKheTemR45DuCw8MrjliD1wVrBuhPuwgw+//2FPkmNw7IdLLHDEnpUCBCdbaBrVjl7uFSp7b8L0Nc6dHidb8IlJTSaWRylvLqkYopUaMMJoooxxvuHQDhM6uMBpLhvzAfnim2fK5aGcc33vTkKX8iucfnADULbcY1Vkyzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789866737; c=relaxed/simple;
	bh=ZmpLs63N7lsluxZ0uVt89HPkSAMY/bOkWCzpM4BNro4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fS3RjtL9HJ0UCjp5QOoKM+JHSrDOwTqmZcnAbPVybcwIc92z92rqmxPeQD5KFO0U15L+ZqiOMmWIGzLCkxYJAGwoLKtKMxMUfhNUgvf0zixlIW//ctT16upOcacSirOa8TQ5hSfPxsbDRHNGzyXvXWjhMs3HEIgLvd+BrGjQfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax9HyRum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax9HyRum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7215E1F000FF;
	Sun, 20 Sep 2026 01:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789866736;
	bh=+MrYzsFpziq8IouHeqFH0quA2nMpYFte1GPAaBGwEM8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ax9HyRummmsL9hj26DISkB3sktFib2EZJTxbetPkC4zvMazIl/6pLMBYYVR4tGsbb
	 n5u7dJ/LbMkTxbVgc5GXWh9J5ZwnFuKh6WzM84UvzBbMCWa9JZh9nFwKHnLnOwDiFW
	 K0CCUpUJIHjjk7fj+UfTRnb+/hG5I/939xIIJ0BBHKoQZeaCDtNMIIVDZFpFy5PEpZ
	 Q63uWhBFP1Dvef1jzZcsUdcWpJ9VRQcoaIAE6VjLcKZLqeDQYayWzU6pzpeFap4wPg
	 aXo7U+J9D/KoC091w7tp7XpsV2ryL3sXYQKN44v7BN7qqQnU16fmeA/SXJb9Ef7NuW
	 CVzgCWSuur0uw==
Message-ID: <2075f6a6-dece-4543-8ba8-e4ca91c77319@kernel.org>
Date: Sat, 19 Sep 2026 19:12:15 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] ipv4: reject partial checksums covering the IP
 header
Content-Language: en-US
To: Paulos Yibelo <habte.yibelo@gmail.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 hannes@stressinduktion.org, linux-kernel@vger.kernel.org
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
 <20260920004733.6473-3-habte.yibelo@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260920004733.6473-3-habte.yibelo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/26 6:47 PM, Paulos Yibelo wrote:
> ip_do_fragment() completes a CHECKSUM_PARTIAL skb before reading the IPv4
> header length. A virtualization interface can supply a checksum start that
> still points inside the IPv4 header after link-layer removal.
> 
> This does not require a virtual-machine guest. A TUN device with
> virtio-net header support is sufficient to reach this path.
> 
> skb_checksum_help() can then change iph->ihl after the packet was parsed
> and routed. Fragmentation trusts the changed IHL and can copy beyond the
> skb's logical linear head into transmitted IPv4 options.
> 
> Read and validate IHL before checksum completion, reject a checksum start
> inside that header, retain the validated length, and reacquire iph after
> skb_checksum_help().
> 
> Fixes: dbd3393c56a8 ("ipv4: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes in v4:
> - State explicitly that a TUN device is sufficient and no guest is required,
>   as noted by Michael S. Tsirkin. No code changes.
> 
> Changes in v3:
> - No code changes.
> 
> Changes in v2:
> - No code changes.
> 
>  net/ipv4/ip_output.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
>

Reviewed-by: David Ahern <dsahern@kernel.org>

