Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=79.135.107.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794513815;
	b=1w34+W5U9MM4CQW+p1PlnRghbqvlpS99valNI+s+6zENee2pnN+R3QMBbJ+O/DlgWEm0
	 DMG/j1l55MGUfRjtb5upDim5oaMEjqWhoc2nHxY7/5SnxaqfpyezMX1GkjJf4n02K1kLd
	 HjQf5XDwMXzC9DwIuJMT900L4Bf/MntmTyBbCC9Wg/YWmS5LlNmvDNRZogATKJRPPExSL
	 I8U1iBitbuoVcEmvyipZBvOm7OPm1zCJYGbdRZE6s41kgpiwZe71+qnAgkXBLEheh4FDk
	 Zx04c+7GJ9lCKxhlItpqYi1xCWsYQT0I1PUHwzJvlmdyPRyEHRuscYEmO01+8wu2uEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513815;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=0E3W616PIIwYgmjnft8Gf472v/DbdmSZ1OX5fDFqHR4=;
	b=i82Q6yUrRy3NnKsNjVRquy1TQvdwyfizypsALjH2brmkB2CMlbaOxBzojz2R3oLywFHZ
	 Li7t/CPHDd+x+yxSRGEp6Wyw1AckU3en1YCWiBz5phGWco5nzfnymsfmC/ZYOGpQpxeR4
	 DydP8o2Wne/SeDyeoldYCRM9o6PhBJWFQYfGcCQqhsphsfxFIGw5NpYQkVNDCGPwb6h1O
	 B4ByJ2zIRVxnJ0MkCUQWJt7cU3ZtVFO9o+LXGxLt37AB5dVierYNme/CJBfKh8GGIYDtE
	 tsXVimjCtnKQwm1on1LpG8x+0d8d0FUXCrq7bUuSgVpi+9K1mvBZtgh1fUYE1QNPkkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=C80fJPC6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=79.135.107.169
