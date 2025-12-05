Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118BE155C97
	for <virtualization@lists.linux.dev>; Fri,  5 Dec 2025 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764898333; cv=none; b=OjyqZhUF7Q7BUPWqoFH2hR4xbuIRaqI9sXpVJD9KaT1uqohwzdWONC4dW+OGbKxtFiLijH99q1uv2DIMN7GT8V8ZdkoYaIJe2dNL5H0RGhx5wyPIeXktc147JFtjxSy+2TJlr0XB8n9GKEDezf+dLNjLh/+QEgiSsyiGI+OZiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764898333; c=relaxed/simple;
	bh=b3Ez8+yWMkGA5gpAkQt7RdpyK0iRnQzdGVgQTEK2Zmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4QlIQIwWxiIxfq/L+TpmFqO7ePpevfYnJ1glnrkNpRJYyjFe08xfdsICtYKQsbyWyVbt9+X2nEpp4z0zxo2BCYrzZM/LMspCdlQgL5aOOvFLjUilR5InpAE92Y0oxv04aRcQI22ahY9GdNff+QJvyaQ/iWcIQTT9fvXQIjP+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXbHxIwB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXbHxIwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764898330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dsq8oFQa/VCPAZZwGy/bUQxA/2aYZc+HS65+giLRpM=;
	b=VXbHxIwBqp8RD8SIsXJG9oPQoMJs365uogzwSRXQVCZH3EVopYLAEZw/h4+p6dV8sNSZVm
	pOwS/2d4LR61iyAosXRE+MPOedtaGb6MCxNtPqknr/VuMWvbAk5N+6pLotlBMBSV56uoUO
	pHH2uIAS5xSSjS8vnVHXyBe3hqHDRNU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-F97Zf6WJPgCmNm4sWLzqrA-1; Thu, 04 Dec 2025 20:32:08 -0500
X-MC-Unique: F97Zf6WJPgCmNm4sWLzqrA-1
X-Mimecast-MFC-AGG-ID: F97Zf6WJPgCmNm4sWLzqrA_1764898327
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3416dc5752aso3943688a91.1
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 17:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764898327; x=1765503127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0dsq8oFQa/VCPAZZwGy/bUQxA/2aYZc+HS65+giLRpM=;
        b=qSc0f30XTUV9jSayXnJRlH1chr/Ai7HVb1tiC/olSgF/kPWf0khN+/sh+yp/7G30mb
         2YsyKus0UVRXCpDZxPQn1hbtf6mTKqS+XtbjsDdIZBx56bapKr1II/TOq0szBQAtmWMY
         utayevPVSe8RWeZANytQZGQ1ryDaQuWVjInWR3Ra8OBZ4vz89ciE4RKqHcQ0zNnftFUW
         5f5eMuGokdnRgTFkVhu7t0F65EnqF8lkSq5rbmrxR1O1Iiq6SunaYvcitF8mxyE/aXq0
         bx8gK5Hmu2w+tnmHggC+Lul4bTHPzUy3/8PoofudI6Aw6aAhegktT870iMav5wb12Asb
         j29A==
X-Forwarded-Encrypted: i=1; AJvYcCUgT///TAePa/lqZbTV7OVhIKnWh7UWZlz8jEUgXbUvQE4W7uPnT/u2E/TBllk/pbHCJHxGg6uZmHWuzSJGrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YywUGWHLJLS5yVjgRTsg/KQDBIeRFEMjwGHm4fSDzQ01A4RxFbR
	EC36FyUBXfo/zpzS+Z1+Ql/HWdZUnRDUGkmCGli6ktvBfLiev4TobsYw7I11uS+U34xurNSi9hQ
	mHZcBHgBKDPkcTunK4Q4dn7Q2IggsQmg6EgX32uM2irwBagBp9qCk+zaX+clHjxL9jZZW91O4mI
	t9corwNLHP0iWZUJ3fgYSMSj/7fjGBXHbhcVFCQhpMXAg=
X-Gm-Gg: ASbGncucSi7VuxLIvcR8MD609uHngcpW25tzPFuPEe2frTzLvMUJqk5patXHYPs0ybL
	nVqfp3l27aCmxB6OvPCBW+DBLiPhvMf0vwW1HkZQ8ZJKf0KNARnFQnKCVvphzYbmXa50reZofno
	X3HVnMRj5RDCln38mHvIxkwOya53D462DEFyuwInAwL1tK7FIYfYS9jDFPsVZjx2fEcA==
X-Received: by 2002:a17:90b:2784:b0:340:dd2c:a3f5 with SMTP id 98e67ed59e1d1-34947b5ffbfmr5314766a91.3.1764898327392;
        Thu, 04 Dec 2025 17:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZVUUVrZNrU9zy5VVS63ijjPseuKARttg+oAzFaelLxvIi3gh6iAM+h+okddgsxpg98PrIp9rap3jAvrqXnNY=
X-Received: by 2002:a17:90b:2784:b0:340:dd2c:a3f5 with SMTP id
 98e67ed59e1d1-34947b5ffbfmr5314736a91.3.1764898326948; Thu, 04 Dec 2025
 17:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com> <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
 <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com> <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
 <faad67c7-8b25-4516-ab37-3b154ee4d0cf@gmail.com> <CACGkMEtpARauj6GSZu+iY3Lx=c+rq_C019r4E-eisx2mujB6=A@mail.gmail.com>
 <eabd665c-b14d-4281-9307-2348791d3a77@gmail.com>
