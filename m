Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F91548C;
	Tue,  2 Dec 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690944; cv=none; b=ISsyerKZpyvNO2+X98950E9eI7D5ELJd2LLKQmtMaZz0i7TCxdMqDbbEVo/Xn6OFK8z7ylXQsO2sxn5BHICAEmCRL0WUK78eCQzke+x4Xcxc6dcd+N3Et2JjpMXIYBEj95A+WwX7hyCn5ktZIy0eVhh1RkTAyay1Pc84jWBgmfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690944; c=relaxed/simple;
	bh=/1PilUd9q6RJgw3U38mxQKQbwR1HO+42RtuQ6hI+w7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaNnb4hr/vVHvnfti6fcuoua+uIOABVn4uukJEblRMcBBwRS3TwpvLRF8ItHw+z1WXDGpzr1noLrOP/clPLfhQzdfOYBCxnIfYwDFWwJsrkG3V1+4cozfuo+uGJ3+20msS0L5bdNeGeNIOaLVoxGF8WW1c82fKenggnqLcNlWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUQ/3oO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUQ/3oO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E98C4CEF1;
	Tue,  2 Dec 2025 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764690944;
	bh=/1PilUd9q6RJgw3U38mxQKQbwR1HO+42RtuQ6hI+w7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUQ/3oO0tINB7XUGNt76XlWg2j4qPwh4qLVfuCmmIaSquxa4mtOTmEPp+vppmw3G8
	 klR7FCixWkaCRb/bs6FFEh8jfKhaXt1F95LSVFhAKbZILZpVpXGXorfAwRBoXKIZ3A
	 t6I4dofeBBgK3XfmWKJs9GLQ6cEmEBtMzzvMiZjEYYZIqXWfAiQ3vmrD9iYk3MXiQm
	 hQmMjN80OmfVAhuhSW/j2zC5W+wrnn4DrKdDnMDEUa00Ub3ukTOjya2cXofhkA2TDY
	 Dg/h+/aswgiLFUlHivoDirLWHGCfMLOF9Y4b/B4c8mzLfDilmydCNCh/9/F4+iWLF5
	 jIZEHAZXZfqbw==
Date: Tue, 2 Dec 2025 15:55:39 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <aS8L--z0ezhkywT_@horms.kernel.org>
References: <20251126193539.7791-1-danielj@nvidia.com>
 <20251126193539.7791-12-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126193539.7791-12-danielj@nvidia.com>

On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:

...

> @@ -6005,6 +6085,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  		mask->tos = l3_mask->tos;
>  		key->tos = l3_val->tos;
>  	}
> +
> +	if (l3_mask->proto) {
> +		mask->protocol = l3_mask->proto;
> +		key->protocol = l3_val->proto;
> +	}
>  }

Hi Daniel,

Claude Code with review-prompts flags an issue here,
which I can't convince myself is not the case.

If parse_ip4() is called for a IP_USER_FLOW, which use ethtool_usrip4_spec,
as does this function, then all is well.

However, it seems that it may also be called for TCP_V4_FLOW and UDP_V4_FLOW
flows, in which case accessing .proto will overrun the mask and key which
are actually struct ethtool_tcpip4_spec.

https://netdev-ai.bots.linux.dev/ai-review.html?id=51d97b85-5ca3-4cb8-a96a-0d6eab5e7196#patch-10

>  
>  static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> @@ -6022,16 +6107,35 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
>  		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
>  		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
>  	}
> +
> +	if (l3_mask->l4_proto) {
> +		mask->nexthdr = l3_mask->l4_proto;
> +		key->nexthdr = l3_val->l4_proto;
> +	}

Likewise here.

>  }

...
