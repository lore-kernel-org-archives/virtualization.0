Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052357;
	b=2UA9Tg4SG/MGSlmV37KJDUvZwYmnqDtwwru7As/FJBVZblLXe2Gvme4p+so9rExFGT7w
	 Sp66d5Nn+dMMgHtB0TExueCjAPX84xrcz3ab7P7s3IFDI+6JHJpelh2w/9ukhkPmnKlkK
	 vIdU+K7bXod3MTFrbdI8kPj83auPzgaVEY+jl5I19XuJNXqKSdezv1T3vnQ5+0/TjhBDg
	 NdU38YoIH/XwunwqefDcbo/wYskMVcomR9n19XrmUotk7D21EWF/GSDcNoX095n6MkZ+r
	 UQAp1v7VRncOs3qUT5mbkpp7m5D9pzpAvES28SIl1xFYkvhExzZ2XlHyYkOn0i1enXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052357;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=I1Z/UEBMkZ2eyWGttef85G5kGG91dwTk/1RV8AnX9Hw=;
	b=a846F/GACrno8VVrvykMjKFsfO90dbiWx0XXCNkzNM0rbAYFsbvaeiAUVE86uXC5JtEP
	 BzGFA9lLQ857AkoOTVXlFlIqJEKz3dJUWz1thPXheXk+Sow9UsVPiO8CCk6+pqXwrrtSG
	 b+rhRXuJ2sHbnP1z9R8f9hjmppp1+Rlc/BE4o30K4JQ0bpqnFR6ggHhCw+zmQbez9WCll
	 FWpYRhp4qOfJ5r0brxYOQGHSuHpWHQ8oUq1+a36AeZBKFJoeuC6II7zVr2aGlKvRAHMWT
	 QU9F77dCowvSO9FKqTF97X9fv8G/H71caZpkfT3NeimvsnL+SqZAngnITU/y3i6VWxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSb2K1rl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D32606A325;
	Mon, 26 Oct 2026 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSb2K1rl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A631F01828;
	Mon, 26 Oct 2026 22:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793052356;
	bh=I1Z/UEBMkZ2eyWGttef85G5kGG91dwTk/1RV8AnX9Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RSb2K1rl2D/iiCOieLGIP5QjaYD0QT2vv84q0R5Tm9eP6wZC6gVhHBjFDpFMCjUXE
	 sZMuI+u9XTrEAFZaNj1JhZtCtSgu94jXq8qdDCb3VZ86U61Gudmqwd2kiFhBspd4Td
	 6tFbYaUkNytXXi8AIwNY45J3f1LelTIeY3q5+wVRWAmbJt7xET4QSpyv8c4m/R+CRc
	 fsLtrngJjKN5WgFL70YTb1WuGjDQjknPN6pYbh7+quHr8Rz4hukQI1pw/ygAU647RJ
	 2ZTzXbetdWfA01W3+4cNC4WA1VRqeZlwSFeaGSy0DfoRMhnQ6LMeRzw8inGT9nehq+
	 u84tDA/URpBRw==
Date: Mon, 26 Oct 2026 17:05:52 -0500
From: Rob Herring <robh@kernel.org>
To: Francesco Valla <francesco@valla.it>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Jason Wang <jasowangio@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: spi: add bindings for spi-virtio
Message-ID: <20261026220552.GA3933778-robh@kernel.org>
References: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
 <20260929-spi-virtio-bindings-v1-1-6a0eef3213b3@valla.it>
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
In-Reply-To: <20260929-spi-virtio-bindings-v1-1-6a0eef3213b3@valla.it>

On Tue, Sep 29, 2026 at 06:41:55PM +0200, Francesco Valla wrote:
> Add bindings for spi-virtio based on virtio-device, reflecting what
> already exists for gpio-virtio and i2c-virtio. A node using the bindings
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

Drop. This just repeats the title and $ref.

> +
> +properties:
> +  $nodename:
> +    const: spi

Drop. spi-controller.yaml already defines this.

Rob
