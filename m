Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264564;
	b=QC3Kvg6ejt36cyAisj2kYs3GGnCuyrcnWCwr1pyOm//28gISZL6/P3+ew2fLDsqZYRDn
	 1h8CpWkZlfOclF9MjnLtx945XHBaBjD0Sia4vVGxWf7C9JGRhmH4eMWvJJyoGhpujN9WO
	 0WospndGqe1hpk8/iSxRJtc55UAbrqCu6dcca+gZJZQU8yTXyQ4lqHq2vYN7Qo+BREfFY
	 7G4P3QoifDDRXodZk0l0k6dMopcZas7FjY+/TRPIaVn0WnMkgBS2jQvQCUJiiPjTj2WjA
	 Hsvbw3xrvz/KJKTMeu167LdGkr+geyjLumo00pH4ITW+uVhR1XA7VQAIWOa5KHLTaJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vv3p/7wm0QBEDc6CLJFMujnGXdcPSn72f6YTVmurvsU=;
	b=I7aF1aLmd3QvLRhIi+D58fdj6mL3GHK58+fDbqjAvlqxVlpViOJNiodVeuaR22uygcXI
	 siaioNAt8PdTP/Rso+DvXLii1kzpb79nnY2ic4vYvHW7qQlDk4EUoBAcJpmUkaHmsxy6V
	 Vitt0Uzh7BxoNBTmwziB00Ig8QR+HA+UPUO8qYmDcUnCaMOgTFhNFWbB4cpIlGRLcvsLx
	 gO046yLcgbU9GeVUe98Wn0UtEejfRbP6HC2X7O8+BrqYaQlVJAvE2XAWm7A7JpXAfPxR5
	 /RDYbXaYNFtNLj1AiLbGVqxbMwMq5fD9pMhy7a/PHoD60QudCjw4B3vuK24Vp/ufQ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPE2AzUc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3D60A2601
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPE2AzUc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09501F012C3;
	Thu, 29 Oct 2026 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793264563;
	bh=vv3p/7wm0QBEDc6CLJFMujnGXdcPSn72f6YTVmurvsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kPE2AzUcyEfpPGOjQQqhv2xG88Nmi00Gmd2IStvazRm5Pc2wF+YJNY++OrT/D7ZbR
	 Ajwj8OVwJVm6EaeFYlCdQKjh1zIqsX3b4/TVwTq8PAZ6OYVlvV+uK4ix/tvXyQopwb
	 CbPfdg+hh4KyYzG7Il7Y46NAD8/+Lu8ziFqO4CLad9DN7U0Epj3cjhHur5glY7NtOB
	 JCbFAg8jdZbWG5uQohtx/z20MRwH6GB7OmfDCJGcudSgEKAlB2jVwyoFuyaQgzEDAz
	 gAE6Yn4YszGNXfE2KmNsWHpop5rX4sMKrNHFWLr1lnEUY0loZ5mmDC3cYXoprdOJvi
	 SsXGkP5FHkp0A==
Message-ID: <sashiko-outbox-189001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/14] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-13-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:02:42 +0000
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
> Zero permits the position rebase; it does not promise XRUN recovery.
> A negative return skips the core rebase, so a callback returning an error
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
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D12

