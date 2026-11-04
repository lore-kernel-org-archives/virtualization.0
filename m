Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793811195;
	b=KRIqzibzHrRlD+x60AD/fRpZn6QS/WT9hyPw2+wuH1iXPwVbQtY+Z8QKdCK5KHcdHT6u
	 XlAqAIOFskallK5MdKUM/jzBMejzMOGguZqgsZqLgKMPYhV7fle05KGiyKz71I7DP3fyO
	 iteiLiHh0cEY0ZSeqkhn8J9sGlPoDrTEbEuwHvxCoKyw9WiQ5MOb1zpBClYvH7FHau7wV
	 p2hO+wVyw7/Cb0Bup2XzRaQcg3McTdLWH6n3k1/aHGYdcTpu+ovwxEwlYBEbBmtZo9sIu
	 O0a/ZyBCRf1t1LCee6bPraJDaPHFAe8EoaMA5YiliJGozXIfhb+Ei5HLuI8oIcL9+zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811195;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=THYlU6dsxV8ed96P6OJPtEWq8tUs/nV5roX8ImFt+iY=;
	b=GPnlYbrdMyVMjYxcdDPXsLfJrZ3lJXegjy9fTRmiJWyGiZ2xEPy6BMQx1Lh0TbtyIw+N
	 DGLwOHF+aVZPsEqMLO6O8aQCSE1oYzbyw2RxmZVM1KoflFymNmM1YC1Ok2M7PyTGQnNwt
	 Q3Zrr76fHON3eQjbcp2flQ8iUELNIfvqV1rdV1Abv2EQvKTH7izTwjecamrrhjjr6f0iD
	 gtUvHVdrpchMuYOO5+oc71hKAR4JqWz2bM623n+J5GSt9f521u9zZeD3T5HF/HjAhVJah
	 C1E1OfVc6SoheK0BK5ut+Nq0cw+RJtlTYdQUZ1edfA0ULD7Sag+0o+Tw/XsA8zplVdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=BIvjAjm5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.171
Received: from mail-200171.simplelogin.co (mail-200171.simplelogin.co [176.119.200.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522E606A332
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 16:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D522E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=BIvjAjm5
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793811187;
	cv=none; b=T1BH8iovP5IY7PZ99nmbuIqKoa2giHP6pkahLrc1ahPdHCfNpWw7U39IBp7i9rlO5RqGUou9vn52f6k/DQQKykRpLUp2s1wTA+NEY1ATtcza5jsJdKwWVEoaZ+ccLr1J9QI73JLOJId4PznJzv48L2erjMHtZ3zfg/qOcnvMhjdRhyDq3G5ZUFE6A6FJw+K/ypZYsuAUAJ8ZsGgYzMZ6/Yide+pGYaheG67JktkGhFbmtzL7dwvdcoNkkjNJRy8fGTW0XTgAhQWNMgeCapKiurHjD280kArvXVyzTDXlQUHnLxyGQSALnqwnwMjbBsmgX2ohLF5oWzr9Kwg2eKKVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793811187; c=relaxed/simple;
	bh=b22BmvbWIYRK51tJiOsPu3kTH0mAG+T8cRcAHNYNM48=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=Z0jNM7uwKbon+u9Co4fj22kvwfX2gs7+jh1imglCD4LGvpyOSoZocavrh4gvsy6N6lLF8e9ybJd90DBdukwzZEFb/bqCbsNSG+/gvyptehY/FVzsD71USOG+LMc1vF+/ZG36nulX/jfLZ1jHSmz0k3mHXanb4y3ItsEdhQGpm/Oy2w8YS8r9SohhjLjMP3WUMZeQ6xsvhp1/bOpykfsjMJkEeGQguYd8jSpWUUKwAUcTeoa0OIQ2dBMCs+Ce8qNAd563WMaJdl3T/NamB+Zpz7rcef0hStnM9x6OInfhHNoUUmogbkE1qBmz3iKkx+e/ohjm80uJEzSU0S1DJoCPNw==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793811187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THYlU6dsxV8ed96P6OJPtEWq8tUs/nV5roX8ImFt+iY=;
	b=BIvjAjm5TRTO61GsOBpZh8JyEhMHRyp2ciJjRUsqrPmbrSppaR0sMWhwKWAEXDG9SQ3WbG
	pLzwuv43YJd5ISH48y5Dh7JmSHF9GAFWgtTuZI7oPrsSFxxaCQHe7FztKNejlPJVgpeq4Q
	XDisBlPe4pE7SmfmSFz2NcV1Az4/GnE=
Date: Wed, 04 Nov 2026 16:52:59 +0000
Subject: Re: [PATCH net v3 2/2] vsock/bpf: fix zero-length,
 MSG_OOB and MSG_ERRQUEUE reads in recvmsg
In-Reply-To: <auSngVsWiGI475J4@sgarzare-redhat>
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
Message-ID: <179381118562.7.1635260105890086879.1746288140@eldare.de>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-2-bc0752b2d3db@eldare.de>
 <auSngVsWiGI475J4@sgarzare-redhat>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1746288178
X-SimpleLogin-Want-Signing: yes

On Fri, Oct 30, 2026 at 03:25:26PM +0100, Stefano Garzarella wrote:
> Ditto.

Same as for 1/2, I'll rewrite it.

> >+    if (unlikely(flags & MSG_ERRQUEUE))
> >+            return __vsock_recvmsg(sk, msg, len, flags);
>
> If the psock ingress queue is not empty, wouldn't recvmsg(MSG_ERRQUEUE)
> (e.g. a MSG_ZEROCOPY user reading completions) also consume stream bytes
> through sk_msg_recvmsg(), since it only looks at MSG_PEEK? If so, maybe
> worth mentioning in the commit message.

Yes, when the read passes a buffer. I reproduced it: without this patch
a 1-byte MSG_ERRQUEUE read with stream data in the psock ingress queue
returns that byte. A zero-length read, as MSG_ZEROCOPY users do, takes
none, but never reaches the error queue either: it gets -EAGAIN instead
of the completion. Routing MSG_ERRQUEUE first fixes both; I'll mention
it in the message.

> >+    if (flags & MSG_OOB)
> >+            return -EOPNOTSUPP;
> >+
> >+    if (!len)
> >+            return 0;
>
> Is the order of the checks important? We should mention it in the commit
> description (if it's important or not and why).

Yes. MSG_ERRQUEUE must come first, or a zero-length error-queue read
returns 0. MSG_OOB goes before len =3D=3D 0 so that recv(fd, buf, 0, MSG_OO=
B)
returns -EOPNOTSUPP as in the native path on a connected socket. I'll say
so in the message.

Thanks,
Jerome

