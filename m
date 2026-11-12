Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480796;
	b=Ke6oaI0/PZ5V/gag844WAufQGvND+thSOwbBWACyVuR75PYD/qvDyFThC8yFvoqrTeFR
	 5p2RPtrtJIjXJfNG61Jpem1617Whf/XcKSbw7kbR/BMoW8WYY6Zp9tfmKBkvSurQpG4jd
	 koiN5TMx9nwry2qCo9EzWK7NjfiPeEK0C+c5W9+bEtOjFyk3Sm7Wvfig2koIJVrhKLTgK
	 03DA85uqcZL1LQFhNAsaaMLDLgYOuutGKnbH1lsllpVqZmcwTf+CKCyvZywmlJOtcNyBI
	 KvqY4WMeWd9toHCfi7kdN9PJem53S61hUbOwBQvFyKXQWoF2OrWtROxLUkr9lK5cI4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480796;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YkfsgtQgDkRJaBVA+m0bj+SaLpO/MI4c2Nw9+WXxjHw=;
	b=jYwUmO0qhlu89NfRxT6JjObu9iDGlE5uYzg3Mt8wbNld8h3mQuexApHjCn4obzNcFczv
	 NUkDiE8zyNutOCAU+VlqtGYLGMvoE0CETo1pUveGI45VNhmt2s0aPwtHtiR1wcOdThwem
	 3GFvion7arC1zi+OX1TCbrkwGg0nQQY1TSie4QncFdxlP8mXyBFz+TA+TIXaGqTm1QSQi
	 Tzif6e99oJsO89LRcDXo1h9bfWFG7oz1CNCxg1qkBy1WPDucaBTaCQ2JQ6CaCinmizHWG
	 Sey8gNalHCyMnyBAwwLFRgsy5fRg9PaG5y/WwTnXgOkaWxEUjg20dT3JrIuJb2vRcrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=vA5prnCr;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1867B606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 10:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1867B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=vA5prnCr
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xRSQY-004UYJ-LY; Thu, 12 Nov 2026 11:53:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=YkfsgtQgDkRJaBVA+m0bj+SaLpO/MI4c2Nw9+WXxjHw=; b=vA5prnCrpzhzImvR6dL1hZ5aRx
	7AZfRRw/AHFTjjH14a9+SL6btoKJD7r3qjUU6vZluBY4yiXzj4EkPT7O3tsVzytYT9F8Q6omZRhfC
	rjSP+lIYyhcccVt4FQ1thHaQ3EB6KMYIe/k57NBQvE7wNuU7BcbkkS9ovsfC6acXFlZtcWsM9txun
	FJ2/cNs1c28l736y6d8qTxoZ2gOebmT3UyROCGjzS51oBTV7NUGLlU0rIXGpJBU9fe5CFAQJcq0nj
	ZkQsf115+s82VBjiu2kpUJLwMUDvyKVnUlu0npvonOx6HadHmshrDy+wIJxfA6Fzg6b31WLoCZrH5
	IrE54w5A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xRSQT-0004QY-4T; Thu, 12 Nov 2026 11:53:05 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xRSQD-005W3c-UH;
	Thu, 12 Nov 2026 11:52:50 +0100
Message-ID: <b4dbeace-95ad-4b0e-8f13-a418ab59e8df@rbox.co>
Date: Thu, 12 Nov 2026 11:52:48 +0100
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
Subject: Re: [PATCH net] vhost/vsock: Fix socket state constant
To: netdev-bot+sinfo@kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261112-transport-reset-state-fix-v1-1-5698375f52a9@rbox.co>
 <179447976386.2168702.18392043659968828325@kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <179447976386.2168702.18392043659968828325@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 11:36, netdev-bot+sinfo@kernel.org wrote:

>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Discovered by reading the code and not getting it.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.

Not triggered at runtime. It's a correctness fix, I didn't try to work out
what could/would actually go wrong.
