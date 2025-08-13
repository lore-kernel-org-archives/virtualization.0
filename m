Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8CD2D46A9
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066508; cv=none; b=X75lTPbQZbtDZiDLD4vrDM88BlD1b8xSzLBFz6RlMLlj/cqk8R7HFCwl2J6F+3iiNJOb+QW+qe7OdEPiqVqNTy5XwF0QF4vuz0Rm7gmIpPBgm0EMqj6Zr974dJxXTmWqjxWyGS2wte9NmiOK/a3pbW11SyGuxrV1J/lYXlXLPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066508; c=relaxed/simple;
	bh=ruSc1og0k+neVyIZpEtyljRVj11cTbE4xBOWaKErHVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgJgrwWi17qUENUADy03GDkdjgKOuKrMo5vZIVLLUqWGC97tXWFzHzjha568Exj3bziZYdlV8in1mxhMYYPHBQL/yFGZm9t5HXIvd8vJoxwasNH7gX0lgYe/Vc5abjThX1YxBUNf7sUwd5ysmCd3/pU1Wh9zZgI3WWhkRGsnwrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a42vxY0n; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a42vxY0n"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-242d8dff9deso37962865ad.2
        for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 23:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755066506; x=1755671306; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hkkOFNG1twvUB4ikm7yQwDp0IAPOj20d67SV/lZx5C0=;
        b=a42vxY0nzhtWALz3DsuhAXEGn8kfCSuL43ZLOU8X7yOhbiYZlW3vQKXaKwaUStDzLu
         Bf+fLybmcK217ZaDdeMCW7GwazSIkyr+sy/3wLeNxq8M2v2XFWKd7QkXays1zIsigkMz
         UWapwp+1QgPxs8cJ5uQ7E936i30F72V3HkcJTgID5TMdlU8obsaXa00cq6gt//J1uUxV
         2Ts32xLfiANjSl1Sl9JE1h/aGtMI/EWQfKfizKJMtKwcGO8zjO1cjGEMeVZLknUz7Edl
         tlamg3ffTh5JkKQ334C/S5++rUuwkzXmUp9gJrLxdHDsAKnH8YNVkjV2g21Rx8Dz9fjm
         07rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755066506; x=1755671306;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkkOFNG1twvUB4ikm7yQwDp0IAPOj20d67SV/lZx5C0=;
        b=WqIeeE8HsB/v5eR5b3U/7UybuTM+dBZ6IiyTvOjfsZ9U/DoQJCmSUM+/azWiC2tDwG
         ZUux8g65DMV4z95CgvolqnKAgFX5+nyWr6m0TCTL2dDCeEWRikDG6NSXrQHTZ32ie03G
         NzBzy43Pc/ABW56feHnx2mHflhfTiO3W0ISMJJw0TZEskHWZ7qnvMlYF5MSzUQjixRNI
         vOtaQcbNIv0fsg0JX6oGLBQcYrFWSWnoV9UFWpz3i0KhpH7GnZcw0t3V8UYFrW1oxaKJ
         +IpewFLDcHGsAB2jUz1lp7kBrNMyoGs993BILx8dUIZXcQeux/y2GUprbg/Duw8/5FGJ
         tiGw==
X-Forwarded-Encrypted: i=1; AJvYcCUcuz+l2vS/uUYYrv4qaA0HIkd6TbWtIoSLeimmZ4rGJl+JZlIzm4LAd5rxn7T794Rh0yjbIKaJxY/wfvZbIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq770HwDsstORZGziq47jFCILGvXGaAlFTHxmCkQk/SqobbgsD
	Q7rg7LZSlc9XzRcBYq0W29Q/H+LJFWJ2HR3Of67p+N4eSUjW4/+G+bdRH3edemCGVwA=
