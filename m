Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B642A82
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828799; cv=none; b=SB1gFei62MikM4G7N5+z6I1wsE2xB+BKxZQMoATIc/k7M7lKuxb+zVx3Lr/Q3iNDZRozg+sNeZjbumM5DVRey4cCM3ZQiHdr3zQnRtvB8nWghnv9S1JhokYa+0ty22K+3UuoKXQUcnkP0CxzIhgnJWq1893M2tx8cIwu21E8Ye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828799; c=relaxed/simple;
	bh=ZSjjUHbTxbzfu7+e+ZdRhPqco1l8REhS7uBHqpKEPHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nikgpepnrBZaTd9wmSgGtUBBCFtE80jQ5THuYXi2Nt2JAkO9/99l8M8HVPblEl1J1PPNU809FvrBRcS8zaEwIqjZ8O3c39C3k/RN9ie/xtjrYsf2ErJltib04bBWo1mZbXA61UKIG8XjmrS/tbIzUCTR7Vi9IvVqWaHYLkH5UIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsXxgRgT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsXxgRgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752828796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSjjUHbTxbzfu7+e+ZdRhPqco1l8REhS7uBHqpKEPHk=;
	b=dsXxgRgTxP0lR+KQkJB0pbsPJ0GYveDbBxbm7ZinK5mFPhAm6q6xcSvCTureViY3KCoFdo
	NXKRq+Mbv4l2HNp4Op635Bo6bMyu3cBZLzNxUbzD+omoeQGFo1YIa1vMIlf6CBPAewnJOh
	jZuGNjMRnnjUB+oKxsBWkk2DvAgWYws=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-HsHQ9AH9McCvC9qBCFOi1g-1; Fri, 18 Jul 2025 04:53:14 -0400
X-MC-Unique: HsHQ9AH9McCvC9qBCFOi1g-1
X-Mimecast-MFC-AGG-ID: HsHQ9AH9McCvC9qBCFOi1g_1752828794
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso1982656a91.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 01:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828794; x=1753433594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSjjUHbTxbzfu7+e+ZdRhPqco1l8REhS7uBHqpKEPHk=;
        b=MdPNnUH8+HUQdDep+GJnKBEvLhDozavqmjy7EQ6ETRZMdbtCyua/TQE6mRAN/IIG4m
         ol1DlHBf1XUJvShK1sVus9Yo7G1vKKkYKWgCi3OfTrZZXsFltafglVWpLfmyAwo5XMMk
         DAdOs+2FHafD6rrkUlVCAdLkwvSLx18gg/184T3gzz/nYJsABw2AhnBwKmjmM74ukK5u
         oM+6aBbPQI/Ftcm8RyyaU7K57Hwwq/LSBG0fru2uPeoJVGySUzpVLAULBUOXoXIbZR4E
         QxO4enuFUmLdr6UsiQy7tpmF8gk79EtWeW9K6l2HX00bZOKsbkj2XY4vLZBfnYudsEQx
         U7/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvZaWKIwq61+aOlN31uzo9xzTYsVCb2gTlQ+4Ryqikm9umKYDqmHZoC+j9eEzOJa9yPfKgIOxhZ89BHvCTHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLn8uEwKn8obew9/hz/LawKdtuN3Q3FLeGY7W1PAHnpXE+4DN2
	vmuBLx4KuFeV+AYqJvjMG+kDS5fXYbzas3J57yjLjv5XVGDBDr/kIr8KCI8eDkH0srlwEZowWtV
	rlH9a0U1nPwHi7i2FpcT3ik2uf6erT/xPps2nCw6j2OtxSJ+DNslWG3qSKtwLcZcs3FKql3tFR1
	dWbQIY70UFuX4f6RofBPKwxGa9XQMsFjHICoIfiuLFWns=
X-Gm-Gg: ASbGncvKi3Yo7/MxxAyN2r85lDzQQJQBOIUX6N0A6ZNEBuNNgVyxI6aT/Uxbc15Fu/S
	5MSrjoGzKUzFN4+GHFPfsl3lXLACBTxxeKW9XObJdETn04QaYD+yd4VgYRw4ClwZ84w9MGdZWXc
	M5XXZTFb53Fy12P1YT6RU3Wg==
X-Received: by 2002:a17:90b:58cb:b0:302:fc48:4f0a with SMTP id 98e67ed59e1d1-31caea8bc31mr9571994a91.0.1752828793547;
        Fri, 18 Jul 2025 01:53:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOTL4jxd95R5TnyAbSZCimUTCXsjb4ewP5lu22rDU15P+gQBp7YDlaAagD7XMNapi/tdLsX3vZ45790RZw9v8=
X-Received: by 2002:a17:90b:58cb:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-31caea8bc31mr9571968a91.0.1752828793111; Fri, 18 Jul 2025
 01:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718023758.36866-1-jasowang@redhat.com> <CACGkMEsPPxVB5mgcT4=6xL5trBHn33_P1pqxgti-4FSqdYZ5vQ@mail.gmail.com>
 <20250718044839-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250718044839-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Jul 2025 16:53:01 +0800
X-Gm-Features: Ac12FXyk5Rrhjoqn2eN4KaZTUK4G2l7ruhapUakemZUNZfDrCbqpDHArwAI_v5E
Message-ID: <CACGkMEsggdeW3rVTS5Z7Zi3yMC9GCQBGAjQKEDG_aaissap7YA@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] Refine virtio mapping API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zs3D0kRQI3M3obTjXNClNSEtgUeejk3tvz5t_IrwsCE_1752828794
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:49=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 18, 2025 at 12:23:49PM +0800, Jason Wang wrote:
> > On Fri, Jul 18, 2025 at 10:38=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > Hi all:
> > >
> > > Virtio used to be coupled with DMA API. This works fine for the devic=
e
> > > that do real DMA but not the others. For example, VDUSE nees to craft
> > > with DMA API in order to let the virtio-vdpa driver to work.
> > >
> > > This series tries to solve this issue by introducing the mapping API
> > > in the virtio core. So transport like vDPA can implement their own
> > > mapping logic without the need to hack with DMA API. The mapping API
> > > are abstracted with a new map operations in order to be re-used by
> > > transprot or device. So device like VDUSE can implement its own
> > > mapping loigc.
> > >
> > > For device that uses DMA (for example PCI device), the virtio core
> > > will still call DMA API directly without the need of implementing map
> > > ops per device/transport.
> > >
> > > Please review.
> > >
> > > Changes since V2:
> > >
> > > - Drop VDUSE dependenct for HAS_DMA and ARCH_HAS_DMA_OPS
> >
> > I just realized V2 has been merged. So I will post an independent
> > patch to do this on top.
> >
> > Thanks
>
> Dropped for now. Posted a comment though. does v3 fix the build failure
> in linux-next?
>

I didn't find the report, maybe you can give me a pointer?

Thanks

