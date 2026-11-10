Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332407;
	b=dM2T9f67S1OfT+zDjzvNeTFRBgDcKmJcr4p3YLg2eyPOaalHDIgzB13g4QnwJ63aIj4B
	 rfmQlaUDc8VSA8YSfoxES0Fc71t5kATFuopdm1eHfrIMf7W6uDV0UfB4ejMLdGFu/4BNa
	 nF2zYmytTm4qsyLETNMV1l2S/z0eSE6xZIFA9o4vBFzvpE/8G2qEgmTD0tkbfEfxb7nUe
	 xPvtTx49lSIqDPfpqVd/BQ0qEMFxxcwz5cMhK27FQ+925yDqvJOw5O0WamSbKm7duA/5F
	 AsYWqZ24tfKPi7Zq7/oBSoZ+iIYU/DSiFKG8WCmxh0f6OGYH9JVqU6RQYebi5veacZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=vDIdWDqCs7bQzZm4Myzs55AdA8xj+ko5T/nZrnXBCKE=;
	b=G8ayJaZPf3W0ipD8e2ULmoTKXJxqS42mXCOX36GvFXdyVU0Zo6hiAD4cTNNfbPj9JQvl
	 Ocki7xZslxtQCvfBAyxSV3tiocu3PY23epghK9UfaWgImJko5UXFLP07qxTvXHkRzKVh7
	 MFs0KcdluXhgrDhwN09qXB4lTN6/hk9RfhqSOEvkcm19DwCq5PhR/9uGvEAG2gkUP3Am4
	 +VNJs3nCm0LvGuNn7PpnWxBxIZvzSret1a76oXue0FsqKiRDrdMqV+1ZcJnttqCHeLSsF
	 OHBJx3w3eOC2i+Dp8ccBbUXuSBcifuMqC32D4fAvuz04KcuWNj0BgzdYCUgfiZyqOVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnvYMYZ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E490460A5BD4;
	Tue, 10 Nov 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnvYMYZ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAE31F00937;
	Tue, 10 Nov 2026 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332406;
	bh=vDIdWDqCs7bQzZm4Myzs55AdA8xj+ko5T/nZrnXBCKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XnvYMYZ4G8cIRDuO7q4ftQDGNfQCYbcw4Y0r+Sx9Ury9+EeXu1Ofk80fTxwxNRu7Z
	 EIT4s+RAXmlsN2Dvpu/tkOpnjC+REH2LhaEaF4gyOki/5LJzMBps6l3RyLf/CYU2El
	 jLNRFePMY25wEJ1AV+DvvmiJmclMZs7SHlChygHHzsgqpIlH+vhIWBM6osWL+mD89H
	 9tBXhTdjLEkmP16EpsNPWzCpAwX4BsGLyHQ1yh5I++DR4aCCmziJJcvATJ1iWP2N8g
	 ud5byP66KBVWAcND/DXN4y2eSfTH56fw8ZUZaZ5+gw16gVE++mJMw0exNIHSUO8aQM
	 Z88Xri6zAsfYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2111839D6088;
	Tue, 10 Nov 2026 17:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: pass the XDP action to generic_xdp_tx() for
 tracing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433240494.4112524.1031731452606255276.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 17:40:04 +0000
References: <20261030114753.185281-1-vladimir.oltean@nxp.com>
In-Reply-To: <20261030114753.185281-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kuniyu@google.com, wang.zhan@smartx.com,
 mkarsten@uwaterloo.ca, makita.toshiaki@lab.ntt.co.jp,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Oct 2026 13:47:52 +0200 you wrote:
> When generic_xdp_tx() fails to transmit an skb, it reports the drop
> through trace_xdp_exception() with the action hardcoded to XDP_TX.
> That was right when generic XDP was added, and XDP_TX was the only
> caller. Since then, two XDP_REDIRECT paths have started to transmit
> through generic_xdp_tx() as well:
> 
> - xdp_do_generic_redirect(), for a redirect to an ifindex
> - dev_map_generic_redirect(), for DEVMAP and DEVMAP_HASH redirects,
>   including broadcast
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: pass the XDP action to generic_xdp_tx() for tracing
    https://git.kernel.org/netdev/net-next/c/655978fc71fa
  - [net,2/2] net: validate xmit skbs in generic_xdp_tx()
    https://git.kernel.org/netdev/net-next/c/67b0cca9ba88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


