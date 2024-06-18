Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7873139D1C
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705762; cv=none; b=dn2zLdzf8O6j5Dx7VvHgkFWCD3nNaXcdjFc+Fyo346zaMHOSWlINVxNsJlYQN84NTB9QObJcez4hCxtMCZFP/14G3xTtIBhmpgYSgo5vCRcouzI6EGRWnWpALVlaByrWk8cDu/Q9IWxB3quU4Of9eovxlBgCu0sho2qTKDEuu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705762; c=relaxed/simple;
	bh=IWI1/gErKixxkSyleMnBYEpMm4YM44hgKYTVKo1FDy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGIZTw+c8vkUZskUB4ZtwF1KCJhZEtK5i3AyAtNJfM9qW1e1MimosiRcy4YxNoORKOgxNW5K8YBHmDzTJ1zmpUqTV/fSHxVDrl+nHoQKIefBcMAie2q7lMAEbjJuQnLoFwAwS0npeZthTaj9kFVHTlSpdPVKc46HpzJiWSQqqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp; spf=pass smtp.mailfrom=igel.co.jp; dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b=pzurXy9I; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b="pzurXy9I"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-80ba70d19ddso1504837241.0
        for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 03:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1718705759; x=1719310559; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3LOMCtLpMbNherLX4YW/2xA56OUEssgJ1MFSd811k8=;
        b=pzurXy9IH2oU2xVoyRyGqXZ9mz5HJ9BrCrFbvdVczSV6Hldglos86KVaOraB26RIia
         s+h/27+v3tvinz6//duq1F+bMxcbF6ps1kIInoEOKz8ou5O0OP/ULdWUCrBwGisk8wcN
         OmFQ2hJA2BgI607/X39qs6IT7UZLL7RW0KZ6hpALUoDQBMYZA7Nz8GxLDCVKilY27B+n
         7ThaaY+6pQNjsOT785d6nr5i1FwCfqaXotn7p3pecbtabFDXCf90yrT1TFeKBYV82Gob
         DZRKRPyMNKHtvUxbh6Pi3eBpXHWHLSWNQWQdPp/ROT4OYdUzKoNyC5367UB3FSgXb62D
         nNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718705759; x=1719310559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3LOMCtLpMbNherLX4YW/2xA56OUEssgJ1MFSd811k8=;
        b=kcDO5cHGQE0hYh8YS3Tbgrvgn9oL4zhfgVBkT8tMZDQ+A5NtHf0smC66AwUKOmTYYK
         alffVmDmv6zusdeg/uv5i5/bYK4bHeKvoYZIYyfyDAao12POlpvB8/IoxDDn+iuvby14
         nGddZwF3bMFTg2ZNLEPtEIteLDAjJ4sdvnBjs4uFjbZgzuSjETNdVXz1T1nLNGFFUvEJ
         Z08oRmKRTbk2zNQogetFgbVbfeElJagBF1bkpHSewVr7UFKDyEvDmcXThB1Y3OcwbrKo
         Z3//4h6Sx018NnNP8fQ5FHWJCLuFiCvOJFlJ/APZx7Ny3BPHbXz2g9peDUykaqGdLqSA
         w9nw==
X-Forwarded-Encrypted: i=1; AJvYcCVf+5eKot366n+Ac5Zt7eF2/oRHH/Xgd2S68xf7Vgq3ija1sQTrpYBvmr/U3aw3KHOnY7mXHKVXlS48pb+Fxlo3EIg6GjO6baglcAKvEYo=
X-Gm-Message-State: AOJu0YwDbgtnDAHb3fG8/mTWXg/Ulb/K54OCJyxAi0x+YsSgJcyHeGQH
	hcfUW/+S2SV30HyUSB3CrH6Sm9/pM4lBUq4Uk/qLaFmxysghRrHfcWp+2sCCydc88fHz9nYwcvD
	wpXVuC49QaNmzppfxoJKiYCrgPTVIwz8piScOyQ==
X-Google-Smtp-Source: AGHT+IFkJ/pD+ISGILYFwr6riCYtrMBf32g3buhtG0hhCxedeL4Kng+9i0tizqFF6jZj29y2dCeyUo1H7mYktyPXVQQ=
X-Received: by 2002:a05:6102:1247:b0:48c:3475:da33 with SMTP id
 ada2fe7eead31-48dae2e18a1mr10832551137.7.1718705758660; Tue, 18 Jun 2024
 03:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad> <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad> <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240618054115-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 18 Jun 2024 19:15:47 +0900
Message-ID: <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your response.

