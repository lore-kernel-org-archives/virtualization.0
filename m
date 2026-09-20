Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2D3C5DC5
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789932582; cv=none; b=TUWVLjk4Z4YjMGPmD7I3xqubP3DzwemhH1t7hEynast1craYWHbLWJaC7nLAK5gcT8vfSOBtPnkotjvCpM2sl+oe8QMYB4pJJT2iXcBQmex/uG7Q6Xcl1tW2TQCOAijU0WbG+/I1b//Gs97nSjuED9A/GWr+N2acnXGDbNVZAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789932582; c=relaxed/simple;
	bh=ZCEb7PWxWjqFXQU9Aa1wIndmD1/mjEbe7eeXsYlBY9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uws0pJc5jfqb/YsyEB5mYhR1YN2tHofH3GtF5VhNKX7NfEee523IlkHqmLj+w5+XF+d50bCB1oCLN8ua47H3aOGW95o/tHoSDWkMUEpDWO6yBygQ2mbyetv2WUUsgmtLoQJH/KwDg37x4KqhGbWoVMO1a0oij7/GBQyeqGYzH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxPBeChF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxPBeChF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06891F000FF;
	Sun, 20 Sep 2026 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789932581;
	bh=ZCEb7PWxWjqFXQU9Aa1wIndmD1/mjEbe7eeXsYlBY9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VxPBeChFm1kfmAHFDzUusOB4q1TVtxvmFtelNjQrvzNZT7nK7y/jXeWqT5QYlLBzo
	 Oxmn++OSXhC6H9rBldzloDhSVMf6XbHIqqPLT7OnPQxf7qzMWgZCCIo+JOJdWFp+87
	 c61GY5DX1C372ocLv2NjUINUxGbztVs4jrZ/FUzzyeYmnRBc4SZzQQkjVtZmXztd0m
	 EzF+YkWbgvofJ4x5cEj1jN6dtJihlUNZbXxk4f/Ls1pQGrFvRk1XZJA4atvjkFBiyb
	 yNHEoU1jzZPUhkeR/iZIFebIRWERjbwbAK3fJChQAP+T2ja1CJzUoU2ibtLE+wpKFr
	 kNI2KzGbeJagg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/virtio: Open-code drm_simple_encoder_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian von Arx" <linux@sebastianvonarx.ch>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260920184244.464343-2-linux@sebastianvonarx.ch>
References: <20260920184244.464343-1-linux@sebastianvonarx.ch>
 <20260920184244.464343-2-linux@sebastianvonarx.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 19:29:40 +0000
Message-Id: <20260920192940.B06891F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> drm_simple_encoder_init() only wraps drm_encoder_init() with a
> cleanup callback. Open-code the helper in preparation for removing
> drm_simple_encoder_init().
>=20
> Assisted-by: LLM
> Signed-off-by: Sebastian von Arx <linux@sebastianvonarx.ch>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920184244.4643=
43-2-linux@sebastianvonarx.ch?part=3D1

