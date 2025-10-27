Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF4C2797B5
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584242; cv=none; b=LSFIwTB1pBmMgF96qCZaqp27SACOHpcy4X2EBLyRCfeKHJB4bmD/kdD1TfYp5Sqh9nMy2CJom3ZpGrv6yJKCIDKKeHO5y8fhZxUWG2XxNoYmSpbY8vYi7y83VQWSLvxl+HnlB1t5UvwcyqCPwPglauO/4l6tEZzsG0uslVEMzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584242; c=relaxed/simple;
	bh=O8RTvMejKOvUck1n4vId5oyUBgWmMFjgNqc1s+Fjnl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Egrpkj/sryWPjzkOeQXuoJGBMIG87hHy83F5CceSB9H9mDYf+fA1u9FTk/jziJ73ObV2OqWIzS2V4zi7NnP6siqessYHEabq20O8VjtCzN62B4qMvX4Qob6kEf4RQc0AGGYhkGwk1HAFOkI3VKt8HIUu8F0JXhgtzI+I9kQlUHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKsmXe3f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKsmXe3f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761584238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3kLM35CIDPHOyrsjILGoJJeoXY7IzP9N8um1gdjmbs=;
	b=JKsmXe3fH5rjB8PkUeVRLyeBlLVxd8/X97n49TPgu6kghsLYchm1fLIXTb5VB1VulxGLQT
	u3hbWPrX6UZWaPWtS3LEOX73m9cpmvZoCciplg1CcGeapQVYW9YFBfgMQDd+r6ddaJTvyk
	d7gJnY0Pak9VJFNeTXuQiLAI9CThLvw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-aSf_-4ExOCGw_t5LRJ-Ncg-1; Mon, 27 Oct 2025 12:57:17 -0400
X-MC-Unique: aSf_-4ExOCGw_t5LRJ-Ncg-1
X-Mimecast-MFC-AGG-ID: aSf_-4ExOCGw_t5LRJ-Ncg_1761584236
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-63c276d535bso4884335a12.3
        for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 09:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584236; x=1762189036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3kLM35CIDPHOyrsjILGoJJeoXY7IzP9N8um1gdjmbs=;
        b=CJgGI7W9zCwGrdCE8IWNe2nvjeCZIgUFQMHmjaMRMCBlPELt2BIFwW5x7sshIo/61D
         QaleKNnHN3t65vuf49yHeki8OOXgDPuXJrDqaOGTia5SV5SxbhoMcsOYJgG5eIuMjIme
         GV0+t2pKX0xAICO20IxYw1Gt1hH4h1kv651xvTlyOzmEVRTxhmnfqzPh7YETsk1PDcZL
         AT+zqQmS8QxSxhW2TUcSpfuKqR6P6hO9g2wywoZz55BsIQF65EPyKanQUdVgy9ixIgDB
         D0f//Mq0H3WdzqjAKUBBYOeXANXDvv32nqVijIflzviD68pL5fiY44rnrgE8Y/YlpiYm
         uEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWD/aIHyJHVKUtLehAjj6CTa1gADIi7kVu1idoboXCYHW/RceAazY0AxjhNV9iudfCuFMLptmduGNvGbmXuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRBg/TMDuqAnt4K1II4opHYoEKozNZUMcLvGHhKUTzKJdNfNiO
	jFwbS7KCCW7yauhc0keBcr94uDV21FoK0ZJ0qlpATMror/vFuEgOyNgmmkhDKiWBtoxWaWhuykI
	kKMz6/EhRQIA7Pl3Fghy4O6wxHwKI2PaqKLRNygzfNRPeXo0tmL1PJ0VGe99+h7cQRizM
X-Gm-Gg: ASbGncv4c17KDfacmuIG27DDCfj4mq5CEokFKnc8rbWJ4Nro41NPzrJdf0qqkjeRsnA
	l+CapR3d9CMu6Klh1FvhryDZ4LnzaZLT9Og38i+S0Ej3jdhC5C0ZosmVJo/TqoYqKcmVh2To13r
	s9e2q2KvnhUATK4YmvQEvhvcDPARvHyjZVbrZK4ou7/XGDJn54v6J3O1ldkCcy8vYag8JNNEivc
	h5CLjaCG85Y1F3CZIs1auDt/q4NzwxHwg4GPLXFbqYkB4RWzSb16Wo4H5o8bjnKQDlaKGT1p4AT
	IxR8kdxSSSW9Q/R5RAR+2Z0JoonO9N77W2rn0VbMgIbVQmQ7j5fRxCz4mxiI55xw
