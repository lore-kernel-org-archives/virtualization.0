Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333327;
	b=zvbqheYqkx5dGA/Pnm3kAeKIw4faPjfsYlTxHKtQaAHTeTRP9OtkzEeU6QWIPI2HSiAY
	 /p9iah+PqjfsDEqK7iAkTtt3cYjalLtsPmpGwd9Ogrd8t5Fa0q4QTAVzpl+BhVIADyoXD
	 XCE/FO0cq4Qx9iQC+gMbxxYnspMVIZZQMr+H6FmpDfbnFHbU9WGq7o5Y/ptDpeD+XgZto
	 8q9UOcVsk31pmz9oPLyi1VrwAV7+dkG6iOBRDfa0GR8i25dHvUm22yhE8ODtFz2BD5A5d
	 ozIGstp/159TcHDEuekItTQzDMety9M5qdyqww6dxJ0KXsitLiYDSqzxrYkz7yrRslw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2oyZPxVsUGR3lEqjPv6CqcgMqDvTEtbVpGv2X19Zzdk=;
	b=1m/y754JcnoGmfw4g9+jbmIgMpqDOH/S1AN7mys6Is3MyCRHfx3X1kZVX82qUPE4d/yv
	 scdtrq3RWYovr++eX7dWytYG6OGMXcz5dDNhgRpF58DED00a822pBrwjF30BeGkMU5gO6
	 OWxXbTYL6Pg/i5G1GEewU5NT9e6GaSmzhk2oCw8GIfnAcx08gMnrGYJ50A2fqjqVmdnSa
	 Cf+klnmE3NYHDYbSKNVLIrw8bgFfGDtL6bp3Eu842dCLosoggZqB3LplMvtmYFfccjXYh
	 aSh2PtEZRJ9KovSL5H3qczymeDDqjojRKPhK9KZgCdbcHp2HT4QMtdiYEGHT7hobDAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UHjwAxwL;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569F606A31E
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 04:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5569F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UHjwAxwL
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a18fc7a38so840548eec.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793333326; x=1793938126; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2oyZPxVsUGR3lEqjPv6CqcgMqDvTEtbVpGv2X19Zzdk=;
        b=UHjwAxwL31dWLYE3WZj0ZHHcSE+cwJz8O/Fs2T13ivjmvgsb2IgZr3/wTjLB+79C9P
         Kw9u1OaLMhur9JEeXAThJTrJ6SUuoocl+6Kh8Y/c4lwKjvlHRWhD5VW7xoaDUix8fT+n
         2sU/5epdzoJKrdioa8KncAECdAEKZc//tksLbejo/vjGMgrrInYP2HIWBWEn1wP9mxZc
         i5YzFobYv/Clj1VOvT+EPZ59lQLbi194tT9D7DkSB3wgIfWgz3qcaJEm8A7iz2nbNg6m
         fE2UFjA/2wS4FtLY5YQ3+NNedqSjtRwWZbBGLwnrnHHg+XI/efrP/3+s4l22RsXeNRx2
         HlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333326; x=1793938126;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2oyZPxVsUGR3lEqjPv6CqcgMqDvTEtbVpGv2X19Zzdk=;
        b=ihzxLQbFiqqf1lwfGUVp4FL+IePbc1Ki1c8OSZtYCr1MkMdPcryR+FdKFEzdtDj1qp
         lIQhJCmMpXbO1fYuBg+sGt0yyhvWcIjJV9/HSbP4EBEQ0KmzSdgo9fWAXAT79arvWs6e
         P9MV31FNtfNBKXPNwv0GzlM0edO2nAt6NvOttwUTd9vZYtOoz5sB68LWjQhwwlcLT6cM
         E0USdKKQraJK3IgJg9uZSv17S1sy3/dRsuei4Ev7s7ku3BSwi5RcLhLZxqi6BEdAK1TZ
         pVlym6QQD1YfbuTKi3ra2v6VyaqHT/htzKfdlAlA5cV7LWa/Zk8DFqqVECc4KzWlF7Lx
         AdzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBFl0oz6MhU97JE+LHY2L6o5pcussARzImS3ODG21ieL1wMDnabnHVpVLd5v6JjarHK9RHCSx2W0nWEKGFIA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIuMX56+ATBjNVb5957lh0DBaABzI66X90Vk84DCdpIu3UyDQ9d
	VRtrkwMIqTgodAbyutlnvfw2HpBStFfCkS4rv41pGFD01XVmXqL/Kz5OEkQeTbaC4k0=
