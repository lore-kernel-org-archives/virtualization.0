Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329317;
	b=SXolm1om0z/EV1GkRZwbs2DZaKgJo/NOoEwsHQtZ2c8hCCpdhw2xh1uuCGt8jmBE6OwU
	 XDhHd3unO9TcXnbligTDfpWLcNCmaL0zvozhuF90ah2m/aN1xYTs54cUW3ZBERooyPYkq
	 1cLSe/Cs15cVKsAvXyvPj9iybtEaFq4a5VxUwx4PWV863V90tfEqT181e9qviV6O11KSs
	 ltrxrUn47fQyFj/3M0U9Qyh4tXTdV77V5a+7kGm50JJlBMgYbSqv09Z+Y6f4+EUcGfaQH
	 QXFK+q9kMtZBKxttA7Q7H57BqTDLBnuKzM5uml4/KSkLMXHhrVTozxpstOu4qQmMFmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329317;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Jwwk5V5ZCaD/R0nL2uW3Hm87B5N2Dc9jSKlvyDZ1btg=;
	b=hoDFipFKhI/ypEkS6ybNmnD5YqWhbULS4AmKSD/7KcZphY7IpC5OyYOUMLxrhimC3BPC
	 GkVDA0TDWpMDM1sAeRppzVFSL8JhrTR66e7nr7mEWApjpZ9Eix/6UMpbck9XhQQs6jK/E
	 NV4eV5USDmNwlxmDyWXLA4kQau0LwE1XKm3YJGPJwZPomnPpDRuAGEgPD83yXIdiXj7ah
	 v8UOhPPD+DAjdNgcRT49vdMZ9hElHXVVll9RIXViBvhjiKB9aD5ibEvCQa1dJzWGPKQzX
	 3P2sCBKfqk+OHgeO3pDEdk6ATrTgTTZ2p5FIrUHfUjIyMmwxEEmyruG6yUn2FlbY2zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJnDEi3J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DBD606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 03:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJnDEi3J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE491F000C1;
	Fri, 30 Oct 2026 03:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793329316;
	bh=Jwwk5V5ZCaD/R0nL2uW3Hm87B5N2Dc9jSKlvyDZ1btg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJnDEi3JwhmlwYX2MQl6klqygjAWGqoJy+2wX1Q5oThUhqyH+L7SxEOFPVBa9JDGU
	 mEo2FWq+nUtKxkt+uwd8OSyrgq9Dudh54O/U4LpHSTg+LX9ZmOK8RWTTmJoGm+w6aY
	 yJmR6tzCLsaXiVNPA8NcXks/jfp/JVi0dc5r1hS7ObRpSPmCYvj+PyKsgAs1FadmkT
	 N2aq4vYyRBUarjGOSZdLNRgqvFJ4q0CZhY0cw3zwGmarU7/wtL7t3l5OZseG0rV4Vg
	 rm/Pmp27He1Ntc7+2fPUW+hJBSkp2BLqHcawrHxZ/DVoghIPaFjEmdS3eSQxm20u0p
	 Y6O0V9cBx2L3g==
Message-ID: <sashiko-outbox-190191@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] virtio_balloon: add tracepoints for inflate and
 deflate operations
Reply-To: sashiko-reviews@lists.linux.dev
To: liuqiangneo@163.com
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030025834.19160-2-liuqiangneo@163.com>
References: <20261030025834.19160-1-liuqiangneo@163.com>
 <20261030025834.19160-2-liuqiangneo@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:01:55 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Qiang Liu <liuqiang@kylinos.cn>
>=20
> When the guest responds unexpectedly to balloon resize requests,
> the actual applied delta cannot be observed from the guest side.
>=20
> Add a "virtio_balloon" trace system with three tracepoints:
> config_change (target / resulting size / delta), and
> inflate and deflate (requested / applied page units / resulting size).
>=20
> Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030025834.1916=
0-1-liuqiangneo@163.com?part=3D1

