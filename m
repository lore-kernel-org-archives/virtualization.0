Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C58360EF5;
	Sun, 11 Oct 2026 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791704608; cv=none; b=eh3/++tIBc8f0kXhjjsBGZOtYtPo+Ll1cJmYf/IgCKy/v+G08uKJ06LOoUjj/xhdHG6xQNMYMoWO3OFgzcAF0Iovdh3re+vN1vvI5RTRor3WaWKlIeUqrJG31ILSx8dIRjV89rAFReq2TciUjzUMLlWjlTzlcMPPOC1U1nIPNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791704608; c=relaxed/simple;
	bh=76F1tp3XYAaUTHaar4ATx5HBvyaaV6k44j13mU+CFwk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QiIl9qertLgwDcphwO9vhgiYISkvj6+QYLxK9dZ5N25VrXaulofhK2aFRwEYeb1bYOSvcO34oefV3HWCF/Y06e/MDE8jt3zW3tj85BxgaBAZxs4+eu1mhIrzfJW2I7wdw7RCzFR1RcOgHsL2jH0J/uMvnBDWFWXM6F/Ij8bE4J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN8RqNVV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN8RqNVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5967C1F0089B;
	Sun, 11 Oct 2026 07:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791704607;
	bh=76F1tp3XYAaUTHaar4ATx5HBvyaaV6k44j13mU+CFwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lN8RqNVVyGGm5gqMvT8+5C64zCS2AYFdkm1/8kDOjhBZSWjyY9W+KOsB+ZtELvukf
	 r5YwJOVtyjUi8Zbx8NinxUdQ3QIpZ61SpC/0xKmlMY2eDJovsoY5Ay8iGV3X8jsmVM
	 Z1HLMELw9sMf8aQyZdsD/RAchsq9aJSSjyltq18SSc5kzUtfGVXmYprO5dCleky4mI
	 olev7uQIzl4IhxmVHyQbRD6RXeBkBxuWwbWdp7FC+RPZ2LzwgOJqyo3wsvijsN1yUR
	 vIw6mX0kEj3B/86psk+2uuqjW4cL/2rKva0nBY7gip4QpJwjsTBq06LJJ7bKqr7Otn
	 zGArlV49KkxRw==
Message-ID: <sashiko-outbox-167108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost: reject backend enable without a kick file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linfeng Sun" <linfeng.sun.dev@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261011-fix-null-pointer-in-vhost_test_set_backend-v1-1-60b2f12d64c6@gmail.com>
References: <20261011-fix-null-pointer-in-vhost_test_set_backend-v1-1-60b2f12d64c6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 07:43:26 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Linfeng Sun <linfeng.sun.dev@gmail.com>
>=20
> Enabling a backend without VHOST_SET_VRING_KICK dereferences a NULL
> vq->kick in vhost_poll_start(). Reject the request with -EINVAL.
>=20
> Fixes: 264ee5aa81ec ("tools/virtio: Add --reset")
> Assisted-by: OpenAI-Codex:GPT-5.6
> Signed-off-by: Linfeng Sun <linfeng.sun.dev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-fix-null-p=
ointer-in-vhost_test_set_backend-v1-1-60b2f12d64c6@gmail.com?part=3D1

