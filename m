Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493563233;
	Sat, 13 Apr 2024 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974873; cv=none; b=MWWkkLkfR6ya8/XOXtYdwt/QIVWcd/ReOw8KO4JrShzgriaEvvmC/x336qlqz6zul2LiDVjuUmVrroGMzkZlSiUvd4gSPlIItuUAthUa9OdZW3XcNkD16Mj0HpjrzL6FMTNDfxjIRSeUqqcStDXT7hXci7u40nUXmG83bX2A1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974873; c=relaxed/simple;
	bh=y+Zzs8AYFHabUfNjg7kTlPL7KV+priQgOo0WUYmaY18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9yr/y868XPJGQYJ8iUkDkQmmaLlkTgf1+Qsj9uHt5/Ut81c/WNjksZuCsJ2f2S4hRYxCUu3n39SSKe657EQBA+SgccmZyI3oTNlxO6st64KpR+vVM6oYSxkZi/sipWzCPqP2YluOTQCsqVRbvwbBExgBRTqDJxs6IAQzwrozR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agbd0vkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agbd0vkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44D0C113CC;
	Sat, 13 Apr 2024 02:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712974873;
	bh=y+Zzs8AYFHabUfNjg7kTlPL7KV+priQgOo0WUYmaY18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Agbd0vkNzwlO6UbGfcbo5K41XAhVcMtJvjp0qDFlKWSVGjUufER9dt+ZjzwVptkBs
	 IKoJ+cD24oiIgtzlPJsT/FTfO6866WqyyErYC5BUW0/SYMgyoD5EIjkLrOMbGi/40d
	 oIULuWIQSKTmfq/Qn0Z0AxfCtOteZmxMcXfofVS7hSFzr8buv62UMXskw4NIhqzUum
	 kr1IBNjopY7ygDCTgbkMpZxwWH88kNKEozKclimIKtYTb4HPGM2gf6AuYkhzA1b+DW
	 864j+xOeWm/4D2fpDEwuCmwJYLPliD7lIoixH/+4j9kYRv6DItJcFzQ4BfR3Mw7Vd2
	 nPfQlWGmC/sWw==
Date: Fri, 12 Apr 2024 19:21:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <jiri@nvidia.com>
Subject: Re: [PATCH net-next v3 5/6] virtio_net: Add a lock for per queue RX
 coalesce
Message-ID: <20240412192111.7e0e1117@kernel.org>
In-Reply-To: <20240412195309.737781-6-danielj@nvidia.com>
References: <20240412195309.737781-1-danielj@nvidia.com>
	<20240412195309.737781-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 14:53:08 -0500 Daniel Jurgens wrote:
> Once the RTNL locking around the control buffer is removed there can be
> contention on the per queue RX interrupt coalescing data. Use a spin
> lock per queue.

Does not compile on Clang.

> +			scoped_guard(spinlock, &vi->rq[i].intr_coal_lock) {
> +				err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> +								       vi->intr_coal_rx.max_usecs,
> +								       vi->intr_coal_rx.max_packets);
> +				if (err)
> +					return err;
> +			}

Do you really think this needs a scoped guard and 4th indentation level,
instead of just:

			..lock(..);
			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
							       vi->intr_coal_rx.max_usecs,
							       vi->intr_coal_rx.max_packets);
			..unlock(..);
			if (err)
				return err;

> +		scoped_guard(spinlock, &vi->rq[i].intr_coal_lock) {
> +			vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
> +			vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
> +		}

:-|
-- 
pw-bot: cr
