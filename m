Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76B202C22
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737615099; cv=none; b=LO32Y1YnOL5i3Q039DPoNre4XjSVxM8u/xsi6EAo3FotE9WAZRxC/kQt+gCOTOBKmUuObKH86spxtKNMNZfk4oumJ1EnbYJyyNY9Fi8oUOQt7/eZ4USloxvu+W7QyCw4C1j4p6yD1fVEm++wDaQPRrNSbIEzj92bxt08enGHAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737615099; c=relaxed/simple;
	bh=Gd9ypQyot58b2a+7e+EmHzuaC0SRQ4SIeyMiB2cBhV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p95pn7MAbsswRcJEjfNCImRPcVCbww/f6ENKlkKhLuXiiuDmlEo9YnD2E8RSdpCLkh02SgxeQi5CkH09DSDI/Y1tLdLoOTYu1/6CddAprL+TVYWAHdkpbXMQmLJ3oJEXnacURvYpW0eER7ivTOly+yECtvmNDgUKNawoifM1Tnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eusFY2bJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eusFY2bJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737615096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTxtP5GEqA9QhBeJ2GYcRCTnsRZJGXevVMPD+6qXWRs=;
	b=eusFY2bJscxlMnBkygRKodsgVwBe0EfX50aEmkBiyv4FUm9q52XAPSX8dZtCF/giRXe9nN
	EeW63TpD1DVfF4VlXwCe6Qa6hv9zDIymuDxFlBjc2vMRreED4JN4eFLHySsT4Fg7hMx3V7
	L/xk84zAXgWY/XpoYNcKjYTQud/iJy8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-Oc7LRJWLN9GPtaL5nBx90g-1; Thu, 23 Jan 2025 01:51:33 -0500
X-MC-Unique: Oc7LRJWLN9GPtaL5nBx90g-1
X-Mimecast-MFC-AGG-ID: Oc7LRJWLN9GPtaL5nBx90g
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab367e406b3so51153866b.0
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 22:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737615092; x=1738219892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTxtP5GEqA9QhBeJ2GYcRCTnsRZJGXevVMPD+6qXWRs=;
        b=PfarZZcRPPCG4LBPBySXaRtuDk12XaqO1in6KVjIBl5HEJijlNbxT+DirMv7LqwjZy
         O40wPVnvX2bu2M5RQkEZDNcNCHGjK/greE9f/k0eO6nj9/xb5pjPbJwyMl6aJDmhQjJq
         nPfXqMnflKlGHxyPWkpfcLCqRn0rvfW++Fbwo8c/M+5YXF8bdUl2ufBekZRaz0vTICvG
         ixAg10JWh200mw8En0Ztir7aOvH9ApNy6SzEtgtbzCDAfyAfzS4/THiiER7NUIJwyapA
         3012BYgEIqBUTKSJbHORO8x9d1DQvaYqCgbRsxSzAURB5mJdbH+iFUE0VxYYEIS6lf1G
         8hIg==
X-Forwarded-Encrypted: i=1; AJvYcCVmTHRIJ3yHQopcrpFf+4Lu4QC07z+vxYdraRDtf5S1sFjxFevT9SXKyL4w8dvTDIzJKj23tGa9w9sYbh+GCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRTnwBzZihE1echAW0pOWzgX0TP7K3jOVaAf/ItFFFu4M+isVL
	3dKxAnjnItsiZDXiaJibgX6kOv5W2kkldGvJONKddh/6EDdmxmbkl/W6mfAAOKJpFdQtKjMLAxb
	on+PbGxpjc1sHWsfw9yupE4AgODlTfipIV+lVeUfmYFKS/EKluQtPJnwCgDjWwK90
X-Gm-Gg: ASbGnct5k5AGQrWgm0X7XdkGgL/39LAkBKy0uA1tzfHcaahO2bmID3FA4xEFpibfl+v
	N1l0d7g8SjmutgzscvyEZK18nEanG5oAz7DdsK3xFjuPd9bMGrX8/Ev5XaKmEz6ioe2SKSTWLq4
	TSsVmuahfp1navflQ123hCRfcS9JRDNySLi5/BLcS+xTpbbvx6LbFpOVbxlVUjH7rx9NLFscupv
	GY90CjVX1fwDxSvHxVx6FIAZgj3THSqwVm/Yk6mfYLD+UcyTIwFlLTeqQCqFgV3sg==
X-Received: by 2002:a17:907:7da5:b0:aab:8a9d:6d81 with SMTP id a640c23a62f3a-ab38b3afad9mr2437397666b.44.1737615091890;
        Wed, 22 Jan 2025 22:51:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCfe8A35vAG1ot6PB4Nlj6BGYBtkibvkWK+9XUCPly223g1+K17tOt4GvSJp7Z+sK7r+SnJg==
