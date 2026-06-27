Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1D15E8B;
	Sat, 27 Jun 2026 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521087; cv=none; b=bvpETLJ+ZIhNM42fFvzRBLLUucRYtbcED0i4mLmnnYt78KLQIaYs7BNzkJLYLy26tj0Wse9Z1Jz7RPof5s+WEmupzn5DRSFr7qkdT7Q6thbut6TXp5BEpRD5WBIwMOvl3/a+rWgQGEdDK2sM6xNOlm7V0McawacgGeABm2+UiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521087; c=relaxed/simple;
	bh=kUr2yPQCOsok+8rxx1oCI1yb2iBBXfSozLF9w97A8c8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTX909tjFYsIERs9vp56tMYLFNZy6zBvE+q6ShXPVZHxMBMBkvAsoBQHVmNjsO8YDFvupHO7oOZqefA2h1BIA63Keka0Aqa3CvEQZq1tOLLYRCp8sdXQzf7Ekt1KDi1aK6qBQm5nyoFMvOqI/04UFR1yQtQ18wgmQRwhUc6MQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3IrGto/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3IrGto/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7291F00A3A;
	Sat, 27 Jun 2026 00:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782521086;
	bh=Xft+vbctEr1djAr+KskNxSck9zBs9troo/s4Ve2heuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P3IrGto/ssl/6Aj0KV7T+Mcp2qpZPH2WtCGaQ498wYOm3HGEjWg/xQhVaFoYQHbl2
	 drAJyC+/0xpmPtQV77AMKRAMxKE0xRzY6JwrobJIpo5H3oXLcfu5W0HpWVC5XYB68O
	 DaEvnkJ4umHKsLVLlrQp6vfuQTm4XrujoWigKhf7LI561Z1EXhd/3n9YV5qLTIkail
	 r92R0mgaeJKYLM6iwdVNam3lnHAJu0n9i7IoVl5XTFba54xQIM1ZRsQTdq2LLtzT27
	 gqya1lJy5fQI+sGKvGfbdum8bbLUzCmQU7XKgREtqkJK1Zjra34tcddsQyXPuAvgKP
	 fRZ0Ol0iJybRA==
Date: Fri, 26 Jun 2026 17:44:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>, lange_tang@163.com
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, jasowang@redhat.com,
 edumazet@google.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH v4] virtio_net: disable cb when NAPI is busy-polled
Message-ID: <20260626174445.700df7e3@kernel.org>
In-Reply-To: <20260626151508.1319440-1-horms@kernel.org>
References: <20260625013733.29300-1-lange_tang@163.com>
	<20260626151508.1319440-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 16:15:08 +0100 Simon Horman wrote:
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 26afa6341d161..c1e252400c0fc 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3011,6 +3011,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> >  	unsigned int xdp_xmit = 0;
> >  	bool napi_complete;
> >  
> > +	virtqueue_disable_cb(rq->vq);
> > +  
> 
> [Severity: High]
> Can this unconditionally disable the RX callback and cause a permanent network
> stall when polled by netpoll?

Good catch, Longjun just add if (budget)
