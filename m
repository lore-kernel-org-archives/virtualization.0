Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618634;
	b=pp+BYReD/dk4AHmcr0o8aL+iZrAYXy5lA2HAeS/iorX1e09XN9yOXgwTWN3JB2tn4BpH
	 pvnOlzg2OJkFYVNkH0Wj0v0JV8gCs83B/W7zE64pFQSab0iMYMpsj2jQRn97GZRfyG1rs
	 d11su9VtuWE5nsL7JgxIKMhJo17cBZIgCgrnSyGFj8MXtE/PfN8Udp3ZXCwqdItvyegTX
	 4qUg643oUfeHQmIBCyRMfDsmrxvcj2JB0o0RoipUdq3qHDPWf9F8K8G11huPY7+XVUEB7
	 2peFRgGx3fPJKv/nxG3gXAQ3pv/vX0f0RiqUjO0MGAEwsiKFq4wZ4xpGv+jDQ7G+b3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618634;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=VcjTCIQxHPy1RNYAHZs+gYCcjsuVMw4HX1QUflSdR9M=;
	b=kDkEcyY5x8w2EXLzRCXq3PoeWHwE4YOfW9KmzsopX/APl7w9HaP2dL4qLqOhZrqvOb9T
	 T6gw1gYNCS7gC3fevofxmoSOVgZfe69KWo7we0aXFuh6GlGTVrRQTeDfJXr64zztO66eB
	 8K9drQzbQE9ZvEJvc0lmRapR/F1WnrDLi5qTuoCIHBbigC7x0d79iSgPCZAB0lj1k2zyt
	 /0wCdIlIpOizckLUMK1dEmGplYad8bF+rJsDsDViGZ63VZ4/dtcQrkP9fcp+/p8arUn1o
	 5vmBhFl+HDZrg9lcTDypXcE3QGhy5uFk8MrkLm5SCwmGuHwd0tovIw7hXvO4ttkrPVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YTc8SYum;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B99606CEE7
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 11:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15B99606CEE7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YTc8SYum
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793618633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VcjTCIQxHPy1RNYAHZs+gYCcjsuVMw4HX1QUflSdR9M=;
	b=YTc8SYumQu1WC5MxyuJBjxBxyhcoK0twJMuSQnj1fPFX+lStKxZ3qZQoQp9VT4djHA9wUw
	vkv2e05wGcAWqtm3DglXn0FAXFHvnNrl+G0V0+9iuwOlfylOCmMTYwAWuIX1jGENSHmq+h
	/Y9k6LYy2tLzoL6/YBWZeSgOrtDhCKM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-WuCeHw07Mcyot-6X1QDEZw-1; Mon, 02 Nov 2026 06:23:51 -0500
X-MC-Unique: WuCeHw07Mcyot-6X1QDEZw-1
X-Mimecast-MFC-AGG-ID: WuCeHw07Mcyot-6X1QDEZw_1793618630
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a027f2e364so19165635e9.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 03:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618630; x=1794223430;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VcjTCIQxHPy1RNYAHZs+gYCcjsuVMw4HX1QUflSdR9M=;
        b=v54vSBNm+DVIYhDMtTQDlFPpmn13KK9sCkMQNFOdP0j2GoiKNe96howtEXIOqQ468T
         LtcWLFbAaL8MG4gMdRBSipQUIL9T8cYELhCC2MmfdUkU+tSlu0b/dmKXoW8bjrTqXuor
         BPhB0j+6MfhMhQryd0iE7+6lqQkwmIlu+w2TJDI7EFrWKpM1AHdKax2GcSZsmyfhg8Et
         NS3JPHbKSWkjvgo8d0zgTEbsdezQUuIXrFOX8SQTmDaVHQ3uzb1Z+ironIobf50Kzl/Y
         3Pq9m1jxxxNGYiZ2PjoNpgFG0zuCzWintkmnp8V5LRP+v4fKoUzLcC5NwUGwW/AG7Oh1
         +n6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzntw7GInCVntzvuosRDBKvGM9RcMHKHsmv8tO8EKZv1jwlFezOK+r6rf4pGPvGtX6RW8Go6WukohuVHsdfgw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ7KrDv9G/KPLnY81bo4dBwOnE4GkoM/m9y0sw4CB19Tl/kBxI7
	Haj2iQP48qvMS6gci1WTmu/RRiJ3kZl0O/CiJI4MgQv6CEUzPTBTxwEZgXgu/Bp2p+4j3liQHEi
	a/GPfTPeIbPya9O++h8bCfdd6sExwHBsY+IN2eEWhQ+rbGoY0S0c291aaLRit27EtDSAs
