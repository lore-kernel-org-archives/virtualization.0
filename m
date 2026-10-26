Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052423;
	b=U/I4+vS7ik1tnhm0Sh37dn89Bkn6qxspCjqykg6n2vgW81d9MmNn9tjzibw2+Y04dax+
	 mi7RwsODvXYP5Eaqs+TKUvhDx6aInXT4IH2IE0pfRxi9vBbgr+pdBAkyRCe1b+ss48Lpp
	 ulmNiX0nK5wp0p/tAgbNymw9228SBVfkxCbfP5R07Swc+xXK3e5JrBS6k0wlJIvdQoBFP
	 XE2fPeaq4qdOFT2wTO5pZY7eZv8QEvzZQLg9aLlPjNfznYCiGmB/x/OMo86xf5pKgRQMf
	 zFddnBkRRUrxDv/2UdELtUIphChcug4S5GXuCmNjEa1cbg/i644lMtv4w2ung62lP/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052423;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iMoY1bhATOkV6/qdTLBe/XQQ1QFQE7+t4e7GpS+4QRQ=;
	b=LSnSZ9+yFvzt5SgSpis13uQmmRdvSNR+yYYPKUSCeDYsC79pPR1fGPSmKot9d930BEH7
	 kIcf4N1+Uul24Xu6ccW6j+Npd8frwV30wCmVnvw0CGL0ayQb9K86mAnOXaYEUa58CL1b1
	 maknkDvGovpq9b6s8MeP+yGvPjbFWFPfE4og6FGDHDRt655l3ceoBkO1/4XAXeTV+1k8I
	 cjAJVlqWgJW9stnFgf/yeHBuDMOMHlDqEfymJfXbOQnae6v2+5xYhpfaa9FRyd4HZSf3a
	 +i2waEPiWHAEMj8H5Jzap+Ez659vuGb0suOnLXZbfRqQY/6OQozbUkaUt0Ca84q/vVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M789tOoG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F962606A31A;
	Mon, 26 Oct 2026 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M789tOoG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49CB1F01825;
	Mon, 26 Oct 2026 22:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793052423;
	bh=iMoY1bhATOkV6/qdTLBe/XQQ1QFQE7+t4e7GpS+4QRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M789tOoGnX0+ozMdGj28v+IlM7S8xfX3xNFyeAHTz8Y2SJQmo3NOWNLXx5RcOR7VP
	 EPkhtCK/tzDi4Z1t4NrS4VJm/m4SZ9UPJL8JxbpfZdi/D92gWbQ6aHiKQJiLEdmbEZ
	 MOODUiqo4OAX1GrC7kyNyjsEHYqCbFlxPUtz9ADHG8u1ie4swNwSUyCcth1DNrxs92
	 OkBKVdyyivn7jtCNufTAaqUeiqw6tHy+/7RkvWaZReEuiIrBWxBiEGgaVLfXmB9l3d
	 bv634dgog++/8KKJ5D2ewiGl++MTURp8+pwTDt1/T7YzQyNL2PNp2d80fZ5tjNsGqT
	 cWZKvR7qgq0Yg==
Date: Mon, 26 Oct 2026 17:07:00 -0500
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
Message-ID: <20261026220700.GB3933778-robh@kernel.org>
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

Also drop 'bindings for ' in the subject. No need to say bindings twice.

Rob
