Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618866;
	b=yEe4wC9p4ma/snLNFqcdK6Ed9TIMLS1hNKUtIWv64Gl341kAxuFwTGaKIyijIsuudJ2I
	 oJ0UnT0UxVLi8GXY18yaGwIgvzJsVJ90dqNgJ3XeMC09P8TALWA9aeSEQUmIoinqJOFiS
	 Sxt2qdhd8/N84E+bCqJ/6o1YFHmBJd5V86mUT6XVZgmX8tQe76eWVhzWEPttmh9QmWbAP
	 15NQcgQJn4+lvfp9T69dxRf0nrnuKSiW7rMwFF2V5HB/eqiGRV/6hdbqpG2xVR8Puzcju
	 yw3xh/K+q8NN3nN0nAoXj9E5DAnWBVjxjf/8FssE2qsSP4bARpY2mzNQUDAk6rKBBHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618866;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TEl1DgfXUA5pWV0ULqPFDtP6OTn2CRZgvQuqRoLVd2k=;
	b=vbME1SJBQaK+iwRWiw/uKNi+6hiJ1OwGddbf/odL7moRVQbsxGx6vgGNaD/mbZ55jXQr
	 E2Y57LShEWdYUZ9GRUsqTIqLW0nqeFDdJW2zo0mApEOQD/Xnh4ZR0Lpf/2tF+Ae9lvNn3
	 O6hIS1rcWPoncUftc+IxaArHoeL/AOyEFdwNys7JZgzWQ8SaQAqCY5cI87yemTFuo1rJ1
	 qIOIvuGTKkKHDbw/sBjjY5CaiaFISlnkvenhfc+iNuKffx+BdIbz356f9XGdulsMUQQfR
	 VYAM0szThOhE4OMUlxkl/4K14seM8uVYwMPNHB2olUoKq+L/omtQ5Jin3vxH0201EpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=UdlUnKwa;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C27D606A32C;
	Mon,  2 Nov 2026 11:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C27D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=UdlUnKwa
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xNqCJ-00BSF2-62; Mon, 02 Nov 2026 12:27:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=TEl1DgfXUA5pWV0ULqPFDtP6OTn2CRZgvQuqRoLVd2k=; b=UdlUnKwa2wwdsv4p1NZcbSZeV7
	t4UOZnJaFeNb1oOLIegteX+/dZrJeyljqcQ8j+DemSAkcNZ9NA6RWxLB1qHZwZpB51BTC6BQllue7
	kUMdtmojCpnGTa7941e3k/nOmpzV90w9kZJo+S6M0WLvFJcPy3x0eW7Okn9UrI0Mho7XOqc1/gDPz
	J7OgLEcen16fXD3G+0uHsUVhj/SkBoJl+XumCZkg+45U3u6GRIH5EaDajhTqxh8WHW1GAr4INWy4d
	nUkOjpuLeOMmHg40TB5oRoTVszVeAuf/LQnMd7teaFJCfeGJI7wxfjhsnD0t6bOizG7rupdqMfw7W
	shLj9clg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xNqC6-0001gG-1k; Mon, 02 Nov 2026 12:27:18 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xNqC0-00BRqT-Uz;
	Mon, 02 Nov 2026 12:27:13 +0100
Message-ID: <44aa83c2-042b-4d4f-9f9c-f9be8b0fccc1@rbox.co>
Date: Mon, 2 Nov 2026 12:27:10 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next v4 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me,
 jlinbox@meta.com
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-4-047527cfccfc@meta.com>
 <atjZZP2ebhXKzMxL@sgarzare-redhat>
 <atld3+5LKmGxJ8+s@devvm29614.prn0.facebook.com>
 <atnjOZjKUBagRVWq@sgarzare-redhat>
 <d946003a-8bec-4e8b-89a3-05eeb96780cc@rbox.co>
 <auT+YIawHSMPHbJI@devvm29614.prn0.facebook.com>
 <5a411a67-f550-459d-be9b-5e8e51d3018c@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <5a411a67-f550-459d-be9b-5e8e51d3018c@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 02:21, Michal Luczaj wrote:
> On 10/30/26 21:30, Bobby Eshleman wrote:
>>> virtio_vsock_reset_sock() and vhost_vsock_reset_orphans() are my pet
>>> peeves: state switcheroo without taking lock_sock(). Which, again, races
>>> vsock_connect().
>>
>> True, I don't love that either, but I feel the impact is at least
>> constrained by the fact that it only happens when the module or device
>> is already going away.
> 
> Doesn't it happen on suspend as well? Is so, with a poorly timed connect()
> things can go south on resume.

What I wrote doesn't really make sense, does it? vsock_connect() cannot
freeze midway, so SS_UNCONNECTED (due to virtio_vsock_reset_sock() flipping
state to TCP_CLOSE) can't be set. Sorry.

But it is still the case for bind/unbind, right?
