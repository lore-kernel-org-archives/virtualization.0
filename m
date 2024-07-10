Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E3197A65
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643978; cv=none; b=N8iWltGycBMc+W9hz+vv0fkWwJAI9U7gZXu8HT82sYB+3NRvZAbp8retEfa5Rbcs2aZByMFMzZPa92svOqOffIUJXyLXRCB9U2/8lf/oEKZbCi4B6xI0jLXIZcvMHJ0K7x8/efJ7I2e1BP28ZnFrK7ErV/P/cTxvQ30S47xFdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643978; c=relaxed/simple;
	bh=FkBwZIwX/vwv/flv1JLtkKzJfwEAAipbXsO2aRGsSSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sySvjgD+BFyTQptm9RuR0G4SDUt/SdD57596sJqPbUTzOAGek6Wu5iVjr/kpE/UunG7DHs/0u3mJ3QsQ0vBCaJGtn1dST69RU243ROnmCmjC4GbgM/F9jw5BZxoU4beCsNOmPwxtmY5XHXSrjv+CHI+dLhjpY+kGNoBtAV8/oV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2QCAeOF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2QCAeOF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720643976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+f+kV8PGs9cvgE7zeVigaMsenY/36PRSuVdnQGbWD0=;
	b=Z2QCAeOFLkXf8HD0Peyl0H2jOvym1qUDEamcq146JulAx1xaK1jQQVvKCahQ07UcNylA9g
	WpnR0Nor1jDaUYx2akV7aC0JnuGdDSSSvUn6C6nrcI6cMmPxGhvi1lX6Txnr5zewRprPyT
	NofkfHfMuZz2ekx8CXiFrpWo8QESppU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-6YHPpQ-kMGa1F4E1ZLrJtQ-1; Wed, 10 Jul 2024 16:39:34 -0400
X-MC-Unique: 6YHPpQ-kMGa1F4E1ZLrJtQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42726545762so1156185e9.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 13:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720643973; x=1721248773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+f+kV8PGs9cvgE7zeVigaMsenY/36PRSuVdnQGbWD0=;
        b=Zv+1mE1+z2IBhhu6Hu8ksW29gQ+6ZM6TB1S8vXPFNv2gpq1tekumsfCiq306DHY1ZD
         MLBbl/DFuTlJrlKeifZYql0Or+ucscNw4zQeMy8h+osaoB0OIA+7NaOl0AOIq7ij5yI1
         d4N9338I0Mj5v66uYUhImmL8O1Tpql8lAPJPhih8fX5hk7EyaKo7hYzoMvlHOn6wfH0l
         W/NIbqmtQUBcrdOelAsn7osedHvwulCzYlKa3lWE5jkDkjbAJSAk2jTxHJMNMbt37M7x
         PkiwqBbSX35ti8YjWsHjjq/xgUnt//ckFBkdUl45Sstx2+kVNfmJbxl90/wyGBtLHmrk
         vpPA==
X-Forwarded-Encrypted: i=1; AJvYcCUEJzUhFZxcTdSA13xFI+tJzvlYIOSonH3zBxRRAQcOJiRg/IuRdx5zP3yxU3GOE0LG49JNvlPgZmh4uqL4ofVN/9iTRQA1VdhDBJ1lLD0=
X-Gm-Message-State: AOJu0YyJxwR/tt+CrwHG7p/VgoRrg0qGI6EC/T81PFkpkFkyJLi5JPkM
	2l4VcsX5PTtAxCR7cy6fMxqcEvPtTgRe7Z3PPVap3oepWADqImSCCS+BbT5PihijKf7LUfEPv3i
	wzrdUnpsKlxgbpUwQQ3Dd7zrlOFtBgHqM+Xmje6mQ3WgPl+1jPX3CiUASJqIIXvXQ
X-Received: by 2002:a05:600c:229a:b0:426:5f75:1c2c with SMTP id 5b1f17b1804b1-426707cbc97mr44811685e9.11.1720643973113;
        Wed, 10 Jul 2024 13:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtCfrEexr56Rkv7hJ8Mgk/LJU1kKofEwb65pnZ1cmAQDQy0+5tLig+uLI502/i8+1HPIzcTQ==
X-Received: by 2002:a05:600c:229a:b0:426:5f75:1c2c with SMTP id 5b1f17b1804b1-426707cbc97mr44811475e9.11.1720643972423;
        Wed, 10 Jul 2024 13:39:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e9666sm92264125e9.9.2024.07.10.13.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 13:39:32 -0700 (PDT)
