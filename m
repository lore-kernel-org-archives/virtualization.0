Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058047;
	b=i/jD7gB2tkjCA6Tp+dyyuEgTiRL2lvyLxkcDWmhKKkoGkk/Ia6SqsS2S/WCGk9PshPRS
	 HPefBDdnah1XB5zvXo+QA7gxvAww4xa/N0efnyav72KQTcd/rh2rPIHecJEqSx3NYoaG0
	 9nA5ybSWqta03WpFeudZtYvhcoP8HfcjHodaD36Au2Iv+SoP8ny/Us2d6zHwLIOUx/vgy
	 OUWGyiGKZivy5L9l/bF7fjX+MHgilwMuuhp/b8hcm/oKPLWQ7In0ea6uT76tETXYs0NXU
	 rDhvomgPp+ZNoknoR1Y53dDB3gjm7oJgE0lQrHVwRAEXn52Ond35Bwfem9yT0JgGXYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058047;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0jPZiEPnTZS4uEf1luX5oYxCDBJFAKFwJxxaupfhpdM=;
	b=NtdaZTG/5/CtG/OeLo7oAlSu8jdiZAg1Sig9x5eL78u7ozjyk8MFG57Y0TM4DfONC1hI
	 5XXDMPSdqseXZyBWKbJ/mKtYjf5j2ezwhFzQW7ZDFJXLudvve2Kl3o8pkl9tLje9XCLLu
	 YDgsJyKs31pixDZ34KJkB7Tct+T9OLs5NSlr9xOQxy1/fUfUFhnZNT2vyCiKNdXAZG+RA
	 CjGn/wqiemOKw/8/9zvNNVNxXozmpLOzKvWfkwUnvZ78L+MEXcodUK0iZdq1hcMQFMFUh
	 fsdhK4vXFPuam/PQQp2Vilv4r/Z+V0uC2J6YqIQcoD2+I3niqCieUxsDn3RD9thehbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+7Vt9mc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61381606A333
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+7Vt9mc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA701F0089F;
	Sat,  7 Nov 2026 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794058047;
	bh=0jPZiEPnTZS4uEf1luX5oYxCDBJFAKFwJxxaupfhpdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F+7Vt9mc4hH0mXpsOgPIQzEDHq/XATIUqh4Tka6H48/ZYDs/1Ev09g2muV198HHiW
	 b0bRF3xW4xlLfH7KMBC3r6CELMyf3/lmFK0jnz7qj7GrVT2PBv15Dc8s57Z692QMcA
	 tNwVe2/cK7c9ZzRyCHGQ289twbQN/iShBJ7Aqvzw8MuIGYttZ8tzAGuzjSunVIgIWA
	 fn6c2mFsigCNJthu7T1UJVnF/jzpT8K9QuqRiMCV9iZHrfz9LZmYtck+DtWlkjLBl+
	 Ss3Q+fBVd4RdD4HFE2xv20ilqd6at+aPZ1uNfe0+SgZPTpRjpeSeHa6rtvVZl1PVQ1
	 aBXZjS1hZAowA==
Message-ID: <sashiko-outbox-202920@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] vhost: account the per-device kernel allocations to
 memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106131829.3228926-4-cui.tao@linux.dev>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:27:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Tao Cui <cuitao@kylinos.cn>
>=20
> Everything except the worker struct is allocated with plain GFP_KERNEL:
> the per-vq iovec and log arrays at VHOST_SET_OWNER, the memory table at
> VHOST_SET_MEM_TABLE whose size follows the user supplied region count,
> the pending message nodes, and the vhost_net/vhost_vsock device structs
> with their fallback to vmalloc.  The worker has been accounted since the
> vhost_task conversion.
>=20
> A container that can open /dev/vhost-net or /dev/vhost-vsock, which
> device plugins hand out with passthrough, holds roughly 150KB of
> resident kernel memory per device after SET_OWNER.  Charge the rest the
> same way the worker already is.
>=20
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106131829.3228=
926-1-cui.tao@linux.dev?part=3D3

