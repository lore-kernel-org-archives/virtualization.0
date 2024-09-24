Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6151A7ADE
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183160; cv=none; b=K194RdKVs1l/TBcq/V4p39Bd+yNXPWJO0/oaGm5l5hCZ+wu8NOOs+4Hfnw2r6V9c5CDfpBHV3XrV7bgworMeR93ydN9SuouCKbCJX/3C4dCzEjn2g/Ci3z9QXo9d4v0dQOHr0Rz9Ai6E0uJuXtx/QyQGm/aMFJU/Y+m9aNq3bkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183160; c=relaxed/simple;
	bh=Qjfkvp5NGxGZwA6T1g5vVDbjGsM0vKbe4sPFNhJ0gMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vnk0BCwBNOGo2DIiRLVsDGdOgAIMmreB4ny8pINQ6m41S+1MqwH+wj3zwJ/D+AQdbLUPTi+o4i1D3YfJkZpeskJCDcpoOiHFshVVUivU2uy6eDgcn9XJTBiUvh5+3ZCTd1DFC2EoV/X0gVO0YZm+4shgibQCMb9mw4sFB4DiGVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCwvZzHT; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCwvZzHT"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3D7E41A64
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 13:05:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -10.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y66CxNKS_Xe2 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Sep 2024 13:05:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DB2F141A4A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB2F141A4A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VCwvZzHT
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB2F141A4A
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 13:05:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AC3135C5BBB;
	Tue, 24 Sep 2024 13:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783F8C4CEC4;
	Tue, 24 Sep 2024 13:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727183156;
	bh=Qjfkvp5NGxGZwA6T1g5vVDbjGsM0vKbe4sPFNhJ0gMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCwvZzHTT9yxyAvB2n8zK8p7WY1pmoFea6z+aE9IL/IfzVWoVPfR8uXfaU1uK+Sg4
	 zytQ0T1k6W1qH0L5t/uHf2w+AEW0SGL7DvqCAjU74Odo7Wm8BteRNN7kq7KY+XFQkm
	 i4ctdi7zFur41pQbVczHrkGGZ/3C0kAn0E3FV44J9fauG//51XXrDXq5ZzDqfyt5Ll
	 PvTuujfe5rWsvl4Osrr/I4gIbY55YZZcATwE26ximLa+qdY0W7GCmLr3dP5PxsxSzx
	 6oy5XMuOsaf3CMtuZXH8HYDZLvglkF40PDca9mcjQnY26jq87AL467dB92HqgOAiwZ
	 xpJVQjjHct5fw==
Date: Tue, 24 Sep 2024 14:05:50 +0100
From: Simon Horman <horms@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com
Subject: Re: [PATCH RFC v4 7/9] tun: Introduce virtio-net RSS
Message-ID: <20240924130550.GJ4029621@kernel.org>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
 <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924-rss-v4-7-84e932ec0e6c@daynix.com>

On Tue, Sep 24, 2024 at 11:01:12AM +0200, Akihiko Odaki wrote:
> RSS is a receive steering algorithm that can be negotiated to use with
> virtio_net. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
> 
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF steering program.
> 
> Introduce the code to perform RSS to the kernel in order to overcome
> thse challenges. An alternative solution is to extend the eBPF steering
> program so that it will be able to report to the userspace, but I didn't
> opt for it because extending the current mechanism of eBPF steering
> program as is because it relies on legacy context rewriting, and
> introducing kfunc-based eBPF will result in non-UAPI dependency while
> the other relevant virtualization APIs such as KVM and vhost_net are
> UAPIs.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

...

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c

...

> @@ -333,8 +336,10 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
>  		return -EFAULT;
>  
>  	if (be) {
> +		struct tun_vnet_hash_container *vnet_hash = rtnl_dereference(tun->vnet_hash);
> +
>  		if (!(tun->flags & TUN_VNET_LE) &&
> -		    (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT))
> +		    vnet_hash && (vnet_hash->flags & TUN_VNET_HASH_REPORT))

Hi Odaki-san,

I am wondering if the above should this be vnet_hash->common.flags?
I am seeing this:

../drivers/net/tun.c:342:44: error: ‘struct tun_vnet_hash_container’ has no member named ‘flags’
  342 |                     vnet_hash && (vnet_hash->flags & TUN_VNET_HASH_REPORT))

...