X-Received: by 2002:a05:6402:234d:b0:63e:2d46:cc5d with SMTP id 4fb4d7f45d1cf-63ed82668a2mr574343a12.7.1761584236082;
        Mon, 27 Oct 2025 09:57:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHazDZMNTIt14q/vEvfYcAyvhYxSk9xb4dxmlkKFJ2jGm6Zydzpl6NEPCj6GTS7o2yzgjqVjw==
X-Received: by 2002:a05:6402:234d:b0:63e:2d46:cc5d with SMTP id 4fb4d7f45d1cf-63ed82668a2mr574311a12.7.1761584235473;
        Mon, 27 Oct 2025 09:57:15 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb97b3sm6731026a12.30.2025.10.27.09.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:57:14 -0700 (PDT)
Date: Mon, 27 Oct 2025 12:57:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v7 1/7] vduse: make domain_lock an rwlock
Message-ID: <20251027125520-mutt-send-email-mst@kernel.org>
References: <20251010085827.116958-1-eperezma@redhat.com>
 <20251010085827.116958-2-eperezma@redhat.com>
 <20251010081923-mutt-send-email-mst@kernel.org>
 <CAJaqyWeeJVM6VeYp4HUEe0ZZAi26Jgqw8WaEg6POoGcUOkk6Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeeJVM6VeYp4HUEe0ZZAi26Jgqw8WaEg6POoGcUOkk6Qw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I2uH3C38yxIDlM3goToh1EMOKGf4gyZVICOMADrwZZ8_1761584236
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 23, 2025 at 10:59:01AM +0200, Eugenio Perez Martin wrote:
> On Fri, Oct 10, 2025 at 2:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> 
> ...
> 
> >
> >
> > > @@ -2045,11 +2046,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> > >       if (ret)
> > >               return ret;
> > >
> > > -     mutex_lock(&dev->domain_lock);
> > > +     write_lock(&dev->domain_lock);
> > >       if (!dev->domain)
> > >               dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> > >                                                 dev->bounce_size);
> > > -     mutex_unlock(&dev->domain_lock);
> > > +     write_unlock(&dev->domain_lock);
> > >       if (!dev->domain) {
> > >               put_device(&dev->vdev->vdpa.dev);
> > >               return -ENOMEM;
> >
> >
> > Let's look at this example:
> >
> > So now you are invoking this under an rw lock:
> >
> >
> >
> >
> > struct vduse_iova_domain *
> > vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
> > {
> >         struct vduse_iova_domain *domain;
> >         struct file *file;
> >         struct vduse_bounce_map *map;
> >         unsigned long pfn, bounce_pfns;
> >         int ret;
> >
> >         bounce_pfns = PAGE_ALIGN(bounce_size) >> BOUNCE_MAP_SHIFT;
> >         if (iova_limit <= bounce_size)
> >                 return NULL;
> >
> >         domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> >         if (!domain)
> >                 return NULL;
> >
> >
> > ...
> >
> >
> >
> > Which unless I am mistaken will produce a lockdep splat and deadlock.
> >
> 
> Can you expand on this? All that code works with and without lockdep.


GFP_KERNEL can sleep and if that happens and another thread runs and
will try to take the lock, it will spin forever.


> >
> > So it looks like the previous version did not compile
> > and this one looks DOA.  What's up?
> >
> 
> In case it is useful, I forgot to enable some vendor vdpa drivers of
> HW I don't have, and that was the reason why it didn't compile. But I
> didn't send it without testing it of course.
> 
> > At this stage please include information about configs you
> > tested, and how.
> >
> > And any locking changes should also be tested with lockdep enabled
> > please.
> >
> 
> This is the text I'm planning to include in the next series, please
> let me know if you want me to expand:
> 
> Tested by creating a VDUSE device OVS with and without MQ, and live
> migrating between two hosts back and forth while maintaining ping
> alive in all the stages. All tested with and without lockdep.

