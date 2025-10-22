Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7E33FE2C
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133409; cv=none; b=ATVu2NEsM0QMD1tZm/LcA3yyQ5EXf5FPx+aQP66Q02nYPY6he0A56LG84j40Dvt7GP6vGJP2QD1oeGFEi226dkQEYuKFwQYPIax9KqMJg8xPk2HCNz8VUFd8jH1M0YnErJllzBVWFVquPu1Hdufo8+vg/Wc37bubsV/BKtUgdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133409; c=relaxed/simple;
	bh=c2gkXQ9qcXJtUs/3FfqdNZPZA2zNtwVFuMGrLRxmayY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GtPWvFLyPFqbRlxkH2adWOjffiRqiS1Df09gH9n+FTKfY6z8F4lgonHHkh48XrLeOfLxllgzKtDzO/Hkyo/L0rYLRFmCJhjacEjcNx+s3g30D5VUSDDNTehjz25fr3PFB+FPvNwLxaMfc1rMno4FiEzAboA/oJbHSjgtN/3LvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JafbY4np; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JafbY4np"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761133406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gq9iqnmobSVqV9ZHUp92OeMBuruVUcw0JjePNmGaQbs=;
	b=JafbY4npXi0qiUn2s8DopQiJuPSy7BFCxS9sVyZRtI03xiZdGzDvWz8Cqo4Td8ylLgUQHj
	gAPwaECetLTkiDxo3o6EwI5gr/KD+sXBbtG08U+01vVfslkBptR9cBGP+dywJy3EKQTRhb
	mqB2wWbh5b9PQFvDUcPWyohNGYaHQsE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-Tvs9wGpEN8GTLDeRHvrIoQ-1; Wed, 22 Oct 2025 07:43:25 -0400
X-MC-Unique: Tvs9wGpEN8GTLDeRHvrIoQ-1
X-Mimecast-MFC-AGG-ID: Tvs9wGpEN8GTLDeRHvrIoQ_1761133404
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b4635c413a7so544383266b.1
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 04:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761133404; x=1761738204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq9iqnmobSVqV9ZHUp92OeMBuruVUcw0JjePNmGaQbs=;
        b=P2XAz4QVIfK7ttaXgLsgzMUemHr1tYx+X0UMxxBVX1/sTt/NSs266fwTL6p7XD1kBD
         PLgl3dAI2w6SBrIZV64meQAsbhY+vTZRGKDcylCwh/plGDSlpaFdMxGvNqoBpO3uaa2Z
         RFfZPvHBchtsfSQ2hXuqHWBUKELK8/uyECl+hHU/jE3ppOg+ApAnWXFEQNlUupn6wEYz
         ACZG+ckrxarjG/cdtHakeyBO9KJNWiGQGQAsIAJakqkoYefIEf6AXPw7c5CHSAYHPKtm
         tITwSdfvSE27oZr8NUgx4gMSvDxBXVFfqTxVtaUJK7aNEXCEslUH8NCF4DhWGggzNqjF
         RDzg==
X-Forwarded-Encrypted: i=1; AJvYcCWOhZtpmVMF6vFDGYHGX7AhWG8ilqyWJ2U6QINUYp7o48UksLJJ3m8Z+QT4+z6qapByUUAu1gK5InHRX6/b5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwB3LAxFYp8TThkVzlKvADchXuhC7wUEjK1y819tx0IJk78r2zt
	xFxAmGgRPS5nC82n8jaWmqm1u3E23+W3rPSd7hUsSXJWx7aH9rJ1V+bVNpPAexdDrAK/bmZjDsF
	ocTS919qJ3n2hodw4htqQN0zmqWwdtYMy0DO5tQ8xcXqzx8utCt0ZbtEurhoTLnNpA0DJ
X-Gm-Gg: ASbGncvb56skMP5WOs/xUcE24Ctni3qxHnKTZa9rTb++Nqd3ySkDZmSP6Pc/yC7Vvp7
	9xgz5QY6qcOtj22XaTBYrrjqLP7taOyHJo4OkRTirZ8mHxaQ4NvzubDwnV3PRPs0I0FKqI6zjOs
	rnxcivV+GA86+Eriqjuy60ZAK1wefckbEd0B7hz6p5f/ARhIMFi85dw10H54q/mC3jz0Oh+NvcI
	jEBQDkaa12UO0e45LLBsE8T1PExugt0MEwe8qnvYlk8hKQpC9UUyq4eRllMrhjzxK5MW5T10qvj
	4BidivbwkkTXiUQvkki0v/ScTJZKZowCyTELzxHWfk0vS74j9NAtsS9rKsZegs1T
X-Received: by 2002:a17:907:7ba5:b0:b41:a571:21b0 with SMTP id a640c23a62f3a-b6475ff442amr2415779366b.39.1761133403998;
        Wed, 22 Oct 2025 04:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZGzSladakOrxLxalLSUPQkdwcOvpWAWqSmSMF7sigp17wPG2uCWvHCAJbfBX3zgt7DTEEUw==
X-Received: by 2002:a17:907:7ba5:b0:b41:a571:21b0 with SMTP id a640c23a62f3a-b6475ff442amr2415776466b.39.1761133403330;
        Wed, 22 Oct 2025 04:43:23 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8971897sm1318623966b.37.2025.10.22.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:43:22 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:43:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251022073231-mutt-send-email-mst@kernel.org>
References: <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org>
 <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MKEWdd_Qqp94SBG3YB_ZLMFDIlG_M9KdWivBPY9toqg_1761133404
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> Let me switch to MQ as I think it illustrates the point better.
> 
> IIUC the workflow:
> a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> b) VDUSE CVQ sends ok to the virtio-net driver
> c) VDUSE CVQ sends the command to the VDUSE device
> d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
> e) VDUSE CVQ sends ok to the virtio-net driver
> 
> The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
> so it potentially uses the second rx queue. But, by the standard:
> 
> The device MUST NOT queue packets on receive queues greater than
> virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> command in a used buffer.
> 
> So the driver does not expect rx buffers on that queue at all. From
> the driver's POV, the device is invalid, and it could mark it as
> broken.

ok intresting. Note that if userspace processes vqs it should process
cvq too. I don't know what to do in this case yet, I'm going on
vacation, let me ponder this a bit.


> And, what's worse, how to handle it if the device now replies with
> VIRTIO_NET_ERR to the VDUSE CVQ?

this part does not bother me much. break it, probably.

> > > If we wait for the device to reply, we're in the
> > > same situation regarding the RTNL.
> > >
> > > Now we receive a new state (A, B, E). We haven't sent the (A, B, D),
> > > so it is good to just replace the (A, B, D) with that. and send it
> > > when (A, B, C) is completed with either success or failure.
> > >
> > > 2) VQ_PAIRS_SET
> > >
> > > The driver starts with 1 vq pair. Now the driver sets 3 vq pairs, and
> > > the VDUSE CVQ forwards the command. The driver still thinks that it is
> > > using 1 vq pair. I can store that the driver request was 3, and it is
> > > still in-flight. Now the timeout occurs, so the VDUSE device returns
> > > fail to the driver, and the driver frees the vq regions etc. After
> > > that, the device now replies OK. The memory that was sent as the new
> > > vqs avail ring and descriptor ring now contains garbage, and it could
> > > happen that the device start overriding unrelated memory.
> > >
> > > Not even VQ_RESET protects against it as there is still a window
> > > between the CMD set and the VQ reset.
> >
> > Timeouts should be up to userspace. If userspace times out
> > and then gets confused, kernel is not to blame.
> >
> >
> 
> I meant the virtio-net driver will be confused.

