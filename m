Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984788;
	b=1VFJc2KgLqF/jKW2EfcoWm0HInUS7cwbe7YdlhdrCOMI8lzBmWpK9FzAwN6EoW77G/r0
	 yGA8OVsWL10ce4ZzGabeZU/cKhgBnBvNIS3p4krtMGHc/oce4pdS/4hgbKS8/H817QUjc
	 4GunZu6+0QkyePv6VqwF5JoBVMZF1dDJWK90F7ito+NREbsBCYoUB47Ko3qDgQnUIeE+o
	 plpO6Qf8VR0hnShiXXIcSVOJh9J4DJ5L/sAeQDKbofox/WXTRs9/E1VWxLNkMj9fhR2wp
	 ijVrcabG+dK1K1DJ8vFfjZny5jrB7QrFjDIufC3pQsRWqnmCgvFQf1SSQEbOSXbDZLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984788;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pAX7+YWc1zhaQmOMigmVD+shaCTS6dHwBQ8zFvoDAzk=;
	b=bu2vx7j3AjEgzvhMP6Kz6DJkb+SpLBAJ8NqI6QBYBlapnXqXt6DB4ZXgLk5IVrR9DQhQ
	 3rGOzLPs414KDmZTs8VBoDglY89lQi2gxGkBIbWjt4TffvA5DwNxSxRkKC78Y/7PioBNz
	 T/nPit2yekoMdCQtPUyNE+0qjBCj0jmLnvBxes2qHoxEFGv/leXTIjZlnW/xpREgdn7Po
	 Q0bqCghoLTjK+w0eCMH9bbSFXl9bQCYdE8cglzqNX1VAwMRnvmyUy/HBcYF/sTryJjo5Y
	 CCBZJOzp3Saq+Q0plBbjCdUn3TDtyFiyjqw9JOU/A3erqVd6LFKzrMs4jdIut43uECw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LROmWMrC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8E606A325
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LROmWMrC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF541F000C4;
	Wed, 18 Nov 2026 06:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794984788;
	bh=pAX7+YWc1zhaQmOMigmVD+shaCTS6dHwBQ8zFvoDAzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LROmWMrCh/IzBB7C5jnSGs9yVhrDDyo1nK4vzyZuKgrv97CtLxx0XIZesltXOLxXw
	 nohKcwJIVC3YGmHz2P2A65Res0FZGX4+0nYCyorrsgtoNf9yS059wFMS1/HSNxZKhY
	 9meFG1D30u/dJtZ8g4XluetHq0/7qCWvV0obEcis34t6R17AMurwNPfTxnFGB39ix6
	 srsEuixbxebhQVkrlTV9CokweShlwFEWj3faaB6ajnIQL/h5A6UESNajhbiKtouDUV
	 11DWoZKIyQAzWxmT1yvgoz+FK1nzjttNkoK0odwxGYEHOn5XomLPb1ap2M5wVLGkF+
	 bNH33R0Yu7Xcg==
Message-ID: <sashiko-outbox-220276@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] x86/vmware: Route low-bandwidth hypercalls
 through a static call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <7c77ebf56fe48daad11a0de31ff41785364e5029.1794206170.git.zack.rusin@broadcom.com>
References: <cover.1794206170.git.zack.rusin@broadcom.com>
 <7c77ebf56fe48daad11a0de31ff41785364e5029.1794206170.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:53:07 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Alexey Makhalov <alexey.makhalov@broadcom.com>
>=20
> The low-bandwidth wrappers duplicate inline assembly for the backdoor,
> vmcall and vmmcall paths, and each repeats the TDX check. The early boot
> path also needs a separate dispatcher until alternatives have been
> patched.
>=20
> Move the assembly into four backends selected by a static call. Pass the
> command with input and result structures instead of ten arguments with
> nullable output pointers, as suggested by Linus. Keep the existing wrapper
> API for callers.
>=20
> The backdoor remains the link-time target for early DMI probing. TDX
> guests cannot use its I/O port, so it forwards them to the TDX backend,
> which still rejects other hypervisors such as KVM. Each backend fills
> the complete result structure. The backdoor replaces the low 16 bits of
> %edx with its port; vmcall, vmmcall and TDX preserve them. Export only
> the GPL trampoline so modules can call it but cannot retarget it.
>=20
> The selected static call also makes vmware_hypercall_slow() obsolete.
> Remove it in the same change so no runtime code refers to the init-only
> mode byte. Print the selected backend by name instead of its numeric mode.
>=20
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Co-developed-by: Zack Rusin <zack.rusin@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794206170.gi=
t.zack.rusin@broadcom.com?part=3D2

