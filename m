Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D361991A3
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718667683; cv=none; b=ZlKmoUW1h2hFkaJbO9qihKXM+jiFs3hiD5iSXLakXwh3J1c5W0uvhEGH5TPQ3Ad1+S9rJDxKhC6KO0u+btr9kDPV+iw3QX39RtwozX3+yErLZ+3ydlfVF93Q2A4YIWLo+0qyKEodosRA+RSkcmwTBBAOy1bhK1muJXZaN7U1xec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718667683; c=relaxed/simple;
	bh=EGhZKCLc8GCsyFE0K97AbCX92rQpazxSUjuv0Ul1A0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JO4ye6J0FhfqPw2+Pb/5AKQSreU489yrjn02QViybvY35xlL2yL0jZbGtiq6RmR8b0pRxuLIKoWyAJTvmWHvMmBYoFL/nL5VgZxs3ASxEUCPtIKIIMt5UdcPJJVlv/8C3dmPMJD+0UV36k6lZXONin5YjKami/qbCpxsKxENkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp; spf=pass smtp.mailfrom=igel.co.jp; dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b=rybH6wVt; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b="rybH6wVt"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-80d61a602f2so1693106241.2
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1718667680; x=1719272480; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezjr4vOTDpa5tlXOg2IPrvZ97jwXmLsTTeegkWPsjjE=;
        b=rybH6wVt/Uxti2IIwGPguRWYBlsm3/unsIPL6AgUpq6YPRqLys0aq36CDWdDlrCd9O
         UhjsrEUUsS2V+rZf+b9C7Vylf1jBAtt0TgZcwzKuGJdPNCsuDnsH/mzVqD4vZchftpSe
         QrBFFuY2OjCjkq9JbI1JEDG+tmSgNRCs1ZPGR/VEwOn4gSuh9N27yee82VJn0TrxjC+l
         GSwZL2QRV8OulBIQgkWZIuhMNOXhtA3UglkK4mY9VGaLDdd5Ch/KjM8SaYz/dTbsM5Zk
         15+6wJ/QyyDOHHxhwqkY7FWbSgb5/h8eQ+TDBVl5JMTHZ3EpRKuRx6SRsj23d6ixmZmR
         6MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718667680; x=1719272480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezjr4vOTDpa5tlXOg2IPrvZ97jwXmLsTTeegkWPsjjE=;
        b=LUdD6Q8ARnNuNpy9uDjSK0m0NxpRAIWjn5YTlZwRSQkgAZ4rqMzMNeT87RyYjw7jmO
         DzPBlvtsAuvAccl0CuCLQTa7AV/+ugNqMbJTbAKeMiw09ZEYINz/Vc75LzWNpqN5M/Cn
         6uj73Du8zvEHlliBEOelVC2ILZhpnimO3b7IwNp+12TqLFbYc52l4ZXVGtbNlBtYmsZu
         ovmBfKoHDJWLNkCCvltSIG6jTDS9FPg1fUodzNhHM30yi5AR5ijrU0VwIWcjo3q+1ytz
         UIKWHivm8lGLdkINTly3HTMwBlgeXrGWZB5LRhx1nBttV2M0+YKGZhNNODAFk6S9G+y9
         S/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyesvmQaQUiA1WbvWWSjkfO31L1fmBa70X5ozXhOUtcajL97nOywDsbrGbM8JGqO+HjkGQQCsRJpz9utFAF1gtlkcnZeukldR1hIzjlxA=
X-Gm-Message-State: AOJu0Ywqzse+lA6OgmkJIHNdiDPjVAO1+TGIVkh4UHjAlnPCCtdudhZj
	qY99iXWjG48funzgjMZ3Yx9CKsFuD8NQ4tWWd+Y0hcDvd4e2+Tqpp3ht1mnbHkrmkZqjRgtxNa1
	sMGUjSSz03h1SsRnSHSbO3BVqeewRFuE/iHTaWw==
X-Google-Smtp-Source: AGHT+IGCgko3dsG3RDOkEu9eXynGhaJ1dXjxNzPfiQTSWcQAxhegQKdCUwWdN5c+CVRDaodxxBKvr7orivmk/rM0Jac=
X-Received: by 2002:a67:cf89:0:b0:48c:55b9:e9f with SMTP id
 ada2fe7eead31-48dae3e2d13mr10931067137.33.1718667680251; Mon, 17 Jun 2024
 16:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad> <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
