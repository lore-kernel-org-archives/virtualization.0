Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168EE2D7380
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890124; cv=none; b=lLOS8+lym82N40tQuAqymNrk20QUL38sCL7eCxWpNVOGFc8YqfGlBAFrQyh8l13341UCMKljaee/YoubKIdz4krRW+w4tLEr8CflQO5HNgMS+5nNEpkEpI7JKHabujxOV3UkaZksYpbR4Bn9BkRbjZ1A0/nHZNxZ2HVaefbJ30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890124; c=relaxed/simple;
	bh=J99RHanEPW+wJmUVQ4WGSuuM6jUREIKfQnqH/7stKn0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LUwP54m9lZuArz8ApU/kv/efVMPsVKvGwMziOXv0IQuQkAR8dfwc6S2Sbzey3jH+BBOQaYUPnVDXTydT265OlZGrl+IAA25TLLCqLveayy4hNToedaYHW+GAAaAw515W1SnxI0xIsRKCggvyNqgufAJNFk7se8ZLqFA7a7OKGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFLrT2dN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFLrT2dN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8453E1F00893;
	Tue, 13 Oct 2026 11:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791890122;
	bh=J99RHanEPW+wJmUVQ4WGSuuM6jUREIKfQnqH/7stKn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fFLrT2dNWMn3GeOgVBYjeYFiAFfBU+utcXy/Tmxg0lZza9s6qH1j4TpKOm8ZtZL0n
	 eRP6seTjApCITm0YiNNsyAP2w3iz+JkMjFbKhAShNzjLdGcbSOscNzn4ck9fZTuFwl
	 i2mVJwDqG4CdGFsRGnVwqD9xFNna6lzqF7wAOOSJA4/7Og+ab1evQ8Jfz+6MNl3+4A
	 tBxIYtRQxqhq7zbBaSNFsMa8ThDn+xOE7o0Wp5mlApfwR/ByB+XGkl5ciOiMTUqBk8
	 QLgjuQZizYLOZS2BmUBxK7Rxw6Gb1YAqBaTbYbyA62W4kaHkLiYP9GM7jCsVRSrcZY
	 9yJxNikOGf7hw==
Message-ID: <sashiko-outbox-169594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/4] net: add ip4_parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <bfd6257f8fc8a5c6cd876b8ebc498b8a4ee0be8e.1791887415.git.mst@redhat.com>
References: <cover.1791887415.git.mst@redhat.com>
 <bfd6257f8fc8a5c6cd876b8ebc498b8a4ee0be8e.1791887415.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 11:15:22 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Multiple places in the net stack open-code the same minimal IPv4 header
> validation: pull the fixed header, check version 4 and IHL >=3D 5 (where 5
> is the fixed header size in 32-bit units) - and locate the transport
> header at IHL * 4 past the network header.
>=20
> Add a helper for doing that: it returns the validated header and
> the transport header offset, or NULL if truncated or malformed.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791887415.gi=
t.mst@redhat.com?part=3D1

