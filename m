Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4B1AB6D5
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151665; cv=none; b=K+oa5LBUbqZnCv3bk0aNf42Dko7DDw0jOW+rBy0+vgtCqiLUROm5L5PBnnO3eBTgkFKPu9v5xtT9cTp4xRU57GzerISdYJS8dVHuPGgWB8qvRFQ8YCG2/nzFuYJVVzT5GVbxyLhZgWqhjUu3L/p+LxKnsbq4bzdsmkcKz8/W58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151665; c=relaxed/simple;
	bh=s5SCUSV2N13cBuqs2/CZcBicuYyGC/7ZlO7Z3j50H1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Kug0BAI0X1PlyoiIKYU4sWUzt7ObYqt87tlYYMWic/Az6O5r3pdjPBlLEMzOITGe64aeqyyEH9SXdwFNa4f4QzQUhXmubXxAvRc/SU3Ohq0JSRC+inGmDhbvAQ5mqvGDhaPMz8qvQoyF9X/14WcM52LjDkavqOjyytSJsjr+Hf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXIZvVFY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXIZvVFY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726151662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxGa2WKqdhEIp/ToTEe+Od8jgzABw24Ex9DEEyXHNoU=;
	b=GXIZvVFY+e9OdoI8+O1/YGc+jC8EgGNrK3mgttQnbl82HgER+H8ku+RRa7okTCi0V8558N
	ggoyAG3wQ4S78jgylug2eAWOAT3lK5nCMfIR8ew1GsMgSS9AyCF0CjmD2tTG0Lz1BNG7yM
	3eaEv7kPt9EiwvInqy6ZrNa9dp+aJS4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-n6coetHTOSG8f9DEEgpXFQ-1; Thu, 12 Sep 2024 10:34:20 -0400
X-MC-Unique: n6coetHTOSG8f9DEEgpXFQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb236ad4aso6579465e9.3
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 07:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151659; x=1726756459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxGa2WKqdhEIp/ToTEe+Od8jgzABw24Ex9DEEyXHNoU=;
        b=l/ffVUkii7faHdqCJ6RHNBI+mmWbDL9tT/Qp6aSdOgEEh30M0GcET4wUHbgIMjXyJB
         k8NHHsQJ5zhCrqCnffkd1Ax0Xx1qqc+aWhO61QYs3+1BLAf4JwjzojaJh4bVNlO9Usnu
         Ip38otRHVrcyBboZXIEAOcKIIEwR0hXX6o/j/9rms1UeD0NT1QFH5H8jQ8JyXpL0Yok3
         6CnP1AXYCEB2Vjq7wQHfyh6mjLjpY+rjjZgGrPENoHOpIP8HZ+neEh61Zpx5dyodtPzc
         YymGtcv467YBXbYMqZmE3KlsVY3cdT1FbWLT5/gZS0Xt0Qap0O6aDqDUVhwwmP21PqXx
         otdA==
X-Forwarded-Encrypted: i=1; AJvYcCWoSIr0Opd/uG9AaSAbPm1ua26ebt+lkjTPTDM9TsW+Gy0LSCvTeZr/wO0hiiEc7Jsj7HfAWrUFKSsk5WmRDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4OaTRACcyudTrI08GYRHc8dUOUEfu9WUj80w9NuvpgjB3IHZO
	IBAEg+1Ggomegt6AASP69Cr32wlutwmeXyEdK4OTyNTyDflwrXeX+Is8eENk5ovKG+yKg52xJ8F
	4bZaKR6OCqXiZxh2gHX5QX+747unV1i2nLguHPr2fjjTbtIdxOUYq8wjH+I0FLYv7
X-Received: by 2002:a05:600c:1550:b0:42c:a8cb:6a96 with SMTP id 5b1f17b1804b1-42cdb5721eamr25202365e9.31.1726151659459;
        Thu, 12 Sep 2024 07:34:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMaYXhiXR8hK+VHBPqK9k4lvOVvTspIgsm7eb/P3KRMgSGoGIwmwzRxkM+fUsPQ5bB9VbKew==
X-Received: by 2002:a05:600c:1550:b0:42c:a8cb:6a96 with SMTP id 5b1f17b1804b1-42cdb5721eamr25202025e9.31.1726151658499;
        Thu, 12 Sep 2024 07:34:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:45a6:a4e6:75a4:a286:2745])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm91335385e9.1.2024.09.12.07.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:34:18 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:34:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com>,
	eperezma@redhat.com, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 vring_interrupt (4)
Message-ID: <20240912103017-mutt-send-email-mst@kernel.org>
References: <000000000000e2058e0621e7a637@google.com>
 <20240912070121-mutt-send-email-mst@kernel.org>
 <CANpmjNN+3TwdxkvnFzzeQNOVXq-smqpi+xtkw0j+Pd-BGkrgFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANpmjNN+3TwdxkvnFzzeQNOVXq-smqpi+xtkw0j+Pd-BGkrgFw@mail.gmail.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2024 at 03:48:32PM +0200, Marco Elver wrote:
> On Thu, 12 Sept 2024 at 13:03, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 01:11:21AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1608e49f980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e7d02549be622b2
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=8a02104389c2e0ef5049
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/a1f7496fa21f/disk-7c6a3a65.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/f423739e51a9/vmlinux-7c6a3a65.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/b65a0f38cbd7/bzImage-7c6a3a65.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in virtqueue_disable_cb / vring_interrupt
> > >
> > > write to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 0:
> > >  vring_interrupt+0x12b/0x180 drivers/virtio/virtio_ring.c:2591
> >
> >
> > Yes, it's racy!
> >
> > 2589:        /* Just a hint for performance: so it's ok that this can be racy! */
> > 2590:        if (vq->event)
> > 2591:            vq->event_triggered = true;
> >
> >
> > Question: is there a way to annotate code to tell syzbot it's ok?
> 
> In this case, "if (data_race(vq->event))" might be the right choice.

No, vq->event is not racy.

The race is between a write and a read of event_triggered.
I think data_race tags a read, it can not tag a write, correct?



> This is a quick guide on which access primitive to use in concurrent
> code: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
> 
> Thanks,
> -- Marco

