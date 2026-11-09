Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202200;
	b=r140oRqIKVdS6uhDx06aERqh/XvVy4yAyFEG2n31lX+EtfYondyNtucETS/oK14OTYWN
	 6xRjZV7psZQn+ZuS6uxU/goaaYi5D5Ub4zTN6+hkSV4syUvQGqUxbTDiLr4NeTHtczyi7
	 LVbF2PaWlwQTpgrJ8re8b7YrtsXrfqND/J35QU5+Q/DJVBaZFquEIrPbyCpQKk+pDWryv
	 HkW3WrSMA3Ep82F8n+236p3juIwSH2dTN3PGWrPR8RNWmPVc1EQhcELa/svtgeZo2QAk4
	 HKNmbX7MrMljwCIKqQNlShkkCJOd8Q2NiafqiNVmDYvBg//VvyscWOl0/YXyqBgO2iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202200;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fbx+VZA81Ct3QsU6BLMdfWWrJ3kKWxZU1ojllZEbL5U=;
	b=RkqJsOvIMRrr3pEF/lCwkU9HKRwi2uiy7bztk776a4yXsz+TyTXjsZM83mv18P+DyWnA
	 JigKKceACOBVlGVWQTXxga1v+dweOFkyyRslPBSnOk81gJ3lT2Za4DO5IK1R13G66uzpl
	 tZes6Pnb8kjuG+DXYl3OQiaPSTw5TWQeXtZpYNUueyHpxdIItlCHovcTlas6kXww4/+DJ
	 /c5t8eFkaweoofGI+5YTug/IUFRozMTsIafEP39N0z4ABD1NTj9O5aU2RU+u4PS73DdlV
	 dWSTJmyytQ5MRdKIIb5djAzBMsHGZjbpq332BqgqW4E3q7ec5rIFa7Y/WHYbiSiSiQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajluDLG+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270FF606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajluDLG+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768C21F0089F;
	Mon,  9 Nov 2026 05:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794202199;
	bh=Fbx+VZA81Ct3QsU6BLMdfWWrJ3kKWxZU1ojllZEbL5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ajluDLG+dUSDHuzEY65NanskbU7J6xRj9UVHuD6Oor5VV6xB9nTeQD5h9AS5DdnN8
	 CF8uJ3BZs1D4BsBAAXxu1d5LJK6YyNfQMUgrNIyall+ObvN+sHyN3fTwulkU3CEcyA
	 N88uNvY+2jYmk1KGNr14QxUvAjD6bwgowROAkf9ILTik0mtvsNTalhq4VD3i7GBOkx
	 3VxBzbOym7WNBPHRRjZD+a5KYS8ABVq2X4yObh31uZaBUu/HQMdT3x/l0r3DrumPLO
	 9q4wmH9HieZFL7thvwXRV7SYoQNlnn/grvrt5fk2IANT6j9hpVjsCE7qEsoF+pLriI
	 woah9au8KsFxg==
Message-ID: <sashiko-outbox-204439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 13/13] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-14-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:29:59 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document the five opt-in virtio_snd capture module parameters. State
> that capture_allow_empty, capture_allow_short, capture_packed_status and
> capture_pause_restart require capture_staging, and use the ALSA kernel
> parameter restriction tag for each entry.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D13

