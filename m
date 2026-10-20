Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497841;
	b=fcQibIRBoJ9iUJ1ZWd8+Mvn9k2x4mhfP6zXiDQrB5VAMSoxxXbxOiOCxt8Sc8W3Mx9gb
	 U06EKOBvH3J9DI5ZexyzXqWHmb+2QkeL0Exgr/UwgqKhaMJiMwzAdvyxVEm0bt1pOqx/l
	 wKctYEapnZ3F+L2YMrusRi8HrVGZGsbO6cQQPUVdwi/UeiTiXpxLn7zhzzzXBpOUah3HB
	 u0o0r9Y6dS+BqZrG2XthhfOEefGCtfs0VBkfCKbTNWrK+ewDVJUCgeJEgdLfNheJkI3iB
	 AbAkbNzMQMcgWaNDz9cdSwCX6/iZN6odlXf+D8QgAB7S3R67VIQV2hF2iJUU/+Hp1YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497841;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q46rA0vKf17pqCd8IrFtpqBt8R4O+V4hYNexpSYT768=;
	b=3Z8g6g/mD4OS5TGT5ECp/eeojisAahtAX9b3M15mj8xSJWzx6Razei48Mw6/N5BIOPhM
	 Ov+RkqkbZsURxM85waBedfOyd1AddhgNvUKU1YqXoiqwZL1dy33By+sZe8e2vZPOZnaNB
	 oW3zBJHCpV70zwRcbR9h561gdw/wkch8TF/4mHQLkswiKFAKlpdBSed/4tbdhWWPOKZBS
	 4pQguea7mAEI2Qr/RLx7t0aOGjO2502w3660uERHeGOWm3eAUSChedGNkVZtoc6y+Ee0P
	 bEBijWb9kv2j6W7lZon4QSmdS/6PIOlNYlE+eNU6dGu50XRAUzOSWsZ1AaXm137RHOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/ZYbVLf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6C606A31E
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/ZYbVLf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B461F000C4;
	Tue, 20 Oct 2026 12:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497840;
	bh=Q46rA0vKf17pqCd8IrFtpqBt8R4O+V4hYNexpSYT768=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/ZYbVLf1bGO1AUGuMqgRBaco5qHY9D6ZBRtaiJ6MN8yZXA3RKzPfvAlbTnBs+RX+
	 9hapB74RM4OY67wU+65eWCZE1Ryj7Zll0266v/W2u0xvxYMln9q8oQIgI+6use1mPr
	 DZiyvLwaftgJjm3hI2iINtaXJQcIGPVRL+8n2MnhW1bQzaQha2ctHJ8GOo0AKcoM+A
	 yCLecOr7CDAg1jhX13mJC+Er0fDW5W6hqLo1dNMRAI4tkXSdLVHvgd5+7hE0Rm7ns/
	 PUI0nocBgC39PMd5RCLXND1egVSTAQDUWWTCH1nfyemQ7yZAJRdgJ4jak6SGB158K5
	 3S3yxAMgJuNQQ==
Message-ID: <sashiko-outbox-178919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/8] um: vector: trim skbs before verifying the
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <372d22237412a8dee2f848660e76162f05c566cd.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <372d22237412a8dee2f848660e76162f05c566cd.1792411304.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 12:04:00 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The vector receive path over-allocates the skb and only trims it
> to the received length after the transport header is verified.
>=20
> A follow up patch will complete the packet checksum in software within
> virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
> checksum would be computed incorrectly over the unreceived tail of the
> buffer).
>=20
> Trim first, so the import sees the packet as it was received.
>=20
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411304.gi=
t.mst@redhat.com?part=3D3

