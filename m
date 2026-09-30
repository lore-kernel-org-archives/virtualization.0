Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E34CB8AB;
	Wed, 30 Sep 2026 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769524; cv=none; b=p7xoNBFQyd1eq8YBnJlgNzckv3KGw3kOV3SFdxZTUWSwqslP25jLJM92axLbH4/Adz7fNOR3eHNZUIZ+eo6Z2qcLrg+E73vJzWu+n1JgHgoo3vVvD9PHzwVTjtOcfa1l2ZQ5LTu3uChAqE73GRaEfio10CYU9tIJpHsAAlMF+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769524; c=relaxed/simple;
	bh=cNHKABu4dfKiAXfDD4ulkUo2uiuNccW3YYQ0BgT66C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrkCzI8K7kUQWbYbzUYrAdxuRNYxelnBKd/65U076jjWeNypsIZe46i9Z1wDsJCQSVfsLYN93V1amDxQ/VszEqr3Bpa5+G6HsFIV4rUaaZQwLwbYwKjakEhefnfZ510YFJ9fPmshXo/k/yB4Nf9PZieZL2z+Lmyw2dNXhrkr63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1McMJ3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1McMJ3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCB21F000FF;
	Wed, 30 Sep 2026 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769522;
	bh=cNHKABu4dfKiAXfDD4ulkUo2uiuNccW3YYQ0BgT66C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c1McMJ3WoLDcWc+Vj/LC/n2ONT541e0if/xXIZGq0cJfxywU1YxsBi4p6ZCnur2yM
	 oXFFKyY2PItMx4ONpKAAQvoWuP8GbVtg0g0kxHRKhPrDI4MbZUyBbKIeYriXWdAcV/
	 AUu9ZvRAyDrlDFM1Qvm4p0cH9KsGvnvekh2Y75b/M2CFKT0b9tJ62Mp5mDMs19zbFT
	 q5qD7HjLJKADAtltY0zVk5/nncprrVd0G/Y3pMCtYkeq297C2dMna+yqnSlwPRiRpT
	 vaf4/pZoV8oYkwg0nsulBqbOAb4+Q7gIF0G6zD8jA/k7UnKU8Kn24H9no5FYNbMgZT
	 OixUoRDAJ/Xow==
Date: Wed, 30 Sep 2026 13:58:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Francesco Valla <francesco@valla.it>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
	Jason Wang <jasowangio@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH 0/2] Add devicetree bindings for spi-virtio
Message-ID: <20260930-neon-automatic-rooster-e2eec5@quoll>
References: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>

On Tue, Sep 29, 2026 at 06:41:54PM +0200, Francesco Valla wrote:
> Add bindings for spi-virtio, like the ones that already exists for
> gpio-virtio and i2c-virtio. A node using these would not be used to
> probe the device, which is registered by the virtio transport
> (e.g.: virtio-mmio) but to declare properties and/or child nodes.

Keep proper versioning of your work and DO NOT IGNORE previous
discussions. This was discussed before, no?

https://lore.kernel.org/all/20260916-remoteproc_virtio_map-v1-7-dac8c5eb4aa9@valla.it/

b4 solves the first problem for you.

Best regards,
Krzysztof

