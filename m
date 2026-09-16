Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F454F55CF;
	Wed, 16 Sep 2026 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564562; cv=none; b=HfzatG4S+4nLePSnbBR+f9fAlBFEIHImZnWZ/HI9zDIpyOIPyzoQwvGRI2poEgMF/lo+ir8apmJzuOHwtUT90Qx4KMN9/p2RYu7O/+0QCprVXWEQar99+P1xWkqxaGrKRTnXzN1zOfTb8WL0VZxojdmWJAL5pCThBdFtFKy4cM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564562; c=relaxed/simple;
	bh=PXE0UBPoj3SRXGBGFmC73swvmXvbGukMDNAXGhVxK3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nmjqf+0mxbfEJYXRj4NJS+4YZZQ2rgnSOudYR8suRQfJJ22VtAQfXlcGOrisPOQ3nL147LtGTfURorqk+mHvml2mdpwjYShxCtjZIW+WLTotZ3npZjGQ5+Wui+jck+5h8PUmukzmlIbc9DRan16C4CXv7huQQonF001Dl+CsUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqq19LLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqq19LLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3431F000FF;
	Wed, 16 Sep 2026 13:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789564561;
	bh=CDpnmdjDWh/wiSvUpurQb5bvNhq2Ui1bt10eJonnaQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oqq19LLJHiA0A6NIOkWP8AWYszNQ7luzUtbc+8+AsdJ6MXvlJ11WnSiJnLqCKXuAq
	 gw+ggFEwBFX9zXFOEpwN4fd07jS75gHnR6FviU5K1daQd598byyQvl6pnJuaAuNcDt
	 Q0qXPXopPJ438ZHtjya1cJK6XamVldsh+M4rr+unBXibnnpM7KjnvD6AGSUILFGiHt
	 jQ4RHPJltwUq5f0FeB9gNpcsuJxHcYQ/Lxn855GTVfBJ5eu2vt35BLYmeUuiwdHx7r
	 O8sTzYTjgiGDE93q3ncEPRAQ+U5FMhs+Z7dSn8tUcgMW18sL3MQE84e1KRqKt9J0Bg
	 yKMCCkySj9kDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 4/5] vsock: Do not reset a TCP_CLOSING socket
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 13:16:00 +0000
Message-Id: <20260916131600.DF3431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Handle the previously overlooked TCP_ESTABLISHED -> TCP_CLOSING
> transition (on VIRTIO_VSOCK_OP_RST), which could race with the connect
> loop.
>=20
> Resetting a socket that is still present in connected_table can lead to
> memory corruption. The reporter noted lost transports for in-flight skbs,
> and I have reproduced crashes caused by re-insertion into connected_table.
>=20
>   list_add double add: new=3D, prev=3D, next=3D.
>   kernel BUG at lib/list_debug.c:35!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   Workqueue: vsock-loopback vsock_loopback_work
>   RIP: 0010:__list_add_valid_or_report+0x11f/0x130
>   Call Trace:
>    vsock_insert_connected.cold+0xe/0x13
> [ ... ]
>=20
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-vsock-conn=
ect-reset-closing-v2-0-a1d9abb472f7@rbox.co?part=3D4

