Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4265552930
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091638; cv=none; b=Ln38jcHxyfQ1uXueGO+qxl0/YLq9b4l6kpwxoTT2cmVOYixkgqT/XNmYqu7YB4wekLDuvJXsEnC9WyXSwxnvYRJMkEc4OOkD7wY1/e+GBkXTXEnljkJdQuHilQelIny18J/wq3jhLtdL2G3WGevsxwoATscn7m+LRrRSb+vsEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091638; c=relaxed/simple;
	bh=983PoGRnItfbcGLq9/2KSAqK/+R/CY53c2rZGuZ7b1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNoEVOkdyyhLwLsjr1HZPzFUOyJbBF1oI+Up4epKLvJk/uZi8sn2bXkS38IfH1rRwigssXvK29XfjMBPuB0CUCNOyWunQg+20aScSIgcTI0F58f9CnB6YWfcFMwYjc1EklztnRcoXXV3IirgtNbr79OLKMaZMLAiIHK3u3dcGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dcp9wa72; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcp9wa72"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d20963so29932b3a.1
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790091635; x=1790696435; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2HjM704yjUPc3oYEkUo0s9e3MpU0+mzXloxkK4JXLZM=;
        b=dcp9wa72JzU00uAowJShd8OdBJckvy2Kcwva80E6xnFYqaD8Ziq/cO3AD85pGWRPIg
         rzlJFjRVhO+erflXvZ3VaxqgGnnvVSwFJSnI9sVHtvUGeXpJDx3G7BT+9JprmAd2LKgk
         Gba4eHR4YeR7q2xm9SEjZapyyDb3Hc593chssHxVNYHaepbRfyJStxcC9fKwP+sU6OAE
         trQXCvHJPLeF1MmatuYWt3+JJo/p7kTcA5RJjypzExkuEb3DoMKhdK5vcv6xr6aFW2i5
         SxvjNs+3khSEYkCQeWuIYyYeyyRWu3g2cJDFVrhEvU3QU7TLLH1p91x2vloesmgogk4x
         iN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091635; x=1790696435;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HjM704yjUPc3oYEkUo0s9e3MpU0+mzXloxkK4JXLZM=;
        b=Q0/IfsmhnWLL9eSrKCOPKKZS9DJgjBKLG3vSgLE1vxAF4yawsPPdaZdBD/r6sjCtPm
         6GChKpee67NZFBvAONwU5XJrCJFwSbPcUXJcD/AOFPoieeHfxXK/OLlL46wFx7NGEgod
         2uKnEMYhNTLMaGPcqGTZsotigxeyTEsZuvCN8Swgfwb5fbgbUplx4z7ZLpubEgFby/qo
         MZrV6zxob0A+kPemc7X6JcEq6lLauVszdEzid/+gj5XaoGsPfTY4DHSYNqwscA60UiCH
         fRYvi+DyiGcPbnpberDYLdjvm1oM8uE99db8BkkGIomnp4JYfLb0XUKoC6WSMhgfDnCE
         oc+w==
X-Forwarded-Encrypted: i=1; AKwUvBz0nldswFWKKz46DUFLQycNFfIdgswX6rjuQP+AzngLliIxdhoGOsgEjdV5W49aBESYpY+eH5sKQhMqolNDJw==@lists.linux.dev
X-Gm-Message-State: AFuF++mkqVEWFqQlGoBs3A7yaQOUVJ1ylnz2zJSLkf5yw0fyORcsw+O4
	7PjRxTI2+CImzh5ljhPELdZN7Yg3DqO9Yr0G1RvST2mSB93aKYP+vPkt8r/HJMlKF6E=
