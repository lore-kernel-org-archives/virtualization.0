Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51F367B8B
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326241; cv=none; b=ZX+kqOEB5RyywNOv1/rUTxgN8r8jmmLyKVpwkbvXxfA+vYzYwTrDuLxKuye5uAyQW8pyEvfRykLbVbMODVCpSPQTgGaHGNtbpablwD+Z8hrYmgKQTa0BrC1PINeGT5y9/DyChWVRXirA7Lan23BcqvCE0LYy7Is9myAPmDA2gdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326241; c=relaxed/simple;
	bh=7ln20y4IAjjrQujbE/rINypQBgH3iWErEjKlwp9kHGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Pychy7CVkEjZNzbHrozgwUvVlp8zNJzwLzdmuBmE+VgOxdUO6h9KST6vuT7fJG88q4lLdb5Cqswr0ykc+8GvB5/7VAE/L/pvrXQm5vgSaDz/6x9bQljWghq2rrj5Rc6nLSvZSxYQmhWF/U3gpm7Yjc1+hNbns5FqnC+ef0Wi0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=auS/Rom/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auS/Rom/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783326232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiZ7rFhsrLuWgwOq/cJtjOuC/zDIDMp/izDn3la0y/g=;
	b=auS/Rom/ilPrKEDZ6l8JFeIVu2P6p5DiGpWbytg97tQkOIUdzVjpoVNO2zVGtpGxUAbavt
	Xs/FLKVoqcl75We9otbmi1YlIERc4RX5Fl5zWbdPF8lozKd7FumxWYaAhWmFD2bcMdhlp0
	x/2icNvSGHebVrJWhmZSEPW5WMeklYU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-FLvCIH8jNHq3DpAHAqymTA-1; Mon, 06 Jul 2026 04:23:51 -0400
X-MC-Unique: FLvCIH8jNHq3DpAHAqymTA-1
X-Mimecast-MFC-AGG-ID: FLvCIH8jNHq3DpAHAqymTA_1783326230
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490c56e2576so18356785e9.3
        for <virtualization@lists.linux.dev>; Mon, 06 Jul 2026 01:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783326230; x=1783931030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiZ7rFhsrLuWgwOq/cJtjOuC/zDIDMp/izDn3la0y/g=;
        b=OxNTjY6eplmZqOrJd+QQy5g6IZggYsaJxlcFNNYaPRrlfy7gZ9o72dkSiy79GmDtzP
         X8SH/qHyfB5I564F/UpJo1Q14c8KSvP0ntHM4dLNtRL5InFzsmxw0RwksX0DR4xOLerk
         x+VOUbyEayYYhKWbxiCDbGS0iVChJrsOXNFP+Yid8283Ld3kARYfGbd9ZY35h+ZyNM5o
         FXasXk9PnSM3KPGoyBmFXGaF5TU1LVs5ryqLr00fzCTKpvI4Sgrzi9/jVPfgFbdG9OpE
         LE2RbZ5R3qevHWl/tzvHgxrEKwQwTv6MoVAuJtfq6OSSnYHIusZHDD5zxl+pzevdNnCb
         uJUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqY6ve8yOdUZe2Pks9XxnH3KXJjoCXuIlH4gqQAP9tEW/rsG3FZuMHGjkk0AS6aBc9xo7KrcaTvz0yN1sCobA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuGNfKiqnL3cgTlRVS/KCJExHRLf8eEAOjJSck65LhoWAF2WWK
	Y1nYO556KQ2nMzIF6Ltl2MNXdK49Lh+VqCufdDumYPpoLaXBd4lU8LeOvVBZ/dLZqEGHqvrdB/5
	MqXRzmQtFzyOn+sBQzBXvO6gmisLkUPrY8zTuCxI6nOg7b+0jsCv8MlySeBgWsjQpAEDg
X-Gm-Gg: AfdE7cl8saGmDKdeRK0uwlt8Raekof9bd/MKnMTxJ+xqkklafAJ+5BJEmlVuyP7VcLM
	ecTs3X6/C8zeh4wnz4whTJnYi67tZ2B16504wVVdxiE1lVurkq4wVBkugvDTSjRs423pdIHuUd/
	Xv7Ilxl8cT+mIl2DAeb2zELxskucdOWmCtxD0m4FH9N0eZ3/UE8SZDgDu1QfCO2nPR5oRPjAqA+
	WcwO8myOo/0IlpLU3ZlH4/UIF+lYvGZKZNiMIdgGOTAf1+BbDzg+7YegcWrDKWi/An7eeCzQnjk
	OypZYTvbImeInK2XYQl2dmfXMQs6WVZU1jCnJRM6I64N7N5DNRLAlaRPZKUXhBqxf5rCvzo7Zjm
	8Y/v9tv0C8RSYZkm9lG9O2lx3bzvnJGyq
X-Received: by 2002:a05:600c:a01:b0:493:a7bc:5bcf with SMTP id 5b1f17b1804b1-493d11f033cmr112299305e9.24.1783326230335;
        Mon, 06 Jul 2026 01:23:50 -0700 (PDT)
