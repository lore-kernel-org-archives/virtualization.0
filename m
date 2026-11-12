Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=79.135.107.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794512839;
	b=nj6fZLSEbi4usRRX620K0CMb6RkVH5DsxofaLo4dlooLwBNHjuzzfmrjzpA/WMBPMYsS
	 Cg4N+NKCnri4B2BgRmZPoWP8mdDvOyMBnhgH52hICVzZRRw7lO9T8QUbRLN0hR+sRHpBx
	 WGqIXUMFzUjl2RB6Hqm4pIZKD9cWjy+ZAD1mGl7TKQ6UUsedbgo9vy+lAW1vaNzSadY0q
	 UNA5CU7am7jby/4rQ8ojzjduCFMqZdKG2vgQlSyfgV4+zhu46g958whG4t6bXM9udwEZm
	 q7csmbbMqKoRqgYKSB9ENMP+turpTAG4h2DD2CklKznmo2p0lNlWVUa05Y1sqDHBcww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512839;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=ivl2fzOJBQU4OmEbMUJ0rBy92j+Wag+ptYQzVvr86dM=;
	b=MRVGLJTW8Ju0SqrUfWbEh0Wx4DG3HpKZeTUlIlSH9JJTANnylhvDMCm+Ev5UrVdAtnRr
	 wtQulY94ZJdnODs/Oy7+c3ibAZIOFd94PgGIeiJfRqZAyCQm9QREnroEs2L2Lz7P/wUZb
	 b0dcUez/H+nAFzvctD1/Alzrfk7vKvFm8MU/vc7KKt7yFiKyXT2drh2N3zKCylWryHL4I
	 Zt2/8ufZUDgb3hxxwYGFNS2fh/hytIDU5pEMSUTbwjtFGUp3fB0H3SmTOCrGhsCZmSnmB
	 IuUAolZ0gG3/smhMzqYBaVeaDanhaFdYnZzQYDG+MwEuEFo8odwb6h5L+yA37IAi0hA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=tZnT5CS6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=79.135.107.171
Received: from mail-107171.simplelogin.co (mail-107171.simplelogin.co [79.135.107.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17170606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 19:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17170606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=tZnT5CS6
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1794512836;
	cv=none; b=lQYvtklKl1dAk7CYylbkBDOYq+ona8c+b3VSdF8oPwt+znK7vaJiFKVRTmkVlcInS7RVcekbfb8HvZSqrfirdiTqsPm0frMQKNJ51zLku+qmxsPB3CUqh+HYNqvjWIY2s7kuq8JJYlwZOOWnmXrnwASXnJrIT2iurs66qSeGmeFxfEElpM24CB2x2e11gXLggSMmdkTKE43oAhGN3OMnGWpDEvIlyIbGVI66YfqocO5A58KZm/fHlwxjxWN/t3Mox/etU8pmH9IZTHyBNdJz4kt6Bu9OZ1d5qCzewFqV/1kstNd57iUuKKBiUTO8twqhOS60OexjyNvOq4q/3qxqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1794512836; c=relaxed/simple;
	bh=ztgw636+7zmYYSIAXD/3iv7hAPBrWzov6S3L7gOj9Xo=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=ROeBGIDNyCrfK69DeMcJXsq1mbzOFYcD5Nrmi/tsHw9s4O01QOoq690uki0lX/V0iOD6G3rlWiNKrXK6C8bm98Xt50dQmSX3eLS1AtUCdbH23/gNFESB5FHSB7pw/60XRwRRCCGc06NqvR8uxLesiPIdwxR0ZVLwH19nY3Uy60UPYIFWk+xmmTjMy72/wpW1D+Wp0eFuLJ+NQO0PuPPcmedaLasXbplLGm6UBBoXakRt+6zpsna659wm/SLjsXUxQXUE5m2jkwcZDexcKplJgr5m0wp2vknaO4bjOuNaiPChwH/rftQ+pQa3YhqzNiJQ7EUxpBSjRpmGtL2Hc1rRew==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1794512836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivl2fzOJBQU4OmEbMUJ0rBy92j+Wag+ptYQzVvr86dM=;
	b=tZnT5CS6C6cxJpsrqHazPBI0Zbg5ymh/bFwT7RqGGOlZoYDvTOr6+2eC2q3nruhiPdzIoY
	h8J9c2gzY29Tc93F8O2wB0fXN4GQDFAqZ6Hxt2u8lt66aVDCWl6X0vRWvpHEGfZbGn2NvW
	m/OAXuDn+niq3PRYj8SYbrF7vi5RJCM=
Date: Thu, 12 Nov 2026 19:47:11 +0000
Subject: Re: [PATCH net v5] vsock/bpf: release sock lock while waiting for
 data in recvmsg
In-Reply-To: <avXyzxvIN3ngFepE@sgarzare-redhat>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: jrmmhm.kernel@eldare.de
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,"David S. Miller"
 <davem@davemloft.net>,Eric Dumazet <edumazet@kernel.org>,Jakub Kicinski
 <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,Simon Horman
 <horms@kernel.org>,"Michael S. Tsirkin" <mst@redhat.com>,Alexei Starovoitov
 <ast@kernel.org>,Michal Luczaj
 <mhal@rbox.co>,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179451283622.7.13355395779239029915.1767743913@eldare.de>
References: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
 <avXyzxvIN3ngFepE@sgarzare-redhat>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1767743934
X-SimpleLogin-Want-Signing: yes

On Thu, Nov 12, 2026 at 06:23:00PM +0100, Stefano Garzarella wrote:
>On Mon, Nov 09, 2026 at 09:08:29PM +0100, Jerome Mohm via B4 Relay
>wrote:
>>The loop
>>and the zero-length check belong to the fix (without them the reader
>>returns early or spins with the lock held), so this is one patch;
>
>I don't understand why that fix can't be in a fist patch of the
>series...
>
>>+    if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
>>+        return __vsock_recvmsg(sk, msg, len, flags);
>
>... I mean, why this change ^^^ can't be in patch 1/2?
>
>BTW I'm not asking to split it (at least for now).

It can: the loop is needed for the deadlock fix, since without it the
reader returns -EAGAIN early when it wakes without data, but the early
return isn't. A zero-length read with data in the psock queue already
spins with the lock held on net, and as far as I can tell from the code
the early return alone fixes that, plus the MSG_OOB and MSG_ERRQUEUE
cases. In v4 those reads were patch 2/2. They went into one patch only
because Alexei's diff replaced both, and my v5 sentence justified that
badly. You said you're not asking for a split, but since the early
return isn't needed for the deadlock, it would fit as its own patch:
should v6 have it as 1/2 and the lock change as 2/2, or stay one patch?

>I saw some comments from sashiko, can you reply to them?

I'll wait for your answer before sending v6, and I'm replying to the
Sashiko comments separately.

Thanks,
Jerome

