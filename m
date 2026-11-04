Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793810933;
	b=LXRZNDOJi8lygF6UdEZXXdfYpG1jMaeKYRqfts1tT63TOLQWJPqbgpIFijQSExX1XrDN
	 NecFhRZEuIOHvGYVotppkl5DkwIZR2qsZBMMXbVusKS1GAYUyrxXWdIoj+9BEzyhHI9tJ
	 cG3Mck1gBaYoFiDpM8NrFh0+VxUDEiuldF7V25HHuR+qoa0h3TKMckAIt5m7fqaEOU17P
	 21LTIT8cGwOxAVeQ/bCa1fZhw/z+Xfq/yOh8v/Q/dA+29MucE2dAS0pOkExizYHsfmwtX
	 mNWNR9sxfDQlRhKMcxZRi3barOlLaVmtdiXarT29Eiv1u6fTVZv8ts2jbRGTPIZDOaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810933;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=+6NWrTkD19j6pXo7fX9iBIpL0RSF2GXs9ygbR1u2JBY=;
	b=D30SANx8LUcdR/PbOCMBBGGfF/54eGJKhr/X03w0p3jNXfGoKiVdkq5kUuojQm7V6V0W
	 Xyoc58E0DS02/cj6IJhLNS0FLDrZMqOxcOY0hRjN1Tu9CHzbqyi+lFBQ1FodKitYzp1JE
	 i4Ql0APrqxhx6lvSttllqeIp8oKKUdJ5pd2K49eK+HLVAFpmd81Nd+TRROhbdYdzQ/4ul
	 DFLZE7AGIBHV+40He0Z0Rphceruli6G5mNqvXCbWU64BoGso3BanEd3FM9/nd3zkdwrXS
	 E5Wd7xvHXi5Z8R85BPetBYVx35z9Bal4V9uXOEjEyQVfsDOm9T8T+hC3t08nhtOB/ZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=LPPJmNY1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.168
Received: from mail-200168.simplelogin.co (mail-200168.simplelogin.co [176.119.200.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F0606D828
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 16:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 308F0606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=LPPJmNY1
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793810931;
	cv=none; b=vNNsw+udY1vYJbNjVyXwt+DnayQTkYHfuxdNl6jI5OCNzzieV8/Nz0cRI/Hzotb28MjUX8GK2YJ63FX1ZcfAoLkUA0L3/q8uYOiUhkj/BYiDxwlynlmlOzV/qPAucZIR90h1LCMhlbuDKFOSpMtgPJKZnfLW/pFRstqDAynH1MF/ofxEKMuzLJ0tMHcbhpWBnURWh/qq8y/H/iDgV7/0kYMGNMjH5/VKgh51SpxC/ZITgr4j1aZLhjdzaqSYi1mQ8P418bbRhm4bRGGGe44WL5QjCV4oa1wOqbHZxrzv5+eBYx0r9ade+r7ojwlvd9CwOSvKbiyR9ZjjPfuwzOZOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793810931; c=relaxed/simple;
	bh=NZfHjc8GabK+5fWc9xU1eIPV8ar6IHlihuK1W6X9Wrk=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=CqyEDSrkOyrGgTHIQxjYSBNbn0RoKwBxczaaIB1oItAJIJuOZTRvi3RxUaI04S5DJsIqeMIu8AJQMZrH1cXtnj3oleyut6juWA0tS2ZzH1xCP/SicTmUPqAFg1W+S/k0UJcNuYLD3IOewaK6wX1dm5arJ8t3GdjwaJM/oh7a4nVeV+viOz8m21+D/s7BAQ8wVvXMmtyo+DFRaFjh3GbZnM0W/GsCW+PV9mjEUJOeZK3o1utvXHg+rjMwWI/I7qszBGXSaqpWerOpLgBVGpvGBtyb+vwSEBfWAUn+EjcrkQOcP3XZZ9cd47mzAYFHbDXHgOJLDe8ZATGP/WDMKul1wg==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793810931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6NWrTkD19j6pXo7fX9iBIpL0RSF2GXs9ygbR1u2JBY=;
	b=LPPJmNY1E9Afuj8tm1dblKOuW0bxHTT/z8wxoKA1SWLuokKtwfZQdsa1q0vyV1i4itNXSH
	t70Rmwl3JdmySaKgnjxgXHQ1Z0I0pGT/edUTIiU72xqAa7fNWOwaigxF9i/aB33SlYt8la
	BTYSyUnSSDLMgNBg2V3RfWM23P7RpDs=
Date: Wed, 04 Nov 2026 16:48:44 +0000
Subject: Re: [PATCH net v3 1/2] vsock/bpf: release sock lock while waiting for
 data in recvmsg
In-Reply-To: <auSkQOU6qmj0NPEt@sgarzare-redhat>
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
 <horms@kernel.org>,"Michael S. Tsirkin" <mst@redhat.com>,Michal Luczaj
 <mhal@rbox.co>,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179381093020.9.4719932034061956856.1746278795@eldare.de>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>
 <auSkQOU6qmj0NPEt@sgarzare-redhat>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1746278842
X-SimpleLogin-Want-Signing: yes

On Fri, Oct 30, 2026 at 03:18:10PM +0100, Stefano Garzarella wrote:
> Ditto about commit message, please put more effort on writing something
> readable by a human.

Agreed, I'll rewrite both messages myself for v4, much shorter.

> >+            if (sk->sk_err) {
> >+                    ret =3D -sk->sk_err;
>
> Why?

Same as vsock_connectible_wait_data(): an error that arrives during the
wait is returned to recv(). Without the check the loop still ends, since
every path that sets sk_err also closes the socket or sets peer_shutdown,
but recv() then returns 0 or -ENOTCONN instead of the error.

> >+            if (sk->sk_state !=3D TCP_ESTABLISHED) {
> >+                    ret =3D sock_flag(sk, SOCK_DONE) ? 0 : -ENOTCONN;
> >+                    break;
> >+            }
>
> I'm thinking if we should split this in multiple patches.

From reading the code, it can be split without breaking bisect: first
loop on all exit conditions with the lock still held, then drop the lock
around wait_woken(). The order is fixed, since dropping the lock alone
brings back the early -EAGAIN, and the loop alone does not fix the
deadlock, so both would carry the Fixes tag. That is why I kept it as one
patch, but I'm fine either way. Split it like that for v4, with the
current 2/2 on top, or keep it as one?

> >+            if (!timeo) {
> >+                    ret =3D -EAGAIN;
> >+                    break;
> >+            }
>
> Is the move of this check changing some user visible error?
> I mean before this patch it was one of the first checks, is this okay?

Yes, for non-blocking reads, intentionally: -sk_err, 0 on peer shutdown
and the not-connected result now come before -EAGAIN, as on the native
recvmsg path. I'll say so in the commit message.

> >+            if (signal_pending(current)) {
> >+                    ret =3D sock_intr_errno(timeo);
> >+                    break;
> >+            }
>
> Why? Should be a separate patch?

No, the loop needs it: with a pending signal wait_woken() returns at
once, so without the check the loop spins until SO_RCVTIMEO expires, or
forever if none is set. I checked it by removing the check: a signalled
reader without SO_RCVTIMEO never returned and used a full CPU. The
native path does the same.

> >+            if (data < 0) {
>
> Why not data <=3D 0  and void the other if?

Right, will do in v4.

Thanks,
Jerome

