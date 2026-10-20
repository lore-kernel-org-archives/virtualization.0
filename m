Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497840;
	b=yKnAHykEWMStcqS1QWWoxrgao401rICXtLLRO3pc7OBqXRPl8Rqb3/4jVapzDbUK2hqE
	 UcXR3KvNva1CK/BOhJxiJ65hKFs5bAA4q67teziTjhvHhpNHc3o8ZTnLn0QcZ9Ws3In4B
	 3KC4wRn09FGw0SOSBDvfOtqbjiPr7eilsrmQFtROgZVXG5d7FGT4MLF+fhQxenXjqsC8X
	 PAO11CTxn6ctCvL6FDo/2eafhe4KvzAo5/BdsY+boupuCwte4avSJdphe0vSGSXSfiu+9
	 eTobVjSds0P+AxK1M/tL/VZizXaODZJquLzGIJxFKJZ7xMU1nd95HkQKpVfVB74KGDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497840;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IU/GQ/MeFF4DL5Bovu0D7I6PDWZQUTgzRozq7bUHbQk=;
	b=J9WyLAm2QYqN5zFPYoqAb2N9P5SQlI5VALb2uGMaImNOajyVuMdclTwrxAaJqZF0wh5h
	 RcxrLcr+C18zPi8e0Q4EzC6PV4O0M2XNPJsT4GL5yzfsugLjWiTXnCeI1pzvEyv8Ckz92
	 WzrGf2gLpGA5MNz0abozuK3nlVQYheeV2OtklWEKSLAOtvpcUEl24fEEKLM+HEvDrKc/E
	 TmX8OzzbDa3ctg24f2RXW6fwuy8YXFytAiFxxtlxif73EZnajGo735t18uBlcbncd4eUz
	 adAoStkUewqWFOR/LhYGvAZv1zOWgHmq+/p4qylWYmcyeipj8veH5svmkkuW2g0qISg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k/8VcMyH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154C606A31E
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k/8VcMyH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA04A1F000C5;
	Tue, 20 Oct 2026 12:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497840;
	bh=IU/GQ/MeFF4DL5Bovu0D7I6PDWZQUTgzRozq7bUHbQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k/8VcMyHS013dUoYHjU6gWtXbahkKudVZzirD0Z53e3Iav0VN0cDcONK9wnIgTKxi
	 5K2A9gQufffEf/wJJKYZ4/qUOT/cS4NnPodVFZDNQXJOzsJx0yhL+cb/1AlBswflEQ
	 Lh9oxWHlaOu3pyon8OSyGU9IpnOxYBKZRDuCBQQMiZAIAxg1sY8oeg0pfLhoTzAPWf
	 dWPfAqzFXSfBvLdS6Bg2S3niY9fGHyXR3Qi3qdr47ctBBNXB6gzEt3Lclqvysw7C4v
	 AzK2Py6Iy7XoIiecFsmBUA6PDSltpAYaAlV0IMdRuUw9dc4GouxRUoaxBwdbCKEpVl
	 7JeklsO8Dz62g==
Message-ID: <sashiko-outbox-178918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/8] um: vector: honor virtio net hdr conversion
 failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <554a7cf11f82676fcadde914c7044dcad9bbd0b5.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <554a7cf11f82676fcadde914c7044dcad9bbd0b5.1792411304.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 12:03:59 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> it cannot make sense of, but the vector raw transport ignored
> its return value: rejected packets went on into the stack with
> their metadata unvalidated.
>=20
> Propagate the failure.
>=20
> Note that a follow-up patch will modify virtio_net_hdr_to_skb()
> to return a negative value on error and a non-negative value on
> success.  This is why we don't just propagate its return value
> directly.
>=20
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411304.gi=
t.mst@redhat.com?part=3D2