X-Received: by 2002:a05:600c:a01:b0:493:a7bc:5bcf with SMTP id 5b1f17b1804b1-493d11f033cmr112298735e9.24.1783326229699;
        Mon, 06 Jul 2026 01:23:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bc21sm635500545e9.7.2026.07.06.01.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:23:49 -0700 (PDT)
Date: Mon, 6 Jul 2026 04:23:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Adam Litke <agl@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2] virtio_balloon: prime stats vq after
 virtio_device_ready()
Message-ID: <20260706042207-mutt-send-email-mst@kernel.org>
References: <2f0d0de033f3005d3b985883be3e5cf37b3f6c42.1783278596.git.mst@redhat.com>
 <13794c5e-375a-4fc5-84b4-a637d077f8a0@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <13794c5e-375a-4fc5-84b4-a637d077f8a0@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oQTQKPfMup52McDWO3RQVrYIzNt7xalY58BjPIvNz7I_1783326230
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 06, 2026 at 09:28:50AM +0200, David Hildenbrand (Arm) wrote:
> On 7/5/26 21:12, Michael S. Tsirkin wrote:
> > The virtio spec requires the driver not to kick the device before
> > DRIVER_OK is set.  init_vqs() primes the stats virtqueue with a buffer
> > and kicks the device before virtio_device_ready() is called in
> > virtballoon_probe(), violating this requirement.
> > 
> > Further, if the device responds to the early kick by processing the
> > buffer before DRIVER_OK, stats_request() fires and queues
> > update_balloon_stats_work.  Should probe then fail and free vb, the work
> > runs against freed memory.
> > 
> > To fix, move buffer setup to after DRIVER_OK. Be careful to
> > disable update_balloon_stats_work while this is going on,
> > to make sure it does not race with the setup.
> > 
> > setup_vqs() warns but does not fail probe or restore if
> > virtqueue_add_outbuf() fails; the call never actually fails in these
> > contexts since the queue is freshly initialized and empty.
> > 
> > Testing: tested that stats still work after the change.
> > 
> > Fixes: 9564e138b1f6 ("virtio: Add memory statistics reporting to the balloon driver (V4)")
> > Reported-by: Sashiko:gemini-3.1-pro-preview
> > Cc: David Hildenbrand <david@kernel.org>
> > Assisted-by: Claude:claude-sonnet-4-6
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > changes from v1:
> > 	check that work enable/disable is balanced
> > 	explain how add buf never fails in probe/restore
> > 
> >  drivers/virtio/virtio_balloon.c | 50 +++++++++++++++++++++------------
> >  1 file changed, 32 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 088b3a0e6ce6..bc0a2b19ca7d 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -611,25 +611,8 @@ static int init_vqs(struct virtio_balloon *vb)
> >  	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
> >  	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> >  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> > -		struct scatterlist sg;
> > -		unsigned int num_stats;
> >  		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
> > -
> > -		/*
> > -		 * Prime this virtqueue with one buffer so the hypervisor can
> > -		 * use it to signal us later (it can't be broken yet!).
> > -		 */
> > -		num_stats = update_balloon_stats(vb);
> > -
> > -		sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
> > -		err = virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb,
> > -					   GFP_KERNEL);
> > -		if (err) {
> > -			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
> > -				 __func__);
> > -			return err;
> > -		}
> > -		virtqueue_kick(vb->stats_vq);
> > +		disable_work(&vb->update_balloon_stats_work);
> 
> That's to stop the stats queue triggering stats_request() I assume?

Yes.

> Is that
> valid before we actually added+kicked ourselves?

Why not?

> Also, can't we simply handle that in stats_request(), just ignoring it there?

Then we'd need to maintain a special flag and I dislike that.

> Then  we wouldn't have to go through the siable + enable.

We'd still need to flip the flag on/off.

> >  	}
> >  
> >  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> > @@ -916,6 +899,33 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
> >  	return 0;
> >  }
> >  
> > +static void setup_vqs(struct virtio_balloon *vb)
> > +{
> > +	struct scatterlist sg;
> > +	unsigned int num_stats;
> > +	bool ret;
> > +
> > +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ))
> > +		return;
> > +
> > +	/*
> > +	 * Prime this virtqueue with one buffer so the hypervisor can
> > +	 * use it to signal us later (it can't be broken yet!).
> > +	 */
> > +	num_stats = update_balloon_stats(vb);
> > +	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
> > +	if (virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL)) {
> > +		dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n", __func__);
> > +		return;
> > +	}
> > +	virtqueue_kick(vb->stats_vq);
> > +
> > +	ret = enable_and_queue_work(system_freezable_wq,
> > +				    &vb->update_balloon_stats_work);
> > +	/* Make sure we balanced enable/disable, or we won't report stats. */
> > +	BUG_ON(!ret);
> 
> A WARN_ON_ONCE() should be good enough here, no need to crash the kernel (no new
> BUG_ON's).

Will do, thanks!

> -- 
> Cheers,
> 
> David

