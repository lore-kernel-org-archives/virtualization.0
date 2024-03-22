Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12814A97
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 05:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711085467; cv=none; b=MoePXeBp7vI8wQ1kP+gLnyOHZbOu1zVqczI0IXZHmzOb9LHByjcWvUkVXyt/DlTTNjHMcN0bNocvLPfPTFpG0dseinqPm3p8cVkqCzXxS1ptpUFO56ncHELDhwRyzUKKd8s36ADgyMalRgUeqcTw77eySntPVc6vfGADozYg2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711085467; c=relaxed/simple;
	bh=q21Oo2Bry/F1emY/6CL7cFJhoOqCZgnwXMWaEqLUKt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6k0q9Gm77bV0rA8rU9g3TJA8jU8F4lgiG/QBUb48UnyhN+d0XuBbfJGWjCjeRqXCbLl9q9hVmfRXuih9UWgVEjQxqBkqSRV34lpKGkduQTNZuX44ACDk7UGU/oQVGu7wuGF3dfyay3sBh+o3oMzVoK/QlOeKGJXXAFUKa0Ajzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFo9hMVJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFo9hMVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711085464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zeyqe8RQeD7lvkeazy10PIuuNwicb6A5lKZzL5V9940=;
	b=MFo9hMVJ2H8tk8AlN9wngYTEt280urgOJ+91qE1Wina7VRXr+/DoFD0fNYC3ChhbSqiHBu
	9b44xu/a14XS8pIwH5UpHtGR4cSYxt4pM7pinINvfAx9nBbzhlekzAEVQ+PenW7K+kQV2D
	UOmJFadUIgwAusCqvBSHCG6aMcGjxeE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-B0weqH3OPVC25rZdmfSebA-1; Fri, 22 Mar 2024 01:31:03 -0400
X-MC-Unique: B0weqH3OPVC25rZdmfSebA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29de93371cdso1288603a91.2
        for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 22:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711085462; x=1711690262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zeyqe8RQeD7lvkeazy10PIuuNwicb6A5lKZzL5V9940=;
        b=q82H4wS3Rkz1tagtgm5gEaA30xC5Yuhw3Q0No9lvPoTWmugmG4Wh/Jwn5lOU53jdfa
         yVLCo+erxwZyk2ZwyorkTw3zlmq4i716hcYRXNA57v6+xtXCU1u35qogj/mSTNGmSFRb
         2J9ubW6aQzwX0euLJkVqTQ/Tkw0qMEO8f/RDEJuuTXJUNtiSXq8pPuLDpPB4UyKwssD5
         bPT/KQI0zj5+39eE9eWu0klfa1/aJalCWcpne+4MR+zWBxRWfTGcT3IxHdaKMNtSTbuM
         2F9Du09k+BAwPZ6NjAUwFTra3JsBc5hK1z3Od+Za74YYzTaXhj+EYT38pC1mPnKw1Hyy
         GLfg==
X-Forwarded-Encrypted: i=1; AJvYcCVp6rtMY0Ql6wAQbKZK/AdXOSUcsizPMj/jq+53wxKSP+t+62LmWqXHOzOYkF5hijL3oXeGQf5dSdMvrbs2fdFa2dVdiNB6Qduj1osCw/8=
X-Gm-Message-State: AOJu0YxQbLvsErRfu4yTmWmBs7JcshAkZFybWmDUbVNR+m0zkmQwKFkj
	LopxfDTu9Kpt8XUv0+uO0EaCA3PzvzGYg+b2I1oo37y6TuIMynPeq/3DPrr//1ud3Yta00QetUX
	6ThD6akLAEp/2Cg8eDLqcFLPHYNusseBZOcCt2cQFzLk67l9Hw5JEBtMKsk7/YXNtw4B8XSn/+c
	MTFQ3POP6ivMJ76y6sxl+Nap9rtRl7HhJtxikYNro=
X-Received: by 2002:a17:90a:a418:b0:29c:5ba3:890e with SMTP id y24-20020a17090aa41800b0029c5ba3890emr1322054pjp.4.1711085461982;
        Thu, 21 Mar 2024 22:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQB0sfVvGsmkxlkxiev1UO+YVtZ530Wo19MHC05q7NO4RtVeKRKi9QvIqyovGaiEZByXQR8JJUbHlopkLt9Ak=
