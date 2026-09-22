Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6A54280D;
	Tue, 22 Sep 2026 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084623; cv=none; b=HFb0X4v3E4LLRnqSzFgOg77ivrUUVbH4DoWCeX7YYt0f0hJKyb+5z7QBOub9nlASOhv0eovZ/beEjfWeD4DR8fH4pwHyta8esKabJiop4RzZ3N50C3naKq5zLAtsXcaN45CxFEcaE7Dy0R0u4hWcwWofCydvt5CvfYVJZ2eUXew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084623; c=relaxed/simple;
	bh=DO6aRf0dJvim68jbtyQ1gOZHoTkyc8X8+IJJj+SV6VI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PWDc732OIsd95UEqS2klhHzih+bKvEg2hmNIbTFaAh86iOWlxlADnKcQEKUf/CKvxzt3NM9tusTTbY2dZHYKwu+brQsSO50oJCLtGi/zvjWzD6Sfodjog6xgN6n8KnHVV/rc029v2YPGFkFS4SJX0QZ5Yr+dm/EhTTD2l2ptZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ3D771f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ3D771f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B3E1F00899;
	Tue, 22 Sep 2026 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084622;
	bh=DO6aRf0dJvim68jbtyQ1gOZHoTkyc8X8+IJJj+SV6VI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZ3D771fv+kcosjlZ5sIsflTs/jLVp5XOgntSC5CgTYwJYPxugSVrLU3ALVfaKl1D
	 pSIkLcQoOitjp3pXjDGjfALe3tJzVcNdcwlExf7U2/i19wNiZstr1ZSOJUWJ1GcBXD
	 neWhxUKt7G0rc7qS0oOkgAeTA8tCw9c4JBs1wM6AWCaxHwpMKXjh9ePlUaxvWVwyYo
	 ZE0F+0KB6hcZYBepyjL7GmzM/nXQwq1l0EcNdqKhy8QMluDnr5K/vMsLDMMfDaU3xj
	 bkqk90ro1yGBvM8eUFX4WgOlCwgLzgGxMMCqod8LkeUmyTvyKDpecu1TMLF8VJXZf0
	 b3gxFJVKom3wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/8] vsock: do not preserve transport assignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-3-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
 <20260922-vsock-connect-reset-closing-v3-3-78907b8200d4@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:43:41 +0000
Message-Id: <20260922134342.25B3E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Introduce vsock_unconnected_reset() and adapt vsock_connect().
>=20
> Change transport assignment life cycle. On connect(), socket gets a
> transport assigned. If connection fails (init went wrong, peer
> misbehaviour, time out, signal), transport is de-assigned and socket state
> is re-initialized. Once the connection is established, transport remains
> assigned until close().
>=20
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-vsock-conn=
ect-reset-closing-v3-0-78907b8200d4@rbox.co?part=3D3

