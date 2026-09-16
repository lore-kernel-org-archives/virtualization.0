Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B1486E7D;
	Wed, 16 Sep 2026 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596049; cv=none; b=UQVB4yTlBSmwrNQqDn4a7minveZ2L+da7xuauCrs9W8T/pw9SQeVzQ7/sgYcDtJ4wtQ14t//y94AIn9WtMObQMYCw9jOGAwAmt4JRaIV8QxajjXxe1eeIFJtL0vVOlX5XQJw6j7BYy3JwECXoqzXYvlA8N5QP46qgoWAhS60+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596049; c=relaxed/simple;
	bh=NojZdnWvKe7IR5omxARJcOrfVnJ6pr3BlQoTbJD36Vo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gETtnd9LhAWKTcSUiusqXEWZPXytVYhA5RE2/PeSM+SOA2ExlHkq5PPUNt6lpwuM+ofmgF/dzOOtSj6gct0VSL0v4zluv3qpbsMYktIghS20VeWHaFa/9IrZ9HNRLvxTJz386gbYSwgNJ0o28SYaqiMd5pS38JzkBVvWgdbtNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCiLj0/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCiLj0/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36CC1F00893;
	Wed, 16 Sep 2026 22:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789596032;
	bh=NojZdnWvKe7IR5omxARJcOrfVnJ6pr3BlQoTbJD36Vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WCiLj0/Ce4FLCHHaocAIvqB9XrpNlJp7/e2RThwk/HVCQ7t3JucwtZN4Y0LBxWGqm
	 BZsw1/cjuO1H+X9i+FyAGAvhBPHG62IZbvM3nRd6Oa2szN8TbY99h6fmqubCL8Bh6W
	 T7AzJoEQKZZShXY8/Znsst8eSPGvVwhKbae6Uh1tD+WZem0GJZu2g1QsgnEVEqKIDg
	 G+Fvq9ak6a+SfpnmBrJhhxIK8BAJbO4+rszrei5cKdX9jAMSV1V0FMZ2Wcx/w4XbIg
	 eb3IhJX87hmkcU44XSb+rceMw+0t9VLcGPTji4miSuyBE6hXLreZsIuff5nlq4TxO/
	 UZksMVTze/Ngg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/12] remoteproc: virtio: support dynamic number of
 vrings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev, conor+dt@kernel.org, robh@kernel.org, Frank.Li@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260916-remoteproc_virtio_map-v1-3-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-3-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:00:31 +0000
Message-Id: <20260916220031.E36CC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The number of vrings for each vdev has been fixed to 2 since the
> introduction of multi-vdev support [1]; this is completely fine for the
> rpmsg usecase, but can conflict with other virtio devices (CAN for
> example requires 3 virtqueues, entropy only 1, network a variable number
> and so on).
>=20
> Remove the static vring allocation, transforming it to a flex array that
> is allocated at vdev probe time; for the existent usecases (i.e.: mainly
> rpmsg) this leads to no functional change, except the additional memory
> used for the counter associated to the new array.
>=20
> The maximum number of virtqueues is limited to 256 due to the uint8_t
> value used inside the resource table to indicate the number of vring to
> allocate; for this reason, no additional plausibility check is performed
> on the number of vrings indicated by the resource table.
>=20
> As a side effect, this also fixes the single virtqueue usecase, which
> was apparently supported also before but for which the remove action
> caused an error (because the remove action was trying to unmap also the
> second vring, which was in fact not mapped).
>=20
> [1] https://lore.kernel.org/all/1330589497-4139-5-git-send-email-ohad@wiz=
ery.com/
>=20
> Signed-off-by: Francesco Valla <francesco@valla.it>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D3

