Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F1346FB3;
	Sat,  3 Oct 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013617; cv=none; b=na1o2uLEauauDV3Gpbw+/NJO5/o8LIBn3DJDy+2JNPmLx60rqWNEOsGQNAdlTP/bE1/4W7bdWDDDHvvnDFvbvJ95uPY3Qqc4IzDbmUzNdmMufRodpHgxcdyrvMFOPyyjHFIJA3/NveX3NgKH6Hg6nQPjAhhTu4OvQynxv1iSGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013617; c=relaxed/simple;
	bh=dNGqc1KGpDSPs1takGPaljh20JB7wImZ7Il0t2Kuxj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XorEpNqdjBSpYLxaTbzoxD/nWabGhda6+HASutZ6Kw6Ihe++Tq6cV/JzdPfdaDMR7I3VtSDhfWmQ8i5MSQE7OXO7h3qQJaBV4eZJabVPQqntT6uAdXH/FQnb/r8TKjQd1+i9MTRVD5Wzqq9CxnVoGa9is5gpf2yCkKCpfrCi6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKGu26tr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKGu26tr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22D21F0089D;
	Sat,  3 Oct 2026 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791013616;
	bh=dNGqc1KGpDSPs1takGPaljh20JB7wImZ7Il0t2Kuxj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LKGu26trEH21uxHevZENuL8BwnQ8Bplj6693rAKlAsWiP254AEoRHIpWbqFPNaolk
	 E7C52V2Y8VNFHSAXlHkjAWzWJqO8ZfGciSXgL+Mt7dW+nbUOtBEB1w76IDFHJYDW+u
	 yM0YZ9Iam8NDlhyWICt96OuEyRBWf6idPL4aIRTVoI+a4ommeyCFUyWJRgpuDtqXo1
	 rrezRdSZpbY2npWQQ5VEvndKxtZFafAlCqBuSMYH6Awsjrg/ZrmI70zWEmN4ddzlqQ
	 RMCNlv3d/RENP5IZy3KVMLuTLn8qjmIPYhOP6LTt5WwEa8wjbywV85utZt9EggH8YE
	 dTyIDxNROz4hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] vsock: reuse same-flow socket lookup in RX batches
Reply-To: sashiko-reviews@lists.linux.dev
To: physicalmtea@gmail.com
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261002074551.318789-4-physicalmtea@gmail.com>
References: <20261002074551.318789-4-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 07:46:55 +0000
Message-Id: <20261003074655.E22D21F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Jia Jia <physicalmtea@gmail.com>
>=20
> An RX lock batch still looks up the socket for every packet and takes a
> temporary lookup reference, even though the batch already holds a
> reference to the locked socket.
>=20
> Record the network namespace and packet address tuple when a batch
> starts. Reuse the batch socket for later STREAM/RW packets with the same
> tuple, and release the batch before looking up a different flow.
>=20
> The cached path still traces every packet, takes an skb owner reference,
> validates socket state, source and transport, updates credit, and runs
> the receive state machine. Only the socket table lookup and its temporary
> reference are skipped.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002074551.3187=
89-1-physicalmtea@gmail.com?part=3D3

