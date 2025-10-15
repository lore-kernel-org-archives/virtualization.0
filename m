Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB512BE64F
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 04:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503504; cv=none; b=ZZ6P+sst3c7RxJgwG90UWy9ByqTG2fB6s5thnUrA87+e3SSq1iZVHYEME3GUa/7H924vzpYFk/CEYzZLfGzsl1q3EurV+2Iu8a5ilsGhsdrhysmAadtXrRY0psbw8ZDczrKRF+dZp6dmAKFyDqrLGELN0/xh4CVWxVQ2jGj6OvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503504; c=relaxed/simple;
	bh=LSC2b/SZp1Gl7xSk6Lw/gyf4cf3285mzXQOprivu0bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaUAl5VoDQPdfaacPecnG6dA67TLsuIpN90MfE6l2M4faYL4PDmcVPZa0O+BdMYm/GdbsFgp592HGD/ws93r8X+aps7vOVVH0j21U+40PoztqyvtfzD5Z+8l8dz3q71SvHXDkNOi/6Qzu7A8MTTETgZs+IdZvQx39nb2WpjkM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOlmbeqX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOlmbeqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760503501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHoYpl/qIggxMNAcJsbGTBz+xXz4lxSJ0MRugYkIEII=;
	b=FOlmbeqXF72FrOVcizHMFJQXZFsCCZV+PQspr+Df9eWnbkpLipLYreUVzpf/3jxCisjtx7
	8kTTgENga+JaGOxhOR//D4FJQtN/1R0VmjhyqZ0cXdcq7Rlkdm+aUQNs9ujccSc1x1u8rT
	juZ6MDgqgRbLiC0aZVCdCmK+KzBvjbc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-qMNMNXS8ORK6R4Z7uLX8pg-1; Wed, 15 Oct 2025 00:44:59 -0400
X-MC-Unique: qMNMNXS8ORK6R4Z7uLX8pg-1
X-Mimecast-MFC-AGG-ID: qMNMNXS8ORK6R4Z7uLX8pg_1760503499
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so9553039a91.3
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 21:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503499; x=1761108299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHoYpl/qIggxMNAcJsbGTBz+xXz4lxSJ0MRugYkIEII=;
        b=VQJxUXtUS55LDpiY3n9CT+KtfAbsNDlhN8Dl/F9ENjtSMCsR1rNzwmptRYito0jBmd
         rCcqTBQQvcEuWPUnkNJ45wKr06T21iGgeJd9uicseGTA+xu/b4E3xENAV0N5Hh9D5SO5
         bjh5bFRAzwgIZZDG77fr8DzqrlMqkJNpPQ6tYsqnapd37GnJ55Ny5JVxaJDi1v2g5MFx
         /QEuuncSdBa6IB+SODknsiQnTaLvpb0mLlSuhDcG6Zq+5TfzkS6Hy1VOcZGp8r3X3Qek
         ZNqSnEDiK2HR7NO5t1AuRwpjf0OJQoh9/coMi0foH2tBpwZh0Y9szHoPVWdq8Hb8iJgZ
         aghA==
X-Forwarded-Encrypted: i=1; AJvYcCXHRus26WQ9sIEcOJ/k82uRPQvtr+YO+4zRovnmGuetE+pNcM7nWn57JclhU0179mqbcg7nb20n7PdfHyVyqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKgN9CY35YeBfAY/RYEDHUKIVVZhbcPQluJbfoO3+svmWCFood
	ENt3MU0XC6Ebileds7DUmKH4ogEmLrioXpspOENA+SsVZ5W99qYftBIut7dLuisjN9j2Xvcril2
	wj3eG6i7iSy+IwI4lP7C80u20YKUXbQG/tP+edPjiKOuCH1fnCp7ynQY30OU9W1kFpwlMYVJTaH
	aSsoRY5rTnGVY3oIjVlqD0gAT9BQJQzAt4VM/RrUlulvU=
X-Gm-Gg: ASbGncucju5MLRVPiHAI7apYhQTQJ0Xk7F6mkf1kiBrQlQt3kal151PEYX/2FyNJGFt
	qDagsslZuW9nzwuoHJ56oaWLAhR5FTxChWcsuZ0ddXKFtPScpMhg9nZb/a3ZFgcDpwJP9bN4Fwp
	OcqnKV+V++7B5TTT7pg4wTPg==
