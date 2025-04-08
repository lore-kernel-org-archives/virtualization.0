Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9D263F27
	for <virtualization@lists.linux.dev>; Tue,  8 Apr 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097732; cv=none; b=Y17ZRuA5XGX/3yornPEgp3sOGaUF98Msu+2dISarD+ejVXqyS5CqaH/XZeIgl+Q8NAxyDI6egVJzkZ16MbyugvRveyoJoo7bn+kFcaJA0bOatOUhzSpdZm135YAbY3Ey4MBcV7jzEZyvh1+KKZ+BYThm55L1TWADS+bw18fTRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097732; c=relaxed/simple;
	bh=lT5mKdSlq8oPEv2oBvQ90+eQd2L1YXxqPfN8R/eFRE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE4LVRUKxtcZ3eX1Nv5NLxdpiwlJpndjdyDZDb6H5wP4t+4uiNBakckBE3bQ1tEiAUwDiL9tJQ1wB4CP3zbdR7vsW+/SmbrGr+5Z2kF8fBX7lyrShdn6OPcT9jzHe1qvrImKE1DQ13iKc+lgaIuh0lesu68561PZdTSB0ItrN7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P7kwnapM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7kwnapM"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf257158fso36315825e9.2
        for <virtualization@lists.linux.dev>; Tue, 08 Apr 2025 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744097729; x=1744702529; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzDOAHoHmGJFY2C4m+oCbnEJZ1yOWSsgLDpINkYOwtw=;
        b=P7kwnapMmHkabVCTB0ylg4n+eIedaJe2bGbCfDamzFxlpsoGfzqyuQTjykSQzhMcRT
         gpgqNtuNKCAm21XWUKbYtYszmWT8Bf2f99h+PZ5Apd4nPXY3o4or5QNpRjq82iHWjcvd
         Kio7wjen9qpThISB3qcih6YGLwwZ4JdYHgwRs4V84mIOzNq+f6fZSxvj1mjedteKKbEo
         glB5dwKEuW76e4/wlhnQCdtvjLpUIS+mezNmAh99qKxx15liw5pVmlryF0xP33GOjWHU
         L9gXkCgRm7elQnelbrzciyenlMXFTrYkwkqdN4QWzhTLkHBwu3HhdwNuZhpaN4jg6kyk
         4CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744097729; x=1744702529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzDOAHoHmGJFY2C4m+oCbnEJZ1yOWSsgLDpINkYOwtw=;
        b=rct7fbeeHP5Nouv3p767xBcZ+gGONBpd0OGZLRPeTwKMpTCBPxtfzLc3x5zcvay8PM
         4gPTuQdyZZGyGhjm4MyN7CqQRacJ8+g16SIWH0YBdZ0fKHjn6Sp1iHwtE31nzXKvwECw
         InthpK0wLPpNR1Bkv1Q3StHdbDwU4g0Zs0aF2xIvS6OLx+OkiQsu6wSMVMfbcMWCjXHT
         FY6GmM308/J3jLVHVtVuCzNGlWgDqWXXcu9s7GHX4RHG9FqkSO+qAQpSe/MJ71v9dnx8
         YqI9/8/cR/dNQ2qWX+r0HOFIMS2VttjlcBG5CwlzKJSJaa9SSaH9ZRN34tjThWUuID6c
         I3CA==
X-Forwarded-Encrypted: i=1; AJvYcCUQnl/v62UREr7oF8rM2yAdWrx2+0Z+lCI69jB/gMtPCZwWkaWBqbZB0WJy12PdbMW4vxE5pBTr8BygsYkOTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3p6/ua2xG9ngsbfV+JiZubl5HZtfC7wLspYvtirpM/3BHVvx/
	yyhU7zqQYig+nJ8r3tUXcA1SlH1xmKYLTlVM+Wt6ZwaYIygoEEnavjZ3Ml/jGUg=
X-Gm-Gg: ASbGncsY0IjSvO22xJhg5ajYW95pSvU2AGdCygAt0b4OcgN2w1vmjwNHkdYB0gAk14U
	ken/XEnnGFXOKflDOKMF2YRdJy7YfAyeMRMtpUG3jTRD1A45Jkb/FJG5tn6vXxt6tpe8eQ7XdZI
	joO4OBVui7tW9svaczYJkRuYhCHy4FQnxKz1nyIDLEFPGcV0URPWBckI14C0cI2cN9hWEUftrOS
	4YNJrEmiHW0JZxlvreIlpJSj2w1aGcBv4sluUuvwA3/PWEgJ8nPHvQ2KYYSq7NzuL4e0ghrddz7
	p0pII8CkiFVY2zh4a2ZOh8DIdFZ+X+QJfPjh9pgUxcg=
X-Google-Smtp-Source: AGHT+IHJ4HfDuWG19jV3pAC/z0UwKWS4vohMre2m90wxX+hddBFsMJUEGHrkQ7C6iLrYU3yh7T2Htg==
X-Received: by 2002:a05:600c:8719:b0:43c:f85d:1245 with SMTP id 5b1f17b1804b1-43ecf8e7321mr170671655e9.17.1744097728808;
        Tue, 08 Apr 2025 00:35:28 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2ffsm151346185e9.22.2025.04.08.00.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 00:35:28 -0700 (PDT)
Date: Tue, 8 Apr 2025 08:35:27 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, virtualization@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: virtio: pci-iommu: Add ref to
 pci-device.yaml
Message-ID: <20250408073527.GA2279090@myrica>
References: <20250407165341.2934499-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407165341.2934499-1-robh@kernel.org>

On Mon, Apr 07, 2025 at 11:53:40AM -0500, Rob Herring (Arm) wrote:
> The virtio pci-iommu is a PCI device, so it should have a reference to
> the pci-device.yaml schema. The pci-device.yaml schema defines the 'reg'
> format as a schema, so the text description for 'reg' can be dropped.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  .../devicetree/bindings/virtio/pci-iommu.yaml          | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/virtio/pci-iommu.yaml b/Documentation/devicetree/bindings/virtio/pci-iommu.yaml
> index 972a785a42de..8bd6ad72ac7a 100644
> --- a/Documentation/devicetree/bindings/virtio/pci-iommu.yaml
> +++ b/Documentation/devicetree/bindings/virtio/pci-iommu.yaml
> @@ -20,6 +20,9 @@ description: |
>    virtio-iommu node doesn't have an "iommus" property, and is omitted from
>    the iommu-map property of the root complex.
>  
> +allOf:
> +  - $ref: /schemas/pci/pci-device.yaml#
> +
>  properties:
>    # If compatible is present, it should contain the vendor and device ID
>    # according to the PCI Bus Binding specification. Since PCI provides
> @@ -33,12 +36,7 @@ properties:
>            - const: pci1af4,1057
>  
>    reg:
> -    description: |
> -      PCI address of the IOMMU. As defined in the PCI Bus Binding
> -      reference, the reg property is a five-cell address encoded as (phys.hi
> -      phys.mid phys.lo size.hi size.lo). phys.hi should contain the device's
> -      BDF as 0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be
> -      zero. See Documentation/devicetree/bindings/pci/pci.txt
> +    maxItems: 1
>  
>    '#iommu-cells':
>      const: 1
> -- 
> 2.47.2
> 