X-Received: by 2002:a17:90a:a418:b0:29c:5ba3:890e with SMTP id
 y24-20020a17090aa41800b0029c5ba3890emr1322041pjp.4.1711085461672; Thu, 21 Mar
 2024 22:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+9S74hbTMxckB=HgRiqL6b8ChZMQfJ6-K9y_GQ0ZDiWkev_vA@mail.gmail.com>
 <20240319131207.GB1096131@fedora> <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
 <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com> <CA+9S74g5fR=hBxWk1U2TyvW1uPmU3XgJnjw4Owov8LNwLiiOZw@mail.gmail.com>
In-Reply-To: <CA+9S74g5fR=hBxWk1U2TyvW1uPmU3XgJnjw4Owov8LNwLiiOZw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:30:50 +0800
Message-ID: <CACGkMEt4MbyDgdqDGUqQ+0gV-1kmp6CWASDgwMpZnRU8dfPd2Q@mail.gmail.com>
Subject: Re: REGRESSION: RIP: 0010:skb_release_data+0xb8/0x1e0 in vhost/tun
To: Igor Raits <igor@gooddata.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Stefano Garzarella <sgarzare@redhat.com>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:44=E2=80=AFPM Igor Raits <igor@gooddata.com> wrot=
e:
>
> Hello Jason & others,
>
> On Wed, Mar 20, 2024 at 10:33=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Mar 19, 2024 at 9:15=E2=80=AFPM Igor Raits <igor@gooddata.com> =
wrote:
> > >
> > > Hello Stefan,
> > >
> > > On Tue, Mar 19, 2024 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha@red=
hat.com> wrote:
> > > >
> > > > On Tue, Mar 19, 2024 at 10:00:08AM +0100, Igor Raits wrote:
> > > > > Hello,
> > > > >
> > > > > We have started to observe kernel crashes on 6.7.y kernels (atm w=
e
> > > > > have hit the issue 5 times on 6.7.5 and 6.7.10). On 6.6.9 where w=
e
> > > > > have nodes of cluster it looks stable. Please see stacktrace belo=
w. If
> > > > > you need more information please let me know.
> > > > >
> > > > > We do not have a consistent reproducer but when we put some bigge=
r
> > > > > network load on a VM, the hypervisor's kernel crashes.
> > > > >
> > > > > Help is much appreciated! We are happy to test any patches.
> > > >
> > > > CCing Michael Tsirkin and Jason Wang for vhost_net.
> > > >
> > > > >
> > > > > [62254.167584] stack segment: 0000 [#1] PREEMPT SMP NOPTI
> > > > > [62254.173450] CPU: 63 PID: 11939 Comm: vhost-11890 Tainted: G
> > > > >    E      6.7.10-1.gdc.el9.x86_64 #1
> > > >
> > > > Are there any patches in this kernel?
> > >
> > > Only one, unrelated to this part. Removal of pr_err("EEVDF scheduling
> > > fail, picking leftmost\n"); line (reported somewhere few months ago
> > > and it was suggested workaround until proper solution comes).
> >
> > Btw, a bisection would help as well.
>
> In the end it seems like we don't really have "stable" setup, so
> bisection looks to be useless but we did find few things meantime:
>
> 1. On 6.6.9 it crashes either with unexpected GSO type or usercopy:
> Kernel memory exposure attempt detected from SLUB object
> 'skbuff_head_cache'

Do you have a full calltrace for this?

> 2. On 6.7.5, 6.7.10 and 6.8.1 it crashes with RIP:
> 0010:skb_release_data+0xb8/0x1e0

And for this?

> 3. It does NOT crash on 6.8.1 when VM does not have multi-queue setup
>
> Looks like the multi-queue setup (we have 2 interfaces =C3=97 3 virtio
> queues for each) is causing problems as if we set only one queue for
> each interface the issue is gone.
> Maybe there is some race condition in __pfx_vhost_task_fn+0x10/0x10 or
> somewhere around?

I can't tell now, but it seems not because if we have 3 queue pairs we
will have 3 vhost threads.

> We have noticed that there are 3 of such functions
> in the stacktrace that gave us hints about what we could try=E2=80=A6

Let's try to enable SLUB_DEBUG and KASAN to see if we can get
something interesting.

Thanks

>
> >
> > Thanks
> >
>
> Thank you!
>

