Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841683;
	b=QadF8YQhHQjO2ZpbDukfyMJl4urwupKvLqV2tAkwwn6KTrouF8eIxb3ZMV1AAocF3lPQ
	 VSaA3pxdTUgtCdScbSEo1trwj5HTkHewYTIrSPE0YBedXwUTNWHXEu3QvA+a8o8IA/jBQ
	 z7/A2qMPNfwT0WhW8FVTsVXfhONMzgVk/YCetxLOF7lXNgFL8lNVANsdlVuykeY9MdO1T
	 MiHcQEyyVaRI9hqwRgyQNlHFEOLS/83Rqdjz+NoWKNIcjRP7eyr5tYqiSR1aCiYD5pLED
	 BQD9LUHQreJq1Rzh/dazKpOWyuxn5NXLf4a5ftHmPFe1PK2fL9xHq+L1Kfmm2sW6vUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841683;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qqiEVJGDrgTJzFNozvFafcgWas4Gq5sDOxFGw+XIZrU=;
	b=oyCYEhToVLrhUoYgNGCynhe47z3SOgxrr2SGhGbExXCNwVDVYdRwT70J1DjF8SOHuJQU
	 KjNWOOa14Eqv/X3EirxDNnjam02go3kbFKb8s3xbso/ilNDzu05iEk94dD9JVaMEE8ASX
	 48eGGuPWY1cggSciIKpoVtvE2/EwvFJL5ig0viNqWzKsiOPNN9z0Ez0f9KeuL+SDSV6hU
	 C10c3qqT8Q+b5OosA3isWf3Ye4gb2EZ/YcPAa+kyNVVFJGhLmLPOaWdzwNLeDJlVnP56v
	 v1gALGEMkBYqaQVAwDqDsggvKhXrDqV9XUPtvKYF6Mzm2TmdFTnDHYfV72mMseGmf0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8cY7Qym;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77FF606A33E
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8cY7Qym
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FE61F000C4;
	Mon, 16 Nov 2026 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841683;
	bh=qqiEVJGDrgTJzFNozvFafcgWas4Gq5sDOxFGw+XIZrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W8cY7QymSnl/Zju8aJyQWDJ+3be56REgK2b48oMEutk3epKVcHFCQxSlkG2TCN9QT
	 oIYbwtdlOsju3WKz+NJCVHKstVPesReshdn7MUEvq5GU9QrxpURUyAPHmvaW9+bQAi
	 tOBZcNbHeZTwLbF2o6X6JM0b5RYXjmwhwYQKSk/41sB1F33/WHOUjFfp3GRgi5ebOe
	 S7tRAixH6IESLkrify09H8MY1pcgd2kTa66Gt3TGoLXa4zcbk5hK+SebCR+0r2VnYt
	 7RMl33m6Ck9I7KE27HXwvmhlN81CS+rUDHiFkRodfYP7FSbTUu7HmNCPXMbAk+fpON
	 b5GGnaT+IWSYA==
Message-ID: <sashiko-outbox-217228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/12] x86/msr: Remove wrmsr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261116150208.1572254-10-jgross@suse.com>
References: <20261116150208.1572254-1-jgross@suse.com>
 <20261116150208.1572254-10-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:08:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> wrmsr() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116150208.1572=
254-1-jgross@suse.com?part=3D9

