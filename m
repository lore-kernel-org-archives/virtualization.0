Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182755;
	b=jRn44lZFimtOUJ93Gmkz2iFLoMS0/hJxF+MQZaD4vQzGvkWxRdrdCRXxJF5LcyCBLVIB
	 +nBp+tvWpFZlIy6j7XKKmcqryJ/9sxKokGrKVyNlMpd0d4/JkuHCT2wVtFSSroSAWEqyj
	 YhmBtTUyxz61PdxLz7UyhgmgSAFACg8tZ+3GTzT/1xlyPhEvJo60v/hmDNEHZAN7ot4KJ
	 jQy1DJRsH0hMFExy2pYHtxyC/PdO70FYfePXwSYiX9xqO512W02NU5w3Z4Wm4EHqzlAC/
	 S9s4KjztT1qm5yJGEaFbd328srYI1bbz+avEx7O3xGd0wPO8FRWlfSrLeNZrOwZBBoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182755;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rvmz88MaIaCU735U9P6+iAre07QLZXE3TEYZ6EDa4Nk=;
	b=KPnecAe+uK+lSUMW+3icLro8jduQqrGCT74aGBSHNECFuHy1teQIP5ukWfvGHovl1gQC
	 Wva68IutvlGfdWkRQNAtuwe1hcGzD1kWV50FI7ycJyzcyCm2IFYM7LMzvinBXL6g5LoSX
	 D7+3DJ2rinJUHw0G345MRykg17Pczmpe85YcOP0S317MePOHGVPHugvGb6DQcUPQI/Tzo
	 ngEKlbalTgz307xEu3XSh16Add0gEg7CE9wp42TZ9BKBmjadWkzJTxdJUVvOPx8OxDVIE
	 lD0TbAZ8hsMOW8cqpYF0VRnDFcXYqxYoEK98845Aox0D84CYFQlJXTBW+Gdo8l9Bcow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GP08EXkd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0A606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GP08EXkd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927171F0089F;
	Mon,  9 Nov 2026 00:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794182754;
	bh=rvmz88MaIaCU735U9P6+iAre07QLZXE3TEYZ6EDa4Nk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GP08EXkdeBw9u1KxeqgA5Jgg+UXxfn5SBqHcZ94IsdeY8B8rwAlQptm4B2schkmPi
	 0SKP1+lB8D9b3M8WTS6C86CqhIG1OJXI600m49vKjzyCOT0WHvnIVoNmWN1wdjAmTi
	 zXbNOTxKlY5ut6FV9p1yre4RQLVJEEvZSqrXfdqxMQ8PGBxEGv9zzMt6Jj2uixtfVJ
	 cyD61gXkZnTrC6Daw6tX7jNTUy3NhiqmAUUheHjFzp5mKm8ttAog1iHneJcCW4WHD7
	 +MTTY6AoSuGdTFpYS+fLKPJOaNHSYoyPjfM13wF7QcVicXZgafyyn23r/4KbuTjyGL
	 +D2pZwfVtXbjw==
Message-ID: <sashiko-outbox-204188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 03/12] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-4-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:05:54 +0000
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
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D3

