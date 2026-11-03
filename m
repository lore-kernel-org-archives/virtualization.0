Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698890;
	b=Cnrs2eOO61dOVtClwbYDb8nJYRa2+uZuLIU3PnI+d5KpFefF7Bqv2laKCcDDYllDUDHk
	 Yfwrx9op6midl1aIMhRMugEFGezFFHEeYzGA5hVMUGMuijKtNXzFWHX2yRVQc2UG6c7s9
	 0LdixT3/Ba0cEPxdlaofHcd0PBREnS+nAOXSf358Y/Dc1O97pT9wogkhQc86yBTZTnXkt
	 SiphjstG0yOac5zERxYt0yeVSr+jDUIf+zcoYVqX9exFYmfFp5f7748dRpZsV0+fFSdOb
	 w8yQmg2nG9DOTjBNyPuSRAwEEt+ua468mYHQBYgs6mxIILJDbQZwyc7np2T2csgI2vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698890;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=R/lFJKDhJJZ0txuBvnSbtzyJ6egVpzp4MgRqqSeZeow=;
	b=eLVPRpvOFQ6kECJDeDK+0CdgovAAgHCp1CbuCXdymntti+4IrTl0ZcJjzYfmEgD0QkuX
	 lUlkr3J1egln3joEFXKxyMDlBljPZJDdpMmmtg4OCTAli6iufUM0dnnE56YDUnLX606hA
	 BEoZMEE+fctYIkRGPB5BCDhPKTZw+xFtavqKnNhKn6MROR/TjoaDus2rf0EfSoI1LcAjO
	 CE7zNLZzpQvaQjhwyzyKUjCcNyvBt6xvP3CcP53cZ99OTaz+H8tf4SUIHpa6+orfD3ctX
	 VhvNmhwuIApzO2Qy8kiB2+HmQrrPgQ9QzQSnUTBV3izmC8mvy4h+fzcpN4XjPaNfN3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BynTmWyn;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BC606A32F
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 09:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A95BC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BynTmWyn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793698888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/lFJKDhJJZ0txuBvnSbtzyJ6egVpzp4MgRqqSeZeow=;
	b=BynTmWyncU8JPtwbjzglvEeoNwK3bL8SytXukrXW+mvgcgMnymNu2JqoA53wCZrU+8CvHl
	ty7I4Dvwa7XiDB/S/qXXhOL+HLBk9atjK/xSkC2ccR2wCYulDEgrlTKPi2epotzZjCmfCL
	yYrTB9UqU63rkxRr8ELAJv4Z4RHRIxE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-1c_cpGsnPE2KwMLOweY-jw-1; Tue, 03 Nov 2026 04:41:27 -0500
X-MC-Unique: 1c_cpGsnPE2KwMLOweY-jw-1
X-Mimecast-MFC-AGG-ID: 1c_cpGsnPE2KwMLOweY-jw_1793698886
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b0a199b20so3310632f8f.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 01:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793698886; x=1794303686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R/lFJKDhJJZ0txuBvnSbtzyJ6egVpzp4MgRqqSeZeow=;
        b=Vo4tqfeI/evHVrKqRBgpMIPjmNYu21ls9GP+yV/02T8s2texMMbkFUbntViYW7t2WP
         nPOLPrnOEPWsqYV1CMPVY0RtVFgn0O4+VEL6yTId7X/d9nGabm5bD2E6/GOx2Pe/CWe/
         H984cArJiKnMztymRG32qcACCJbzDdj1mZbWLZqtefaU7fJFOLeUBHdNqAyg15CV6dLE
         PAO8m1WHmVUl6NAREFlkHn2z5mFS1zc7wwZGfzVyUB/eM9KDikx0EmaGIBvRDN//O8V8
         9g9y/i5HMMuA6FvMskDMf8Hn6vAYaaBZrNdpKltqJ6dY8XCUalL4IRQOFC+WGXS8BTM1
         p06Q==
X-Forwarded-Encrypted: i=1; AKwUvBw+C6K6XSdc6sefBcwDtbOpiJ92B+u0V6bxEwOm8eQaPkKcSa/o8oYEJl5AbS6jCCMM9j5moO/VJHqQGHqzYQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/IPGQEk8AjCf3tFQ1kOdYb7Z5WDfViNwQeg03AqYOKhwjTMKTk
	RTFALpv19eAEDAAFt8ujJLu0ICE7wjd7BFVx6zgdyLRatf0IN+qLVmo9OubtuIpb6krXUEVNDBr
	PEBDcn002wACZDkvkkKnd2r3m/d1gXO/ihaBqrFCAK7W8tqdgMTFtqXpnfKEWD+REUQXE
