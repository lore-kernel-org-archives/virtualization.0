Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D760139579
	for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761278469; cv=none; b=lEwLrfiZt3+kTH9COJCw2lQMD+kC2/bwpRMV60XpTUKk08bO2bOj8CKPc6W8oWj61Ic+2Hb9oGTsqkJuE60EewxhNiB2eH06s7lyP2tnu6AwXxc2r6sVHnFF1If7X9ybZ/UGew+Cw9OUe/Ud1la5/ZgaGUbc2yT7VHypY06HNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761278469; c=relaxed/simple;
	bh=X/wg1dlOoOLJXddH9S/CU52E4bwolzQNRp0e2NEc/Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpVuKq4uImSohxe8q6Y1w03z8gc6/NrBb5BkPXP+TWLDQva1PNFp7sYLTcqkjmPgKw7p0oldsqbJBlQLF2TQYn3pAeS3KGzIRTi+nwfZgIhff0GdZdXjyXMjNe0htm1w6FEneDdMu4CcYJv2JdVd6kTD/vBVOg2U/DJiU5pDhu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzczmdXR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzczmdXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761278465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOOkSkyc81lJ3YyAbSvfeo2EUEqU/zqat7/GCqLMidU=;
	b=SzczmdXRfLZ0lj2VPfCrBZZMG6P2z7ljxrOfeAa6T1LudzuFOlzyjL1gZoW8LtppZjx9qs
	3cwT9Bbj8AsC5KrzGCdx31XVq7P0alXhURzqYdoCPBXdn/ORRu3GGdYGAFwm56qbsqBijr
	5U1sY7MTAYpHnymj8fQ5CCqMDzIkZHc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-ZvPoDmhLOAaBTytnGeXgpQ-1; Fri, 24 Oct 2025 00:01:03 -0400
X-MC-Unique: ZvPoDmhLOAaBTytnGeXgpQ-1
X-Mimecast-MFC-AGG-ID: ZvPoDmhLOAaBTytnGeXgpQ_1761278463
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so1289793a12.1
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 21:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761278463; x=1761883263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOOkSkyc81lJ3YyAbSvfeo2EUEqU/zqat7/GCqLMidU=;
        b=upITZG5unhdGaRHSzHfAJRf1eY9ybU9YjSH10zQXfsVmgzlnaWdWHH4KlXlF3+A0hn
         +C3ng8Q6pVy/3K6zQVbA8qEkebJVRM82elj3YU+KgOCdl+CZ777mh+81kNkDa3QFaEHW
         u4bhKivcHqKQ0455k3uivv8cGoXu7Ys6kfNrIkaOhqKSUg0Xn/FAs6AuostTCKbLHZI+
         HHXxPzD34E3GjQ4oqeTExntEyOAN3GWW23N0VqyXaHX4+b2QQnYogirvozG13LHvgCnv
         uIFQnyKFUSI47E7BkiS5nPU3ryB6FQZY80TXpEY+0O70XR6lvHRO5JDoBSYtMFK9F6JP
         sE9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNcKWsf9+9MUt4uLVBD8dZsWYP1G1xYGHdAhY2UNGCaM46Qo/irSO2Ru5k/9aMKrBH0A/bipcwBaNoaqrP+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVnGmuBabEuulQgsRKWGW8US8dLFjteplK50VbHXFeVD9xv1Dc
	Np8k1Xm+Rfcftgm0fK5sr0M12gIHpyCS1IU7Zwvj31MSUw3msrKFqw3+qF8hUvPJZgzHTQOFOXB
	2MD7p5UoAo9y/LBYEXDYa7v0ikxFWrxIGx1F9Oo1NyrSauGzrNGPtcl/JzxuDKR0CVs/U6Ltg9D
	4n9TMr4c1h4K3UaXFThvcUV9CF0VOpU0AydxHd1gO9NjM=
X-Gm-Gg: ASbGncuKQD+gXuwbQRGsLxvdHYFoUUY4J4WfAqBnfWLbYPmBgGalsNwNivthYWC7e4P
	nWQk0I2gHzB8moVPdjx9MzejHi19Dv3yHB3wBkY+0mkvE+Uu9JTSe5pwee8PJ1Wgruy7j8lXf0v
	8LWK0HFxRcwKZONOpkLBAAk14LF1aEk0ry6uihGgfNWlXIPf4lkjMf
X-Received: by 2002:a05:6a20:430e:b0:32d:a70e:120a with SMTP id adf61e73a8af0-334a8621362mr39016546637.45.1761278462691;
        Thu, 23 Oct 2025 21:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT9qDfEKW7XFhwtKdpNR4Y9NHxEu76SknfyjzYVTXZbUcA7HumVpwtuiBJtgQFk1iBURq/Ou36QzXQO1egdac=
