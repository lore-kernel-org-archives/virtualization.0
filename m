Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBBB2C2369
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698228; cv=none; b=UQs8EK+Hbxc5v+E0L1h5+YoqxDYNdJ1+VxPXqvXNPSMSjkDb0+70AojhJTuluEz8xlOcxGCl4rSKpjeBrTmC88Z1fx6CH2qbTRhAb1ORYZL1D/MOtInuZP19/Bi1p10Xdzfb4O2jjwwjra2CvcFZa67YsFFZm9s5USCUrVS9pTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698228; c=relaxed/simple;
	bh=z2KxUywKM/o4sjXFIMx/mY+Zmwl/FX3Tzo88dQEt2xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF1Geig1RUZSgMhNVSzI5neMRbi7FF82V+LPaTeD6SANnsgibTi10/4BxN0E2twLhAL81IrOtBF8Lr0UjdlxhHXAE+1y0O8+Z/nj34W+bGHdpxl/1tdxA6RgLt6a2lIM7vTILfQ1LosbFky7ikaQSR+wJoRA4CG4Cl/OPRTOMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqKqCy3H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqKqCy3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761698226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2KxUywKM/o4sjXFIMx/mY+Zmwl/FX3Tzo88dQEt2xs=;
	b=SqKqCy3HOkbeW/a6ipLPP0dtoWBpmtUS0Cj+CBN9PAVTx3iZWYgI4cEa6jIXD0YoyiAwkU
	N1AjdERdyDp2NQx9fG9axt2A0V1T1ImP7bD9OHAIkG0svLWS9gJ2/mj62vwbaCrNcWMtGr
	Dc2riachxeeYuaCYo0Kdp8o/MTJiA2g=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-ws79M0VNPzusPrDzFjF4bQ-1; Tue, 28 Oct 2025 20:37:04 -0400
X-MC-Unique: ws79M0VNPzusPrDzFjF4bQ-1
X-Mimecast-MFC-AGG-ID: ws79M0VNPzusPrDzFjF4bQ_1761698223
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290cd61855eso56367805ad.1
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 17:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761698223; x=1762303023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2KxUywKM/o4sjXFIMx/mY+Zmwl/FX3Tzo88dQEt2xs=;
        b=AP4OtVVFZoCmkfSn2FQBn7Njt/tKRHQ4Y1it4hBPd+DWfJQrI820ulSaXwEOegCnaU
         Lwxy+J+Vki3gBaY8qD8pRqQaJ+dGD9CL5DX2RG+69/MSkhHfGMQYJ7ZOXkAL3W3nn9Hx
         /5YhADEecL19zUcsNrk4IM+RZSUjC0Zkwz37FBzMIQB9kTOFB9+OD58Eqei4v62M04Ob
         hrvie0A5WnHOvJEEV8PW0WiPoRdeJJz3mibm82JC2LnJXq/gsk325rAUlbGOupuwMvRt
         iGxlPLc09kGkNrRe4eJ6IvsJv54O7Q6ub4RTf/g0Niq9/1njFJQzCPLEOc6RmH5GJ7uQ
         cZxA==
X-Forwarded-Encrypted: i=1; AJvYcCWa55rZxitMuTYKUGUBoEWsdqjgOclBhUnms1sreGKABbKANJPUPwFwvF10qZHjiWea+3WMCDoMMs5/yAJTUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywv+kO1GsIpUd67PCnLMr2Zb0yT7Bi2UpefTjR4GGqCrwJH77uM
	PCjduo5vHJlgIYrAV9YlxuZxPSWWtCewvOMn7mS45neo1kZXmJTheH8gdTbP/DolIoDWxsZ/ep3
	MznYW8vvEshVgoY+yzQSbJpNHGgn2/V3LpkuBT0/3DxzOUGcJNDfP644FrTCfH3EzObQF1OyKIT
	rFM8DfAE/hpWSDrwz/lKDqNTZ3yegKiFKalJrGwuv0MkA=
X-Gm-Gg: ASbGncv9U+J/pQMugJo7BnbZ6qnhFYj8gIvNGIY8tNjlofaMBSfexCBRjIK/QewxThS
	5Ar7B8asIb23LeP7X3nue5JahshAhqeczsqEd5Lw7b8xafOap7aT2I6/swEEEuz8Tta6vVVWUKI
	VnaTBP2/PTcLvvDzsayLhASP0ysXq2YT6S0a8U5NBFvLKH9cURAvsV
X-Received: by 2002:a17:903:18c:b0:25c:76f1:b024 with SMTP id d9443c01a7336-294dee3572dmr10317065ad.25.1761698223396;
        Tue, 28 Oct 2025 17:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/SiMLBBOrGOScV5jwu3LEgWMNSKEpwIxmJj+/O/Qz7kK4bu5+UPkMl7kc61nl2u6Eqbd9szURp9TnMPpT23k=
X-Received: by 2002:a17:903:18c:b0:25c:76f1:b024 with SMTP id
 d9443c01a7336-294dee3572dmr10316805ad.25.1761698222965; Tue, 28 Oct 2025
 17:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org> <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org> <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org> <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org> <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
In-Reply-To: <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Oct 2025 08:36:51 +0800
X-Gm-Features: AWmQ_blHBTuatMSJPDVuJEjsd9mldfKukgTo-6k1-Y6oj3d-VR92-lkw7uaPq1E
Message-ID: <CACGkMEsv3SXnQ74bQKadcOr5Ztv-O-VZ8Zgfdq7mXqXN_Yrg0Q@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vaKmC5eVhaSdPg-gHkhGhVvB9KdNnGsDAK82JJqSPXc_1761698223
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:58=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Oct 28, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrote:
> > > On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrot=
e:
> > > > > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > Let me switch to MQ as I think it illustrates the point bette=
r.
> > > > > > >
> > > > > > > IIUC the workflow:
> > > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAI=
RS_SET 1
> > > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > >
> > > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at th=
is point,
> > > > > > > so it potentially uses the second rx queue. But, by the stand=
ard:
> > > > > > >
> > > > > > > The device MUST NOT queue packets on receive queues greater t=
han
> > > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_=
PAIRS_SET
> > > > > > > command in a used buffer.
> > > > > > >
> > > > > > > So the driver does not expect rx buffers on that queue at all=
. From
> > > > > > > the driver's POV, the device is invalid, and it could mark it=
 as
> > > > > > > broken.
> > > > > >
> > > > > > ok intresting. Note that if userspace processes vqs it should p=
rocess
> > > > > > cvq too. I don't know what to do in this case yet, I'm going on
> > > > > > vacation, let me ponder this a bit.
> > > > > >
> > > > >
> > > > > Sure.
> > > >
> > > > So let me ask you this, how are you going to handle device reset?
> > > > Same issue, it seems to me.
> > > >
> > >
> > > Well my proposal is to mark it as broken so it needs to be reset
> > > manually.
> >
> >
> > Heh but guest assumes after reset device does not poke at guest
> > memory, and will free up and reuse that memory.
> > If userspace still pokes at it -> plus plus ungood.
> >
>
> I don't get this part. Once the device is reset, the device should not
> poke at guest memory (unless it is malicious or similar). Why would it
> do it?
>

At least for this case virtio-vDPA + VDUSE, there's no way for the
userspace to poke after reset since everything is done via IOTLB.

For other devices, if we want this extra safety, we need to enable swiotlb.

Thanks

