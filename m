Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573167;
	b=wdvMRaARrLQ6J00/t7xopbAf5U7KmpZLqvv+HtRTbQRf4/vItjkTFYj8CdWXVdaAnP7Z
	 i7NIolqCHlVJ9sgZXaax7C8yXAXdy+eBFvR4vUNqp+lQq5YY5v1taTyuPsE3rOCmZP0R5
	 0Yjj/O9teaJ1x9uhmzfpaiZo/tRM2O4lRxafLBkYNx/cER0i9jb2i6GV4p3G1fhP44V67
	 aoM/tY2AtGE58SU9u4aLmIbheMXxrRZ091pNHRtLmNn8SBaflXwDnqL0NlSpAbFpJT51w
	 DQL+EJL4KCLwFegyldFcwrwYY99Pm2aRbUu61yEInO4Sx7o35G2j4/fAtM7wKrJu/4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573167;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MC4N/UBMy5sgvcsVto2EdiLGoWCKWGsYEOWUBbWpje8=;
	b=E/+lz4hweIqxTPEUS8PzmGTA+p+HzSXCCRCNePdC4VcbM17az6egx3KRodvo+WEQIO7S
	 h2F/bLz+YJ7K5WHiyKxjIgGcx4cyI5e/HPtEOVIbThYr4Vuo7QojVmFJAn90vpbAHxzbU
	 cKExGYAw1Joh51Vjyp9ydD2+27OxkMAvYH4vyKdFLZVConro4s3VbrKwMlgnyhI8TIPWv
	 koxxPjeDrkinPFHSQLGeVZhuGgtIu4E4FTZGpc5lhlJE8fQIO5rJ/8SIN0WOqPFY8ECOt
	 G8Sj7vzSNrNm796aKm4LLlPXA4skWgMg+UaWxyqnOwyALOU8rFAeJ4j4qre+eUFDojg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bmH/5Rtn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C05606A31B
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmH/5Rtn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6761F000C9;
	Wed, 21 Oct 2026 08:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792573167;
	bh=MC4N/UBMy5sgvcsVto2EdiLGoWCKWGsYEOWUBbWpje8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bmH/5RtnTpYL6lL5iBUT4Axk3Hxr/Sxy6sfkv7GJ0b0tuLIDCploEO0y3cGXBpngu
	 M+nKwp+RIs2N7/MmEAGSNVZizxYpdsCQ8Vn+8eSGq9k16AK9K3Igiu6pGeG82G/8ol
	 GqxfZJLpDxVk/Ss4dlbSpGvrkitRU7WCDqSfnnfeph4g881PhxnoAuXn8iOZtYPW36
	 1MS1IXIC9KPsebWrBqLxRw9HtufhXvdIMYIED/JOpd/TdI9KXA8vLKH+WPVxrSdHKp
	 pEG31QPgop7Jo760r10X39oUdF/2NBg7w8K5Lovk4WN3nnUll4mNKIfR60A/YNnfzB
	 v+puBQMvwSrfg==
Message-ID: <sashiko-outbox-179995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost-scsi: fix page reference leak in misaligned I/O
 fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261021085458.196742-1-physicalmtea@gmail.com>
References: <20261021085458.196742-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 08:59:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> iov_iter_get_pages2() returns a byte count that excludes the offset
> into the first page, but also returns a reference to that page in
> pages[].
>=20
> On the misaligned-I/O fallback,
> vhost_scsi_revert_map_iov_to_sgl() puts pages already added to the SG
> list.  The cleanup loop starts at pages[npages], but accounts for its
> first page as PAGE_SIZE bytes rather than PAGE_SIZE - offset.  If the
> remaining data starts at a non-zero offset, it can finish one page
> early and leave a page reference behind.
>=20
> Use PAGE_SIZE - offset for the first remaining page and clear offset
> for later pages, as in the mapping loop.  Without this, each affected
> request leaks one page reference.
>=20
> Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021085458.1967=
42-1-physicalmtea@gmail.com?part=3D1