X-Received: by 2002:a05:6a20:430e:b0:32d:a70e:120a with SMTP id
 adf61e73a8af0-334a8621362mr39016477637.45.1761278462047; Thu, 23 Oct 2025
 21:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAP4dvsfZEo+1+O8tpLFFh=s-fEFaMRu2+mQ3F=LJmjoEHyZXMw@mail.gmail.com>
 <20251022073015-mutt-send-email-mst@kernel.org> <CAP4dvsfXs7Do=9d_05tzU5FUuqfLnsFSpodSMDhv=FR2KYWh=w@mail.gmail.com>
 <CACGkMEugHNb1QfG17sPzDfV8-W1mJQGX_cJQvDCoCVQ7axGRkQ@mail.gmail.com> <CAP4dvsc=LnwRvTFJ4mxCUAW6SApJ0eyvBVu+B58MDOWNCnRbow@mail.gmail.com>
In-Reply-To: <CAP4dvsc=LnwRvTFJ4mxCUAW6SApJ0eyvBVu+B58MDOWNCnRbow@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Oct 2025 12:00:50 +0800
X-Gm-Features: AS18NWD10qpV7gYy9Z65QipXlCd7NAAm48IwhhsmLsT0neTIKZdV_Nv0uMx84wI
Message-ID: <CACGkMEt41L4pmMcE9zSJ5tVU-Tj0zGEoLqvsktbKWf=gEGphww@mail.gmail.com>
Subject: Re: [External] Re: virtio_pci: Question about virtio_pci kernel
 module refcnt
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, xieyongji@bytedance.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b6qyBWy4-DRGplqMcc_3goj5LxojgwGUi-pB-RsfY0M_1761278463
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:34=E2=80=AFAM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Hi, thanks for your reply
>
> On Fri, Oct 24, 2025 at 9:53=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Oct 23, 2025 at 10:34=E2=80=AFAM Zhang Tianci
> > <zhangtianci.1997@bytedance.com> wrote:
> > >
> > > Hi, thank you for your reply, but I still have a few questions:
> > >
> > > On Wed, Oct 22, 2025 at 7:31=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 07:21:45PM +0800, Zhang Tianci wrote:
> > > > > Hi,
> > > > > I noticed that the reference count of the virtio_pci kernel modul=
e
> > > > > in the VM is always 0, even though there are at least two
> > > > > virtio block devices and one virtiofs device in the VM.
> > > > >
> > > > > Using rmmod virtio_pci can unload the virtio_pci module,
> > > > > but this renders the virtio block devices unusable.
> > > >
> > > > it removes them. you can put it back in and you will
> > > > get devices again.
> > >
> > > But I can't do it anymore because the rootfs is no longer available,
> > > or rather, the OS is no longer available.
> > >
> > > >
> > > > > I wonder if this result is expected? Why don't the virtio block d=
evices
> > > > > and virtiofs device hold a reference count to the virtio_pci kern=
el module?
> > > >
> > > > because they don't have to.
> > >
> > > Is it due to design reasons or implementation reasons?
> > > Is it because the semantics of kernel module refcnt does not include =
such
> > > logical dependency?
> >
> > Note that virito has a bus so it follows the device/driver model so if
> > I was not wrong the refcnt was handled by the driver core.
>
> Let's look at an example:
>
> $ lsmod | grep virtio
> virtio_balloon                 20480  0
> virtio_console                40960  1
> virtiofs                            32768  1  <-  one virtiofs
> fuse                                172032  2 virtiofs
> virtio_net                         73728  0
> net_failover                     20480  1 virtio_net
> virtio_blk                         32768  2  <- two block devices
> virtio_pci                         24576  0
> virtio_pci_legacy_dev     16384  1 virtio_pci
> virtio_pci_modern_dev   16384  1 virtio_pci
> virtio                                16384  6
> virtio_console,virtio_balloon,virtiofs,virtio_pci,virtio_blk,virtio_net
> virtio_ring                         49152  6
> virtio_console,virtio_balloon,virtiofs,virtio_pci,virtio_blk,virtio_net
>
> There are two virtio_blk devices which are vda and vdb, and one virtiofs =
device.
> We can find the block device and fs instance are holding virtio_blk
> and virtiofs' refcnts.
> But they don't hold virtio_pci(pci bus) or virtio(virtio bus) refcnts
> even though they logically depend on
> them.

My understanding is the driver must be unregistered while the device
is being unregistered.

> So I might need to consult the driver core maintainers?(I have cc'd
> them in this email.)
>
> Thanks,
> Tianci
>

Thanks

