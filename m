Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262124;
	b=Z8EXXVPW1jtsG4w7wIVGq0f9zlqWFzzkDm9YCZ2iuTo7lh+ologNY3xmlhmemy809Vgq
	 hH+MH2CMJ5T3aDRhPbM/C8bIXyA1XU1tqjiMkINXxNApu+Db0R5H7rKyHhFKa4LlqV17W
	 gmGLLPpUo8eIcovYRS8xJWWA6DoogaqopsAFBXkcwjN9Yp0FmkKuAu/lZj6Sie/UdABvg
	 jRDhYtWnzwwTKY1HbF8ihgRDk7tKbAByB1U1pEiML14Iet38cQYwHd9zppiDAE98ACDsT
	 tw2vHNpOMCG4C4Zcp8pcT6LGv8ARZ5FBqn1LoC3gkHoUyWICqghIutPYxyh8gC7t4rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262124;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=80L/74JJpPjW2XTYPhSHYPvDLWJV+C0FOX8YWdWl3VY=;
	b=QXUDpEtQkTYetpx3UybLgMn0UZ2Oq/flYcfpeur5La4+Z1Had7Uda9NdQSM3pP5WZ7Pr
	 sMOxtfmoUOglY7ddUFVxKVyjQQvN1a9yas97vYVs6VGiGgeC15wNH9oJf6KdL4yrrUQ8J
	 70IklNFxUKIX32mux+W85Ed63AAQq9CbmCiz3M32tEYp+nmUuRn2LlEg9jjZbXp3PACUe
	 gnqMYkOByoHqBDAwKApM3ebTj4ci2ewJ+yeyAMqwB1zAhcBkmxVwO5ePARhAfMzQDfM97
	 PEsqaelK05b8hM8CKzJrL9j1Z5U5HC0uwRn/yCqyOI23hkv6JlLyL4vGl2ylah4gkyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgg6EkpC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DAC606A31E;
	Thu, 29 Oct 2026 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgg6EkpC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A66A1F01825;
	Thu, 29 Oct 2026 08:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793262123;
	bh=80L/74JJpPjW2XTYPhSHYPvDLWJV+C0FOX8YWdWl3VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kgg6EkpCOw1a0M5b1a4gnTAoNqkEBhSPHrJkWnEE31zB+qbdnRJUPGqPU2IHclOYs
	 /iKnDpozrVErI0BtUvTv+5wdEBo3QDHNdcr93K2cH8ywWIBr5Z6E/KLfrG4+FLN9Kd
	 iT7QgZQGKucikrZadiklQm2y0PBrHtZeS1Pv9yf2mRf4+WvwRZAMS6RK28oHMvIAWL
	 6qfaZRci8S2vQL3elRejIZG8N6sZB37U9Bfblv4mkS6PiJ1C51OQJUOn4kCt/aQotp
	 TYQWpp55gdvKs5E0YGdZIbppDtNy8J0E8hH+DMyGoxZseeuyyr61q4u+P5b8FYbzlm
	 mdLcsWPpHToKw==
Date: Thu, 29 Oct 2026 09:21:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Francesco Valla <francesco@valla.it>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
	Jason Wang <jasowangio@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Add devicetree bindings for spi-virtio
Message-ID: <20261029-tactful-able-moose-e61a2d@quoll>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
 <20261027065001-mutt-send-email-mst@kernel.org>
 <auCb8_ROuyXdTkQ4@bywater>
 <20261027090324-mutt-send-email-mst@kernel.org>
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
In-Reply-To: <20261027090324-mutt-send-email-mst@kernel.org>

On Tue, Oct 27, 2026 at 09:07:47AM -0400, Michael S. Tsirkin wrote:
> On Tue, Oct 27, 2026 at 01:46:35PM +0100, Francesco Valla wrote:
> > Hello Michael,
> > 
> > On Tue, Oct 27, 2026 at 06:50:51AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Oct 27, 2026 at 08:26:32AM +0100, Francesco Valla wrote:
> > > > When a virtio transport exposes a non-discoverable bus, the devicetree
> > > > can be used to declare its child devices (if any) and/or other
> > > > properties. To allow for that, the virtio framework searches for a node
> > > > with a suitable compatible in virtio_device_of_init() when registering
> > > > a device [1]; such compatible takes the form "virtio,deviceXX", where
> > > > XX is the hexadecimal representation of the virtio device ID as defined
> > > > by the virtio specification.
> > > > 
> > > > This patchset thus does not introduce a new functionality, but allows
> > > > proper validation of nodes tied to spi-virtio devices, aligning SPI to
> > > > what is already being done for e.g. I2C and GPIO virtio devices.
> > > > It was sent initially as part of a different patchset [2], but since it
> > > > complements a functionality that is de-facto already there and is useful
> > > > beyond that specific use case it was sent separately (also following the
> > > > maintainer's feedback there to separate it from remoteproc-specific
> > > > changes).
> > > > 
> > > > This was tested both with virtio-mmio using qemu-system-aarch64 and with
> > > > remoteproc-virtio with a Zephyr backend (with relevant remoteproc-virtio
> > > > parts still not not upstreamed - see [2]).
> > > > 
> > > > I added myself as reviewer for the spi-virtio driver to be CC'd on any
> > > > patch involving the new bindings.
> > > > 
> > > > Thank you!
> > > > 
> > > > Regards,
> > > > Francesco
> > > > 
> > > > [1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
> > > > [2] https://lore.kernel.org/linux-remoteproc/20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it/
> > > > 
> > > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > > ---
> > > 
> > > I hope this can be merged through the devicetree maintainers,
> > > I have no idea.
> > > MAINTAINERS changes needs an ack from existing maintainers, of
> > > course.
> > > 
> > 
> > This might prove... difficult. My e-mails to the maintainer (Haixu Cui
> > @quicinc.com) continue to be bounced back by the Qualcomm postmaster
> > with a RecipientNotFound error. Maybe someone from Qualcomm can give me
> > a lead on how to contact them?
> 
> Indeed, so it did for me.  Oh that's no good at all.
> 
> Mark, what's your take? The maintainer is MIA but we have a volunteer
> maintainer here.
> 
> As far as I'm concerned
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

All @quicinc.com emails stopped working long time ago and Qualcomm
engineers were asked to update their emails. Most did the update, so if
nothing happened here, let's make it orphaned and then Francesco can
take it over.

Best regards,
Krzysztof

