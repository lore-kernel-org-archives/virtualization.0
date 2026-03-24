Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6C39B948
	for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325199; cv=none; b=j7tcJiKa7W2Zbch2yTsonFnkETuNoxV+6NG82RLRwZr9pjJ7rTdwxehPrQOiCNUeb2Vk0F8jphFGnDlWBgzJNkfqPFpo5C6dbm7WFtESKlR0tHsr2gkvxNh/XJaYuJkzlqE89s6H5K7xh591XWAFhmYn8RqU3gIKEOgd94wqC84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325199; c=relaxed/simple;
	bh=BpeoYm2me6K+Dc6+M7uak6KdTN0vdOyhFUGGh1WvVVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbLc8Lo7OIKr56aCoTFQGNutQ3aygRriO70p1gPvsbWHY8cfLwVwmYJwsa6fLyAlMhJ+A3cQsfsAxZhLFCm9xdAkDKsGzsme5MeWhByzh2QGnvMv6SAo7SMMgIocCI1Z6oGwtbPKp9AzGrCDjQQme8NOdrfeknUKP1rW7odZ/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PfaN31bo; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PfaN31bo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=AEw0ALkfl/eEyK8p9OdBYjDi13UrriYKZIfwNtIhTxU=;
	b=PfaN31bo6Pa+Muf/7pXaU2aOV5b101wvtrv8P8hsNKqyEWnUsEd9vbvt+nEUn0
	12XPJkQxBohvsdBVIQxJuIptGU+7aa6BivCdb1DVx4b6uXckO29h6gZefIHtmpXy
	f1U0KwMWlkUGP/mk+CRTnKQNnGFbXmtfoeeMP94H16Ppk=
Received: from [7.247.167.152] (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgDnP4LIDMJpyYMBAA--.3218S2;
	Tue, 24 Mar 2026 12:02:17 +0800 (CST)
Message-ID: <8f918b23-5877-4963-a048-5783f11f264c@yeah.net>
Date: Tue, 24 Mar 2026 12:02:15 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when
 IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260312025406.15641-1-xietangxin@yeah.net>
 <20260314124017.59206dac@kernel.org>
 <CANn89iJHp+nCcAo7tzMTfH5yW2qDsEXP_u=RzdV=DC9ZvDH9Fg@mail.gmail.com>
 <20260314181243.177d4ab4@kernel.org>
From: xietangxin <xietangxin@yeah.net>
In-Reply-To: <20260314181243.177d4ab4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Ms8vCgDnP4LIDMJpyYMBAA--.3218S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW3tw4kKF4UXrWDAF43Wrg_yoW8Wr48pa
	yIqF4S9F4kWrWxCan7t3WFqryjk395ua42gr1kW3sIvr45u3WF9r18Zw45WFn0kr4kXw42
	van7Xr95KF4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIzuXUUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiIglAdGnCDMm4NwAA3+



On 3/15/2026 9:12 AM, Jakub Kicinski wrote:
> On Sat, 14 Mar 2026 21:11:33 +0100 Eric Dumazet wrote:
>>> On Thu, 12 Mar 2026 10:54:06 +0800 xietangxin wrote:  
>>>> Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside the network namespace")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: xietangxin <xietangxin@yeah.net>  
>>>
>>> The Fixes tag should be:
>>>
>>> Fixes: 0287587884b1 ("net: better IFF_XMIT_DST_RELEASE support")  
>>
>> I disagree
>>
>> What was the situation before this patch ?
> 
> My thinking process was that it's fairly unusual that the dst is kept
> because the stack decided so. Normally its the device driver that asks
> for dst to be kept when its xmit is called. I thought 0287587884b1 was
> the first time when stack could make the dst decision behind device
> driver's back. But my analysis was very shallow, could well be wrong.
Hi Jakub and Eric,

Thank you both for this deep dive.

As Eric noted, the root cause is architectural (the per-netns dst_ops),
but virtio_net with napi_tx=N seems to be a particularly vulnerable trigger.

I have verified that the TUN driver is not affected (discussed in v1 [1])
because its lifecycle management of skbs is different.
However, I haven't check other drivers that might also defer skb freeing.

Should I wait for a consensus on a more generic fix in the network core,
or would it be acceptable to land this targeted fix for virtio_net first
to address the immediate UAF?

[1] https://lore.kernel.org/all/4b8a6182-da50-4edb-a34a-b75ed784f1e2@yeah.net/

Best regards,
Tangxin Xie

