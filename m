Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA919B3E1
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877728; cv=none; b=jIzXwI246gAgCg3HThSr0KUZ2gQTJQLLCvjhQRlcOjY3y9O7d5/sQllsMnsX/9ookH+xdfkdvxW6z8nnT20xjnnsPv6uNFgFqM3HmI+NG+tN9wCWPo3LG4cV9Ao0r4QlDiBcc6VSGumqazZErE2o5OvqR7u0u0W/zAaFf0BWSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877728; c=relaxed/simple;
	bh=5dhDiFusAAN4M6pX4JzcMcygCEmAn6CQoqfdwB//obU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oeyVfCAmXfUJPtjCrV6VB6fhumk8QyG1LSLwELE214SMvoxvcnIQlpE45QqXDSTBhUvuJsrGvxLS10AmfjIOOO1DDpNDBfwhcrRSTbQh6ov02tSoZBLrCQ8L+7zTXp+yLLq/Pc9WW6FDHiTNzTnsnrUUJ9QvnRWF3XNWfGwfuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uv6M1ovf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uv6M1ovf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718877725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDuLutVSNe5rSO4mU2km20/sLHcVu1RDWVk3Uo1JFTE=;
	b=Uv6M1ovfEFPWomZejZy9IHdG0cjR315N35xQFh7VWxDbEu12wJx0IVLYoinVfMpfh+AXzt
	mby4gFvN70oYlf6rSGo7PbhwCFZAVKIw3bd7SAo0gmvrGHP2qMKN4zrtr6kRcqGFaiILiu
	FiEZz2YK9geQ/fXFHX0uz+sfUDXz3go=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-t4Uko_CQOvWCJpYGWaM44g-1; Thu, 20 Jun 2024 06:02:04 -0400
X-MC-Unique: t4Uko_CQOvWCJpYGWaM44g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6ec06ed579so35058366b.2
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 03:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718877723; x=1719482523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDuLutVSNe5rSO4mU2km20/sLHcVu1RDWVk3Uo1JFTE=;
        b=AbdXjVwiPni/tNT7IXpLJJN++05NUwx5OGuaBUZQxzJBXTcF9ImIHQrSpgQ4Tjnc5b
         YqIB//VuU5u4C86/Z77XEYaNBwJiJm2F/I11ABltNE/tOGJHUqzBAJI4RXadX/n/7a9d
         1QdXOvnNh4wrUaNbXzIf1HYsKWwJ39ASRyPjvYK8G93Am57w/Ix7d7pa05FDt1G8EB6o
         abJcIztCc5plHjDXpHvGGBM+NWMprDd9oQC3HZmgr/0YEwddp6sCQd+ngHCTJOnno4xO
         kI0a6zQ8WaJZ5ZNYHHNxp/brfFGG1XcSBzUpp7s6oy3ezAM6vyuDcCN8n9vF6F+inyOP
         EFkw==
X-Gm-Message-State: AOJu0Yw3xqx86U5RvL9PZQDRN4ZBOb31ZDTZrY8Udy8p1opjnUYJo5ux
	R+veBYdnu82vGCeP38d5EqCvHv8Fgk1w2exhodirwU15wWgdfbGOllBukwrG9cqHAlGyVksuu0d
	bgctNeDouxC+cVoIbpJjB0uqGXOXS1VvvAF29E7Z9CQdOAM2/SKsxUjX0dki2N27s
X-Received: by 2002:a17:906:a398:b0:a6f:3f75:41ac with SMTP id a640c23a62f3a-a6fab7d7c2emr269528966b.63.1718877722556;
        Thu, 20 Jun 2024 03:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOVPKUPfyHjzvCp3jOmaukYXIFLJ/paPmYIKro+AvCHkv/tuVFAiJNm8SiwWX/rjwGdLuqWQ==
