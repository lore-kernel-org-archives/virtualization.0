Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2F5CDE6
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861775; cv=none; b=nGOfizQLTYXZ655rPZBRbxhGN+pOaraYZnAliFJrKs9bbV/NzNhZMi3kEGKxpWmZnNwAx8is/6agFH448HcDy765Up72Q18+41+xdcrCT+bqGEEOexu/+hLTxbfXOA69cI8TjyMmu71FeJSN+hLvN7zhfzUqDVwKm+DNKxeR4zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861775; c=relaxed/simple;
	bh=2fDjVbeuUBzTnztgsVGjQmQS5y0ZjQkAUa5V+c2zvzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=srHZ6lpC2ZDMyk3G2v3hNoKj+DpTQSvHRU6XwPvk7lVHpP6Z84GF/ZK+yj7eWX79fAeHBxMz72t8P5yM4lZwaYwH61j989iNwG0o/CPRGIyVch3OR9dtvacpG6nSvqJp0YNA7eqz43nYZ7D0T5pQbiuw0A5JrvhlFNmJA3Xx85A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2yz/MN/; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2yz/MN/"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D7BF40118
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 08:42:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v-HtxGgnkF_L for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Apr 2024 08:42:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8C206400F4
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C206400F4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M2yz/MN/
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8C206400F4
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 08:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713861771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ps+xzWTYxFd7OS06+PYtb6cxlk6Hy0GmNF9fJOn63Zo=;
	b=M2yz/MN/BSKrPw268Jf7EhhRdSS4cMuhmVL0fQLZbOO/u2iTnt/atuDC2iOdZVjhSoPh56
	huR0R8gnvCp67yIdf8fQyk8n6WWcGLGZTW48llYDRADx0YI9Q8Vb5ki2gSBfdy1ze+4BiN
	lIRgGy/EI891/AnxdWrKTz8G7T26TFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-0ZEZINNDNcORXKt294pPyQ-1; Tue, 23 Apr 2024 04:42:49 -0400
X-MC-Unique: 0ZEZINNDNcORXKt294pPyQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41a3369659eso9383395e9.1
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 01:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861768; x=1714466568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ps+xzWTYxFd7OS06+PYtb6cxlk6Hy0GmNF9fJOn63Zo=;
        b=oeFTL9esjyxEbUGkHrZNLsOig8ryzk5QPNNmBwaV6KmgUw+Y4PxHdaAPx5n3nXJ8Rv
         hVa06SRhdu+e/HNUe7gIyOCF8ZRh4udf/qEBf4+KRWdwvSS644ii138JjZoFGh66NvTr
         JmZvE2OFO8jkTa55ZG/GxTGHMKfHE7YnBAFg5tnNj/sJqXRweoSWzzDnuRR4gf95WcqV
         LhPUpiOQ/VPoxlkvn37PCOfyy1LBTWTpI5kT29Lp9clMpOs/OlAW/WCgd6B4sfnEMSzO
         BbgQW2ZhETKW4ofrxtYnhYS62+VrdTbj13i3mJo/uNxqm2wOMrazVdZkCzQMiWo3jW6i
         C+pA==
X-Forwarded-Encrypted: i=1; AJvYcCU3sLZmK6ulNZRSM27+w88Km3ihuVCz4ksyYXSjwEPr21lZ+jERiAxQS+6qadvYfB/Zi48fLB+MlkoI7OXIR+GXcU6I/ghH8jHJ1kP4XlaGmYf4WXv3ujeM+g==
X-Gm-Message-State: AOJu0YyVFhpt64PJb0Y53KwpyAeHbkFbkb/JrY+JNpmsnWVEeLCJUgZC
	lhKINDHU42ZvxzyYObBxGqRaJ0Gh9yFpi2d8YQoHrIBb6NqPDb6vGSYEwAcD/HlIvhDZ2dD65qa
	DcIqaNveT3e719XnWFwLEWiPbfp5OATdktZi0z4C8hymkTi4PF42dx5pFoCJ7WMM4etbvS2SnUj
	AdNlA=
X-Received: by 2002:adf:db47:0:b0:34b:6240:3467 with SMTP id f7-20020adfdb47000000b0034b62403467mr1428316wrj.3.1713861768547;
        Tue, 23 Apr 2024 01:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5lBC1PGR2u/FH3l6COzzBqmrDWV109EY8m+4UpFCe4iQbYF4ViweNueYxZykEpRxLbBYujg==
