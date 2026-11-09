Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203462;
	b=a3AQ010yBaB8tX6aodGoSsfV3/bgV0BXi6SPP1I3YRs6Q/N/0/+qCHdgFRdU+xdEC3ys
	 sQOWegshYTSX4yg7OPIFSf8q+AJMcd7PfJQcCxdBUWp2SmGLAAnmwdhAoOTwIcTR2kXC6
	 zQAfLHdEmH08fOSIQLEwYuGFrIwLdLFWts++MYaFaj5A1gjbJtxrmJKohuTwDMvbGd3wG
	 mSGEV9Jz6Ti29ZznbW245lSIcuJ9YP/p8TDJlbVV+gfcEWfxP1ICqz00OsPSQozvVnDcn
	 LK5Q9wJsJqJXP7EqmCmkGPoVWf0StjsjDnEScayFkwms4nNH1tdgsFIjlEpt8Oemj2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203462;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e/GRI6Eilm+AlrbRBKLUQO6xF+UeqIpko8jL7ID577E=;
	b=qPss5GaFPrf28jWvF3X+ffgiQzuTKmQYCiZLSaYd8oaa+6+ocCRiht4G0zMaUrvr2hKq
	 6YmBTqiNYEGNmA7Y5/Rc1YIz9YdNOzk+TfYgWT2zntqquDafwlKQiR6ltpFWR0F749ugy
	 pYKeQUOnQEO5fC2c4WvuIr3hu1hwjdIi6xQZAtIS0T8hlG5r104ARnmZcMB3+W28rSITg
	 oZiovFzAqqnZiMqsGqR0ETLYmkWXsgWEVesfUAbw8S12A8MaieEAxoYZedu2M6cTQBeg4
	 PVfKvvFLOTbtsOniLeOl7708SImAu1OPCB7eVFsTjIzap/PC7lK3CjqNMNa7+JIpLKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuFj8Zoa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335B606A322;
	Mon,  9 Nov 2026 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuFj8Zoa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461F31F0089F;
	Mon,  9 Nov 2026 05:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203461;
	bh=e/GRI6Eilm+AlrbRBKLUQO6xF+UeqIpko8jL7ID577E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WuFj8Zoaq59bph0y7IsraSK9EX7/vLUr0JQpOB8Dhwvbny8RRUdZ+Sme1qtBIx8DE
	 pM2dIyXPVix25BXgVda/x3vLRvSyihz3/iveTJ64RSs5DtMDABalcYb6vMxusJnhUu
	 tnVovYDPU7wD3DKu1NF95sZlPCNwlxwYmBLDWtWmBC75rLFzTE0B7C6uOnpmZnySqu
	 SckASSDfyvwx00GJfQNPB4vr3J9gaBQ67ZvF/XLNhZXEmLrSl0xfnpZMfEmZ4zyErf
	 +0lRaPYXqjAxG8Nn6e49x5qIEZDBs4EvH8KgtZeHCcm0f3Q3aRyBwnWmAhFoKTWo+A
	 FNeXyr8HBNKnA==
Message-ID: <sashiko-outbox-204459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 08/13] ALSA: virtio: validate indirect PCM ACK
 accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-9-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:51:00 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] ALSA: virtio: commit message omits DMA page pinning and RX
  completion checks
--

commit 832b53a386769dc75553162a208f16a9eb5a42b0
Author: Joonho Lee <mynameisjune111@gmail.com>

> ALSA: virtio: validate indirect PCM ACK accounting
>
> Validate playback appl_ptr accounting before the indirect transfer
> helper can mutate its cursor or queue data. Normalize boundary wrap,
> reject frame deltas outside runtime->min_align before byte conversion,
> and check frame-to-byte geometry before the helper's signed multiply.
> Validate ring indices and signed ready counters, then bound hw_ready +
> sw_ready + new bytes by the PCM buffer capacity. The playback pointer
> has already deducted device completions from hw_ready when ACK runs.
>
> Retain ordinary indirect capture's existing checks against unread
> completed RX bytes and its pre-START no-data behavior. An invalid paused
> playback ACK returns -EBADFD without starting a linked XRUN.
>
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

[Severity: Low]
This isn't a bug, but the commit title and message only describe the
indirect playback and capture ACK validation in sound/virtio/virtio_pcm_ops=
.c.
They do not mention the other changes in this patch: retaining struct page
references for vmalloc PCM buffers via virtsnd_pcm_dma_pages_get() and
virtsnd_pcm_dma_pages_put() (and allocating owned_dma_area on !CONFIG_MMU),
rewriting capture completion validation and xfer_xrun handling in
virtsnd_pcm_msg_complete(), checking offset and byte bounds in
virtsnd_pcm_msg_send(), and checking period and buffer alignment in
virtsnd_pcm_hw_params(). Could the changelog be updated (or the patch
split) to cover these changes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D8
