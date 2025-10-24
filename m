Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656923D7EC
	for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273274; cv=none; b=TVXg+IoKiGiGAakFNxRXO9FA6auIj5iE6gJfG4V2mlQVqdBQyx3VoQ6YPfkiDqnQD8JAtS89IZFOH9Tw38k4ykgRF+vxwOOAJ3Y0qE5ddzMie1kjQLwXXAZvvM/xPW6Q7eBlGq02a6C4Z/Go4o3Y2jg48MXrhgtm5pUTLy69b1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273274; c=relaxed/simple;
	bh=hlV/GDlDWjiP3V4F2H+ecKa4T1eMNbn54Re1g84V35w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GykldVjPR8KA/vCXj+baJL4kRVafQiLmGE/RGt+n66/xTvshpgZgQ981PKGs+Fpxxw+doJPqMq5i2P0557GfgEN+BK49/e/V71E8aq9J61udlO8Sle+uf5Endes9NAGz4CnkyZexChS/SoSRYqU0zV3uTsePldwplIGfGLuY2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M368uCIL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M368uCIL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78125ed4052so1807977b3a.0
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 19:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761273272; x=1761878072; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpZu/ZwablGzrbD3ML3k0Us4lqrXufJxs7CcsteoPbo=;
        b=M368uCILV1qYZVqFlbWDUzm/uerFL9IVJZmetKMt3wlnz1KGLs8oZ61ZklgMilxxWW
         dhjLKYuRp9AB4s+jKQ+TGY5bNrp/ZbHIuvdcIRWhAY6YaYDiT3PmxKA7UkUWrUFNA8IX
         Zg5j6ZUb1tx6ooBIA/Nz3NNngE0KGf937ab9SHtshPPoAAWUoWbBKikaDnexoReoijrG
         /3AF9Ji5lauV+0qP2bimx4ULSjvTdCsPjEZOXIzHDsX+u0YoTY0J740yXBGErceZ4w5E
         EImMnLaaqIIJ/6Ga8JlhgXR7yD7akVVVhrTztExNpgVuwwZj/D2OcSs9MI8NtsDVy215
         NQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761273272; x=1761878072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpZu/ZwablGzrbD3ML3k0Us4lqrXufJxs7CcsteoPbo=;
        b=HV5xl8KBqFsOCxChPBdB0qG1xxCGRlBilMkRymNg1ECU8K9MtPloHNj7gbW8T80Mjf
         LRtzsM6luycPJm5eqTifXZdxmAtpU5k2xVwsagSeEEBGOu3PV5vmqYSqQF9HP5ABMtpH
         lP9SWnGKHTa+WBTddW1T2sUo1K/YDzrhm/n3zXc7pnkzw6HvH/rhWr//ZCJ4Wa7YXVQx
         S0pGZ9Oyhcrm3ERS7Xl+4kSPKL3Cd3si/3VDU4im7CmepQBcU6/BFmaXXUo4TAYQL+ZW
         CzU0/tM0fB4CoodzczOWAmGa+q4OBmyiFLEMPi3OxM+7NW9WcuQiaZjTQALwp8lrG2IW
         HgNg==
X-Forwarded-Encrypted: i=1; AJvYcCXa7j7wTRTx4SDqdVHQGwLFVR0/hP7Nu2CFNHbPVvidmulX7NY7vArNaszYg+dLw+ZrHHfa/RktGIf5RIZgvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwK26hC/vOMrtZe5ay253WHH5sci4rPZoDcbwnVVFuekHfCpoMn
	Svp6Fm3JPDAxEK6E/mglykR5YYvxTh1iutAAvLHkY3ynMroYkyX1SVFIRfgcL/SoUX4tk/CJ54K
	CEzM9je0Vv7Il3GnM1yIIkqYgN5w3u9jNiCmHNp2Afw==
X-Gm-Gg: ASbGncthuYKV2k6GAshsPVitfuo+NLkaX/cTe9HvbcAMqU2I6G1JfHVyIesn1pAuYhE
	+Lve1Z9JcrKrqIWPsO9WmCWGowda+lHTG99MLnsw4MNX/CU9horANQdnoTq+jzE022CQygQY+SG
	34DT8B4WRjyYqwvCL7vIzvQ/xKk4Kau3yqwMD4A/2UYosdeM9q2LuP592bSSJiRse2GrExCcS8R
	NSpj8Bhd2KV79PEVMNB3J/NTvahhxoHGLlv96/qtSDjaiDew9ZJ2RW7ITwsiyI5gXGJapc2xiHI
	Xw==
