Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0775456286;
	Wed, 16 Sep 2026 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595785; cv=none; b=FpmAeLYjFTdauWbOgKIwkj2nGk5WqQkan26WqDHd8okf3VYiGRr+92A4fNVq/o3jCd4YJyOl25sursupZRX4GuNRThNOkB7kdOSiT59O8dSU6DH2oRK0Mo1t84pKzw9tFRjFvnaZOhVwmFzNJH3evFghFzwuhbsQwJuCyq9ID4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595785; c=relaxed/simple;
	bh=909ATlBWrVsBlJ/3tlVthd1WA7GSSUXSRdGcHUGkbN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OnEBZ8KsVnorXAEbcysvBVxKGncRXqAgjRnBCrChzUTxEncp3zmpR+zHXi7hWweAIUHYCS1xz9LpaF5O/H2cncWBAendSZiRbdRoGf7175yq6GTUKYfaQo7N2+LYbdQRTACF5I7SdE1sqYUrFf3e3xli91TiBgCAfQo7lAFKSlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXNUeid3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXNUeid3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E60D1F000FF;
	Wed, 16 Sep 2026 21:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789595772;
	bh=909ATlBWrVsBlJ/3tlVthd1WA7GSSUXSRdGcHUGkbN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WXNUeid3KcJ7W/dnmAjlyjEj1HgkVC8Gl2S8izxeNmSrD+j67qg6FZYeJxIbJ5rVw
	 mvkfW4s+61jeuYfitgB348kxLjMClfQmKurqRF2m0akVkMid8tWNRK9EVvyaFDhLY4
	 W/lVEy/SEz1Z/b5WzXlZDeb6btQLYLUEIYGr40XluT0UZ57bopWcrC79dWmKYRrJR7
	 8P4sAgF38pVM/XkKpK0h1AxSeABNBBuEjTUA+nKSXUEp7zkpuIUe7UZER0U0IZGlMQ
	 gFbQevPETDRQuV3WQXT7q2wn7xtFQcCWZrG0N4I0tBJAogBdGltUzvdzOTZSa0qosb
	 Pit8/xydgA9iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/12] remoteproc: virtio: cleanup
 rproc_add_virtio_dev error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260916-remoteproc_virtio_map-v1-1-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-1-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:56:11 +0000
Message-Id: <20260916215612.0E60D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> There is no cleanup to perform in case an error occurs inside
> rproc_add_virtio_dev, so remove the goto label and just return in such
> cases.
>=20
> Signed-off-by: Francesco Valla <francesco@valla.it>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D1

