Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769FB30E0C9
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518590; cv=none; b=qiC7iX0K9yHMPTpJCkbA5YVzwW1f+uJWQ30N8rEjYH/OcmrZrpxAdSZ964/z/O4F5Pqcpi2Rj0E7Ymadgz2CLDHc+BXZd/z3FVX3aFA0ki5Ry1/HN4nI3BG/4mnU3f1tAkgGdEEWpDIXW6gV9SeNqgkczHWfkmXsyDIQNFdXBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518590; c=relaxed/simple;
	bh=aX0ppwvrxQtCilmjtLhlmGJxM/amdtR0qU3OoxYkR9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jJ89aQ/I7dPf89yM9QUPFpuhzRoYL3sqCo1rfk5+Q1I+n9mbGwlJB9u3iRqn5X4hBeWpNcY2qSAgF+ZD2wnrEKKysrggLaqj6jgiTAIsDGT/lXxDSX18DtH+uQPjkEm5GSxuNBrdYp5cTP4FgTSIw8di2+wCRyOLCG/+R9ntEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTJfCaK/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTJfCaK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755518587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLE2lYRhrpJm9URBECoaPw5p007Ex98xqleh1QLEKQs=;
	b=JTJfCaK/tuHtNUR0uoU+o6FZ+0kMkmGLsf6g9swxnZID0l1eyfFsddpZrTWRmNzNcqHKU3
	JmT8S+XHWL539Agqg/JaboqNVx9AE4m+EDYXBKtzq5UVEZKvF5IDFKpJTSG1K1zpNYMz3g
	SrdE/NpaYWse0FEIU+qtrc0iuHavGH8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-J1eYM2W9NKGbUyBaTnz4-Q-1; Mon, 18 Aug 2025 08:03:02 -0400
X-MC-Unique: J1eYM2W9NKGbUyBaTnz4-Q-1
X-Mimecast-MFC-AGG-ID: J1eYM2W9NKGbUyBaTnz4-Q_1755518581
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9e743736dso2054210f8f.3
        for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 05:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518581; x=1756123381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLE2lYRhrpJm9URBECoaPw5p007Ex98xqleh1QLEKQs=;
        b=L2ntK3jOUP32AMqTXYNmd8SylBrVYfBAu0AGVwJNJJq5ge6oIMs8LW/nJDnflblrxI
         M2ZTiChD39qqSa7bHqLo6n+amFzFwipfYkdiDCkq866jjnFwecBgel9HKjI1oqU94Xs9
         iKYIRH0PQizLiNgIYQ8vpdz59gBYzB3wTc3r5ycQF/nWwTIxscYSNV3wMXn6oxWnrHuo
         rVTNzaF3cnLtrEDOc7P21tA6d7zf9dev4VzfGGeLIfOIsoYtMQ0jg4k/4Rq4zenE85oi
         LsgGdqw9PutfxgjcAq/7iJ0nyAbWwmtukYBxr5/jNUjwc+z0JHisdoU189tavT+3GAv5
         ujGQ==
X-Forwarded-Encrypted: i=1; AJvYcCURbHY8GJHuAdIMpYihacDdaZo6/0SfVkwg6h4JJ+EMJj4UAVthwqc93mcRmSKWF9W3kNhjHMwxj0rlCapFng==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzqqs6ZRqU8UbCYD7FSXUIKLsiMjoNnUrev02P2yIp34OLJ6D9F
	G9GRm2SC596Sul++OoLWg6j+0+uIx364dSJuXe146rp97Abb/eWWchCqWrvIjFPAMvdJqCUbpcz
	YO6kKNav4TAQxV8a3TiVcAFvPdsoRQYnX1AjMiLixeSourP1qasmtMUw2fH+zoLmSgvYo
X-Gm-Gg: ASbGncuvDbHxHMRSIIQyJoRgm66LgETa0StS+i/riUr87YE5Qjpu9l4z+XCpV9S8r0m
	ReCsYFPpEyBA4T7YdOSRGcLtXNqdCwCM/gu777AV2NM6sja6nLZQ3/TYrdgEBmVNdHBxsct7sTZ
	hsI7P4fABJDYUqeXgDRrR465/piqmYkJh5ZHbgxbxch0yCItMXXB8MwJ7OTGMas5ATIbRV7YedU
	bpBkhrQhsW2IHurjy4ApYPy+hMKq9yO1dd5xPWCpdg9wSoM93LaQlizjtwRWow11Lyi4b6dApiz
	BBSXJz2jFX7YUIBwHk7AcJCtGAAN509P
