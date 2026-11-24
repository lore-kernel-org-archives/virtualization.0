Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515332;
	b=17u51vio4TaJa9IkewMZ491XYTGp/R7lqJIa93u+NZ5Mn/+l1MBMyd/nSUNk22CgO+O0
	 wOYNr9XQ6oI6mYILcSVltCHnjhvXTnQSYs9MjRsjhKppIIMDfbme54I/4tBaGQN4gT7Rn
	 m1CqycSphPiaNZiby2lV3KzBT5Iw0BJeKlmFNCsoz9QmX0joxhaU8aWme3y13zXbY+VkO
	 bKnqy3jVzCdnSOGvQKb458Yx6ZQytxzDOkPUENFiga4ehFng9zKW+Bk3/ruqxHnC5Y6H2
	 QwwZ+AcSUmXCbOMKeUi53mdTDEQlz5pVKXDvBk5/4yiAaa2GTjlW8OC1C0FdfBMfsMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515332;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nMng3ZJa0ZitP554JNLrDGi/NFaJSSIjBBszYdhqGDA=;
	b=pnh2mQSTw7yWMxZGL64sk1Z1QzJCTzBb47NkFxhXGfwJo4FHCO7YwZXUn1WUIimJd2pU
	 ICbXeTyeXWg5tYps2JrLGV9iyAkuJ3VdB2B4nEDEg2Q/4LbW3v2Z5a6bGAnI5k8rmJ5O4
	 vUZKIQCTN/BO8nwzdaHTTZ6Qaao1n8KAW5fTyuaMlgHCKCvxfQfr+DBGzS8QZbE6Akw+p
	 FDKuCy2apEZej4pKJ/ZUN6YnjVG6QLuMH6SFbZTeBnBpBkyVmwCPkRJeADG/FOLxroLxY
	 yQAw7m3IK7yIJG10JDOMzPxi2SDpU/eCjxThdbN18RCCoDa2A32P4s/5J4II/bgUSxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XfNReD8+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B5606A33B
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 10:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B7B5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XfNReD8+
Received: from ratatoskr.pengutronix.de (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E9D5C202033;
	Tue, 24 Nov 2026 11:15:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795515327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMng3ZJa0ZitP554JNLrDGi/NFaJSSIjBBszYdhqGDA=;
	b=XfNReD8+95LSSEuAPwKVuMxr/EScHMIyNNXm6XzrKwlVFx1LvCCY1sNZbyiYYAJjA1v9OW
	EaKYjEdBkBXbcUfeJSgZBhxVSxnZuARjYD8HgZdmem/cf3Mj4YDsMFgtFAB8fuAa+D3ntK
	aO69h5aV/Velb4B0s6QzpBKqw7irgjDu+zW4QSJE20VvCDdyeT/tGIz1eLzKAZ7ufTRftJ
	v06YRKm184FBw/py+VW5S9d8lYpkntH3blqNwnR0A7R9Aoy6HT55VTac4rNNI8lobKa0Xx
	bya6dkvAPN9rxb9TIysYwjwh5jECD3asuCSRbbc/wqAhC94ZNJKoM99haMLh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795515327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMng3ZJa0ZitP554JNLrDGi/NFaJSSIjBBszYdhqGDA=;
	b=O7wBEvRpDwTYlkQcK04uYuwllHgnINS3lAGY4NxKgRW9SkgCIUFOgZx5ox7iZTwcTTXRyo
	prNUPQ/r8KGNOlyfSLMv/BSXSvBkde3Ul+ccRX3Vr33+uzD37RQ62zEvGQsCvAmLWUnEQs
	mZKoJqrVGArR4rOo87KcKIi4gjX60vZAfyANWNBHdz89J6IUjv2BbXEJHrS6tiJOyVzo9q
	BrVCFA2lGII5lRW5MWNBzgzS3zTQzoqpuIHIFHBiLHvRwC3f97oE9IKbY45Mm4LsbSu+F4
	tmkFhjGYF1kk4/18nCI9tMuAkBDYXIRX0wBaPDYDMK5WjACOzGM39DS32VZ9KA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795515327; a=rsa-sha256;
	cv=none;
	b=OiC4RMMbihANiayaaHtNtDvTSbsaj++gqSa8r0Ie1G6tFLUeS5qPXvZeRg6E0XK3sPil6J
	bklJeX2P9SQuytZYQcR0WGR8N7sPTxfKsoGrfd6fWu+7Z0Hr3kUUCOkR+6N+c/DcbTKXvZ
	LCHbXj/n+4hfM06nhYH5cyVRc/HluquGRQeVDE0Gt9Er1mPti9P7n2EDeBrME/d/Wy2JOr
	5eypMYT6XqHvRHjseFauRP+kao99cI1nYhoFvuS4J7c6axd0pMZd5s8U8XbW2CagyM144v
	mpRiOqS2E5kQCokCB7xPAyCMNbyTHTnvDYTDuw7qafA3Zvu/d2mCGMqZrG6WbQ==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: mst@redhat.com,  xuanzhuo@linux.alibaba.com,  davem@davemloft.net,
  kuba@kernel.org,  pabeni@redhat.com,  richardcochran@gmail.com,
  willemdebruijn.kernel@gmail.com,  andrew+netdev@lunn.ch,
  eperezma@redhat.com,  jasowangio@gmail.com,  ast@kernel.org,
  daniel@iogearbox.net,  hawk@kernel.org,  john.fastabend@gmail.com,
  sdf@fomichev.me,  edumazet@kernel.org,  andrew@lunn.ch,
  horms@kernel.org,  kory.maincent@bootlin.com,  liangchen.linux@gmail.com,
  hengqi@linux.alibaba.com,  virtualization@lists.linux.dev,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  bpf@vger.kernel.org,  kvm@vger.kernel.org,  kernel@pengutronix.de
Subject: Re: [PATCH net-next v5 9/9] tun: add rx timestamp to the vnet header
In-Reply-To: <179483731174.3136.9033275454370245376@kernel.org>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-9-7ab67b572f4f@pengutronix.de>
	<179483731174.3136.9033275454370245376@kernel.org>
User-Agent: mu4e 1.14.4; emacs 31.1
Date: Tue, 24 Nov 2026 11:15:25 +0100
Message-ID: <87wlq2eds2.fsf@pengutronix.de>
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

On 2026-11-16 at 13:55 GMT, netdev-bot+sashiko@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 4 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The commit message says the TAI time is written "when a packet
>   is handed to userspace or vhost".
> - [Medium] Whether tun writes the timestamp depends only on the
>   configured header size: `vnet_hdr_sz >=3D offsetofend(struct=E2=80=A6
> - [Medium] The value the device side reports as the 'TAI receive time' is
>   sampled in tun_put_user() (drivers/net/tun.c:2178,=E2=80=A6
> - [Medium] tun cannot see the negotiated virtio features, so it guesses
>   them from vnet_hdr_sz.
> - [Low] The patch adds `sz < tun_vnet_parse_size(features)` =E2=86=92 -EI=
NVAL in
>   __tun_vnet_hdr_put() (drivers/net/tun_vnet.h:163-164).
>=20
> --

(...)

I will fix this.

pw-bot: cr=20


Steffen

--=20
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
