Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8F3DABF2
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540632; cv=none; b=QvlSeQMHGXtB6Du4rsu2i1zmIvVv1Lg6/SopIEIixDKjSnAux/i4JzXVuObx5B41EErVqBxC8mVcN7V4TWO2htzWLAqDwtkpzY5vaRkEu7T72FYv7TgbWZ/d2b2QKe8+PwfzGifr6VRZPo1mz0zQGxCZMP+zsa+ikTe8eEb8hyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540632; c=relaxed/simple;
	bh=/bVCLHeYkfY4wX+w0FmLv677D8eoPiD32q9LLkx2i8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=d6oVcKCSvS5gqp3ZSE0Zz2FM5p64WU8dZdq6KzxZB0HKci7yQnkd6mTX6yhVGDIDUB7M0N3jdQqUAEtl9l+CtJ1T+a/LbHo4aYdrbNoKLwjBhfWw9rgoEhCZUN3nkQ4MQxDwwI6/jtoD27xQmKkqbRt2OD6SEBgl2I9fIVRHtS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6ZHDiha; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6ZHDiha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711540629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hWri6+tiRPxiqqVnG5Me+/c+BeHQBoEHnxaqpBOMAaM=;
	b=b6ZHDihaAfzWQw74uFFTvEaiQ2lYNE6ZQuOMtdHITDoEOUNfgUhg71QX03yKQHvmp14Gyc
	p3AO4bQGG5sfRT2viNXqB3QkEnHPgIuvovwK8EH/IXUPZgO2vf3ksuescu6edRfOZzUp4C
	Z2jrv+k3PZXc+tN04a18rGt/fuQJpVo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-WkaVqDR3MMalxP7ppZBJ0Q-1; Wed, 27 Mar 2024 07:57:06 -0400
X-MC-Unique: WkaVqDR3MMalxP7ppZBJ0Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41407fd718dso36069985e9.1
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 04:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540625; x=1712145425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWri6+tiRPxiqqVnG5Me+/c+BeHQBoEHnxaqpBOMAaM=;
        b=Kw2cv4k2VJeFhK8MX7WYU55kv3JgidLOsl/GbDYst0zsyQg1DUIhPDEFLb8jj7HlGI
         dGOXa3vtmodjDp1Cc6OGaLV/GmMnxcc+s2zqTqJvbrjwPlOCpkSx+0gAH03QlZfK/sAC
         gcsl0GRUkQL+Zhq4mFfmI2gCZqvFZwg/HoE8Etw0Zb8R2CluejSPpBnPZgl0pGqXGaIc
         ENzKmzrtYubLXTYf+YVGpR1WdhloDyv4+5Yl+Dp+II5/yaBaNzjvaQmR5c7afwDB9VHA
         yr200xC72hRKu+kdSqpNHsDi7/3qH7V+nvaN2w1Ern8n6cCpRT3Bqw3Y0/AehY4gIp2m
         h1vg==
X-Forwarded-Encrypted: i=1; AJvYcCUy33T/AHpmjU2qAyS17jZkx1x/axhgsAAXrzPh2UxHcFVbOmxz4Ve1pGOlxMFEMsF+2f93sgRxFDERQkNgpDB9e/z2ylLx18gApeF04CM=
X-Gm-Message-State: AOJu0YxUQ0VkU5ppKmlyPx9K/Wl/GSt+4St+ttfZpprJee0kwelXUsyu
	R6Ue07Y3sxgYvk/ary/rMoSAZDWcwXL9YY8SIzF4N4xYgK+NYAZDywU69NfYYYH/8H1Vq+hxT/z
	CY57huQXY3p5zxifLICX3RTjtYf8MMK52cNAKV67ijTmttcoCzTPphVgrd/Wcv788
X-Received: by 2002:a05:600c:3b9e:b0:413:133c:b9c8 with SMTP id n30-20020a05600c3b9e00b00413133cb9c8mr886063wms.33.1711540625445;
        Wed, 27 Mar 2024 04:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjtWZgoLECCahLjXIvmW31Yh+6KWzfZk85gRGbWkJ9cBwuztQZcyvva3YOYYkjVtDSlBU+UA==
