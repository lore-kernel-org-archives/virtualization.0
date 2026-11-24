Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530822;
	b=jZ5KtbaySnDT5ROz9pUp1Xaeg2S8/wUs1A2jXuoRc/w7O55VVExWbYhnLAWNuZg7OW4p
	 gdS/saaoKNBh5m9JQNivV/y3qQLeUdDdzOWqDJxFQcpu62SIQ6FTlmeC/zAPIB6ZRIQnw
	 FNRC1HmIrQpM0XuiOgFWoxxW8QY4e447gD8VxKzDIYwo8z3ibvFmpP4m7bXznUV2cHpt7
	 XblP3LORi1kYn9ZdwZmU/g4S72iuu6t9BA/bPNNixmUOVyMIClt+2Dg4Vr26/4T9OD6zy
	 P6u2vh3KQK2hdEy3kEysCEFZDHSlCM6p5PAUAdxL/tQeIHS4QMeyhsbD3vN7/knTU+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530822;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4cc9Ielo1mGI5SYId0oaZcFbFQf+BjXbbrlwicmMuv0=;
	b=LvVKHpn1XN36E06AeTt2bQrDsEoc8Di2fZpqMfy+wj7p4A5KvUcrjEzdpIOUC0d7csJm
	 lxAb/LKe08SISYqptUGbHHvW/NF0KHtyrHk5VEMoqk7/uVqbh/r3orWCU46yngKQpmYRc
	 VPuRD15abCQMupGoYKBNhRPbv0ztoVBdpHupsIfuyF7EbBrbKmeMYrN4QCVTXp5lVQHbv
	 kJ8eR4REXcKL8hlBNZdmUKu68rtoZLWVKy4IurJKPYqJcol0FQ+nBBitznN0SmybV8dp+
	 MtU8+8mbJGiw1XtgwvoAICaJrBP5QZU8Hv8T5TkFZF5Akv6XE9mvJQHnpMmiiFBwCTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYatlBAe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511A606A31E;
	Tue, 24 Nov 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYatlBAe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0221F000E6;
	Tue, 24 Nov 2026 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795530822;
	bh=4cc9Ielo1mGI5SYId0oaZcFbFQf+BjXbbrlwicmMuv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AYatlBAenMNdS7mSSdw83my+VNGEHc+QyVr+JL6oY6EG8gCxztrESgqzzIOyiBo+M
	 Nscc+rJENn8e7X4EfqzZQn2kp5+98Wdqu7+WUNTlPzW2OCpP+DHmkLfJtfeSN74SEZ
	 +XDEcA7yi3Rc26qOT59q0e15OQwqxcGi3vf4ewjvgo1U195W06Q3I4pAto+2v5YZGf
	 vHzjux9E/ZK1PmaIdLhXWdNu2pXFHFhN19nwxwOuw1gEWtFOxh5n7HqE2Ws4Lk+oEK
	 ksd95/xUoTEXqjEe5yIrl0fuTnvqwsPzIuN1aAo84JGrIBeR2N/PkAJg5VrlhiV8Dn
	 4VYlQEm0UrmDA==
Message-ID: <sashiko-outbox-231354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost-vdpa: skip unmapped gap in vhost_vdpa_va_map()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261123143318.73514-1-fangxy@xiaopeng.com>
References: <20261123143318.73514-1-fangxy@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 14:33:41 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] vhost-vdpa: inconsistent handling of unmapped gaps in
  vhost_vdpa_va_map()
- [Low] vhost-vdpa: redundant find_vma() call after gap skip in
  vhost_vdpa_va_map()
--

commit 47702b500dd411149b51bf05337d951339f690bc
Author: Fang Xieyan <fangxy@xiaopeng.com>

vhost-vdpa: skip unmapped gap in vhost_vdpa_va_map()

This commit skips unmapped virtual address gaps before vma->vm_start in
vhost_vdpa_va_map() so the file offset calculation does not underflow when
uaddr lies below vma->vm_start.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index c912ac40ca375..2707be470a1f6 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1154,6 +1154,20 @@ static int vhost_vdpa_va_map(struct vhost_vdpa *v,
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

[Severity: Medium]
Does this handle an unmapped gap at the end of the address space
differently from a gap below a higher VMA?

When the remaining range [uaddr, uaddr + size) is an unmapped gap and any
unrelated VMA exists at a higher address in dev->mm, find_vma() returns
that VMA and gap >=3D size breaks out of the loop with ret =3D 0.  If the s=
ame
unmapped gap lies above the highest VMA in dev->mm, find_vma() returns
NULL, setting ret =3D -EINVAL and causing vhost_vdpa_unmap() to tear down
any valid VMA mappings already created earlier in the loop:

drivers/vhost/vdpa.c:vhost_vdpa_va_map() {
	...
	while (size) {
		vma =3D find_vma(dev->mm, uaddr);
		if (!vma) {
			ret =3D -EINVAL;
			break;
		}
	...
	if (ret)
		vhost_vdpa_unmap(v, iotlb, iova, map_iova - iova);
}

> +			size -=3D gap;
> +			uaddr =3D vma->vm_start;
> +			map_iova +=3D gap;
> +			continue;
> +		}
>  		map_size =3D min(size, vma->vm_end - uaddr);

[Severity: Low]
Does the continue statement here cause a redundant find_vma() tree walk on
the next iteration?  Since vma already points to the VMA starting at
vma->vm_start under mmap_read_lock(dev->mm), falling through to map_size
would use vma directly without looking up vma->vm_start a second time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123143318.7351=
4-1-fangxy@xiaopeng.com?part=3D1