X-Received: by 2002:a05:6000:1a8e:b0:3b8:d115:e6c7 with SMTP id ffacd0b85a97d-3bb68a167c4mr8471601f8f.33.1755518581077;
        Mon, 18 Aug 2025 05:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYzqZmffMklSj2Qi5PMXTUCEGdHYiVCyTvHGGQFSd6yY3SKyObBGhysM4csYFePqDKpPJBQw==
X-Received: by 2002:a05:6000:1a8e:b0:3b8:d115:e6c7 with SMTP id ffacd0b85a97d-3bb68a167c4mr8471575f8f.33.1755518580568;
        Mon, 18 Aug 2025 05:03:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb7f02578dsm12845133f8f.62.2025.08.18.05.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:02:59 -0700 (PDT)
Date: Mon, 18 Aug 2025 08:02:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
Message-ID: <20250818075749-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-5-jasowang@redhat.com>
 <20250813043151-mutt-send-email-mst@kernel.org>
 <CACGkMEuKmn4f9spFT1YxjVPxBFkdGVCTQEUpNG=xHd6hcL-a8w@mail.gmail.com>
 <20250814063927-mutt-send-email-mst@kernel.org>
 <CAJaqyWcxV+f6dhKLscGGy0bw2YWJ8NaJ4QN+Qe3Ax7C+Lf4X-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcxV+f6dhKLscGGy0bw2YWJ8NaJ4QN+Qe3Ax7C+Lf4X-g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KTrNsugvSYO7fGBHoo1tsCneBGXgy3Csow4M2n3oDfk_1755518581
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Aug 18, 2025 at 11:09:44AM +0200, Eugenio Perez Martin wrote:
> On Thu, Aug 14, 2025 at 12:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Aug 14, 2025 at 11:36:22AM +0800, Jason Wang wrote:
> > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > index addbc209275a..37029df94aaf 100644
> > > > > --- a/include/linux/virtio.h
> > > > > +++ b/include/linux/virtio.h
> > > > > @@ -40,6 +40,13 @@ struct virtqueue {
> > > > >       void *priv;
> > > > >  };
> > > > >
> > > > > +union vring_mapping_token {
> > > > > +     /* Device that performs DMA */
> > > > > +     struct device *dma_dev;
> > > > > +     /* Transport specific token used for doing map */
> > > > > +     void *opaque;
> > > >
> > > > Please just declare whatever structure you want it to be.
> > >
> > > It's an opaque one and so
> > >
> > > 1) the virtio core knows nothing about that because it could be
> > > transport or device specific
> > > 2) no assumption of the type and usage, it just receive it from the
> > > transport and pass it back when doing the mapping
> > >
> > > It should work like page->private etc.
> > >
> > > Does this make sense?
> > >
> > > Thanks
> >
> > I fully expect most devices simply to use DMA here and no weird
> > tricks. vduse is the weird one, but I don't see us making it
> > grow much beyond that.
> >
> > So I think for now we can just make it vduse_iova_domain *. If we see
> > it's getting out of hand with too many types, we can think of solutions.
> >
> 
> I've sent my series of adding ASID to VDUSE, which uses this series'
> token on each vq group, on top of this version of the DMA rework.

But then I see it drops it from vduse_iova_domain. So it does not
look like they union is going to keep growing in an unmanageable way.

> This patch [1] and the next one are the one that reworks the token to
> an empty struct, so virtio can handle it in an opaque way and VDUSE
> can convert it back and forth in a type safe way, skipping the void *.
> Please let me know if you prefer to import a VDUSE header into the
> virtio config header or to make a VDUSE forward declaration instead of
> going through the empty struct to preserve layer boundaries.

Personally for now I'd be happier with just a forward declaration.
I just like seeing things at a glance: "it's a union, and
can be one of two types", is better for me than
"it can be anything grep the source to figure out what it is".
And a forward declaration is opaque by design.


> There is one usage I've not been able to convert though. Jason, could
> you take a look? It is marked as TODO in my series. I'm not sure if
> that's also an abuse of the void * in the DMA rework to be honest, but
> it should be easy to correct.
> 
> [1] https://lore.kernel.org/all/20250818085711.3461758-4-eperezma@redhat.com/T/#u