X-Received: by 2002:adf:db47:0:b0:34b:6240:3467 with SMTP id f7-20020adfdb47000000b0034b62403467mr1428290wrj.3.1713861767997;
        Tue, 23 Apr 2024 01:42:47 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d4604000000b00343826878e8sm13993177wrq.38.2024.04.23.01.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:42:47 -0700 (PDT)
Date: Tue, 23 Apr 2024 04:42:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for
 reconnection
Message-ID: <20240423043538-mutt-send-email-mst@kernel.org>
References: <20240412133017.483407-1-lulu@redhat.com>
 <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org>
 <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org>
 <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> On Tue, Apr 23, 2024 at 4:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > On Wed, Apr 17, 2024 at 5:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > and vduse_alloc_reconnnect_info_mem
> > > > > These functions allow vduse to allocate and free memory for reconnection
> > > > > information. The amount of memory allocated is vq_num pages.
> > > > > Each VQS will map its own page where the reconnection information will be saved
> > > > >
> > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
> > > > >  1 file changed, 40 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > >       int irq_effective_cpu;
> > > > >       struct cpumask irq_affinity;
> > > > >       struct kobject kobj;
> > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > >  };
> > > > >
> > > > >  struct vduse_dev;
> > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> > > > >
> > > > >       vq->irq_effective_cpu = curr_cpu;
> > > > >  }
> > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > > > > +{
> > > > > +     unsigned long vaddr = 0;
> > > > > +     struct vduse_virtqueue *vq;
> > > > > +
> > > > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > > > +             /*page 0~ vq_num save the reconnect info for vq*/
> > > > > +             vq = dev->vqs[i];
> > > > > +             vaddr = get_zeroed_page(GFP_KERNEL);
> > > >
> > > >
> > > > I don't get why you insist on stealing kernel memory for something
> > > > that is just used by userspace to store data for its own use.
> > > > Userspace does not lack ways to persist data, for example,
> > > > create a regular file anywhere in the filesystem.
> > >
> > > Good point. So the motivation here is to:
> > >
> > > 1) be self contained, no dependency for high speed persist data
> > > storage like tmpfs
> >
> > No idea what this means.
> 
> I mean a regular file may slow down the datapath performance, so
> usually the application will try to use tmpfs and other which is a
> dependency for implementing the reconnection.

Are we worried about systems without tmpfs now?


> >
> > > 2) standardize the format in uAPI which allows reconnection from
> > > arbitrary userspace, unfortunately, such effort was removed in new
> > > versions
> >
> > And I don't see why that has to live in the kernel tree either.
> 
> I can't find a better place, any idea?
> 
> Thanks


Well anywhere on github really. with libvhost-user maybe?
It's harmless enough in Documentation
if you like but ties you to the kernel release cycle in a way that
is completely unnecessary.

> >
> > > If the above doesn't make sense, we don't need to offer those pages by VDUSE.
> > >
> > > Thanks
> > >
> > >
> > > >
> > > >
> > > >
> > > > > +             if (vaddr == 0)
> > > > > +                     return -ENOMEM;
> > > > > +
> > > > > +             vq->vdpa_reconnect_vaddr = vaddr;
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> > > > > +{
> > > > > +     struct vduse_virtqueue *vq;
> > > > > +
> > > > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > > > +             vq = dev->vqs[i];
> > > > > +
> > > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > > +             vq->vdpa_reconnect_vaddr = 0;
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > >
> > > > >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > > >                           unsigned long arg)
> > > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
> > > > >               mutex_unlock(&dev->lock);
> > > > >               return -EBUSY;
> > > > >       }
> > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > +
> > > > >       dev->connected = true;
> > > > >       mutex_unlock(&dev->lock);
> > > > >
> > > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > > > >       ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> > > > >       if (ret)
> > > > >               goto err_vqs;
> > > > > +     ret = vduse_alloc_reconnnect_info_mem(dev);
> > > > > +     if (ret < 0)
> > > > > +             goto err_mem;
> > > > >
> > > > >       __module_get(THIS_MODULE);
> > > > >
> > > > >       return 0;
> > > > >  err_vqs:
> > > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
> > > > > +err_mem:
> > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > >  err_dev:
> > > > >       idr_remove(&vduse_idr, dev->minor);
> > > > >  err_idr:
> > > > > --
> > > > > 2.43.0
> > > >
> >

