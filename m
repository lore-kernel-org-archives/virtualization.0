Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321830F7E6
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510007; cv=none; b=QYwTH49GvQfsgA0990/RipaVEqXmRfLr0/mj/fE9xAdijq7uCvKMrVnLGfYN4jkjRG9U8GrlVZzktHdpitO6mSJFJr+SMLl/iSXuI854SJTko3NQKBW4y3jTFbZ0IqpCHA+KRBC8aTA4RoE9HN18MmDmc8mXUceeH3AjWI3qqsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510007; c=relaxed/simple;
	bh=5fY2EHaiPx5YUffclMiP+qS81HjO027W1pJLKkStZWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=navlBtNgiEIxqaT5AZa9LEHPsiD/KniYV+iH4PRIpufua32mwVFZQK6sYZzwknssvz7zMpjQ1OjCwhIyzbzseJg4VDrYvWGcPqDo42+/Hrs0iI03Dxt0xQDvky5lO5H/rznzII9MZO3JS+8LAFOsOUtxUGXcZBdZfQyd44vEJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ap5hQank; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ap5hQank"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760510004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJx3k4VeIaHUuzyh2iGzXH7FVxaGE9ANbJiYM/s1DZw=;
	b=ap5hQank8yINHK9cQkj+i+P7v1dR7yugRyDqs8weSoisx3oeeAf0mwVH5WZkf8DIEJpUlS
	AkQvCyufZts+MSCwawrUk1Y0iqcfhrUCCsjNGZ9ECyYDa+h0aiLZgelJZ4vmMmhMh3EtCd
	zOJU267v83I3GAXoljKOg12L0xHxPsE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-SavfOQhvP76jtOPWxxzwzw-1; Wed, 15 Oct 2025 02:33:23 -0400
X-MC-Unique: SavfOQhvP76jtOPWxxzwzw-1
X-Mimecast-MFC-AGG-ID: SavfOQhvP76jtOPWxxzwzw_1760510002
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3fba0d9eb87so3862345f8f.0
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 23:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760510002; x=1761114802;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJx3k4VeIaHUuzyh2iGzXH7FVxaGE9ANbJiYM/s1DZw=;
        b=Bjmk1sGIKyme8ie7lsXchdT6c4ZxpOFbAGCCJQgSITRBgynfGD6nD/KdfyOAIzpAxZ
         e21AftF51tNB7HrKR3OMzwpOrve88DoMlHNMfVMbNK3NiszaXapuwJ35Qu9SOEYvfAG/
         j6Wd1YoGdA1YYNKQp3UZSRAGUVphOFGcPiqgfrCPfv1Y/N144oEJeKTWpddF3HmfbskP
         TX0QWYy2GrjmJ7Aqo3L0mg66GO/yrTFzR8eJVLDWDTvAeaUTwZmVgF/vwRJ10bk4Gkml
         XIlh5LrGCLbllzcsdl3M44C97zaIuRIm1EFb7RYviLiHAedzMmB1tYWRn4Hvfhc7l0JJ
         7FHw==
X-Forwarded-Encrypted: i=1; AJvYcCUtMe2RcN7kibI2ql4zpm8C/eO6TEqebc0CzbseeVp55irU8Mm2niiCMp7R1DOfetzv1PsrMISHt8Ncipj4mw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9n1D/R50FCSAJDouQ/nS7MGfwezUG9DiAd39E6DFkIFZFMX6m
	YEd58t4TbAl24GW+vo9SeZARrsdhvs1WyYqUzaTu+zLkbfJ47IbycKp2PrGTj9S8/upylWIQ3PY
	sud6uuU+3aegC9IhCJg5n772nTau8vdDRN37ZsBf+mvOp96ldZo0s8IW5w73UTn8r195o
X-Gm-Gg: ASbGncteLOyd2qFYpwJUzL5+zdAzSSLpb/PRYmq7Yy+kSnUjWzixMsD27FF9BSMRLU3
	z66Kl4Hcd2jl93gmC4A0z6GCtt4lhyvO6gGFXVaf/qdqwlxlQ/gK6C2c6U9tJAiWV15lt0lCo2v
	Zvm+VrWm14ZlOtNtHrNCOE4dgC+C+rgbQqnGmQo66qAOnUgZry64Qmf/L6UgwcdOvGALYeDkiDI
	iQKASLCD2J4pFulSB86xq6QxUXT/AIzaGz9UalShRJmpWmDi67cMEKtMn1jo8iLq18Q6j4KjxZW
	q05GinOpI0TYEGNp94sDuzVET1scAy259w==
X-Received: by 2002:a05:6000:4313:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-42666ab29d5mr15404678f8f.2.1760510002270;
        Tue, 14 Oct 2025 23:33:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIRF0l4Q21l9jFN9l+tSLarmdL7yzNMiguJ5V8NmivPeOIyz/B0YcSRZ8aXBSFF4p4dY25oQ==
X-Received: by 2002:a05:6000:4313:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-42666ab29d5mr15404659f8f.2.1760510001787;
        Tue, 14 Oct 2025 23:33:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d3b9sm27612424f8f.11.2025.10.14.23.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 23:33:21 -0700 (PDT)
Date: Wed, 15 Oct 2025 02:33:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251015023020-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6Kwp_lqVrQcRVodCag8vAlw56e2_gRTWFce1AlVfTmc_1760510002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrote:
> On Tue, Oct 14, 2025 at 11:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > > > An userland device implemented through VDUSE could take rtnl forever if
> > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > > > device if it does not return the buffer in a longer-than-assumible
> > > > > timeout.
> > > >
> > > > So now I can't debug qemu with gdb because guest dies :(
> > > > Let's not break valid use-cases please.
> > > >
> > > >
> > > > Instead, solve it in vduse, probably by handling cvq within
> > > > kernel.
> > >
> > > Would a shadow control virtqueue implementation in the VDUSE driver work?
> > > It would ack systematically messages sent by the Virtio-net driver,
> > > and so assume the userspace application will Ack them.
> > >
> > > When the userspace application handles the message, if the handling fails,
> > > it somehow marks the device as broken?
> > >
> > > Thanks,
> > > Maxime
> >
> > Yes but it's a bit more convoluted  than just acking them.
> > Once you use the buffer you can get another one and so on
> > with no limit.
> > One fix is to actually maintain device state in the
> > kernel, update it, and then notify userspace.
> >
> 
> I thought of implementing this approach at first, but it has two drawbacks.
> 
> The first one: it's racy. Let's say the driver updates the MAC filter,
> VDUSE timeout occurs, the guest receives the fail, and then the device
> replies with an OK. There is no way for the device or VDUSE to update
> the driver.

There's no timeout. Kernel can guarantee executing all requests.



> 
> The second one, what to do when the VDUSE cvq runs out of descriptors?
> While the driver has its descriptor returned with VIRTIO_NET_ERR, the
> VDUSE CVQ has the descriptor available. If this process repeats to
> make available all of the VDUSE CVQ descriptors, how can we proceed?

There's no reason to return VIRTIO_NET_ERR ever and cvq will not run
out of descriptors. Kernel uses cvq buffers.


> I think both of them can be solved with the DEVICE_NEEDS_RESET status
> bit, but it is not implemented in the drivers at this moment.

No need for a reset, either.

