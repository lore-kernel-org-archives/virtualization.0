Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355991;
	b=YEHIU1vIHpzjgGjIg1FpsBwSjhDWYmeIGoRlVGvjOzpaeRzpJoFOnFkX6otLSO+dQNjs
	 /2Uw8VClxUuBwvGiN2YTFpu7T69w4Z4GKbIkFQOh87XPf0rKKkaFwuVV1Kr7kQGsm55E6
	 lcHeZlNFhFvFGi5XxepraaKz++502GimC5T3HBj74+0juKjPVIqtzvE+trcqBTM7HAcNv
	 lBFdqc7i6fyP0dp1/F6B4PeoXMh3z0OeTElYAUmCTHwwkM3Sm+B3rSdHn9dAdLw34mYe1
	 nOOYDGBabN0E1w6u4sUDEOAcm4tmApbzcYbSa+rvETe5R4Aco1us6fZwXSTlGF2YEUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355991;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p/eakdXUMyhPjoYv9YLXgaFweMwXm5YCpomhJ68z79E=;
	b=b5SN819lIdUEBrneGsI3j7xlwGl9ZvawjMyarlS4RP4P8OGWUVIxwoBChvTeo+OGP6By
	 utYjrk1WIAA4PM2Vgvx2r9mDhQ7+T2xDSFniNdzarI+1s/XqFmFW0VNViVbm3YyW/XICY
	 nyfQ5prUnPlblK20ttgO2QJZkoqSZEHFWYoAHC9PFXgUKikHpxpp73RhN40UJ8dmjzLvk
	 3+izUoKIhm22VquLMATeVkFW7rD9kC5bjEmXHrClg7Kgu3DDF5rnNjuDtqk/J41T4EDF+
	 abWsVcx7f1q+Lvn7pEFQaZE0Zwf6gtmnEWiJn5FdXUPykzXcInfnhq9oGAchrLi+nhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ee+ywDk7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9B606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ee+ywDk7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560AC1F0089F;
	Wed, 11 Nov 2026 00:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355990;
	bh=p/eakdXUMyhPjoYv9YLXgaFweMwXm5YCpomhJ68z79E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ee+ywDk7Vxa0s8L0PxTwOqDYuYK+swHxvKvLWGJ4rNjFhRoO5oUesZYpOYJNYDHsI
	 /dQeC7wFPeLzaZ/XWJ1GpMxwx8psuHXwZgehppUrAYGW3KqPIqYoVpBmwwryDTeKpa
	 6mXpbcoGzSKFVy0zwm+vB4v+JohB15A2kZbAStz5AygiAoSnQTONmkdLfzBSl356t5
	 BEH0Gcxmz2/UeQ5TfSDS85nF4DSR0sv4OjkNDgYyTYg8rccFEnpMPxLGzlPjW8xQfv
	 UDkW0t46n0cCFWUGHhrqtcLK1cPafUOIRWVrRwMW1siLaIVO6KAAL3B58RYpnMObB6
	 Aqq3hHRQ8prAA==
Message-ID: <sashiko-outbox-208000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 01/16] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-2-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:13:09 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> staged-capture policy sampling.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D1

