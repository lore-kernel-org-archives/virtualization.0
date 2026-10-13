Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C40547071
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849963; cv=none; b=JWS8pXk/IL9Q7nL8e9GLB1DvlphIjP3RGKoobJAhBD8JJWjgyp8N4qHMvT9EysNBp33bKl88q6TxAPc4j4HL6SQlFaqXgav1VKltvYZcCdRLcG687RM/J75HVsCsgmJ8Fv3Ry2KSjPXXjs90PK4fh0MYxmGsT2PuENubmvhJLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849963; c=relaxed/simple;
	bh=YTBzaQ7nQAWlpWRtIgMRnK7D8S0R3GeEKXibxeTyqfc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=claxeIulBVWC96GpH+X/LoVI6mkdYhcXlyhBP+3yEmqB4NF5rjXwI9iT/qCx7xKj0e2u8TNuGIFognYVlpeNDWOsB9c6pFs+LPT664aGQWp8S/IpMT/3ufMZXj5U6WrMX7xjpifNrvzk+s8w0FodSY5KO+r+s9ww38Q5c6rof0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3wcVKQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3wcVKQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446B11F008A1;
	Tue, 13 Oct 2026 00:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849962;
	bh=YTBzaQ7nQAWlpWRtIgMRnK7D8S0R3GeEKXibxeTyqfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3wcVKQXOf/0zYBETkpoeGg+OGqQjeAyL336EnRdEVuy7O+zdVpaWvjjC6aAnAMef
	 EtpuxHWxF6mE0uy8iXBwfU/ZnEvGuVHz8eBk/gMoRIT0HazV6y91R1eDYDSpeyKAUU
	 b4Hxc4r83TkGBiDAsQ7xks69ZD98tvHCaEV22UJU2z8YRA9WFjdBv5DyVHRthIPBV9
	 I0SfIG6t4nEn/1W815QAFXtQlMq8jtalMKbCymWW8RXEhJ6Hob9iQLHfwxOE9p9fAb
	 GYvPw4EXOonBMqn6PgP10KmdJgOWo5FiTiAJJYY8WIZVuqNn73miSU7u5Rbs86pdoo
	 ahGtk3YBbHT/g==
Message-ID: <sashiko-outbox-168770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/2] vsock/test: cover SO_INQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261012235524.41468-3-devnexen@gmail.com>
References: <20261012235524.41468-1-devnexen@gmail.com>
 <20261012235524.41468-3-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:06:01 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Check the SCM_INQ value after a partial receive, after draining the
> queue and at EOF, that no cmsg is sent while the option is off, and
> that out of range values and SOCK_SEQPACKET are rejected.
>=20
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012235524.4146=
8-1-devnexen@gmail.com?part=3D2

