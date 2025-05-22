Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84727F742
	for <virtualization@lists.linux.dev>; Thu, 22 May 2025 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953024; cv=none; b=VeCFHVX69G55SU0hw9KceFOBlCYRS9HRDXK9srZNocPXrm7yaQrei02RAnU1FfwQo2S3kutaiVNqpwhJkqtwksFpWg1bEpTaQifuFIpHRt9aTBE0gBmtjUV5WxbUWukQMhbnCaAn17wmPypOxMPLS3XPqFhDYjsAtImiQOcrTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953024; c=relaxed/simple;
	bh=6nlrUA/fMTKOObBYQK+Gk7I0UmQ0/p3SwQAXUH/DDgo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a333T03bfF01hlr93DtFPlJCsF5Lr4WzOMLzcdrFCfEs2X4OhsDp6g32ntqHRo3EUMMbczURULV1uFcrwiH/z9OPcXEBjnsmu9U0ek2RJefs509y/4XTlSnGIYfDew77YN320kANMAUo80h0JYefRpW/UxvpAfMVlfrCDG9tuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=u1MWOB5X; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="u1MWOB5X"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uIEQS-00778w-55; Fri, 23 May 2025 00:30:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=aGuZyX3fslrEUusqSYEFKL1p6x06fg8Wgbqcbb2KmYE=; b=u1MWOB5XWOn6QImSwmqJF4Utap
	WRmuDzFaLw8ppqdg8znfYdo4n1/qc7bGnEDjfEqOzwvcCHzUWespFsxLqs3/liNG5xlmN11sGSFsI
	klX80AXVXd9P9GWrRXuCGA/Hp/7OUN4HCeO/q/BuoDnDozy1d5Q4QMDNg9rxequ+Pll8eJkLrMV4N
	lK4UkRXYIptC3Gy75UreI8kl45hggwfp9kUvjdd7G2JKRcWKENjcGSjZvk9hY73/Mlo56Z/GHCLpy
	kBKz66JXRn5UcYd08yMJjYDqHUNa6/3rntgksf7/zACbM3SEkou0r61KNB8Th7ZSpaAfrwpGTVhl3
	3hnBloWg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uIEQQ-000437-T4; Fri, 23 May 2025 00:30:07 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uIEQC-009KRJ-Dv; Fri, 23 May 2025 00:29:52 +0200
Message-ID: <6d6b2f04-fc4b-436c-a963-f4f8977bed37@rbox.co>
Date: Fri, 23 May 2025 00:29:51 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next v6 0/5] vsock: SOCK_LINGER rework
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250522-vsock-linger-v6-0-2ad00b0e447e@rbox.co>
 <kqm3bdj66qkziz27xsy6k6rnyminleqvebgqoudmufa424jlzm@khnzut7q4nqq>
Content-Language: pl-PL, en-GB
In-Reply-To: <kqm3bdj66qkziz27xsy6k6rnyminleqvebgqoudmufa424jlzm@khnzut7q4nqq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 10:08, Stefano Garzarella wrote:
> On Thu, May 22, 2025 at 01:18:20AM +0200, Michal Luczaj wrote:
>> Change vsock's lingerning to wait on close() until all data is sent, i.e.
>> until workers picked all the packets for processing.
> 
> Thanks for the series and the patience :-)
> 
> LGTM! There should be my R-b for all patches.

I think it went smoothly, thanks for the reviews :)

Michal