X-Gm-Gg: AYBFou2zvqMe3FGaK5LbQEtUDN6djHdgjE29WU4rrNdkbSRSlLjmyxe71oes/qqL8i/
	DYWIxQf11kRvv+xhzplAkOkcDvk+XUP9jPzwc/VuaeeI2RBJHsZ+ylkfePVdtu5TOqE4xGjq0GE
	rNgS8zoq4TSfHmuDIec1fMuFlgaaBp9nZLZ5b2SJepmfOjDZy35p8+GCOuM6ZrDjQpKcNLUlcsq
	4afLiQcHv2Z7kL/wQCTV7akX/eKk3dmzcrMKvDh8YdBSTmlvw96bjrqRCJF9CwU6r3jt5lP6K4Y
	xBMr4qjnB9iK3tYW8fmN7Z1JTzU5iKUXAf+jGwiPZVPJxqfdzW7eLWfhHQe3JBI9TcU0i6Oeri8
	4/i7uTYAc7oje54w4831GdmKSt4SuUfpJU95lWdQ1BA==
X-Received: by 2002:a05:600c:3b2a:b0:4a2:cbe:bec2 with SMTP id 5b1f17b1804b1-4ac18a8882cmr224771095e9.32.1793618630210;
        Mon, 02 Nov 2026 03:23:50 -0800 (PST)
X-Received: by 2002:a05:600c:3b2a:b0:4a2:cbe:bec2 with SMTP id 5b1f17b1804b1-4ac18a8882cmr224770425e9.32.1793618629674;
        Mon, 02 Nov 2026 03:23:49 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ad414e298bsm120989945e9.2.2026.11.02.03.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:23:49 -0800 (PST)
Date: Mon, 2 Nov 2026 06:23:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2?=
 =?utf-8?B?XSBSZTogW1BBVENI?= =?utf-8?Q?=5D?= virtio_ring: reset IN_ORDER
 state in virtqueue_init()
Message-ID: <20261102062326-mutt-send-email-mst@kernel.org>
References: <20260910123903.1717-1-lirongqing@baidu.com>
 <CAAf7B_M=tfyL33WGkxSX68FwPaRRRBcASVx92EGwPMXaFtUdzQ@mail.gmail.com>
 <fe5e4fb1b68d4203812e253d722cbe69@baidu.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <fe5e4fb1b68d4203812e253d722cbe69@baidu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 09YBBu_gHWQuBPNgv9yQBXDeqnsddqEDzOb_WfOnRxk_1793618630
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Eugenio, could you look at the qemu side of this pls?

On Fri, Sep 11, 2026 at 06:05:25AM +0000, Li,Rongqing wrote:
> > >
> > > The IN_ORDER feature uses additional software state to track the next
> > > available descriptor and in-flight descriptor batches.
> > >
> > > virtqueue_init() resets the common virtqueue state, but free_head and
> > > batch_last.id are initialized only when the virtqueue is created. When
> > > an IN_ORDER virtqueue is reset, these fields can retain state from the
> > > previous queue instance.
> > >
> > > Reset free_head and invalidate batch_last when initializing an
> > > IN_ORDER virtqueue. Keep this in virtqueue_init() so the state is
> > > initialized consistently for both newly created and reset virtqueues.
> > >
> > > Fixes: f6a15d854986 ("virtio_ring: add in order support")
> > 
> > I think this is needed for -stable.
> > 
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c
> > > b/drivers/virtio/virtio_ring.c index db678f5..d0dc464 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -559,6 +559,11 @@ static void virtqueue_init(struct vring_virtqueue *vq,
> > u32 num)
> > >         vq->in_use = false;
> > >         vq->last_add_time_valid = false;  #endif
> > > +
> > > +       if (virtqueue_is_in_order(vq)) {
> > > +               vq->free_head = 0;
> > > +               vq->batch_last.id = UINT_MAX;
> > > +       }
> > 
> > I would try to reuse or refactor virtqueue_vring_attach_split() to reduce code
> > duplication.
> > 
> > Btw have you checked Qemu shadow virtqueue as it might suffer from the same
> > issue.
> > 
> 
> I checked QEMU's shadow virtqueue implementation. batch_last is reinitialized in vhost_svq_start(), 
> but free_head is not. Since the SVQ object can be reused across stop/start, free_head may retain stale 
> state. So a corresponding fix should be needed
> 
> void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>                       VirtQueue *vq, VhostIOVATree *iova_tree)
>  {
>      ...
>      svq->shadow_avail_idx = 0;
>      svq->shadow_used_idx = 0;
> +    svq->free_head = 0;
>      memset(&svq->batch_last, 0, sizeof(svq->batch_last));
>      svq->last_used = 0;
>      svq->last_used_idx = 0;
> 
> thanks
>  
> [Li,Rongqing] 
> 
> 
> > Thanks
> > 
> > >  }
> > >
> > >
> > > --
> > > 2.9.4
> > >

