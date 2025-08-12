Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F427FB3C
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005348; cv=none; b=JpWadvTc8lY4m+1AYGDKgeT8JO/wgefKgsmP6pw0mqPY5vJEp8JTlINfnWulLi3fKZ9jPHD2ywkaJefAgLaIFWmRBUFYr23WC2AIE/1aY7V+yC5TWdxGWt2s1OYfgm1gnaf9A02OLsXJ4lNlbfUXuZBNfXNJCF7Aw88qmk5Dz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005348; c=relaxed/simple;
	bh=GMMGDDvmy7/b2xlgQxi4X/T90SQPEHldSBlyZttmxGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1u9hXQ+VdlHeFFMnfrRP/e+om1a2EPdwhZ9IOb3YRl9/3rTUsnmwFWRWvq+vlyGzauxyDKbeFiJgEKQaSxEQBSJNYbTUDdGqNkbKsYV9CsgQgCkZ/O61jKvd2xV7JXpL10nAcGelm10FVPe9bMGX3442qEOSCU8rWqBo7M4lV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM3yubK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM3yubK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5688DC4AF09
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 13:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755005348;
	bh=GMMGDDvmy7/b2xlgQxi4X/T90SQPEHldSBlyZttmxGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mM3yubK/lLObJpIvrrD0Z8M/KPVOdrEcMP3Igh2O1y4EMgBv7flQJ3R84zjPdpE6A
	 lkWqQ/9iYehUJCAIa4TttzatnPapFLqNzr/e5Sdc84WioG5wYYvt4GgadNPt7Mf4Me
	 VDEkGEa8N4bjYUZ2N2A4IJaX63H1355tLSbByPqnTlsn56Jh+MabZuXdN18JKRA1+f
	 MxXBBj4XtJn5OM6fqNkkuISWBjz7dYJv1W+zXA85XENNWEt5mruU92p0g46LNK0S03
	 M2qjpYk/aM24DUvmeI8h5IwOsyPPmirAU6DajST3wTrgW3xIlcanCMQZF0Wtmc22Li
	 CB8B1LrrLCfJA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so6380997a12.2
        for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 06:29:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhBmM9s8fvGb7aRPlAb9v0ogPr+z9vxaPWzrvh3qa9JZuBaTZNirPstvt6/c5yiVuVTScbQibE9g7IK/DPmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRpWjQT/fR+9UsVvKVquZbgiKJlZqqEH6jVCE6BNc4ih77VFkA
	cbYaYmjwq8eDKWksv32EH7zyud3uwEsY69Wg1dKMq5d0t9nFVe47x6GDNhxOGJfxpafvsV1u9T7
	muktzLhvenn2jAtWkzS3T5rd29Ihzuw==
X-Google-Smtp-Source: AGHT+IF7GHeMWGqSVBOM1gStPy48v5sXvDsBL4TjWEX2CXWZdGbz6C+H2e2r4/C3oWTX5oWbCwqx0GQUgijlu7ioPnk=
X-Received: by 2002:a17:907:dac:b0:af9:5da0:adde with SMTP id
 a640c23a62f3a-afa1e155119mr344130866b.45.1755005346908; Tue, 12 Aug 2025
 06:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1753865268.git.viresh.kumar@linaro.org> <CAL_JsqJn2XtvWaDBSqYPUe2ZVxE7t4EbAt8OPncbQaKjh1jY5w@mail.gmail.com>
 <20250812094955.fdyil4cbxr3bx4bo@vireshk-i7>
In-Reply-To: <20250812094955.fdyil4cbxr3bx4bo@vireshk-i7>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Aug 2025 08:28:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKHGFPF-2d-cH4KhxFQ-KA1WO+TuDn722vYbs4Jyx8iYw@mail.gmail.com>
X-Gm-Features: Ac12FXzhhmuReoPQBliN29Av2MDBr7ZwnqPE5KVpcSyLcTFZhNi2n8hmWiHskf8
Message-ID: <CAL_JsqKHGFPF-2d-cH4KhxFQ-KA1WO+TuDn722vYbs4Jyx8iYw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] virtio: Add support for Virtio message transport
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Saravana Kannan <saravanak@google.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Arnd Bergmann <arnd@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Bill Mills <bill.mills@linaro.org>, devicetree@vger.kernel.org, 
	virtualization@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>, 
	Bertrand Marquis <bertrand.marquis@arm.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:50=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rob,
>
> On 30-07-25, 08:39, Rob Herring wrote:
> > On Wed, Jul 30, 2025 at 4:29=E2=80=AFAM Viresh Kumar <viresh.kumar@lina=
ro.org> wrote:
> > > ### Memory Mapping and Reserved Memory Usage
> > >
> > > The first two patches enhance the reserved-memory subsystem to suppor=
t attaching
> > > struct device`s that do not originate from DT nodes =E2=80=94 essenti=
al for virtual or
> > > dynamically discovered devices like the FF-A or loopback buses.
> >
> > We support creating devices from reserved-memory nodes.
>
> I didn't know about this.
>
> > Just add a
> > compatible which you should do anyways because node names are not
> > supposed to be that specific or an ABI.
>
> Yeah, I already knew that the node-names thing isn't going to fly as
> you and Krzysztof rightly pointed out. I just wanted inputs from you
> guys and so did that as a first implementation to get the discussion
> started.
>
> I tried something like this now:
>
>       reserved-memory {
>         #address-cells =3D <2>;
>         #size-cells   =3D <2>;
>         ranges;
>
>         rmem@100000000 {
>           compatible =3D "restricted-dma-pool", "virtio-msg,loopback";

The order is wrong here. The 2nd one seems more specific to me. But is
"restricted-dma-pool" useful? Should an OS that only understands that
and not "virtio-msg,loopback" use it?

The format of compatibles is <vendor>,<device/block/interface> and
"virtio-msg" is not a vendor.

>           reg =3D <0x00000001 0x00000000  0x0 0x00400000>; /* 4 MiB */
>         };
>       };
>
> and this works fine. I am adding two compatibles for virtio-msg:
> "virtio-msg,loopback" and "virtio-msg,ffa". Yes I will properly
> document them in the next version.

Why do you need 2 compatibles? Can't you discover what the remote end
is with some message? We only define "virtio-mmio" in DT for example,
not that the device is a console, rng, etc.

Rob
