Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C481C695;
	Sat,  3 Oct 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013616; cv=none; b=hyI4BOUIl21bysYiHzvNMneV18h74XgLVBamnsJ6EOX0VyoN+qgXZYOCbR/jlKitd+J4y0LYIGwxS0bPnPrZaG9tZwL2TH6nPDGlLPhuOMmmp71Ah/aIXCh0ekcVPSWahs8vql6bMh9G1axkKBTikRl3myncrIjV47kil8jmJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013616; c=relaxed/simple;
	bh=MbH4LryovLucnGvF7y6S0+Ma8jyoCnPUm3Oed1aNf5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nfGY19NzDcUzsHOD1m1Y2irbfVIh+XXXOjhrNG08HgQMGAS1SBbODFAMGFZAw27ejpyswUIm89JGETYXoK9OCuLFfL+19J1MgGPSmlF82Y0If/xcarIjqNcwuE+npoTkf6+S3AJRD8uA4Ff4Za5ykNwFvMVcZHEcJMN9wNO2Wx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPiTXLng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPiTXLng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579841F0089B;
	Sat,  3 Oct 2026 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791013614;
	bh=MbH4LryovLucnGvF7y6S0+Ma8jyoCnPUm3Oed1aNf5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dPiTXLngwxcdvLwkmoYnEilVpugd+4a/K08h9B9DydH8paa/lT2ucfJMh0Iwb01eS
	 VzGGJkfLJsoKEWGNMZGghGS8YqGpJXWB1oEWbDHajldkuUPkO0Rw/mG8Z/+6fpJeUW
	 euuz1jxiTzKydke5BPVwvLmmsTozhENBIKrv/u3ZP212HqsENtYmuYyAnOBfMJEOfe
	 wEmL/aeA6PGS8k66o0OUktSO759s/1SwtK7PZZXfJwbjPO7jpq5IE8IqcchA3KDUWq
	 p/AYlgomCquNMAz8rEVx3l1hPd4eR2fdm1hAVQBS6zTPxkvsj183UOMWOBe1zmiEK6
	 08LfW5+dRNoig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] vsock: split socket lookup from locked RX
 processing
Reply-To: sashiko-reviews@lists.linux.dev
To: physicalmtea@gmail.com
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261002074551.318789-2-physicalmtea@gmail.com>
References: <20261002074551.318789-2-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 07:46:53 +0000
Message-Id: <20261003074654.579841F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Jia Jia <physicalmtea@gmail.com>
>=20
> Split virtio_transport_recv_pkt() so socket lookup is separate from the
> receive state machine that runs under the socket lock.
>=20
> Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> Pass the source and destination addresses used for lookup to the locked
> receive path so they are decoded only once.
>=20
> Pass the network namespace and decoded address tuple to the locked receive
> path through a packet context so later extensions remain cleanly
> encapsulated.
>=20
> Preserve source validation and failure handling. Keep the lookup reference
> separate from the skb owner reference so a later patch can retain it while
> processing a bounded run of packets under one socket lock.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002074551.3187=
89-1-physicalmtea@gmail.com?part=3D1

