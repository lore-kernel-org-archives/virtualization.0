Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3714E2E0
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707247; cv=none; b=GQPpWxAhB7zI36fxiqS5edTHwvOCjKZz/TAgpBZjkbrqB1aIiERwgufkSnz2llSzInbrgEiblwRrnymi6LjNDscBGRae1W/+IRdMigP7VG1sd9FesvNP+nv2o4xBh8g2Oyr8SuaPI7LgH8MOlhHNAF+s/3Sm7TywYlEKQq0fvwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707247; c=relaxed/simple;
	bh=QUZtEG9m5EGGPIsNYlvFNCzGak0heKIOdAl3a6ylhIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uD85nWIRgKayemDpoacAa0XsMVnBf5yZnOzTIetaR6Zy5x611dFbv7GqPVNjnjI4V8WBJenew0j3UDZspz1SE4k4qL/xYWrexfXY+8w4iObc4uru/SlV9gCrr02mAReUo/o6GUs5iS0v4rGNXIZtkNTyWT7EEPj+BTfvzFTjvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp; spf=pass smtp.mailfrom=igel.co.jp; dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b=nSvLnPo9; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b="nSvLnPo9"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-80b7699abcaso1499425241.3
        for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 03:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1718707245; x=1719312045; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUZtEG9m5EGGPIsNYlvFNCzGak0heKIOdAl3a6ylhIw=;
        b=nSvLnPo9dSPRWkns+lqoGUjWolEEU4bZ9CyPxtTbCXEuLuQwWgjbOdEo4tS66qXdg1
         U2N6rMZX8VrnxvZFFuFiupE/R4aS1W84TtbiWdUYT2KtwZ7zrqbFzS3KlMYkCb4aSIq+
         PxuCQRMEbTk+QEaoobp5Mof8WSC0az+qsPBgRIDjAE6+AwfItMADlheVzHVTmXytwtjV
         TeVI65XqC6h3rDn3J0eN2/lu3K00tRP/48UtKvEZhv3742B4C5qND5bPbLInUCDvfBPG
         U4WENQUwAY7GttNu9Jj37ypRfqUMH2Hm0ny8SneCMvNpp+zds4HXUU7l0bNzZnbED+lq
         xpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707245; x=1719312045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUZtEG9m5EGGPIsNYlvFNCzGak0heKIOdAl3a6ylhIw=;
        b=pCMju9bCrUdUry2owsOUa+JHLR3CRLx/UxLiknRzKV7bC/wJSVDBcCSmm9DzivRfX+
         1DHMtzmhT9jV3xCHzSCyFfkl6yyjjPGPelrZo0QM+aMXWlpAwOMJKh+2zehXRq/IG7M7
         Tr1aJuvlitkacFe9CKqCzv+Yy36yPMZlVbXdbJ4Mzk/cRLBs5eLMma6NT5mH5P46v1OJ
         iY2/T/pkE6A9/EWQ2Iv/CoLLN6wBqKOGkX5921pEPVS/tKS43mUs7fCGbbWflD1dgSeL
         eJe4EoWIJo06JPj8G00TBSGRXWz3+WOvlJhg9qGx6wTE0XHzy8Yx+ehG4YNYt74EJl6e
         TU+g==
X-Forwarded-Encrypted: i=1; AJvYcCXK3C56dkRE0EzcLRPS7kubvrrj9O3Wk7nOA56Un0yFc7VxPlt5YQFhR/udB3WOM46GCDvejLcBdmI7y0QkY5wOEs/TuSLQdTtbAFSue3s=
X-Gm-Message-State: AOJu0Yx2QdLiPR3iT1zsjFKxqrKRdzxn6pbC+/mxOiM7VOyt/OIiGu9p
	WD9sqV42PVq7dwSij4soL4jjFkatjKzItItbntqAVbF+EdJed0sv+S8wM3WSmhaJKuhxz8/UnUM
	CIZzoUBkRKaU4554prWm0l3Dj4T8daqcd0pwKGg==
X-Google-Smtp-Source: AGHT+IGvfcGfqQoY3MzRav8ed/slokoh5A3Ps7owp6wpMs2ZMHdV4kkvRQ+BzhDS69u78xzULFIbl4tCnNz67fGKqJE=
X-Received: by 2002:a67:cd9a:0:b0:48c:4e31:4e25 with SMTP id
 ada2fe7eead31-48dae34bccdmr12303977137.19.1718707245269; Tue, 18 Jun 2024
 03:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad> <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad> <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org> <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
 <20240618061705-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240618061705-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 18 Jun 2024 19:40:34 +0900
Message-ID: <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B46=E6=9C=8818=E6=97=A5(=E7=81=AB) 19:33 Michael S. Tsirkin <mst=
@redhat.com>:
>
> On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> > Thank you for your response.
> >
> > 2024=E5=B9=B46=E6=9C=8818=E6=97=A5(=E7=81=AB) 18:47 Michael S. Tsirkin =
<mst@redhat.com>:
> > >
> > > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > > Let's clarify the situation.
> > > >
> > > > The Virtio device and driver are not working properly due to a
> > > > combination of the following reasons:
> > > >
> > > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > > > Physical DMAC to be used.
> > > > - This feature is not available in the legacy spec.
> > >
> > > ... because legacy drivers don't set it
> > >
> > > > 2. Regarding Virtio PCIe Capability:
> > > > - The modern spec requires Virtio PCIe Capability.
> > >
> > > It's a PCI capability actually. People have been asking
> > > about option to make it a pcie extended capability,
> > > but no one did the spec, qemu and driver work, yet.
> > >
> > > > - In some environments, Virtio PCIe Capability cannot be provided.
> > >
> > > why not?
> > PCIe Endpoint Controller chips are available from several vendors and a=
llow
> > software to describe the behavior of PCIe Endpoint functions. However, =
they
> > offer only limited functionality. Specifically, while PCIe bus communic=
ation is
> > programmable, PCIe Capabilities are fixed and cannot be made to show as
> > virtio's.
>
> Okay. So where could these structures live, if not in pci config?
What does "these structures" refer to? PCIe Capabilities? virtio configs?
> --
> MST
>
