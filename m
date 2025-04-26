Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09282701A7
	for <virtualization@lists.linux.dev>; Sat, 26 Apr 2025 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745649090; cv=none; b=ngkccAAxrrJJtW6C6LIrYYtkAx0Nh369ehX+bTTbfi5roUFNwhIEYm+0XpJmBnvVdobFgXH5WMl992mIEdoDx1pthwYwhYpBm7APj74YBu9OgN5KtEaRJC3r0tE9FAxT3RisCqrRBxjuN14OHl2+rbk+ArrBE0iAvh69RLOVkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745649090; c=relaxed/simple;
	bh=LStxSYSMQWQfySUUYevBrjI7tk6cSXHz2Zsm/0azcgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6M8UdT1QiaIkrtUXhrIR3ZZq480KjgBlMqECkdChMC3CVhF79lVWz6m2laTB+jvbvKmPs2V2TFSxIQx5X157f1GiZbgC9CFs6RNYxmta3RcvytUdPn0k1jKyjowerKHPAkAZ97Bu0AldQ3XdgCTs2kwRgAOD3PIjkLRfIetY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dO3h3FBk; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dO3h3FBk"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 8Z4AudHRUAix78Z4DuSQ21; Sat, 26 Apr 2025 08:31:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745649079;
	bh=5noqtwG52h6FrrE55CMqaxj5XRYDTBNIEIbRi1Rpv78=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dO3h3FBk53n0URP5sGWwvqGIIC7nb3y3Qme+QXyz0HxA0rlcgxtDXrebZJiX2CmDc
	 tQLJT2yCS16OVuENKMNuYvjlbwrh+AutA7W3UtRL9GcOGf2z1Tdab2igjI+ARLQ0SA
	 i7Y3q68HodHMA7Yn98R4+0eVQ52f3Eyksb5aJr0TgYAlm2wb443OmPmdluHVQGE1T/
	 SrGw1yj0NdSyS7TnO0VbN/W1MjZ5YG7UkrIHiv8fahuHWp4pOuMcP9+VmKsXqFQWuK
	 fhtmBSFWu7WWOHyFXLtIKOOHhcDFZOw+qtMXOfLdCelB7DoQirXCvB0j0CfazUJKGP
	 lJwTTNeNMHZNg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 26 Apr 2025 08:31:19 +0200
X-ME-IP: 90.11.132.44
Message-ID: <a70511f2-70b2-4f48-94df-c55c179ce488@wanadoo.fr>
Date: Sat, 26 Apr 2025 08:31:10 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
To: Mina Almasry <almasrymina@google.com>
Cc: andrew+netdev@lunn.ch, asml.silence@gmail.com, axboe@kernel.dk,
 corbet@lwn.net, davem@davemloft.net, donald.hunter@gmail.com,
 dsahern@kernel.org, dw@davidwei.uk, edumazet@google.com,
 eperezma@redhat.com, horms@kernel.org, hramamurthy@google.com,
 io-uring@vger.kernel.org, jasowang@redhat.com, jeroendb@google.com,
 jhs@mojatatu.com, kuba@kernel.org, kuniyu@amazon.com, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mst@redhat.com, ncardwell@google.com,
 netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
 sdf@fomichev.me, sgarzare@redhat.com, shuah@kernel.org, skhawaja@google.com,
 stefanha@redhat.com, victor@mojatatu.com, virtualization@lists.linux.dev,
 willemb@google.com, xuanzhuo@linux.alibaba.com
References: <20250425204743.617260-1-almasrymina@google.com>
 <20250425204743.617260-2-almasrymina@google.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250425204743.617260-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

below a few nitpicks in case of a v13.


Le 25/04/2025 à 22:47, Mina Almasry a écrit :
> Later patches in the series adds TX net_iovs where there is no pp
> associated, so we can't rely on niov->pp->mp_ops to tell what is the
> type of the net_iov.
> 
> Add a type enum to the net_iov which tells us the net_iov type.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---

Nitpick: unneeded empty need line above ---?

...

> +enum net_iov_type {
> +	NET_IOV_DMABUF,
> +	NET_IOV_IOURING,
> +
> +	/* Force size to unsigned long to make the NET_IOV_ASSERTS below pass.
> +	 */
> +	NET_IOV_MAX = ULONG_MAX,

Nitpick: unneeded trailing , after such a terminator.

> +};

...

CJ