X-Received: by 2002:a17:906:a398:b0:a6f:3f75:41ac with SMTP id a640c23a62f3a-a6fab7d7c2emr269525766b.63.1718877721990;
        Thu, 20 Jun 2024 03:02:01 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56fa4150sm757023766b.212.2024.06.20.03.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:02:01 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:01:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH vhost v9 2/6] virtio: remove support for names array
 entries being null.
Message-ID: <20240620054548-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-3-xuanzhuo@linux.alibaba.com>
 <20240620035749-mutt-send-email-mst@kernel.org>
 <1718872778.4831812-1-xuanzhuo@linux.alibaba.com>
 <20240620044839-mutt-send-email-mst@kernel.org>
 <1718874293.698573-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1718874293.698573-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 05:04:53PM +0800, Xuan Zhuo wrote:
> On Thu, 20 Jun 2024 05:01:08 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 04:39:38PM +0800, Xuan Zhuo wrote:
> > > On Thu, 20 Jun 2024 04:02:45 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Apr 24, 2024 at 05:15:29PM +0800, Xuan Zhuo wrote:
> > > > > commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> > > > > support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> > > > > doesn't apply. And not one uses this.
> > > > >
> > > > > On the other side, that makes some trouble for us to refactor the
> > > > > find_vqs() params.
> > > > >
> > > > > So I remove this support.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > Acked-by: Eric Farman <farman@linux.ibm.com> # s390
> > > > > Acked-by: Halil Pasic <pasic@linux.ibm.com>
> > > >
> > > >
> > > > I don't mind, but this patchset is too big already.
> > > > Why do we need to make this part of this patchset?
> > >
> > >
> > > If some the pointers of the names is NULL, then in the virtio ring,
> > > we will have a trouble to index from the arrays(names, callbacks...).
> > > Becasue that the idx of the vq is not the index of these arrays.
> > >
> > > If the names is [NULL, "rx", "tx"], the first vq is the "rx", but index of the
> > > vq is zero, but the index of the info of this vq inside the arrays is 1.
> >
> >
> > Ah. So actually, it used to work.
> >
> > What this should refer to is
> >
> > commit ddbeac07a39a81d82331a312d0578fab94fccbf1
> > Author: Wei Wang <wei.w.wang@intel.com>
> > Date:   Fri Dec 28 10:26:25 2018 +0800
> >
> >     virtio_pci: use queue idx instead of array idx to set up the vq
> >
> >     When find_vqs, there will be no vq[i] allocation if its corresponding
> >     names[i] is NULL. For example, the caller may pass in names[i] (i=4)
> >     with names[2] being NULL because the related feature bit is turned off,
> >     so technically there are 3 queues on the device, and name[4] should
> >     correspond to the 3rd queue on the device.
> >
> >     So we use queue_idx as the queue index, which is increased only when the
> >     queue exists.
> >
> >     Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> That just work for PCI.
> 
> The trouble I described is that we can not index in the virtio ring.
> 
> In virtio ring, we may like to use the vq.index that do not increase
> for the NULL.
> 
> 
> >
> > Which made it so setting names NULL actually does not reserve a vq.
> >
> > But I worry about non pci transports - there's a chance they used
> > a different index with the balloon. Did you test some of these?
> >
> 
> Balloon is out of spec.
> 
> The vq.index does not increase for the name NULL. So the Balloon use the
> continuous id. That is out of spec.


I see. And apparently the QEMU implementation is out of spec, too,
so they work fine. And STATS is always on in QEMU.

That change by Wei broke the theoretical config which has
!STATS but does have FREE_PAGE. We never noticed - not many people
ever bothered with FREE_PAGE.

However QEMU really is broken in a weird way.
In particular if it exposes STATS but driver does not
configure STATS then QEMU still has the stats vq.
Things will break then.


In short, it's a mess, and it needs thought.
At this point I suggest we keep the ability to set
names to NULL in case we want to just revert Wei's patch.



> That does not matter for this patchset.
> The name NULL is always skipped.
> 
> Thanks.


Let's keep this patchset as small as possible.
Keep the existing functionality, we'll do cleanups
later.


> > --
> > MST
> >

