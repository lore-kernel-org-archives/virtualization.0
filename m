Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962C3126DF
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127785; cv=none; b=rSVMPDALZXFMQF4Nw61RsqPwiZKG2mKRdRO0iLR/3RkYf5eRK4mnHOcpQaBPocFOXRdsjPwRmMFsUac4emImksQSWjJLprZ/DSKdE4mzig7W33mUOt6/vCFP4iqWX1aCjd25eC3dMc77M7XCt/RcjQOlFezNvU/efG/3HZNMGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127785; c=relaxed/simple;
	bh=C9Mm2dxFST1Npvlr+6IUglDpwNOV6KogFRdlIU8hkYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lGpByDNs4uqJlTXB6mqnO5VTWAG6YXCjb2Fs4FALcxZRrZK7KYZ1cWDSAIvi+kARLKmmjiuzUqVw4v19R9v//D+McOD2/iW+0MgqaOeYxghqM1f30y8zkiOKOV2v6KHzdDMjGNQSpnWEfd9mTv/N0o2R3GIXzX2hPPOFskM8/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGyYWQNx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGyYWQNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761127782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQ6PGT7U8Zjz5PqrsvnmsOYhktAt3PvByfU6TEvf+S0=;
	b=NGyYWQNxNqFCYeTEi/gPyRIvk3+j1VXbEMwwQLL88OHnO0EiQdVexB1g2HYpdW8ZpJd7YU
	oHqX1RnNIZIKeYpaoLods7KMAfaCRjTgf8Ryn8YQSAOH4MpN/MHi3MkDPeYEV5VlFChUG+
	Ne0/c7F/wHNsOeaPlTDUgAXBZ2+QkWE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-zuKH25QvM5qDsZLzxHtHhQ-1; Wed, 22 Oct 2025 06:09:41 -0400
X-MC-Unique: zuKH25QvM5qDsZLzxHtHhQ-1
X-Mimecast-MFC-AGG-ID: zuKH25QvM5qDsZLzxHtHhQ_1761127780
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b2d1072a9c4so650300066b.3
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 03:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127780; x=1761732580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQ6PGT7U8Zjz5PqrsvnmsOYhktAt3PvByfU6TEvf+S0=;
        b=O1q7ZF5ZJ3qJGHh2j2sSoZYSz3kkemTCexqWYGIkroQMUOM3+rzf+5/R9zj4wk8bTr
         HvJjTcwhPzOn4V2Va3O0iwOff1Kmb3oWhEjkRos+LFNIL92/IJAv+IghSuUT6ssQyRm2
         I0IqnHa579L46PsM5A9tJRu7pvJDzm8E7HhVTSQRcKauEQENSur9mBfy1rMPl/x/2XPT
         EkR9WOjZqzJpe9U5jiljFMFN1nuhRs/SGKeFjUM1k7spA2b07BZX6Kl4e3mkPG5LITNh
         DyWAHcL5gkDm9SLOENdqpjLwcJtp1BZH9G8nWWnwEz64np8z7IT5qHW1CLDJbV1jkLrK
         ourQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGUdLr9cMVS4RtbpsmdB/VBjMeA+0KTkgv/JGc4pijN6UKYld5kjnzHuy2qiKgWd2KcgiV78RVRXlWwMvaCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS6GKYWHNFM6lXsBRhaAlgXhZNnNj6x8DT4RRMmyAmVfY8X5P0
	753ZP5soVfxSCN+x+S0+yRKt/SpvjfwG37xXVFl/HzYyrt9BwsNBDRm+y6fsINSPmMdFxHpgMSs
	zGZZEtMsp8k+BQxGLkce3aiUn9biID9z4lE0VFJAFMwhiUdqFvOwNrszMxDkUEbupMZ0R
X-Gm-Gg: ASbGncs2VHH8ubrDvAArqjGwVpG/ABt4lZLeXpHJO5hM66XXM1vOPfS2XlcJNi5WK57
	CudzymKygkrJqilFVMZ3mE5+6VF6MfhbOat/yfdTllGzIkCL9BHIX2Jy/rxptMTqM6Ya+TZm+AS
	RRxgWpzrf7WSKjA/2npY3X2Od1+tgnpKnz8ghyMc9fyYMaAujslb0BaTeUMPZ5fdwN+oy1z6uBZ
	a5CBuEBLbGMLmRRn41ES9xxdmsK++/vnLMM5PKSDxzMC8FRe+b9LupKW8PzyDMyXKiENTnIR0eK
	DGKBCjo/h6DN5ONwd4sfvV5gZK3vK1B/vTzzywH8wJolurl5uWkjG2O5pyxh5jUE
X-Received: by 2002:a17:906:ef07:b0:b57:43c1:e194 with SMTP id a640c23a62f3a-b647254f794mr2555186366b.11.1761127780159;
        Wed, 22 Oct 2025 03:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXWFxmOeM7ei0B+Fi8xm1ol8UHOjWwepsbziS5ZeH0FMm1eWC/BMCVsnSG89pccSJHbOLuAg==
X-Received: by 2002:a17:906:ef07:b0:b57:43c1:e194 with SMTP id a640c23a62f3a-b647254f794mr2555182266b.11.1761127779531;
        Wed, 22 Oct 2025 03:09:39 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6aaf93a32asm853297866b.51.2025.10.22.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:09:39 -0700 (PDT)
Date: Wed, 22 Oct 2025 06:09:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251022060748-mutt-send-email-mst@kernel.org>
References: <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L9cefsdA4_8-wnUgIcXCYrfurwu1KD5CYy84BrHx-P4_1761127780
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 15, 2025 at 12:36:47PM +0200, Eugenio Perez Martin wrote:
> On Wed, Oct 15, 2025 at 10:09 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 15, 2025 at 10:03:49AM +0200, Maxime Coquelin wrote:
> > > On Wed, Oct 15, 2025 at 9:45 AM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Wed, Oct 15, 2025 at 9:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrote:
> > > > > > On Wed, Oct 15, 2025 at 8:33 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrote:
> > > > > > > > On Tue, Oct 14, 2025 at 11:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > > > > > > > > On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > > > > > > > > > > An userland device implemented through VDUSE could take rtnl forever if
> > > > > > > > > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > > > > > > > > > > device if it does not return the buffer in a longer-than-assumible
> > > > > > > > > > > > timeout.
> > > > > > > > > > >
> > > > > > > > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > > > > > > > Let's not break valid use-cases please.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > > > > > > > kernel.
> > > > > > > > > >
> > > > > > > > > > Would a shadow control virtqueue implementation in the VDUSE driver work?
> > > > > > > > > > It would ack systematically messages sent by the Virtio-net driver,
> > > > > > > > > > and so assume the userspace application will Ack them.
> > > > > > > > > >
> > > > > > > > > > When the userspace application handles the message, if the handling fails,
> > > > > > > > > > it somehow marks the device as broken?
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Maxime
> > > > > > > > >
> > > > > > > > > Yes but it's a bit more convoluted  than just acking them.
> > > > > > > > > Once you use the buffer you can get another one and so on
> > > > > > > > > with no limit.
> > > > > > > > > One fix is to actually maintain device state in the
> > > > > > > > > kernel, update it, and then notify userspace.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I thought of implementing this approach at first, but it has two drawbacks.
> > > > > > > >
> > > > > > > > The first one: it's racy. Let's say the driver updates the MAC filter,
> > > > > > > > VDUSE timeout occurs, the guest receives the fail, and then the device
> > > > > > > > replies with an OK. There is no way for the device or VDUSE to update
> > > > > > > > the driver.
> > > > > > >
> > > > > > > There's no timeout. Kernel can guarantee executing all requests.
> > > > > > >
> > > > > >
> > > > > > I don't follow this. How should the VDUSE kernel module act if the
> > > > > > VDUSE userland device does not use the CVQ buffer then?
> > > > >
> > > > > First I am not sure a VQ is the best interface for talking to userspace.
> > > > > But assuming yes - just avoid sending more data, send it later after
> > > > > userspace used the buffer.
> > > > >
> > > >
> > > > Let me take a step back, I think I didn't describe the scenario well enough.
> > > >
> > > > We have a VDUSE device, and then the same host is interacting with the
> > > > device through the virtio_net driver over virtio_vdpa.
> > > >
> > > > Then, the virtio_net driver sends a control command though its CVQ, so
> > > > it *takes the RTNL*. That command reaches the VDUSE CVQ.
> > > >
> > > > It does not matter if the VDUSE device in the userland processes the
> > > > commands through a CVQ, reading the vduse character device, or another
> > > > system. The question is: what to do if the VDUSE device does not
> > > > process that command in a timely manner? Should we just let the RTNL
> > > > be taken forever?
> > > >
> > >
> > > My understanding is that:
> > > 1. Virtio-net sends a control messages, waits for reply
> > > 2. VDUSE driver dequeues it, adds it to the SCVQ, replies OK to the CVQ
> > > 3. Userspace application dequeues the message from the SCVQ
> > >  a. If handling is successful it replies OK
> > >  b. If handling fails, replies ERROR
> 
> If that's the case, everything would be ok now. In both cases, the
> RTNL is held only by that time. The problem is when the VDUSE device
> userland does not reply.
> 
> > > 4. VDUSE driver reads the reply
> > >  a. if OK, do nothing
> > >  b. if ERROR, mark the device as broken?
> > >
> > > This is simplified as it does not take into account SCVQ overflow if
> > > the application is stuck.
> > > If IIUC, Michael suggests to only enqueue a single message at the time
> > > in the SVQ,
> > > and bufferize the pending messages in the VDUSE driver.
> 
> But the RTNL keeps being held in all that process, isn't it?
> 
> >
> > Not exactly bufferize, record.  E.g. we do not need to send
> > 100 messages to enable/disable promisc mode - together they
> > have no effect.
> >
> 
> I still don't follow how that unlocks the RTNL. Let me put some workflows:
> 
> 1) MAC_TABLE_SET, what can we do if:
> The driver sets a set of MAC addresses, (A, B, C). VDUSE device does
> send this set to the VDUSE userland device, as we don't have more
> information. Now, the driver sends a new table with addresses (A, B,
> D), but the device still didn't reply to the VDUSE driver.
> 
> VDUSE should track that the new state is (A, B, D), and then wait for
> the previous request to be replied by the device? What should we
> report to the driver?

you reply OK to the driver immediately.

> If we wait for the device to reply, we're in the
> same situation regarding the RTNL.
> 
> Now we receive a new state (A, B, E). We haven't sent the (A, B, D),
> so it is good to just replace the (A, B, D) with that. and send it
> when (A, B, C) is completed with either success or failure.
> 
> 2) VQ_PAIRS_SET
> 
> The driver starts with 1 vq pair. Now the driver sets 3 vq pairs, and
> the VDUSE CVQ forwards the command. The driver still thinks that it is
> using 1 vq pair. I can store that the driver request was 3, and it is
> still in-flight. Now the timeout occurs, so the VDUSE device returns
> fail to the driver, and the driver frees the vq regions etc. After
> that, the device now replies OK. The memory that was sent as the new
> vqs avail ring and descriptor ring now contains garbage, and it could
> happen that the device start overriding unrelated memory.
> 
> Not even VQ_RESET protects against it as there is still a window
> between the CMD set and the VQ reset.

Timeouts should be up to userspace. If userspace times out
and then gets confused, kernel is not to blame.


