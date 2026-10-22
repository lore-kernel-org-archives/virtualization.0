Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655438;
	b=pmhzEqy8nTkzX01gw7jIFxquZwyVsm5irfxQbZ1nFPmRkJsFqRE+1VfhJ89wW2QyvxLj
	 FmKqdf2BaX/fq/eBFbVaRL30D026kw5Co+rYAFbKWJf+b+3LkIS0irKHgIWh9ZiR7MVz5
	 QekoZZzlo6K3KTvcW7gF9ZEshZgsVRxEveH0o7aw64Nitel92Jgt79+RSxzkZEJsF7BcK
	 EfZ6H+Cmnnv2w5h/vnjsRBWaDuHzX6xW4pk81daVrY1ppQ3MSH1RIRjjy81KdoMPfnpsp
	 pewfFLeEn2AxyXR0AXrUu7UxPOai80Yf4x/qtULPXYQMqo3h6xDd220hnjH5uDIPaTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655438;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lpq0JLv4H8/4NS5eNM3NmH1vLR960Eo/4fQi30abF5Y=;
	b=tzyI+XnPGYd7PTmsAjemKujicsSw/ECZ7EQX3toUYmxX4ib2OYmEJM98MbNL014Z0pki
	 fKPbSydBMzN+em07PGb/oyB9H8Ap1asY+9gBRhHH26PBtQjR19/MrT/c4iQ3wZ66SG5kf
	 XIpMeSwfmldF7TMltv6Hz0L6DGJ2E95rSon2pg4SaiDjb60jAipAXo9TtLVeyrYtoevag
	 qjdYNbTHIF0cmXT/eVbNlJHNKki2k0lPvVcxard6ZI1nSuxZc+kUCa0QluPd6Fvt1ulYq
	 a/8xwBqyVF5tipsV43hGX2pL1kj1LnSWQM1mEj9N5zjYcXgHB1ZFOn0HXX4/y3rNmbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1CcAG+E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159D606A320
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1CcAG+E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628401F000C8;
	Thu, 22 Oct 2026 07:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655438;
	bh=lpq0JLv4H8/4NS5eNM3NmH1vLR960Eo/4fQi30abF5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1CcAG+E6B7KKXp2owbcvgyWEQeu8v7cZ2gesCcN3zCALSedUyvOoegLjQh3FXlGN
	 ht7oX+oLarqNnQnFQs3jKx15SjUCccQvJRLTQ4kkSe/hOnyvjzde4XdvAR7T1Ct5Hk
	 gdfgtMXxCC46+jtE7fYt+ASsQEg2JZ3CvC+Rj3aadbTrIcw58WgqRh/yOojY0ynrxw
	 7p3L8EDFJhL+SutWRcW63agBtRwKBC435Sx8/9ISRhVPMR7veLAvEU686VoTiOvKLC
	 col8Ik8YYdxSpiHAap8TUdBdzBX1okKzP3TKlC2zwoLkNYbD0NYAHYcvUH80w8yyEE
	 NOsUD5thf4d/g==
Message-ID: <sashiko-outbox-181139@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 3/7] virtio_net: parse tunnel csum_start
 little-endian
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <421e7ebb8173ab919c2b90b945aaed462145583d.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <421e7ebb8173ab919c2b90b945aaed462145583d.1792565282.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 07:50:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> All tunnel related virtio features are > 32, so none of this
> functionality can be enabled on legacy mixed-endian device.
>=20
> Accordingly, all tunnel header fields, csum_start included, are
> little-endian.
>=20
> The nested virtio net header import parses csum_start that way, but the
> inner transport offset is parsed with the endianness specified by the
> interface.
>=20
> If tun is misconfigured to legacy big-endian mode while the tunnel
> features are enabled, the two parses of this field disagree, and the
> value stored in skb->inner_transport_header - which is only
> bounds-checked from below - can point past the end of the packet, where
> GSO segmentation later dereferences it.
>=20
> To fix, parse the field little-endian in both places.
>=20
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tun=
neling.")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v4.git.mst@re=
dhat.com?part=3D3

