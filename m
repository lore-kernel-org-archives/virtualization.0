Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86068158DC7
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952295; cv=none; b=deK+FhpezI3Gv+6/Ne9SE0fdYg8Agtv1KkJrMNOWHuPAFXxLFtrQQ4ginWg7XjeCldGtAk7tXb4d7HHTiANJHS9s5hrhaV+MpyjhwUtOVp619fgrtFkhzcZmUOkCwW6GWFX4+0tMBvzomXb8y09hUptCjbPdm6SWV5YrmHQo8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952295; c=relaxed/simple;
	bh=DEXpHeXxlKLGtBABA81i9UYmTJHW63GkAg+T90z+zW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WgpbBEyUguz4EU65n1BB/L1Q7Wfb1CIeKrFpRZHW9efcjtRK252vpA5yeuvdwIk6iRd7h+x7TFtHKBU1Cq8OrvDd0JhqR7oocBoK/GjSPTqNLL5FOWINtD38UKIFA5UOy9UzJQYQDTrpvtAAAIpyUvNT00kckG/rh6eIJCMEKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClI3KNjp; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClI3KNjp"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E62781F5E
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 09:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLcGkhG9MfuB for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Apr 2024 09:51:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F058381F56
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F058381F56
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ClI3KNjp
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F058381F56
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713952291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv8cjYcXwwXBVKkdVfh0gXFti8JhCIGV3qOrwaSd90k=;
	b=ClI3KNjpr+KHq0gEWNFJ6fjzPG+loAXn8pR5ShL1d9DdJRuQ+PdHkWCBQW5y1kerffzeKa
	tNXFfNurD3bSwlsTpeHvj87hZqZ6cdE1UkIHUV3rwPKjbfGalHdE6NFSmKtP4BlCc0viZv
	Dm7LCQ606pDxBNGP1QlFEHI+bl19x9g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-G_t8ptR_PRyjxQLiBSueTA-1; Wed, 24 Apr 2024 05:51:30 -0400
X-MC-Unique: G_t8ptR_PRyjxQLiBSueTA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-416ac21981dso3518245e9.1
        for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 02:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713952289; x=1714557089;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv8cjYcXwwXBVKkdVfh0gXFti8JhCIGV3qOrwaSd90k=;
        b=aNwLBMAKRKdxK9M9gG++ajoFpWmTEhrc1719eYjyPp4eNLTCMxUjmLYAWR0aFe2eyc
         EFovKCOOouDwNdzgU/smi50IhlSkaKKv2eY3OqDLILUnn2cAZNuGM9Yb7PTIyeCFvK0k
         8W4tL0D81aNRFLEgIakEIfbm5Aa0Q2sGReMhuUn3cwpDf8wdhdYD6bsquwYdJKncqche
         5GKI+jk5PKNjAMKo7/N6qpB4TV+fbQj9XLfr2Z1XJ4pRk5oqBM3SxtexgD6gP/3j7+Gw
         A2wpgx9CnG7YvHb88HpwHHFEPO1E8spKh01j7uFaI+bilDhudupcAE6npAWz4rXuNTvg
         WUUw==
X-Forwarded-Encrypted: i=1; AJvYcCV9oEi0VxkhraWM/sjJp/EPYGk/2UuL+WejoQ+S+kSqKDUrNQrqTpfrQQFdfahV6AkhD2EB3rvvFNDfIlzxwvQefqnK3V7R7IjKATHsJ9zvJzZ6HEoqHagLrA==
X-Gm-Message-State: AOJu0YyaKd0kOnXH/5BJXRa3IfOEJ+65s7nksbd43RwRUVT91b1obCfq
	pw+J8J/CjCbghgyadMYhcMPqro3uce0OMr8zwKVj61x2bGkM/Ik2GCK80TxD9BPEBxa8xvUHr8t
	l1wOWhqq7TwCqazS/nm+3QgfVdfNB5LTF7RgyA1cNL2lWeS5ANNjC0R/nUp5k6Fh0G9rQqXx2UI
	2WPZA=
X-Received: by 2002:a05:600c:358a:b0:41a:410b:fe9e with SMTP id p10-20020a05600c358a00b0041a410bfe9emr1364080wmq.12.1713952288943;
        Wed, 24 Apr 2024 02:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8IqubQ4pRsFqO6DbDOa+rGyhzaTafu1jLoU5U7uacX0Oi4qm5g6J2rAWDSdfJ4KhyRZzAqw==
X-Received: by 2002:a05:600c:358a:b0:41a:410b:fe9e with SMTP id p10-20020a05600c358a00b0041a410bfe9emr1364061wmq.12.1713952288374;
        Wed, 24 Apr 2024 02:51:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c139400b0041906397ab7sm19477548wmf.3.2024.04.24.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:51:27 -0700 (PDT)