X-Received: by 2002:a17:907:7da5:b0:aab:8a9d:6d81 with SMTP id a640c23a62f3a-ab38b3afad9mr2437395566b.44.1737615091458;
        Wed, 22 Jan 2025 22:51:31 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:443:5f4e:8fd1:d298:3d75:448e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c5c3e1sm1012134466b.7.2025.01.22.22.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 22:51:30 -0800 (PST)
Date: Thu, 23 Jan 2025 01:51:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Boyer, Andrew" <Andrew.Boyer@amd.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"Nelson, Shannon" <Shannon.Nelson@amd.com>,
	"Creeley, Brett" <Brett.Creeley@amd.com>,
	"Hubbe, Allen" <Allen.Hubbe@amd.com>
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Message-ID: <20250123014913-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <20250122165854-mutt-send-email-mst@kernel.org>
 <CB749FA4-79E2-49F0-9BDF-67B089A8EC35@amd.com>
 <20250122172108-mutt-send-email-mst@kernel.org>
 <CF92E813-EE94-4F61-A8A9-278CA1BD3629@amd.com>
 <CACGkMEuf2PgrOYvVdLjgQT53AH7pJFtk9L3bC55JZbkM78V_yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuf2PgrOYvVdLjgQT53AH7pJFtk9L3bC55JZbkM78V_yA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n4sgH1A8gHGKUP0J2ISJBLAeYq0fQc2_BElog8QeRsw_1737615092
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 23, 2025 at 09:47:24AM +0800, Jason Wang wrote:
> On Thu, Jan 23, 2025 at 6:34 AM Boyer, Andrew <Andrew.Boyer@amd.com> wrote:
> >
> >
> > > On Jan 22, 2025, at 5:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Wed, Jan 22, 2025 at 10:14:52PM +0000, Boyer, Andrew wrote:
> > >>
> > >>> On Jan 22, 2025, at 5:07 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >>>
> > >>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > >>>
> > >>>
> > >>> On Wed, Jan 22, 2025 at 06:33:04PM +0100, Christian Borntraeger wrote:
> > >>>> Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> > >>>> [...]
> > >>>>
> > >>>>>>>> --- a/drivers/block/virtio_blk.c
> > >>>>>>>> +++ b/drivers/block/virtio_blk.c
> > >>>>>>>> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> > >>>>>>>> {
> > >>>>>>>>  struct virtio_blk *vblk = hctx->queue->queuedata;
> > >>>>>>>>  struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > >>>>>>>> -   bool kick;
> > >>>>>>>>  spin_lock_irq(&vq->lock);
> > >>>>>>>> -   kick = virtqueue_kick_prepare(vq->vq);
> > >>>>>>>> +   virtqueue_kick(vq->vq);
> > >>>>>>>>  spin_unlock_irq(&vq->lock);
> > >>>>>>>> -
> > >>>>>>>> -   if (kick)
> > >>>>>>>> -           virtqueue_notify(vq->vq);
> > >>>>>>>> }
> > >>>>>>>
> > >>>>>>> I would assume this will be a performance nightmare for normal IO.
> > >>>>>>
> > >>>>>
> > >>>>> Hello Michael and Christian and Jason,
> > >>>>> Thank you for taking a look.
> > >>>>>
> > >>>>> Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.
> > >>>>
> > >>>> The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
> > >>>> Really, dont do it.
> > >>>
> > >>>
> > >>> The issue is with hardware that wants a copy of an index sent to
> > >>> it in a notification. Now, you have a race:
> > >>>
> > >>> thread 1:
> > >>>
> > >>>       index = 1
> > >>>               ->                      -> send 1 to hardware
> > >>>
> > >>>
> > >>> thread 2:
> > >>>
> > >>>       index = 2
> > >>>               -> send 2 to hardware
> > >>>
> > >>> the spec unfortunately does not say whether that is legal.
> > >>>
> > >>> As far as I could tell, the device can easily use the
> > >>> wrap counter inside the notification to detect this
> > >>> and simply discard the "1" notification.
> > >>>
> > >>>
> > >>> If not, I'd like to understand why.
> > >>
> > >> "Easily"?
> > >>
> > >> This is a hardware doorbell block used for many different interfaces and devices. When the notification write comes through, the doorbell block updates the queue state and schedules the queue for work. If a second notification comes in and overwrites that update before the queue is able to run (going backwards but not wrapping), we'll have no way of detecting it.
> > >>
> > >> -Andrew
> > >>
> > >
> > > Does not this work?
> > >
> > > notification includes two values:
> > >
> > > 1. offset
> > > 2. wrap_counter
> > >
> > > if ((offset2 < offset1 && wrap_counter2 == wrap_counter1) ||
> > >     offset1 > offset1 && wrap_counter2 != wrap_counter1)) {
> > >        printf("going backwards, discard offset2");
> > > }
> > >
> >
> > No, Michael, this does not work in our programmable hardware device, because it is not software.
> >
> > -Andrew
> >
> 
> Should we send a patch to disable this feature and cc stable first
> then consider how to fix this?
> 
> Thanks

Given this has been out there for a long time, I do not see
how this will contribute anything useful.

-- 
MST

