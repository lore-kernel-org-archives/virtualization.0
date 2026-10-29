Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253991;
	b=RErnJ30bjdXcisjshJIucL81Np/vEm5bv/xcbrwOqXYwLjffcXBeNDKjMhoYvRxhDtLv
	 /ZfQjH1peFrhqeCLU/TRiXz8KD2bWmgXvV2hKjXLkdmP0ozQmyEimMWQUcpk5c8wPBOMu
	 4VQUFwqLszjQdy/Rzd/D27tKzTF5u3JB9LFVysc6iTNjW7KKbfPEHeELp7KfBuKYU/OeS
	 PoRGw5nbJVitHZNNmZ4wgnWvwraX1Y0Y72i9cBh6V3ppmPUp99Hc3nKbcBTW2dIG2Pbb3
	 ouFOR01r9Tzn8KOgvbRqJb2s8xVf2LdV+d3nEvGtNBV3uLASM1hufSTZbK00XxmxYRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253991;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=An4RZIrGtZjzEWjq/3HhUbVpF0IT9CsHAkVBnz449DU=;
	b=EzyYFu8JHwKXcgp9wOAI8/KA2DmsBcJwe/At9KW6BZU0s4vDx/2ahYkQyT1pr/QTEFsm
	 eQxPt/zmdxFgdYJsaVeH3OYHwVPLpWiTILYVYxcjX6cwikxzuoT57C+HCWkknXHmPOvRX
	 DU6UWNOrc9/Q+oCRf7q+wWMkz9+z6TuODhY26D5jEHVgLDJG8JeUqhcWPTBDvJMwol5nX
	 m2P78R6sT6WZHiOFWUnmWiXZlpgIuVuU6awPmQt/aw6fdyV5Q4jpXq0A3LBsogQBqvUlg
	 xcXXhN9npgxk1cfS0VZFqI1u+BN+IWVoDWABAtSvf8zk0Tb3v2edi8+KEkXxlDTxtzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpOVFEhc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D8606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpOVFEhc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9991F01825;
	Thu, 29 Oct 2026 06:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253990;
	bh=An4RZIrGtZjzEWjq/3HhUbVpF0IT9CsHAkVBnz449DU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YpOVFEhc60AAtdqWIpLHXss1kI/XWUwBhaFmiwS664SjVRaRmfJx6yEX2obifYYaX
	 k+/0G9IRUeVUYKCTtFZaMxv0qpKeZ1WTxmq5jFUC8t/zKoj1UNnHJKKJBYVfHiWELm
	 aRrQc45vK8hHvUAmkCNiOkBmpC2y4uKcBEkllEz3hSr/v3UceugPwN721wSKbJmJ+1
	 RMZoUSf2ULyUvmjxQ82cM4dmwolnoBB4ZXIW/+yc6+h0lOKnHnY7oGYk5FbJ/Z2WtC
	 QfJN6agPDYhiV6mVFg4/1UR2cqxkcKbv8f/HzlM1HPV38DRF83LU1muMLaAeU8G8a4
	 C3ibUgCCaiTuw==
Message-ID: <sashiko-outbox-188793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/14] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-2-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:06:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
> failed message's length and notify the device about earlier messages
> queued by the same call, so they do not remain stranded.
>=20
> Propagate that failure through the indirect PCM transfer callback instead
> of discarding it. Commit the updated indirect state only after successful
> submission and stop further transfers when a send fails. Return an XRUN
> error to ALSA so the stream can recover.
>=20
> Keep the polling feature path unchanged.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D1

