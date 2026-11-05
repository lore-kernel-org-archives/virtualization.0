Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843679;
	b=Lw62pu3ZcKLhUGE/M0yWBXa6/F50PqXxree4cXXYieMSXtmP+l8PCQMIbHrqCAysGvlJ
	 BsmJw/34/HerAuK3CGjcH9XmdW3k3s8muj8N3KHwEgtpv1cQ63KDsj2dlb05hW6wMBAC+
	 Tm9gm0iMzRigi6DbxBXH+JGgbAiNrRmZHJx04HPeJQ3tDDYmRwM92h7JFQnTNt988Jjkg
	 uYJLWWQnCOn4F6fZkRDJIH0rRbTL0qg88haFtEDvfwmczFNiP+0y5TdOppTrLZ8Jspv7F
	 WleYV4rQTBdWDTd6Q56ZTjdjcEWpsMDVjSqIXDAA5Ps1qYayeEIYPGEXKR24685cFPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843679;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IC/g0DTiv8Cpz1YH9DywbDK+wDUuD9W7yw6QBcpHgqw=;
	b=yFvsP4xdrzokFH7d4xEdKhOMBtgDDbPjrec8R7rQ4jR3N6ifHsYGya1TjRt9AVZfeI14
	 7sFVx25LJFvlGD/pzOLOV5zG/1Clk4zvTzR6EuDzHJ5GlOJ7aXeogmwwVR1jzC/wrf3wB
	 uoM0Vo+stglAmGcDF6Q67CfiuaXGtQaIQseTCYTtiVG+EYemNlHGrNVw2ZBRoRpjpyFQq
	 cZFzCX/GZP7jF6nT7BAJMWRkU6U47lJv73/UDJtSQf8w3FL46FDcW4Z2qvdjJhxsfkknI
	 DiQ0h5JBDXOm8FD40yP9gWqZdcqseuCRj73dX6H6vDEghR/mXpoVkYBg9FcyDEw9VmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKKecQY+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE51606A331
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKKecQY+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5971F000C1;
	Thu,  5 Nov 2026 01:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843679;
	bh=IC/g0DTiv8Cpz1YH9DywbDK+wDUuD9W7yw6QBcpHgqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKKecQY+kWYjHvsQlgtxM4MzsZppIfJ1z4RZoyKy2HPz1abpzEtJGC2UE8r+CKP+X
	 YG9fqqLmCKWpY0uvJlTrFoyaHhsy5r4uIPSux3xsgp7B+SUKwP4d27K2xUuzEJc8Tc
	 Y6Xij9URcGvO85PABs6gNtXlt5GUfLB490wFM9FPkjGQ5UHGGAgM7weD34RfFp7Erp
	 HcmlJBduHR1jbTZS3sP+GHmfGgIdU84EClel8P4LMD8tMUpMI3eaiDfDnR6wdsnWGR
	 bOeYHwtxYhK0iHiYyman7vlALxzYQa1dah1+5b4weVTRdISxQlUpycJGdglhjlPTmn
	 1sfeRoeb+fjjA==
Message-ID: <sashiko-outbox-198419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 3/7] vsock: pass the netns to
 ->has_remote_cid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-3-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
 <20261103-vsock-guest-ns-v5-3-48179b9b66b8@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 01:54:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The transports only use the socket to find its network namespace. Pass
> the namespace instead, so that a later patch can ask whether a CID is
> taken in a namespace without necessarily having a socket on hand. This
> will help with avoiding CID collisions when devices move between
> namespaces.
>=20
> No functional change.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-vsock-gues=
t-ns-v5-0-48179b9b66b8@meta.com?part=3D3

