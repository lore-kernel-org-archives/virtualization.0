Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271235;
	b=nwZg59mCCQYC9JiwXvUo9NNW2bzxLwhjk4aXt+QTg/nNvahg7FJU9HxsSXsiRYrpoBrr
	 sdU9eiuai9qWy0zbuX7qEVl+TXGeWjo4ZHIMdAQ9i68HhRyObXPmzuCHj6myjRxEH0WAW
	 YbG2WkVZo+n2wo2H74MoG8T1b/ywJjt9ymoDSaxxj0Ww5kpsc7ePcqvlxFuIAApP79aQk
	 rAA6SEBC3UCGy2ME/iZZe1iEtur8ioZ/qduzHkmwdJgjrwe8WTuiSFDGcrgKHifGzemK8
	 iOjpIfdeL9I4Abrs5p87QzP9WMmVCzNDVNZc04nTMZ0LdhCVGTV0zvAqVbObz4aEAuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271235;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=65gOLGKNSzKKaUZM7WsX+Cz3ZVYsko2nYRWUmyLDTv4=;
	b=JFTx35ytK34g5oxyCB2oSTO5OeuFpdzlqg3avgteAxcLp+MiU8O5Ui3p9CPFy48j/lBM
	 UhM2f2b+pQKGQEikddyt3linEm7oyPc7/l9TMW89OUulitykrwF62DcXzBzG5N6Za5ox3
	 7rF9oqZpvMkNExdQfxaqYfmtYKaHaSscvfiWQuRTjubFpyCLQHbVmr6m+s+EnIJfLF1aT
	 xHoPRXL4hIM63xLlzp2ayUbwPelpy/aGYqzeyjQh1I0uDzIbuVFgtJDDMSCX3Unej+tIJ
	 m3tQaAM2NHc0GekVDDZrfeY2R6zx2uPMUkXjX6R6mdO+kUmAP1V27yVBfgJXfkhqF5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmAM52+O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFED606A31C;
	Thu, 29 Oct 2026 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmAM52+O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D341F01825;
	Thu, 29 Oct 2026 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793271235;
	bh=65gOLGKNSzKKaUZM7WsX+Cz3ZVYsko2nYRWUmyLDTv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nmAM52+O+/DQvV6qkfMbnKqpeCbeloN1B45BYEcdPqP7r9ogRIwIyh9HC2n4g9Ee5
	 yPguFhqMfcBmrxl8dw7Jg/gvwVDhauqd5rbALrjOwJIcaJWrxSnCLYgk5YSmjDxz8k
	 aTi1RJIJ7d3c8lYZ4n2YeWBvXg+mQZhRDVb+ci8r6l1guuDZPc0isEef1eAv5rr3cp
	 hhb1lB5OrfW18sjIwrVLRvxgyr86gyaJnTcRNc6ZKeCYXAys0ee9ecKSYl7/nEhfuc
	 q4Z+Z8yE1HsJGaLXyfc5xYsKiUgnvFQEfTgBNASSokl+KIx5DHn0yxBYo/3THswq1g
	 Xrd1j4oukU63g==
Date: Thu, 29 Oct 2026 10:53:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Valla <francesco@valla.it>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Jason Wang <jasowangio@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add spi-virtio
Message-ID: <1449d4cf-9e9d-4fe4-a904-15d51ba9448d@sirena.org.uk>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
 <20261027-spi-virtio-bindings-v2-1-67927b24b9d4@valla.it>
 <20261029-enigmatic-honeybee-of-dignity-bee01f@quoll>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xh4GpOXgVUQqvuT8"
Content-Disposition: inline
In-Reply-To: <20261029-enigmatic-honeybee-of-dignity-bee01f@quoll>
X-Cookie: I have a TINY BOWL in my HEAD


--xh4GpOXgVUQqvuT8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2026 at 09:29:56AM +0100, Krzysztof Kozlowski wrote:

> I guess everything should go via DT tree, but Francesco, please update
> the maintainers file if that's fine with Michael.

I'd been expecting to pull it into spi since that's where the driver is.

--xh4GpOXgVUQqvuT8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrjJbwACgkQJNaLcl1U
h9Bl+Af/SRb9q/27ELXx9ZEZ40ZQK8PgoXa2g2rWIlRdsiD/UePNNfSG/AijrSds
fZg9z/sbyOZ8mkW3F6Ud/Vy/bom/GOhmCGGVqdwBQ/NfcGnqh6tB139C5TyoQI7N
q7mpYVj7cDX6tlf1sk4JbYh64e+QiWuUZusup3yuwaAl4eNrXZaOQJIAIuZZXQTJ
kfha8B3SwBio6kWELiBvtbS6lYcMZ8iBvd0fautLZkdBWKLkbgEwgkSmC0lPttSz
i5iNWEk++Qed8g4VCkMXxMBrqQ118tPQcj7oX5LEFR/Er/TJMw8WVj4yEqB5zLYe
IcUgvpqYfwriH96isKQQZbdAs0K6HQ==
=5bhi
-----END PGP SIGNATURE-----

--xh4GpOXgVUQqvuT8--
