Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406428;
	b=fRiSaX6yCgDFwvzUIl8UHi5R3EraeZxc2WqjzyLH4hZEonCByM1PeaLweXr/GtZ8dUN4
	 hKrkW8OtpTDzkovTa1Xwbt1vbo9zfVyIEam/Xwt0jXrn+mAPjfsO1M2a02Ek1e44tYPIA
	 XGSoBeCpIiF3Mz7jAhSZipAkUH/m8OWyapqeOLc6gfhFKKgQEvEAeXgUW9An/hjjfNzGW
	 LimedRy7TaZJ+DPXEkuMHvfL6+8Z36SCTlY4KbkC43nucS9RpdSqx921iHQJwF6NQWslX
	 nG5S9BY0BSAMOnq3rD/eoTpxa3SZvNl/hQylODaHm6VynXOWto4pCcW65lArk3qh9TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406428;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Hpk1hIi7XOiwEjgpy1/0/z4p3t9ooWMOkXOse5X+snU=;
	b=h8Vvi0IYLGxGigefzGeev6QHIZvDPMP9t2naxfnMlWkZ044lFM3xYCBz81q4DBVEy6tR
	 sV/mXHAt5dv6rhAbB5rwIMeCXEnex+DiQCTDV2cYRmsQToDhF+lPwkldJWVnMrGzA2Wgb
	 3+pDLjKiCqaxzucINvMDKWGMZoloiVvADSMc7791x2XKMnxTd5Gq9IqZkr8MkPsLCn+9L
	 WnYKaO9woXmy0H5D8MoZ/PTbMG9hI68Deji0HkWKZzQcDyIxEkw3C8pi/VmcssyTyuuXU
	 A/VCct30Y/InEPL/OmcAYXPnNv3UEMW7eDMHanX0FrbIzAxeHo0gb0xm116sEWoNNnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccH0Vsla;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEEA606A894;
	Wed, 11 Nov 2026 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccH0Vsla
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9901F00A06;
	Wed, 11 Nov 2026 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406428;
	bh=Hpk1hIi7XOiwEjgpy1/0/z4p3t9ooWMOkXOse5X+snU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ccH0Vslai/XhiQzYLaY6LVV1GiPvL6PFsDomzdlhfDfdNwCtXYgpnqABTAcrKhrBt
	 7ASdw3d34VJscDVuOV87qBfD8IYhWyBBH+EXJB/TZVl2pclmrqZ2ioEXukibOdR1Oi
	 4eyB0BlNMC/LJesN/cGT5JGitNrbks/7p/SdrRxSzeoR0fIwnsrfLKCWTYaKFeLQXV
	 HwuTf1P3rykgTyIee6xQM6PluUfUFx1zWEt3uX8gjwH4rSmrOb/Q6PvHVIEKlqFLDu
	 b3sKzFRZAeBRaCmlPMqxZ09tffwA8PFWlndXfYAMEpC4AVYo7kr81WBAaU420luCvd
	 uQanlR/g2zJEg==
Date: Wed, 11 Nov 2026 08:13:46 -0600
From: Rob Herring <robh@kernel.org>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: iommu@lists.linux.dev, Abhinav Kumar <abhinav.kumar@linux.dev>,
	Simona Vetter <simona@ffwll.ch>,
	Robin Murphy <robin.murphy@arm.com>,
	Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>, linux-arm-msm@vger.kernel.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	devicetree@vger.kernel.org,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	linaro-mm-sig@lists.linaro.org, virtualization@lists.linux.dev,
	Jason Wang <jasowangio@gmail.com>, linux-kernel@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, linux-media@vger.kernel.org,
	Mahadevan P <mahap@oss.qualcomm.com>,
	freedreno@lists.freedesktop.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Flemin Jose <flemin.jose@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	dri-devel@lists.freedesktop.org, Abel Vesa <abelvesa@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Philipp Stanner <phasta@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
Message-ID: <20261111141346.GC1476246-robh@kernel.org>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
 <179304379330.2965544.11793708430519844335.robh@kernel.org>
 <2fb9fd90-fac5-4a9e-ac7e-5dde689d8b80@oss.qualcomm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb9fd90-fac5-4a9e-ac7e-5dde689d8b80@oss.qualcomm.com>

On Wed, Nov 11, 2026 at 12:40:05PM +0530, Jayant Shekhar wrote:
> 
> On 27-10-2026 01:14, Rob Herring (Arm) wrote:
> > On Mon, 26 Oct 2026 11:51:11 +0530, Jayant Shekhar wrote:
> > > DCP platforms place the display pipeline under firmware control, so Linux
> > > cannot discover display resources through direct register access. The DRM
> > > driver therefore needs device-tree descriptions of the Qualcomm transport
> > > wrapper, display topology, IOMMU contexts, and panel connections.
> > > 
> > > Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
> > > subsystem. Document the IPCC power-notify resources, transport and
> > > framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
> > > DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
> > > after the IPCC power-notify sequence has completed.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > ---
> > >   .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
> > >   .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
> > >   .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
> > >   3 files changed, 334 insertions(+)
> > > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml: iommu-ranges: multiple incompatible types: uint32-array
> > /usr/local/lib/python3.13/dist-packages/dtschema/schemas/iommu/iommu.yaml: iommu-ranges: multiple incompatible types: uint32-matrix
> > Could not decode node virtio@9be8000 property iommu-ranges with value b'\x00\x00\x00\x00\x84\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00'
> > 
> > Traceback (most recent call last):
> >    File "/usr/local/bin/dt-validate", line 8, in <module>
> >      sys.exit(main())
> >               ~~~~^^
> >    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 443, in main
> >      dtb_diagnostics = sg.check_dtb(filename)
> >    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 331, in check_dtb
> >      dt = self.validator.decode_dtb(f.read(), decode_errors)
> >    File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 631, in decode_dtb
> >      return [dtschema.dtb.fdt_unflatten(self, dtb)]
> >              ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
> >    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 591, in fdt_unflatten
> >      dt = fdt_scan_node(validator, fdt, '/', offset)
> >    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 320, in fdt_scan_node
> >      node = fdt_scan_node(validator, fdt, nodename, offset)
> >    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 320, in fdt_scan_node
> >      node = fdt_scan_node(validator, fdt, nodename, offset)
> >    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 312, in fdt_scan_node
> >      node_dict = node_props(validator, fdt, nodename, offset)
> >    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 258, in node_props
> >      props_dict[p.name] = prop_value(validator, nodename, p)
> >                           ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^
> >    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 185, in prop_value
> >      if len(p) / type_format[fmt].size >= min_dim:
> >                  ~~~~~~~~~~~^^^^^
> > KeyError: 'uint32-array'
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.kernel.org/project/devicetree/patch/20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> 
> 
> There is a dependent patch which adds iommu-ranges, I had tried with that
> locally and it passes.

Where in the patch does it say that? The maintainer applying this series 
needs to know about the dependency, hence the report.

b4 provides for ways to define the base and any dependencies. Use that 
and then you won't get this report.

Rob
