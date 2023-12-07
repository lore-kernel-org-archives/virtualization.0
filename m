Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEA101EA
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 04:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGC21cXK"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DA1C61591
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 04:19:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DA1C61591
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jGC21cXK
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q0eIsPiWO8DG
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 04:19:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5273A6157D
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 04:19:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5273A6157D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701922756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2Os4RiTW3HusUmNhl4rW9yhlsI81Z+VuhLDA4VXj5w=;
	b=jGC21cXKrS3SSiDAkgqWZZR4mZJn16jbL4/aB01+Uu0WCbXkKWUPGUmSNdr9Go/DXf+Q74
	XZdV52Snl9rbRdKaSQ7WvFT+/I8cyJInh4mmkj2FMf5vHqHwT+82K3tzRJ2qnbd08NhclD
	2oNrascHjs/nArX1YRGIMQ8J0D4kIOo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-3Dpe8aXkOICJgQUHYbFyIg-1; Wed, 06 Dec 2023 23:19:12 -0500
X-MC-Unique: 3Dpe8aXkOICJgQUHYbFyIg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2865681dcb4so528603a91.3
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Dec 2023 20:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701922752; x=1702527552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2Os4RiTW3HusUmNhl4rW9yhlsI81Z+VuhLDA4VXj5w=;
        b=lx5sCVQSVf2CmEk6yBmdjJR2mvJzWWqXQQQLIGfWevWfNkmCExidm5rmXLk0gueTa+
         CPKPHtbXPS6GZwgk27C2aWjJI7EF6QsWC2VA+fjf7gB9n/XpICLvnpnSjfB2SAkplxyO
         lzv8XLLYDkIijPR4TSq9GyjwPE35xpvFe8XZimQBVv0GfOyOwnnD3LTqKl+i9yQMnqJb
         700KosQ/1NlrPmAwhWGZmxu01CpbNGtEXfxmdRroVVsAuT/t7rA9scGnJK/1Dze5spVC
         LmjWNbECyeGXyhOhSc7aYaKtkUwPs3IqR09ONyVShypnnFWJJkvkrcoye2jhcwjs4hk/
         C53Q==
X-Gm-Message-State: AOJu0YxEPfR3Xe5A2VRSlfgPmmSI0Ii7WQhAynfGX2Ywsg5PZ21ZvsGn
	wFSF21lr+x5Kbr7uRf16i/a3ZQzreapGES8EAZ0xjGemmrApNgI40OmM6Ubo2sOyHV1457RUjfs
	K9kxt6/JKvVjLQ+xugCaFd9Bvz+LKI7P587ZQzMsic2gjgUoOGQAhs6Pe0w==
X-Received: by 2002:a17:90b:895:b0:286:6cc1:865e with SMTP id bj21-20020a17090b089500b002866cc1865emr1654613pjb.67.1701922751891;
        Wed, 06 Dec 2023 20:19:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3pk+HUp4Id3qg0tpVfmBQO/RuW4OlinrD1v+8yiUHFe2WVcEyWRpns4urw4PQr4DxY92hUPFTNHSsK3cAdFE=
X-Received: by 2002:a17:90b:895:b0:286:6cc1:865e with SMTP id
 bj21-20020a17090b089500b002866cc1865emr1654597pjb.67.1701922751565; Wed, 06
 Dec 2023 20:19:11 -0800 (PST)
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
 <fbea1040-cf84-45e0-b0f5-1d7752339479@linux.alibaba.com>
In-Reply-To: <fbea1040-cf84-45e0-b0f5-1d7752339479@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2023 12:19:00 +0800
Message-ID: <CACGkMEuU18fn8oC=DPNP3Dk=uE0Rutwib7jkoXEZXV+H4H6VcA@mail.gmail.com>
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

On Wed, Dec 6, 2023 at 9:03=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
>
>
> =E5=9C=A8 2023/12/6 =E4=B8=8B=E5=8D=888:27, Paolo Abeni =E5=86=99=E9=81=
=93:
> > On Tue, 2023-12-05 at 19:05 +0800, Heng Qi wrote:
> >> =E5=9C=A8 2023/12/5 =E4=B8=8B=E5=8D=884:35, Jason Wang =E5=86=99=E9=81=
=93:
> >>> On Tue, Dec 5, 2023 at 4:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> >>>> Currently access to ctrl cmd is globally protected via rtnl_lock and=
 works
> >>>> fine. But if dim work's access to ctrl cmd also holds rtnl_lock, dea=
dlock
> >>>> may occur due to cancel_work_sync for dim work.
> >>> Can you explain why?
> >> For example, during the bus unbind operation, the following call stack
> >> occurs:
> >> virtnet_remove -> unregister_netdev -> rtnl_lock[1] -> virtnet_close -=
>
> >> cancel_work_sync -> virtnet_rx_dim_work -> rtnl_lock[2] (deadlock occu=
rs).
> >>
> >>>> Therefore, treating
> >>>> ctrl cmd as a separate protection object of the lock is the solution=
 and