2024=E5=B9=B46=E6=9C=8818=E6=97=A5(=E7=81=AB) 18:47 Michael S. Tsirkin <mst=
@redhat.com>:
>
> On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > Let's clarify the situation.
> >
> > The Virtio device and driver are not working properly due to a
> > combination of the following reasons:
> >
> > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > Physical DMAC to be used.
> > - This feature is not available in the legacy spec.
>
> ... because legacy drivers don't set it
>
> > 2. Regarding Virtio PCIe Capability:
> > - The modern spec requires Virtio PCIe Capability.
>
> It's a PCI capability actually. People have been asking
> about option to make it a pcie extended capability,
> but no one did the spec, qemu and driver work, yet.
>
> > - In some environments, Virtio PCIe Capability cannot be provided.
>
> why not?
PCIe Endpoint Controller chips are available from several vendors and allow
software to describe the behavior of PCIe Endpoint functions. However, they
offer only limited functionality. Specifically, while PCIe bus communicatio=
n is
programmable, PCIe Capabilities are fixed and cannot be made to show as
virtio's.
> > Ideas to solve this problem:
> > 1. Introduce an ACCESS_PLATFORM-like flag in the legacy spec:
> > There are some unused bits, but it may be difficult to make changes to
> > the legacy spec at this stage.
>
> seems pointless - if you can not change the driver then it won't
> negotiate ACCESS_PLATFORM. if you can change the driver then
> use 1.0 interface, please.
The original idea was to provide an endpoint function that could use a virt=
io
driver as is using the programmable pcie endpoint controller.
> > 2. Mani's Idea:
> > I think it is best to add support for modern virtio PCI device to make
> > use of IOMMU. Legacy devices can continue to use physical address.
> >
> > The meaning of "Legacy devices can continue to use physical address"
> > is not fully understood. @mani Could you explain more?
>
> I don't know how this is different from 3.
My understanding was wrong. They were the same.
> > 3. Wait until the HW supports the modern spec:
> > This depends on the chip vendor.
>
> Adding ACCESS_PLATFORM hacks would also depend on the chip vendor.
>
> > Option 3 is essentially doing nothing, so it would be preferable to
> > consider other ideas.
>
> Why because you have to do something, anything?
>
> > Best,
> > Shunsuke
> >
> > 2024=E5=B9=B46=E6=9C=8814=E6=97=A5(=E9=87=91) 18:50 Manivannan Sadhasiv=
am <mani@kernel.org>:
> > >
> > > On Mon, May 20, 2024 at 09:22:54AM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wro=
te:
> > > > > On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > > > > > Hi virtio folks,
> > > > > >
> > > > >
> > > > > You forgot to CC the actual Virtio folks. I've CCed them now.
> > > > >
> > > > > > I'm writing to discuss finding a workaround with Virtio drivers=
 and legacy
> > > > > > devices with limited memory access.
> > > > > >
> > > > > > # Background
> > > > > > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLA=
TFORM) to
> > > > > > indicate devices requiring restricted memory access or IOMMU tr=
anslation. This
> > > > > > feature bit resides at position 33 in the 64-bit Features regis=
ter on modern
> > > > > > interfaces. When the linux virtio driver finds the flag, the dr=
iver uses DMA
> > > > > > API that handles to use of appropriate memory.
> > > > > >
> > > > > > # Problem
> > > > > > However, legacy devices only have a 32-bit register for the fea=
tures bits.
> > > > > > Consequently, these devices cannot represent the ACCESS_PLATFOR=
M bit. As a
> > > > > > result, legacy devices with restricted memory access cannot fun=
ction
> > > > > > properly[1]. This is a legacy spec issue, but I'd like to find =
a workaround.
> > > > > >
> > > > > > # Proposed Solutions
> > > > > > I know these are not ideal, but I propose the following solutio=
n.
> > > > > > Driver-side:
> > > > > >     - Implement special handling similar to xen_domain.
> > > > > > In xen_domain, linux virtio driver enables to use the DMA API.
> > > > > >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > > > > > Device-side:
> > > > > > Due to indistinguishability from the guest's perspective, a dev=
ice-side
> > > > > > solution might be difficult.
> > > > > >
> > > > > > I'm open to any comments or suggestions you may have on this is=
sue or
> > > > > > alternative approaches.
> > > > > >
> > > > > > [1] virtio-net PCI endpoint function using PCIe Endpoint Framew=
ork,
> > > > > > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2aca=
b1@igel.co.jp/t/
> > > > > > The Linux PCIe endpoint framework is used to implement the virt=
io-net device on
> > > > > > a legacy interface. This is necessary because of the framework =
and hardware
> > > > > > limitation.
> > > > > >
> > > > >
> > > > > We can fix the endpoint framework limitation, but the problem lie=
s with some
> > > > > platforms where we cannot write to vendor capability registers an=
d still have
> > > > > IOMMU.
> > > > >
> > > > > - Mani
> > > >
> > > > What are vendor capability registers and what do they have to do
> > > > with the IOMMU?
> > > >
> > >
> > > Virtio spec v1.2, sec 4.1.4 says,
> > >
> > > "Each structure can be mapped by a Base Address register (BAR) belong=
ing to the
> > > function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in=
 the PCI
> > > configuration space.
> > >
> > > The location of each structure is specified using a vendor-specific P=
CI
> > > capability located on the capability list in PCI configuration space =
of the
> > > device."
> > >
> > > So this means the device has to expose the virtio structures through =
vendor
> > > specific capability isn't it?
> > >
> > > And only in that case, it can expose VIRTIO_F_ACCESS_PLATFORM bit for=
 making
> > > use of IOMMU translation.
> > >
> > > - Mani
> > >
> > > --
> > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D
>
