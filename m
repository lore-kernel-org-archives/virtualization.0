Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010078;
	b=Xmio6KSKiIOUc8SX43JZzH1dXmXcW6zR12lXPe01FSiCS9JSPRPaWHHts1OTk/hfZisQ
	 cdWVuZRUR1kCwmwX0SPGH0CUWylScpXYFKt0JlqeGomCPr5BBzKoSGp/zIpiSGTJ6mMPA
	 pRHrKG7kLYGxR7djrw2qHbnbU7iDhlZMNE5n8cg3pw++L9Kwwh19Mz90FY9dNxc8OuTbv
	 /6ucvDGCfRr2X7OWDSFdAbDmNRHr3Q4BtGagZrVELs2340ZYmrhz8hDf6E0qBRd09r7TG
	 pfVgIOkOm5NqVDSnY8nnLXukBl04jgyHjqAzTytkneUQwGP3dfj0wwK1MqRE6nOdyTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010078;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZjRo9Y+R6Lubf9gIS81PG3WzunqYIQvXP7R9PpMgBOQ=;
	b=ZRULUTaMo91ua7d9Bo4cks5YSpUDP+MvdPw62Pla9TQ0B9j2Up0TGCgR2iFvnNdGmdbi
	 Yw+jAbtUVD5/GNqO1hXtBU7rXlg8C4ay6zIaIuZ12ndMAGscCmzSg4D6iODxqVgsl9jLN
	 BC2QPE9gxzpWppkNxmbOlCNYTECICn1mjvRGsHJHvljzUehpINAWAbJ7QyKxBFddCcr/y
	 C4u7p5m14daXepqa/BNDlR4SvlzY6gTJ1jsv/KjYdk6d52K/U2QE2iNjHTT246yenphyE
	 W88pSiyjTixSbZ2ckSEGhlhJlJ3BzM4vrUP/GwOEBnlhzhRQchCvMc6GdEcCYnQ0h1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONS8S7nf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DD606A31C;
	Wed, 18 Nov 2026 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONS8S7nf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7429D1F000C5;
	Wed, 18 Nov 2026 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795010077;
	bh=ZjRo9Y+R6Lubf9gIS81PG3WzunqYIQvXP7R9PpMgBOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ONS8S7nfaCp2wKVv6Js550VqrcaTIPCNJ9y7viHF5qOZEojElPA+UlXJ5hj3N4smF
	 9tycAGNQOSft1b0vncLkNvtBpZsFeekucaqLcbseHKb8SP5cXLutT2k6Y3BTIr+q1V
	 f3NbGOGUms4NEi5dGYUCKocPZX7uYcJLPprFLcFHqefWPaTrBFkZGlCKm6/32V2J7v
	 fZFljvLXcMNbRn9VM0vy4lD80NSh9nDnGf+h1E79wnkGY8J1xVXAIaCw09o/SXJOBy
	 M/2CL1d5j1aq1yj4yhKVjPzoB6C7pFbnmpC96aTqt8fO861rwwXl61gTKC2QKhHREB
	 UjDjld50+kaKw==
Message-ID: <sashiko-outbox-221097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] dma-buf: Port users of dma_fence_init64()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Philipp Stanner" <phasta@kernel.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261118134522.1646892-4-phasta@kernel.org>
References: <20261118134522.1646892-2-phasta@kernel.org>
 <20261118134522.1646892-4-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 13:54:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> dma_fence_init() now natively allows for selecting 64-bit seqno support.
> Port all users of dma_fence_init64() to this unified method.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118134522.1646=
892-2-phasta@kernel.org?part=3D2

