Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878697;
	b=v0DOMaVtbVFzTZ2eBnQtB1XglJO8s8bSVBtC41B65Q1aZqLO8byvyEufKt9pFF+YXcLB
	 7vhUJ7H8bS1DoQTr2dOSTsxm5eAJzNYeHUPCNsH9NndoRyTVyfE3awJ329l1WvTDe1dpn
	 Gxu9beG5Re+hHNcyIGPmSgM99N9fv4MkpVk+6GKDDwYVfX+v5OrtimpczgrhUVmGyHj/+
	 Gl0prOIo2CaUWaQbKeHIwn6vXjsyPLd1E98zjCgm5EAnM+GxymTF08ZA6zpPEmg/MnYnf
	 XFN4MIEG/GAMX55LpvWgHQ1vaWfoU5XO3NV1ICdT3wlY8MoCUfTh5O804AodWYnx8aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878697;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=jRo6v1yesX88h7OcyNAcfI2+Tt+WAJUB3xSN50MgUos=;
	b=DLXjQSDBkuDAfBUcLnJmcxdOLHvrr195Pa6vPzHcJU7K8X21ky5Ho4yGdgSugtYNuaSH
	 o6oGIONn2T6PQB7xJb2jcVRtRkJMGDltDr9GO6cXPoWKxYFqDs3dfvZEaMjDETSeeP562
	 baZCUl1TbpORqaalICQGXn/9E+7yDhQ7JGLC6+wfd7Xf2ecXS7hZOsXav3BNjTW3Esg1B
	 VetrGB3+KOZYPidNIyLphjvEZlgAj+KMQqE2wRA/+1WXybjuhYKAc12zYfc206zbQZK0B
	 C0QNBo+iXOo3KRsig1zz+/IpKfEeoJR46SVdyIn3GcMHsIW1HawZ4OzzR1JuSAdwlNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KhlsZn4y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C2606A32F;
	Thu,  5 Nov 2026 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KhlsZn4y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E63B1F000C1;
	Thu,  5 Nov 2026 11:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878697;
	bh=jRo6v1yesX88h7OcyNAcfI2+Tt+WAJUB3xSN50MgUos=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KhlsZn4yFevLCGBPZ+LUQkIXowVSUHj6Hlf5vx5Sdk/TD3VsG4KJVK1HUPHe9iIYh
	 FtLMqxBhPeL5wUOpWC9q4NqZ5oFUjOx6TZ+5dbMlHR82zDDytOWhWE0oVPrQ1dziSP
	 9NQw6dcIH6Lz+19ELuWGLRo9CvvkI5x93WAxPB4mE8HnsHSwWrB1Tik5cewhSQnbNx
	 Gegv7724y6vxHgg8dMCGuX4ZyhC4h2MKgaGi+NGp1KWpzoQmddvQAwYmXkdgUKq1uL
	 PHMJCKTYcecy/HAX3SrKHOu8o8GyH4jc+fhfotTlZiln2sJH3Uce3tcPz5WdZluJqz
	 ZvMqbzNGCQNhw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 421B3272E97B;
	Thu, 05 Nov 2026 11:38:15 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
 Jason Wang <jasowangio@gmail.com>, Francesco Valla <francesco@valla.it>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>
References: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>
Subject: Re: [PATCH v3 0/2] Add devicetree bindings and maintainer for
 spi-virtio
Message-Id: <179383873171.2186205.18306069236737533511.b4-ty@b4>
Date: Thu, 05 Nov 2026 00:32:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d/2HHn0oM1yVBytTovcK25fmEh8H6DrOdy6DAE4SDbU=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeZC0XVd+1debfPX+5WkI2/wlkmKnILeN3IfGbaoZby
 w23i+ksHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZjIolsM/9RX3q1o3/pvh992
 OSmH7Pa9pz2nNzJvenSA+7/kqnt8V7wY/kf+rmbslamrD32rPu1m35pqG5E5Zx/f3Vq1UXxa028
 /Kz4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 29 Oct 2026 17:27:42 +0100, Francesco Valla wrote:
> Add devicetree bindings and maintainer for spi-virtio
> 
> When a virtio transport exposes a non-discoverable bus, the devicetree
> can be used to declare its child devices (if any) and/or other
> properties. To allow for that, the virtio framework searches for a node
> with a suitable compatible in virtio_device_of_init() when registering
> a device [1]; such compatible takes the form "virtio,deviceXX", where
> XX is the hexadecimal representation of the virtio device ID as defined
> by the virtio specification.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/2] dt-bindings: spi: add spi-virtio
      https://git.kernel.org/broonie/spi/c/5e36c313bcba
[2/2] MAINTAINERS: replace spi-virtio maintainer
      https://git.kernel.org/broonie/spi/c/a64623716fa1

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

