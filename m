Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4197C2E6CA7
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433297; cv=none; b=ErW68N1tcwQyxkwALch2MWeEGNJBuq5y1lNKREzIBlzRrHTmi9iEoTmxeMxt12cei8yUk7R1JoC9wmBfdvvx6r5OhOxOwECH8ukqNphCQdGR5Rwrv6NeE+uLlvTIhuwia1vsrABbbirLsi9eP8F6Q7ms5Nde7Jpj74plTnn7dPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433297; c=relaxed/simple;
	bh=Oe9BwXCx5mTi7D94IVeSvUgRbst/UVU8w13GJgYIh6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezu27fjdF7AO1GvUN/xRjeqMgu/sAKuYtXQb2B+Ge2f/gcRTQRZqGeztNnjr9EPhwLyv0xQX39JzIV95cC/fn4xHRD/LI/o8HZpAiMWK++PhUjZ+5yjvU/s5jRDEHohowj7yvVP+Ym5QeBcdzqxW7iG44CkDe9xjR7ysx5X0Kk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtZcO4xe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtZcO4xe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760433295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjFzk/lXUrsoKBLaVwr+eBWd6g6pix2Ksz3wpcPF/28=;
	b=PtZcO4xeHzbc9fjkdzrog89GHfoKaDEW7RzAxGf5IYoQthsgbDeYQtTATCb+s9HBMMnUjT
	ryTbIA5PMmOG7UBpCTdh0sgdcu9v3uPQO9vne/Mvk6F7Es0k2CHrcyb+YrXUM2qOXdC9A6
	G1+pKJxghWKxzlXkvSIl69SMqKtCb/A=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-l0qYb9-TPnm-FKlhERQGPA-1; Tue, 14 Oct 2025 05:14:53 -0400
X-MC-Unique: l0qYb9-TPnm-FKlhERQGPA-1
X-Mimecast-MFC-AGG-ID: l0qYb9-TPnm-FKlhERQGPA_1760433292
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-57da66e0dc7so3889810e87.1
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 02:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433292; x=1761038092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjFzk/lXUrsoKBLaVwr+eBWd6g6pix2Ksz3wpcPF/28=;
        b=TcXX+3uVVT/vtIUJ3gTuVWoUhWiENHpGYpNJHfDfetmr94A2ld6cDFjCyiYsHy68ZH
         9nk5Y9D/dNoN3AgNeVIBBvslOqDeqC/4ofjQPfzwCUDt84Y/y5UrYQJ3fjKTtz5HoDpy
         21nWmnFckJueoS4VrA52l7NbEEPwROFb04NEM16XrevnXfONS+DQU/QamAGwi6en4ieV
         GFp56daiwhhxiJNv0BSwIg6IfZl/ICT3XD+2QQQ40mWRqG64Y2y10GWdMJpPRUs58NjN
         BTFgflDxOJKoBFmU4HdiNJ/9APB9jpKPCvPDA6CB1SjWsaViBeqgpLL+aEmF1kf5KnkR
         9YqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdp02saGvngA/sqVVvLTaInHJyIGhwoF0SG9nqhnymIjRbfrb1QX0VYHip8IxDfZk23ZnoFVGuPd7Cb+UwOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMRhUo9eQIP7WmD7yJTke2ov7v9M8sPbbw+OCo1lQ7pcQ7Vx+/
	iA7hcSX6HXiceC0reTzNcyVoib+Agz6luJk3/QvUisWWvImCiRHx9x/rN9BRoawmOKvOoCcvRM9
	+LHeP0abyw/q8458QGnsiqFS/1GB88vc3qiep1vLRHMmNTNLsUB+MlK8JJccE4Rm7hBzk0zVdEr
	gwZt+zNK7iLnnWkJ9NX6q8OpNPzwI5xLFwHUZ6RTWV89g=
X-Gm-Gg: ASbGncvT7M/dYsb4frmZkjoqaT5/S1qwJkPtSx30/KVTW366jXOSE4XSUgTO/MPrUth
	ft7tQVJfuy9BfSdl3aJqeKRNM02xnb6lHr7WfIcLUo8ekIoo2ce9TL+uPUZTnNWWLFvI5Pr85DA
	0K5u5uLnjD5vVYaG14o6w=
X-Received: by 2002:a05:6512:131a:b0:57f:42c8:409 with SMTP id 2adb3069b0e04-5906dd6aa55mr6464984e87.39.1760433292100;
        Tue, 14 Oct 2025 02:14:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQaadRipU0EaeNi46sv19M3AVTnexyca5jXwlVD7EkR3B7khaZ93kLadMtEiUtbufik7xqECGA8OqqwXCTMOY=
X-Received: by 2002:a05:6512:131a:b0:57f:42c8:409 with SMTP id
 2adb3069b0e04-5906dd6aa55mr6464970e87.39.1760433291667; Tue, 14 Oct 2025
 02:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251014042459-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Tue, 14 Oct 2025 11:14:40 +0200
X-Gm-Features: AS18NWAOeQa0WEHFwSIShkcFXHYVmOKdwTw9vdFnAxBWu2pL8g9mbBpXpqcp2jo
Message-ID: <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iDg-Ea1Mcd3ZS710krqIJ4O-w48MkMTT5McjjvVc_iA_1760433292
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=A9rez wrote:
> > An userland device implemented through VDUSE could take rtnl forever if
> > the virtio-net driver is running on top of virtio_vdpa.  Let's break th=
e
> > device if it does not return the buffer in a longer-than-assumible
> > timeout.
>
> So now I can't debug qemu with gdb because guest dies :(
> Let's not break valid use-cases please.
>
>
> Instead, solve it in vduse, probably by handling cvq within
> kernel.

Would a shadow control virtqueue implementation in the VDUSE driver work?
It would ack systematically messages sent by the Virtio-net driver,
and so assume the userspace application will Ack them.

When the userspace application handles the message, if the handling fails,
it somehow marks the device as broken?

Thanks,
Maxime

>
> > A less agressive path can be taken to recover the device, like only
> > resetting the control virtqueue.  However, the state of the device afte=
r
> > this action is taken races, as the vq could be reset after the device
> > writes the OK.  Leaving TODO anyway.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 31bd32bdecaf..ed68ad69a019 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct vir=
tnet_info *vi, u8 class, u8 cmd
> >  {
> >       struct scatterlist *sgs[5], hdr, stat;
> >       u32 out_num =3D 0, tmp, in_num =3D 0;
> > +     unsigned long end_time;
> >       bool ok;
> >       int ret;
> >
> > @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct v=
irtnet_info *vi, u8 class, u8 cmd
> >
> >       /* Spin for a response, the kick causes an ioport write, trapping
> >        * into the hypervisor, so the request should be handled immediat=
ely.
> > +      *
> > +      * Long timeout so a malicious device is not able to lock rtnl fo=
rever.
> >        */
> > +     end_time =3D jiffies + 30 * HZ;
> >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> >              !virtqueue_is_broken(vi->cvq)) {
> >               cond_resched();
> >               cpu_relax();
> > +
> > +             if (time_after(end_time, jiffies)) {
> > +                     /* TODO Reset vq if possible? */
> > +                     virtio_break_device(vi->vdev);
> > +                     break;
> > +             }
> >       }
> >
> >  unlock:
> > --
> > 2.51.0
>

