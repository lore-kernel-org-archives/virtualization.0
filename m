Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF23E2DCF7B
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433941; cv=none; b=PAXVqe2yVOx/3LXMxcTIZNK8gq0n5ViPc24DmKtBXewHA6lCC/ZK+a60aGW7qTrc0MXe8vnqA3Mwa1vWd14THXgIE8HE53T5f24YAUY3Gasids8IV866wZqZ0hEMEfAoBn9OTVhmO42kYMaWcImuDLY9Yvao6pFoAu2hflZW9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433941; c=relaxed/simple;
	bh=rZCAygjY0OWPeTvsMe7UoXhWjSZufdU/LV1/KfHjJRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Dt5Ck3aEO+EMpeRXw4OCS1qd/BoTboj+QSAl41gAMw7csukTTtRFs+jbhHmjEdbBo49hYx6YwJfOIBgKnbqbanRw/8FCwWvqHgnX49+1+RG6wfrgvmJhQxkAOAzHMFAtphtEzB589rMG8aZVYVixQnyx8SrhkIAdVwjtnBIgqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TczrInAz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TczrInAz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760433938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfLdBJrnTMVkOACQmFhZRlAwlSYvcBsyR97wH5UAbz4=;
	b=TczrInAzhUuDdfMYhkROnCgaAbvZc694y/w/VjXSK+VE4niREyM/z2qwGt3IOTHxql/oFT
	/yfAKnIDsz2qXae5g3offf1vgAz3+w1mNA7SBnRulksdNcDBYcyhYuY5Fj5tS8O93RA5tk
	Jdv5/LxxNItpOFMnbMg3anjw4kc+rRY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-I6Go9_jJMU2C1Eh9KhSTjg-1; Tue, 14 Oct 2025 05:25:35 -0400
X-MC-Unique: I6Go9_jJMU2C1Eh9KhSTjg-1
X-Mimecast-MFC-AGG-ID: I6Go9_jJMU2C1Eh9KhSTjg_1760433934
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3efe4fcc9ccso4405708f8f.3
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 02:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433934; x=1761038734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfLdBJrnTMVkOACQmFhZRlAwlSYvcBsyR97wH5UAbz4=;
        b=fAvyiD6OqyNWLz7nQWOj1fqi8Im6I7KNebGutmpqsFe0qZ5rF1TbnGZoeO7cpWl9rL
         Qyvr8Jx5L0ZbSvObFWizkDbSB9IZ2oOCGwWrin+mfppaipYmhZWpwS4tRXPMBfU5lp5n
         IpYTIev5TsX39my768Tp+Am66woNUebDGor3McUyjh79xW7N+imIYZwYIhVyjCjcSd1/
         kKnq8OR0HTcW6aWtC10EB3xJlF0mJX6MAglEl8pNGLWoGMYGwvAkkCscWUqMMctQ7h02
         osHA3oY+IULiPveGERUe3pB4e9AdzIasHfPYUdQ/fkbuSuod835+le9H43v7fDGjAC0l
         YL2w==
X-Forwarded-Encrypted: i=1; AJvYcCVJDII2Lr6ASsg2/a/UakkPtgGqpkuooTBxohoZVjck5BM4drBVmEMgf8wVj3XFboGvPCdbw8IGfhcFM8zMyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjQ5qp4+4Gszd8VyiDj79kW7+q8Pu+CLDjvgOOCoVjv9GRsWRg
	PdIXeoEG5PnjLQPDKW+q8GS9QPV3tpcG/5rhxsJcwRucWc7KtYrw2LKQgishWnejGLUNfVT9S5C
	CQVzicJu9voKQWnf0/YnGGjZykuLfecb9zV8Bd0zpmWLmU/kUK3/OEG2q9U142onI+c7Z
X-Gm-Gg: ASbGncuXKX0n7aevWHr7DMg0CzXN+fvHjnhRdKk2BNmDvElWdizDw7h3J9v5nLKaPLl
	2c/lyxWoL6EomyPceiCkfwi0m61xe+I7t3A4R88TYelMFxtahaDG1J6QFtCk9N7WiYmQ8tN224H
	g4eCsQluB0UeLMkJw2LyAPBvN/tcPcJnwuvg5xv6fzhbd54+FMwXa+iP0X/ULA+eKncwRDruFBn
	b5IBw0PkVyoQH2oQDTqGVy1nCqh9N2vZxJLevpst1A7Gf7p5PusZaNP2lvlATb8pauXLDUV680L
	4Axqjp5Y3nu8UH74c1OZ7JtmYsmTrrc3ig==
X-Received: by 2002:a05:6000:2485:b0:425:8133:ec6c with SMTP id ffacd0b85a97d-42666ac634cmr13951503f8f.9.1760433934208;
        Tue, 14 Oct 2025 02:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNy4HULkh4edX8RYJTZCVGTdNQF7IsmD0wybDN7UvL+JUlMATmv35cRvOQ3uVINtBjnY95mQ==
X-Received: by 2002:a05:6000:2485:b0:425:8133:ec6c with SMTP id ffacd0b85a97d-42666ac634cmr13951481f8f.9.1760433933753;
        Tue, 14 Oct 2025 02:25:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8141sm22498086f8f.48.2025.10.14.02.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:25:33 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:25:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <mcoqueli@redhat.com>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251014051537-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TZNhadYkbK6020pszTgAcKhYrjXZJ3bNlVcSfy1zZrw_1760433934
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > An userland device implemented through VDUSE could take rtnl forever if
> > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > device if it does not return the buffer in a longer-than-assumible
> > > timeout.
> >
> > So now I can't debug qemu with gdb because guest dies :(
> > Let's not break valid use-cases please.
> >
> >
> > Instead, solve it in vduse, probably by handling cvq within
> > kernel.
> 
> Would a shadow control virtqueue implementation in the VDUSE driver work?
> It would ack systematically messages sent by the Virtio-net driver,
> and so assume the userspace application will Ack them.
> 
> When the userspace application handles the message, if the handling fails,
> it somehow marks the device as broken?
> 
> Thanks,
> Maxime

Yes but it's a bit more convoluted  than just acking them.
Once you use the buffer you can get another one and so on
with no limit.
One fix is to actually maintain device state in the
kernel, update it, and then notify userspace.



> >
> > > A less agressive path can be taken to recover the device, like only
> > > resetting the control virtqueue.  However, the state of the device after
> > > this action is taken races, as the vq could be reset after the device
> > > writes the OK.  Leaving TODO anyway.
> > >
> > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > ---
> > >  drivers/net/virtio_net.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 31bd32bdecaf..ed68ad69a019 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > >  {
> > >       struct scatterlist *sgs[5], hdr, stat;
> > >       u32 out_num = 0, tmp, in_num = 0;
> > > +     unsigned long end_time;
> > >       bool ok;
> > >       int ret;
> > >
> > > @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > >
> > >       /* Spin for a response, the kick causes an ioport write, trapping
> > >        * into the hypervisor, so the request should be handled immediately.
> > > +      *
> > > +      * Long timeout so a malicious device is not able to lock rtnl forever.
> > >        */
> > > +     end_time = jiffies + 30 * HZ;
> > >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > >              !virtqueue_is_broken(vi->cvq)) {
> > >               cond_resched();
> > >               cpu_relax();
> > > +
> > > +             if (time_after(end_time, jiffies)) {
> > > +                     /* TODO Reset vq if possible? */
> > > +                     virtio_break_device(vi->vdev);
> > > +                     break;
> > > +             }
> > >       }
> > >
> > >  unlock:
> > > --
> > > 2.51.0
> >