X-Gm-Gg: AYBFou1JgFV8xSQQS8g8Gi+XZFWzqZI2yit4onFHOyG39WdC+is+cPbtZUq0SOMzAkq
	WkaEmNCil4y1LW+G8Pw0+vpaBaAQQNkPHS+w43EHRXX0C73enyzBHjxdxGbb95QbKml/c9B/IXN
	ViYf5Q3eB1+3UrorZMfzlKnT85+Qr5RjiDNkCxZ550EF9oUlQjdtYIPT/Fe0Az7yduJ6yj/nbvA
	X6cRqg4/MAjQFczjXiQV2Ne6Id3WvtkKwpHtIRyR+zDvtmRQxb9HBkTK35qi1c30CjwZFmV4FSf
	+I2MrBjXgW08Kec+Sjb/DQJ2XIqwj8U92LDPk1TAJTRqgb95iteBbNeBonSSlBRRADf6xM55plg
	AnMSwNavotOIgYbz133t5g2ulsLzb9jp7mx3lfcqnGQ==
X-Received: by 2002:a05:6000:4026:b0:48b:4a2:8175 with SMTP id ffacd0b85a97d-48e6e501911mr28209566f8f.43.1793698886354;
        Tue, 03 Nov 2026 01:41:26 -0800 (PST)
X-Received: by 2002:a05:6000:4026:b0:48b:4a2:8175 with SMTP id ffacd0b85a97d-48e6e501911mr28209499f8f.43.1793698885760;
        Tue, 03 Nov 2026 01:41:25 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8e5f4sm24468482f8f.40.2026.11.03.01.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:41:24 -0800 (PST)
Date: Tue, 3 Nov 2026 04:41:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Li,Rongqing" <lirongqing@baidu.com>, Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQ?= =?utf-8?Q?ATCH=5D?=
 virtio_ring: reset IN_ORDER state in virtqueue_init()
Message-ID: <20261103044056-mutt-send-email-mst@kernel.org>
References: <20260910123903.1717-1-lirongqing@baidu.com>
 <CAAf7B_M=tfyL33WGkxSX68FwPaRRRBcASVx92EGwPMXaFtUdzQ@mail.gmail.com>
 <fe5e4fb1b68d4203812e253d722cbe69@baidu.com>
 <CAJaqyWc6OzMF2yvrSjOfRE8g4-Y=JD50iq42zPuXWKjb00FdCg@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAJaqyWc6OzMF2yvrSjOfRE8g4-Y=JD50iq42zPuXWKjb00FdCg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QzvvBvGY7OZNDHOPLyu-diCrzOP_Mjh5udhw0BsPN7E_1793698886
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Nov 03, 2026 at 10:36:26AM +0100, Eugenio Perez Martin wrote:
> On Fri, Sep 11, 2026 at 8:05 AM Li,Rongqing <lirongqing@baidu.com> wrote:
> >
> > > >
> > > > The IN_ORDER feature uses additional software state to track the next
> > > > available descriptor and in-flight descriptor batches.
> > > >
> > > > virtqueue_init() resets the common virtqueue state, but free_head and
> > > > batch_last.id are initialized only when the virtqueue is created. When
> > > > an IN_ORDER virtqueue is reset, these fields can retain state from the
> > > > previous queue instance.
> > > >
> > > > Reset free_head and invalidate batch_last when initializing an
> > > > IN_ORDER virtqueue. Keep this in virtqueue_init() so the state is
> > > > initialized consistently for both newly created and reset virtqueues.
> > > >
> > > > Fixes: f6a15d854986 ("virtio_ring: add in order support")
> > >
> > > I think this is needed for -stable.
> > >
> > > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c
> > > > b/drivers/virtio/virtio_ring.c index db678f5..d0dc464 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -559,6 +559,11 @@ static void virtqueue_init(struct vring_virtqueue *vq,
> > > u32 num)
> > > >         vq->in_use = false;
> > > >         vq->last_add_time_valid = false;  #endif
> > > > +
> > > > +       if (virtqueue_is_in_order(vq)) {
> > > > +               vq->free_head = 0;
> > > > +               vq->batch_last.id = UINT_MAX;
> > > > +       }
> > >
> > > I would try to reuse or refactor virtqueue_vring_attach_split() to reduce code
> > > duplication.
> > >
> > > Btw have you checked Qemu shadow virtqueue as it might suffer from the same
> > > issue.
> > >
> >
> > I checked QEMU's shadow virtqueue implementation. batch_last is reinitialized in vhost_svq_start(),
> > but free_head is not. Since the SVQ object can be reused across stop/start, free_head may retain stale
> > state. So a corresponding fix should be needed
> >
> > void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
> >                       VirtQueue *vq, VhostIOVATree *iova_tree)
> >  {
> >      ...
> >      svq->shadow_avail_idx = 0;
> >      svq->shadow_used_idx = 0;
> > +    svq->free_head = 0;
> >      memset(&svq->batch_last, 0, sizeof(svq->batch_last));
> >      svq->last_used = 0;
> >      svq->last_used_idx = 0;
> >
> 
> I'll ack this patch if it is sent to the QEMU mailing list, but the
> guest is not able to reset a virtqueue without deallocating it

what would "deallocating" mean here? who's doing the deallocating?

> as far
> as I know. Do you have a reproducer or something similar?

