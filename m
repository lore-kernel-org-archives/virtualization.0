Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB827F484
	for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 03:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309057; cv=none; b=fu2xZnc5Z8HQtBd4mxSRsQy7C7kCDRjNQo/436uFSshzU5UMZcucFPM1mj/0Cfu/UEk7R+dVykGOtaqU4ZWKu3mjdQx4AZI5fm3U2UPofz0bP1eB7PopDelcCMea3hnDHG1kCJOqw+PAoJGVUALgaP/CeDBNtDQT31ydDB5t5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309057; c=relaxed/simple;
	bh=hoPk+Y1c2pYRS5BORMEZbsorfi+63n2pxsSueQkde3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixNEjKruppsHOFM/MAEYVTiqPc0JZ8EkP5eWbIAXkFMoSk9jF6OFFSGTUGvCkoCBLrLvFvKwu2aFYwSaNWI6qyDRDbEdCjx9mw0Y8fteP/z/jJAZmxUEQMMKrS/OL6DWpllDEKKUDSy1y9ESsXl5Ebx6EfVUuvQLhz8e/QpUKns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqUu0OxW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqUu0OxW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722309054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoPk+Y1c2pYRS5BORMEZbsorfi+63n2pxsSueQkde3k=;
	b=BqUu0OxWoOnLnqC55HV/Fi9LrbaVYV1DUP1IU0OLnoh2F8B3K3fO+I9Nc5KgstrlsRCJXF
	Cv8p/nekNFItyszqNtq1ATqndBJwDNwgnKveUZdtGvxSTZbRBnpNbtV7cIGTm4ygf/xN/f
	WuxdwfIuEN4s+gm8fusFZobKTzWb+CQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-mvGjNDudN52DMOhogXIc9Q-1; Mon, 29 Jul 2024 23:10:48 -0400
X-MC-Unique: mvGjNDudN52DMOhogXIc9Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb653cb5e6so3949383a91.2
        for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 20:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722309048; x=1722913848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoPk+Y1c2pYRS5BORMEZbsorfi+63n2pxsSueQkde3k=;
        b=dZXfWQGX3fzebOvpl8Bu4PsMY+dWLs1bdwkgHekEmKxrwALTdW4ihcC3dsHEmYhU/w
         uSYeGF+kW2+FCivcBWLPExBqwk2gK5Po8NP2TMIyag337UhjCmuZ0x5nEfr+ZpYqAkqF
         NnIvn1+MtQjPzNgRdhTM541HhKGXpNbbXwkC/BKawTpTUhR4+SHaNUzWz0iB0cdnqsLh
         hnPdFa+xPcPaRFEM34mSXdW0OXm5LfYRB/CH+7vgeuAY/YuWaN8Cp9QeXi6dD9xKtHZG
         zl5fZ27S7+Nd4KSCC/oEfdSgGS+0BDZm2oRjBGmK+vXecBAp4RLdqlT24Li51sFSlgTu
         Gzdw==
X-Forwarded-Encrypted: i=1; AJvYcCX+zz/CXsqNAmT6atywATwz3hBYgbs5NZSRuGdX9IxtCYYPL2S8WfRANOK7IAtnOXWYBMjC/iYHVsJafSSm/MZ1SSayun7yFVmrrYvSP0g=
X-Gm-Message-State: AOJu0YysGf6mwo+ijR3xxMUaZQL4Se9kDyqH9I7AxPj6PE+3oVZncu8N
	/BZMDbBg6NyzPItaxTCbuMOVew9w8MKBpB3nu+MFVSQBRS+rKgKiN3iohFQ+DnKMGbIYvnU37/U
	5nr7YnGpLL/VzE5DRY/OMIXYNyoS+t0Wx7Pg0yznd1b3jGUR9nZGFcUrdtfyp+YlUy1YzXbX8Dx
	5uHHq9q7cyN0fVrtAtLmBt5oeaubzZSSFi72sSbjU=
X-Received: by 2002:a17:90b:915:b0:2cb:5455:8018 with SMTP id 98e67ed59e1d1-2cf7e1fb9d1mr7881932a91.23.1722309047796;
        Mon, 29 Jul 2024 20:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIt5i2b9H8odLQpO+0TZxjUjhrhFHoUwZ7ouWKVcyhF8EmvcBUEQGWKFmxEqa0/kUjpb0g0bdydgoerkwk248=
