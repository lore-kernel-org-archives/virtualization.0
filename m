Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462803;
	b=MNx5KQIfLdPbrBtKAs8b9PU682P4rKxTZuZLjbf4/IAOEqne3gFydIqCypqHA96x530t
	 P2mt8+sDrE/Q+6MWObqngu91XB7NV9UA/dWWhAndiOA6mmRKxHRJfXj7l99+Llg0+LcdH
	 3peE/TXAegTifBq/MMT3DwOp4FyDOD3z7Krnr2XOOiYnsKxewTGhPjVQQsc1ohPU+Xz57
	 c7TyEmzLDnW4WSPWUyMREjZB1E6tixG0oeSpUJu2NJiCQtgKUYnzBmpPoDbo6lsTs0R1s
	 KeXwSgwpbUxy2OStAJLXi809mFGbxIylhcsgt4wFEBOy27SpSBWM4WGk3rkUxhzHa1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462803;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i+niMTkUfzgNm7gWTjXpcvH0X1PD8MjNHIb1H8kUgF8=;
	b=iDM1Pcw/J6Jj5zIqjW+x6WekcFc0q7aQ/t9fhuKpbN08F6PEh+MDGApsgkOcMDhEyNhx
	 qME09KP6EQEwsXhDflSfiu95epwiYV0Ny7HxsLisVT3fJ/wfCGw2lkdBwlGgvAntw1Ikj
	 C58e7TkBRyDygdp6aoQHI+qwZyI0fo8qKKmCQ18PO4S/Y1sQmU54ZuotqB2noR3dNUh+x
	 qM7V0mEai2JtERzCra7pSr06nDvVn+8u7ir40N3/v1ry69uqLjncTI6jUs/lMftnw6+N3
	 dAGn7Nygi+wf1ALiCjj36l5GJr1Y6UqAYs0tD6lMNGQuv40rSusLfOuF8B9+PHw++SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOXc+8sh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894E606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOXc+8sh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458B71F00A05;
	Thu, 12 Nov 2026 05:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462803;
	bh=i+niMTkUfzgNm7gWTjXpcvH0X1PD8MjNHIb1H8kUgF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kOXc+8shJduOdZ75mPyh7tfx5RbfNgGzPqKJ2DmR2bZIZ16bwFWYXHIyYVGRJxEPC
	 NPsdARbBD2DFdmfSGbZR4oPizofH8KzQoQC9kO1lCioIgYaEs3fxmAzsYzXknQH+a4
	 Ru9b5rB9leLWL3FXe67e3EvrgIABGgA6Y1bw15/I5i+ImJgu7335azH0O9ENVosmOE
	 1stch3TBkF/xvSZMtvbqC7UsnEu2LW1ngFdNkn91/XDrOzYaxt74mVyZJsP2uxwNS/
	 BYGESxmyBYjsP1O6BQLUVOf1ezAMoE5YaCNP+AfAK1OK06Jcac7JfrggX2vMRJd1Z6
	 O0EkZWQLOKfSg==
Message-ID: <sashiko-outbox-210485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 04/17] ALSA: pcm: notify drivers after linked
 prepare completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-5-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:53:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A linked prepare can finish one member before another member's driver
> prepare or reset fails. Drivers that admit transfers after their own
> prepare callback can then accept an ACK while the group action is still
> incomplete.
>=20
> Add an optional prepare_complete callback. After all sleeping prepare
> and reset actions have succeeded, take the group and member PCM locks,
> publish every PREPARED state, and notify opted-in drivers before
> releasing those locks. Keep the buffer locks and access gates held
> throughout the operation. A concurrent DROP observes the group before or
> after this commit point.
>=20
> On a driver error, notify only the attempted prefix, including the
> failing member. On any revoked prepare, opted-in members in the affected
> prefix or group return to SETUP. Preserve DISCONNECTED members and keep
> SUSPENDED members suspended, but set both saved suspended-state fields
> to SETUP so a later prepare can recover. Leave unreached members
> untouched after a driver error. Preflight failures have no completion
> callback. A successful driver action canceled by a terminal state
> returns -ESTRPIPE or -EBADFD, respectively. A driver error keeps its
> original return value. DISCONNECTED takes precedence when a linked group
> contains both terminal states.
>=20
> Do not generate a stop-timer event while closing prepare admission.
> Ordinary legacy drivers keep their existing successful preparation and
> pointer rebasing. The new callback runs with the group and member locks
> held and must neither sleep nor acquire another PCM stream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D4