X-Gm-Gg: AYBFou3pUNmXHX+vmbf34GXA3jBRRmvZKBsdfVVYw/5M4+0ecdik/cf9ICZ+yHd4Y1i
	6O89eJlglO6kfQ2fBtGe/yE5qP7hynKulZVFcdiOpR0z4UtXPYYoWFcrl/MKNaWJy10cfwmWmfs
	YoWr7t6W8JGnmAYvGKWxzx49C1rqHa0draecCFw4V04sbWkLWYO+iFtwdMf7OpeygS0Db6BgDnf
	UZypATMTuLsVLdaAGDzTZqSFxqhXvNn44HY1M9pprrve4IlxLfti5eln1gaG9sRK2PFLjqaYhb7
	9aSmxh6oxfiZoxmqwVMKfby8gjOhnI2NzwuHt+EvW3c2Vb6grYR53tehOJG1qBEOsWOUzX0WfE1
	HbQHH1LU8AIJgUTpDtEnaPYEA1xGUCB7/a2DCusmNjFDI3tRrUCW01REfIK5UbrstMsQf3ANxj4
	UdM0/c3pZaMT939nnEIeTc7MarsiyKuxfhCRcEYKnBsEE0piBLsqYmQ+99hjkUaCNSaLXDPk42+
	fAz6qCVw0VjO8Dnb3xiByZC1ZkZDOGU8ChTAnpuKCcP46FLWwZRsFUGwTjSZiLa/YKEmYdjs/3o
	CmyQDywL/f/IRs4MkslKieNil3i282Tc6LtDo0MpRN79eoZFS0MA
X-Received: by 2002:a05:7300:a9f:b0:369:fb01:2eb7 with SMTP id 5a478bee46e88-36a4235f45emr1732875eec.13.1793333326139;
        Thu, 29 Oct 2026 21:08:46 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af91bsm3272988eec.8.2026.10.29.21.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:08:45 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:38:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/2] Add devicetree bindings and maintainer for
 spi-virtio
Message-ID: <auQYSv2ad5WJSHdI@vireshk-B250M-D3H>
References: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>
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
In-Reply-To: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>

On 29-10-26, 17:27, Francesco Valla wrote:
> When a virtio transport exposes a non-discoverable bus, the devicetree
> can be used to declare its child devices (if any) and/or other
> properties. To allow for that, the virtio framework searches for a node
> with a suitable compatible in virtio_device_of_init() when registering
> a device [1]; such compatible takes the form "virtio,deviceXX", where
> XX is the hexadecimal representation of the virtio device ID as defined
> by the virtio specification.
> 
> This patchset thus does not introduce a new functionality, but allows
> proper validation of nodes tied to spi-virtio devices, aligning SPI to
> what is already being done for e.g. I2C and GPIO virtio devices.
> It was sent initially as part of a different patchset [2], but since it
> complements a functionality that is de-facto already there and is useful
> beyond that specific use case it was sent separately (also following the
> maintainer's feedback there to separate it from remoteproc-specific
> changes).
> 
> This was tested both with virtio-mmio using qemu-system-aarch64 and with
> remoteproc-virtio with a Zephyr backend (with relevant remoteproc-virtio
> parts still not upstreamed - see [2]).
> 
> On top of that, I added myself as maintainer for the spi-virtio driver,
> since the former maintainer's e-mail bounces back and its owner (Haixu
> Cui) did not update it after changing employment.
> 
> Thank you!
> 
> Regards,
> Francesco
> 
> [1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
> [2] https://lore.kernel.org/linux-remoteproc/20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it/
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
> Changes in v3:
> - Add Francesco as Maintainer of the spi-virtio driver (instead of
>   Reviewer) as replacement for the former maintainer (Haixu Cui).
> - Link to v2: https://patch.msgid.link/20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