X-Received: by 2002:a17:90b:915:b0:2cb:5455:8018 with SMTP id
 98e67ed59e1d1-2cf7e1fb9d1mr7881900a91.23.1722309047260; Mon, 29 Jul 2024
 20:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724033816.GD492231@quicinc.com> <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
 <20240726070324.GA723942@quicinc.com> <CACGkMEtin7mb=rA_nS6ArinP4k_v-Zsa05tMb_KXXUvfuCMiKw@mail.gmail.com>
 <20240729060122.GA1542333@quicinc.com> <CACGkMEsRtxezU8sEPYiVWSdmEDAZ-7=ZFGO-oHidR1UcS=rgbw@mail.gmail.com>
In-Reply-To: <CACGkMEsRtxezU8sEPYiVWSdmEDAZ-7=ZFGO-oHidR1UcS=rgbw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 11:10:35 +0800
Message-ID: <CACGkMEt+hCQTfCkPhPR+47rMiPCfZLCJkpC-=2drKAiAFRxJCA@mail.gmail.com>
Subject: Re: [RFC] vduse config write support
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: xieyongji@bytedance.com, stefanha@redhat.com, virtio-dev@lists.linux.dev, 
	virtualization@lists.linux.dev, quic_mnalajal@quicinc.com, 
	quic_eberman@quicinc.com, quic_pheragu@quicinc.com, quic_pderrin@quicinc.com, 
	quic_cvanscha@quicinc.com, quic_pkondeti@quicinc.com, quic_tsoni@quicinc.com, 
	eperezma <eperezma@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, mst <mst@redhat.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:06=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jul 29, 2024 at 2:03=E2=80=AFPM Srivatsa Vaddagiri
> <quic_svaddagi@quicinc.com> wrote:
> >
> > * Jason Wang <jasowang@redhat.com> [2024-07-29 10:16:48]:
> >
> > > > Without this optimization, guest VCPU would have stalled until VMM =
in host can
> > > > emulate it, which can be long, especially a concern when the read i=
s issued in
> > > > hot path (interrupt handler, w/o MSI_X).
> > >
> > > I think I agree with Michael, let's try to use MSI-X here where
> > > there's a lot of existing optimizations in various layers.
> >
> > Yes sure. Even if we implement MSI-X, there is a security angle to why =
we want
> > hypervisor-hosted PCI bus (have provided details in an earlier reply
> >
> > https://lore.kernel.org/virtio-dev/20240726070609.GB723942@quicinc.com/=
T/#m84455763d6b4d0d3b8df814b3d64e6e48ec12ae3
> >
> >
> > > > > > We will however likely need vduse to support configuration writ=
es (guest VM
> > > > > > updating configuration space, for ex: writing to 'events_clear'=
 field in case of
> > > > > > virtio-gpu). Would vduse maintainers be willing to accept confi=
g_write support
> > > > > > for select devices/features (as long as the writes don't violat=
e any safety
> > > > > > concerns we may have)?
> > > > >
> > > > > I think so, looking at virtio_gpu_config_changed_work_func(), the
> > > > > events_clear seems to be fine to have a posted semantic.
> > > > >
> > > > > Maybe you can post an RFC to support config writing and let's sta=
rt from there?
> >
> > Does VDUSE support runtime configuration changes (ex: block device capa=
city
> > changes)?
>
> Looks like it can, it has VDUSE_DEV_INJECT_CONFIG_IRQ.
>
> > I am curious how the atomicity of that update is handled. For ex:
> > guest reading config space while concurrent updates are underway (SET_C=
ONFIG).
> > I think the generation count should help there - but it was not clear t=
o me how
> > VDUSE is handling generation_count reads during such concurrent udpates=
.
>
> Similar to the above, we are missing uAPI to do that. Probably just an
> uAPI to update the device generation.

I meant userspace can just do:

ioctl(fd,VDUSE_DEV_INC_GENRATION);
ioctl(fd,VDUSE_DEV_SET_CONFIG);
ioctl(fd,VDUSE_DEV_INC_GENREATION);

And synchronize the device generation increasing with
vduse_vdpa_get_generation(). Then we should be fine.

Thanks

>
> Thanks
>
> >
> > - vatsa
> >

