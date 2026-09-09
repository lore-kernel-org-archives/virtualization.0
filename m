Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B53DC4CE
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946041; cv=none; b=GfWpENRdm2UY4F82z0el7WQ+qLSOqcPPfravAzO9nibrhcUZRN9NxUuRfIiK7mSEhDWZIHN4DbXiz0g58hHunemXHUmvCLCc2EIlMZXgIOKpZ3B2Boy/BW/EmNnSLAfjUxKRgW8QKKQBa8e8xkJwdX6EI9xB2eCHRLB+u+5HaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946041; c=relaxed/simple;
	bh=vtxJS6yB77L7DsNUaU7Z5ouel60sj0N3MOEofJff6qs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rMutUO9Kh0zAfKrO3qsYdGpVMxi2D82vEONiU7jNdJjw/f3C/MdT6A0lVtkh6CfozsjgyvZg0fBvtVAyvE1rStmbK8RblbJVVTFqsUvor/uXGeTZGI2WYQtBxf9dPASWp8rf3wOnAzChEbTifhVV1CPysOqe6h41fTzngWUfGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo4ormp6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo4ormp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9741F00A3A;
	Wed,  9 Sep 2026 09:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946038;
	bh=vtxJS6yB77L7DsNUaU7Z5ouel60sj0N3MOEofJff6qs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uo4ormp6Z3zhDaA3R1yM9xu04t3F2UEBtsDqHbwQmeVdTyue9oXuqEZ6Rt/UwqhMb
	 G4C2CQ+Pn+yaYerFgZSMPe1trdvrln0CHmxf/ZEeOnGfY5SUNXQt+UaxHpc1cbga9J
	 wQ5fpyv89mBVKX65ZF/Mj+mJC/nwzWsW0WL6s5bjCWzUautA5niAl9A9L+tH7QPOHd
	 zwM9gxs0TwW6kizGxNbG2IyMQQswssIMEHcSihqxUHEv6DhoFr5UcSicNCWLycK3g3
	 dNcEmUeg5AwwjUHpRPtvJVttqZhHtZF/9KT9RWhmphR1LU9fP9/InDbQnbiwm47DsU
	 hPFvBukZft53A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC RESEND 1/3] virtio: add virtqueue_get_last_used_idx()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260908092646.108865-2-lange_tang@163.com>
References: <20260908092646.108865-1-lange_tang@163.com>
 <20260908092646.108865-2-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:27:17 +0000
Message-Id: <20260909092718.1B9741F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Longjun Tang <tanglongjun@kylinos.cn>
>=20
> Export a read-only accessor for the last consumed used ring index.
> It's useful for drivers that need to detect whether the device has
> produced buffers that have not been consumed yet, by passing the
> returned value to virtqueue_poll().
>=20
> The split ring now writes the field with WRITE_ONCE() (the packed
> ring already did) to document that the new reader can run concurrently
> with the poll path.
>=20
> Assisted-by: Kilo:deepseek-v4-pro
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908092646.1088=
65-1-lange_tang@163.com?part=3D1

