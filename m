Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89533031F
	for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662579; cv=none; b=nahmjXtidTyz9+WuQmJxDwam59ZP4I/0uLjmkkaent3WO43tgLskPrxIeIArX6nA63hEa0vh2VEruQUCZzjg4fXhfynDjiVSjzfJUhx66nx57uBIY9rDAhLq1n+RAnUuOo6p6HaSlAfeHN3f0G6PhurU5wAJhIk8N4lZQ88wea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662579; c=relaxed/simple;
	bh=Qj7vk7uTH1BUaGwkyY9Q/6UjhXjCxtzuh88Iuht0Qho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=um4aFZ3BBiKFEYQihqp7lRj+vGe+yuDFJXRJr7WfI+8hqEeuyPklvcUEIcjQa3/55U+TdAgCTzikJ3qsasAGEMjS/W9zd5vL37wVfXruzQFKxTho1XeXqGw50whbjaGPBChhwcIsbdeeyqGGE0RNO5l3yGNWkXuGF7vEq1m3xE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HP+ZIJp1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HP+ZIJp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761662574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woPx9WhmwY04MjIk66oosoLlHaAzSD9kVyrfhGb0WyQ=;
	b=HP+ZIJp1FnbGjRmlJ8Ipq/+0qj9USBw2vpkwFugS6t+uyEspdYeiTLo/Y+VGEgS30+rLDB
	ThmLc3u3h2zjtrlpw6H5GsEWJ7K+EKN87qM/2Fpu/DcHYwdifs1PxbWmM7H+0n6jGqWD+k
	FqW42UCi7oW5jixg7aY4QBrcuHiB0Fc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-TS06RuWxOk2nipB6rNb_jA-1; Tue, 28 Oct 2025 10:42:53 -0400
X-MC-Unique: TS06RuWxOk2nipB6rNb_jA-1
X-Mimecast-MFC-AGG-ID: TS06RuWxOk2nipB6rNb_jA_1761662572
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-63c588cb6d5so3807828a12.1
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 07:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761662572; x=1762267372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woPx9WhmwY04MjIk66oosoLlHaAzSD9kVyrfhGb0WyQ=;
        b=FxJ2Tl2QZVGHWUjrCTZ+JE/e+8sFa3bnOkLq2LCTwLIvI+WvURSDLMCmYGreSsN+5k
         q+mhOROvRoIG7paUD+Grq3ALCyrn1Eb4xBwfaeAXPoPC4tp/qifxj6l5neIRxHqbvU8+
         yfrf6S/Pka7p845FruGiFMea4WpOkt9oniJ+liCqSzZBBsLvtoyKZ01OMPqLSLQVVdWH
         1y42BhAOYLEpzB39SX6HYA9Ny08xA964ovCJoBlZds/W38md7g8TL2goykZqigYQ4YRk
         AphIEutYDjAr8+lafUYBCOKkl4/rS+w+fbaNLaxl7bKLbThXTCY5fG2Dw7iKcfv0EG+Q
         YxZA==
X-Forwarded-Encrypted: i=1; AJvYcCXMMf4YGGnmoVMGo31d7TERQv+E90DrXrcX+QQ8do7YAIpg19cXpO5S+C5P0xhi/xIy4oy9uBFhDMzmQwZfeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1TzwRWCRtpB3PFgYtGSFqbCq1XMP50gpC27H1CNWq5Dq2C59p
	w4ElHwd1l/Wo/3HLFE+UFCQksHQBsPLTqbXC76cd79l3eENpNxNI54qNIAIabOTx/ul23oQI9+l
	3ZO2KVsuetEJ7bEkrknF73nySEzyQk6rzYDR6Z9X0I6n8YSlSfaqogjm/dTX2obGXbnCSuxX3ZW
	fE
X-Gm-Gg: ASbGncsL12nVPrSNYgirf/Ge+vs/T7WvJFKj7qXR0KGbwVE8gZWu+xvrAQSgQRjJVXh
	wvcSd+G2xB/CoRssZBPGfglenL9nbB9D5yUIKtii+oaeVsea9j923v1JJuyIKNk6Um+bkXP0lH2
	PVazBVBGh7nJdKqDGMlK7kYXzbl6dWb6L6eIflDt8BwIR2v2WaBXdabJ0h7IR6s47KehOwyaXot
	nnbUP/5fvVT32eI5UlbMnT+79n2yS0OsaOJtX2D6Qx8Lo9QyJFf1sLml/kONINd1F2muXIp3U2B
	FUouuHeAQoq77//B4lJhel7bDHP9CWkOM6B8OFrDKpCxdsN0Wgug4ngAGRzB6lod
X-Received: by 2002:a17:907:2da2:b0:b6d:76a9:e7de with SMTP id a640c23a62f3a-b6dba45b18cmr383531366b.8.1761662572128;
        Tue, 28 Oct 2025 07:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX+9QwURp9/sS/6BgNcaqFOSOydpvsqcU1BGjMxVWZLPbegGZKTa+1qvtbiLD844pPi67X3A==
X-Received: by 2002:a17:907:2da2:b0:b6d:76a9:e7de with SMTP id a640c23a62f3a-b6dba45b18cmr383529666b.8.1761662571688;
        Tue, 28 Oct 2025 07:42:51 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85413b88sm1090546266b.55.2025.10.28.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:42:51 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:42:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251028104154-mutt-send-email-mst@kernel.org>
References: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org>
 <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org>
 <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org>
 <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TND2PxFJkboKgFP5MB88s1-JFTO0ff8ZXfZ7Iu0AoEU_1761662572
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrote:
> On Tue, Oct 28, 2025 at 3:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrote:
> > > On Wed, Oct 22, 2025 at 1:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> > > > > Let me switch to MQ as I think it illustrates the point better.
> > > > >
> > > > > IIUC the workflow:
> > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
> > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > >
> > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
> > > > > so it potentially uses the second rx queue. But, by the standard:
> > > > >
> > > > > The device MUST NOT queue packets on receive queues greater than
> > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > > > > command in a used buffer.
> > > > >
> > > > > So the driver does not expect rx buffers on that queue at all. From
> > > > > the driver's POV, the device is invalid, and it could mark it as
> > > > > broken.
> > > >
> > > > ok intresting. Note that if userspace processes vqs it should process
> > > > cvq too. I don't know what to do in this case yet, I'm going on
> > > > vacation, let me ponder this a bit.
> > > >
> > >
> > > Sure.
> >
> > So let me ask you this, how are you going to handle device reset?
> > Same issue, it seems to me.
> >
> 
> Well my proposal is to mark it as broken so it needs to be reset
> manually.


Heh but guest assumes after reset device does not poke at guest
memory, and will free up and reuse that memory.
If userspace still pokes at it -> plus plus ungood.

> For example, unbinding and binding the driver in Linux. The
> point is that the driver cannot trust the device anymore as it is in
> an invalid state. Maybe suspend and reset all the vqs is also a valid
> solution to un-broke it if the device supports it but I think a race
> is unavoidable there, and I'm not sure how to communicate it to
> userspace for all kinds of devices. Incrementing rx errors could be a
> first proposal.
> 
> If we want to track it in VDUSE we should implement NEEDS_RESET and
> leave all the old drivers without solution. That's why I think it is
> better to solve all the problems at once in the driver.