In-Reply-To: <eabd665c-b14d-4281-9307-2348791d3a77@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Dec 2025 09:31:55 +0800
X-Gm-Features: AWmQ_blh1owa4VZkxcTchqi8uqZ8bw7WQqwN7uDSrgQCemeKCLZrFSD0qqwYA5A
Message-ID: <CACGkMEtJ-jErjFQgBcEPVeUo4rHejTZ0cuCCVzHSjzk8S80W5A@mail.gmail.com>
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bn3cDEoOc7FcmyjTD4SuTwpCJDP85Ug_uZLEaTExt6w_1764898327
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 11:08=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 12/3/25 13:37, Jason Wang wrote:
> > On Tue, Dec 2, 2025 at 11:29=E2=80=AFPM Bui Quang Minh <minhquangbui99@=
gmail.com> wrote:
> >> On 12/2/25 13:03, Jason Wang wrote:
> >>> On Mon, Dec 1, 2025 at 11:04=E2=80=AFPM Bui Quang Minh <minhquangbui9=
9@gmail.com> wrote:
> >>>> On 11/28/25 09:20, Jason Wang wrote:
> >>>>> On Fri, Nov 28, 2025 at 1:47=E2=80=AFAM Bui Quang Minh <minhquangbu=
i99@gmail.com> wrote:
> >>>>>> I think the the requeue in refill_work is not the problem here. In
> >>>>>> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe =
to
> >>>>>> use "even if the work re-queues itself". AFAICS, cancel_work_sync(=
)
> >>>>>> will disable work -> flush work -> enable again. So if the work re=
queue
> >>>>>> itself in flush work, the requeue will fail because the work is al=
ready
> >>>>>> disabled.
> >>>>> Right.
> >>>>>
> >>>>>> I think what triggers the deadlock here is a bug in
> >>>>>> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
> >>>>>> __virtnet_rx_resume() which calls napi_enable() and may schedule
> >>>>>> refill. It schedules the refill work right after napi_enable the f=
irst
> >>>>>> receive queue. The correct way must be napi_enable all receive que=
ues
> >>>>>> before scheduling refill work.
> >>>>> So what you meant is that the napi_disable() is called for a queue
> >>>>> whose NAPI has been disabled?
> >>>>>
> >>>>> cpu0] enable_delayed_refill()
> >>>>> cpu0] napi_enable(queue0)
> >>>>> cpu0] schedule_delayed_work(&vi->refill)
> >>>>> cpu1] napi_disable(queue0)
> >>>>> cpu1] napi_enable(queue0)
> >>>>> cpu1] napi_disable(queue1)
> >>>>>
> >>>>> In this case cpu1 waits forever while holding the netdev lock. This
> >>>>> looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
> >>>>> NAPI enablement with netdev_lock()")?
> >>>> Yes, I've tried to fix it in 4bc12818b363 ("virtio-net: disable dela=
yed
> >>>> refill when pausing rx"), but it has flaws.
> >>> I wonder if a simplified version is just restoring the behaviour
> >>> before 413f0271f3966 by using napi_enable_locked() but maybe I miss
> >>> something.
> >> As far as I understand, before 413f0271f3966 ("net: protect NAPI
> >> enablement with netdev_lock()"), the napi is protected by the
> > I guess you meant napi enable/disable actually.
> >
> >> rtnl_lock(). But in the refill_work, we don't acquire the rtnl_lock(),
> > Any reason we need to hold rtnl_lock() there?
>
> Correct me if I'm wrong here. Before 413f0271f3966 ("net: protect NAPI
> enablement with netdev_lock()"), napi_disable and napi_enable are not
> safe to be called concurrently.
>
> The example race is
>
> napi_disable -> napi_save_config -> write to n->config->defer_hard_irqs
> napi_enable -> napi_restore_config -> read n->config->defer_hard_irqs
>
> In refill_work, we don't hold any locks so the race scenario can happen.

Ok, I get you, so it occurs after we introduced the NAPI config to virtio-n=
et.

>
> Maybe I misunderstand what you mean by restoring the behavior before
> 413f0271f3966. Do you mean that we use this pattern
>
>      In virtnet_xdp_se;
>
>      netdev_lock(dev);
>      virtnet_rx_pause_all()
>          -> napi_disable_locked
>
>      virtnet_rx_resume_all()
>          -> napi_disable_locked
>      netdev_unlock(dev);
>
> And in other places where we pause the rx too. It will hold the
> netdev_lock during the time napi is disabled so that even when
> refill_work happens concurrently, napi_disable cannot acquire the
> netdev_lock and gets stuck inside.

It might work but I think it would be easy to either

1) use locked version everywhere

or

2) use the unlocked version everywhere

Mix using locked and unlocked may cause the code hard to be maintained

Thanks

>
>
> >
> >> so it seems like we will have race condition before 413f0271f3966 ("ne=
t:
> >> protect NAPI enablement with netdev_lock()").
> >>
> >> Thanks,
> >> Quang Minh.
> >>
> > Thanks
> >
>
> Thanks,
> Quang Minh.
>

