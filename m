Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364219;
	b=0npD+aUuBMrDuRsx/1b80opRtzOJ5vtTJGEJ3+fux/tSuCUJ3MAmDpam0ft/Z7Oh0w/P
	 royudD3MWbe+64tVqsgD7yE1LEB2Cb4fKwoFyeD2IhAYX4YGpkTfFKoIs5df67rz+T37x
	 ldpUDOFDfamgddEtj5cgF+cPNDAR0RxodPle4swU+cCv8fwFoeyBCFAhxseyEvw2Pz/VL
	 mEvjKRnkaBl5TPsfPNTa+T54M3kxMQKvXqfSUAO5pNlzEtOfis8XnP6criAkoG5xiA+Us
	 dMZEBY1XeoFIQn1Dt+O1HYbJYw11rcBH7nO+z6b3K+HKQr2QfqfiA8ktQVLbiCFzU/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gA9Mzfh/L7gIVVbTzP0fXX5YPSq4wuZmOJLdcc6nORA=;
	b=CYyDlHbxJssQhCb/2STJ1MgWXl1AeLRObCTR0vFGcM/fGk0QCT7r73ticodxEKC0HFtl
	 J/fH+COVXiIApfXec9Ned3YKR6P7kh1xtmIzDEXN5MzmmKgpcpjArqiheOfpDSnskoOaF
	 OrQ55dNndw0R0jGoSV4vBuZcE9uAunDyilkWrjQt3T7ZQZVKssnKUvblJEbQqsd5sy19r
	 6l/cra9pJf31GLiR7BkLe+FsoK1Fbn3URcaM6BE/LVMSb2gSfHJlZFT9fQwfV/GQIbB2H
	 JwaGig/lypMfzIJnskL1O2zlmrfK11z9f+X/n61bm0i8krAYk8VJzsr/SKRC9oP2gsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BieMRNEc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C52606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BieMRNEc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469DB1F00A00;
	Wed, 11 Nov 2026 02:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794364218;
	bh=gA9Mzfh/L7gIVVbTzP0fXX5YPSq4wuZmOJLdcc6nORA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BieMRNEcVrk1T/c1+cN673VAymgYT/S2rhWTTZU5FTXLsfm0rt4cT0qRYWYOJq0ci
	 mMhsEceAiF82I6hHWnQ6YDNAv11GoSlmhpcA2R9iiyp9YVAQpGsI5DHjBfTTx4EV3r
	 AjVnAGA4trmn9nukPUYyIvDZINyOx2SB3l5UfY7UW0okG9PekKkCnRu2DCa/ECMjLk
	 qamzvpimLT7tEV7Ye9xtU6qcpSet0I2eshkqRK7D5HbJhDESEd6uHmiajpz1PD38CG
	 hh3mzJfn1RnZ4m+5n82C7SXpOmqjZitmW6KMVvRVafE+iWhdgRbviXv4P92fveDkna
	 Z1L4jUNmLka7g==
Message-ID: <sashiko-outbox-208088@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S2lyeWwgU2h1dHNlbWF1IChNZXRhKQ==?= <kas@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261110145241.536019-2-kas@kernel.org>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-2-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:30:17 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> pipe_to_sg() tries to steal the page of each pipe buffer and pass it to
> the host as it is.  When the steal fails, it copies the data into a page
> of its own.
>=20
> Pages written into the pipe with write(), gifted user pages and page
> cache pages can be stolen.  The ftrace ring buffer pages that
> virtio-trace splices cannot, so that in-tree user always gets the copy.
>=20
> Always copy.  The data that reaches the host does not change.
>=20
> Preparation for removing ->try_steal() from pipe buffers.
>=20
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110145241.5360=
19-1-kas@kernel.org?part=3D1

