Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99D4EBAD3
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890124; cv=none; b=HkO+Rgqwdw/CAtsA0vzSwPy8AhMfEUaVvi/uhD01gWnhcYiENRl50lDGHliUP3zvDoFqUkH/ixLjqplYbmvY5SQZMf6RFrXxyGQLOYGgoXYfTDf6wPeyXW5NNUDXobDl7Jcn/Ti/OhDy2ILFKDe+UxyAl7WRd4sYcSM4VFskfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890124; c=relaxed/simple;
	bh=VfxANCO9QGgRdyokN2GSbmS/RIfswKUFvYgkj0eEbYI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QmDCdFxGs0LTu1cXMKpLD8IDtfxqCrt8OzIfjCTAMX822D7NBGOXDwb4oHxXgSmKFBoz5Wxy2rCr9Mh2D5qKM3Rcjw/PQ15lr05A90cG0FZ74/Z1HB9xUUrTjPKIG8L5B0H5oRuHV5SrOG49D4mzjtEpxfV9CaSyk3n/Dr0QR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hr9HlOto; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr9HlOto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428C41F000FF;
	Tue, 13 Oct 2026 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791890123;
	bh=VfxANCO9QGgRdyokN2GSbmS/RIfswKUFvYgkj0eEbYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hr9HlOto5DXxY1fCkyzGBLTW76AtsJKsnNNcS/XHn2dpjUhEI5Lbm+x4v4DH0KJQl
	 txVEhSGQPQ2mF6g7mKPVwloCwFRZl0Oye3KTbEdQz8FQMyv7INXgvyx77eJqJsE/g7
	 XJ2fNCmwCtG5xMiCpq0tqTTJBr+bAliOiSiuDyUA063pUyCbU3R0Lo1Q8X+Q6nNUE2
	 RsX8JJULmJfXrOZn+UngXQuHQOc1J30NgUJzENIVDazH3s2tmxRqriJz3NdNoZlUBQ
	 SilwpyEyXIoZB3+vfrd6G84v7MVHYEtAiiaZp6PvdXC4lzUDZOzY2uHZD0a93F1ITj
	 PWX1B+a781kew==
Message-ID: <sashiko-outbox-169595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/4] net: use ip4_parse() in receive validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <05eb0a83a9975e8e042caeeb4fca5fad30e02fb4.1791887415.git.mst@redhat.com>
References: <cover.1791887415.git.mst@redhat.com>
 <05eb0a83a9975e8e042caeeb4fca5fad30e02fb4.1791887415.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 11:15:22 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Convert the sites that pull and do version and ihl checks on the ipv4
> header and validate the packet transport offset to use ip4_parse.
>=20
> Sites that validate a read-only copy instead of pulling - the nft
> and nft_inner header_pointer validators, ip_check_defrag()'s
> skb_copy_bits, the flow dissector - stay open-coded for now.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791887415.gi=
t.mst@redhat.com?part=3D2

