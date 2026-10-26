Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027412;
	b=ZNEOg6c7mhDQ7Q1H5MowTWQryj0TwusukpKNKftmcOjmc0es6SVu+7oIenajqUXs2h9f
	 EnFQQPwVerFHDFyMAyNIfwTJR6kHf4oSeQyArJOKqa5XP6+N8+J8g9C6MXY7bTMGXuq0J
	 8VlsSb9NIK04AS5UA0SXaAT/6qiIjmY101zOt083PlhbjDqFjvxl5Nn6OrmsOGWPLSbrm
	 JEgZnI5UokM+UXptGQNsjJdTOwI2STe7vTirgxzwhaSxFxNBTBsCITfS/j9jTMHFFE7+n
	 v42hSOgogpEsw6oEF4q7gZJfNT+lNq5HrRt4fO1uQA/o/uL6DFngqfc4vWNn2MSAb+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027412;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2WRc+6jKb1+rLFwlm6EMxXrK00B3VaipSnTC3dwcXMM=;
	b=nDrVFgcb0WMY7+U63CLAgToEHcWQEDYgCZOjbA14zaBCQeAqZqHoJ+FnRbRqU1yN9vON
	 NEDA9R+dy33hdc+UtcELqkhbFdVYxe3NP4zljnmOFZOm34iPxkdjSljiakUOiLhqhxXDs
	 opGOncapxht1SEFctzM1S8JtFuAEtQd7WqYj1qq6ZaNckejFaseoDVORwE8zbcSCrO4jG
	 DT395U9BSbvDjXthkzjnpukM4GqKWXigYjHeGm/+wMXD+yr73FOWmmJoHQm2HzvEO4CMi
	 nYF25uBwkyh7XQ/eWQlh3D0RL47HYIQPox0m8kH/MqM4UsSl3erQ9PUuHuH6YsF2sEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dchg4vGt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24A606A31E;
	Mon, 26 Oct 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dchg4vGt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948781F01825;
	Mon, 26 Oct 2026 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793027412;
	bh=2WRc+6jKb1+rLFwlm6EMxXrK00B3VaipSnTC3dwcXMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dchg4vGtrpLM04uYvU6oR6FN93DNFhSnS0EKv0Uy5TG6P1YGMNO+EqEDcDB4njqOn
	 Opk00KY0UqvphCpRURdUbZ51bZHL9mYKRTS49oyAg/T+qe9RHWiJhzta66V19b1fQH
	 8sNKon6cZm0uKEVaNZW6Rk4UvCMwnzE9ASYsLBZRFpMVI24TWKmejq3NvTQc0WfOeS
	 bNg66TkCUDCsvqbpB4UR9/Zr1l4Goyi8FyLF+KXpzrgOAlbWCU2WhL29QVoMv52wdQ
	 Kp2ZbTdko6DCRKg4s7+4z2xO+NwTG2ZZtWMXonem0bosTtmgv4Un1XXp78eU658o1q
	 d5U+KZxULb2Lw==
Message-ID: <sashiko-outbox-185424@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/23] arm64: dts: qcom: hawi: Add DCP support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-23-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-23-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:10:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] arm64: dts: qcom: hawi: dcp virtio node placed under root instead =
of soc@0
- [High] arm64: dts: qcom: hawi: panel reset-gpios pin 210 mismatches pinct=
rl gpio211
- [Medium] arm64: dts: qcom: hawi: dcp left enabled in dtsi with unconnecte=
d endpoint
- [Low] arm64: dts: qcom: hawi: sde_disp0_vdd_active violates qcom,pmic-gpi=
o schema
- [Low] arm64: dts: qcom: hawi: duplicate tlmm block and unsorted nodes in =
hawi-mtp
- [Low] arm64: dts: qcom: hawi: raw integer 13 used instead of IPCC_MPROC_D=
CP macro
--

commit 1a3114977b7eb966fe7d2b04c935e54daa02d988
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

arm64: dts: qcom: hawi: Add DCP support

This commit adds device tree nodes for the Qualcomm DCP VirtIO display
transport, subsystem, IOMMU mappings, and DSI endpoints in hawi.dtsi, and
adds the DSI panel, regulator, and pinctrl configuration in hawi-mtp.dts.

