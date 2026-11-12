Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462284;
	b=r4vAXagMOKk6TrE679a/pr+Mx0BHoIWdwiWVMthuKwQpo0/fzRsK0Q4HccsPPRQqUY+l
	 A+QFa47f0BEG6JR24J+l1aK/BEfVqmv2bLHWBKJhUt3nNtVWd9i/iKY9cyn/DwJeU2jd0
	 vYNxCFbKyVPdF+PeqGRnJj99Jk9HPGcacnH8N+XviCFkSvAHgRcP2KUcHyCnGa+LathEA
	 RCJuZufWFGoEXelMgxD822WcLyd5t8t7O/w983mMZJE3IZIeufwNmqYQq+zri2uBsSsWI
	 /S3sccfeHkFr2CZ0hzQVMDe+NLtnapO9gcrt0yKOPoiZqHJWbJ/OYAw2Z+lrYFQJ7cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462284;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2SlGVncsz2zxBtySljLqOEImTNe5+X200C7V+qQ76FQ=;
	b=0h16BfCzhSxE35Kj7xu7y+oYRDcgOO1iXCbdr2A4dWw7vO/Yp767A17zJzh3Ng9aJSyc
	 a3BMN1FZ1TKdw4HAoj3PBMtfYJPUzDAgxXfvHWWRTFKal9kWRGeQ3Jk5VBz6PXrdcYe3y
	 aE9hn4fSePrsMC4Z5HmRr5H/wu53SgXAytx1+IQpThDAyDnBZmNVingOjluZvKkLieDk1
	 553vGve92xx86ubege9q7nTrgxtFslgtRQGaG6lCE5H3HC6O4tGkCiwCaLydXEHUCCN56
	 BNL1NBlZBPTHNHPl/TSU8qL4ue6DOs7hgqawRR04d3TNfN9zYCVJGAYVAm45esxL0dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZsFpGZc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45945606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZsFpGZc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD40C1F00A05;
	Thu, 12 Nov 2026 05:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462283;
	bh=2SlGVncsz2zxBtySljLqOEImTNe5+X200C7V+qQ76FQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZsFpGZchNoPjfXre5AoPJjuu0k42N6rHd7BS/88njDqRF6D39/PxeDqUF3bJfMoL
	 53JoVPsgQ4NGMlDG6L9AY1lYBLgFZ39ncn5oo42ZfAZU+/93J4N1+c7n77aoJR/p8o
	 MXxJBlWoRtffa55CLaRO5gcty53MWNOkeftSd6P7Ml9+bFCl3HM5Y4ZfAN70MOaRf/
	 QSdOlPd7Gl6grglRdMl07QMPrevI3UpENMLUyFwGRW4+MWomatVp8fp0yzm4wIDyGH
	 cuhZsgMZ+DUn6FiCehtH9hafTbTa6sKb/7JcOnETtqtrs151qComBUNwjnUKnX8VL8
	 Tmh2I+n3UjKvw==
Message-ID: <sashiko-outbox-210476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 03/17] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-4-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:44:43 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A driver may need to synchronize private capture accounting with the
> common RESET pointer observation and the core's position rebase.
>=20
> Add an optional reset operation called under the member's stream lock.
> Expose snd_pcm_lib_reset() so the callback can retain common pointer and
> time handling. On zero return the core completes that member's rebase
> before unlocking it. Drivers without the callback retain the ioctl path.
> The operation is also used after a successful prepare.
>=20
> Zero permits the position rebase; it does not promise XRUN recovery. A
> negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> Linked RESET and prepare stop at the first error without rollback.
> Earlier callback members may already have completed. Legacy members keep
> the existing post_action policy. Applications must recover the group
> after partial failure before relying on shared positions.
>=20
> This adds an internal kernel operation and no userspace ioctl or layout.
> Out-of-tree modules using snd_pcm_ops need to be rebuilt.
>=20
> Complete appl_ptr rebasing once in the callback path. A later linked
> member can sleep in prepare while the earlier member accepts SYNC_PTR; a
> subsequent unlocked post_prepare assignment would overwrite that
> acknowledgment. Keep explicit RESET playback silence processing and
> leave prepare-time filling to the normal START path, preserving samples
> written and rewound after prepare.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D3

