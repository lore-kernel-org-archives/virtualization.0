Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008222;
	b=b0GUpfhQTfSqcaLLO3NAcII5t+npX+xR2UvOT2yMGCquE2VEFga4bS2cE0PDy7/VUB3f
	 aHk6o3PnKjCyuWvHQZOU1aovpo1nO4i1c9FtcNsuiqJZCUWpDhL0TJc7+5mh6ZwdKTqoW
	 nGb2XhQKzRvn9QfPcWSNY9osi/rUhfxcEazEjtUSaQereyXGUvsYeoOto1DyZ/T4WiWBH
	 10Ejb1+njAkyb1385E1aNV0EmCC7I873POJIsDTQhopgUEgfMNd7styzE2YQP3MDbC/xq
	 3NHpon4/qQvmqMhexoyZ1iYiElXxO9O+0IZr8MfCMEz2EY6PNaAZIffGz/qaU76AFHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008222;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RdnjZ6Ch5HaFPVXw3+RUJO5V8KiWWuSETDKzFdl9Wgo=;
	b=nPo7jVjTe9/UdOMzYHI88AYyQIE7F68lcTHvu9fWZPC/ZD+pLA56C1i3ulj/DZ3i95xT
	 614mDzAPeoh+wtegoolGpR9Uedtb7NwSgw/DCuvNat2nDFQtDPu0nwR42Z33NiwSakKlz
	 kwE5HdtLbow5q+n2Ll7RAEtXRPAPZsSz0YBwEYbRMaCwaXd1kJ6JW7bLscAEDMM0Ak5iO
	 Dwi+JXhQnPl1eLJEsmYJFjuiP7XRHlvRV0vDB1SXRRGrICowEIb9y+Srl8wbNrJT3LFoN
	 ZI7UjadJGMBIkj0i/IbIm+siPdCNCZNTldnVq7LbpZRAmyxBMXTmnw1KjvW4a9pRZWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Swa3cMgY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6727606A31D
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Swa3cMgY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7E21F01825;
	Mon, 26 Oct 2026 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008221;
	bh=RdnjZ6Ch5HaFPVXw3+RUJO5V8KiWWuSETDKzFdl9Wgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Swa3cMgYVLDZaBs1Nx25w9tzZd3vlkjyZcHcYL90P8Ww2Xe7q7pRcsnF8Lb7IiKet
	 eD4cN+6GxyZmbB3x8/ZHl0KLXxi4O4lvPX/MaxmSJP9Fe8aIS947vFDausRyVxbQyh
	 WQ/ar7YqiJEi5Kupo0/64aRgOyKKEIJ+5CxpYxXO4v5DzNabvDNF2Baxy5xqT42nOs
	 D/ZQK7EsPpsshpim14s0LiIhatqeYgtGqtMKX1BKMOzYrY0y6YJLBIC9fGOkjC7qLF
	 i+p+YEK6NV8TSip1EsHPG1BYSIK24M3Gmgm0f+ifijdHW64eLpXKrG64EGNThdsemd
	 Mmsgf8uyx0dyA==
Message-ID: <sashiko-outbox-184841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/23] drm/msm/dcp: Add HFI device definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-3-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-3-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:50:21 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Define the HFI device commands and properties needed to discover DCP
> capabilities and register display resources. The KMS backend cannot
> size or allocate the firmware-owned pipeline without these protocol
> definitions.
>=20
> Describe device commands, resource data, and capability property
> identifiers used by the DCP device and KMS layers.
>=20
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D3

