Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062E4AE135;
	Wed, 16 Sep 2026 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596466; cv=none; b=grEWIpeiZpbiSVFJfqGKdYg+SyI8oKz6SUVbYi98yB+jD1ADjv7CopCdVo3bwbe9g1K8mroQiodpjyyQ6t4gA5aTlcfGTFLqUBBWsC1nx20kLB+/Oc6Y1L6SnzkD5Nkcyo/uW7p1nGaikS1NM1RDnGtA5gFDA9NN74iFK0+unL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596466; c=relaxed/simple;
	bh=r/4mJPmvpkVyqlS+cYIm9RB7ZB+wg63qbCevPs4CilA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kFf+W5yKvNa24mwUK+VNQktbeRQG/ta6oo+GtcKAtIy035nZ6QSTBdXqTXm3T+/KVbKkICAJUK34KiUCqvGnjlIO3itxsn+MRrmHKc9l28yhEHOII61ziv58fE9VY0KLOapvurMvCJVE8D+X7KEbJq7JB3ibmFvRL/5Amp0feo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh7WgpO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh7WgpO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D73D1F000FF;
	Wed, 16 Sep 2026 22:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789596455;
	bh=qpobW0ldlnumVACiaPcj06j6cP1uhzx6fkmN8a2srUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dh7WgpO4bqEy2D53dzXkBlp+Ue1PRUZLusYeEcFPDAGUG7TrYCY88cmSFkIePaoyc
	 yQeVUhtBJp2TTqdQ+OgO083tBengSBiWiJeRrKkQ0yCJ6C7HivYKo812hSWVDTUWCx
	 OBiPPkSlw53xd5IwS7P1s+TrHiMW1DPipagWrhO80Gb0ceaLIYgRTy6L4VfEXS3a6W
	 Sgj1IHDHNDMk9r9I0r6RnHvEoBLxywcvm7s/UK4d//mL+zc0lXKcvAzwIzuzHpRMQi
	 p+1dHH1I6CWdMsfHwRF+A9k9SrIzvyL/KXr34EnanrOXnxjaw3VnzzEOFAlBY0gqZ8
	 qafRDq3h4dUrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 12/12] PoC: arm64: dts: imx93-11x11-frdm: add
 multiple vdevs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: "Eugenio Perez" <eperezma@redhat.com>, imx@lists.linux.dev, virtualization@lists.linux.dev, Frank.Li@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260916-remoteproc_virtio_map-v1-12-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-12-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:07:34 +0000
Message-Id: <20260916220735.4D73D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dts: virtio device nodes are ignored due to missing of_node linkag=
e in remoteproc
- [Medium] Process: Patch is a Proof-Of-Concept and not meant for integrati=
on
--

commit a7b0e29a0ba6644ce08c06f5c058683c28280b67
Author: Francesco Valla <francesco@valla.it>

PoC: arm64: dts: imx93-11x11-frdm: add multiple vdevs

This commit adds rings for multiple vdevs and the required virtio nodes for
I2C, SPI, and GPIO functionalities to the imx93-11x11-frdm devicetree. It
also includes example peripherals to demonstrate these virtio interfaces.

>     NOTE: this is a Proof-Of-Concept, not meant to be integrated!

[Severity: Medium]
Since this patch is explicitly marked as a Proof-Of-Concept and not meant f=
or
integration, should it be dropped from the queue to prevent merging unstable
or incomplete code?

> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts b/arch/ar=
m64/boot/dts/freescale/imx93-11x11-frdm.dts
> index bd14ba28690c0..dfa3b122ac5f4 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> @@ -53,6 +53,32 @@ button-k3 {
>  		};
>  	};
> =20
> +	gpio-keys-virtio {
> +		compatible =3D "gpio-keys-polled";
> +		poll-interval =3D <100>;
> +
> +		button-v1 {
> +			label =3D "Button V1";
> +			linux,code =3D <BTN_3>;
> +			gpios =3D <&v_gpio 23 GPIO_ACTIVE_LOW>;
> +		};

[Severity: High]
Will the v_gpio phandle fail to resolve because the v_gpio node is not
recognized as a valid OF GPIO controller by the system?

[ ... ]

> @@ -149,8 +200,67 @@ &cm33 {
>  		 <&mu1 3 1>;
>  	mbox-names =3D "tx", "rx", "rxdb";
>  	memory-region =3D <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> -			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> +			<&vdev1vring0>, <&vdev2vring0>, <&vdev2vring1>,
> +			<&vdev3vring0>, <&vdev4vring0>,
> +			<&vdev5vring0>, <&vdev5vring1>, <&vdev5vring2>;
>  	status =3D "okay";
> +
> +	virtio {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		vdev@2 {
> +			reg =3D <2>;
> +
> +			v_gpio: gpio {
> +				compatible =3D "virtio,device29";

[Severity: High]
Will these virtio subnodes remain unlinked to the actual devices?

virtio_device_of_init() attempts to match devicetree nodes by checking
dev_of_node(dev->dev.parent). For remoteproc-created virtio devices, the
parent is the dynamically created rproc-virtio platform device (created in
rproc_handle_vdev()), which is never assigned an of_node.

Does this result in the devicetree matching failing silently, causing
dependent peripheral drivers (e.g., gpio-keys) to defer probing indefinitel=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D12
