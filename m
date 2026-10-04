Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE366424D79
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119391; cv=none; b=Tz375pGF+iqKjQqGgEbgeZGAQyTNe6Ot7pKSXdtw4D/ieIXK+o8Bvu10x8UpCb9L30f+aFGOpnJ091WJDzIeACD3kGH4vM+d74G+Ic6y/dhzmmc+zdFieUgF963/q6rm3uDEXUqGaW+byMRT0Xwkpuhnieqnbl3GEne6m/kUZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119391; c=relaxed/simple;
	bh=tekz55eLxYk+qBKLlqhgFSD/zdrrTekZKU97jjbQqRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hjBdnJRZ2HiZYP8wwmXwNzhEYDcfkp6/OKf5XrcFQZ9huzy2qNnorpkK/HaerBUUCSW5KfzH8492N90ocPFPSM9ie+rQHk9YlreLhuvXOY0YXOUrN0VQb4Itt7YN2pKAeVpNbNJmnY2kOBNiRvotccilLy+rSsrGBVaMSm+IT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWdN3hox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWdN3hox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F81F1F000FF;
	Sun,  4 Oct 2026 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119390;
	bh=tekz55eLxYk+qBKLlqhgFSD/zdrrTekZKU97jjbQqRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWdN3hoxiA+QaTQDBrm+oVNjDIoIp7jbEZEGvea2re1QUFHQtUbGj1zFeQCGDRD29
	 qsV7Cysa20hcZjnOyaRY8k/fAeuLuEpLHXEVihllrNySM8/we0MwNlDV15YDHeXxH5
	 lsAkGjYNkOgP0K3C7/mk3IslFtD3XkbTe+h6NNFPJvFyINIptHkkJkYV6QQZIgIllC
	 Gef0wv2EQPXXkotGZhcwCMc5w5SYGDCTJTXYaA9rwrG7qmWX34ZFVrxGPSQohFLqVj
	 DUF2KhINZnd0djAoyrBBcUKrfd1hJdq6hfDIDQDOnoQIO8CN6xSaVBhwYCMe0gurdn
	 MpjesmeDYgwDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] iommu/virtio: allocate the UNMAP request with
 the mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <tencent_E9DADACA296EBD4DBF63DB0F072B37DDCC07@qq.com>
References: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
 <tencent_E9DADACA296EBD4DBF63DB0F072B37DDCC07@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 13:09:49 +0000
Message-Id: <20261004130950.3F81F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The iommu core states the contract plainly (iommufd pages.c): a driver
> may not fail unmap for reasons beyond bad arguments, and in particular
> may not allocate on the unmap path, because the caller may free the
> memory as soon as unmap returns. viommu_del_mappings() still allocated
> the UNMAP request there, so a forced allocation failure left the device
> mapping a page the driver had already released, while the caller was told
> nothing.
>=20
> Allocate that request object with the mapping instead - on the map path,
> which is allowed to fail and reports the failure to the caller that is
> mapping - and free it with the mapping when no UNMAP is sent: the unmap
> path then only fills in and queues a request. Measured with a fault
> injected into that allocation (failslab, on the fault-injection harness
> this work used): the unpatched driver returns success for a re-map of the
> same IOVA while the device still translates it to the freed page, proven
> with a real DMA through the QEMU iommu-testdev; with this patch the same
> scenario reports no such case in any round and the DMA lands on the new
> page. The unmap path allocates nothing afterwards, and the device sees
> the same request stream.
>=20
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Signed-off-by: Anlai Lu <agicy@qq.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_D757B544955=
DDC509B5DC7161F425620BA08@qq.com?part=3D3

