Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63F3BED44
	for <virtualization@lists.linux.dev>; Fri, 10 Jul 2026 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669225; cv=none; b=EpSm+m1QMCHHbvBoxMJJCvZg9vZEI2yxvtuNm6aWRJm2ZrzGYIyXEPPHEKRLEMGC4Sa2qoLVcENgCNvEt+XRJzu2FTGkxUPnbaNg1IdhBrqVTkhzEBNYBm8yhqkHZ8Ja+d2aeCKNkDXemhwC/lHZBeGiHfv+1zP8PpuqX8Bnjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669225; c=relaxed/simple;
	bh=86pzGDg38uXFCW2JGOwA3e085I/3QBH3sZ2DZZ2NCCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBzifMgw83o1AqLWDmSZMg3aNOc5Db/2ifSP5OuYglS2dAZoPKpevsXY9Lwh/S1V2ciAWs4DQGwfotLNnEsyy+OISbEeoHYJd6ifuRi8QUkhScLq0zMrrcMaftZXwoXJYOCJlI7PAZ8eXfArQ6MCr8xwyaajMRXVX30vS+LRe40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j/kSjpFx; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j/kSjpFx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783669221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAnobAo08XVC7dBk56KDBO/XbkEzdxpuiaM6tAGNrhk=;
	b=j/kSjpFxwqdqn+fL4fjSsxFArocXZQCkElUZ6k8kB9P/B0NcyRHptDeOIPd/HQ5xEP3gpF
	082wQYQfhWRV7iPi4IAbrTRLU+C0OuM8+7fPSJ2xHyZuuKBXYIotk4VIJ0JIno7Q8UOPVE
	nXuwxp62d5mGIpuzA5xXx2QUsalUByg=
From: Menglong Dong <menglong.dong@linux.dev>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: menglong8.dong@gmail.com, Jakub Kicinski <kuba@kernel.org>,
 jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, magnus.karlsson@intel.com,
 sdf@fomichev.me, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bjorn@kernel.org,
 kerneljasonxing@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
Date: Fri, 10 Jul 2026 15:39:57 +0800
Message-ID: <NCm5lbjeS9uYIxdwTdjp7g@linux.dev>
In-Reply-To: <ajJrckiXEUztBQDz@boxer>
References:
 <20260611071242.2485058-1-dongml2@chinatelecom.cn>
 <TYn10tJ2SIGF1pAhF26DRQ@linux.dev> <ajJrckiXEUztBQDz@boxer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/6/17 17:40 Maciej Fijalkowski <maciej.fijalkowski@intel.com> write:
> On Sun, Jun 14, 2026 at 06:12:46PM +0800, Menglong Dong wrote:
> > On 2026/6/14 02:21, Jakub Kicinski wrote:
> > > On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
> > > > For now, we use sk_busy_loop() for both rx and tx path. The sk_busy_loop()
> > > > will call napi_busy_loop() for the specified napi_id. However, some
> > > > nic drivers have tx napi, such as virtio-net. In this case, sk_busy_loop()
> > > > doesn't work, as it can only schedule the NAPI for the rx queue.
> > > > 
> > > > Therefore, introduce sk_tx_busy_loop() for the nic drivers that support tx
> > > > napi, which will schedule the tx napi if available.
> > > 
> > > First, I thought the only difference with Tx NAPI is that it can't be
> > > busy polled. So if you want to poll an instance don't register it as 
> > > a Tx one instead of adding all this "tx polling" stuff in the core?
> > 
> > I see. Register the tx NAPI with netif_napi_add_config() allow us
> > busy poll it. But we still have two NAPI instance: rx NAPI and tx NAPI.
> > sk_busy_loop() can only busy poll on one of them.
> > 
> > Before AF_XDP, we don't have the need to send packet via tx NAPI, which
> > means that we don't need to busy poll it.
> > 
> > I analyst some nic drivers on the implement of AF_XDP. Some of them
> > will check xsk tx ring of current queue and send the data in it in the
> > rx NAPI, such as mlx5. Some of them will allocate a extra "rxtx" NAPI
> > for the AF_XDP zero-copy queue, which will poll both the data receiving
> > and sending.
> > 
> > In the case about, they will do the data sending and receiving for the
> > AF_XDP in a single NAPI instance.
> > 
> > However, some driver receiving the data in rx NAPI and send data in
> > tx NAPI for AF_XDP. In this case, we can't use sk_busy_loop() for both
> > rx path and tx path, as we need to wake different NAPI instance.
> > 
> > > 
> > > Second, can this problem happen for any other NIC or is it purely 
> > > an artifact of virtio's delayed Tx completion handling?
> > 
> > According to my analysis, only virtio-net and ICSSG driver have
> > split NAPI for AF_XDP. I don't have a ICSSG nic, but the codex tell
> > me that it does have the same problem.
> > 
> > I'm not sure if it is a good idea to introduce the sk_tx_busy_loop().
> > Maybe we can modify the driver instead by using the same NAPI
> > for both data sending and receiving, just like others do. The
> > advantage of introduce sk_tx_busy_loop() is that we can split the
> > data sending and receiving, which maybe more efficient.
> 
> Would be good if you back your changes by any performance numbers. I
> believe that drivers do tx processing via rx napi as before AF_XDP it was
> only about cleaning up writebacks, AF_XDP added more weight via actual tx
> descriptors submission.
> 
> Maybe you can vibe-code virtio-net to work only with rx napi and see what
> are the results.

According to my testing, there is no obvious performance improvement
with tx napi. I'm going to implement the xsk tx queue consume in rx napi
instead for virtio-net.

Thanks!
Menglong Dong

> 
> Side note/question - Do you have a tx-only use case for AF_XDP ? I am
> planning (for a long time actually) to implement asymmetric AF_XDP
> sockets. Currently for ZC scenarios xsk socket occupies both rx and tx
> queues even when you do rx or tx only.
> 
> > 
> > > 
> > > Third, this series does not apply.
> > 
> > Ah, I'll rebase this series if a V2 is acceptable.
> > 
> > Thanks!
> > Menglong Dong
> > 
> > > 
> > > 
> > 
> > 
> > 
> > 
> 




