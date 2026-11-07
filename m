Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063661;
	b=urI+SXAeCw4OH74pyldTFV01hCUvvpuIlHEpsZO2tolirbGKbm0m0yN/IemnENowFBJ6
	 6UfVByYCZVUbx1gpkxVT4Naj53llZ0Zea2igCQooJUmy/RnClT4dxles6af5VLWUY3wht
	 /XLD5AddkIyjjt3dpuUduizW35kMhBnSL/IPvGWyGB7qs9Haid8fEw2OW6FGJeDmJEtUX
	 8AJsR5kKyJvUftQrN5Hd6J2aYbKr0D6kwvh0SlZLjhozGNzep/tPUzSLUbHe1gNFEOGSp
	 eWGpNnjF55VwbApb5XPAS0WHppoLx8Dw/TdHPR2p7sZ2ylnjodPLmrBXC36CFZp4cxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063661;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IM/zoyAEqHByv4uV426EyRvG5YsJRUrh9WmKsYyAEek=;
	b=NdgmxH/jrG+lixrRGDFFgipsFs+smNtG+bvzn6agPJo/Ob6mAhow3Z62+QOhPh6gMqz4
	 vRiz1t+0DPRyKfhJ29yo4cdWFAXfiYvreXcgyhr0SM+7HcRExQndAhxoZ4Kte94jbVnYw
	 Aw3VGXfAGjzOg3U8rlH09ySGesGFbIJgJ94HMYgBnGE8Bvrx0DLXWfspraa0txeRvBM0P
	 SYf7DwVFLFG83DvVxUHUCTG6jLJWIaKNsqhUpKNg9eq06RSf/usovkTcpNxBmla5ckEfQ
	 B3P8sCVGN88/nczhNSg2iyprEss4fxwG7LInxifBBBASSTsCOZlKpEx9IV91mDgmWcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0hBc8Zg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEF606A9EB
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0hBc8Zg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDDC1F008A1;
	Sat,  7 Nov 2026 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063660;
	bh=IM/zoyAEqHByv4uV426EyRvG5YsJRUrh9WmKsYyAEek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0hBc8ZgWWRhqjvxwB+xRXsIzw2toQvTQwdiswrGR7F7J9oDEa+QIOlZD3EUP90i8
	 ZPEr13HiFhSKwdohXf44BrUOptuH915OJfs5OxO4FKtd6DwsPc8+UCNB4SdPEuYYE1
	 sCrwtMj6s8wXgf3qwxTiDaGZ8gztj4Lw7lBza8gmcWxuTq6Di+tZ4oQsNQucgeyyFd
	 q3bj2tm4T3rYsVBM8L6h3FQVoEbYnWEIquFBxr8wlIl58Em7gCpIbrWaCRwq6YXxmP
	 1XUIlDNPbcg+uPR1XKkb0JypcIYg63ujODeE1eOgjuwvxVI+/S65x9vKCZ18Y0ueE1
	 r3X2eWDe6SYwA==
Message-ID: <sashiko-outbox-202977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 05/12] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-6-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 15:01:00 +0000
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
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D5

