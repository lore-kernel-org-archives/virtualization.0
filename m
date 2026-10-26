Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793043865;
	b=jZHlkqgMBVhBzUJkSAfA3QUe1raoz/ZURLt+jsrLpqr+u2l9KBQYlQkPelcYvizUDYoy
	 QeBYUcg5amC1xVv6nDcD7P8ErjAjZWN7DJeKGR6rG74CAgKb50evMBN6+gOsVk0y0RAFg
	 GF689EbaB7jlwjXrRTY0GvBUNuNW6DeBp8ZiMBM7+ah2qzwxGvEKInRt9E5C326H3uMmk
	 NOTG3G9htDSwK+VqeXV08mbNZlXBnD+qa7dvp1zdvmuXxdfIXn+/NmdlKTg3kQ8DPHCti
	 RzQYtZ8tFsw8B5MWhVTCWw9EoKreDCnd1awYW/Bv89O4pHdsLjTj9P7MGqbuvhZanHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043865;
	h=Received:DKIM-Signature:Date:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=EnFV3b4kBOohLUYDrT2EqqoWC7vJoIJiTj7bdy7r6OI=;
	b=Fejs33lx8Pf9Y4pJZ5KHls7x8rhj2FgwwBcaM0Fk7hbxcAHHeDRwKJMi0LCeQvUCVzCs
	 kxBoeCQK2FsUmL/Nitddl1MoOdqWBx7cZpWI0GKx43+AhDmmq912BQQRmJnnKF4AjDDvV
	 CveUZJ6LLDaZHAop9jcbiTcCHfiBvthOu3kxs09X1GDQTIQ0N0T8qATHxJ4jUNFies7xM
	 K/8tvFeUWJD//wR+JQeTGJPx+bd2Akd9eGMf8sc37FCob12ndYsuxU8j6RLi3maceyH7J
	 7sMuAzpXAqr7PDnavK+JbWf8v34IB9zS2hHJUrVIP9N1si27l7Bkqyo8Kys3C/yauGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORXNjc6l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C9D606A31A;
	Mon, 26 Oct 2026 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORXNjc6l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6CE1F01828;
	Mon, 26 Oct 2026 19:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793043864;
	bh=EnFV3b4kBOohLUYDrT2EqqoWC7vJoIJiTj7bdy7r6OI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=ORXNjc6lV4OPB/JbeGos2UZgw/cJHmUDpVxWFIXeJ9IQc1OIbUO0GwHsSt+PYSBtF
	 0c+bFq+C4t8uvAgxXtft9Qrilg9uZFSeIQWNo1tRBzMmGSfP4zboJpS4awNV5jnqTn
	 sF4yIE+AS+NvvERIjFrHj32wwaxBM/jJj0yu6wL2H9fx4577Bc1r7DDgBZgK2sTW5s
	 KFxAKu5vUEzq0Fl5b7iG3BDLNDDuQ7ucgNaLVKIB7MZuoiHY+/QFcf/m4Cqu2k0SZJ
	 sEBMBktyAgstq+lAAeCm/sSGl1ZIl9FIxURJ6wIlBpQb6CU36g1MwtCN3lqepAt9rp
	 e9K0DDBfzoVlg==
Date: Mon, 26 Oct 2026 14:44:21 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: iommu@lists.linux.dev, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Simona Vetter <simona@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 linux-arm-msm@vger.kernel.org, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 devicetree@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>, 
 linaro-mm-sig@lists.linaro.org, virtualization@lists.linux.dev, 
 Jason Wang <jasowangio@gmail.com>, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-media@vger.kernel.org, 
 Mahadevan P <mahap@oss.qualcomm.com>, freedreno@lists.freedesktop.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Flemin Jose <flemin.jose@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 dri-devel@lists.freedesktop.org, Abel Vesa <abelvesa@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
Message-Id: <179304379330.2965544.11793708430519844335.robh@kernel.org>
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP


On Mon, 26 Oct 2026 11:51:11 +0530, Jayant Shekhar wrote:
> DCP platforms place the display pipeline under firmware control, so Linux
> cannot discover display resources through direct register access. The DRM
> driver therefore needs device-tree descriptions of the Qualcomm transport
> wrapper, display topology, IOMMU contexts, and panel connections.
> 
> Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
> subsystem. Document the IPCC power-notify resources, transport and
> framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
> DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
> after the IPCC power-notify sequence has completed.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
>  .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
>  .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
>  3 files changed, 334 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml: iommu-ranges: multiple incompatible types: uint32-array
/usr/local/lib/python3.13/dist-packages/dtschema/schemas/iommu/iommu.yaml: iommu-ranges: multiple incompatible types: uint32-matrix
Could not decode node virtio@9be8000 property iommu-ranges with value b'\x00\x00\x00\x00\x84\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00'

Traceback (most recent call last):
  File "/usr/local/bin/dt-validate", line 8, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 443, in main
    dtb_diagnostics = sg.check_dtb(filename)
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 331, in check_dtb
    dt = self.validator.decode_dtb(f.read(), decode_errors)
  File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 631, in decode_dtb
    return [dtschema.dtb.fdt_unflatten(self, dtb)]
            ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 591, in fdt_unflatten
    dt = fdt_scan_node(validator, fdt, '/', offset)
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 320, in fdt_scan_node
    node = fdt_scan_node(validator, fdt, nodename, offset)
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 320, in fdt_scan_node
    node = fdt_scan_node(validator, fdt, nodename, offset)
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 312, in fdt_scan_node
    node_dict = node_props(validator, fdt, nodename, offset)
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 258, in node_props
    props_dict[p.name] = prop_value(validator, nodename, p)
                         ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 185, in prop_value
    if len(p) / type_format[fmt].size >= min_dim:
                ~~~~~~~~~~~^^^^^
KeyError: 'uint32-array'

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

