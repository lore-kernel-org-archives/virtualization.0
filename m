Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF7D261B8A;
	Sun, 20 Sep 2026 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789866712; cv=none; b=PnrfHSoEtrK3QxmStkI76myA52HY8hX9fyd8rD9uLDl2r/QjkkBxAhWN27B1bJGWUjtfRJ69VQfZlw3hw2RA2VaQIfAix7uVRr72BpVq7ADzYgVPKG2BpSPPnjM3WgzJ0S/MaY/mq0fsl4IhGUQM5SsZmdUeLFwSk1hnyRRu2lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789866712; c=relaxed/simple;
	bh=Rbf2UmQoZ8cJlkDTRBORUinT+eLFmTrkJ9pA6ZKUQUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNgL6PJ/5svxABdjO0aAlsBBfu4YxNxdmkmjTm7Zev5X6nSS6qO+hwQdg0e8qL3WUJBqlmbOloBDmKz4wwiTmB1YaCmYkK69eiHUfacm265y991hJ5f2ucMlKJD/RJfL/WaUb37EIYVxVNHE6Q5Mqm/G7Z0wRk4072kbT/rO1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCoZaL+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCoZaL+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232191F000FF;
	Sun, 20 Sep 2026 01:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789866710;
	bh=HIAamHxIBpjT0eTh6Hn/5Zhy4OkAadXKJpZOxIwIEDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oCoZaL+qiC30HjKuEVWqtdnI2gUEf+mhSu/+urJZOxTgzlo5fLh9ljQBQfwxcFOrU
	 tdCabMd42xZsBDhsC8hZlZchkFVkmwumZSAxA7Rpv3rsZWoAnhXYLnfclpdAAtHB3b
	 /l/j9whc/Ng6GtJpsrTcSYYq7U3l+gc+VlNEy0bdgNhnuvM+Un45/ZnLb0znvTRTN9
	 rdxzvcVnvzRZ59iTfnUGBiPWU6RcoAw1fFVTAI4jMLeh3SLdo8MkPxa3jYp/XXp4QQ
	 LjqcbCKuvwoXUG06ckomOtys8ew0MFrPz2RMiFKCA9Xl8v6jG7Skx0fjIZAwmoswWP
	 GEgX54hcSrG+w==
Message-ID: <05fed577-a9c9-4574-8d21-8c455a585e65@kernel.org>
Date: Sat, 19 Sep 2026 19:11:49 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] net: validate virtio checksum start after
 network header
Content-Language: en-US
To: Paulos Yibelo <habte.yibelo@gmail.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 hannes@stressinduktion.org, linux-kernel@vger.kernel.org
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
 <20260920004733.6473-2-habte.yibelo@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260920004733.6473-2-habte.yibelo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/26 6:47 PM, Paulos Yibelo wrote:
> __virtio_net_hdr_to_skb() rejects a CHECKSUM_PARTIAL start smaller than an
> estimated minimum network-header length. The comparison currently uses the
> offset from skb->data rather than the offset from skb_network_header().
> 
> For an AF_PACKET frame, skb->data can still point at the Ethernet header
> while skb_network_header() points past nested link-layer headers. A
> checksum start at the network header can therefore pass, then target byte
> zero after those headers are removed.
> 
> This does not require a virtual-machine guest. A TUN device with
> virtio-net header support can supply the same checksum metadata.
> 
> Keep the existing data-relative lower bound and also require checksum
> start to follow the estimated minimum relative to skb_network_header().
> 
> Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_net_hdr_to_skb()")
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
> - Keep the network-relative comparison on one line for readability, as
>   requested by David Ahern.
> 
> Changes in v2:
> - Make nh_min_len an int and remove the casts, as suggested by Michael S.
>   Tsirkin.
> 
>  include/linux/virtio_net.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