X-Received: by 2002:a05:600c:3b9e:b0:413:133c:b9c8 with SMTP id n30-20020a05600c3b9e00b00413133cb9c8mr886041wms.33.1711540624781;
        Wed, 27 Mar 2024 04:57:04 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0041487f70d9fsm1934113wmo.21.2024.03.27.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 04:57:04 -0700 (PDT)
Date: Wed, 27 Mar 2024 07:56:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: Keir Fraser <keirf@google.com>, gshan@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240327075049-mutt-send-email-mst@kernel.org>
References: <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
 <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
 <20240326033809-mutt-send-email-mst@kernel.org>
 <ZgKXr8IQ51xBECuP@google.com>
 <20240326114313.GA9482@willie-the-truck>
 <20240326154628.GA9613@willie-the-truck>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240326154628.GA9613@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 03:46:29PM +0000, Will Deacon wrote:
> On Tue, Mar 26, 2024 at 11:43:13AM +0000, Will Deacon wrote:
> > On Tue, Mar 26, 2024 at 09:38:55AM +0000, Keir Fraser wrote:
> > > On Tue, Mar 26, 2024 at 03:49:02AM -0400, Michael S. Tsirkin wrote:
> > > > > Secondly, the debugging code is enhanced so that the available head for
> > > > > (last_avail_idx - 1) is read for twice and recorded. It means the available
> > > > > head for one specific available index is read for twice. I do see the
> > > > > available heads are different from the consecutive reads. More details
> > > > > are shared as below.
> > > > > 
> > > > > From the guest side
> > > > > ===================
> > > > > 
> > > > > virtio_net virtio0: output.0:id 86 is not a head!
> > > > > head to be released: 047 062 112
> > > > > 
> > > > > avail_idx:
> > > > > 000  49665
> > > > > 001  49666  <--
> > > > >  :
> > > > > 015  49664
> > > > 
> > > > what are these #s 49665 and so on?
> > > > and how large is the ring?
> > > > I am guessing 49664 is the index ring size is 16 and
> > > > 49664 % 16 == 0
> > > 
> > > More than that, 49664 % 256 == 0
> > > 
> > > So again there seems to be an error in the vicinity of roll-over of
> > > the idx low byte, as I observed in the earlier log. Surely this is
> > > more than coincidence?
> > 
> > Yeah, I'd still really like to see the disassembly for both sides of the
> > protocol here. Gavin, is that something you're able to provide? Worst
> > case, the host and guest vmlinux objects would be a starting point.
> > 
> > Personally, I'd be fairly surprised if this was a hardware issue.
> 
> Ok, long shot after eyeballing the vhost code, but does the diff below
> help at all? It looks like vhost_vq_avail_empty() can advance the value
> saved in 'vq->avail_idx' but without the read barrier, possibly confusing
> vhost_get_vq_desc() in polling mode.
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..87bff710331a 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2801,6 +2801,7 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>                 return false;
>         vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>  
> +       smp_rmb();
>         return vq->avail_idx == vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);

Oh wow you are right.

We have:

        if (vq->avail_idx == vq->last_avail_idx) {
                if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
                        vq_err(vq, "Failed to access avail idx at %p\n",
                                &vq->avail->idx);
                        return -EFAULT;
                }
                vq->avail_idx = vhost16_to_cpu(vq, avail_idx);

                if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
                        vq_err(vq, "Guest moved used index from %u to %u",
                                last_avail_idx, vq->avail_idx);
                        return -EFAULT;
                }

                /* If there's nothing new since last we looked, return
                 * invalid.
                 */
                if (vq->avail_idx == last_avail_idx)
                        return vq->num;

                /* Only get avail ring entries after they have been
                 * exposed by guest.
                 */
                smp_rmb();
        }


and so the rmb only happens if avail_idx is not advanced.

Actually there is a bunch of code duplication where we assign to
avail_idx, too.

Will thanks a lot for looking into this! I kept looking into
the virtio side for some reason, the fact that it did not
trigger with qemu should have been a big hint!


-- 
MST