Received: from mail-107169.simplelogin.co (mail-107169.simplelogin.co [79.135.107.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EFE606A323
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 20:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39EFE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=C80fJPC6
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1794513813;
	cv=none; b=VWsLIO5ZDFdFMSexR1WD0s2jyF5Ecg6aJ7egPZC5KX01jpZdaOM71xq/CWCAJKtAu4XjvqAbrOYrlEC5HOmQIXPQfHNb5cPTzcRO6cnvSDYCPxlfJ8TEp5GdssBeYJ9GfBh+ChZtDGLUT0g3Aryi7uDUkmzGVOi9kTxcM5HJEyFvMSmrR1IkD5H99LXhwW7rqcobNHbV2Ajgsj/9HwEzVVY+CcZRjUF89ICmilkPOukE3YVjZeIZxqFzMqjLXCmQKpRry5+Xy1VBL8C1nBXFXacJzjTRYDVOYYOzS+V+eqt/g60XjDAjH7G3byWQrhjyKLXjjWP4qLi7WPrQe/l/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1794513813; c=relaxed/simple;
	bh=0wc9Z/4W6CTXSp1rTTaxIG30rifzfPuvCw+aRoc0wpE=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=NENS0VfnzmH5V90SmV+FD/CZVcM+m4aEp6WZtCNDPq83O0VXEXXL29H5035TNVr2Yzi09OA6BzFce2Af5FXKAzCSCqxZm2E2Qr+DvXC0Bc1N2oGoQOWcDu/b7JNKaG8vTkreYvYNT1L30l6owqNdT7ZOcwF66koOksuf+pXKKCYLOiN8JPnj/gCseqogWhUD4avWRioAIYv9FNyyn1GBpMCG+ACd3sVJgcVfG5z94zFpCkHoSSZn4bT3qCpiMTNhz0zV7CuQGjz+PNp7zYc9Qa7mIOnnkGqGZkVesvlhQPGpXSq6BrSmp4GwKqsgqg8x5Q5Qwr1lpBSVPBCYD851jw==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1794513813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0E3W616PIIwYgmjnft8Gf472v/DbdmSZ1OX5fDFqHR4=;
	b=C80fJPC6c82t8kBWD1d1BIAZlIX8ADI7iFadx9fa7XQeUBpqdd0ZEPR2PATr9dBXbB6QB8
	R78HVgSdpPUBG9gH2eCQtzA/ZlUTPoqX5wRQVlIWlciSmDGVeKyHob8PosYa7wzKyZ6yv5
	uB0ewh3FaDmO2uYttqH0U4Ecn8/uGWk=
Date: Thu, 12 Nov 2026 20:03:22 +0000
Subject: Re: [PATCH net v5] vsock/bpf: release sock lock while waiting for
 data in recvmsg
In-Reply-To: <179447093204.2199510.8895677421994612994@kernel.org>
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
To: netdev-bot+sashiko@kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,Bobby Eshleman
 <bobbyeshleman@meta.com>,"David S. Miller" <davem@davemloft.net>,Eric Dumazet
 <edumazet@kernel.org>,Jakub Kicinski <kuba@kernel.org>,Paolo Abeni
 <pabeni@redhat.com>,Simon Horman <horms@kernel.org>,"Michael S. Tsirkin"
 <mst@redhat.com>,Alexei Starovoitov <ast@kernel.org>,Michal Luczaj
 <mhal@rbox.co>,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179451381226.6.3359410033921765387.1767782037@eldare.de>
References: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
 <179447093204.2199510.8895677421994612994@kernel.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1767782109
X-SimpleLogin-Want-Signing: yes

On Thu, Nov 12, 2026 at 08:08:52AM +0000, netdev-bot+sashiko@kernel.org wro=
te:
>> -static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock=
, long timeo)
>> +/* __vsock_recvmsg() doesn't wait in these states and knows what to ret=
urn. */
>> +static bool vsock_rx_done(struct sock *sk)
>
>[Severity: Low]
>Does this comment hold for the sk_err case after a transport reset?
[ ... ]
>The wait loop stops on sk_err, but the code it hands off to can't
>report that error. Could the wait path return the pending error the
>way the native path does? If not, could the comment be reworded to
>cover this case?

I reworded the comment and kept -ENOTCONN, which the commit
message already notes. Returning the pending error from the wait would
bring back the copy of the native return values that Alexei asked me
to drop in v4.

>> +    while (!vsock_has_data(sk, psock) && !vsock_rx_done(sk)) {
>> +        if (!timeo) {
>> +            ret =3D -EAGAIN;
>> +            break;
>> +        }
>> +        if (signal_pending(current)) {
>> +            ret =3D sock_intr_errno(timeo);
>> +            break;
>> +        }
>
>[Severity: Low]
>What happens when the timeout and a signal land in the same wakeup?
[ ... ]
>Would checking signal_pending() right after wait_woken() returns, as
>the native loop does, make this match?

I'm leaving this one as is: it only changes which error a reader gets
when the timeout and a signal land in the same wakeup, and I don't
think that is worth another change to the loop in this patch.

>> +        release_sock(sk);
>> +        timeo =3D wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>> +        lock_sock(sk);
>>      }
>
>[Severity: Medium]
>Now that the lock is dropped around wait_woken(), can vsk->transport
>be NULL when the loop condition is checked again?
[ ... ]
>Before this patch, the lock was held for the whole wait on the BPF
>path, so this interleaving could not happen there. Would checking
>vsock_rx_done() or !vsk->transport before vsock_has_data() in the loop
>condition avoid the warning?

I haven't reproduced this, but the code agrees with it: v6 will check
vsk->transport first in the wait loop, so a reader woken after its
transport is gone no longer calls vsock_has_data(). The entry
WARN_ON_ONCE() in vsock_bpf_recvmsg() stays as it is, so a later recv()
on such a socket still reaches it, as it does on net today.

pw-bot: cr

Jerome

