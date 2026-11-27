Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764279;
	b=dfb4aWVzKiank7r6fyw5ZHxYLx05A0qWxJZ/UQwaBFaF35jT933o297+MsltomxAVMrb
	 vgyTCDhsrJ/pmKYGwAOi7wP6pExXEmulB/kUnxA3rxKoKy+5d5pFSq9/9jLIT4pTerPZg
	 cdIa7q4BjpX4RUGRn0i++aIT5UhYb/JGVQMRmBh2ZIR9rAzB/oa2GgpHdauH3bWKcpEjr
	 oi3jckV5HyQYwcTZptT9+U0tdiT1LO02HiOArlVB61eM+zY8cAJLlN7bLqZKpX445MYK8
	 yY9BaWjP205T+UmKdKu+1nDlQuTp+DVu6quVg8s23xJIIsIbii6lr/3s8csdTAiLn2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764279;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pNvwViERl8s7sXdzcG83DsqbHBCvwtXUGhMZLQxRuts=;
	b=1nDPyf55V04S2rLn8V3aYunrqoj0+lCuJmalujjgCiV2K1R5KaHbnArGahEcTZEuoqL1
	 VNGmRYKNZywHbOO3FFYhjm+hiUVcqN59xw9Zj5x9N8qrSLeEjlAm+3+9o+NGvwKZQuc+3
	 +sigwTy0cAou6LVw45UojcOUgoXW0QH26fBOpBLQYp7YeS1yxH/rioqjpb2huQd4VJ38I
	 rlu3B7W5KAvgtLQX2Bv+XApZ6IL4YMcBsMgECigLd+dRI5hxEbSEngSgjirpj/Rgzs1v8
	 gLOqbvotM8jT065JMX0JtX5zXVl6PFfEw0JcPUlulnvUry0e4B+AebN6sVeHOg0hInQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLawWYRv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084F5606A324;
	Fri, 27 Nov 2026 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLawWYRv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FED01F000C1;
	Fri, 27 Nov 2026 07:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795764278;
	bh=pNvwViERl8s7sXdzcG83DsqbHBCvwtXUGhMZLQxRuts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CLawWYRvuE6/aGoKOLxKOqlfZls5j5AwBkVvxmKfUDU0b+6mHHCw92fFFUg7WtagN
	 fgKGy9XOwizqLKIjw1U3KpmfcMs4q8W+4CGl3aED/dgSwgjyYV6hYm/ta+aIRiXV8K
	 t3wQkx0+RgbO5SudcL9Zni33rQGZto+uavNwkT5TLuG5FA7VEIWsAb2qIgYu4wP1oB
	 7wtsb3sZJsJH1nd7S5fIh9bFnrs5LAWES59N0Wk3DYmdDN2eZCLwcAqS/lqE+o5U+4
	 rQ6UjmjQpZQklxIaJOUuG34PGJdZuiNn2SBL/BqdCEUqKPeLbMN6dxtnNOcCLYeG0h
	 rO2+2MRIhJEhA==
Message-ID: <sashiko-outbox-236800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost-vdpa: skip unmapped gap in vhost_vdpa_va_map()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261126072414.97199-1-fangxy@xiaopeng.com>
References: <20261123143318.73514-1-fangxy@xiaopeng.com>
 <20261126072414.97199-1-fangxy@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 07:24:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vhost-vdpa: inconsistent unmapped gap handling in
  vhost_vdpa_va_map()
--

commit 32b0d078e53a97a709c1be4706495eeda3a12b09
Author: Fang Xieyan <fangxy@xiaopeng.com>

vhost-vdpa: skip unmapped gap in vhost_vdpa_va_map()

This commit skips unmapped virtual address gaps before a VMA in
vhost_vdpa_va_map() so the file offset calculation does not underflow
when uaddr lies below vma->vm_start.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index c912ac40ca375..091aa58d2d977 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1154,6 +1154,19 @@ static int vhost_vdpa_va_map(struct vhost_vdpa *v,
>  			ret =3D -EINVAL;
>  			break;
>  		}
> +		/*
> +		 * uaddr may lie in an unmapped gap before vma->vm_start; skip
> +		 * the gap so the offset calculation below uses an address in the VMA.
> +		 */
> +		if (uaddr < vma->vm_start) {
> +			u64 gap =3D vma->vm_start - uaddr;
> +
> +			if (gap >=3D size)
> +				break;
> +			size -=3D gap;
> +			uaddr =3D vma->vm_start;
> +			map_iova +=3D gap;
> +		}
>  		map_size =3D min(size, vma->vm_end - uaddr);
>  		if (!(vma->vm_file && (vma->vm_flags & VM_SHARED) &&
>  			!(vma->vm_flags & (VM_IO | VM_PFNMAP))))

[Severity: Medium]
Should an unmapped gap at the end of [uaddr, uaddr + size) be handled
the same way regardless of whether an unrelated VMA exists at a higher
address in dev->mm?

find_vma(dev->mm, uaddr) searches up to ULONG_MAX rather than uaddr +
size.  If an unmapped gap (either the whole request or a trailing portion
after valid VMAs) has any unrelated VMA above it in dev->mm, such as the
stack or vDSO, find_vma() returns that VMA with gap >=3D size and the loop
exits with ret =3D 0, keeping any mappings created in earlier iterations.
If no VMA exists above uaddr in dev->mm, find_vma() returns NULL,
setting ret =3D -EINVAL and calling vhost_vdpa_unmap() to tear down all
valid VMA mappings already established earlier in the same request.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126072414.9719=
9-1-fangxy@xiaopeng.com?part=3D1
