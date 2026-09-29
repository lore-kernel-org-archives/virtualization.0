Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0243E6DD5;
	Tue, 29 Sep 2026 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700617; cv=none; b=TZTyQm0qS+jj924FaEuFEwPH3ILIxww0xVlMdWtpGLNzR6JDTLEIzWTFuRGxOZPigRIAnvkgs8awG6XHscmYoaG92QDHfY5JrSu+xDuEuyMqTfE2gev/YmcnMY3eD7ur1CZBWVL0CisT6i7b5P1mbqHnntAqHku/GFYTroJt5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700617; c=relaxed/simple;
	bh=Nk7oBv53CgQ1czBcoK4lkoWcOC1TBdZV/O4NJawqYvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AwDJUFur9QXguoG0f3aBvTRZBE3FF77hMayM00OOpDoMlPfCuk0n8KhS3LAARrBHL7irc3Cuvu1GNuYlyqbATJi95HF21PCQ8w6W2y6rviMYnsFn/w13qpFvpdjO8SyuYv5VWJuhzswqeNP3YlldeqbgHRzQXATEr0TG36yCUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvwDxcYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvwDxcYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DDF1F000FF;
	Tue, 29 Sep 2026 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790700616;
	bh=bFd5af9jpN3FJiZNM7AvmHF7ZTb0u5rT+S+aYNo3zMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvwDxcYwFRcYVXCsBh5IyAh6RtnkpicZP++C4+M6rTkOf/zyjNEPVBcazU4vOyqO4
	 wk7QGQZzYw3yGOVTkOlaZjbVnMeP/eg8eYtLlKC3YU4dtP2OV7ffRQAZzMb5CDZROb
	 pdyWsqTsioJAnFEe/rkLhTkKqWdqCz11XLnvmVb1Pt9IVYpE7PnD2jInbEcvE3owN9
	 TBbZKKIkbK/FAai1CnRzIGmOcpINOJsi39pDpOdPXkvyYL0Rr3qV2QiTC4s8DRRtgh
	 iF2HAoIsoyeeVFrKGoJy9VkryRgROQ6cwfIKBTeKSRK1W8/KEzvRrPFJLrQROsfQGx
	 e7j4w57ZfU6AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: add bindings for spi-virtio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: devicetree@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, robh@kernel.org, conor+dt@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260929-spi-virtio-bindings-v1-1-6a0eef3213b3@valla.it>
References: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
 <20260929-spi-virtio-bindings-v1-1-6a0eef3213b3@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 16:50:14 +0000
Message-Id: <20260929165015.E5DDF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: spi-virtio: undocumented compatible in example
--

commit eb6ae8a9a8b3aa403347f70589897a8c7d297186
Author: Francesco Valla <francesco@valla.it>

dt-bindings: spi: add bindings for spi-virtio

This commit adds device tree bindings for spi-virtio based on virtio-device.
It defines the properties and node dependencies for the virtio SPI controll=
er.

> diff --git a/Documentation/devicetree/bindings/spi/spi-virtio.yaml b/Docu=
mentation/devicetree/bindings/spi/spi-virtio.yaml
> new file mode 100644
> index 0000000000000..5b8639dd2e1f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-virtio.yaml

[ ... ]

> +examples:
> +  - |
> +    virtio@3000 {
> +        compatible =3D "virtio,mmio";
> +        reg =3D <0x3000 0x100>;
> +        interrupts =3D <41>;
> +
> +        spi {
> +            compatible =3D "virtio,device2d";
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            sram@0 {
> +                compatible =3D "microchip,mchp23k256";

[Severity: Low]
Is this compatible string documented in any existing binding schema?

The dt_binding_check tool strictly validates all compatible strings against
known schemas, so an undocumented compatible string in an example will emit=
 a
schema validation warning.

When running make dt_binding_check on the new spi-virtio.yaml file, it
parses the example and attempts to match microchip,mchp23k256 against
registered bindings, which fails if none exist.

> +                reg =3D <0>;
> +                spi-max-frequency =3D <20000000>;
> +            };
> +        };
> +    };
> +
> +...

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-spi-virtio=
-bindings-v1-0-6a0eef3213b3@valla.it?part=3D1