X-Google-Smtp-Source: AGHT+IHZ5vUnizhMkg75VXJ3JuoqBbS3n24HhfaogKMFosNS883pW7Zhkx6oxrEShXreiWn1sZrhHbYa+V1+K7DUCs0=
X-Received: by 2002:a05:6a21:8884:b0:334:b0d9:a543 with SMTP id
 adf61e73a8af0-334b0d9ab1fmr28932927637.14.1761273272374; Thu, 23 Oct 2025
 19:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAP4dvsfZEo+1+O8tpLFFh=s-fEFaMRu2+mQ3F=LJmjoEHyZXMw@mail.gmail.com>
 <20251022073015-mutt-send-email-mst@kernel.org> <CAP4dvsfXs7Do=9d_05tzU5FUuqfLnsFSpodSMDhv=FR2KYWh=w@mail.gmail.com>
 <CACGkMEugHNb1QfG17sPzDfV8-W1mJQGX_cJQvDCoCVQ7axGRkQ@mail.gmail.com>
In-Reply-To: <CACGkMEugHNb1QfG17sPzDfV8-W1mJQGX_cJQvDCoCVQ7axGRkQ@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Fri, 24 Oct 2025 10:34:21 +0800
X-Gm-Features: AS18NWCmvA0lV0-81RaQTg1nvP9KHzeGAnDDK3qObTlMYkvRSUR9rCR3bKD7ofc
Message-ID: <CAP4dvsc=LnwRvTFJ4mxCUAW6SApJ0eyvBVu+B58MDOWNCnRbow@mail.gmail.com>
Subject: Re: [External] Re: virtio_pci: Question about virtio_pci kernel
 module refcnt
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, xieyongji@bytedance.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thanks for your reply

On Fri, Oct 24, 2025 at 9:53=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Oct 23, 2025 at 10:34=E2=80=AFAM Zhang Tianci
> <zhangtianci.1997@bytedance.com> wrote:
> >
> > Hi, thank you for your reply, but I still have a few questions:
> >
> > On Wed, Oct 22, 2025 at 7:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Oct 22, 2025 at 07:21:45PM +0800, Zhang Tianci wrote:
> > > > Hi,
> > > > I noticed that the reference count of the virtio_pci kernel module
> > > > in the VM is always 0, even though there are at least two
> > > > virtio block devices and one virtiofs device in the VM.
> > > >
> > > > Using rmmod virtio_pci can unload the virtio_pci module,
> > > > but this renders the virtio block devices unusable.
> > >
> > > it removes them. you can put it back in and you will
> > > get devices again.
> >
> > But I can't do it anymore because the rootfs is no longer available,
> > or rather, the OS is no longer available.
> >
> > >
> > > > I wonder if this result is expected? Why don't the virtio block dev=
ices
> > > > and virtiofs device hold a reference count to the virtio_pci kernel=
 module?
> > >
> > > because they don't have to.
> >
> > Is it due to design reasons or implementation reasons?
> > Is it because the semantics of kernel module refcnt does not include su=
ch
> > logical dependency?
>
> Note that virito has a bus so it follows the device/driver model so if
> I was not wrong the refcnt was handled by the driver core.

Let's look at an example:

$ lsmod | grep virtio
virtio_balloon                 20480  0
virtio_console                40960  1
virtiofs                            32768  1  <-  one virtiofs
fuse                                172032  2 virtiofs
virtio_net                         73728  0
net_failover                     20480  1 virtio_net
virtio_blk                         32768  2  <- two block devices
virtio_pci                         24576  0
virtio_pci_legacy_dev     16384  1 virtio_pci
virtio_pci_modern_dev   16384  1 virtio_pci
virtio                                16384  6
virtio_console,virtio_balloon,virtiofs,virtio_pci,virtio_blk,virtio_net
virtio_ring                         49152  6
virtio_console,virtio_balloon,virtiofs,virtio_pci,virtio_blk,virtio_net

There are two virtio_blk devices which are vda and vdb, and one virtiofs de=
vice.
We can find the block device and fs instance are holding virtio_blk
and virtiofs' refcnts.
But they don't hold virtio_pci(pci bus) or virtio(virtio bus) refcnts
even though they logically depend on
them.
So I might need to consult the driver core maintainers?(I have cc'd
them in this email.)

Thanks,
Tianci
