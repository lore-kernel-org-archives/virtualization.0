Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794659091;
	b=0hKT0I4DDmtZW6aybe2TWmTHEG5oLYaU3Edww8OwGh+oBdplI+06ddJLBmNpCakUXy9c
	 h8icTNnEssEsspTX9zDaCZNweunn+r1wF472pvaqUyQj8IQUkJoZ1ZNy2nIytlBz6iz1D
	 lmwyvMw2sltU3aNQ5WlmAAKdXQNcg6ILuN7/oSK3G5okHl994izCTRa/lpEzrnzQ5dz/0
	 tCUTyqBi//DooYdphv5Zx88B98FQjLmrd7nffdead/2o9sBmjlkUVTOFwNkNKOy7KeRAz
	 blZhYA5AAiX4LQqE9X9W5aMOuhKULJfE9GbZq1xJgU2mn0h9cYugzcEVaVx15vytnCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794659091;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rziMI0ndPHEsoFcugMsCWKiPH9bye9ihqApQhfw8Uho=;
	b=rRAGh5D6dbpExlhzA/q7ztmS6dm3Jm8Pap+cm8klxGCUkWvIG3p3Q4IeZPWFQdHUH3Id
	 bX1r3zjD/7d3kmPIWiQGiQoEYWjPRH2XnFS3IpGi3EmGL5MPo9Bim+vzaMY7dNyQqSoZn
	 P0QZEZBDIyEEIcvxDQpfhd2/+tsLuprYfkGQzIGH5RVHw/uHY2lEVbin+H4wwHgNyxTtq
	 QhRa8MbsuZDbPmGpmFeLy/ntlwGMCgV/hzEdPZmNPUxP36ZiO/am1ppMHNiu2YyHKPBZP
	 V8RorQxmhjI86mcp4SsPBwQfrxkSXH4J9mImfLXdmAQN8aoUgTPKS5OKq/k8YoTDmMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdWrz8EF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D150606A327
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdWrz8EF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7439A1F000C4;
	Sat, 14 Nov 2026 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794659090;
	bh=rziMI0ndPHEsoFcugMsCWKiPH9bye9ihqApQhfw8Uho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZdWrz8EFXdJyN881wIF0R1HOPptOz+xSMRoB4BGkSQV+3fdyLlnakIRXnRPu0EKMP
	 TlFdVZLCTb1nDkIy2F0prsWofps6DD/bJybSC4ds5Wj/gPnt87FAjbCRsRKUkJQ1Vx
	 xr+e4JR22CxozBzGpCUPxY9gE6KhLgnkq8cK/0mxBpjsblPS2JMEgriHvFtmiES+tl
	 hEoNHbS6wRherg1XQgsR8rUQst9qRsfNJXJwl2qxjyke6MCyXIYMm9PsrY9GM1GXNi
	 z1VaHkxRU1WGYyMUHw0vXXiRSS/y28Rcp/9nT/0PFmiiOHInJiebq8G7xi5INC2bjs
	 x1WEpNa+rrw3g==
Message-ID: <sashiko-outbox-214502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 1/2] vsock/bpf: fix zero-length, MSG_OOB and
 MSG_ERRQUEUE reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Mohm" <jrmmhm.kernel@eldare.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-1-96b6029bbffa@eldare.de>
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
 <20261114-kbh3-1-022-fix-v2-v6-1-96b6029bbffa@eldare.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 12:24:50 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>=20
> On a vsock socket in a sockmap, vsock_bpf_recvmsg() sends zero-length,
> MSG_OOB and MSG_ERRQUEUE reads down the sockmap path whenever the psock
> queue has data or nothing is queued at all. That path copies from the
> psock queue and waits for data, and it handles none of these reads:
>=20
>  - a zero-length read with data in the psock queue spins with the
>    socket lock held, and the delivery worker blocks on that lock;
>  - MSG_ERRQUEUE consumes stream bytes from the psock queue, and the
>    zero-length MSG_ERRQUEUE read that MSG_ZEROCOPY users make to collect
>    completions gets -EAGAIN or blocks instead of reading the error
>    queue;
>  - MSG_OOB consumes ordinary stream bytes or waits for data, where a
>    connected native socket returns -EOPNOTSUPP.
> [ ... ]
>=20
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-kbh3-1-022=
-fix-v2-v6-0-96b6029bbffa@eldare.de?part=3D1

