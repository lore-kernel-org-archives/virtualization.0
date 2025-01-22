Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96941C8FB4
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584768; cv=none; b=rzTCJRR5L7HLPu2XrpBvNa7+VJirAD6ay3tzKlykR6YpNSb2ExS9PqU/HV/rwt0J4cXAkyj+E+Q6u14JwPMJGBznGxcYe1NHAmOMI3LOBoM+ErKV2rzGqY3xOJK36BMEP5cGFJjjfGz5Slgmljx8pklOMLrsl8XGB516p1bM7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584768; c=relaxed/simple;
	bh=5eXBoINOTvUSuoZiNuDWlz0bUkjdMqiKgAxp7RPGup4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZnIj8tTW3igN32uV77+F1y0VRs+Ju651npiGW/cnw03NJo5kzemufMimm/5jCJW7jvQs0A6El+zI0zHQcHjAm55u23nO9Y+r6dzW28+PXblUWQPD3WAS6PVP8qgCQNp9ShZSfMg7HNPqS4FgqnXrvmylbW625Vw+drNNYBd9+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbKHeaxg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbKHeaxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737584764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHXhU6bWDw8TYDCC7oLhNKnJfNRqJA79QvQ44NI+/20=;
	b=NbKHeaxgbnNQb6k0BvoMUIGwgH/Dt0xGK0lDozuHuOy9aMrKKYgPwWaEJQmgeXc51mPBxT
	0WKvgsac9ACaTQeCBRx0xW91uD7scltHVnP1fufEyhY1CT16kQvR+nOmJmFyyZwd7Jdjtj
	13vq9U6sOftM3f6kDzSGbbkNZQJWPME=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ufoxDrh4P9iQ_uS1ELjJuw-1; Wed, 22 Jan 2025 17:26:00 -0500
X-MC-Unique: ufoxDrh4P9iQ_uS1ELjJuw-1
X-Mimecast-MFC-AGG-ID: ufoxDrh4P9iQ_uS1ELjJuw
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d3fe991854so286764a12.0
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 14:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737584760; x=1738189560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHXhU6bWDw8TYDCC7oLhNKnJfNRqJA79QvQ44NI+/20=;
        b=mdgZr25eAfJUdqQL/MCZRIVb2Nn5W5Cy1+hhAfBx9jVSsvr6/JsYqnRlCA3R7FqnFC
         lCWjgYJ7Ozc9t/XIkMU689qWkhZ9oV6chc5RWbdom61/75x6JJzV+zDjFv73ik0uHAch
         5K/uBFStB6b1NbY90fg7i39hlMpopnHEzG7V6de//99zDLisqzRZZ7aA8TAKrXZgz4kB
         FMJDlspK0dxWu4RlA7NpW2Nyz1s2+jvHh/J2qMl+ALRhWtUHKsgUWbF1uZfz+Nnrv5L2
         LdOOKZ614ejm7AAqTP/mym7NCmgUC4sNhDqTlTi7fwTivQu/HdRMpAW/AbPyEOeeJrSj
         H6qg==
X-Forwarded-Encrypted: i=1; AJvYcCVOL6JiXMq3Vnl9vIdgTz4ICY23q3h4iFuH+BIT7kKqVfuatQZv9b2IHehaY2A1XQg1oGzMP6/Gb160JKhB7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ1FgEwF2EkSC2mDUgqAnxzog/l/t45+POigaK/NeVWu5ycPxg
	f49aIKLZ9eRAFaXxDP6dGqbWkV3pBzvD/adeCyZTHDTe9lkdfrrwU7dxB3lOj/TVAoftlOtyOFz
	G4Ofn4urBWcbXxkjz9PjApwlbrCZRVB6L+aM43eZsOE82re9yJgBk8EH5th6t9cLE
X-Gm-Gg: ASbGncs6VeGdmbiG7h8zV/JHkTBg4nPMFVs0C/o0+hMqnjwDkn3kOHQN4eqweIXITl1
	Y+AL/IBc0scswXUgnG0VedkOg+IyFmXx8Onn6/Xvx9sP1yJlx460yRvtZZIT7lucZCChwv2lSPZ
	ajhPRF3uA+z5gyNKaOzmwoLRAarEmBzhadkYr79Z02YuphIDtco0/bM0tewXPh6D9KTwT0EMSV3
	rBu/kYC1G1Rpt4OXluOJvVMIJnkK5D4XMR9FLwB9R+Zucr+0zo0iC3g0CAcYI+P4w==
