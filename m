Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC573EB815
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267711; cv=none; b=oFC1Hz+ZKuRgMqv3kbIwIcXSaTPyZgSSwaSE8+WY2N/TRnb+YyD9wa0Z3U5TbjgMtFDbApEZmdcy8xqnyi94eO9/ZNiNY9MqVYLmF3DeJWj0y1FSXTR/YE0IsLTrrLDssTjNxgQJQqKbjeZw8bSDYN91FOmXnGgsF0kIp94yZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267711; c=relaxed/simple;
	bh=pd8/HGNiqfl/bgzkYrxk8efVvk4hPX4jfCF++hfUJQI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vBlMod5Jh6SYyAttK0G4Qgps4fbWG/ejQuMQyISF2GIkOZ5/wmSmNWd/AnB3dZUMyvIxoRB8xqitOxyWnuBzmV2mN/9VjarUOwKS61AbLXeVN6qukmRkS8tuLoqGXTxNbe0LacFruSTqeLtZBaI5z/ebnnaJe4QiAClSBkd67iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vyyyl/lH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vyyyl/lH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF3F1F000FF;
	Thu, 24 Sep 2026 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267709;
	bh=Dz4JtRpwtyy+WoxU7CrXujkJx3+4Eb+7+yaqJlnTcFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vyyyl/lHCIOCkT5nIK3kf2xmjYBJ5lU9qn8kIqudQURXfadT5oVOywkRu8CszkYL8
	 SubzapbV4UH6PpBg+vnzK9RmWKMkiPu+Rgf4St7n4mjqE6ee5WlI2pSjMPj73TyfPe
	 rsOJj1EKryt1y83OIw6RUyucflN3A5H7rE+ST3xt7e4t71sxopag7xXN761VHPLIlR
	 8lH4fHrVz5qggWPkwwSPr248YGnJ3VVY+fiSufA/vnplbFS3Thk64U/CjeaGuIrXgw
	 hCcPD1J2M2rzqagVZGarlCSQkoKi4wdX6FduSUpTzUwNhxKK5skJYpJUiQVQEikKAl
	 zESrbhs2qwayg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] virtio-usb: add SuperSpeed device-role support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Skalkin" <igor.skalkin@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260924160907.145405-8-igor.skalkin@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-8-igor.skalkin@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:35:09 +0000
Message-Id: <20260924163509.AFF3F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] usb: payload corruption due to oversized endpoint descriptor mappi=
ng
--

commit 3644614322079b958f1f64d6f45046b653de97cb
Author: Igor Skalkin <igor.skalkin@oss.qualcomm.com>

virtio-usb: add SuperSpeed device-role support

This commit updates virtio-usb to dynamically parse the maximum supported=20
speed from the host backend's bind event rather than hardcoding it. It also=
=20
configures endpoint packet sizes accordingly and includes the companion=20
descriptor alongside the endpoint descriptor for SuperSpeed bring-up.

> diff --git a/drivers/usb/virtio_usb/device.c b/drivers/usb/virtio_usb/dev=
ice.c
> index 9ee1f050019f1..ee41ea9d164f1 100644
> --- a/drivers/usb/virtio_usb/device.c
> +++ b/drivers/usb/virtio_usb/device.c

[ ... ]

> @@ -461,7 +463,13 @@ static void vep_enable_work(struct work_struct *work)
>  		goto done;
>  	}
> =20
> -	sg_init_one(psg_data, desc, sizeof(*desc));
> +	if (virtio_usb_ep_comp_valid(comp))
> +		n_sgs =3D 2;
> +
> +	sg_init_table(psg_data, n_sgs);
> +	sg_set_buf(&psg_data[0], desc, sizeof(*desc));

[Severity: High]
Does mapping sizeof(*desc) misalign the payload sent to the host backend?

Since sizeof(struct usb_endpoint_descriptor) is 9 bytes (which includes
audio-only fields) and desc->bLength is typically 7, appending the companion
descriptor immediately after this 9-byte chunk might shift it by 2 bytes in
the resulting payload.

When the host backend parses the descriptors sequentially by advancing
bLength bytes, could this cause it to parse misaligned data instead of the
companion descriptor, causing the SuperSpeed endpoint configuration to fail?

> +	if (n_sgs =3D=3D 2)
> +		sg_set_buf(&psg_data[1], comp, sizeof(*comp));
>  	hdr =3D virtio_usb_cmd_request(cmd);
>  	hdr->endpoint =3D cpu_to_le16(endpoint);
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924160907.1454=
05-1-igor.skalkin@oss.qualcomm.com?part=3D7