In-Reply-To: <20240614095033.GA59574@thinkpad>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 18 Jun 2024 08:41:09 +0900
Message-ID: <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Let's clarify the situation.

The Virtio device and driver are not working properly due to a
combination of the following reasons:

1. Regarding VIRTIO_F_ACCESS_PLATFORM:
- The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
Physical DMAC to be used.
- This feature is not available in the legacy spec.

2. Regarding Virtio PCIe Capability:
- The modern spec requires Virtio PCIe Capability.
- In some environments, Virtio PCIe Capability cannot be provided.

Ideas to solve this problem:
1. Introduce an ACCESS_PLATFORM-like flag in the legacy spec:
There are some unused bits, but it may be difficult to make changes to
the legacy spec at this stage.

2. Mani's Idea:
I think it is best to add support for modern virtio PCI device to make
use of IOMMU. Legacy devices can continue to use physical address.

The meaning of "Legacy devices can continue to use physical address"
is not fully understood. @mani Could you explain more?

3. Wait until the HW supports the modern spec:
This depends on the chip vendor.

Option 3 is essentially doing nothing, so it would be preferable to
consider other ideas.

Best,
Shunsuke

2024=E5=B9=B46=E6=9C=8814=E6=97=A5(=E9=87=91) 18:50 Manivannan Sadhasivam <=
mani@kernel.org>:
>
> On Mon, May 20, 2024 at 09:22:54AM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wrote:
> > > On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > > > Hi virtio folks,
> > > >
> > >
> > > You forgot to CC the actual Virtio folks. I've CCed them now.
> > >
> > > > I'm writing to discuss finding a workaround with Virtio drivers and=
 legacy
> > > > devices with limited memory access.
> > > >
> > > > # Background
> > > > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFOR=
M) to
> > > > indicate devices requiring restricted memory access or IOMMU transl=
ation. This
> > > > feature bit resides at position 33 in the 64-bit Features register =
on modern
> > > > interfaces. When the linux virtio driver finds the flag, the driver=
 uses DMA
> > > > API that handles to use of appropriate memory.
> > > >
> > > > # Problem
> > > > However, legacy devices only have a 32-bit register for the feature=
s bits.
> > > > Consequently, these devices cannot represent the ACCESS_PLATFORM bi=
t. As a
> > > > result, legacy devices with restricted memory access cannot functio=
n
> > > > properly[1]. This is a legacy spec issue, but I'd like to find a wo=
rkaround.
> > > >
> > > > # Proposed Solutions
> > > > I know these are not ideal, but I propose the following solution.
> > > > Driver-side:
> > > >     - Implement special handling similar to xen_domain.
> > > > In xen_domain, linux virtio driver enables to use the DMA API.
> > > >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > > > Device-side:
> > > > Due to indistinguishability from the guest's perspective, a device-=
side
> > > > solution might be difficult.
> > > >
> > > > I'm open to any comments or suggestions you may have on this issue =
or
> > > > alternative approaches.
> > > >
> > > > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > > > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@i=
gel.co.jp/t/
> > > > The Linux PCIe endpoint framework is used to implement the virtio-n=
et device on
> > > > a legacy interface. This is necessary because of the framework and =
hardware
> > > > limitation.
> > > >
> > >
> > > We can fix the endpoint framework limitation, but the problem lies wi=
th some
> > > platforms where we cannot write to vendor capability registers and st=
ill have
> > > IOMMU.
> > >
> > > - Mani
> >
> > What are vendor capability registers and what do they have to do
> > with the IOMMU?
> >
>
> Virtio spec v1.2, sec 4.1.4 says,
>
> "Each structure can be mapped by a Base Address register (BAR) belonging =
to the
> function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in the=
 PCI
> configuration space.
>
> The location of each structure is specified using a vendor-specific PCI
> capability located on the capability list in PCI configuration space of t=
he
> device."
>
> So this means the device has to expose the virtio structures through vend=
or
> specific capability isn't it?
>
> And only in that case, it can expose VIRTIO_F_ACCESS_PLATFORM bit for mak=
ing
> use of IOMMU translation.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
