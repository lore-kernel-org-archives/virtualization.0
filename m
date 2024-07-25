Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7529CA
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721887738; cv=none; b=XbhkF0hqiEh83Fa7VBBApXfj7GMziHNjjkBmE/5fY/t6xw4U7ap87bzETYE70ZHfMSrYGuqEoKSUcXdg/0DTD0BIrkBrM76Y0IzbGBrZlUsbKpbTwpCSEo3T+o41i3l80UhBstbafITSk3q7RKUuFBHhon7lMGlUzDSTxiqodH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721887738; c=relaxed/simple;
	bh=ktUeEo/bkEJsoCv8Aw7rH+7JHWWn0RrsQrNIxvx7j9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPd16G6LFR3N3gIbLjOenUrOaik24QP0ZUXIGcfPrGFq42gbsqlfY8NEWOD0FexTrSxQP6Sy1IuLWV8po5Pa8FhlkJp9nYh9/OIKe0qH9i0ZeD4Y1FyR81YCJn1AMz0IyZxkLmkxEYMGZaeDjbPgASq9b98DSUl/+ukJ1DERl+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T4aGHd7R; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T4aGHd7R"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso474542e87.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 23:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721887734; x=1722492534; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zbstpGz3BJoh4Yi4J8FfFAsfYZOmCWi0WHOoaHkQIeM=;
        b=T4aGHd7RAhCwxGU8FBj5iY5GXWgIKVDUuJv/8jDiLma7h+gIU9cyO2CgEpT+7TbXGb
         sM3yxtVuLu13ftT7PBWD5QR5LUkaphCgPyglmGSRiODUkyIMh1TAvbpMaLghj11H5TNY
         rsarRZGKv6VZ6iIpf8bMACe3CFS3Mad76GGbt4U3E+4P/tB2m4MJ4dXMFO2kP9gU45be
         GwCBaqORWnMLAuoG9RlJ+OiAhPP1rF5sF/FcmaUS+F92n6hcuMDbcKPNuMwihei2F1Fs
         Oo4CUq86Iu6qwiUYI/8WysMSC9Lg0fRhufqe2iiFqrUjsH/M+xsB0v2qxQX420ed8zxc
         dK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721887734; x=1722492534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbstpGz3BJoh4Yi4J8FfFAsfYZOmCWi0WHOoaHkQIeM=;
        b=YeNZMnbzHkGnA75kVxd6mHMjNZJN9DeeM7DZq8gTVIWwcFM7t//Xmej1Ts6I0Ls7Gs
         7Z7ixBoreoxJ+mV3J6OBHpx8EXHsDWLuX0tuXJWzAqyYPO3QAToinJ5X7KX5AuoOxopN
         azSTUXKSZ7lH8BNusAazKQKSj3Mi9Gfs5rhtBkdBUBenfggtdNyzxRdj6jABW/7qDNkp
         F7sZXlkiAP6697Ofm6SKvSXKAgfydOU0CknUd0lhDSVVpjcItLcz0V7Vntj918tW3A56
         6rey6l1VzwuXzTY/mc2MikSQJaUsXYnc36d8VrLxsqHbKCn/oLJMY5h4vT8SfyzoZaZ8
         thCw==
X-Forwarded-Encrypted: i=1; AJvYcCUntRgKzkAkpUjohLRge+WMB7AhTL7aNtgcAwHIRPPR281bOoRNOiHKRXcfdlsXbUecgob1DUHGGogb01aYrepkHALXQSTE6+EDQX51jLY=
X-Gm-Message-State: AOJu0YxTyGXJntvn5swZ7bpuJZRucNhAnklmhzLbVUbB3mDPDcWKdYCJ
	pb0Dnl3xAiiN4e1e7afJwFyii/2zILgVUV3HSdt9UgnJaKsyoM/joQ4sRZkPYMM=
X-Google-Smtp-Source: AGHT+IHHRod0kPEF7TumO/KmS3bpcIdRG7a5qChmWx75LylMoQL7VSxZYZyaTpHk0ms/RvJrkTaunw==
X-Received: by 2002:ac2:4e09:0:b0:52e:943c:c61a with SMTP id 2adb3069b0e04-52fd3f864c9mr1289601e87.57.1721887734191;
        Wed, 24 Jul 2024 23:08:54 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9f60sm34656266b.223.2024.07.24.23.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 23:08:53 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:08:52 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
	vbabka@suse.cz, virtualization@lists.linux.dev,
	hailong.liu@oppo.com, torvalds@linux-foundation.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH RFC 1/5] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
Message-ID: <ZqHr9OQPDVKr-1Cs@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-2-21cnbao@gmail.com>
 <ZqDzErEQbC49F4j9@tiehlicka>
 <CAGsJ_4z+iMXqJP68HQzbmkmWGHa-houPUKth=vbYgL=1OLV4Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4z+iMXqJP68HQzbmkmWGHa-houPUKth=vbYgL=1OLV4Gg@mail.gmail.com>

On Thu 25-07-24 10:50:45, Barry Song wrote:
> On Thu, Jul 25, 2024 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 24-07-24 20:55:40, Barry Song wrote:
[...]
> > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> > > index 791d38d6284c..eff700e5f7a2 100644
> > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > @@ -287,28 +287,44 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
> > >  {
> > >       struct vduse_bounce_map *map;
> > >       unsigned long i, count;
> > > +     struct page **pages = NULL;
> > >
> > >       write_lock(&domain->bounce_lock);
> > >       if (!domain->user_bounce_pages)
> > >               goto out;
> > > -
> > >       count = domain->bounce_size >> PAGE_SHIFT;
> > > +     write_unlock(&domain->bounce_lock);
> > > +
> > > +     pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NOFAIL);
> > > +     for (i = 0; i < count; i++)
> > > +             pages[i] = alloc_page(GFP_KERNEL | __GFP_NOFAIL);
> >
> > AFAICS vduse_domain_release calls this function with
> > spin_lock(&domain->iotlb_lock) so dropping &domain->bounce_lock is not
> > sufficient.
> 
> yes. this is true:
> 
> static int vduse_domain_release(struct inode *inode, struct file *file)
> {
>         struct vduse_iova_domain *domain = file->private_data;
> 
>         spin_lock(&domain->iotlb_lock);
>         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
>         vduse_domain_remove_user_bounce_pages(domain);
>         vduse_domain_free_kernel_bounce_pages(domain);
>         spin_unlock(&domain->iotlb_lock);
>         put_iova_domain(&domain->stream_iovad);
>         put_iova_domain(&domain->consistent_iovad);
>         vhost_iotlb_free(domain->iotlb);
>         vfree(domain->bounce_maps);
>         kfree(domain);
> 
>         return 0;
> }
> 
> This is quite a pain. I admit I don't have knowledge of this driver, and I don't
> think it's safe to release two locks and then reacquire them. The situation is
> rather complex. Therefore, I would prefer if the VDPA maintainers could
> take the lead in implementing a proper fix.

Would it be possible to move all that work to a deferred context?
-- 
Michal Hocko
SUSE Labs
