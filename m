Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296B1474B8
	for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308791; cv=none; b=eKDTCMyAfeQeB+y354kJzLx3pSBcKCxrcCSrffanPEfoKAIQTfUWLUiZ/jPUn4iSO0mMbclPCMe1rj8JjydrCUN7AezSeFeDsCuZkSYY9iWt/0azvaG5YDBfaz7WPb/w5mXTbkTNn05k0KKFa0MDtHp/avURgCG3GWLxTjnKnYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308791; c=relaxed/simple;
	bh=HyX+3BVaOG7CR9AYkNVWcTm75cFajmUq2m/2q0ImLMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vgl80ThXaM4AHgeogaymtqNAhscwBB7IOoz2wuxU1in3XAbLsPWnWnK04Z51xV800Eh2LKsNoNP0IQ0L3NKAseSIUHlj/ve/GUUIwZmQKVU14YJLjzcHAEp0685DJ9XdNzaI3wWWPgSVfu7vjXwPSDdfQEDCF5+F8vxeTHZc2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IER+C1AE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IER+C1AE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722308788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyX+3BVaOG7CR9AYkNVWcTm75cFajmUq2m/2q0ImLMs=;
	b=IER+C1AEQIN7eySFTb2T1AEfInpVl1Tyx2i9qaZalwSDYqHgjWKFAwfL19J/IYvEESiX4q
	JBIYKUWrAHi+sYQQhXHZWillOv8xem/S69eaMDzT2Fra841nspqAJA1l/G2MHhCutQT8ZA
	zGlLJf02O7EXigb58CwpghQcYvMxlQs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-E6OL9QrFMgype4lXe4kC1A-1; Mon, 29 Jul 2024 23:06:24 -0400
X-MC-Unique: E6OL9QrFMgype4lXe4kC1A-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7a2a04c79b6so3518883a12.0
        for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 20:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722308783; x=1722913583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyX+3BVaOG7CR9AYkNVWcTm75cFajmUq2m/2q0ImLMs=;
        b=ufPdCy2ZsbWsAvxOqP4wmr2UWe9k9nfEWfY86xBmbgX+DWpp507u0aaMFpqh0WVWiu
         5MjS+TRmGUYQSZXgqC/BKuO6G49/fy1fvq18w2wLE2wJTAaouUZ+oupNYck96FZ0S855
         AulhlPiT/qXHAUxqwT6V1fSEE7yC9BQm5T3AVTdKCV8pjh01S40YNAOr2F9WkTlgE0bP
         tH2F+OtywEkPAL3plEaoPA7yM3t2LHepiyviTnIJc7NidbsU+mUMqsWR/ZxqWwP1whs/
         AAR9NF88MpMZbw8aTZgoJeIZrCodJ0D0cgdi4Rv9hHdiyAInzZ9JhkmSRVkO+3OpNq5t
         yWKA==
X-Forwarded-Encrypted: i=1; AJvYcCVZF0e4zkYmvTukedL0n1LgV+qZvuRTjSKo46QstqoKADDIaftF1jKiDGBHPPL8DQn9vmBUsaqfKsjXLbMsrjLlhcBckXWd7eRRyBOtUZc=
X-Gm-Message-State: AOJu0YyUT4T0SGjBfCAXP9khEjx+GPzJcPMJeUztwnuSyJsude633mFx
	esbCVNmSKHRRPtUeVMR/cShHdVlTJi0RCsNzIUoKLpcNfTKn4JQ+HwWN9XPZj2UrBkISfd+6Jxx
	MUUjf/bZgtPBUFzKROZvC2zOvZ327J8SBzXGxV3mJAeRjvXKdl6JyMis46ZNJ8MdauPJNvYiL9H
	L2++Ul62LK/j5ryni+u3/pXgEQguqagy3AkSIL1Rw=
X-Received: by 2002:a17:90b:4c03:b0:2ca:f755:1040 with SMTP id 98e67ed59e1d1-2cfcaaec72fmr1120839a91.7.1722308783318;
        Mon, 29 Jul 2024 20:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFryUvcqGZpQYTjgqUn1VlxKwR493Yb4lfjVWyYmy1iS1ZVdwKJCPFlCrpqBtot+TLUJS6GFjig5uLn+V4DMps=
X-Received: by 2002:a17:90b:4c03:b0:2ca:f755:1040 with SMTP id
 98e67ed59e1d1-2cfcaaec72fmr1120806a91.7.1722308782849; Mon, 29 Jul 2024
 20:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724033816.GD492231@quicinc.com> <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
 <20240726070324.GA723942@quicinc.com> <CACGkMEtin7mb=rA_nS6ArinP4k_v-Zsa05tMb_KXXUvfuCMiKw@mail.gmail.com>
 <20240729060122.GA1542333@quicinc.com>
In-Reply-To: <20240729060122.GA1542333@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 11:06:11 +0800
Message-ID: <CACGkMEsRtxezU8sEPYiVWSdmEDAZ-7=ZFGO-oHidR1UcS=rgbw@mail.gmail.com>
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

On Mon, Jul 29, 2024 at 2:03=E2=80=AFPM Srivatsa Vaddagiri
<quic_svaddagi@quicinc.com> wrote:
>
> * Jason Wang <jasowang@redhat.com> [2024-07-29 10:16:48]:
>
> > > Without this optimization, guest VCPU would have stalled until VMM in=
 host can
> > > emulate it, which can be long, especially a concern when the read is =
issued in
> > > hot path (interrupt handler, w/o MSI_X).
> >
> > I think I agree with Michael, let's try to use MSI-X here where
> > there's a lot of existing optimizations in various layers.
>
> Yes sure. Even if we implement MSI-X, there is a security angle to why we=
 want
> hypervisor-hosted PCI bus (have provided details in an earlier reply
>
> https://lore.kernel.org/virtio-dev/20240726070609.GB723942@quicinc.com/T/=
#m84455763d6b4d0d3b8df814b3d64e6e48ec12ae3
>
>
> > > > > We will however likely need vduse to support configuration writes=
 (guest VM
> > > > > updating configuration space, for ex: writing to 'events_clear' f=
ield in case of
> > > > > virtio-gpu). Would vduse maintainers be willing to accept config_=
write support
> > > > > for select devices/features (as long as the writes don't violate =
any safety
> > > > > concerns we may have)?
> > > >
> > > > I think so, looking at virtio_gpu_config_changed_work_func(), the
> > > > events_clear seems to be fine to have a posted semantic.
> > > >
> > > > Maybe you can post an RFC to support config writing and let's start=
 from there?
>
> Does VDUSE support runtime configuration changes (ex: block device capaci=
ty
> changes)?

Looks like it can, it has VDUSE_DEV_INJECT_CONFIG_IRQ.

> I am curious how the atomicity of that update is handled. For ex:
> guest reading config space while concurrent updates are underway (SET_CON=
FIG).
> I think the generation count should help there - but it was not clear to =
me how
> VDUSE is handling generation_count reads during such concurrent udpates.

Similar to the above, we are missing uAPI to do that. Probably just an
uAPI to update the device generation.

Thanks

>
> - vatsa
>

