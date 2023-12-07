Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338310A1C
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 05:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSx/U2ZD"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D8B942089
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 05:32:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D8B942089
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MSx/U2ZD
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kDAvM_WIEIpl
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 05:32:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0F71E42086
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 05:32:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F71E42086
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701927134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8AKubdH5eUqbZp9S/sQ4T9pKm0YRUiJhSDS/SdPqZY=;
	b=MSx/U2ZDQ9UsEageB+5ioVH4cDyhFWck2fIU/A1k9XGyBcYrxeZp5kG/Q9booWdUAEpF13
	URmJyh2HI+D6w60jPuyKAcw697E4m4u8qRfIm00Jg/lkRJQtdMYpDm9Sfata4n/0wvs323
	BJdEianGvneavSMirCMDly+L2L8EIis=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-yc-N7F-dNFGnl_fzR3WijQ-1; Thu, 07 Dec 2023 00:32:13 -0500
X-MC-Unique: yc-N7F-dNFGnl_fzR3WijQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28867e91e37so572013a91.1
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Dec 2023 21:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927132; x=1702531932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8AKubdH5eUqbZp9S/sQ4T9pKm0YRUiJhSDS/SdPqZY=;
        b=vi8oPZmj6BmfA+7CwnHbGRGF08uLj6rjooBh3EtogcQel0H5BRW7rbSgF2G8mRRd1Q
         vuLDZ2XYQqmW0btWvGHr1ZRN787EYD09nrnmAQsDSPC2mJ9EEBdnp1KbMdxqcHp7hZto
         rqtonnkBGcb1Ue2mOwWVlexmD3wyaUO1f6RXC94MnRuFT/xxDhB/GCINN2JDIvryN+hs
         cRdJ+3huDIJvWJaADWhoQ2uIvGjPUTh2WOgmN6LbJQinl/5PVT47+odkvVsJP3gpFOgg
         PrWZcpvYtYyUp82u9GS08Q1pcp+wnIC9sgryHhFqL4/pDXO9jrIb9T6ECjZRJSUxntgU
         vLjg==
X-Gm-Message-State: AOJu0Yyalil9meQds0awTTSKF9qaHD7HwPgL91XPQJVMWNIOI3JTFnQJ
	V1ImnibYTbJEx5q8bG+bG18Fvvr3msn/++jEoLU74Hldn1AxdBYXxalDPnDsBAsRu71uH6gyyIn
	RzYVonTx8LS2awxH5hKRc7bbMaBGhQOvjCwarLWeTmT0te/k60MBpOiIzJA==
X-Received: by 2002:a17:90b:8c4:b0:286:6cc1:866b with SMTP id ds4-20020a17090b08c400b002866cc1866bmr1735474pjb.80.1701927131690;
        Wed, 06 Dec 2023 21:32:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6XoZVQHN0I8TmPCeCnxuhZW9K7ObTTorIlWlVOqvXJihMRJ//c3mDTg0rJap6u3bSTnnCHjKkz4KP+tc+Vbk=
X-Received: by 2002:a17:90b:8c4:b0:286:6cc1:866b with SMTP id
 ds4-20020a17090b08c400b002866cc1866bmr1735458pjb.80.1701927131367; Wed, 06
 Dec 2023 21:32:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1701762688.git.hengqi@linux.alibaba.com>
 <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
 <CACGkMEurTAGj+mSEtAiYtGfqy=6sU33xVskAZH47qUi+GcyvWA@mail.gmail.com>
 <ad02f02a-b08f-4061-9aba-cadef02641c8@linux.alibaba.com> <f36e686e13142d885a6e34f0a4dc2e33567ef287.camel@redhat.com>
 <fbea1040-cf84-45e0-b0f5-1d7752339479@linux.alibaba.com> <CACGkMEuU18fn8oC=DPNP3Dk=uE0Rutwib7jkoXEZXV+H4H6VcA@mail.gmail.com>
 <d2cc8026-eaa8-46d2-ac61-9d228bc409cf@linux.alibaba.com>