Date: Wed, 24 Apr 2024 05:51:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for
 reconnection
Message-ID: <20240424055108-mutt-send-email-mst@kernel.org>
References: <20240412133017.483407-1-lulu@redhat.com>
 <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org>
 <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org>
 <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
 <20240423043538-mutt-send-email-mst@kernel.org>
 <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Apr 24, 2024 at 08:44:10AM +0800, Jason Wang wrote:
> On Tue, Apr 23, 2024 at 4:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > > On Tue, Apr 23, 2024 at 4:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > > On Wed, Apr 17, 2024 at 5:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > > These functions allow vduse to allocate and free memory for reconnection
> > > > > > > information. The amount of memory allocated is vq_num pages.
> > > > > > > Each VQS will map its own page where the reconnection information will be saved
> > > > > > >
> > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
> > > > > > >  1 file changed, 40 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > > > >       int irq_effective_cpu;
> > > > > > >       struct cpumask irq_affinity;
> > > > > > >       struct kobject kobj;
> > > > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > > > >  };
> > > > > > >
> > > > > > >  struct vduse_dev;
> > > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> > > > > > >
> > > > > > >       vq->irq_effective_cpu = curr_cpu;
> > > > > > >  }
> > > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > > > > > > +{
> > > > > > > +     unsigned long vaddr = 0;
> > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > +
> > > > > > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > > > > > +             /*page 0~ vq_num save the reconnect info for vq*/
> > > > > > > +             vq = dev->vqs[i];
> > > > > > > +             vaddr = get_zeroed_page(GFP_KERNEL);
> > > > > >
> > > > > >
> > > > > > I don't get why you insist on stealing kernel memory for something
> > > > > > that is just used by userspace to store data for its own use.
> > > > > > Userspace does not lack ways to persist data, for example,
> > > > > > create a regular file anywhere in the filesystem.
> > > > >
> > > > > Good point. So the motivation here is to:
> > > > >
> > > > > 1) be self contained, no dependency for high speed persist data
> > > > > storage like tmpfs
> > > >
> > > > No idea what this means.
> > >
> > > I mean a regular file may slow down the datapath performance, so
> > > usually the application will try to use tmpfs and other which is a
> > > dependency for implementing the reconnection.
> >
> > Are we worried about systems without tmpfs now?
> 
> Yes.

Why? Who ships these?


> >
> >
> > > >
> > > > > 2) standardize the format in uAPI which allows reconnection from
> > > > > arbitrary userspace, unfortunately, such effort was removed in new
> > > > > versions
> > > >
> > > > And I don't see why that has to live in the kernel tree either.
> > >
> > > I can't find a better place, any idea?
> > >
> > > Thanks
> >
> >
> > Well anywhere on github really. with libvhost-user maybe?
> > It's harmless enough in Documentation
> > if you like but ties you to the kernel release cycle in a way that
> > is completely unnecessary.
> 
> Ok.
> 
> Thanks
> 
> >
> > > >
> > > > > If the above doesn't make sense, we don't need to offer those pages by VDUSE.
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > +             if (vaddr == 0)
> > > > > > > +                     return -ENOMEM;
> > > > > > > +
> > > > > > > +             vq->vdpa_reconnect_vaddr = vaddr;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> > > > > > > +{
> > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > +
> > > > > > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > > > > > +             vq = dev->vqs[i];
> > > > > > > +
> > > > > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > > > > +             vq->vdpa_reconnect_vaddr = 0;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > >
> > > > > > >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > > > > >                           unsigned long arg)
> > > > > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
> > > > > > >               mutex_unlock(&dev->lock);
> > > > > > >               return -EBUSY;
> > > > > > >       }
> > > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > > +
> > > > > > >       dev->connected = true;
> > > > > > >       mutex_unlock(&dev->lock);
> > > > > > >
> > > > > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > > > > > >       ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> > > > > > >       if (ret)
> > > > > > >               goto err_vqs;
> > > > > > > +     ret = vduse_alloc_reconnnect_info_mem(dev);
> > > > > > > +     if (ret < 0)
> > > > > > > +             goto err_mem;
> > > > > > >
> > > > > > >       __module_get(THIS_MODULE);
> > > > > > >
> > > > > > >       return 0;
> > > > > > >  err_vqs:
> > > > > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
> > > > > > > +err_mem:
> > > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > >  err_dev:
> > > > > > >       idr_remove(&vduse_idr, dev->minor);
> > > > > > >  err_idr:
> > > > > > > --
> > > > > > > 2.43.0
> > > > > >
> > > >
> >