X-Gm-Gg: AYBFou1MGQA+q9nQWdN8ojQKMVdhwFCeTre1eBvSWuXbNI5Sng3eG7+2EF36pz3HOwP
	iUf4hjNSyi5Ck4urzYRf/XdOCzr3XEde4E+vnIiyHOjy4CbcnXj9bwtJDeU9B5Xz3VKBf1lONdv
	VuO7H+a0ICvqmEyG6nyXOVuxuH/di9Cq6IoQnLaactnEbA42MrfdMxzK5KiTL3klPqXIYrOQ+b4
	s4WSpY4DRTzgOKGpHwx0e/CMI28RJbLnMBdGaauSr07WBSrWgSLByEdROpJDyvw+i41T5PPKthg
	aFnCB15urIxa4jBNmUKaOfTQUSZJfCVBOSVy9D1Hke8RULkoPG6330MQGPbC+SmIIze30eebkUi
	l+eATCBWsxhSHTfHTjPiE0yoPa3KvuWs0b4uyqRIZ+6ZbYSWUj2gWYrnvZfjxZCoSQP2K38oGl9
	vf1bK4/Sn9Oo8ar/TgY1LLd6UvzAKQwyr58zhqIZ79PYwsfMPKvldXiLBAMbZo1faTMgxpadww
X-Received: by 2002:a05:6a00:1393:b0:85b:8606:627f with SMTP id d2e1a72fcca58-87c82f7f151mr1827877b3a.26.1790091635190;
        Tue, 22 Sep 2026 08:40:35 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1046:ab8:737c:d2e2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c2fc4b581sm1104255b3a.7.2026.09.22.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:40:34 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:40:31 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	imx@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 08/12] dt-bindings: remoteproc: add remoteproc-virtio
Message-ID: <arKhbxi3Snbt1_Mn@p14s>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-8-dac8c5eb4aa9@valla.it>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-remoteproc_virtio_map-v1-8-dac8c5eb4aa9@valla.it>

On Wed, Sep 16, 2026 at 11:10:53PM +0200, Francesco Valla wrote:
> Add a new binding to describe remoteproc-provided virtio devices; while
> these are discovered through a resource table parsed by the remoteproc
> infrastructure at runtime, their description can be needed to probe
> non-discoverable buses (such as I2C) or to link consumers and suppliers.
> 
> Each vdev is described by a dedicated "group" node, which then includes
> a virtio-device node, which binding is already existent and used by
> virtio-mmio. Each vdev shall be stattically linked to a "group" node
> using its index inside the resource table as the reg property of the
> node; this permits to have multiple instances of the same type of
> device.
> 
> The binding is intended to be generic and adopted by any remoteproc
> provider.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  .../bindings/remoteproc/remoteproc-virtio.yaml     | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml
> new file mode 100644
> index 000000000000..c4a0d84b1460
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/remoteproc-virtio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Virtio devices over remoteproc
> +
> +description: |
> +  Virtio devices ("vdevs") can be exposed using the remoteproc infrastructure
> +  and its resource table. For some of them, a device tree node might be needed
> +  to describe remote undiscoverable hardware and/or connect consumers and
> +  providers.
> +
> +maintainers:
> +  - Francesco Valla <francesco@valla.it>
> +
> +properties:
> +  virtio:
> +    description: Contains a group of Virtio devices exposed by the remoteproc.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^vdev@[0-9a-f]+$":
> +        type: object
> +
> +        properties:
> +          reg:
> +            description: Virtio device index inside the resource table.
> +            maxItems: 1
> +
> +        additionalProperties:
> +          type: object
> +          $ref: /schemas/virtio/virtio-device.yaml
> +          maxItems: 1
> +
> +        required:
> +          - reg
> +
> +    additionalProperties: false
> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    remoteproc-cm33 {
> +      virtio {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          vdev@0 {
> +              reg = <0>;
> +

Do we need the 'reg' since we already have vdev@X?  I'll let the DT people
provide their input on this.

> +              gpio {
> +                  compatible = "virtio,device29";
> +
> +                  gpio-controller;
> +                  #gpio-cells = <2>;
> +              };
> +          };
> +
> +          vdev@1 {
> +              reg = <1>;
> +
> +              i2c {
> +                  compatible = "virtio,device22";
> +
> +                  #address-cells = <1>;
> +                  #size-cells = <0>;
> +
> +                  eeprom@50 {
> +                      compatible = "atmel,24c1025";
> +                      reg = <0x50>;
> +                  };

The previous patch introduced bindings for virtio SPI while the above two are
for GPIO and I2c, which is very confusing.  I suggest you pick one and apply
everywhere.

> +              };
> +          };
> +      };
> +    };
> +...
> 
> -- 
> 2.55.0
> 