In-Reply-To: <d2cc8026-eaa8-46d2-ac61-9d228bc409cf@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2023 13:31:59 +0800
Message-ID: <CACGkMEvzhF0yQb5sb22+sh=p1tyNfA5sOuvyj8jjAxthLaxrAw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/5] virtio-net: add spin lock for ctrl cmd access
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, mst@redhat.com, kuba@kernel.org, 
	yinjun.zhang@corigine.com, edumazet@google.com, davem@davemloft.net, 
	hawk@kernel.org, john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org, 
	xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 12:47=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2023/12/7 =E4=B8=8B=E5=8D=8812:19, Jason Wang =E5=86=99=E9=81=
=93:
> > On Wed, Dec 6, 2023 at 9:03=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.co=
m> wrote:
> >>
> >>
> >> =E5=9C=A8 2023/12/6 =E4=B8=8B=E5=8D=888:27, Paolo Abeni =E5=86=99=E9=
=81=93:
> >>> On Tue, 2023-12-05 at 19:05 +0800, Heng Qi wrote:
> >>>> =E5=9C=A8 2023/12/5 =E4=B8=8B=E5=8D=884:35, Jason Wang =E5=86=99=E9=
=81=93:
> >>>>> On Tue, Dec 5, 2023 at 4:02=E2=80=AFPM Heng Qi <hengqi@linux.alibab=
a.com> wrote:
> >>>>>> Currently access to ctrl cmd is globally protected via rtnl_lock a=
nd works
> >>>>>> fine. But if dim work's access to ctrl cmd also holds rtnl_lock, d=
eadlock
> >>>>>> may occur due to cancel_work_sync for dim work.
> >>>>> Can you explain why?
> >>>> For example, during the bus unbind operation, the following call sta=
ck
> >>>> occurs:
> >>>> virtnet_remove -> unregister_netdev -> rtnl_lock[1] -> virtnet_close=
 ->
