Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2DD2ED14B
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437313; cv=none; b=snYuuhda4mMOeDwKn5SxaWP0LZ+fQeNeo8PDMVc0iaNmj7LZQhbNX8Xc4RPVcFiRuIQLejcqQbF3wlaH6jnZwgl17wdVYv0J8XlGIjjS5fTIDSWRxoPUjPaFOXkJL/1wni9DvcTMe9hYKX6WUKXjiDv5ktdnHnFWlEfIx/qNgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437313; c=relaxed/simple;
	bh=0+9oOtn3ToO9YBdvcAwnf/zoA3wAd3rg3heRydAHaEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxgOJh1WtgM6Dw7AGHC7tZVAcvaY+ApzYoMqX/ig5W6fPGD6Yq9fyk7i9me8ojnmxy5URHKX5bwplOGDMqV1mxsEjr7Iep7pBwawCQEjlZV8n04LuLQXSKub5pS6VBmzVhUcqkSYJFuKP2c48jaXiec/y0N7mup3Rrsef1yM4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSoyqVJP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSoyqVJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760437308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DfJWp99jFxqBbEKvRqQ4rgQH8Wd24+r3ktEvYW+Eps=;
	b=PSoyqVJPWNr+y8p4Y/KG0LZvuw/O/tBtYhixklsUt4T3KUbCYhQFUYq2n7kyWMpkr2J2Ik
	OMJqOyNSzaPtzVb6C/xSfszkBPxdCD7POV75X5rL5H9syUEXXONUh0qvxCsoCH9yeFKlJH
	LN2KLBQmc0Hx2+ncLFhevKjYcf0RU7s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-MdLB88l7Ouu9GWNDDeyDFA-1; Tue, 14 Oct 2025 06:21:47 -0400
X-MC-Unique: MdLB88l7Ouu9GWNDDeyDFA-1
X-Mimecast-MFC-AGG-ID: MdLB88l7Ouu9GWNDDeyDFA_1760437306
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-639f0a38c43so7345314a12.1
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 03:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437306; x=1761042106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DfJWp99jFxqBbEKvRqQ4rgQH8Wd24+r3ktEvYW+Eps=;
        b=wz7FjsqLTbkXEajwBWerYi7xTDMMRWj7NkYSFVnDJe910Gjt0C1xjFV8YGx4os1c0K
         4SFYcjVAUgTkwM1ySOGG/W4yYs0Wh1v1fDYdQ5f52S7Um2B/bx6ubKDjMKRbFLvw8gv2
         yRz8sJFPpM6Gc8+n0B2W8Hwy1Bfmn7X/zVuRcioVeSnceub+J6L1RwIVHEEDrl8kt0aa
         43OPOEqv4a/CjWxKKOxv6QgMFIBidGQdj3TBDzFh7WgOB71cAZiiR82VUn9qkdfyhGow
         V78ox1+UZPGNmFwJEkV5Ljdf624ojzb+EZa5pUxYNmt6O9+O3aEv9h08YXqC8JiShk+Q
         b/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNiZJaCrGq65PxCAmi5t4zzJmAJ8DnrIv292iGTPgSXM8VzcZUQGoPaSgp4X9M3QWPbkaoqllSeo/EGmgcDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6948L4ca4SZGshxBrPOCe/Fs7HaYa0AK7lc24E7W2sd5vkCDv
	1Dpo8nXnwQUSY4wklqTPLIKy/JgeG4V9UAZZdg+1L75YtvttyERBT50xd3ChLh4jV5hJlUHguaM
	xcHlfRHuWGN08AtaH2G43VVl56oLEh180h3V3c6Zcvi0Si+cqp9AU70o3ewhruCAVkX1sQ+BCWi
	Km+YfWi7EbZJ1xlUYblbCnewzxkMLc3c/Ai4Bczoc3aMk=
X-Gm-Gg: ASbGnctDOXIkSXcuXpudwtb1shJRgUAxkyod5r6U2yYb/712S8+F3ATPlIG17rXDAnK
	O2CvwV09U/lK8KzU9JZ3khHoViRb+vYxx9dFI4rEdo7MOI4zEvV4PIYDnXf5z1GmsDmC5jfrSeu
	ZyK5yDUw5mx08imOE5Uto=
