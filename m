Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489135C68E
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368327; cv=none; b=mLaKS7aDrPChsjU4Xe/3xp520b36H4/0CTvOi/FjInsXjJ44mosRTg8w9HVhr86IlM0B8OZncljpsFWbWYAVQDfVJrucwtrU+gDqweVzBdDPrm3rYbNTVY9bmPUAWnQgHSkJa8XkjJ9BWN/eBYL/xH0W2qOyIX16OzmXzUkzQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368327; c=relaxed/simple;
	bh=B8Kpw0JPqJEXYAOLDMKIaAc4pa002KqgaAqibO7rajc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8NV9DTUgg3/y8L9znpgLi26X6W+7Rk24e99ojJaVWu3+EfdEvfXqMijsXJbUxpAkBmIO3AFBCcgwJar3AWeg29k8S+yE+WiFy8XBreg5BSrIOrR04tVckk7V4QumeOMqOQ6M3cMURgZqvJrJmLGJoDqvKtB0DNGnR507aD2Zm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNNIAPT0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNNIAPT0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49558ce01afso14626195e9.1
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786368324; x=1786973124; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N0ofoODcYWs3I9OWUEGLHyeHF210MGua+sArH7R31wk=;
        b=gNNIAPT0pvygHE9QEebW5xgWw5UHXLE8xH6/sePpRaM9bmeTpbVV1+pcbi7Y8q64AS
         cDcH8m0H5+cG2mx6am9V6PWwfAoCHI1Bqa0da6KQ4bJ2XbGb5//TkavQRhX8K39hCXFZ
         QdljbcQdjb8xne9NEVsy9tOtj6s86C8jEGjNaUtlUOu822Dm8u7+SfRYo44Z83hJPiFN
         aVraxNYzAoxJcsvIYcBN0e0ZEx2CljV3AmdR95PrZcv2kaYiS9ng7x/3/Ljw//JY0VtC
         XYckwbvXYVCXN99dWjTW6pv340YxMkPBZ1jhJk4kQXflEgmOfrC54yoF2ZjunyZKWrKL
         689Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368324; x=1786973124;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0ofoODcYWs3I9OWUEGLHyeHF210MGua+sArH7R31wk=;
        b=RAqLQmYpk2372+2tR5YmeqIXHG7M2s090Jz4h9KkGS6u4N594AJLCY6wI0gPMEm3KE
         XkfEh2ula7lVqZwSIibqRX/sw54A6aDsbaFHZqeDpz+9U/OBOW0bLiObNSNy8ON5dCNT
         CYIknBu8EC2VGDVTXIQlz//8q28exNjFoGsCUGy6RxZIF+ie0I5qwzEsb4oi5iRc32u4
         jAGrGiQMH/HpoL3jLphfIU864KfW0TB5mVX6gixS/fjewbY7o/vmdN5jl43oegkYeqg+
         coWnmHx3E9cNKZZ0eGNT28z9yWjcI3xAYKAwdkEDUmommb0xhugCc2nLyvOhjrrgNqZO
         wQCg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5NMRM4PjW2RYWxX+CoQ7V5SMj56MmzCZ4HaQ2QTkyHq0cuYHs5QPUShaNc8oScFzBltN3m7D0bJ2eF/yNEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3JOd1ob78C6LCxW6XLLTytVZCzPAprNdj3uSifB3jr5nnVRO9
	HXN4Nx/afNRUKXw4/r1anE2NOgBqxo1xoy2M5AJMDBH2gAfOjdHRB5a4
X-Gm-Gg: AR+sD10DCO8uJRxqwdbxsv+Pbp/BDXlxpL/+T3N+N5JNBI6hA+YIcY96q0PZQRhoUtT
	796D0rSr97kXP/nnRwbdpk/inVK+tqAaGSpWV1TDqF7Tn94LSMjZB4Y+ybo67CYqezYGLxnj0xC
	Khs3fBE2/SiF+82bhavP8ZqKQYt6eOA8zXrdSOt5bSfqRhO7mYfx3ZPHTzA5dU3IPQDqiVumgc+
	dox8wZ5MSjclUkVI0KsMIWT3wLnUEVyYrVzATzrizt3NobpyGeI7mB0DblPALloZyyuW99YCPVP
	R5Ggf705My/FWpEMLZRCFZKPFdnNqCXR84KwQgAb19Z+DpZjhlGMsboLcsfmaOpzzMN9HB/Kk3D
	ONEvo834/wLuT2p+vch+VGpUGUbf7rR6pGMCRYTZS3ArQD4YAxtJEOtuatOYy6hbPeta8CEh0mH
	PabhD2mO+I+6zVAe3ImIg9fznNSWX17mbu7wpj9WCY2uc0iNKMvQXPzQHdrfini+jnVfKeEw==
X-Received: by 2002:a05:600c:4f86:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-4994e72f7c1mr558010415e9.2.1786368323764;
        Mon, 10 Aug 2026 06:25:23 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm229399395e9.2.2026.08.10.06.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:25:22 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:35:51 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: Fix resize of the RX ring
Message-ID: <annTt1qn3LOmNvvr@mail.gmail.com>
References: <20260810120728.47445-1-a.s.protopopov@gmail.com>
 <2aef652e-d98d-4ca5-8270-5f108e5593a2@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aef652e-d98d-4ca5-8270-5f108e5593a2@linux.dev>

On 26/08/10 02:07PM, Vadim Fedorenko wrote:
> On 10/08/2026 13:07, Anton Protopopov wrote:
> > When a AF_XDP socket is attached, the virtnet_rx_resize
> > should resize the rq->xsk_buffs XSK buffer array. Otherwise,
> > when the size grows, the virtnet_rx_resume() causes a write
> > past the end of the array. This is easily reproducable with
> > 
> >      ethtool -G ens3 rx 32
> >      ./xdpsock -i eth0 -q 0 -r -z &
> >      ethtool -G eth0 rx 256
> > 
> > Fixes: e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >   drivers/net/virtio_net.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 3e2a5876c6c8..e34c52d059d3 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3444,17 +3444,31 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
> >   static int virtnet_rx_resize(struct virtnet_info *vi,
> >   			     struct receive_queue *rq, u32 ring_num)
> >   {
> > +	unsigned int old_ring_num = virtqueue_get_vring_size(rq->vq);
> > +	struct xdp_buff **tmp_xsk_buffs = NULL;
> >   	int err, qindex;
> >   	qindex = rq - vi->rq;
> > +	if (rq->xsk_pool && ring_num > old_ring_num) {
> 
> why do you cover only the case for growing buffer? Don't we expect to
> free some memory in case of shrinking? Should be fine given you are
> swapping buffers completely...

Isn't this common for "realloc[s]" to just return the same ptr, when
shrinking (to avoid extra actual allocations)?  But I do not have
any strong feelings about this, can switch to "shrink/grow", if this
looks better.

> > +		tmp_xsk_buffs = kvzalloc_objs(*tmp_xsk_buffs, ring_num);
> > +		if (!tmp_xsk_buffs)
> > +			return -ENOMEM;
> > +	}
> > +
> >   	virtnet_rx_pause(vi, rq);
> >   	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf, NULL);
> > +
> > +	/* virtqueue_resize may have changed the size even if err != 0 */
> > +	if (tmp_xsk_buffs && virtqueue_get_vring_size(rq->vq) > old_ring_num)
> > +		swap(rq->xsk_buffs, tmp_xsk_buffs);
> > +
> >   	if (err)
> >   		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
> >   	virtnet_rx_resume(vi, rq, true);
> > +	kvfree(tmp_xsk_buffs);
> >   	return err;
> >   }
> 