> >>>> cancel_work_sync -> virtnet_rx_dim_work -> rtnl_lock[2] (deadlock oc=
curs).
> >>>>
> >>>>>> Therefore, treating
> >>>>>> ctrl cmd as a separate protection object of the lock is the soluti=
on and
> >>>>>> the basis for the next patch.
> >>>>> Let's don't do that. Reasons are:
> >>>>>
> >>>>> 1) virtnet_send_command() may wait for cvq commands for an indefini=
te time
> >>>> Yes, I took that into consideration. But ndo_set_rx_mode's need for =
an
> >>>> atomic
> >>>> environment rules out the mutex lock.
> >>>>
> >>>>> 2) hold locks may complicate the future hardening works around cvq
> >>>> Agree, but I don't seem to have thought of a better way besides pass=
ing
> >>>> the lock.
> >>>> Do you have any other better ideas or suggestions?
> >>> What about:
> >>>
> >>> - using the rtnl lock only
> >>> - virtionet_close() invokes cancel_work(), without flushing the work
> >>> - virtnet_remove() calls flush_work() after unregister_netdev(),
> >>> outside the rtnl lock
> >>>
> >>> Should prevent both the deadlock and the UaF.
> >>
> >> Hi, Paolo and Jason!
> >>
> >> Thank you very much for your effective suggestions, but I found anothe=
r
> >> solution[1],
> >> based on the ideas of rtnl_trylock and refill_work, which works very w=
ell:
> >>
> >> [1]
> >> +static void virtnet_rx_dim_work(struct work_struct *work)
> >> +{
> >> +    struct dim *dim =3D container_of(work, struct dim, work);
> >> +    struct receive_queue *rq =3D container_of(dim,
> >> +            struct receive_queue, dim);
> >> +    struct virtnet_info *vi =3D rq->vq->vdev->priv;
> >> +    struct net_device *dev =3D vi->dev;
> >> +    struct dim_cq_moder update_moder;
> >> +    int i, qnum, err;
> >> +
> >> +    if (!rtnl_trylock())
> >> +        return;
> > Don't we need to reschedule here?
> >
> > like
> >
> > if (rq->dim_enabled)
> >         sechedule_work()
> >
> > ?
>
> I think no, we don't need this.
>
> The work of each queue will be called by "net_dim()->schedule_work()"
> when napi traffic changes (before schedule_work(), the dim->profile_ix
> of the corresponding rxq has been updated).
> So we only need to traverse and update the profiles of all rxqs in the
> work which is obtaining the rtnl_lock.

Ok, let's have a comment here then.

Thanks

>
> Thanks!
>
> >
> > Thanks
> >
> >> +
> >> +    for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> >> +        rq =3D &vi->rq[i];
> >> +        dim =3D &rq->dim;
> >> +        qnum =3D rq - vi->rq;
> >> +
> >> +        if (!rq->dim_enabled)
> >> +            continue;
> >> +
> >> +        update_moder =3D net_dim_get_rx_moderation(dim->mode,
> >> dim->profile_ix);
> >> +        if (update_moder.usec !=3D rq->intr_coal.max_usecs ||
> >> +            update_moder.pkts !=3D rq->intr_coal.max_packets) {
> >> +            err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> >> +                                   update_moder.usec,
> >> +                                   update_moder.pkts);
> >> +            if (err)
> >> +                pr_debug("%s: Failed to send dim parameters on rxq%d\=
n",
> >> +                     dev->name, qnum);
> >> +            dim->state =3D DIM_START_MEASURE;
> >> +        }
> >> +    }
> >> +
> >> +    rtnl_unlock();
> >> +}
> >>
> >>
> >> In addition, other optimizations[2] have been tried, but it may be due
> >> to the sparsely
> >> scheduled work that the retry condition is always satisfied, affecting
> >> performance,
> >> so [1] is the final solution:
> >>
> >> [2]
> >>
> >> +static void virtnet_rx_dim_work(struct work_struct *work)
> >> +{
> >> +    struct dim *dim =3D container_of(work, struct dim, work);
> >> +    struct receive_queue *rq =3D container_of(dim,
> >> +            struct receive_queue, dim);
> >> +    struct virtnet_info *vi =3D rq->vq->vdev->priv;
> >> +    struct net_device *dev =3D vi->dev;
> >> +    struct dim_cq_moder update_moder;
> >> +    int i, qnum, err, count;
> >> +
> >> +    if (!rtnl_trylock())
> >> +        return;
> >> +retry:
> >> +    count =3D vi->curr_queue_pairs;
> >> +    for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> >> +        rq =3D &vi->rq[i];
> >> +        dim =3D &rq->dim;
> >> +        qnum =3D rq - vi->rq;
> >> +        update_moder =3D net_dim_get_rx_moderation(dim->mode,
> >> dim->profile_ix);
> >> +        if (update_moder.usec !=3D rq->intr_coal.max_usecs ||
> >> +            update_moder.pkts !=3D rq->intr_coal.max_packets) {
> >> +            --count;
> >> +            err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> >> +                                   update_moder.usec,
> >> +                                   update_moder.pkts);
> >> +            if (err)
> >> +                pr_debug("%s: Failed to send dim parameters on rxq%d\=
n",
> >> +                     dev->name, qnum);
> >> +            dim->state =3D DIM_START_MEASURE;
> >> +        }
> >> +    }
> >> +
> >> +    if (need_resched()) {
> >> +        rtnl_unlock();
> >> +        schedule();
> >> +    }
> >> +
> >> +    if (count)
> >> +        goto retry;
> >> +
> >> +    rtnl_unlock();
> >> +}
> >>
> >> Thanks a lot!
> >>
> >>> Side note: for this specific case any functional test with a
> >>> CONFIG_LOCKDEP enabled build should suffice to catch the deadlock
> >>> scenario above.
> >>>
> >>> Cheers,
> >>>
> >>> Paolo
>

