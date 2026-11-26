Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674578;
	b=4FKy7YWjOz3WKXFWO/NFQF0VPSnNAVFReEDGBIH9B4YlSw/Ec5Phrxq1ZGrwYCUkR2F3
	 3XJJPGSweOsa3PQ6FDOA1JHtpHeJ6vyf1nTfaz2gFHaIqA0ncVxbka4s0gGdKcmEfOatL
	 9d07izg38MnSZJxf7eYivh//GG3IhRB9rDYCMpQNMdP/3fM40LBbet1RVS6uemC+RUJGE
	 GAAbNVmf+ubIBXqKmafSo1NGeBwqjPXBK8cHulDwtd34Qhf6zqA+cYT10R9WD2FziIOpt
	 wZ6PlrhlS5whOdvDs3Lq1Lnf9D8dkfkSSRwt9D52QX1ekjj8Kxb+s0lLbOjV7bzyuJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674578;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wMA1SZehVIWRyJUOw1gsgdAhNQojEJ63Quh4yWmOdS4=;
	b=Ng4NsQQUEjfESb0UsbSX7uJBsniRXuPpGEqFVs0wv51n/772Yw3ZRs7l+ZrdYx3GCjEV
	 IFSIkiRXtmsYLXI5pu1O0G0/xijSAZNnY4viiGeznbHbGb8z1hl/gXyigNMcN+0ZGpypg
	 Vt1lVXRmDsgpSU8oVX1Yzs9WqQ03GMGM8ikG2uo4A7q1SNOKVxYIDWmIpDSY5lEXujKAj
	 1zU5Y9AUorz+BPL9m5ZFR4l+cS5pCuitEaEcoh5nNn/mkSVgLZN36CIrxgVDvUTRj8qlP
	 U0G14jbxCnZf492I5tfOZfN3aLODrMsVamCa9dXNF2JCFzP6O4vLZz/H8MxFeja8Zrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFsJUqru;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E22606A68B;
	Thu, 26 Nov 2026 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFsJUqru
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137111F00ACF;
	Thu, 26 Nov 2026 06:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674577;
	bh=wMA1SZehVIWRyJUOw1gsgdAhNQojEJ63Quh4yWmOdS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VFsJUqruY+JIe184R799e9Wd7WLdHPK8TUksMA0VuI5pJlUj2fmAyIczkod5hS2No
	 ypNdpmK32vOIqN2JUggBAAkir3YLVO+NTt33f++18zzlxR+nxXnAIXq9VvDXhgfexS
	 DcmHgqAZxi+R8MtrAtaXYe4MQ7VYdBfzqUo8rFxCjpVyCfv1KNVRC/JiSWyTk1et7D
	 GldbqRcSeNcxg3qY5/U1hYA+gXEy/m/lQvbTHBP/l+4sSTRu5oKhXBFmT2Cg7Gmz0w
	 xNP9yeo+nJvSU6SnF6fj4GtWxqm8W764tS0oAN8CwwSB7PM3uGTq9jbiF2G9Xe0WPJ
	 2d7CXSDd6tbuw==
Message-ID: <sashiko-outbox-234855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] virtio: Add vendor-specific device ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261126-jshekhar-qcom-virtio-dcp-v1-2-7b49bda74916@oss.qualcomm.com>
References: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
 <20261126-jshekhar-qcom-virtio-dcp-v1-2-7b49bda74916@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:29:36 +0000
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
- [Medium] virtio: unallocated VIRTIO_ID_VENDOR added to UAPI
  virtio_ids.h
--

commit 913884946279be0d6a387cfae4fb22c6ba81e67d
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

virtio: Add vendor-specific device ID

This commit defines VIRTIO_ID_VENDOR (52) in include/uapi/linux/virtio_ids.h
for generic vendor-specific VirtIO devices.

> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_=
ids.h
> index f9056af0c6223..9a8b6a6a03a48 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -70,6 +70,7 @@
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
>  #define VIRTIO_ID_SPI			45 /* virtio spi */
>  #define VIRTIO_ID_MEDIA			48 /* virtio media */
> +#define VIRTIO_ID_VENDOR		52 /* virtio vendor-specific device */

[Severity: Medium]
Should VIRTIO_ID_VENDOR be added to include/uapi/linux/virtio_ids.h before
device ID 52 is reserved in the VirtIO specification?

As noted in the commit message, value 52 is only proposed for VirtIO TC
allocation.  Documentation/driver-api/virtio/writing_virtio_drivers.rst
requires device IDs to be at least reserved in the VirtIO specification
before being added to include/uapi/linux/virtio_ids.h, because exposing an
unallocated ID in the UAPI header risks an ABI conflict if the VirtIO TC
assigns 52 to another device type or assigns a different ID here.

In addition, temporary merge-blocking notes and commentary about future
driver matching belong below the --- tearline rather than in the permanent
commit changelog.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-q=
com-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com?part=3D2
