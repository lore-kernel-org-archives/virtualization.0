Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262601;
	b=2ocC9gGOh6l9zONuaSowZ/l5yM4rslD//L8FQVz8ezxOWqBDeQq0BEXiSsygjWovRNuI
	 QV1l1kais69GrUy+k0MiWMCiSNE1rx7rOg1JjgvLqOfQ8NQyscXnhcvN5Ba+1KbVnYiZS
	 /Q/Kq5HJbsozMw2frylGAVDVtD+2Vxf23NHPyIGn3De8V2r+1q0Ezdl+/zJV/P9X2mn9C
	 r4z3UFKrM3ob/z0wefDA4bcB0GBgBVnqeHDhOssOC8fygXjgjlYaUvBzN4g8i0aU7LbZ1
	 DMdYrZXXB19E5mec5JP2uSq8zUdHe7vR3KPMSRWMMBXY3IlXJjXxTGGDVYH7PY3FNmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262601;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JqG+lDYltlnao/ARBbfD/u5hrXSlDYp4BgLb7g8BjiY=;
	b=HQxmUKZEjQZhxrSEv0jsbhwwCBAVbZZ0ZKKhIsLOwwPbh/P1SF9f/pZsMjKXRDtx/emK
	 p8AdwDWLPHkLDU+g6MOVXLtK2TVLfZljDO5jenZR7LjakLEdHBPgXkavCpEd3mvLzArCk
	 lIbeoL9kPRRxZtW1vb08bwe7qlPHgdv6zZv/KaJQaKW+506IehcjHCB2YhxjO3BSzUqzi
	 /SXpl8bb1Kc1Eu2XWk8wkeDPWRdcW4uAd4G4CmcM8QJFRNrKt5hZU28UcKUwqCAGUEgq7
	 eCQ9sbs7YuexC0HWh+8MePzTBF33lYZX5o+u7jm9zi03k1sCHQ6CHUmauxihQ9mSagA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ie2qmN5B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11A606A32A;
	Thu, 29 Oct 2026 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ie2qmN5B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44A71F01828;
	Thu, 29 Oct 2026 08:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793262600;
	bh=JqG+lDYltlnao/ARBbfD/u5hrXSlDYp4BgLb7g8BjiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ie2qmN5BLsWRHRXWQtNUeoQhAO7VCzoB+iQx5xm5/P85fbkbuJm/rXDVjLNABrKxZ
	 kBMbwEbhNK42ftplmQwz8KF8kijVzYVvOba72hyox1YpRZSgEvIuKyu7LkuhLnbT1q
	 7KqO5scIhOIpxNWXpoxTx0W6uHhZIH+3UUKzdDyOEwY9dP+qPz4Q7vD476UTlrZ4Jl
	 0qJ7h35eRXscAqKEZqD+4rosLdev71DwSiZ6V0eZnPbGpryg4kp1HZy1LBbIWxyNUS
	 3XUMoUuGkpxkNn6iN3Pizfx/YBi5brLizBqRS/G+U9r9SamN7T38R0EYjCxMXe3NIZ
	 xnZiXk93yMj3Q==
Date: Thu, 29 Oct 2026 09:29:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Francesco Valla <francesco@valla.it>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
	Jason Wang <jasowangio@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add spi-virtio
Message-ID: <20261029-enigmatic-honeybee-of-dignity-bee01f@quoll>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
 <20261027-spi-virtio-bindings-v2-1-67927b24b9d4@valla.it>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027-spi-virtio-bindings-v2-1-67927b24b9d4@valla.it>

On Tue, Oct 27, 2026 at 08:26:33AM +0100, Francesco Valla wrote:
> Add bindings for spi-virtio based on virtio-device, allowing proper
> validation of SPI controller nodes declared as children of virtio
> transports (e.g.: virtio-mmio). Such nodes are not used to instantiate
> devices, which are registered by the virtio transport, but to define
> their properties and establish dependencies with other nodes.
> 
> The compatible follows what the virtio framework already searches for,
> "2d" being the hexadecimal representation of the SPI controller device
> ID defined by the virtio specification [1].
> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  .../devicetree/bindings/spi/spi-virtio.yaml        | 46 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 47 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

I guess everything should go via DT tree, but Francesco, please update
the maintainers file if that's fine with Michael.

Best regards,
Krzysztof

