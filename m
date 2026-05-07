Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB823FBEDE;
	Thu,  7 May 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164422; cv=none; b=WZuDx9zLJd9/PZpB1WFzxo+ByFd6KTDcSSmbp9aH3wtNDF8deOAsMS3MKQTKrBZ2TDiUpl1S0e7RmAqqGP86pz0LY42M4YxdmvgWWpfLVPmmK1t/TA5Oiue+x1MAvCiW8umKf6ma+zcZ00L7dTXYLD+m4vWaKPmmVFfW9ZffZtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164422; c=relaxed/simple;
	bh=/t+4zQkWn+b1kcYj0Bb28t9/uAuXIPLVUIWHdyAexWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2/ubBGFKcMVraImtiC5fo12gMq4bvxBdxIpTe625wBDhER3OhrDBKt8UvFz8axjSdMbPLatArYqReN2LpzWzVXglDcpE1w4gWIjBP5kZdjCMbaQ4KnoHRsUm46W8TLJ0ugXeGXZOYbcHzLttK2sw+1R6wX3EMhPi35Ocsq5cyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVeZCQjb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVeZCQjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC739C2BCB2;
	Thu,  7 May 2026 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164422;
	bh=/t+4zQkWn+b1kcYj0Bb28t9/uAuXIPLVUIWHdyAexWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iVeZCQjbp4+zTNKDZMoScR+tglVXbaMAq1Hlfhxc1a+Bv67yNMqCbwz8SKT1RhE0q
	 robHo62cHFjzq+l2aivUo5E8e8+ExQI2rh+4+CJMaRTs8pueXvBwI/n6Uv0N91Y5lx
	 cjDGnjTa+IkuvaoNy+ubhjScTMg9sj3MSvZMKBSq2ZDP8yt5jSC/x/wMLclZ1nT3Lh
	 X64USyisalBaO7HMFihJk1R2l5SlUHcPymd9ZqgV9huXl1bUoEJS5+3WLP30KKm9jC
	 Mc097tK8lFoHnrIxwa9JrZ4V5KU6dzp4JwZfxbBlAfDAEKgGNBx05TFwtrNxwk58lh
	 ufOvqmaz1KfoQ==
Date: Thu, 7 May 2026 07:33:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby
 Eshleman <bobbyeshleman@meta.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260507073340.0604667d@kernel.org>
In-Reply-To: <afyMCyBvZpzWrLtO@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
	<afn0ZdvZWswBuDMm@sgarzare-redhat>
	<CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
	<afoF_cHfl6ygcupM@sgarzare-redhat>
	<20260506113554-mutt-send-email-mst@kernel.org>
	<afxVH2So9BbZ3Gta@sgarzare-redhat>
	<20260507074113-mutt-send-email-mst@kernel.org>
	<afyMCyBvZpzWrLtO@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 May 2026 14:59:13 +0200 Stefano Garzarella wrote:
> >well if you want to support pathological cases such as 1 byte messages
> >that would mean like 100x reduction no?
> 
> Yep, but since this patch is already merged, IMHO that is better than 
> losing data in those pathological cases.

We can revert if you think that the risk of regression is high..
Please LMK soon, we can do it before patch reaches Linus.
