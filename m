Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B42D6E74
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540446; cv=none; b=eAKBcZcSNJjQy+dkFx5W686OHPvs26GKAor87i6I+3QvxeULQ4H7qC9vwBaG8yylGj3mlfASa7nPpQd0LfmTYwdvrBfWYO7xbfylMAgwBFIaDybTJ4d7gEatSws6wKVu4QjIaoPbjpdwYnJKVsW+tpZa/L+Lj1oTdR9ZXYl1qTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540446; c=relaxed/simple;
	bh=tSSuv9qd+EGYUQL8vOXHRSPgInZY98O3jOMvDKpPSXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EqgIRMV/6nGjwbv1ZdMsREA/v/EX50pm2uJER0JldnDKcxnp/uaKxRLZWAVPVIVQI0uQMSe0S04jK/Sjq76TLiM1+/WPMq53y0+oBrcwKi3pPZXK9oAgEkCcXpAhV16ItFjJX8KySyXheLKuKhPy8Cd74emjo7VmStaGjzvSuPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8Qx8npr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8Qx8npr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760540443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MElpqlEaZ/QL8rOGgLuRvu7r4AErxu8O/kca7UOA8yU=;
	b=J8Qx8nprCsAkEP4MoGxK1oTv6skSUofipysVrI4rXBt1ObQ+7sxFq/6z44xT4nKUevO/LG
	8bXsPHrHCB3XlJfvvEYykqjrAbjZ4yzjHh0lueIbzy4ysOFtN6PE42WnB0MY62mN+Z9ads
	ttYIS+9lmUmNcl89AELQqJgqV5Z+oU4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-tJPoiAZeNcOfDmxYHi-tHw-1; Wed, 15 Oct 2025 11:00:42 -0400
X-MC-Unique: tJPoiAZeNcOfDmxYHi-tHw-1
X-Mimecast-MFC-AGG-ID: tJPoiAZeNcOfDmxYHi-tHw_1760540440
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e4cc8ed76so36710435e9.1
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 08:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760540440; x=1761145240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MElpqlEaZ/QL8rOGgLuRvu7r4AErxu8O/kca7UOA8yU=;
        b=nWwMtUuXVveT71ERkDYYxvzqiflFsbEItVF9UMMQIM1FZt2nTaZAm1yMq0yhi4WTcS
         B9VaN5lmGeoTpzz/bn1bvpFW8auDVOg7jdspM2MnM14L6F6oaDE2pqwWosi3/brAezYY
         29zUy1+Fze3YKVGP//KLZ+EOs2+X0/pIT40rUmfb2ulL1Q7xDfNiY/0BPJZFZ+7aSEJR
         CA23FVimT5itYjCmxEao4nkEhTjwxJNACc4tDH3wn6Hw4jOa6xY1lfF0hewKQ3bM5FDy
         VnWjghBtb4Vk057WlXB6CaAQAS7YIsLvcpX8nPtSKCxRtZyNzUCId7JhDBU6WZCeQoAl
         1iLg==
X-Forwarded-Encrypted: i=1; AJvYcCXTb1bI5wPzEzEZZjV8djvxB4JSxE6TMMyyUTKDwemi6f5qOAle4dIFgUyV4ck8d3KYZbrVC957FH8K4nfSpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YynVpdJGKuq5cL5gRJvqYANMfPleqEyRLT/7WncXlY3GscHFAFl
	fA4ZByibExv3OKvBSBu2KeNPzmr4uyM3/qwAT/trCJq/RXGhWuT8Ejpnwm80rRHqutqyNlBg/wV
	layPbGHRvHULhxacx64O7qewl/xtSNSa6l9WbkAu5fdcVDj0JMmH2syGiXa53WCrZXhtb
X-Gm-Gg: ASbGncvKhApXksMFb/IEDPMKTCQKlSjjoXoqi2dEBc+cCWcBdDbtWz2O32DWv6KIc4F
	W8hb63uXKh/NBsrmzTaBA05EkM7qZ9NWNL3e6PPQ2zlDz5fSBvXBQ2hIWXJ/C9Rc5J19fp55Hat
	i99fIuzabBowWkHowkdZrHefXqCyEVf2Y7mG1KGzZU7WP9o9+8EtLBZfxo5FQ8HnqSyEk3jQulf
	rMXLQV3ny7wxI0MDW1/mif32idOzS1QHMdie0/bQKWVuJGAtTwpwUDwMKr3vabRqo3m0P6HtVcu
	bDG3dk2bqOhpaqDGhrS7fOjhhTVEtgirPw==
