Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA32F4A05;
	Wed, 30 Sep 2026 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769803; cv=none; b=BMkt9j+2uoI5wSJlOMU0IbyDRIAn+KtMiN7irTJP6qoE02ewMwSvq10+Dd+hu1Qy9fCIECRHZd+ezKUD2I/QRHbSu+r/cI60/8/lIy7FfsmLcimG8T7kP7Nt03mTOa21L6mJz6+AxQ+phG5PJDnZgsiOf28LaHtUMWl44sXZBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769803; c=relaxed/simple;
	bh=9rGggYwbOXnYSUoBcgsAL8Tc3W+81t7Ft2I6zn09JFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql4bqpWVvg6NIiybQOasc513r0F+XCZNTmONFhpblCRI3Uhg2iDOX2lQmRuYtr+w/eJHmkz1uK9vDGzTWO+4rswszHIMzER/LpG/Ttow/pHlelXWF/+MHmUDFoY3TcZTCspw4ucmVJHyHH0SlzokdPghHE4Rhlyi9ZG3Y7QgwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+KY/DCg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+KY/DCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D471F00898;
	Wed, 30 Sep 2026 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769802;
	bh=lCjS25zdAXqSW9teXqsvW5XjZnZ+ytkIDyTc7gD5Ie4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g+KY/DCg4e+KnejKnB2YcSWonl+t9bQCRxb7eVwivzSwaWW55DMs6HaxMwuee8mKh
	 Ltj1BDE9jMQF3b2OVp1y2eaYsvKqXG8M0JhepHbd9rzIOc5w0n/+dDs8mrJGyAoT25
	 HBAp2NZQHit1FZYSppJ6qnQ97CFb38dPPY3qcqtlKodw0yjy9YbwOroYCBOEQXVVjE
	 wrOrwiZcpPWo7B9L+vmxVVnwvQ9VXaKlLa2JIv5CXOr6Lz/uewv+nG9IdXXDF4Mj6a
	 ++tPeLhvQcQlMwxYPJgVQzjrwCrA+fjS3vPQU4OnwB+6smkr7R2BqavdYaPa37f/IF
	 ZfZSUWARlBU7A==
Date: Wed, 30 Sep 2026 14:03:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Francesco Valla <francesco@valla.it>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
	Jason Wang <jasowangio@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: spi: add bindings for spi-virtio
Message-ID: <20260930-arcane-pheasant-of-infinity-ecff83@quoll>
References: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
 <20260929-spi-virtio-bindings-v1-1-6a0eef3213b3@valla.it>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929-spi-virtio-bindings-v1-1-6a0eef3213b3@valla.it>

On Tue, Sep 29, 2026 at 06:41:55PM +0200, Francesco Valla wrote:
> Add bindings for spi-virtio based on virtio-device, reflecting what
> already exists for gpio-virtio and i2c-virtio. A node using the bindings

Existing code is not a reason to add more code. Existing bugs are not a
reason to add more bugs. Please provide proper rationale why this suits
DT.

> is not used to instantiate the device, which is registered by the
> transport (e.g.: virtio-mmio), but to define its properties and
> establish dependencies with other nodes.
> 
> Add the new bindings inside the MAINTAINERS file.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  .../devicetree/bindings/spi/spi-virtio.yaml        | 53 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 54 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-virtio.yaml b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
> new file mode 100644
> index 000000000000..5b8639dd2e1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-virtio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Virtio SPI controller device
> +
> +maintainers:
> +  - Francesco Valla <francesco@valla.it>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +  - $ref: /schemas/virtio/virtio-device.yaml#
> +
> +description:
> +  Virtio SPI controller device, see /schemas/virtio/virtio-device.yaml for
> +  more details.
> +
> +properties:
> +  $nodename:
> +    const: spi
> +
> +  compatible:
> +    const: virtio,device2d

From where does the compatible come from?

Best regards,
Krzysztof

