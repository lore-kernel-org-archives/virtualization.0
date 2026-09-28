Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0DF3B42D3
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574508; cv=none; b=RZoMBxPgyP0YsnMjxI3XhO+hlA2QGJgC7BeL1rXlr7rpymjfRBPowdUcPGSNa51CgbUOkyR5KRFiVgYXsSnXRmpfool5nUFkC7afogEo56689YLRziFnj2/iJsKcYxbN5X2FDTBpgVZ77AK00A3pfkrDOwlc8miUCUir0dgnz+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574508; c=relaxed/simple;
	bh=fVh24zTHhRLfm0v1ViKln80bT1pvHdtt8dElzUk8uC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bJqGO+8cdIQb5byyQSADKq6tjjyf3EgyKhjzHG07SuLBEfKOX1sgQ2wowboPV6+sfLHJkXw8L5PqkqAsk2pSe8DBPFPX5AR31QXh1SQU1AF37LM0v0uVmW7KZOmllFBP3Qst5dThBoCRyJM5dapj+TGXHcgJAsm3kNomstikbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNG1BwJu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNG1BwJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300791F000FF;
	Mon, 28 Sep 2026 05:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574504;
	bh=uwMQiCobZXEMbdTsWy8Fwe2/K4r4sBJxfsPryrcQchk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SNG1BwJuF1jSQsT6Sue+pQaXc5QR7OXrQzW2aMQcvhDoX2weLaW+FWSh0Lks4UCwk
	 U5FRZPTjMl1e9hROPZJHvoPhtx3Z3TpNCCfBGMvtFK4YSb7DQEQrGuap9F1TCL6dkB
	 Hk46mWPY17hoIQeQ7nGLQW2WX3mElq2Kxau60bqydvYzousj8OTGKAm1G+atbUdtEX
	 7ZYaH2QUDogznPODa82hdW6R1IBLupbONMabXCZ4qZ4KYhEn6omTG96f3FXb6Fbrr4
	 yaEb98XUvgWrOhMD3DflGRyzPPP9OJWUDrcLm5x2iFjUA3efHGzUnWii/lYB0yPVqN
	 jHO7px8eilekw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 13/13] virt/steal_governor: Enable the driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260928053728.797539-14-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-14-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:48:23 +0000
Message-Id: <20260928054824.300791F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Provide a config option to enable the steal_governor driver.
> Since the feature targets paravirtualized environments and requires SMP,
> enforce those dependencies. The driver selects CONFIG_PREFERRED_CPU
> for the core scheduler mechanisms to work.
>=20
> It is recommended to build the driver as a module (m) instead of
> built-in (y) due to the following reasons:
>=20
> - Module parameters are read-only after initialization. Building as a
>   module allows updating these parameters by simply reloading the module.
>   Default module parameters cannot work in all configurations.
>=20
> - The driver can be completely disabled by unloading the module.
>=20
> - This feature works best when all VMs operate in a cooperative manner.
>   Requiring an explicit module load ensures intentional deployment
>   across all VMs by the system administrator.
>=20
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D13

