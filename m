Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A847161322
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715115; cv=none; b=nF+fuDYap+zWB3Ww18Nezc1zWPpjhybhpVvOSBeunZxWBrnheJKrHuoL4x2gZaik3xXwt17ectfmmI2hEQ3twBYkHLiXGy23V7WDRCt5HdzwMgUF+Qo+mCmB3DKeOiSj+sTsI1NS6+ZxkssG9Mz/cTzDaZAhbCvd4An9ghcdd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715115; c=relaxed/simple;
	bh=XHre21X9SwCqotdXW8/lphzofkaGVwsXiWQNcSyjcfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuBe9XfuRLU38FhHxB13+Oxwk6N2kCrc3hHM9Uua4n5nmPtNThAhsS1305phyowyBeNnyaFC1YGeFAhpNDAUeb9YR8s/Fe+0Re41MIUQVPLzCyEoDJBk7B9Nf8mBNDd9T7xJabiPjiVtK37T8XoAmoVjYqdbj0ln0xpFaGe6LFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp; spf=pass smtp.mailfrom=igel.co.jp; dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b=l8pVIaKr; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b="l8pVIaKr"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48d9998787fso1879345137.1
        for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1718715112; x=1719319912; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hpl86i4haxOVUtbofDOWEJznXKEeJqry7m19gSTHFGs=;
        b=l8pVIaKrDpnEcP4fqxC6rT8zb4FyEinJWMasV7Jo+P+gfL5HO11ktfkTZfLWu6vERQ
         19LLUkb3qa1XVuX9D3mAPcDFIIyU7ZuRtYJC8UPWc4hNetB/HH06m0i3VzPbhMGbu5K1
         78Lo75GQZMACXp51yBPRWb21uPaSPtutYoPshTj+AG3ZdMCCylss9L4ihZeM2l+kBZRn
         WwzFtD73mu/2h94DYrSBAGiGWAltcOmn96ZmTOiCQjo8L7wdVju51iMX5DswUsyXUfhg
         qDGE6+nNT4p9EDVL5or1F2Vosz/4w3h5BjftNKvTqWSJoSJuU7oKTZR1L7NgfaR/8JNR
         nMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718715112; x=1719319912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hpl86i4haxOVUtbofDOWEJznXKEeJqry7m19gSTHFGs=;
        b=bd8gv+PhHXTXW8C+FDJ+mg93PYt7S+DDCU6hAbs7LLtQGUA4C19+iw6kb/ovfK8Et6
         dVpvYvy9KRKr1woEasBnYArkPMk+DHlhQbm3FmnhbY6mZGxHCSkPF/LeGYYCHD7oxuPN
         uuNQEgkIyyHNxNjDGIHD0ylqCOjXQHoxjIm1GCWVD0rZxGgNJZ8hho5PEtoAMBUlJrxq
         oejhCkdP9Wxxc7ZBVYfBuaTmGgjqfiqObM+gfnS3nMWWvrRJ+XF0YVCUUHtFddYXnrZq
         mAMOYoPxggmw7yMurn22Br74y2SJGaIEnfo9bX/rmOVos3WZmSMPNgk9UCX/LJf8FM57
         xFfw==
X-Forwarded-Encrypted: i=1; AJvYcCVHHrlWNrFSD+pAlcRZXxFFSTdtY41RBQw1xgZ+Kh8ogvwRPRaBpADzrSXhCX0t15phE73XETKjd77/eGOER8N83+2yX0Br2M4m9XVeTkE=
X-Gm-Message-State: AOJu0Yz3JjJ/VVsMlQn1RMYUXvS2XEblxMWJRzXPfs2V29RBELwYwzOX
	b6SBuG/7TawceHtR65q/oITfFH2gQpkcgG3sPmJPGq1LaKRgVFbIFfyohYU6Ld/FLdaIHnXEexQ
	T9RqU2auK2J514iotuxPq4qJoezE5EgnwZReY0A==
