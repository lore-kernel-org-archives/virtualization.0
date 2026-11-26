Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675012;
	b=rJC1kWOFX/Xz3je4wCUeOhHkfVRYBvyEX3Md83+B7sHWfIsSHtjmql97xkksLUvzjspw
	 7zQlcRAiEeL9vFumYrYAdjdztAHbAA5xfNbaOWQxUIixEZgVeQW6BqKowiay5EOlRL4R5
	 3ruM14GXotvTI6AX+bLSrlOBPCERGMzH17pdkQR0W9VLgHOLzfy5I1HFI3b9QfIHN+c88
	 SjbtE7IPp5dcJSA1ESTbCm3V7cUVcNQKZtfbuAVKm1zk71nxrMZEscj3xktQ8NlxROKBz
	 0TxXh8tCZBt42YbSdZQ7DeDp+da3aOEq8ok000WWNB7QwfAYOq7UbR3pNachG5yOsyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675012;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TQ0bhFNxLA5rNozi+byxc3f4+9nmmzwZDoF/bNfDYMk=;
	b=EeyqXqOqvmO/lEbLnfL3VDOVw6CeIbF0QYFUzRSEEE7C+lUI4VaQmeUVgTXIqe6mySSI
	 IpGWgFvyxwpudZdRgh2r+Hnj287Lrb5pcVJY4tH7rc1I9WCcWdsYUpQrSAD+8cEKYtJWJ
	 zVu39Ov2/Q9DY5LFAyvcSucjwT9WJc93Yw1XeGFTEBZChQW5FZ8we4JtZARJTXjKn+HdU
	 bHlEn8e+61bzXVku6WEi45NHGFsqLZUYq2QKQQSDzy+40u77+eBO7HyeszQJ7D3XFFG8r
	 TVvbhirYAEB54686q/kXapT9QHAvIHoqsol+cU4NW7eY5HVZiln3frF/9q8rHcaAeRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPU4u94Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11320606A31C;
	Thu, 26 Nov 2026 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPU4u94Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E441F000C0;
	Thu, 26 Nov 2026 06:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675011;
	bh=TQ0bhFNxLA5rNozi+byxc3f4+9nmmzwZDoF/bNfDYMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kPU4u94Yq4TsHgPOm98jjn2zduSDCmoU/IC0UYg4rPZ6lg9F7SLkNa63vEDLb/lFF
	 IRZ4A1vrXwSxSJxcBt66O5UcGMYRWfHWvuZ0gjfoad8EzvLIZ1qSJfMtP5nM9U+8RN
	 NXwhfGzA/cVADV6ZLytnGfSgZG6UyPGaQRXNXVsCAkjaKsVZLQinLv8GeCMJXhvG0M
	 CD2PDqxuC6fZYvhLfA/Q+LgxRK3DfoMx/6pt84GT0SGxRnQfQVFB+8lwgApFvn3x/t
	 GhMDe8wJqrbA5ir9qUo6APV3bEiGDkjNzZD8TjO+SfSeczZuwlmhr6zKZFwh2j+0Q6
	 68eIlyOluL8tA==
Message-ID: <sashiko-outbox-234870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: virtio: Add Qualcomm DCP transport
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261126-jshekhar-qcom-virtio-dcp-v1-1-7b49bda74916@oss.qualcomm.com>
References: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
 <20261126-jshekhar-qcom-virtio-dcp-v1-1-7b49bda74916@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:36:50 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] dt-bindings: virtio: missing referenced qcom,dcp.yaml schema
- [Medium] dt-bindings: virtio: invalid per-item uint32 ref in
  iommu-ranges
- [Low] dt-bindings: virtio: use per-entry items list for interrupts
- [Low] dt-bindings: virtio: DTS example fails dt-check-style strict
  checks
--

commit 32acdab74d03f0d1136a352cb6b5c3095b26176f
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

dt-bindings: virtio: Add Qualcomm DCP transport

This commit adds a Device Tree binding schema for the Qualcomm DCP VirtIO
transport wrapper.

> diff --git a/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yam=
l b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
> new file mode 100644
> index 0000000000000..46b0e53468be0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
> @@ -0,0 +1,147 @@

[ ... ]

> +  interrupts-extended:
> +    minItems: 2
> +    maxItems: 2
> +    description: The VirtIO-MMIO and DCP power-notify interrupts, in tha=
t order.

[Severity: Low]
When a property has a fixed set of ordered entries, DT binding schemas
describe each entry in an items list instead of using minItems/maxItems
with a combined description.  Defining interrupts (in properties and
required) with two per-entry description items also lets dtschema accept
interrupts-extended automatically in DTS nodes and examples.

> +
> +  iommus:
> +    maxItems: 1
> +
> +  iommu-ranges:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      The firmware-visible IOVA range, specified using the parent bus's
> +      #address-cells followed by its #size-cells. The DCP transport uses=
 two
> +      cells for each, encoding a 64-bit IOVA base followed by a 64-bit r=
ange
> +      size.
> +    items:
> +      - description: IOVA base, high cell
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +      - description: IOVA base, low cell
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +      - description: IOVA range size, high cell
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +      - description: IOVA range size, low cell
> +        $ref: /schemas/types.yaml#/definitions/uint32

[Severity: Medium]
Does make dt_binding_check fail on the per-item uint32 $ref entries under
iommu-ranges?

Because iommu-ranges already has $ref:
/schemas/types.yaml#/definitions/uint32-array, each entry under items
describes a single 32-bit cell validated against meta-schemas/cell.yaml,
which does not permit $ref (and /schemas/types.yaml#/definitions/uint32 is
a property-level type).  Dropping the per-item $ref lines and keeping only
the description entries avoids the schema validation failure.

> +
> +  dma-coherent: true
> +
> +  mboxes:
> +    maxItems: 1
> +
> +  mbox-names:
> +    const: dcp-power-tx
> +
> +  display-subsystem:
> +    $ref: ../display/msm/qcom,dcp.yaml#

[Severity: Medium]
Does make dt_binding_check fail to resolve ../display/msm/qcom,dcp.yaml#?

Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml is not present
in the tree, so validating this schema and the display-subsystem child
node in the example fails with an unresolvable reference error.  The
qcom,dcp.yaml schema needs to be present before this binding (and
referenced as /schemas/display/msm/qcom,dcp.yaml#).

[ ... ]

> +    / {
> +        compatible =3D "qcom,hawi-mtp", "qcom,hawi";
> +        model =3D "Qualcomm Technologies, Inc. Hawi MTP";
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;

[ ... ]

> +                    port@1 {
> +                        reg =3D <1>;
> +                        dcp_intf1_out: endpoint {
> +                            remote-endpoint =3D <&panel_dcp_in>;
> +                        };
> +                    };

[Severity: Low]
In the example, scripts/dtc/dt-check-style --mode=3Dstrict reports two style
warnings: in a root node model should precede compatible (or a simple soc
bus node can be used instead of /), and in port@1 a blank line is needed
between reg =3D <1>; and the dcp_intf1_out: endpoint child node.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-q=
com-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com?part=3D1