> >>>> the basis for the next patch.
> >>> Let's don't do that. Reasons are:
> >>>
> >>> 1) virtnet_send_command() may wait for cvq commands for an indefinite=
 time
> >> Yes, I took that into consideration. But ndo_set_rx_mode's need for an
> >> atomic
> >> environment rules out the mutex lock.
> >>
> >>> 2) hold locks may complicate the future hardening works around cvq
> >> Agree, but I don't seem to have thought of a better way besides passin=
g
> >> the lock.
> >> Do you have any other better ideas or suggestions?
> > What about:
> >
> > - using the rtnl lock only
> > - virtionet_close() invokes cancel_work(), without flushing the work
> > - virtnet_remove() calls flush_work() after unregister_netdev(),
> > outside the rtnl lock
> >
> > Should prevent both the deadlock and the UaF.
>
>
> Hi, Paolo and Jason!
>
> Thank you very much for your effective suggestions, but I found another
> solution[1],
> based on the ideas of rtnl_trylock and refill_work, which works very well=
:
>
> [1]
> +static void virtnet_rx_dim_work(struct work_struct *work)
> +{
> +    struct dim *dim =3D container_of(work, struct dim, work);
> +    struct receive_queue *rq =3D container_of(dim,
> +            struct receive_queue, dim);
> +    struct virtnet_info *vi =3D rq->vq->vdev->priv;
> +    struct net_device *dev =3D vi->dev;
> +    struct dim_cq_moder update_moder;
> +    int i, qnum, err;
> +
> +    if (!rtnl_trylock())
> +        return;

Don't we need to reschedule here?

like

if (rq->dim_enabled)
       sechedule_work()

?

Thanks

> +
> +    for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> +        rq =3D &vi->rq[i];
> +        dim =3D &rq->dim;
> +        qnum =3D rq - vi->rq;
> +
> +        if (!rq->dim_enabled)
> +            continue;
> +
> +        update_moder =3D net_dim_get_rx_moderation(dim->mode,
> dim->profile_ix);
> +        if (update_moder.usec !=3D rq->intr_coal.max_usecs ||
> +            update_moder.pkts !=3D rq->intr_coal.max_packets) {
> +            err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> +                                   update_moder.usec,
> +                                   update_moder.pkts);
> +            if (err)
> +                pr_debug("%s: Failed to send dim parameters on rxq%d\n",
> +                     dev->name, qnum);
> +            dim->state =3D DIM_START_MEASURE;
> +        }
> +    }
> +
> +    rtnl_unlock();
> +}
>
>
> In addition, other optimizations[2] have been tried, but it may be due
> to the sparsely
> scheduled work that the retry condition is always satisfied, affecting
> performance,
> so [1] is the final solution:
>
> [2]
>
> +static void virtnet_rx_dim_work(struct work_struct *work)
> +{
> +    struct dim *dim =3D container_of(work, struct dim, work);
> +    struct receive_queue *rq =3D container_of(dim,
> +            struct receive_queue, dim);
> +    struct virtnet_info *vi =3D rq->vq->vdev->priv;
> +    struct net_device *dev =3D vi->dev;
> +    struct dim_cq_moder update_moder;
> +    int i, qnum, err, count;
> +
> +    if (!rtnl_trylock())
> +        return;
> +retry:
> +    count =3D vi->curr_queue_pairs;
> +    for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> +        rq =3D &vi->rq[i];
> +        dim =3D &rq->dim;
> +        qnum =3D rq - vi->rq;
> +        update_moder =3D net_dim_get_rx_moderation(dim->mode,
> dim->profile_ix);
> +        if (update_moder.usec !=3D rq->intr_coal.max_usecs ||
> +            update_moder.pkts !=3D rq->intr_coal.max_packets) {
> +            --count;
> +            err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> +                                   update_moder.usec,
> +                                   update_moder.pkts);
> +            if (err)
> +                pr_debug("%s: Failed to send dim parameters on rxq%d\n",
> +                     dev->name, qnum);
> +            dim->state =3D DIM_START_MEASURE;
> +        }
> +    }
> +
> +    if (need_resched()) {
> +        rtnl_unlock();
> +        schedule();
> +    }
> +
> +    if (count)
> +        goto retry;
> +
> +    rtnl_unlock();
> +}
>
> Thanks a lot!
>
> >
> > Side note: for this specific case any functional test with a
> > CONFIG_LOCKDEP enabled build should suffice to catch the deadlock
> > scenario above.
> >
> > Cheers,
> >
> > Paolo
>

