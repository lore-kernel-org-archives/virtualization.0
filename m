Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546503;
	b=o9p4i9oj/DsJc7IFSRlW4gx0Dm9M/svvJUTONKs+LTxNiW/ZtRFLy/1PvM2P9uU2m3fr
	 vh2ktC1k4SJsMlASIJZSbVi37pciLUORYb6+q7rzJ2xarMzlnIK5hSLbKVt2uRsap6Wfj
	 E1aXf4ztxRkTXgdgG2wFqyA2pGFerAzKauR8n9p5qTTjItOf0aHkeASoC+J4h5/iZ72WG
	 lsFhdonVqdY5kWIwPPQtc+8dWSx771iu25TruEtV6fVW97onpYRQLp4lXbKLZbu+Re9UU
	 3Czx7Fsyb6l3q0zpoTdDxyI3qxxxZSODUETLq3GLkcabWJVcepQzS7K5d74Hu7Cb0kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546503;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RrrCMgJ3wDXc/zCjSsVsylYamdUiiZGnBksOK3TkOQw=;
	b=i1kVf8VFT1UdyTzoGTt9NcbtHvxHvQcO85Sz44gP5IUkkRXkW8KT1IVAbWCmomMRPWpN
	 gC8CPxT5xhgoxSWaWG2lJMuCgfhRiisHOzV1MYE+O2wHFXdFK89fyGLKPiqbLbpjdMZtY
	 4YV3yS+TYsJyKNtNESOujthvqOuAjRfPMLcom+KxpSi8ZR1AB5Plcm2sNn0RQH89ORHE2
	 DWnOb1bPqCxyTY9+j8ppOS7NCy0H+F4HpmleJ3oVABXJf7o759HcfQsjUyICxmmM/tzPC
	 kiVidrFfQrWiUeSNu4vYHDBIksGOjhhfCcsXaT97N973UA6zOLgBtJKxj22+hOPqx9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwgxXx23;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67A606A31A;
	Wed, 21 Oct 2026 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwgxXx23
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1861F000CA;
	Wed, 21 Oct 2026 01:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792546503;
	bh=RrrCMgJ3wDXc/zCjSsVsylYamdUiiZGnBksOK3TkOQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PwgxXx230dZhFycujY1r3ztRThXg4iwUxZDjYIVcBgrQUfJ1FGKjlkWTZriFTAND5
	 /zeeA/coMcRyjwMezIZ4TbB8F3dMmDCtQYGKCTmQu64ZyMAYQLvzNWMv6Hf+UZDGzn
	 7hjAtUHY2+aeQNkarZL3bKAt0tg5s1869fRe7/EurnAAvTs19T9rXzsBVeTSSpu3AV
	 2q6iC5pTG4UYRJLCIOnG1/yoBO9l58FaawOAWiZoctzXnX4BtJNtAi8XfsZGpSEosc
	 xwpi5RdHilx/IrkPV1kDYYJN8q+2ya45u8yIXPc7AOPWjyNV78MDtKMHg5ZUl3QhRw
	 Tn1DC2CHPxJNQ==
Date: Tue, 20 Oct 2026 18:35:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@kernel.org>, <virtualization@lists.linux.dev>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <sargun@sargun.me>, <jlinbox@meta.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v4 0/7] vsock: assign the guest vsock device to
 a network namespace
Message-ID: <20261020183501.6c15777a@kernel.org>
In-Reply-To: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
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

On Tue, 20 Oct 2026 18:15:03 -0700 Bobby Eshleman wrote:
> vsock network namespaces let a host put each VM in a namespace of its
> own. A guest has no equivalent yet. It has a single G2H device that
> cannot be assigned to a network namespace.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed
