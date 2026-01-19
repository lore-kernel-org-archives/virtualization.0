Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE853502B7
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768815566; cv=none; b=gkWe6ZpBZ+tcBZkZazNM7ly7e7FXyHwCeiSTdbdjwwz2CQStW1mPE5e4wSvS/Xy27Ckq6ZILfkF8SryI8i2DCvI/hqXeaLCT4iDwc/+Kt/E1PUaaO8vTe6IEY22jyZm9ksDCnmB3Wwo/iWGZgXytpcIbwDp73RTP5uGXAwoENNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768815566; c=relaxed/simple;
	bh=PK23E4LbAZyB80y9PT5PlqOxzIUOmcAumiKThlM4djw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uPzJD1ouLltv2BQACngdAScNh4+7QBidK5SasZzzbHhqdlx1huYYfuG6nC+c0a1+KNCe+CUDpyta/sg5RFXkMDiXM9KMD/GchDg5YoeVFyyGGfxTvmucbIr81wfJtGguZE9b8LyrYZBAuD0QRfmC3yoIeqdqzq7dTe7OVqXZaAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KE3UozL3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KE3UozL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768815564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3GM8FPdhRriZq6AO20diaaV+30mJHwkaKlJ0PtdWcA=;
	b=KE3UozL3qS/mhljDInSOsLnGIGaU9cVWFpel+3XlLer7X4cgpIl+BILk04IoNpregobO/N
	Uzr51xa98wldgSorNNhxlH01jVLQyXFgUyoZGEM2dAvJZ6cIR8oi1wZFuhhOIkJ1QJ3FFn
	KBPXFQLaGfFIoj0XhSLJpkjG9VVbj2U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-bcoIS593O8SfIB5yMpI5Qg-1; Mon, 19 Jan 2026 04:39:22 -0500
X-MC-Unique: bcoIS593O8SfIB5yMpI5Qg-1
X-Mimecast-MFC-AGG-ID: bcoIS593O8SfIB5yMpI5Qg_1768815561
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430f8866932so3466207f8f.1
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 01:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768815561; x=1769420361;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3GM8FPdhRriZq6AO20diaaV+30mJHwkaKlJ0PtdWcA=;
        b=Ud6oCSYCFwjCyHJuLhxT5LPWwBH5bmiBtROofwwDjJqRPzOa13JwG9ev23Fm4FuanB
         ZZjxAQZLErTlH3c2mVNC1BFc9IH6TPRVlNS9m1TonMajenAW9fap8bO2w9Mr3MXN6qOk
         JsteYgZ0vNPpqo2VgByu7xpAPTk5CQmwQ0g3D43cqFlMwkx4EfTayfQWj+sg78BNjGZh
         9Qa3IvlFqJtV4eUA5SiBSryZ/l829xpJb74oeynG4XUixnKuqbn1cNF9EKwVB0a1LaJO
         /YrGHd5EOnhCkyN4E1OPFxtyiRXpfr7yh2NTmYEnf9n3YIOKuAy7rWjyiuTe2aAMeQF3
         43dQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5l3pfHVRDkrLFb1aNkawCuDb1eG/uYpynLk5Dc4EeU+/14UBxzBwF9YpJYmbbWQue/4ayT8QaTPcJh1+K+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGDq+hipAvIBWskkhPrMlacAFHK3dgTwNGbx3H7PthJvO6PvEL
	/luQzfJREpSb7jVpRAJbOkuKGRXEwUI6yMrCsIUaB7Rso94AV430AvW/5Toj7ZViiiQv93LT47e
	jTwGi051Cvt2ZyljV17RaCT1NvWXQDspIHMcbE2poNbZF4zr7cdaZpfIK9D2w6xGqpGGc
X-Gm-Gg: AY/fxX7v6w2dWZ7NTLH0EhfKPA94G7cRrWHuV/7igsiFhU0FJmK4e1lXorrxVzD5rcj
	S0+BnZYOTHfO0nv4jBRQWmrMxo8TV2WwC7kTo1MBf7uRUEBGArrYmAZf2fZ2N269y48MVZ2V3G/
	HJPxLxFT3ooXHgNBVt8Acj/2KD7l7+2teMvUV7lAiyTJYwY2uqjrCmnZgRGWBO0jGiOwl/wC570
	7zyFqHDfmqszP1CD9fABf0/b7HH515Dc8gGr5a9UY/8BdDoCijxBgkoaf1unBCx8zSDexoX9reD
	LU3MCPuuFR7s97Xg2jSrsVLSOLRqJLqC35uYKy7auyDzGI29dIks25xqpg44AT/XEzvldttWLUe
	dW9CBd6L1zuFl2t3sghOy5gKUCabm8Wc=
X-Received: by 2002:a05:600c:3114:b0:46e:4a30:2b0f with SMTP id 5b1f17b1804b1-4801e348326mr132243785e9.29.1768815561287;
        Mon, 19 Jan 2026 01:39:21 -0800 (PST)
X-Received: by 2002:a05:600c:3114:b0:46e:4a30:2b0f with SMTP id 5b1f17b1804b1-4801e348326mr132243355e9.29.1768815560841;
        Mon, 19 Jan 2026 01:39:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fd3bcd2sm84408095e9.1.2026.01.19.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:39:20 -0800 (PST)
Date: Mon, 19 Jan 2026 04:39:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v14 11/13] vduse: add vq group asid support
Message-ID: <20260119043804-mutt-send-email-mst@kernel.org>
References: <20260116140455.1560491-1-eperezma@redhat.com>
 <20260116140455.1560491-12-eperezma@redhat.com>
 <CACGkMEvJB5uyNnxmr=rap14Tc-JSy4=XGAtDZu6rg3+nucXUOw@mail.gmail.com>
 <CAJaqyWf_37cwV6mK-_nj4GnwquSxUYCPFKUOkxCaPQkJ9iewLQ@mail.gmail.com>
 <CACGkMEtyyPJQ3t_ckwZyNRHW2_fqm=09DEe-__Rvz0pQoUqtsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtyyPJQ3t_ckwZyNRHW2_fqm=09DEe-__Rvz0pQoUqtsQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qDeLcF0X2FHQpDhCtCZwrsRozlw747zBQF_SSu6NOVg_1768815561
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 19, 2026 at 04:34:11PM +0800, Jason Wang wrote:
> On Mon, Jan 19, 2026 at 4:10 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Mon, Jan 19, 2026 at 8:17 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Fri, Jan 16, 2026 at 10:05 PM Eugenio Pérez <eperezma@redhat.com> wrote:
> > > >
> > > > Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> > > > group.  This enables mapping each group into a distinct memory space.
> > > >
> > > > The vq group to ASID association is protected by a rwlock now.  But the
> > > > mutex domain_lock keeps protecting the domains of all ASIDs, as some
> > > > operations like the one related with the bounce buffer size still
> > > > requires to lock all the ASIDs.
> > > >
> > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > >
> > > > ---
> > > > Future improvements can include performance optimizations on top like
> > > > ore to RCU or thread synchronized atomics, or hardening by tracking ASID
> > > > or ASID hashes on unused bits of the DMA address.
> > > >
> > > > Tested virtio_vdpa by adding manually two threads in vduse_set_status:
> > > > one of them modifies the vq group 0 ASID and the other one map and unmap
> > > > memory continuously.  After a while, the two threads stop and the usual
> > > > work continues.  Test with version 0, version 1 with the old ioctl, and
> > > > version 1 with the new ioctl.
> > > >
> > > > Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.  A few
> > > > workaround were needed in some parts:
> > > > * Do not enable CVQ before data vqs in QEMU, as VDUSE does not forward
> > > >   the enable message to the userland device.  This will be solved in the
> > > >   future.
> > > > * Share the suspended state between all vhost devices in QEMU:
> > > >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947.html
> > > > * Implement a fake VDUSE suspend vdpa operation callback that always
> > > >   returns true in the kernel.  DPDK suspend the device at the first
> > > >   GET_VRING_BASE.
> > > > * Remove the CVQ blocker in ASID.
> > > >
> > > > The driver vhost_vdpa was also tested with version 0, version 1 with the
> > > > old ioctl, version 1 with the new ioctl but only one ASID, and version 1
> > > > with many ASID.
> > > >
> > >
> > > Looks good overall, but I spot a small issue:
> > >
> > > int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
> > >                                        struct page **pages, int count)
> > > {
> > >         struct vduse_bounce_map *map, *head_map;
> > >         ...
> > >
> > >         /* Now we don't support partial mapping */
> > >         if (count != (domain->bounce_size >> PAGE_SHIFT))
> > >                 return -EINVAL;
> > >
> > > Here we still use domain->bounce_size even if we support multiple as,
> > > this conflicts with the case without userspace memory.
> > >
> >
> > I don't follow you. My understanding from the previous discussion is
> > that the bounce size is distributed evenly per AS. Should we just have
> > a global bounce buffer size and protect that the amount of added
> > memory of all domains is less than that bounce size?
> 
> I meant we require bounce_size / nas to be the size of the bounce
> buffer size of each AS.
> 
> But for userspace registered memory, it requires bounce_size per AS.
> 
> Thanks

I don't really understand what you are saying here, either.
Could you explain what your suggestion is?


> >

