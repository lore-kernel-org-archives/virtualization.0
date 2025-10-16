Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02607494
	for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595732; cv=none; b=J5oZBVkTKXM60ZG3H9SgvmzcBnrorVhPzL0Jqew0K7gl3/ib1FBLb2vUbW8+QcuEMieu8aehtMbIjKqrfCGrN+FhbB1yja+vaI4KBloFSdk2r01qXngkhGLwoQonxsESwHQk1/U3wYmktIOSZlhZipIThsnf9A4QYTJb34qlMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595732; c=relaxed/simple;
	bh=uTF7g4P4MDcqLlbbpaoY1ppAUV6kqErenYf6eY1HF/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=C2b8XlzvrhrPB3aNKmKu9Y8Gh4yxJ2AjFpUO2+2WMrqg6z0PpK6aCmrvD8aU9+NtHCVyZfFpY0/MzdbBZGuNBZamrc00tSpM4o+BJeq6YzFGZ/c/JSC6VVYeLatRUf/SW9RBd/3hyqP5P1b0iZY2ZfOy6f1HEuBX6qjCKyqEaZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hl2Kr56D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl2Kr56D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760595729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inFv4pKsvQ1IVMUNO3/+DKKfq2HKDKi/cjwCFHrQEC4=;
	b=hl2Kr56DIYauXkEFJgfXgktm9BHyF+AKOG7b9LeaWSUX+sQB0I+Z6FSFNwh8LGfFfZyYiD
	dbYQVlJvHQhAbA982GZfe/zzKyzTZUMSVgKSf/EkBI5jJuLZ7d93MNqSDPPH3tG42Ipx4A
	783MkIttppChy8QxdZQr5CjbM1GGF7c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-9360YZ61Pomo-lWHdTvFVg-1; Thu, 16 Oct 2025 02:22:08 -0400
X-MC-Unique: 9360YZ61Pomo-lWHdTvFVg-1
X-Mimecast-MFC-AGG-ID: 9360YZ61Pomo-lWHdTvFVg_1760595727
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso4882915e9.1
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 23:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760595727; x=1761200527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inFv4pKsvQ1IVMUNO3/+DKKfq2HKDKi/cjwCFHrQEC4=;
        b=t5mhxdzjhfxMqup+FRflrz42/stFrfrIjqFU0VcGCjgnSJTBNjYggV+yiPKtM5lks4
         uopgzOPXybfUrgRQFGfWDrW79OGEU2Z+Z4KdxvBi2YghcqN5LN0BRPiCUt3Fkyk39TDt
         q5qEuRZI78DnJBiUlV053pBViBVu4/ub9g/TUWRY6ew/4ZY4Kg5Xjh//fi5M7EFA0CIi
         17L4a3gE0TARKZN30xoPjtJbFX/T1ZIPPAtWIhnb5Wu68Qw1li/+IevC6mCq9vqlRzfI
         HUCJ/YRn6oklv7xsv157unWSxNCuepbJoLy2P91mYW3STj4yfPTldxRjHcWDSEcmEQBc
         VcXg==
X-Forwarded-Encrypted: i=1; AJvYcCXZM64YpVbFapKAnoSqQwqaCV3hyi6tek02XVtilZSvFEQ9BRl76luYmmdKVWp2JqUqTL6zEET1yfpHVbRVvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhdIfI+yCRFLs5/+/4NCwewTt0vE/QbmpJQ0MznOvpsxSMevka
	kx6JMJugXgJ2xWoX3d+vf2+SNkeDLxMI7GA9rY0Kp8/ZQgw76ojNL9IVnypEqvnYjqpTxR3cFDA
	usyRfvPPe3p+nUEGWBeXysgGjlSUgzD1AkJY7GbCwM+fNnxoRFXB4AqPUwHocYBgcNizA
X-Gm-Gg: ASbGncvKc9jYVGd6NaPNKa99Ti7rU34wSE1rib89c5RwiAFwGSu7ccnktB/XN/CWiil
	Ic7XuGEYfQG1GSdWdD99qUO4pdx3+9wR1ODc+py87Lp4ji5RjsyrXaLRDoD8H5q04F+3Wa3TH4C
	lbyCPeGWE0YiyJEGSxlqNeVTmz4hOUsS67sgNLJxxhToP6HV9RKpzT66o6AKVdql9iJ1coK5my/
	0yAkJ7Y9BnCmkeVleAIEgcx7qt2LldZiwFJ/WbmLhqcNocE4Z8MAqPY2jCaWuiEx1L9ZhU1VYsN
	/seHPoNkKSbtK5nqHFJNQGvhmTFyEt+OQ1gkC5+MbbmU338tVT2IoTMzA0xwT1FCn5E8
X-Received: by 2002:a05:6000:2601:b0:425:8334:9a9d with SMTP id ffacd0b85a97d-426fb6a1f41mr1604064f8f.1.1760595727438;
        Wed, 15 Oct 2025 23:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSDVD4VRRNvVpaIAkB8ninQwYqvJlQlrSELMHHp5BQcgOvDl48VbYVxjOOEbXoKTiADW5LyA==
X-Received: by 2002:a05:6000:2601:b0:425:8334:9a9d with SMTP id ffacd0b85a97d-426fb6a1f41mr1604053f8f.1.1760595726908;
        Wed, 15 Oct 2025 23:22:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114461debsm6689605e9.18.2025.10.15.23.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 23:22:06 -0700 (PDT)
Date: Thu, 16 Oct 2025 02:22:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251016022131-mutt-send-email-mst@kernel.org>
References: <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org>
 <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fvB_mMR2h3DySVhEo9LZ4jDjs7oAmG82YiNuDs5jXPI_1760595727
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> On Thu, Oct 16, 2025 at 1:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > >
> > > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > > 100 messages to enable/disable promisc mode - together they
> > > > > have no effect.
> > >
> > > Note that there's a case that multiple commands need to be sent, e.g
> > > set rx mode. And assuming not all the commands are the best effort,
> > > kernel VDUSE still needs to wait for the usersapce at least for a
> > > while.
> >
> > Not wait, record. Generate 1st command, after userspace consumed it -
> > generate and send second command and so on.
> 
> Right, that's what I asked in another thread, we still need a timeout
> here.

we do not need a timeout.

> Then I think it would not be too much difference whether it is
> VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
> can only advertise NEEDS_RESET since it's a device implementation.
> VDUSE can not simply break the device as it requires synchronization
> which is not easy.
> 
> > But for each bit of data, at most one command has to be sent,
> > we do not care if guest tweaked rx mode 3 times, we only care about
> > the latest state.
> 
> Yes, but I want to know what's best when VDUSE meets userspace timeout.
> 
> Thanks


userspace should manage its own timeouts.

> >
> > --
> > MST
> >

