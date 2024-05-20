Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765FB17BB4
	for <virtualization@lists.linux.dev>; Mon, 20 May 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200687; cv=none; b=uYL8lzlZYbDte0uJ18PJy5S4I3SurrkfyBMHrTmaWOX52LUt1y0vOFdcdjcmzOoJVU5ayIBpaGUJPB9p5zi8Aw9+1QtcUYKJWCpxLJEXPqFO/zGvnQIKiE6xfe6qWfh/tNyNg6TQqHx5RafDVOwo4FFYiFQriGy5HDlLRXQ6unQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200687; c=relaxed/simple;
	bh=6A0GF0XyBkHC3K8crOLyxfeIflMd1hxalZNXXZC0v2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPPFOwEgpM807HRwkzcfjlSg1a2NIn5X9DCrpOAMjq3F3eDi2s0aNz7c1UUqd4IUeQWBwB9KbVlwecz7/a5J2fZy2KqTqM1NM4oHZ2gKF6vbFf1v9hwhzTUsMA4EMbpwVx2SMrVA1agpTVDJvW9aIBWVEn338YnBI696xfvyVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp; spf=pass smtp.mailfrom=igel.co.jp; dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b=z/AT/smi; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b="z/AT/smi"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4e15ef06569so1409824e0c.1
        for <virtualization@lists.linux.dev>; Mon, 20 May 2024 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1716200684; x=1716805484; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYx1MYqKriQMaf8e5K+aZLI/jP8z9alvVTBfQskYD6k=;
        b=z/AT/smil9iAcCgcKLnkJPHfXAjxCjPd7YghnOhJv/9a1YdW1hWQ6smmIo4wm0QoUM
         CtB0U8cMFsof38q9YWTGcnNcRL3vpxf2DORW2YVp9XpndiHuF6bmPcRcIcN+ELAZd+MQ
         Flp5SuHJfgl2iWbkh3mH2PyO9A7gQ6TC9kX0F8N5lZNX66sKylbIIRoRdE9et8FBycV6
         lsuTya4917oYZYze8YCu7RvITmL9zfuS6IQuoH+LjGevRSLvP34eBHHadAV7UrkolaQk
         df2UkuQfPEf4cQ0LR2Cu5dMxzcEk7KP5WU8oYqRNWXytkrbFq5lvWZPBcUqqLqKtReZA
         zFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716200684; x=1716805484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYx1MYqKriQMaf8e5K+aZLI/jP8z9alvVTBfQskYD6k=;
        b=qL9JV7MG+zFYerlarYKQdqbmqw+z3+57M8608ttrunzafN9LFngakOoDtH/oe8qolD
         2hv0pDFBOkm4XIy0qLEXe9oexvacLqsAOWFoYIKto8Ep6oKgnf56vwz1Dwmz4julQHo/
         HEcb661YViigaYNY7o8wES7BiWaAjCr8zasHEVZaDk8CdPJ1hdNUw76Lr79HM89j1o0c
         KWWtbhZhrV1pPqBCJy2AmIWI5bWswhyMnV5u4FC9cZSI7/98+OX2iFDaaVrz6Zkj6jIP
         gzb2WgQajL2EDALrfDIvsnoHXh2uJOFqya8O305xdWwxwSLhNEPYoBBvdLHC3Np16P1D
         6vDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfWgaNQUedZ0yMv9qpiOnr++A7bNhOT5uyze897+8wL/K8CQGzGUQQ+EnuatNU/36eJg+vHwCdW1Wfv+GgMOEjxHEtPtD69wG67Ztt0lQ=
X-Gm-Message-State: AOJu0YzWN82IWfKZVANHFMB3NYguTUdDifFGpZBLvutkVqTwqSg4n2DF
	l15VLFoWKASY4gB2nWIuZRH+KPNDFs5XaatHoKlJHXs3EByA8/kd7EKr4SdzeiCezLcbLY+qc2V
	1yFvxJfeiFB0yaYsq4J0EMmZRMGZYvgkbuUCQKQ==
X-Google-Smtp-Source: AGHT+IHZYzTMr4tU5/8wKI+9VpalGfBtdoxBWlfNPxH+/8kN5nrKIHK4l87eO9LH8BVLZVy+9n42hB4h7V93qzAV43I=
X-Received: by 2002:a1f:ee4d:0:b0:4da:c69c:f5b2 with SMTP id
 71dfb90a1353d-4e16d8c3421mr3523381e0c.2.1716200683719; Mon, 20 May 2024
 03:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
In-Reply-To: <20240516125913.GC11261@thinkpad>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Mon, 20 May 2024 19:24:32 +0900
Message-ID: <CANXvt5rQdhS5XBnHFmFiN=fPO975jQ8dosH0L0ZP_51dd6cXag@mail.gmail.com>
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, virtualization@lists.linux.dev, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B45=E6=9C=8816=E6=97=A5(=E6=9C=A8) 21:59 Manivannan Sadhasivam <=
mani@kernel.org>:
>
> On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > Hi virtio folks,
> >
>
> You forgot to CC the actual Virtio folks. I've CCed them now.
Oops. thank you.
> > I'm writing to discuss finding a workaround with Virtio drivers and leg=
acy
> > devices with limited memory access.
> >
> > # Background
> > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) t=
o
> > indicate devices requiring restricted memory access or IOMMU translatio=
n. This
> > feature bit resides at position 33 in the 64-bit Features register on m=
odern
> > interfaces. When the linux virtio driver finds the flag, the driver use=
s DMA
> > API that handles to use of appropriate memory.
> >
> > # Problem
> > However, legacy devices only have a 32-bit register for the features bi=
ts.
> > Consequently, these devices cannot represent the ACCESS_PLATFORM bit. A=
s a
> > result, legacy devices with restricted memory access cannot function
> > properly[1]. This is a legacy spec issue, but I'd like to find a workar=
ound.
> >
> > # Proposed Solutions
> > I know these are not ideal, but I propose the following solution.
> > Driver-side:
> >     - Implement special handling similar to xen_domain.
> > In xen_domain, linux virtio driver enables to use the DMA API.
> >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > Device-side:
> > Due to indistinguishability from the guest's perspective, a device-side
> > solution might be difficult.
> >
> > I'm open to any comments or suggestions you may have on this issue or
> > alternative approaches.
> >
> > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.=
co.jp/t/
> > The Linux PCIe endpoint framework is used to implement the virtio-net d=
evice on
> > a legacy interface. This is necessary because of the framework and hard=
ware
> > limitation.
> >
>
> We can fix the endpoint framework limitation, but the problem lies with s=
ome
> platforms where we cannot write to vendor capability registers and still =
have
> IOMMU.
I agree, this is a problem caused by the inability to set the
capability. I'm not sure, but are there any chips that support this?
Also, I wasn't aware of the IOMMU issue. I thought that if the Linux
DMA subsystem could handle IOMMU properly, there wouldn't be any
problems. Is that incorrect?

Shunsuke,
Best
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
