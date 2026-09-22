Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C46A41A921;
	Tue, 22 Sep 2026 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084622; cv=none; b=oavqDUz2/xFqcd2YKxbSZ8rfu3Uf5qNaH6wWHv9atj+jPteeqQ8vFYovNv5jw0p5PGpTDe9AArVJgvc/39817gX/Bf50027+xYhDGNk2rnKd9sBUWzrMQFx7cnHmTXByzT6ajJkhBx8Mfe6lt/900mBy25bY8V1y8BeOcsiG4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084622; c=relaxed/simple;
	bh=F+4KLkGPHsdS2lHowY59BQfz0zpjOlk7+BCXlBnEzM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/FFG31VASk0Xzm6Zt4XU15VIsq6ZwT1kDjm9qb+9p9ol13Uo3f1aaD99dkFJlXvYD1nXn+SVALNV2l6isigq2OD4G4ZPnw4RZGXuLHdXa9NJ5rz86F0mAHxtT126Amw4MnKaI7ACWPJFzM26qndItW5VfI7akNg8vGpqVIH6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5UZCTZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5UZCTZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B15C1F00893;
	Tue, 22 Sep 2026 13:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084620;
	bh=F+4KLkGPHsdS2lHowY59BQfz0zpjOlk7+BCXlBnEzM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5UZCTZZpwwd3dtYj7dlbPCPe8xvkn+fPlB3FOOKn3Br+bJ3xsTNXu99HidMyvA5d
	 r7Uk1LB9li+1eO1uU6BRQPTy3Hem+9y05vFY6M/QiMAD4O68LAvdulgcQn1jpp9gKe
	 kw7eHR/X2slEkAQZN+N1Zb54s44ZTRlwPGpesPOQaDj0rsYiL0dMbo75fO3C7XcgtA
	 I+Pd5s51G67gHcGRmgpE+gRtL96zAyUvoDZjQvhYbt+cgr4r2HYtjQsIRSqI54UdWx
	 V47v9jkiLZUZ0SADVG4zXcSV5+J2iOfKMQ0iHay1IMJDsqh8w/S1/zZr1BIA/EULbZ
	 hnmyy8DU5YZ3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/8] vhost/vsock: Fix socket state constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-1-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
 <20260922-vsock-connect-reset-closing-v3-1-78907b8200d4@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:43:40 +0000
Message-Id: <20260922134340.8B15C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Refactor under Fixes missed one: SS_UNCONNECTED (1) -> TCP_CLOSE (7).
> Until now, sk->sk_state =3D 1 stood for TCP_ESTABLISHED.
>=20
> Fixes: 3b4477d2dcf2 ("VSOCK: use TCP state constants for sk_state")
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-vsock-conn=
ect-reset-closing-v3-0-78907b8200d4@rbox.co?part=3D1

