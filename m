Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B414502F
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511901; cv=none; b=DtaUvrSqptDqCMxVvWjpx0IOFWNcTgmF9KHSObMA6mNtRMHwyFLI4I7ACqtaLFJHrjXgwnkRvYUshNp3veu5FfEbqvVqDTyjUnXUX87ZWslNQ8tR8WsVPVT/iaUonO/LEUIS4bQoSg496XbkqlquX1wE1gVzY1Eg2YdLjqJ5C08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511901; c=relaxed/simple;
	bh=pw1kGo2ws+5OCuELJrcKLUoUBQ0/TG/z4KJ0tei3+2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nMtCh7D2LyMLpLNt2olen56C7FLJrqAU3Et10flReYO08XXQDLxZSJBZF2M/rDE6sG4GJYy5FebOiILIt/obZNbRP/qheobKt80XsRSbeC4ftLQaZDwJ7KEKURL03egO4rVMTYugLO3e0qU/dV983dSFMoCNbiBYy1hkXHOGtzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7u/i9Rl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7u/i9Rl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760511898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jp8KDES5ks8Aac5tH2y5JeuFcW9ux+XVUfHWrIy/4U=;
	b=Q7u/i9Rl7wKyyO6pN/hrmU+G+tX0HjsAwiVBrfRDL9cmeBSAz5/bSt14hCwv8RRctNgn+s
	oH9WgSjQ6xoqHU10zwiINOnBPofdMuc4YdFdOC2GpZSMlRleiep0mNrW7BfrdPss8Lhghi
	WeVWrZsHoSpjRUmXwunwZtwvrCDhjzE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-Ia_VJ55hMwCarhdHB7VBLw-1; Wed, 15 Oct 2025 03:04:57 -0400
X-MC-Unique: Ia_VJ55hMwCarhdHB7VBLw-1
X-Mimecast-MFC-AGG-ID: Ia_VJ55hMwCarhdHB7VBLw_1760511897
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e38957979so32078515e9.3
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 00:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760511896; x=1761116696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jp8KDES5ks8Aac5tH2y5JeuFcW9ux+XVUfHWrIy/4U=;
        b=Zh9WGC2cOb4iCLeiSFmwyV60gTHfDywTMObWe2Xp9PaMZQbeRYUK24zzIkXWIXD50K
         h9kreCfikhrOiG/DCTWJVqIg5hp8Q4mLJn/HvqxKBmHTBwNzmJFs9cx5+1Vkc8arKtok
         ZzmP9ItYTHpMdH1uv9eh0cH0OeclqFsHPpgK8HIBkcUAHc1N0nUTdXNIOmwO6gHyAK6W
         Kqgor6TDf2jXUy/sW8gYXVFQChr4FqGpHgOyekWUXOIkLTs6gZNX3lEODzXnY98IYmrq
         MKpgzpiEKvIZ2LfeZthaqMfgSVMMduEsbNPqUtssu05HaWhFNgKzeSRJ9VPSgzo357A4
         PvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn3urKS6jhko001w3TXsVizZesiQv9jcOo/pOFaaWqY2HHWGWYoIQLWGnRH7dPttAlnZZJYaEfuzYog671fQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEkgCk3CGqFsdm5wEjLs3EoUDXBvB3aCF/iOFL8d0joy0IAznE
	AGpfMPGzaXR23BSZmKibR05c1UNH+RB9lVW1ZZFmeeX/jmYTQOwTQx1DjLIIKeGrxGdRSM+iS51
	J8pXKzSxNFyowUQ8ZcCXQtIj236M2j00NvvkD19O0e5cw44IWaKNlm7lqmgGvcc62ad0+
X-Gm-Gg: ASbGnctHPNuaf2BMuoLrybFQOua4bd3s24iYKry7/N1d+tbFKVLONNnoZeQJ8weveAb
	RvDX+CdIOXndGTp0XHE0olvQCwUzrNfmXLyHHdiyBWNsjo3+x4p/N4DOwOXyvHtLvrU4h0auRjN
	WV5Wifb9o+JJFcSAXb16AD/AN95uFpwEG4+hLv2h8ViU5IjCpIxwgSBmKB+uHfqkBWdfsi77Zi8
	u9MPK8wGzXMmOaIeX1v1XrJb74or9c3QFalY1VK8W5b/jVhiVG1fERJHv2TjDDqgiAujK3FI52W
	Imc6oEBwYd1htdm+1stlGFkNXt8/dfyAig==
X-Received: by 2002:a05:600c:502c:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46fa9af014cmr175468015e9.17.1760511896361;
        Wed, 15 Oct 2025 00:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhAQEhpelfdmyS4qYM1C8WtBXdelqu4F1sSu1VYzwVpfHA3C49VVzKIr4iSipRy/2riecqYQ==
X-Received: by 2002:a05:600c:502c:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46fa9af014cmr175467725e9.17.1760511895812;
        Wed, 15 Oct 2025 00:04:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583664sm27454506f8f.22.2025.10.15.00.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 00:04:55 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:04:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251015030313-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X8TrZMKKd8y6yG5EP8M5VwzbAXaX8ars3mpCDN0njXo_1760511897
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrote:
> On Wed, Oct 15, 2025 at 8:33 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrote:
> > > On Tue, Oct 14, 2025 at 11:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > > > On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > > > > > An userland device implemented through VDUSE could take rtnl forever if
> > > > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > > > > > device if it does not return the buffer in a longer-than-assumible
> > > > > > > timeout.
> > > > > >
> > > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > > Let's not break valid use-cases please.
> > > > > >
> > > > > >
> > > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > > kernel.
> > > > >
> > > > > Would a shadow control virtqueue implementation in the VDUSE driver work?
> > > > > It would ack systematically messages sent by the Virtio-net driver,
> > > > > and so assume the userspace application will Ack them.
> > > > >
> > > > > When the userspace application handles the message, if the handling fails,
> > > > > it somehow marks the device as broken?
> > > > >
> > > > > Thanks,
> > > > > Maxime
> > > >
> > > > Yes but it's a bit more convoluted  than just acking them.
> > > > Once you use the buffer you can get another one and so on
> > > > with no limit.
> > > > One fix is to actually maintain device state in the
> > > > kernel, update it, and then notify userspace.
> > > >
> > >
> > > I thought of implementing this approach at first, but it has two drawbacks.
> > >
> > > The first one: it's racy. Let's say the driver updates the MAC filter,
> > > VDUSE timeout occurs, the guest receives the fail, and then the device
> > > replies with an OK. There is no way for the device or VDUSE to update
> > > the driver.
> >
> > There's no timeout. Kernel can guarantee executing all requests.
> >
> 
> I don't follow this. How should the VDUSE kernel module act if the
> VDUSE userland device does not use the CVQ buffer then?

First I am not sure a VQ is the best interface for talking to userspace.
But assuming yes - just avoid sending more data, send it later after
userspace used the buffer.


> >
> >
> > >
> > > The second one, what to do when the VDUSE cvq runs out of descriptors?
> > > While the driver has its descriptor returned with VIRTIO_NET_ERR, the
> > > VDUSE CVQ has the descriptor available. If this process repeats to
> > > make available all of the VDUSE CVQ descriptors, how can we proceed?
> >
> > There's no reason to return VIRTIO_NET_ERR ever and cvq will not run
> > out of descriptors. Kernel uses cvq buffers.
> >
> >
> > > I think both of them can be solved with the DEVICE_NEEDS_RESET status
> > > bit, but it is not implemented in the drivers at this moment.
> >
> > No need for a reset, either.
> >

