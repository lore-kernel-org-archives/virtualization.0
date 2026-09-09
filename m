Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D449356E048
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962788; cv=none; b=IU4inZVWAN235DbjM5qvKDhH+LxBvb8TjFgj4PN/C5VpbuRCtETbLAzrltM8lUQrKf6P7jkJ57xLKlPhZqNcE36LVheNKQj8qz4+uADmyN1XuFmcMOvX5dup+oVS3Z90aYBw5ZzOZj8N83VuN9/2vTkvZ9ISo5br4NcbTfZXH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962788; c=relaxed/simple;
	bh=fzKJO4CRBYZQqKKOdFuPIeM9dqyTmI3yNWE+7jT+6mM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cTUnfnew2VXY65zhkyXAdQhBzzKpG7OM1kxmxd35IQUVhnJ6mdyy2Tn9MBM4F/8jyPu7YiV6/y2m+bsPKICXtHV5JpedeFH3DrDRlPuaOKZ+6n8f9Gfg2VQiEXaTQ3ESANanTCXjVvfFYfhJQ6XVUOFVvEst4ujZjiCkOAqbOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4NY9oLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4NY9oLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB8E1F00A3D;
	Wed,  9 Sep 2026 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962786;
	bh=fzKJO4CRBYZQqKKOdFuPIeM9dqyTmI3yNWE+7jT+6mM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q4NY9oLcfDrCQHvjHBcAadXavuhbFfWmzlmtLINueUX1lsPN8XVIOIw4iAe8CqbIA
	 F4mJl2Bvw3Z/GdbnvYbAVr28eVmK47741h6TOyErXt8StBLhD8Tq3I0fQ4wxJd25RW
	 BWv+JZuM4aQNLJs2Tr6JmW6JP6yVJ4XdyPWxbETTzxt623/uKqfbcav5BFMTiR9215
	 AsU3/4wKf/TdeDLT3lf0j1LJsUBg82+5GT1h8X1LswFFcAugM1gvLO4rYZ9MDFoG0P
	 TTKXlfltDinxMEBn4xPqVvueVvqh90kz9D4tuyA/CYytkO1bvGCBlXomh3OfSc/4Lb
	 w4P+4pn1cHI3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/13] cpumask: Introduce cpu_preferred_mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260909135617.871006-5-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-5-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:06:26 +0000
Message-Id: <20260909140626.6AB8E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Provide the preferred CPU infrastructure. Define get/set macros
> which could be used to get/set CPU state as preferred.
>=20
> CONFIG_PREFERRED_CPU will be selected by the driver which handles
> steal time values. It is going to set/clear preferred CPU state.
> This driver will be called steal_governor and it is introduced in
> subsequent patches. It periodically computes the steal ratio and
> decides on preferred CPU state.
>=20
> A CPU is set to preferred when it becomes active. Later it may be
> marked as non-preferred depending on steal ratio by the steal_governor.
>=20
> Always maintain design construct of preferred is subset of active.
> i.e. preferred =E2=8A=86 active =E2=8A=86 online =E2=8A=86 present =E2=8A=
=86 possible
>=20
> With CONFIG_PREFERRED_CPU=3Dn, ensure set_cpu_preferred is a nop and get
> method returns the active state in that case.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D4

