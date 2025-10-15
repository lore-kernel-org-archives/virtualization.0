Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7913C8EA
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508487; cv=none; b=ojg/mKLou2yv0es5oDkEhIF4mvNEteaoScRele/rPMSK1rDtJd4I9nzpYolgCQrdBdTmc8R4uUKEZb1VzyPOWUKK8Kx5Ka/Wa6AqxiTVTbXqc7xQOogrYE+lhuiyBhbVPA7v7PBHS7uJSQOIMiXDt1AHBghH3QP+DCxd/xDMRiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508487; c=relaxed/simple;
	bh=NJiRt76dTbkJ4xrmV7ry3jBdOkRCmOO9abjget4+0ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DpxYoxdf0b8fAqn6mROb7AdGMtyGhPQHxH7HOA2+R7wllPqEQ/3GAoZGQVzz9iCKdyER+BnFkfN7an9mCekVoGhw+CyH0Pi/w4tHemZhnZmlv1jZ2uC3APqkjY91M8RzQndpLG0Cj3UIrVLo4ED1gCkN3CGSvtt4vtOCS/I7xeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jf9NUO3M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf9NUO3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760508484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIFmfXL90OL8IaHK+O7WfgGi7yW4MSc3y23FO0z51Bw=;
	b=Jf9NUO3MVKv6QjaHPpFjCd3SeX4AsnatWN5S/p+zkDbK4eI4JXgFYITXwdEsTDs+Ilf2yb
	vs2tVMr0BzmoQKjDsBaTSIF2fLI+2TYHI4xqcImbzoBb/Kmkq1n7bf+ZdOob3+16i4bVPE
	+XHiDmMVbToLr+LDjxDof5GdvHEE6eE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-FCz1BVjuO16SPcz2BuNOnQ-1; Wed, 15 Oct 2025 02:08:02 -0400
X-MC-Unique: FCz1BVjuO16SPcz2BuNOnQ-1
X-Mimecast-MFC-AGG-ID: FCz1BVjuO16SPcz2BuNOnQ_1760508481
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426ce339084so4479373f8f.0
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 23:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760508481; x=1761113281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIFmfXL90OL8IaHK+O7WfgGi7yW4MSc3y23FO0z51Bw=;
        b=UrW21eRFxIMS4YeiWApsCEV/WO9+GMT4RmdP/Id7XdOwW+exjtduu/JTfbju03goNw
         Hh1yKEC7WgjSuoTaA/kTeqUnMvlUOk9r91vnQB92pdxplahC1SlQ25Y4Rs8XIQExQZkw
         bHqvKh6TfyHXC8uF2GU2EpXbYB/2fW2mYVcYVKR+50ZK/DAsbm6CF2e4Nm+OU7owwjyp
         N8pnsK5yS6zlwMjNfqMx3Kgq7F7NMPPzqkjPJ8kn+VAE77DM50lKNBll1O2FeRosP1lT
         X7nV/GxhG5+d3/L7H9xjK0tZZk17Vl52owqaSpXVPpUgVE5VgaGt5tGq8MmNcxm4nOq/
         1Xsg==
X-Forwarded-Encrypted: i=1; AJvYcCVkVbQXSK3RCpT9e8R9pMvq+T967aKcfJD8gHDY/NOO7RFcqWqnh9QfReNfd/2TJKy/6i6O2N8UWukURVndIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuoIXyB6mO6cluZYsT8WF2ii1KeD0tGVsdBdYsWGubz84v9xH6
	Hz8YtDh8fV0fwMOgQcsDNuLLmwP2cWx8qHIVuANWahbugdc+XCel9fViw/JI/d9v0hfpDoJHhA2
	yi6dA6CmJBfRO+96oEpuyb2QsyzOTt4Q49ZkHQkuihC6Qzbu0z3wZ6tRMzjT7xySwQd9U
X-Gm-Gg: ASbGnctQlusmuprTM1N6NeNhJsZYbDNjoPuaQq8lno6L5RcfG/t+HUDSPEQnFX4SmFO
	vRqdQ+QbJLCwsG0VQ9inNa+KAPT7KkpUQaVn7tj0xsDSX7atoyFMHkLYvNcQcWuEoJZX6rL4fFb
	HCFCeKAKOWfitl5YE8gflLtKgOM/joag8nZgR3LIx4W8Vlk9wBQTUxAV6IXTHzOZRGxRfZX6yCQ
	LSYVnB5/fKDF0Fv4WqgyPMAxvgxTBEGP9G21McGdIq5JeYggSesyIXbq0BQgR2YaZh512eGwStI
	tETPc4YJ1IwZ2AftG+OMw/sUx07JlAeOgA==
