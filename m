Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79A4078CA;
	Tue, 15 Sep 2026 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442767; cv=none; b=hx87t9mpSduzDYSOlXot1Mi47SUXvB7Yl8sXUozBu0u2+EYEtFjoOpZC7uSRKEr53shtJyE7McipLLJ1f7AzjNc2CVGjsUfrEziDIFG/E2My3hrEVzWhjHt6dG27J800aWVwMQfIy9/5HTyij+16I/koFX7VBASJwg+Sv3FP0GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442767; c=relaxed/simple;
	bh=T+zOAevd/qcEDOuEYodNuUoDj2eXkCF/9wmXCfOEveI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IX2I2jmC8grW0xzxI6xMA4CfHl7d05z8Iw7VHeEpypRgQy7DZIa2L3BK8RMTj9AO8WgRoSfdmqE6SGYlmD1rUAinidefQy9VDaeClC2f8iIQtkWz+mT3HBSVyBFc1w1m6Mt+HBy6/mmzJhxpuskvaZbpHQR+V2t+pQ/UDz27EMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbE7nAkj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbE7nAkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00B51F0089B;
	Tue, 15 Sep 2026 03:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442758;
	bh=T+zOAevd/qcEDOuEYodNuUoDj2eXkCF/9wmXCfOEveI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bbE7nAkjrsN24wXaWHr9YH41rLNHN2IEXRXKzsvpJvm2vTQuJJSV5Ssgkc4TEwABO
	 7lIHKPo/DM21Li0VTcMvIqboZ5OLPoufP1wL68vjMQ/012WxruiGnnOtSgKZ63T6s0
	 u1sEJSDxOoxp0/t7MEd6emN+Hfrg7ZD4kq/3w84SrOBu13k9a67lV/Cm56k4SqvuU6
	 jO14tdNyDHXsf9vVNL/HoGmMdYoozSBqZgd0UK0xQ96A1gQUjy7D6PdTpwwWre+4ti
	 PpPiZAHqygr8b4TNUJJSGdFDcUhr/rHxvIzAmqVnVRQ1yTfC4JTn3oQD1EbuC9ZCnU
	 oxwrICTyt5a3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/17] sched: assert static storage for wait queue and
 completion declarations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260915031334.1194975-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:25:57 +0000
Message-Id: <20260915032557.D00B51F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The ordinary wait queue and completion declarations statically initialize
> their embedded locks. Automatic objects need runtime initialization so
> lockdep receives persistent class keys.
>=20
> Add ASSERT_STATIC_STORAGE() to DECLARE_WAIT_QUEUE_HEAD(),
> DECLARE_SWAIT_QUEUE_HEAD() and DECLARE_COMPLETION(). Keep the _ONSTACK
> variants usable without CONFIG_LOCKDEP by expanding to the underlying
> initializer instead of an asserted declaration.
>=20
> Convert the two automatic completions in the AMS PMU driver to
> DECLARE_COMPLETION_ONSTACK().
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D6

