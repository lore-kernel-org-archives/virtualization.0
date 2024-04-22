Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D241553A2
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816318; cv=none; b=Pkdxz0WvVOBGbbrxY7aeF73lvWGrIicjM1IlPVjpOoerIQJ7ZjKtRPjETONTcYqN5MeS8I58iTksiQffqpQH8o41thsa8LbmQQ2QNPNuVpBa5O7TFM18/Y9JBEjo7qA4Y/d1AqizLhjXv7mp2hJBBG3d8UTOOKhIupkh/+uNhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816318; c=relaxed/simple;
	bh=n5uIrr770JPV6GuY2AOplyzbO/isWDPuTA3wIXzCBHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EqSoeL4wWlfEh+vsFSk8ylGN5ZfqVfquuH3sN2yFER3e8JsKg33YEDbahM1tUezQlZEBEUbd4+O6WQAjz5fOavA94N7fk7VsaVDozTw8xJscc3TbRx6DehE4e8QMHBiEqQZbf9dKEAQBonaI9csNjnk+6zr32idUHco5n2QpP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRrLRobi; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRrLRobi"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60F9E820C7
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 20:05:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 69pP6RnwnlDe for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Apr 2024 20:05:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 981DD82305
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 981DD82305
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IRrLRobi
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 981DD82305
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 20:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713816313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xwnCN3v0hOU8LktPickNEtFG3k1rFXHPQihbXeDdGs=;
	b=IRrLRobir83iMB9ZcXabztFSvmn8S4fCthxpcIwS582LY8mH4IbLbqieY/loQZkkekUrxB
	AuIrEj7bh53AKnxHJyJzFTXIjZOI/8GGHARFTEjJm9Oh+BF48Q25dtc2IK/2S1kn944DfB
	WzOskATqLBTUOGtQTag4DfgAbco1IZE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-xhBEca-BOH20q853ZUgBBQ-1; Mon, 22 Apr 2024 16:05:11 -0400
X-MC-Unique: xhBEca-BOH20q853ZUgBBQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-418a673c191so22933115e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 13:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816311; x=1714421111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xwnCN3v0hOU8LktPickNEtFG3k1rFXHPQihbXeDdGs=;
        b=G6yMGR9JlYMnRfeT/pUasnlsddkfZYTt9YCyT7JEUjhA4SUEIKj+eW/NiizktzXs7j
         7iONQ1TSu0X8usZNf0gLs6z9TRqcKcSo9yu4CqsPK5uadSQ3o7useWuNHxgrz0EI9Kk+
         9tN+jbqFi3yMrZite+nxiARgr/k4OvncY+QPZF5TfP4lttnjONx2xYBmTM+OKS3RQ+Mo
         6AkmG9nMuaCunXKZ7XjvPRf0UrWHFi5BcNaGwc2HkdhMMTeNTd77oV4Jj0Qvwmt9pLHT
         MWw4iUo3WvkewIbAj01wHiBVjzJtpfb98dsi5ngatW0i982Be7LC7NymwqHCmmyTbK9l
         DrbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfJDnNAoabonRyBIZQeBty19GIvtodga63JHqSKYUAH0J5t7a9MF/X96MoGaqp3KLMYkO2+CRbXLcWmm0JleuLPwjHYB6E9a4pparAdbv/yhtFsLfm3oc9bQ==
X-Gm-Message-State: AOJu0YzWHWXsfuVUsXlqyMi4i2CWzxygvqZtK4B24Pw96HRUJv76PWDy
	h7MJ2UbS0p8TFhwOA1B/T+iAXtd++poCuHGx6HyT6CoDqjq4O5j/J8aogzcUA5p+UEANrXrIq69
	nJ//+VJrUsZHtFAMw4GkJihMRV3I0FqQ/2Q4Kr5YU64frXR//g7JdorLK2f5EHSJOsolr2oWg6C
	wIqPo=
