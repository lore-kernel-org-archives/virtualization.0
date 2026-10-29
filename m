Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262364;
	b=S6i1Yf9zYeKC6MLu/wmOr5d1BVVy0oEif436nNh1+M9enYz2zP6vArUrueXxGOsFLO/K
	 jQOxoB0NZjRKuA3XwFQcv4u7K280IXRS2oBNrgBPADxJq+PywJrl6ncb4JKibv8N4GgVL
	 7nmy/pDboOIdNKDBKWtky6tcMkV4C8+L2vq7qSCya71WX4/f0pllxMIilDV0bghxwvP0c
	 jApaVgRZuP3Gx4v9WPIEd3R2ZBbBiUwQrk8/G94uS8j3rKhSK9+Afq7gTaxEp9YUkVuG6
	 nNlKJXdfnM75MZ0dOGO/I7NPWnWu3U2RvFhPUsdJPUigeM1+8TkN6vJMkfTgykbQNVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262364;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mZ6x+n/V07u5Ag7osmam8sMkmN40/qQMcxBAZTPA0VQ=;
	b=tAVqyYdfcnEnyyAVQweJnMuHByQGCNlbsEEiHwyd/7rxGGAZKgciZLnWyjzk/u5BUO4P
	 JBZytI5tHMcdwfNNGq0LrBNc8+0nPyqQ4mvEBJqAWxgWIFyAUkPF2Tbf/BT1H9K+GWSp4
	 EiZLpJWgXrSqWCxjWSeUggQId0bmxEtjDzX3TBZpQZIPMbi3f0EUqFqHlxIWmbevGdBae
	 ibeRVSIE9C9pow3zg2EgIDAkPXH/4k6K9wE5cHRK+B920+Bq2zoK1u1kfFVqGbS15ahWt
	 SD4JivRNwlNG1Nne4mfzMahmwWl4fsZk6nE9NrSk1TEPC7GUugX7rGoZPAE5d32QSSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9n9eG73;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C381606A31A;
	Thu, 29 Oct 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9n9eG73
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2653D1F01829;
	Thu, 29 Oct 2026 08:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793262364;
	bh=mZ6x+n/V07u5Ag7osmam8sMkmN40/qQMcxBAZTPA0VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z9n9eG73NF6tj5M0jpSTYABgAtvh/UYjzVr1km9aObaCC4I9Sk/e083uhbgNCb5AN
	 UsAIG602t8CStb+VK9G/kfRuMYWthXT/LokI7T90DVocZzt9C+HsgfEcawPeCtN/V3
	 i9cVgtmDfIFyNXUDfFx6u8Wequt2eY0WM58Q700hD0TjYtK347JIVSnnneSs3ycvUp
	 NTLOU2g8B9mr12mL79OnyBcNGyQ/0DNbSUHtnalBAfHbU3VG+jCZMAo+/kDk/KkKPF
	 Ms1w4UzE0pw6v65kOVdkbtbFBDQFa2L2SOLPwUWqNKzsHn7WLQrHSiLtH1FYYdO9c7
	 LU6FyYzfDaDPQ==
Date: Thu, 29 Oct 2026 09:26:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Francesco Valla <francesco@valla.it>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
	Jason Wang <jasowangio@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 2/2] MAINTAINERS: add Francesco as spi-virtio reviewer
Message-ID: <20261029-lucky-vanilla-spider-f9cefd@quoll>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
 <20261027-spi-virtio-bindings-v2-2-67927b24b9d4@valla.it>
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
In-Reply-To: <20261027-spi-virtio-bindings-v2-2-67927b24b9d4@valla.it>

On Tue, Oct 27, 2026 at 08:26:34AM +0100, Francesco Valla wrote:
> Add myself as reviewer for spi-virtio, following the introduction of the
> devicetree bindings for it.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5724645bf703..45a29ad08096 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29673,6 +29673,7 @@ F:	sound/virtio/*
>  
>  VIRTIO SPI DRIVER
>  M:	Haixu Cui <quic_haixcui@quicinc.com>

Please drop this email with reasoning:
Email bounces and maintainer did not update it after changing
employerment.

Best regards,
Krzysztof

