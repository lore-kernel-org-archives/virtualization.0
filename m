Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007534;
	b=XlI4ZtC0jdA/OwTmdj3m++j25/cHmeeGLuYoaLc7MjYSIu+2HpYlucnx5XeMDDksGEwl
	 YepKcwlWojKfhP783CojvPg+nVKYkPeZMyERxZNsEw1VGvLignkiyRepMqNp7/BPJ9FsG
	 zphanzdjVYy/eWiaS092ng3TpIrC1kBkfkIugdPEgD1sxQtI8rFaUdSyu/Y3QgzGXApV6
	 IhmT5T+M3RnMCA4/UGHxsi5VgCeQB/0sa99LupInXQbc48Xsde3Z3X4VFwpxhELunEpbw
	 GFA3bD5Sq1hEeaZStvpK5jHiBQ+Q0id0tBKylWjbkLBeOERgV/NEY3+AdJZyKsRg2NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007534;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1gZceDB5JLaDORdRyGWYQSRD3vgwVOwK8Zur333F1/s=;
	b=NqNtJqfeV94LcSxfiYtVy4PESaX+eJxK3Q/HTrFbiT5yJkODFkwR8qkBeQ8S/98srDH2
	 r77AqP2pGtJAsQ6DsaLcc1DXUSU5gncvk9Btm7ftWJXh1OmpkdeMilGJiijORBL3X81Gh
	 0E8GSfZ7cIPKjIL3kAygyRllEHAFe6X6UGULQ5KCXtkt7n2llQ/B9/E3lWi4SfCcp4csY
	 I3cX/QQK0bpjkjmWf42nTR4WBMNfQmsgF75cm3FFuIgm5ejXYGC7THztaoBoB+ThzNacf
	 l42slWRLuYTKPhOZGB+UAogfsisTW0R1d/uss6JhcHeZGWCifyEPXfcWvuEiByVP7YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9M0Xfv7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA9606A31B;
	Mon, 26 Oct 2026 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9M0Xfv7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F481F01825;
	Mon, 26 Oct 2026 09:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007533;
	bh=1gZceDB5JLaDORdRyGWYQSRD3vgwVOwK8Zur333F1/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G9M0Xfv7Kq7IilAIm8zurx9hac+5nKKhHsBhDz+BuvyCR7dZ0+WzsZDRlaPlHuqsY
	 3PtadpEeESZm4EYhNQis6oCpFDd3heGt6NRIKTVf3iGXP445fOUwH4tst1XSIfnoVB
	 f+YbF4uga/RRSuJgqUYtlaoMepgh7geSy6kfDChRKipj1bh2yRL88xpuwKFU+TLtvO
	 YQnsvtFI2QENTvH+1xEqaJVBPnTG1DPZlYoePmrDngetRMn6hyhL1D65Ze/naWA796
	 nmivBC7E+he182/UXxGU6iJCaENJWwvKpQ9C5KscA9oPHWYFlKeW8cX5LK0vj0tdaj
	 AQFt7AiMaHGrA==
Message-ID: <sashiko-outbox-184814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:38:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: qcom,dcp-virtio: invalid uint32 $ref in iommu-range=
s items
- [Medium] dt-bindings: qcom,dcp-virtio: mismatched reg and iommu-ranges ce=
ll counts
--

commit 148fd24e1536920168a0cc19486ca6a7b8039591
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

dt-bindings: display: msm: Add Qualcomm DCP

This commit adds Device Tree binding schemas for the Qualcomm Display
Co-Processor (DCP) VirtIO transport wrapper, the DCP VirtIO display
subsystem, and its child MIPI DSI host controller.

> diff --git a/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yam=
l b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
> new file mode 100644
> index 0000000000000..6020e848ce259
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
> @@ -0,0 +1,132 @@

[ ... ]

> +  iommu-ranges:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      The firmware-visible IOVA range, specified as a four-cell tuple
> +      containing a 64-bit IOVA base followed by a 64-bit range size.
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
Does make dt_binding_check pass on properties.iommu-ranges in
Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml with these
per-item $ref entries?

When iommu-ranges uses /schemas/types.yaml#/definitions/uint32-array at the
property level, dtschema validates each entry under items against
meta-schemas/cell.yaml#/$defs/single-cell, which sets additionalProperties:
false and does not permit $ref, causing dt-doc-validate to fail.

In addition, /schemas/types.yaml#/definitions/uint32 is a property-level 2D
matrix schema rather than a scalar cell schema, so applying it to individual
cells of a uint32-array creates an array-versus-integer type conflict when
dt-validate checks the example's iommu-ranges property. Should the four $re=
f:
/schemas/types.yaml#/definitions/uint32 lines under items be dropped?

> +
> +  dma-coherent: true
> +
> +  mboxes:
> +    maxItems: 1
> +
> +  mbox-names:
> +    const: dcp-power-tx
> +
> +  dcp-subsystem:
> +    $ref: ../display/msm/qcom,dcp.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended
> +  - iommus
> +  - iommu-ranges
> +  - dma-coherent
> +  - mboxes
> +  - mbox-names
> +  - dcp-subsystem
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
> +
> +    virtio@9be8000 {
> +        compatible =3D "qcom,dcp-virtio";
> +        reg =3D <0x09be8000 0x1000>;
> +        interrupts-extended =3D <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
> +                              <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
> +        iommus =3D <&apps_smmu 0x15a3 0x0>;
> +        iommu-ranges =3D <0x0 0x84000000 0x0 0x04000000>;

[Severity: Medium]
In the examples block of
Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml, reg is
specified with 1 address cell and 1 size cell under the default example bus
(#address-cells =3D <1>; #size-cells =3D <1>;), whereas iommu-ranges is wri=
tten
as a 4-cell tuple (2 address cells and 2 size cells).

When the kernel parses iommu-ranges via
of_iommu_get_resv_regions() -> of_iommu_derive_resv_regions() ->
of_translate_dma_region() in drivers/of/address.c:

    struct device_node *parent __free(device_node) =3D __of_get_dma_parent(=
dev);
    ...
    na =3D of_bus_n_addr_cells(parent);
    ns =3D of_bus_n_size_cells(parent);

    address =3D of_translate_dma_address(dev, prop);
    if (address =3D=3D OF_BAD_ADDR)
        return NULL;

    size =3D of_read_number(prop + na, ns);

both reg and iommu-ranges use the parent bus #address-cells and #size-cells.
With a 1-cell parent bus, wouldn't of_iommu_derive_resv_regions() misparse
<0x0 0x84000000 0x0 0x04000000> as two 32-bit ranges ([0x0, 0x84000000) and
[0x0, 0x04000000)) instead of one 64-bit range ([0x84000000, 0x88000000))?
Should the example wrap virtio@9be8000 in a parent bus node with
#address-cells =3D <2> and #size-cells =3D <2> and use a 4-cell reg propert=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D1