> diff --git a/arch/arm64/boot/dts/qcom/hawi-mtp.dts b/arch/arm64/boot/dts/=
qcom/hawi-mtp.dts
> index c38e5fab7a2cb..a27003f69d024 100644
> --- a/arch/arm64/boot/dts/qcom/hawi-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/hawi-mtp.dts

[ ... ]

> @@ -995,3 +1008,119 @@ &usb_dp_qmpphy {
>  &usb_dp_qmpphy_out {
>  	remote-endpoint =3D <&pmic_glink_ss_in>;
>  };
> +
> +&dcp_dsi0 {
> +	panel@0 {
> +		compatible =3D "novatek,nt37801";
> +		reg =3D <0>;
> +
> +		pinctrl-0 =3D <&sde_dsi_active &sde_te_active &sde_esync0_suspend
> +			     &sde_mdp_vsync_p_1p2_active &sde_mdp_vsync_p_1p8_active
> +			     &sde_disp0_rst_1p2_active &sde_disp0_rst_1p8_active>;
> +		pinctrl-1 =3D <&sde_dsi_suspend &sde_te_suspend &sde_esync0_suspend
> +			     &sde_mdp_vsync_p_1p2_active &sde_mdp_vsync_p_1p8_active
> +			     &sde_disp0_rst_1p2_active &sde_disp0_rst_1p8_active>;
> +		pinctrl-names =3D "default", "sleep";
> +
> +		vddio-supply =3D <&vreg_l12b_1p8>;
> +		vci-supply =3D <&vreg_l13b_3p0>;
> +		vdd-supply =3D <&display_panel_vdd>;
> +
> +		reset-gpios =3D <&tlmm 210 GPIO_ACTIVE_LOW>;
> +
> +		port {
> +			panel_dcp_in: endpoint {
> +				remote-endpoint =3D <&dcp_intf0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&dcp_intf0_out {
> +	remote-endpoint =3D <&panel_dcp_in>;
> +};
> +
> +&pmd8028_e1_gpios {
> +	sde_disp0_vdd_active: sde_disp0_vdd_active {
> +		pins =3D "gpio2";

[Severity: Low]
Does the child node name sde_disp0_vdd_active under &pmd8028_e1_gpios in
arch/arm64/boot/dts/qcom/hawi-mtp.dts cause a dtbs_check failure?

Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml sets
additionalProperties: false and requires pin configuration child node names
to match:

patternProperties:
  '-state$':
    oneOf:
      - $ref: '#/$defs/qcom-pmic-gpio-state'

Should this node be named sde-disp0-vdd-active-state to match the schema and
the other PMIC GPIO state nodes in this file?

[ ... ]

> +&tlmm {
> +	sde_te_active: sde-te-active-state {

[Severity: Low]
This isn't a bug, but arch/arm64/boot/dts/qcom/hawi-mtp.dts already has a
&tlmm block earlier in the file and keeps &label overrides sorted
alphabetically. Should the new TLMM pin states be merged into the existing
&tlmm node, and the new &dcp_dsi0, &dcp_intf0_out, &pmd8028_e1_gpios,
&pmh0110_d_e0_gpios, and &pmh0110_f_e0_gpios nodes be placed in alphabetical
order?

[ ... ]

> +	sde_dsi_active: sde-dsi-active-state {
> +		pins =3D "gpio211";
> +		function =3D "gpio";
> +		drive-strength =3D <8>;
> +		bias-disable;
> +	};
> +
> +	sde_dsi_suspend: sde-dsi-suspend-state {
> +		pins =3D "gpio211";
> +		function =3D "gpio";
> +		drive-strength =3D <2>;
> +		bias-pull-down;
> +	};
> +};

[Severity: High]
Is there a pin number mismatch between reset-gpios in panel@0 and the
sde_dsi_active / sde_dsi_suspend pinctrl states in
arch/arm64/boot/dts/qcom/hawi-mtp.dts?

When the novatek,nt37801 panel driver probes and transitions between default
and sleep pinctrl states, panel@0 under &dcp_dsi0 requests pin 210 for rese=
t:

	reset-gpios =3D <&tlmm 210 GPIO_ACTIVE_LOW>;

However, sde_dsi_active and sde_dsi_suspend under &tlmm configure "gpio211"
instead of "gpio210". Since the Qualcomm TLMM controller uses 0-based pin
numbering, does this leave pin 210 without its active/sleep drive-strength
and pull-down settings while reconfiguring pin 211 instead, or should
reset-gpios and the pinctrl states reference the same pin?

> diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qco=
m/hawi.dtsi
> index 6b0a0ff0faa45..836970cdef718 100644
> --- a/arch/arm64/boot/dts/qcom/hawi.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
> @@ -6841,4 +6841,44 @@ timer {
>  			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>  	};
> +
> +	dcp: virtio@9be8000 {
> +		compatible =3D "qcom,dcp-virtio";
> +		reg =3D <0x0 0x09be8000 0x0 0x1000>;

[Severity: High]
Was dcp: virtio@9be8000 in arch/arm64/boot/dts/qcom/hawi.dtsi meant to be
placed inside soc@0 rather than directly under the root node?

In arch/arm64/boot/dts/qcom/hawi.dtsi, all SoC MMIO peripherals live under
soc@0, which defines the bus ranges and 36-bit dma-ranges:

	soc@0 {
		compatible =3D "simple-bus";

		#address-cells =3D <2>;
		#size-cells =3D <2>;
		dma-ranges =3D <0x0 0x0 0x0 0x0 0x10 0x0>;
		ranges =3D <0x0 0x0 0x0 0x0 0x10 0x0>;

Because dcp: virtio@9be8000 is added after timer directly under the root
node, which has no ranges or dma-ranges properties, root-node schema
validation fails and of_dma_configure_id()->of_dma_get_range() cannot find
the SoC dma-ranges when configuring either the virtio@9be8000 transport
device or the child dcp-subsystem device in
drivers/gpu/drm/msm/dcp/dcp_drv.c:dcp_subsystem_dev_init():

	ret =3D of_dma_configure_id(dev, dcp_subsystem_node, true, NULL);
	if (ret) {
		dev_err(dev, "of_dma_configure_id failed: %d\n", ret);
		goto err_destroy;
	}

Should dcp: virtio@9be8000 be moved inside soc@0 (ordered by unit address
between camcc: clock-controller@956d000 and usb_1: usb@a600000)?

> +		interrupts-extended =3D <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
> +		iommus =3D <&apps_smmu 0x15a3 0x0>;
> +		iommu-ranges =3D <0x0 0x84000000 0x0 0x04000000>;
> +		dma-coherent;
> +		mboxes =3D <&ipcc 13 5>;

[Severity: Low]
This isn't a bug, but since arch/arm64/boot/dts/qcom/hawi.dtsi includes
hawi-ipcc.h, could interrupts-extended and mboxes in dcp: virtio@9be8000 use
the symbolic constant for client 13 (defined as IPCC_MPROC_DCP in
hawi-ipcc.h) to match the other IPCC consumers in this file?

> +		mbox-names =3D "dcp-power-tx";
> +
> +		dcp-subsystem {
> +			compatible =3D "virtio,device34";
> +
> +			iommus =3D <&apps_smmu 0x400 0x2>;
> +
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			ports {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +
> +				port@0 {
> +					reg =3D <0>;
> +					dcp_intf0_out: endpoint {
> +
> +					};
> +				};
> +
> +			};

[Severity: Medium]
Should dcp: virtio@9be8000 in arch/arm64/boot/dts/qcom/hawi.dtsi have
status =3D "disabled"; by default, with arch/arm64/boot/dts/qcom/hawi-mtp.d=
ts
enabling &dcp?

The commit message notes "Enable the DCP display device on the Hawi MTP
platform", but dcp is left enabled in hawi.dtsi with an empty
dcp_intf0_out: endpoint node that has no remote-endpoint property.

In Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml, every port
endpoint requires remote-endpoint:

    patternProperties:
      "^port@[0-9a-f]+$":
        $ref: /schemas/graph.yaml#/$defs/port-base
        unevaluatedProperties: false
        properties:
          endpoint:
            $ref: /schemas/graph.yaml#/$defs/endpoint-base
            unevaluatedProperties: false
            required:
              - remote-endpoint

In addition, on any Hawi board DTS that includes hawi.dtsi without attaching
a panel to dcp_intf0_out and dcp_dsi0, leaving dcp enabled causes
drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c:dcp_dpu_kms_init_dsi_bridges() to add
dsi@0 to the DRM component match list even though no panel ever attaches to
register the component:

		dcp_kms->dsi_bridge[dsi_idx] =3D to_dcp_dsi_bridge(bridge);
		drm_of_component_match_add(dcp_kms->pm_dev, matchptr,
					   component_compare_of, dsi_np);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D23