X-Received: by 2002:aa7:cd43:0:b0:636:7b44:f793 with SMTP id 4fb4d7f45d1cf-639d5c76f3amr16517946a12.36.1760437306415;
        Tue, 14 Oct 2025 03:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKrvE9Xc9mqZwQ51BrULFDR+Gy3L+td0SwFVlzpJhYd2POB68sD9sCyewNnN1OSi+CZpFHWHtKVkVVztq+xfw=
X-Received: by 2002:aa7:cd43:0:b0:636:7b44:f793 with SMTP id
 4fb4d7f45d1cf-639d5c76f3amr16517926a12.36.1760437306030; Tue, 14 Oct 2025
 03:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org> <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251014051537-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Tue, 14 Oct 2025 12:21:34 +0200
X-Gm-Features: AS18NWDpS8D6S4j8bcZBNBYFKVG5ZJYkhs61PKFEtR3JascrL9Zw9_GKX6oIn1M
Message-ID: <CAO55cswTyMBsKdpn7becsY4Ry+ZUoEfgP+2Q+DkhZ090VK_-2A@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D5-Q4S-PESINPoej7Sb8kl71UK4G1T7clKOO_5KYXmQ_1760437306
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=A9rez wrote:
> > > > An userland device implemented through VDUSE could take rtnl foreve=
r if
> > > > the virtio-net driver is running on top of virtio_vdpa.  Let's brea=
k the
> > > > device if it does not return the buffer in a longer-than-assumible
> > > > timeout.
> > >
> > > So now I can't debug qemu with gdb because guest dies :(
> > > Let's not break valid use-cases please.
> > >
> > >
> > > Instead, solve it in vduse, probably by handling cvq within
> > > kernel.
> >
> > Would a shadow control virtqueue implementation in the VDUSE driver wor=
k?
> > It would ack systematically messages sent by the Virtio-net driver,
> > and so assume the userspace application will Ack them.
> >
> > When the userspace application handles the message, if the handling fai=
ls,
> > it somehow marks the device as broken?
> >
> > Thanks,
> > Maxime
>
> Yes but it's a bit more convoluted  than just acking them.
> Once you use the buffer you can get another one and so on
> with no limit.
> One fix is to actually maintain device state in the
> kernel, update it, and then notify userspace.

I agree, this is the way to go.

Thanks for your insights,
Maxime

>
>
> > >
> > > > A less agressive path can be taken to recover the device, like only
> > > > resetting the control virtqueue.  However, the state of the device =
after
> > > > this action is taken races, as the vq could be reset after the devi=
ce
> > > > writes the OK.  Leaving TODO anyway.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 31bd32bdecaf..ed68ad69a019 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct=
 virtnet_info *vi, u8 class, u8 cmd
> > > >  {
> > > >       struct scatterlist *sgs[5], hdr, stat;
> > > >       u32 out_num =3D 0, tmp, in_num =3D 0;
> > > > +     unsigned long end_time;
> > > >       bool ok;
> > > >       int ret;
> > > >
> > > > @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(stru=
ct virtnet_info *vi, u8 class, u8 cmd
> > > >
> > > >       /* Spin for a response, the kick causes an ioport write, trap=
ping
> > > >        * into the hypervisor, so the request should be handled imme=
diately.
> > > > +      *
> > > > +      * Long timeout so a malicious device is not able to lock rtn=
l forever.
> > > >        */
> > > > +     end_time =3D jiffies + 30 * HZ;
> > > >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > >              !virtqueue_is_broken(vi->cvq)) {
> > > >               cond_resched();
> > > >               cpu_relax();
> > > > +
> > > > +             if (time_after(end_time, jiffies)) {
> > > > +                     /* TODO Reset vq if possible? */
> > > > +                     virtio_break_device(vi->vdev);
> > > > +                     break;
> > > > +             }
> > > >       }
> > > >
> > > >  unlock:
> > > > --
> > > > 2.51.0
> > >
>

