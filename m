Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79404E1C86;
	Wed, 16 Sep 2026 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595905; cv=none; b=DFrLEVqqphAnARdN614RVejQKUtJQzJBZMcsv3KBu8hzYW0fdfrjvBcn8/kHJvSNaBATln7heSorHLnPEC9NCXmEU5qFlqR/mwewrKP/SHsEJtA8RrBngz8gZk0sbtIfQC275Ft+6B8++oQn2Ufahf10+mn3SSpKSGGBaZsaz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595905; c=relaxed/simple;
	bh=TMIo5h6WtzJxgGGhmDkfLkBvgIMduF+KhlT6xzFIn0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GruWPeK0tTsNu3tJQctWPNJjJ4vbKWMNEhYFLkXYxk3gGCYFEM1UtOlyGq1EElC2rhsTUBLpC7NkJcrqAFmAnae4JxuhouFAC9hnmdPTr/bk0lZhD79A8IiiRp3zpmnxpdwmQag2IJBOjPY9BCKyVAp/YZYQJXuGHiPr2TCUedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCokq6EM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCokq6EM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4541F000FF;
	Wed, 16 Sep 2026 21:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789595895;
	bh=TMIo5h6WtzJxgGGhmDkfLkBvgIMduF+KhlT6xzFIn0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lCokq6EM6Zxzw39VQTGGo6mNdzLE4TDDulAS1ZWYlbcH27+iMs93X7v5P/5kMUqEJ
	 i270x2z/DKPcLm7MJe09DcJvJbelaDa48UGX7XWvC0OxKlPvMBHcJpycB6BDKg4kIz
	 uaag+q3JBkOEequp0X6kwzEbZjcUWwM9Ae45mbYaLqPPW2Yg51ZQCMPhTMkaN6fG0Q
	 kkZpI8oDWs7XX1ZFcDA/1y/vvVspB3VXh7hQp3f9j4ILd5kCdHAPGYxZoS9DnrQlhH
	 dv0ew9X0VcDy3WO8EmudWM4C45PymUUahraIe8GStvTQ813068FyXcjaTNCmns3ECX
	 JFOyWFs6wl5fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/12] remoteproc: virtio: replace commas with
 semicolons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, conor+dt@kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260916-remoteproc_virtio_map-v1-2-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-2-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:58:14 +0000
Message-Id: <20260916215814.BC4541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> While not technically wrong, the comma at the end of an assignment
> directive can lead to nasty bugs. Just replace the two occurrences with
> semicolons.
>=20
> Signed-off-by: Francesco Valla <francesco@valla.it>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D2