X-Received: by 2002:a05:600c:1554:b0:418:a620:15a1 with SMTP id f20-20020a05600c155400b00418a62015a1mr7620680wmg.30.1713816310649;
        Mon, 22 Apr 2024 13:05:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJrcxstD6w10mAE3B1Bou1FLczqnWqc3tQiXTtd/rag2Kfxir5RyTm6J9FFY7JxJfwChH3qQ==
X-Received: by 2002:a05:600c:1554:b0:418:a620:15a1 with SMTP id f20-20020a05600c155400b00418a62015a1mr7620642wmg.30.1713816309507;
        Mon, 22 Apr 2024 13:05:09 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id h16-20020adffd50000000b00346d3a626b8sm13004737wrs.3.2024.04.22.13.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:05:08 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:05:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for
 reconnection
Message-ID: <20240422160348-mutt-send-email-mst@kernel.org>
References: <20240412133017.483407-1-lulu@redhat.com>
 <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org>
 <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> On Wed, Apr 17, 2024 at 5:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > Add the function vduse_alloc_reconnnect_info_mem
> > > and vduse_alloc_reconnnect_info_mem
> > > These functions allow vduse to allocate and free memory for reconnection
> > > information. The amount of memory allocated is vq_num pages.
> > > Each VQS will map its own page where the reconnection information will be saved
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index ef3c9681941e..2da659d5f4a8 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > >       int irq_effective_cpu;
> > >       struct cpumask irq_affinity;
> > >       struct kobject kobj;
> > > +     unsigned long vdpa_reconnect_vaddr;
> > >  };
> > >
> > >  struct vduse_dev;
> > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> > >
> > >       vq->irq_effective_cpu = curr_cpu;
> > >  }
> > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > > +{
> > > +     unsigned long vaddr = 0;
> > > +     struct vduse_virtqueue *vq;
> > > +
> > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > +             /*page 0~ vq_num save the reconnect info for vq*/
> > > +             vq = dev->vqs[i];
> > > +             vaddr = get_zeroed_page(GFP_KERNEL);
> >
> >
> > I don't get why you insist on stealing kernel memory for something
> > that is just used by userspace to store data for its own use.
> > Userspace does not lack ways to persist data, for example,
> > create a regular file anywhere in the filesystem.
> 
> Good point. So the motivation here is to:
> 
> 1) be self contained, no dependency for high speed persist data
> storage like tmpfs

No idea what this means.

> 2) standardize the format in uAPI which allows reconnection from
> arbitrary userspace, unfortunately, such effort was removed in new
> versions

And I don't see why that has to live in the kernel tree either.

> If the above doesn't make sense, we don't need to offer those pages by VDUSE.
> 
> Thanks
> 
> 
> >
> >
> >
> > > +             if (vaddr == 0)
> > > +                     return -ENOMEM;
> > > +
> > > +             vq->vdpa_reconnect_vaddr = vaddr;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> > > +{
> > > +     struct vduse_virtqueue *vq;
> > > +
> > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > +             vq = dev->vqs[i];
> > > +
> > > +             if (vq->vdpa_reconnect_vaddr)
> > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > +             vq->vdpa_reconnect_vaddr = 0;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > >
> > >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >                           unsigned long arg)
> > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
> > >               mutex_unlock(&dev->lock);
> > >               return -EBUSY;
> > >       }
> > > +     vduse_free_reconnnect_info_mem(dev);
> > > +
> > >       dev->connected = true;
> > >       mutex_unlock(&dev->lock);
> > >
> > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > >       ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> > >       if (ret)
> > >               goto err_vqs;
> > > +     ret = vduse_alloc_reconnnect_info_mem(dev);
> > > +     if (ret < 0)
> > > +             goto err_mem;
> > >
> > >       __module_get(THIS_MODULE);
> > >
> > >       return 0;
> > >  err_vqs:
> > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
> > > +err_mem:
> > > +     vduse_free_reconnnect_info_mem(dev);
> > >  err_dev:
> > >       idr_remove(&vduse_idr, dev->minor);
> > >  err_idr:
> > > --
> > > 2.43.0
> >

