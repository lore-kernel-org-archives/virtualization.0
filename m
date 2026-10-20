Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497844;
	b=2MMB7PMrapTihQ13rIY+R2cXjJOYLBPlpi+qutqxrmjGp6G2N/eX4bZNJ3ZmEymsBp0e
	 azeGkealXbPvIYLoo2+wjN0hJoD2TKUxZyqGQPDlftKirsTIAI/aonnlXi+HH7bxs6b0s
	 OEMtAyXLM9Fpo/UUZfQcNG5+BQeIPEwNeStsIWWlrPi8xD2wiGdoZFPLdar12emp5nVS6
	 xIT4U51GeftVrrDbuDwn1NInlvOU+0GRomdDbD39xQSPGci6jkmM6qWJCKoGclmXm3Tcr
	 H4tisC71/jIsnL8ziH7HD0Tq3eJRyE8qA76si59QQsxAmd036Hu+JhY74dKpkkTcLfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497844;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Uh4g5cjFJCktswE4RsrTvDF6O2DyuqyeCT2eHY4Z8xA=;
	b=sG/RrXnChyJEZJL4nW2p2CedLMF+dnv8ar2O7yC+ZsXPs3MkNshqSTp62luDqFjaZu3f
	 WqPaoLjN3kJZtmFv8xSg1p6JQKVYG3QL8yqF3vTiTwVfsh+d6m61gbhwCmgZp5l7dbBgF
	 VDTQ4hn9nBU1HgGio48eTADrBkwDHDSERGM18SJ2SjXfkzxg++MC3TgNIoinmc4FBIoml
	 hnPlwu3Gc76KEbQLA54eSaLlbaDCIMIKSgwFGK4y0/eLhTb+p7otXWJQroyyYlD76LeZq
	 LPxDv3L8CCuIvkkmUhEVBmM5uWpzeOKq1apAx/7goCu7TPFao/yRIRa3sYrieTgdkIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPerv5lz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E255606A31A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPerv5lz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96FD1F000C4;
	Tue, 20 Oct 2026 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497844;
	bh=Uh4g5cjFJCktswE4RsrTvDF6O2DyuqyeCT2eHY4Z8xA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HPerv5lz5KFBWp0XHFeXBMt3blFT5+5mK4MhQao5yu5Zb1On+TFHlRw7Shwi2cGhi
	 ALKiMJArM2kBgfl2iNasqiES/kiCGj7nU5gKefuq0QmXW2Lo3ePgaOZe1UpcHrM3gx
	 yJ9sSxBebRXcyPowoBU7j5PcWaR3RUgztQ6Ew+3ufmAR/jMNgteMWVxhJiRmkOA+cS
	 qBUUiR6dp/P7Fy/Nis9z+t1Twt515g+dDK9sqaHx+JB72ZVaPC8S2yF4+gmDTagPOE
	 DiQseYAVKzftEWzyeO49a3ryyXD/h53/o3roXcJAg85K9Jy1m0a8QPwaHkLoP3qhhw
	 KZ2LnEVn0Xb8A==
Message-ID: <sashiko-outbox-178923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 7/8] net: add ip4_parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <8a90cdf35017ad3e2baf04c209718dd4e8d93b0b.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <8a90cdf35017ad3e2baf04c209718dd4e8d93b0b.1792411304.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 12:04:03 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Multiple places in the net stack open-code the same minimal IPv4 header
> validation: pull the fixed header, check version 4 and IHL >=3D 5 (where 5
> is the fixed header size in 32-bit units) - and locate the transport
> header at IHL * 4 past the network header.
>=20
> Add a helper for doing that: it returns the validated header and
> the transport header offset, or NULL if truncated or malformed.
>=20
> As noted by Phil Sutter, there are more places that could use this
> helper, e.g. ip_mc_check_iphdr(). They will be converted in a follow-up
> patch.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411304.gi=
t.mst@redhat.com?part=3D7

