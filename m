Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4949B5D1
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726125; cv=none; b=jldGzgCV8m8eFciPo0b0PEiWyu3/2iChQL2azUeS+hBlSMhvNMjd4PPABRoJTnc3kykQZbRwEhprlFylf2j+hAhYqoCNoRFVDVWZx2TU+PNTT4zyLdfLr/102POeN9yau8TEaLXzyOWpwUQ45k1zt4rYIqkLxg0Ini6B3eFXArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726125; c=relaxed/simple;
	bh=S/+xa0Xy7sNPAR3k6orUlGSBOQFN60uOdP5WNAD+hrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eW3Zp8EeFYGW+jdmXn0q6HbLytCwiXvN5Jgn5WxwnM6yqNV04pQ3U5iwuAcbw6Ymr5QLGRXG0pHTZNvYbTl8YwODzVDDXNaEr1ltdOWXNdV3/LLZmtMgOPLGJn8kxAYPop8zJ1+P4SMOQSSN0K7z83wNy22Jd0pVY9LBZv2BdF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhRfjipo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhRfjipo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5711F00893;
	Fri, 18 Sep 2026 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726123;
	bh=0logBO07MURCsBD5KVajDxEUhuvDL975pij67DeQqPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OhRfjipoUxGRZa4qoifqVjhwECwzoQtiDEnhGdYa/Fise/Q9MG5ST2g4bIUC04dpL
	 TEeWYpcPOq+Cm7J9rQs/DvKQUcHc5bndP6p+B5XX3Tnf3JzM1G1f3d0mnYUgI8kTcL
	 ROOoP1fMqB2t1tESdxYQON4XLxsFItPP2HHG5t2pE53gzzq2NIeOTYhxHQ8zfx1W5q
	 WNIvtF06hzLX6Kkpyh3TAivZFRU/dFSAQb8FVjfp0Iq+dVCTKa8Dy9KqiR/AfxDt/L
	 naDv+6FuEPUgRBXyw6TpCCYfIK/2xrSQbgbV99OQsQ21qMCD8nJEikPwJiiTIa2C2M
	 7uaf3IayQnczw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr
 objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260918095940.2253018-5-honghuan@amd.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:08:42 +0000
Message-Id: <20260918100842.EF5711F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Integrate userptr into the blob resource creation ioctl.
>=20
> - A non-zero userptr selects virtio_gpu_userptr_create()
> - Reject userptr unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
> - Reject VIRTGPU_BLOB_FLAG_USE_READONLY unless the device
>   advertised VIRTIO_GPU_F_BLOB_READONLY
> - Advertise VIRTGPU_PARAM_USERPTR and VIRTGPU_PARAM_BLOB_READONLY
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918095940.2253=
018-1-honghuan@amd.com?part=3D4

