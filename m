Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847464;
	b=DHEFvEogjyfzs1HnOjKLmYOZfn7hb4ccWykc/fZgxNMJb3/JiR7ItxUXMrw0LD9fkTnP
	 UZVrjx9LpLPBzjg+mp2xo9WbQhddUn+HWEBLGlRIw0qMycaQkqZnfhG78n4Wnp05owBoD
	 WQMndvp6uTe2+AaMdT5/kaziR4U/csjqvgxgOgmRaV8raYm5nnK6XmLphQ3izj6CLcDyp
	 vHYCpICB5gxYcCthKiA3qX1EsoqFEAOhRmYH+186rxgzuYBGGOLUcOstWqQsdgDjmRqgY
	 JT9zqUWp1Q9uaZgFSsHxc5AfEGrhDPIWLMFgWiyMNJc5HzxcW1Qpu1/p7iG6+DPhUvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847464;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qCtkqcOSDZpuTZyFQMjjjldUPPxga5pEgPKffF4ZRVk=;
	b=Z93vibD3F8GezKZyMcsm6TWBqACx+URH1NGQHNFszdsVDXta1cqOnIUywoBB68OdmqNg
	 NtKLumuIFAGDFJETNTmmN2xq8640pj6Sf9DRNOgrOYUaUV2QDHANBg014WO9S5ErSL6j8
	 7dkrUAFj/+iD1w7sLJ5BjlHJbfjsn16Cyr29wieuqyBJVVRJV/PGB2pQFiNR6KWCSsXSV
	 f8k1QzVbl5v34cdmPmCYFsgXbPIl874Qpqdn6wQQChwIHi4Esz+dJrej88n+J68NM4XHT
	 U6qirx7QfhwF2DL5dQICJ7ixcXU/Th5klNpTQ8LXCqddofT+K6/wuuy4cdewPrCxVtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TaFArpfm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F55606EE9C
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TaFArpfm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910B91F00A1A;
	Thu,  5 Nov 2026 02:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793847463;
	bh=qCtkqcOSDZpuTZyFQMjjjldUPPxga5pEgPKffF4ZRVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TaFArpfmXwH64b6TNwMZo2Sux9uGxwfRLVMr6FFpZSpXU/B44WK0Uhmp1bB4MhAk0
	 oDSJoOfMKhZjAe5hbGyZAyXH9aQrvd2bLIDMdPfQhKmiav/FQZk1BuieMdfiKrcsvw
	 jfVA71aM3OEOxClihe8Kq9Wi7uTK9ByyCHCqe5FPnVZ7hmw860hHi0isAjNIFqk2DE
	 S3Kwj6fsraTMap0L3Z4Gh5f0+3XATG1TWVhO0PUpxw78alCSGs7U13DZYj8lmfTQ72
	 5x7KnBlADoXgGaR2I52Or/dN9jViwHAKPWcpVBWuJgzXZxIX90VqGoOgMCEYI4XoKV
	 wZw3f9DomLuFA==
Message-ID: <sashiko-outbox-198491@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 05/12] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-6-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:57:43 +0000
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
> in one locked transition; leave it stopped when release or draining
> fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE is
> needed.
>=20
> Record the RELEASE obligation after successful PREPARE and clear it as
> soon as RELEASE succeeds. If the subsequent RX wait fails, retry that
> wait without submitting RELEASE again.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D5