X-Received: by 2002:a05:6000:4205:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-4266f752fb9mr16997287f8f.43.1760508481221;
        Tue, 14 Oct 2025 23:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo4zy/2ZSFghJwm9U3Fa/LOQMyZhQqIGJ9fyNuM2dBeXBWUD0UpUGr6S550pkPgJhtuk1XzQ==
X-Received: by 2002:a05:6000:4205:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-4266f752fb9mr16997267f8f.43.1760508480741;
        Tue, 14 Oct 2025 23:08:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582a9csm27152693f8f.12.2025.10.14.23.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 23:08:00 -0700 (PDT)
Date: Wed, 15 Oct 2025 02:07:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251015020717-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
 <CAO55cswTyMBsKdpn7becsY4Ry+ZUoEfgP+2Q+DkhZ090VK_-2A@mail.gmail.com>
 <CACGkMEsqD1qAgt8qfV=fwj1OeBeXzoOF1wXdqzJaWYR2A=C+UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsqD1qAgt8qfV=fwj1OeBeXzoOF1wXdqzJaWYR2A=C+UA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g2cC3-9PHHXLWT8_r3XxQlQrxIxUQ77Wb0dTFFvKbEY_1760508481
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 15, 2025 at 12:44:47PM +0800, Jason Wang wrote:
> On Tue, Oct 14, 2025 at 6:21 PM Maxime Coquelin <mcoqueli@redhat.com> wrote:
> >
> > On Tue, Oct 14, 2025 at 11:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > > On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > > > > An userland device implemented through VDUSE could take rtnl forever if
> > > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > > > > device if it does not return the buffer in a longer-than-assumible
> > > > > > timeout.
> > > > >
> > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > Let's not break valid use-cases please.
> > > > >
> > > > >
> > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > kernel.
> > > >
> > > > Would a shadow control virtqueue implementation in the VDUSE driver work?
> > > > It would ack systematically messages sent by the Virtio-net driver,
> > > > and so assume the userspace application will Ack them.
> > > >
> > > > When the userspace application handles the message, if the handling fails,
> > > > it somehow marks the device as broken?
> > > >
> > > > Thanks,
> > > > Maxime
> > >
> > > Yes but it's a bit more convoluted  than just acking them.
> > > Once you use the buffer you can get another one and so on
> > > with no limit.
> > > One fix is to actually maintain device state in the
> > > kernel, update it, and then notify userspace.
> >
> > I agree, this is the way to go.
> >
> > Thanks for your insights,
> > Maxime
> 
> A timeout still needs to be considered in this case. Or I may miss something?
> 
> Thanks

Not as such, kernel can use buffers (semi) predictably.

> >
> > >
> > >
> > > > >
> > > > > > A less agressive path can be taken to recover the device, like only
> > > > > > resetting the control virtqueue.  However, the state of the device after
> > > > > > this action is taken races, as the vq could be reset after the device
> > > > > > writes the OK.  Leaving TODO anyway.
> > > > > >
> > > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 31bd32bdecaf..ed68ad69a019 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > > > > >  {
> > > > > >       struct scatterlist *sgs[5], hdr, stat;
> > > > > >       u32 out_num = 0, tmp, in_num = 0;
> > > > > > +     unsigned long end_time;
> > > > > >       bool ok;
> > > > > >       int ret;
> > > > > >
> > > > > > @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > > > > >
> > > > > >       /* Spin for a response, the kick causes an ioport write, trapping
> > > > > >        * into the hypervisor, so the request should be handled immediately.
> > > > > > +      *
> > > > > > +      * Long timeout so a malicious device is not able to lock rtnl forever.
> > > > > >        */
> > > > > > +     end_time = jiffies + 30 * HZ;
> > > > > >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > >              !virtqueue_is_broken(vi->cvq)) {
> > > > > >               cond_resched();
> > > > > >               cpu_relax();
> > > > > > +
> > > > > > +             if (time_after(end_time, jiffies)) {
> > > > > > +                     /* TODO Reset vq if possible? */
> > > > > > +                     virtio_break_device(vi->vdev);
> > > > > > +                     break;
> > > > > > +             }
> > > > > >       }
> > > > > >
> > > > > >  unlock:
> > > > > > --
> > > > > > 2.51.0
> > > > >
> > >
> >

