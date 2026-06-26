Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54A1A5B9E;
	Fri, 26 Jun 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486938; cv=none; b=BNdzb35cLJGGJYK541ZJxvaO0UVZ4+d6WZlxuPrIfjI9XUUCB8winyth9TSDLjn3xiLOlOjE2WV0bN2COh3AM8z3Zdov0LaeVj5ER9VeQYKAm6/Sh/7wdeOLidHmA+lO/vSAktpxvlnEmlnQPZQZeAobbA6sWKtAP00OmG37fNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486938; c=relaxed/simple;
	bh=jA+LtT+w9ziFAv6SejZy4xHhQcaZUUtt+07+zT74GpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtbxPhdXd6+TLgHk/miOXJFxWS9Pb/MNbIGNuuoJAeYEzBNIJpuoxnPGOj418TzwYkN9By5187jR3C/5rFcZGeKNxTvfN9n8t5ovOPCFV/m/ARiF2ITAcb7JHFs7v56k+ff40UWycfRCbc+Pvzqrf8m75NfBGlZCeT/GN97waOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVjjbM26; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVjjbM26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3081F000E9;
	Fri, 26 Jun 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782486932;
	bh=xMY3o3jBD4b25D29n1Y1hcy2n0lXYQS1LYHlfhK/gYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EVjjbM26lfY86Z2EOtyBuaAUSZlbBDEVn8wyO0rAeKKowe7XE055BXKlqUgLhfaGe
	 0ATXsek9two9aM1KP+USC25qaYd5ShTQ/TpPiHBmpYVAkdndBPGi86rvG8kPT9Vxzo
	 DQ9Ntn6lLkKepCSOwAQV9YrM3Ti6BWqGeIKg4TUOas1d5crz70Zdyj4lsiMXMW80f9
	 9nleyzXTEDsdd9xrIWbZ8dbhsWvqyJIlmKWrm11ZWkf5CSfZomZ5/0QsnBLw91HQqb
	 cPjbAR99qtLBJOhzR6qequiNBP3qX9YI9meZkyeowhN/05ujj9Exo9iOL/NbDSlFu5
	 DANByD0lozLEg==
From: Simon Horman <horms@kernel.org>
To: lange_tang@163.com
Cc: Simon Horman <horms@kernel.org>,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com,
	edumazet@google.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: Re: [PATCH v4] virtio_net: disable cb when NAPI is busy-polled
Date: Fri, 26 Jun 2026 16:15:08 +0100
Message-ID: <20260626151508.1319440-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625013733.29300-1-lange_tang@163.com>
References: <20260625013733.29300-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
virtio_net: disable cb when NAPI is busy-polled

This commit disables the virtqueue callback at the entry of virtnet_poll().
It aims to prevent a large number of spurious interrupts when busy-poll is
active by keeping the callback off while polling.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 26afa6341d161..c1e252400c0fc 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3011,6 +3011,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	unsigned int xdp_xmit = 0;
>  	bool napi_complete;
>  
> +	virtqueue_disable_cb(rq->vq);
> +

[Severity: High]
Can this unconditionally disable the RX callback and cause a permanent network
stall when polled by netpoll?

If the netpoll subsystem (e.g., used by netconsole) calls the NAPI poll
function directly with a budget of 0, virtqueue_disable_cb() is called
immediately. virtnet_receive() will then process 0 packets and return 0.

Later in virtnet_poll(), the completion condition is checked:

	if (received < budget) {
		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
        ...
	}

When both received and budget are 0, this condition evaluates to false. This
skips virtqueue_napi_complete(), leaving the RX callback permanently disabled
and preventing the device from raising further RX interrupts.

>  	virtnet_poll_cleantx(rq, budget);
>  
>  	received = virtnet_receive(rq, budget, &xdp_xmit);
