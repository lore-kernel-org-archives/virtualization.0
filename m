Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7F32C8B
	for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432002; cv=none; b=eDKrCJXy7gW9JQf+Z15enSD2YfgXYiztPyWg7S/8nzsmg8HS5F5cbmsDsbenPjaT7NbQcm+qtUAuYo86UohJkAN/uHj+CAGgVR/uHDixf340GHE7kOWxstxxnQKu4IdepwJN/cLC8z8sqQhrvdAr9m1zv+wSMptxIOgR8QgeDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432002; c=relaxed/simple;
	bh=V8ILNRycnctlx/yOK6n8nBlj8d32lWGWZ4pfWzD5iFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3Ld9DYkQILDD38wXttMqljCZJHJGeWC6oADbFnAOogtLywjKk+Hsa2WNGI0x8gBL0OTXNeQ2kClpOeAA/8eAEKUMggumDROm/2q5R4oRHGVE93WmMNCQnsZpArTEJq02Mh36+r9XhRXSaHb+fPbA8fJttolkf7y1HC3fex3zuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=keN1i+Xz; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="keN1i+Xz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781431997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JqdQnygkXzMaJ6mt2m2i9i/0wK8Xf9zkeWFs7G9YnSw=;
	b=keN1i+XzPhw3q+UVIxflyveBC6Pq8TVXYfrfwfsMc9rSNLicLDzplzy2EbhwdIX6vCvsTl
	rUEhj2+St3Wbsw7jDNB8QUWWLLp5MdCOcjxzaF5nvALqzXQHeiJbO1MgTdXUWTYma6qEIr
	/fQJ2Y1zXfi9D3wI1RxEfpveL4EN+mY=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, Jakub Kicinski <kuba@kernel.org>
Cc: jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bjorn@kernel.org, kerneljasonxing@gmail.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
Date: Sun, 14 Jun 2026 18:12:46 +0800
Message-ID: <TYn10tJ2SIGF1pAhF26DRQ@linux.dev>
In-Reply-To: <20260613112113.55d9313f@kernel.org>
References:
 <20260611071242.2485058-1-dongml2@chinatelecom.cn>
 <20260611071242.2485058-2-dongml2@chinatelecom.cn>
 <20260613112113.55d9313f@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/6/14 02:21, Jakub Kicinski wrote:
> On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
> > For now, we use sk_busy_loop() for both rx and tx path. The sk_busy_loop()
> > will call napi_busy_loop() for the specified napi_id. However, some
> > nic drivers have tx napi, such as virtio-net. In this case, sk_busy_loop()
> > doesn't work, as it can only schedule the NAPI for the rx queue.
> > 
> > Therefore, introduce sk_tx_busy_loop() for the nic drivers that support tx
> > napi, which will schedule the tx napi if available.
> 
> First, I thought the only difference with Tx NAPI is that it can't be
> busy polled. So if you want to poll an instance don't register it as 
> a Tx one instead of adding all this "tx polling" stuff in the core?

I see. Register the tx NAPI with netif_napi_add_config() allow us
busy poll it. But we still have two NAPI instance: rx NAPI and tx NAPI.
sk_busy_loop() can only busy poll on one of them.

Before AF_XDP, we don't have the need to send packet via tx NAPI, which
means that we don't need to busy poll it.

I analyst some nic drivers on the implement of AF_XDP. Some of them
will check xsk tx ring of current queue and send the data in it in the
rx NAPI, such as mlx5. Some of them will allocate a extra "rxtx" NAPI
for the AF_XDP zero-copy queue, which will poll both the data receiving
and sending.

In the case about, they will do the data sending and receiving for the
AF_XDP in a single NAPI instance.

However, some driver receiving the data in rx NAPI and send data in
tx NAPI for AF_XDP. In this case, we can't use sk_busy_loop() for both
rx path and tx path, as we need to wake different NAPI instance.

> 
> Second, can this problem happen for any other NIC or is it purely 
> an artifact of virtio's delayed Tx completion handling?

According to my analysis, only virtio-net and ICSSG driver have
split NAPI for AF_XDP. I don't have a ICSSG nic, but the codex tell
me that it does have the same problem.

I'm not sure if it is a good idea to introduce the sk_tx_busy_loop().
Maybe we can modify the driver instead by using the same NAPI
for both data sending and receiving, just like others do. The
advantage of introduce sk_tx_busy_loop() is that we can split the
data sending and receiving, which maybe more efficient.

> 
> Third, this series does not apply.

Ah, I'll rebase this series if a V2 is acceptable.

Thanks!
Menglong Dong

> 
> 