X-Received: by 2002:a17:90b:52cc:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-33b511185e2mr37768142a91.9.1760503498822;
        Tue, 14 Oct 2025 21:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUUG7KvPpgu2PoUpaCejKKLwvLLR4CU9yjeUizM/YHX9ytu/zSq05xQ+TuWMfC+xZEYoP6Jo/SXgn/94OmTVc=
X-Received: by 2002:a17:90b:52cc:b0:30a:4874:5397 with SMTP id
 98e67ed59e1d1-33b511185e2mr37768107a91.9.1760503498328; Tue, 14 Oct 2025
 21:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org> <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org> <CAO55cswTyMBsKdpn7becsY4Ry+ZUoEfgP+2Q+DkhZ090VK_-2A@mail.gmail.com>
In-Reply-To: <CAO55cswTyMBsKdpn7becsY4Ry+ZUoEfgP+2Q+DkhZ090VK_-2A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Oct 2025 12:44:47 +0800
X-Gm-Features: AS18NWCpLV_Q4BfzxhayYNBKCHjXEh1dLniJamBX5d0_jeJRK-MbZ2aXW1QBTaw
Message-ID: <CACGkMEsqD1qAgt8qfV=fwj1OeBeXzoOF1wXdqzJaWYR2A=C+UA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: Maxime Coquelin <mcoqueli@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zc85XxuQ3NsW0FwJ_XFF6c6p1dkmk6ZNTk7f3x_mx8g_1760503499
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 6:21=E2=80=AFPM Maxime Coquelin <mcoqueli@redhat.co=
m> wrote:
>
> On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >
> > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > >
> > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=A9rez wrote:
> > > > > An userland device implemented through VDUSE could take rtnl fore=
ver if
> > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's br=
eak the
> > > > > device if it does not return the buffer in a longer-than-assumibl=
e
> > > > > timeout.
> > > >
> > > > So now I can't debug qemu with gdb because guest dies :(
> > > > Let's not break valid use-cases please.
> > > >
> > > >
> > > > Instead, solve it in vduse, probably by handling cvq within
> > > > kernel.
> > >
> > > Would a shadow control virtqueue implementation in the VDUSE driver w=
ork?
> > > It would ack systematically messages sent by the Virtio-net driver,
> > > and so assume the userspace application will Ack them.
> > >
> > > When the userspace application handles the message, if the handling f=
ails,
> > > it somehow marks the device as broken?
> > >
> > > Thanks,
> > > Maxime
> >
> > Yes but it's a bit more convoluted  than just acking them.
> > Once you use the buffer you can get another one and so on
> > with no limit.
> > One fix is to actually maintain device state in the
> > kernel, update it, and then notify userspace.
>
> I agree, this is the way to go.
>
> Thanks for your insights,
> Maxime

A timeout still needs to be considered in this case. Or I may miss somethin=
g?

Thanks

>
> >
> >
> > > >
> > > > > A less agressive path can be taken to recover the device, like on=
ly
> > > > > resetting the control virtqueue.  However, the state of the devic=
e after
> > > > > this action is taken races, as the vq could be reset after the de=
vice
> > > > > writes the OK.  Leaving TODO anyway.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 31bd32bdecaf..ed68ad69a019 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(stru=
ct virtnet_info *vi, u8 class, u8 cmd
> > > > >  {
> > > > >       struct scatterlist *sgs[5], hdr, stat;
> > > > >       u32 out_num =3D 0, tmp, in_num =3D 0;
> > > > > +     unsigned long end_time;
> > > > >       bool ok;
> > > > >       int ret;
> > > > >
> > > > > @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(st=
ruct virtnet_info *vi, u8 class, u8 cmd
> > > > >
> > > > >       /* Spin for a response, the kick causes an ioport write, tr=
apping
> > > > >        * into the hypervisor, so the request should be handled im=
mediately.
> > > > > +      *
> > > > > +      * Long timeout so a malicious device is not able to lock r=
tnl forever.
> > > > >        */
> > > > > +     end_time =3D jiffies + 30 * HZ;
> > > > >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > >              !virtqueue_is_broken(vi->cvq)) {
> > > > >               cond_resched();
> > > > >               cpu_relax();
> > > > > +
> > > > > +             if (time_after(end_time, jiffies)) {
> > > > > +                     /* TODO Reset vq if possible? */
> > > > > +                     virtio_break_device(vi->vdev);
> > > > > +                     break;
> > > > > +             }
> > > > >       }
> > > > >
> > > > >  unlock:
> > > > > --
> > > > > 2.51.0
> > > >
> >
>