X-Received: by 2002:a05:6402:518f:b0:5da:7f7:b9b2 with SMTP id 4fb4d7f45d1cf-5db7d318b5dmr24529237a12.18.1737584759633;
        Wed, 22 Jan 2025 14:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtOQBkWecsa+n8gYIhL0MGyQXdaUw0SIgtV8J55JDs8OqFYs8KyRgpgIpQCWjOe3xHzWJEMw==
X-Received: by 2002:a05:6402:518f:b0:5da:7f7:b9b2 with SMTP id 4fb4d7f45d1cf-5db7d318b5dmr24529225a12.18.1737584759262;
        Wed, 22 Jan 2025 14:25:59 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:443:5f4e:8fd1:d298:3d75:448e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73edbfafsm9234974a12.68.2025.01.22.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 14:25:57 -0800 (PST)
Date: Wed, 22 Jan 2025 17:25:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Boyer, Andrew" <Andrew.Boyer@amd.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20250122172108-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <20250122165854-mutt-send-email-mst@kernel.org>
 <CB749FA4-79E2-49F0-9BDF-67B089A8EC35@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CB749FA4-79E2-49F0-9BDF-67B089A8EC35@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nwsHAHNAH13zD5vEHGJ-rSA6L_-PUSfOPu-ed2a3Ugs_1737584760
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 22, 2025 at 10:14:52PM +0000, Boyer, Andrew wrote:
> 
> > On Jan 22, 2025, at 5:07 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Wed, Jan 22, 2025 at 06:33:04PM +0100, Christian Borntraeger wrote:
> >> Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> >> [...]
> >> 
> >>>>>> --- a/drivers/block/virtio_blk.c
> >>>>>> +++ b/drivers/block/virtio_blk.c
> >>>>>> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >>>>>> {
> >>>>>>   struct virtio_blk *vblk = hctx->queue->queuedata;
> >>>>>>   struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> >>>>>> -   bool kick;
> >>>>>>   spin_lock_irq(&vq->lock);
> >>>>>> -   kick = virtqueue_kick_prepare(vq->vq);
> >>>>>> +   virtqueue_kick(vq->vq);
> >>>>>>   spin_unlock_irq(&vq->lock);
> >>>>>> -
> >>>>>> -   if (kick)
> >>>>>> -           virtqueue_notify(vq->vq);
> >>>>>> }
> >>>>> 
> >>>>> I would assume this will be a performance nightmare for normal IO.
> >>>> 
> >>> 
> >>> Hello Michael and Christian and Jason,
> >>> Thank you for taking a look.
> >>> 
> >>> Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.
> >> 
> >> The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
> >> Really, dont do it.
> > 
> > 
> > The issue is with hardware that wants a copy of an index sent to
> > it in a notification. Now, you have a race:
> > 
> > thread 1:
> > 
> >        index = 1
> >                ->                      -> send 1 to hardware
> > 
> > 
> > thread 2:
> > 
> >        index = 2
> >                -> send 2 to hardware
> > 
> > the spec unfortunately does not say whether that is legal.
> > 
> > As far as I could tell, the device can easily use the
> > wrap counter inside the notification to detect this
> > and simply discard the "1" notification.
> > 
> > 
> > If not, I'd like to understand why.
> 
> "Easily"?
> 
> This is a hardware doorbell block used for many different interfaces and devices. When the notification write comes through, the doorbell block updates the queue state and schedules the queue for work. If a second notification comes in and overwrites that update before the queue is able to run (going backwards but not wrapping), we'll have no way of detecting it.
> 
> -Andrew
> 


Does not this work?

notification includes two values:


1. offset
2. wrap_counter


if ((offset2 < offset1 && wrap_counter2 == wrap_counter1) ||
     offset1 > offset1 && wrap_counter2 != wrap_counter1)) {
	printf("going backwards, discard offset2");
}
    



