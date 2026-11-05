Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885015;
	b=h0VYNAAVxeglJA59YUccLD07r11a+7uB3IptHwv60UgUW2FW9hqf1Zgk+/MspJ84Ze7z
	 t/jfogRLFAeun/QwxTQ63n7fUeoHFNAt7FzvMNFpvn2dEdsjdMrX7ZN7bJzb5W+AWqnn7
	 g8yi6uz9EQuYq1xEjEAkMMjtdHKR1aYHzFjC9mCw0LEzbx5oCRfT4KgnXwWLnM9CB8FMX
	 58P9gmgGC7Vi3Yb7aaBwKzw2uxwzfwNSPCT2IV240UZFRsL0S6f44jJ2q6hNfTJbr4bIO
	 7nNNw2P60wTDvwW0hJPVw/FR2DiQoF7RH0Pfz4ZVSA1DQ0rmkZwYwLDt3StZdwhxBzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885015;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2Rg54/UgthSrrGMQdksoyYG0Dil1YdHkzpnilCgBW5E=;
	b=pGKMb20+8j7t+RpTto6+Ua47z0u5ZYsTSX2dJ8x9zKWb/G+cLXrdtGwg6PZuFrM1v7KH
	 egJjTnTEnshIIcSV94yIzv4ryoySgFC7admYmHrSJj06a1x1p1WoArKKXEQMiFh1IYjsC
	 qz75hJqWyab+zsnAKguVdo664p3VjX67RNKVTg5NoUFoYtuy5sRyPEnkJGAg4z5P5wk8i
	 LERc1aRzKmVcRVbH9QkZkyMuASG5IGqoAGmTkX/GcC176cGFSLJ+KS7XF6dp5T10VrOeL
	 7JubUkKKzLsRRoxNLf5QZeNz2rTXvxLpwuxOvF4WKzH9iVXCJr0zU4Nek3cp1B2ybkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T2rPD2F/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293F1606A333;
	Thu,  5 Nov 2026 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2rPD2F/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7CA1F00919;
	Thu,  5 Nov 2026 13:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885014;
	bh=2Rg54/UgthSrrGMQdksoyYG0Dil1YdHkzpnilCgBW5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T2rPD2F/8wB/Id9kJGmahcqSsoxr/veB4/lmXtIYfHDLOA2gm/gWqlPvURULID7vQ
	 LtacLEo7B1C69FdrJKvPQd9K78YzTlKRNJzUfxZVafVk1YTK8KERGpRvIds6+PuxbU
	 mHvHYmQnYLQU7juP4XZ7p+4W68tg3G1cSpC0Dyr50TfMAKZo4IOarRT1wY6NJG1Rc0
	 LJBoXc75+1vtJIq6aLAzSjKybc6xBxDLJh/2yj1oEQav9g003hQjHrd+OCgg4bpmSJ
	 mDy0ySDl+yndoqVDuctfygFAERhYrbv+qFh/KXpd9EekUVsHlmm9NTMPPlD2TeO7yR
	 08No/SVeu6Rig==
Date: Thu, 5 Nov 2026 13:23:27 +0000
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Wang Zhan <wang.zhan@smartx.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net 1/2] net: pass the XDP action to generic_xdp_tx() for
 tracing
Message-ID: <20261105132327.GQ865646@horms.kernel.org>
References: <20261030114753.185281-1-vladimir.oltean@nxp.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030114753.185281-1-vladimir.oltean@nxp.com>

On Fri, Oct 30, 2026 at 01:47:52PM +0200, Vladimir Oltean wrote:
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
> Drops on those paths are reported as XDP_TX, an action which the
> program never returned. Tools which count xdp:xdp_exception events per
> action, such as the samples/bpf programs built on xdp_sample, therefore
> attribute generic XDP redirect drops to the wrong action. Drivers with
> native XDP already report XDP_TX and XDP_REDIRECT drops separately.
> 
> Add an "act" argument to generic_xdp_tx(), and have each caller pass
> the action that led to the transmission: XDP_TX from do_xdp_generic(),
> XDP_REDIRECT from the two redirect paths. generic_xdp_tx() is not
> exported, so these are all of its users.
> 
> Fixes: 6103aa96ec07 ("net: implement XDP_REDIRECT for xdp generic")
> Fixes: 6d5fc1957989 ("xdp: Fix handling of devmap in generic XDP")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>

