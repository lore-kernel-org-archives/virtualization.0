Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255E4078E9;
	Tue, 15 Sep 2026 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442770; cv=none; b=Nb08XnKexmn/adNmJZtwmSDfkj0C5UwQYwvDFMvA1W3AHs/EaVzd8ysYMeSZ7zEm5kl8kAU7JeoN+m0pQAiaEhZ3qLgdtfetWxK+47lMeqRpp6AxiWGInKHh8l8pDC4Qfv5UigvuUDIf7fN2fnpulJgKFmaggaN29oMm5NwB/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442770; c=relaxed/simple;
	bh=DVnVnoKBgM2Ch9IpwibY+KHWhe2z390Oie8AIqeizl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c7V4CxIbyjBb/aHROXG2efvhwaIDwNM1we/brCQDU8lbVXQYcGFizy/0Nz0GH4PoBayf/mHcpxGXao9dWfaQdkNm/Gus8DPVQ70RKVDIOAMPj4ivXVzDTDI03mJesHJhPpH8EGyqQgiY6+x+LlJiS3e67duH8rW2CXcDs9be7Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8DDIyNO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8DDIyNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DDB1F00893;
	Tue, 15 Sep 2026 03:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442765;
	bh=DVnVnoKBgM2Ch9IpwibY+KHWhe2z390Oie8AIqeizl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E8DDIyNOPw2v12J4+m8oQZf2Ne1+o+lbfc9NcFPpqaPokhCGkeRFUGAsD7+f/gz2+
	 QHsTIzHFcnfkYcRxruSUarO+o9LzumGDKN5wtcBqmrMHdOvZNRwPa2Ee373jtM/yc0
	 SQFldmrC5yVyQX3SuzJ56Gh9DbfALiMzpGQsoZOK8pYGhsnd/9g6l3JAoK2rgezh9M
	 RnWn0QakZ2V/40D3znhPgtmmnre3aU74Tpv0y8vI4FD8/LWo0MXSN/D4ZxzpBVaXDZ
	 DhokMLcb15bncVLijv7ohRxGyyEPVNWQAxKCmutslLe15jQ/D2f/Jy/TaV9xGotPjB
	 78DfsdjK1akuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/17] ratelimit: assert static storage for
 DEFINE_RATELIMIT_STATE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-rt-devel@lists.linux.dev, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260915031334.1194975-9-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-9-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:26:04 +0000
Message-Id: <20260915032605.27DDB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_RATELIMIT_STATE() uses a static raw spinlock initializer, which
> requires a persistent object address for lockdep. Automatic objects must
> use ratelimit_state_init().
>=20
> Add ASSERT_STATIC_STORAGE() to the declaration and align the virtio tools
> stub. The virtio tools use a private compiler.h, so provide the same
> assertion helper and its unused attribute there as well.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D14