X-Received: by 2002:a05:600c:609b:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-46fa9b106cbmr224296925e9.31.1760540439771;
        Wed, 15 Oct 2025 08:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG83tZOYf92UjJrUkzfuJBKvYnViUzT9/EFd7GjBiFY3LwsTllALB98FeXxGE98+Djg54Lo+Q==
X-Received: by 2002:a05:600c:609b:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-46fa9b106cbmr224296395e9.31.1760540439138;
        Wed, 15 Oct 2025 08:00:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab5250ddsm175452285e9.6.2025.10.15.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:00:37 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:00:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Gong <gongwei833x@gmail.com>, vgoyal@redhat.com, miklos@szeredi.hu,
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Wei Gong <gongwei09@baidu.com>
Subject: Re: [PATCH] virtiofs: remove max_pages_limit in indirect descriptor
 mode
Message-ID: <20251015105830-mutt-send-email-mst@kernel.org>
References: <20251011033018.75985-1-gongwei833x@gmail.com>
 <20251014185356.GB18850@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251014185356.GB18850@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gWdskQgDXlP53j5MqQLqaQhJ50txvTLrM2nCPFvpZrc_1760540440
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 14, 2025 at 02:53:56PM -0400, Stefan Hajnoczi wrote:
> On Sat, Oct 11, 2025 at 11:30:18AM +0800, Wei Gong wrote:
> > From: Wei Gong <gongwei09@baidu.com>
> > 
> > Currently, indirect descriptor mode unnecessarily restricts the maximum
> > IO size based on virtqueue vringsize. However, the indirect descriptor
> > mechanism inherently supports larger IO operations by chaining descriptors.
> > 
> > This patch removes the artificial constraint, allowing indirect descriptor
> > mode to utilize its full potential without being limited by vringsize.
> > The maximum supported descriptors per IO is now determined by the indirect
> > descriptor capability rather than the virtqueue size.
> > 
> > Signed-off-by: Wei Gong <gongwei09@baidu.com>
> > ---
> >  fs/fuse/virtio_fs.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 76c8fd0bfc75..c0d5db7d7504 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/memremap.h>
> >  #include <linux/module.h>
> >  #include <linux/virtio.h>
> > +#include <linux/virtio_ring.h>
> >  #include <linux/virtio_fs.h>
> >  #include <linux/delay.h>
> >  #include <linux/fs_context.h>
> > @@ -1701,9 +1702,11 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
> >  	fc->sync_fs = true;
> >  	fc->use_pages_for_kvec_io = true;
> >  
> > -	/* Tell FUSE to split requests that exceed the virtqueue's size */
> > -	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
> > -				    virtqueue_size - FUSE_HEADER_OVERHEAD);
> > +	if (!virtio_has_feature(fs->vqs[VQ_REQUEST].vq->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
> > +		/* Tell FUSE to split requests that exceed the virtqueue's size */
> > +		fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
> > +						virtqueue_size - FUSE_HEADER_OVERHEAD);
> > +	}
> 
> The VIRTIO 1.3 specification defines the maximum descriptor chain length
> as follows
> (https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-9200019):
> 
>   The number of descriptors in the table is defined by the queue size for this virtqueue: this is the maximum possible descriptor chain length.
> 
> The driver requirements for indirect descriptors say
> (https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-9200019):
> 
>   A driver MUST NOT create a descriptor chain longer than allowed by the device.
> 
> My interpretation is that this patch violates the specification because
> it allows descriptor chains that exceed the maximum possible descriptor
> chain length.
> 
> Device implementations are not required to enforce this limit, so you
> may not see issues when testing. Nevertheless, this patch has the
> potential to break other device implementations though that work fine
> today, so it doesn't seem safe to merge this patch in its current form.
> 
> I have CCed Michael Tsirkin in case he has thoughts. It would be nice to
> boost performance by allowing longer I/O requests, but the driver must
> comply with the VIRTIO specification.
> 
> Thanks,
> Stefan

This request is not uncommon. We wanted a field for max s/g supported as
separate from the VQ depth for a while now, and for various device
types. No one yet bothered implementing this or even adding the
description to the spec yet.


-- 
MST

