Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549941;
	b=XLSgi93KA4+8EUWnXmldQXURkbNxqdXSzs+NzkTvjLOjR25OfjR+GcNmk4L4wMwiaLDP
	 n5DcSZWKAQjVU43hTDk7gAe1Wn6HhZzDtDDcLjPKa3UiCQcaigR0hXmncUTBt5zNbv9Fo
	 tBKA1giR8T9ZacZUZ0QoildWnZYARkd4l4DyYgn7urnv21UxYwkr2NomdIW/4mJC87ni6
	 g+lzRXoSahGHU+6O8+M9GHxvaBVtBc+fn2CD5ZIYv4bmjb5JHs52W1BD/IBQlqQlmxenp
	 bmI+7ry5b+/GjeVrFhCVbluSmJl7eNuWpRdi+c0rq8rLB6TdN0/ovkv4K+Ev/Lgifdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549941;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nUXkImdoPBH85t2GfK//fEKYQ26SGF4cAAnRKZUyyDE=;
	b=woDikKnrimwOPIZgrAKC3rBGXwHThkHMNXn5vpxnK89hTDew39Lgavg79dpxIl81FV6H
	 qpbwNzobN07u0WCRIi0xlMcltTlST+wlhwwQcfxOCWeNzP2IixdcBeI44foF0xsZBUmvO
	 157j/uveFC/dmp9D+mt4SCDWRjZHYgh3Y5SoJQfChE7dAbD9P4ZTznwLuCvZMk91tRVeq
	 eIMQpShKgacJ8/Ta/o9UivkKg6ausLuydVKgwqnjBlMtiUd4HBEZbJgsapNl/0c2Q+1FC
	 v7uBGubw7dt20eDA1ihHZmJzFV5yHBGALM1AAFxi9ULnvuryWMelJ2M2pOHLTiO32mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clIwSiY3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264DE606A31D;
	Wed, 21 Oct 2026 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clIwSiY3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B1C1F000C9;
	Wed, 21 Oct 2026 02:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792549940;
	bh=nUXkImdoPBH85t2GfK//fEKYQ26SGF4cAAnRKZUyyDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=clIwSiY3Bu0QALCTfAUPRQoVl6BKsSUAxriv1xAFkEAPO0jkukUunQA1l0Q+GtlPn
	 aWhykxCWGlbeN/3KGxOiPIs89FNEbe1st4uEwcknoCUWUXt0IIwnJVyahnGqz0bkWl
	 MVLYWs0gePU9VYDvJuLuz2ziEirLK6h4K/bsHoKy72ldkgZt0h9BQQ74GCmEGzvycs
	 /uDh/TrgtlokSQ+Y4uszupT36XhU9/71xs+pyVkx7E73uhWHGivrocJ/I1gw/73LuT
	 ad1GilIyAjMiFbecOUdWBz7m24xxh0zXdi3SrQO8T+EBIA1ZgsRoB+4VbWuiMKHUn7
	 xyAvOdanGvnoQ==
Date: Tue, 20 Oct 2026 19:32:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Chris Arges <carges@cloudflare.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Phil Sutter
 <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>, Eugenio =?UTF-8?B?UMOp?=
 =?UTF-8?B?cmV6?= <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, Max Krasnyansky <maxk@qualcomm.com>, Rusty
 Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net v3 0/8] more virtio-net csum hardening
Message-ID: <20261020193219.342f3c75@kernel.org>
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 08:03:00 -0400 Michael S. Tsirkin wrote:
> Subject: [PATCH net v3 0/8] more virtio-net csum hardening

FWIW patch 6

net/core/dev.c:2396:1: warning: symbol 'virtio_net_hdr_csum_check_disabled_key' was not declared. Should it be static?

patch 7

Warning: include/linux/ip.h:72 No description found for return value of 'ip4_parse'
Warning: include/linux/ip.h:72 No description found for return value of 'ip4_parse'
