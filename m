Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3D2EA749;
	Sat, 10 Oct 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643163; cv=none; b=R0OYCh6pxpQdEb8QagtmO7lbXxHFkedk+JWxMVtNFs028quek1BXdvR/wZjZ9gpwrOFwTm0nNEYAYyPThhlmdMNyjBIJjQE+RiYOHe/ZPEFJGApuG64jrXNcYftXctSDwCCnKuOax0BclNcIjZRqcjlgdOm5ziQDPcPWByT9/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643163; c=relaxed/simple;
	bh=o4jPaywj6Xf2LA0AYtNd45kFIQBdtURMTNQTqINgVow=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZIgMfkl4JU0ch8ucXsvqUnEztgv3FPjD5VPIi6DyyZyze29dQNWWxAzL+N64QDVeGgtvnmvz8d1TGL1QZcaYvBOyqv6PrPeS3dAmCjq8LBlQAB8r5XEbMxQndQiZj+1uc1Cs3rqQQCAobSVB8fGu6IYsYKM36/szfvmW6lWt7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbALQnpK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbALQnpK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850131F00893;
	Sat, 10 Oct 2026 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791643161;
	bh=o4jPaywj6Xf2LA0AYtNd45kFIQBdtURMTNQTqINgVow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lbALQnpKdRFlANVtzTnWdclTSRAfxluVr8jKZ17xYkEwDdOfgdddmTnMAlnf4rxju
	 tZ5YpD17T6BEpCVT3pmZhWj00/CIRrUgtV5zi5PZQGH0S3gmrXrjTKKtE66vXhnA2u
	 2jcQGrqFcKQLRE9u1w5NvKEYzSIKoWYfJ/4Qr5m5T4AI6gOjR7JbNOFLsd2h/IWQLF
	 TZk9bU17avjcpU37wugrmKTh2t92gBrg0L7TRthoojV0OxiTXXFPO59K2g4nP6Zcq9
	 JPq4Tir4JQwG3wtutm2TE9zbrbzrT9kElk9bcSQXWBKSFTPn0SqH+4izb95Tjmrytf
	 IjkcXutW5JVyQ==
Message-ID: <sashiko-outbox-166651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 3/5] vsock/virtio: reuse same-flow socket
 lookup in RX batches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, bpf@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261010142247.99223-4-physicalmtea@gmail.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-4-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 14:39:21 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> An RX lock batch still looks up the socket for every packet and takes a
> temporary lookup reference, even though the batch already holds a referen=
ce
> to the locked socket.
>=20
> Record the network namespace and packet address tuple when a batch starts.
> Reuse the batch socket for later STREAM/RW packets with the same tuple, a=
nd
> release the batch before looking up a different flow.
>=20
> The cached path still traces every packet, takes an skb owner reference,
> validates socket state, source and transport, updates credit, and runs the
> receive state machine. Only the socket table lookup and its temporary
> reference are skipped.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010142247.9922=
3-1-physicalmtea@gmail.com?part=3D3

