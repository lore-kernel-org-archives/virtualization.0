Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376754;
	b=Nrh9VPXVMOLM+ljrNeRfwlf9XLup1eIQHamZ3iKABDSB8RofLuiclkutgA1llsqs53NK
	 WMuZw9d+5G/sNR4h7oFdkCkMzYNzoIUhxeypt00/ezAjNDF5mCZM1LrqUdT5MZYYzx7CZ
	 PFdNDTBSndt3J2kB0i6dFBqBlJ97MK6YzibPNSqSKFfIe7Q4nnluwmqnlT3oY5VftNv6G
	 S1hhbBV3knjmbJORUBUXYnG05S5D3FvdwEv3mXHTVg5UDVWqfT8Y0YQ3NNkKdsW4Xg4wB
	 NtpKwQBEprIg/oD2KuE87Srf3HX1Dm7785nNKxw+usLwU+o4uYe8QRhovOghGoKaeRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376754;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t1enuN0N67V1YsurNTtIubG5dzmgTRuFhVcHHblsE7c=;
	b=GXsFVQUUVpuzr6NSn6pATygecCp8NBvAAQ6UxKdUmMJINF3NGO0nQ3wwBBrOqcMwrifX
	 Enkcea6USnF5Bk3MKo3ypbYs6MtZM0TqVRpZjtTF3tP9Yx5j4No7KH5jfsu87nq3LgOVq
	 PxVtYPMMi8RFj5z6ti7dHlpaLTz60pj6Tdunq9CaIBO5RfXT2RyTf+mATlzsz1dmVWJVH
	 m7SvhJXSb2kOuzl9esqv8Tbqevjztm3+z0u+TZgN4ma0AsoG+PR9Je/D41XyqqOAr95AO
	 bRV5QaDVJ3pf/g1uE/2iBlR+mxwX5Ct8I4WN6/2jUjfzwp5lNknsoiTfpqcTsvS89+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afSk6CrV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C2606A332
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afSk6CrV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CDE1F00A0A;
	Wed, 11 Nov 2026 05:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794376754;
	bh=t1enuN0N67V1YsurNTtIubG5dzmgTRuFhVcHHblsE7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=afSk6CrVzMsCromjkQzUK/p4lgQaDwBlfUxoeeojykP9j5yf7IocUBemRF5djm1lE
	 8Ua2J4VooLS8R4eNsE+MknYfqxlqXyOEQvhojOLjwi6MvNQ5C1eM5uoUZE6rv1bK0T
	 9Axe+9x4cj3lde2Aq1G8cAHTnD8xWs0EMNCLlDIQGPbf8Abwy2TUH7H2USGTgQU3gl
	 GuD03Jd5Ps3jWFMJCrDvXc0fN8kv8k9EfJW9ZuufFtAMORtTvoDB4QdGgJ4//gDOzI
	 OOXKRvF6L11vF0swnDb5KAYYfvdLy2DBEFoZnlNzWrHSUjakiIlP2CEA7U1EBcJNqG
	 YdyhGKzQAZRNQ==
Message-ID: <sashiko-outbox-208374@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 11/16] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-12-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 05:59:13 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request
> is still pending. A later teardown may then submit another RELEASE
> before the first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels
> the pending request and wakes the waiter.
>=20
> Keep timeout and wait results in the types returned by the kernel wait
> APIs.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D11