Date: Wed, 10 Jul 2024 16:38:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
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
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
Message-ID: <20240710162640-mutt-send-email-mst@kernel.org>
References: <cover.1720611677.git.mst@redhat.com>
 <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
 <20240710142239-mutt-send-email-mst@kernel.org>
 <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 10, 2024 at 12:58:11PM -0700, Daniel Verkamp wrote:
> On Wed, Jul 10, 2024 at 11:39 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> > > On Wed, Jul 10, 2024 at 4:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > virtio balloon communicates to the core that in some
> > > > configurations vq #s are non-contiguous by setting name
> > > > pointer to NULL.
> > > >
> > > > Unfortunately, core then turned around and just made them
> > > > contiguous again. Result is that driver is out of spec.
> > >
> > > Thanks for fixing this - I think the overall approach of the patch looks good.
> > >
> > > > Implement what the API was supposed to do
> > > > in the 1st place. Compatibility with buggy hypervisors
> > > > is handled inside virtio-balloon, which is the only driver
> > > > making use of this facility, so far.
> > >
> > > In addition to virtio-balloon, I believe the same problem also affects
> > > the virtio-fs device, since queue 1 is only supposed to be present if
> > > VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> > > meant to be queue indexes 2 and up. From a look at the Linux driver
> > > (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
> > > and assumes that request queues start at index 1 rather than 2, which
> > > looks out of spec to me, but the current device implementations (that
> > > I am aware of, anyway) are also broken in the same way, so it ends up
> > > working today. Queue numbering in a spec-compliant device and the
> > > current Linux driver would mismatch; what the driver considers to be
> > > the first request queue (index 1) would be ignored by the device since
> > > queue index 1 has no function if F_NOTIFICATION isn't negotiated.
> >
> >
> > Oh, thanks a lot for pointing this out!
> >
> > I see so this patch is no good as is, we need to add a workaround for
> > virtio-fs first.
> >
> > QEMU workaround is simple - just add an extra queue. But I did not
> > reasearch how this would interact with vhost-user.
> >
> > From driver POV, I guess we could just ignore queue # 1 - would that be
> > ok or does it have performance implications?
> 
> As a driver workaround for non-compliant devices, I think ignoring the
> first request queue would be a reasonable approach if the device's
> config advertises num_request_queues > 1. Unfortunately, both
> virtiofsd and crosvm's virtio-fs device have hard-coded
> num_request_queues =1, so this won't help with those existing devices.

Do they care what the vq # is though?
We could do some magic to translate VQ #s in qemu.


> Maybe there are other devices that we would need to consider as well;
> commit 529395d2ae64 ("virtio-fs: add multi-queue support") quotes
> benchmarks that seem to be from a different virtio-fs implementation
> that does support multiple request queues, so the workaround could
> possibly be used there.
> 
> > Or do what I did for balloon here: try with spec compliant #s first,
> > if that fails then assume it's the spec issue and shift by 1.
> 
> If there is a way to "guess and check" without breaking spec-compliant
> devices, that sounds reasonable too; however, I'm not sure how this
> would work out in practice: an existing non-compliant device may fail
> to start if the driver tries to enable queue index 2 when it only
> supports one request queue,

You don't try to enable queue - driver starts by checking queue size.
The way my patch works is that it assumes a non existing queue has
size 0 if not available.

This was actually a documented way to check for PCI and MMIO:
	Read the virtqueue size from queue_size. This controls how big the virtqueue is (see 2.6 Virtqueues).
	If this field is 0, the virtqueue does not exist.
MMIO:
	If the returned value is zero (0x0) the queue is not available.

unfortunately not for CCW, but I guess CCW implementations outside
of QEMU are uncommon enough that we can assume it's the same?


To me the above is also a big hint that drivers are allowed to
query size for queues that do not exist.



> and a spec-compliant device would probably
> balk if the driver tries to enable queue 1 but does not negotiate
> VIRTIO_FS_F_NOTIFICATION. If there's a way to reset and retry the
> whole virtio device initialization process if a device fails like
> this, then maybe it's feasible. (Or can the driver tweak the virtqueue
> configuration and try to set DRIVER_OK repeatedly until it works? It's
> not clear to me if this is allowed by the spec, or what device
> implementations actually do in practice in this scenario.)
> 
> Thanks,
> -- Daniel

My patch starts with a spec compliant behaviour. If that fails,
try non-compliant one as a fallback.

-- 
MST