X-Google-Smtp-Source: AGHT+IHM2rE+8UWJqT3TFlQ4BLez3LcYyKN7Pm0k6QaOKuR+2xg82e3ooeA624IgBFTHiPK5E7zdlJDiyhuVx0Njf5w=
X-Received: by 2002:a05:6102:32d4:b0:48c:45a8:a3b2 with SMTP id
 ada2fe7eead31-48dae3ce706mr15039239137.24.1718715112334; Tue, 18 Jun 2024
 05:51:52 -0700 (PDT)
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
 <20240618061705-mutt-send-email-mst@kernel.org> <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
 <20240618064231-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240618064231-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 18 Jun 2024 21:51:41 +0900
Message-ID: <CANXvt5pbdsSMc9C-nV0MiOAJPVyxXKu5otwLp2yopqBdNLS26A@mail.gmail.com>
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B46=E6=9C=8818=E6=97=A5(=E7=81=AB) 19:47 Michael S. Tsirkin <mst=
@redhat.com>:
>
> On Tue, Jun 18, 2024 at 07:40:34PM +0900, Shunsuke Mie wrote:
> > 2024=E5=B9=B46=E6=9C=8818=E6=97=A5(=E7=81=AB) 19:33 Michael S. Tsirkin =
<mst@redhat.com>:
> > >
> > > On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> > > > Thank you for your response.
> > > >
> > > > 2024=E5=B9=B46=E6=9C=8818=E6=97=A5(=E7=81=AB) 18:47 Michael S. Tsir=
kin <mst@redhat.com>:
> > > > >
> > > > > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > > > > Let's clarify the situation.
> > > > > >
> > > > > > The Virtio device and driver are not working properly due to a
> > > > > > combination of the following reasons:
> > > > > >
> > > > > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > > > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allo=
ws
> > > > > > Physical DMAC to be used.
> > > > > > - This feature is not available in the legacy spec.
> > > > >
> > > > > ... because legacy drivers don't set it
> > > > >
> > > > > > 2. Regarding Virtio PCIe Capability:
> > > > > > - The modern spec requires Virtio PCIe Capability.
> > > > >
> > > > > It's a PCI capability actually. People have been asking
> > > > > about option to make it a pcie extended capability,
> > > > > but no one did the spec, qemu and driver work, yet.
> > > > >
> > > > > > - In some environments, Virtio PCIe Capability cannot be provid=
ed.
> > > > >
> > > > > why not?
> > > > PCIe Endpoint Controller chips are available from several vendors a=
nd allow
> > > > software to describe the behavior of PCIe Endpoint functions. Howev=
er, they
> > > > offer only limited functionality. Specifically, while PCIe bus comm=
unication is
> > > > programmable, PCIe Capabilities are fixed and cannot be made to sho=
w as
> > > > virtio's.
> > >
> > > Okay. So where could these structures live, if not in pci config?
> > What does "these structures" refer to? PCIe Capabilities? virtio config=
s?
>
> Virtio uses a bunch of read only structures that look like this:
>
> struct virtio_pci_cap {
>
>         ..... [skipped, specific to pci config caps] ...
>
>         u8 cfg_type;    /* Identifies the structure. */
>         u8 bar;         /* Where to find it. */
>         u8 id;          /* Multiple capabilities of the same type */
>         u8 padding[2];  /* Pad to full dword. */
>         le32 offset;    /* Offset within bar. */
>         le32 length;    /* Length of the structure, in bytes. */
> };
>
>
> The driver uses that to locate parts of device interface it
> later uses.
>
>
> Per spec, they are currently in pci config, you are saying some devices
> can't have this data in pci config - is that right? Where yes?
I understood. The configuration structure is in the space that is
indicated by BAR0.
Follows the instructions in the spec:
```
4.1.4.10 Legacy Interfaces: A Note on PCI Device Layout
Transitional devices MUST present part of configuration registers in a
legacy configuration structure in BAR0 in the first I/O region of the
PCI device, as documented below.
...
```

>
> > > --
> > > MST
> > >
>
