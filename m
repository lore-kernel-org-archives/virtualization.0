Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838846;
	b=f8mrqVffvFclBNyjju/a6ifU2Tw56/1apxitiVWolgDDp8tcC8op7/cjqlsSxxPIJHVb
	 25FcfGQn7F6zoCzdsTGlEqY+ryXtCSLfbp7urdWhSXD1wBe2/tBS9hNU0SXhQGHLDEaBu
	 jwvcVu8dLVzFpB2wPVtSA0aJYhHObNTbfrw9aRbe3KCNlavS7o86GjDCQzc4uniQuDH7E
	 l42qHVYeNNGaFt788VsnmB+5ikvIfsbU8AuL/mVv8AbGEzEbxFgQ4hl4CBkrnPZa9zHUr
	 0uTC0Jp9Tf8GWMbXRA3rc8cM4rnZlcbjTLhZP0M8RmgEOxeMspB9M64mJsZ/DKdAV6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838846;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FGUt+ojnqswIYvK/vLlb8OeXbWlzl+LA9OyzSYqWtXM=;
	b=440kp6WDvmeITzf2TZQFhNneIPzRRSDSLYZe826f6T6KepksE5I6hnv/qpjwQbRZiqyv
	 Iaofl+xtX3SGqfgvq11/1Kjf7DBaYOB2lVgJn4fcFVbF0evOK7fqwniBwNUxMt98CnMD2
	 dkgp+ouY45RpmGR36uhDViK3H7AioNMzNh2kTJS3n8ZYRePxenVc3a7VL2CE255eNYlx+
	 pfX2On2cfcSyx7hyq3uZ8XdQs18L+UdPhyaGn18XMo4fM8c/Cm5dRnubXG+/J+a9LZMw9
	 TGAT2+YnTDX1BdD66hrktNDNkzno1LDhGWxsq0NTFatfZZa86a4qTMBIvgqZeb/TG4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhjJ5ULs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D7606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhjJ5ULs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954D51F000C1;
	Thu,  5 Nov 2026 00:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793838845;
	bh=FGUt+ojnqswIYvK/vLlb8OeXbWlzl+LA9OyzSYqWtXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lhjJ5ULs+N4cCJ0RCigWlooDg3+xEBBzR4U03xnhEeZL5yayd2qagnJ1/Men2gvZG
	 hdzvx1NBB5Ez57Bzbg0B7999ooZwo5QBxJ9pv8OiatHRWHy6gmkmogrV9cIR2pB2k+
	 skNmBZkOvRkFMI/i5aCrcXij/LcwEyFqafJHbBvTlzOh4P4oTTMlNLDk6sEVezFNOE
	 aqdTW1+AgzgEdpS/Rm/0qv/lTSFVz+vj1Uu3y8AdcPXlVWVnz4NnHIlNpcBohfsWJV
	 aSG8HaAPBUcO2rxeZINCv+fActXkO+K5efl35B2sTzGpHmS0ZkCPeAodke1YkBM00v
	 xVpZAYKqTyMXg==
Message-ID: <sashiko-outbox-198361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 05/12] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000915.15177-6-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
 <20261105000915.15177-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:34:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Capture trigger queues I/O messages before PCM_START. If the START
> message cannot be allocated or sent, transfers may remain queued, and
> ALSA does not invoke the action undo callback for the failed trigger.
>=20
> Mark the stream stopped and disable transfers for every failed START
> path. Arm runtime->stop_operating so sync_stop releases pending I/O and
> prevents prepare, hw_params, or START retries until release succeeds.
>=20
> The stopped flag is shared with ACK callbacks that can run without the
> ALSA stream lock. Protect every stopped access with vss->lock. Read the
> pending message count under the same lock in open and hw_params. In
> sync_stop, decide whether RELEASE is needed and mark the stream stopped
> in one locked transition; leave it stopped when release or draining fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE
> is needed.
>=20
> Record the RELEASE obligation after successful PREPARE and clear it as
> soon as RELEASE succeeds. If the subsequent RX wait fails, retry that
> wait without submitting RELEASE again.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000915.1517=
7-1-mynameisjune111@gmail.com?part=3D5