X-Gm-Gg: ASbGncsS6MSr3Puxjflv4k1t8yfv1obTdRvYuHHOYIZo39qCLancTHwa8miJ41Cm3nu
	ORfaaWXqlP4TbwIYicL3ElnD/zKf2ieye05JBRVxNbIuYqFtxE3FGBssQbUCINQ0/BBy6EIFhDc
	+0hHLstFl2gfPG+pAhzdQUnPneakSfnc11mwHRUH9/nVmBc5bnq+76uzapjl1Qh+qZuQsZmkcZ9
	/d8b+Ja+QA09PbXwJfraDHZDJ46qyJ3faGJgbLuBa9hf8+F5VqDN91/pEfn2U1Au7N+tlmXzyDD
	a6CAmZz0puh3T99Q+8mzV3iZ6Z27VcT95FFzdVtJ1KVOjchMaChI/wAS6jNZvEn33P7T1nI4urW
	4dIDI4JbP4+UR0Mvt5eDTTG3k
X-Google-Smtp-Source: AGHT+IFYTVLKZy1oWyOc6hnM/pMXzM/G8sghp8UldVXVga+3t7fJRL5dFPBL8RVz5xsAnY8qYxh7aA==
X-Received: by 2002:a17:903:18e:b0:23c:7c59:c74e with SMTP id d9443c01a7336-2430cf2d4bdmr32205525ad.0.1755066506029;
        Tue, 12 Aug 2025 23:28:26 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243017dd480sm32575855ad.33.2025.08.12.23.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:28:25 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:58:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [RFC PATCH 0/6] virtio: Add support for Virtio message transport
Message-ID: <20250813062822.3rsgdx5fmefzslc2@vireshk-i7>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
 <CAL_JsqJn2XtvWaDBSqYPUe2ZVxE7t4EbAt8OPncbQaKjh1jY5w@mail.gmail.com>
 <20250812094955.fdyil4cbxr3bx4bo@vireshk-i7>
 <CAL_JsqKHGFPF-2d-cH4KhxFQ-KA1WO+TuDn722vYbs4Jyx8iYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKHGFPF-2d-cH4KhxFQ-KA1WO+TuDn722vYbs4Jyx8iYw@mail.gmail.com>

On 12-08-25, 08:28, Rob Herring wrote:
> On Tue, Aug 12, 2025 at 4:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > I tried something like this now:
> >
> >       reserved-memory {
> >         #address-cells = <2>;
> >         #size-cells   = <2>;
> >         ranges;
> >
> >         rmem@100000000 {
> >           compatible = "restricted-dma-pool", "virtio-msg,loopback";
> 
> The order is wrong here. The 2nd one seems more specific to me.

Right.

> But is "restricted-dma-pool" useful?

I need this to call kernel/dma/swiotlb.c: rmem_swiotlb_setup(), which
makes all the memory allocation for the device happen from that area.

> Should an OS that only understands that and not
> "virtio-msg,loopback" use it?

Since the reserved memory isn't linked to a device in the DT (via the
"memory-region" property), I don't expect an OS to use it without
virtio-msg.

> The format of compatibles is <vendor>,<device/block/interface> and
> "virtio-msg" is not a vendor.

"virtio,msg" is fine then I guess ? Just like "virtio,mmio".

> >           reg = <0x00000001 0x00000000  0x0 0x00400000>; /* 4 MiB */
> >         };
> >       };
> >
> > and this works fine. I am adding two compatibles for virtio-msg:
> > "virtio-msg,loopback" and "virtio-msg,ffa". Yes I will properly
> > document them in the next version.
> 
> Why do you need 2 compatibles? Can't you discover what the remote end
> is with some message? We only define "virtio-mmio" in DT for example,
> not that the device is a console, rng, etc.

In case of virtio-mmio, the reg-range is trapped by the other side and
meaningful MMIO messages are exchanged. And so the OS knows the kind
of device the DT node is related to.

In this case however, this memory is going to be used for virtqueues
and buffers and I don't see a way of communicating the device type
here. Maybe I can get rid of two compatibles and add a property that
links to a device type ? The memory is otherwise exactly same in both
the cases, it is just about which device is using it eventually.

-- 
viresh
