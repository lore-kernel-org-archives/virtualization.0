Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2212255E43
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113341; cv=none; b=uLtW6Tdn2L3nKzexsvOMULMoGKqmhO7OgJ4BD64zGAPpmO3cl9N3g2lrW/wpPV6pMXe3aXlWpZ3a2hh9QMsY1hxt72O89kmJO9yX5r7souynD+6yCwCxiARXGY4wgioHzkeeYxP2IUFOB4EZH5dsasQeUYqkkyB41yjhfBdrC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113341; c=relaxed/simple;
	bh=OkbneVaQRHpJwjmGhKkShdnY5MVEDm3fLZCRarC0CVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shd5MvC1ZKXXsXC3fpafrrqDreFzTMVhG5sgXH6+QON67+rrlsofg8CN83hIDh02SpGCty6XlMw68Vm8/W2M65U+WFm61vxNd5srRSsaIuB1NxVT3FPHARPlKMBZoOlkTlphyhqS1u4DFbSY1lrcnqdhfbRO1M8HAyRrrYBQFj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAlrbRmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAlrbRmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248661F000FF;
	Fri, 11 Sep 2026 07:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789113340;
	bh=OkbneVaQRHpJwjmGhKkShdnY5MVEDm3fLZCRarC0CVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MAlrbRmg0/vhfASuQibAez8kHEG1ZFVvn2HReF2aOCSFmI9J0KGVufgdWS3I+s1A3
	 c98YzKc109rKKJS6TgyuxA16zEMwQcKLZMRZZ5ocpcVexQESRXMktjC6AhNRfHLEZ9
	 pbbsdqb5HEEmkMCAZbDMVtF3OBGjupFpDIi+W5kpDu/LwQnOFRO+yVN0RZLO1VOtiL
	 UQhCjSq4/DOjog80CnPr2kP2An3tI3PLcShvq8ojLJy+EwTF3j6K6/dnSHocSlxIUi
	 j1KLyryrG044N0RY9aE8epYpr7NjcSJ12qP6K15YDuAuWz9jJOLNIoITR+afwkcHQu
	 DzBk9g+Krobdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/13] x86/msr: Remove wrmsr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260911074530.3140830-11-jgross@suse.com>
References: <20260911074530.3140830-1-jgross@suse.com>
 <20260911074530.3140830-11-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 07:55:39 +0000
Message-Id: <20260911075540.248661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> wrmsr() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911074530.3140=
830-1-jgross@suse.com?part=3D10

