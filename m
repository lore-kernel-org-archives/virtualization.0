Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884BB47CC73
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453371; cv=none; b=HLGLfQQYc/obkL7/Lnj3YpUCYLDaV0WRZ0a1o86UtTW5YOFsJUGBF5+AiCTg/uvUAFDTtAZlUjAXfkfulc8kUR41dw1E4c3ji4yF/NMUOyexZXqR24kJKatUVWk60IP6566yC3TtobcAISoM31Cp6hAdgM7TgFAVM2zq9C+egBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453371; c=relaxed/simple;
	bh=pr0Z3tnTE9qKi7myGQwr6we5PwEU55hr/TcA+71hQXg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WoVcYKPFrfiKdhtarCA23S8NW8GJCgxGrwIQwCT0Kw0jC+VJc5XPZl2oOYeB+TJ97N4Hu+d80x++fM7abOQlDB6afeZYbMahJgYZ5527HEhth0LzJ9l8UTHC48M7exj0o9NlPuFjzlbdqx5pttR/WyGWdJhwn8QW93dBVrnJB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfLC6t6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfLC6t6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD761F000FF;
	Thu,  8 Oct 2026 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453364;
	bh=i2NaYmcLz7pcgLwd6SnF0NT7P2rUvHNkoiSnxYWVwc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RfLC6t6DY5xOq0VILHYR/E8/vXIwhOkMI1zr00Bkt7ROPynt4g33K2EtWxWQ3SD1w
	 yqi8OqmJ69hrNNSTDe9RBk6bQIN6Vs9KNxt38L6pDHMHICgZKaesI+ayq76KEje/v1
	 bQAPUeUYz78lAGKoQDMt+kk5wR6VwiqdZ16EgPOKcwOEqGXYnHhgaNSt8bEx2VThmB
	 1iPzG6JiRy9fgT7Esf/ukCxSVcmgy9R2pM7BnHORjN48wHB3LVMjVd+0nWo3rg/y6w
	 J38YRpO3pmK81lHWypATQ8wIGRwa3woX5SlK1rOzdxPoUkxBucqUQkBfWVzQDOztOF
	 YE7zVDsy0fQ2A==
Message-ID: <sashiko-outbox-163970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] iommu/virtio: bound the probe-property walk to the
 probe buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261008094240.1082031-1-yhlee@isslab.korea.ac.kr>
References: <20261008094240.1082031-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 09:56:03 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iommu/virtio: unaligned 64-bit access due to unvalidated property =
length
--

commit 1966676bc77a49f0f207bc2272bebf67d2bd8f06
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

iommu/virtio: bound the probe-property walk to the probe buffer

This commit prevents an out-of-bounds read in viommu_probe_endpoint() by
checking if the property fits within the probe allocation before
dereferencing it. It also moves the length check in viommu_add_resv_mem()
ahead of the memory accesses to avoid reading past the end of the
allocation.

> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 587fc13197f12..dbc997a6e3568 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -489,6 +489,9 @@ static int viommu_add_resv_mem(struct viommu_endpoint=
 *vdev,
>  	struct iommu_resv_region *region =3D NULL, *next;
>  	unsigned long prot =3D IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> =20
> +	if (len < sizeof(*mem))
> +		return -EINVAL;
> +
>  	start =3D start64 =3D le64_to_cpu(mem->start);
>  	end =3D end64 =3D le64_to_cpu(mem->end);

[Severity: High]
If a buggy or malicious device supplies an unaligned property length earlier
in the parsing loop, could the mem pointer passed to viommu_add_resv_mem()
be unaligned?

Because the virtio_iommu_probe_resv_mem structure is not packed, the
compiler assumes natural alignment. On architectures with strict alignment
requirements (such as ARM or SPARC), wouldn't these direct 64-bit
dereferences via le64_to_cpu() trigger a hardware alignment fault and lead
to a kernel panic?

[ ... ]

> @@ -563,8 +564,10 @@ static int viommu_probe_endpoint(struct viommu_dev *=
viommu, struct device *dev)
>  	type =3D le16_to_cpu(prop->type) & VIRTIO_IOMMU_PROBE_T_MASK;
> =20
>  	while (type !=3D VIRTIO_IOMMU_PROBE_T_NONE &&
> -	       cur < viommu->probe_size) {
> +	       cur + sizeof(*prop) <=3D viommu->probe_size) {
>  		len =3D le16_to_cpu(prop->length) + sizeof(*prop);
> +		if (len > viommu->probe_size - cur)
> +			break;

[Severity: High]
The virtio-iommu specification requires property lengths to be 8-byte
aligned, but this length validation does not enforce alignment.

Can an unaligned property length from the untrusted device advance the cur
offset incorrectly?

viommu_probe_endpoint()
    ...
    cur +=3D len;

Wouldn't this cause subsequent property structures to be mapped to unaligned
memory addresses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008094240.1082=
031-1-yhlee@isslab.korea.ac.kr?part=3D1
