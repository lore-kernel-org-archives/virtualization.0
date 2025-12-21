Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E312868B4
	for <virtualization@lists.linux.dev>; Sun, 21 Dec 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766324584; cv=none; b=aRHp5ICk/nsy3TAZkKOxzqg3GiOzlfY9AvepmW99QqpSMNn024zZJ9K5Ud6DPHGioHvU+Xy7yXzfzzSStQjvpNY/C5t71GPHDa+8rZzUAJUpoGgn0FlyZPPcxWX4zk+tCnK28zCDTMnexuRtDsT/3I+UsZzavkzyVUMtG4cJhX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766324584; c=relaxed/simple;
	bh=g1OpVRc/favQfUiIRE8TO5sJVwwB3PHfeg+/jvw5UK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bs+LJ9k48ms7v/FIEYpcFpx7nSiCw1oiL/pxGrOI/5Of1Z0/ki6H+tre2F3WgaLYCqamN3SHDD1nXsrVSX5uiiJG6Eh9fjtT2ckef1z9w1RSbTn8JAcZuBT+RhGrnatVQw6gZthFh+Jj1JEgCQSA65Ib2YmpOyzpi3A6C5QyLlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMEwYFpD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMEwYFpD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766324581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LL1YiW+qcmDAfO6Y9bCrMUIb9gMq0TIVlGP94jNrCWo=;
	b=LMEwYFpDEgczKs2h4v4VhjFPOLrfI7459lbdlOepINMuBqs7l9bTkCaA6Tvv1M0D/oOVfr
	s3KJWsAryWde07/Z0TPbjtMZ4OEH1jpAmj3r2zpQvcCJDDq5lO5D+drbZgFt042ujYFHon
	A6tgE02odaYPKVD7igvWJzT6FjsFsck=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-eEf-PaB3M0Scl0hKtBeFSg-1; Sun, 21 Dec 2025 08:42:57 -0500
X-MC-Unique: eEf-PaB3M0Scl0hKtBeFSg-1
X-Mimecast-MFC-AGG-ID: eEf-PaB3M0Scl0hKtBeFSg_1766324576
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477c49f273fso42108735e9.3
        for <virtualization@lists.linux.dev>; Sun, 21 Dec 2025 05:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766324576; x=1766929376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LL1YiW+qcmDAfO6Y9bCrMUIb9gMq0TIVlGP94jNrCWo=;
        b=U/lE+XeRA6XHoOVi+9tEoJcPZsyqRaujdFq4iSzE6ShXavkOOLJ2GjdirLlk6OI728
         JWEzLASCANQfo1qc/HlpWG19X2SDGfP8qnbQjgObu3m47Xo8DfiTnH6eaHksICdk9RYL
         oMGGPdniRW49uuh4ecPopVWFkgMC12obsSYuuUsMrqR4tZQv/eumnpO/G9frRGWR/cUM
         xPwxSdyW9FmbhExm5g9CxKmouAhxnntrsQGfyWCcVO2rVlF7Q8JHXcp15EKXxfjAsjH5
         OoIjhvbbBTcMlINg5cwKQX8qb4Kk2t8dTUJ1pZzWHr6BMqkw/k7Cx11tqhOwsIWUD5qY
         Kflw==
X-Forwarded-Encrypted: i=1; AJvYcCWW9frzkd74KvwpBm81tyCP73V5p1Y8SRv1CWFz33vT+gt6cIhPZAFYyel3RwYSLUej1yFc+zeittg+ZGmoZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyM2LAVd4sbixOaZL8CMiKJex4mysHuUqeecCmHOZqL/nltVOnc
	TuSMUFAVqQAym/8xSDmN73ByrlbMLDSRIyHfOKHdSj8MKBNVRKaDxzqq5nSqALZIYM+NGbNd7js
	I56tIxF3J5OvLg1iHN5AuZyYDS7orF2qyZjPyb4L/tlihQdEDhN3eGH3pw7oSStTrW0kD
X-Gm-Gg: AY/fxX7Rn4rDRwIStSRjC2/xfGGawOV9byPbcGOqVNQPUMtgMF/3QwXppejx1R4h3tE
	61RKYA6Ke9871ewbfJTDro3WkGqiDWIzqSzU16wC3jHgW0MGSOp5ocywC0b3smlQQFSBTKL9fvm
	b1DrT+4CNNuXtYxCgSfsh/YZ7uFm+UoXmOIUeT23Dkm3146WMNgQC6ZKOVvwRqqeCAJ8dlWMfUL
	DFziXzW/bcab6lvdVnFE7Hl6YDev7qN1pblsDaggNaHiNZDqinFE9dYyfKUeyhpeapi1bZL0H3s
	4ZS8OQVotlk+7GhH1VnkMD8fDAM5th1ZR8P/ml5PjEwF7UylsHDengs6AAan5fd4jxvW76gcKSA
	IajtFf29yK6eHIoRQbT0f3tlPrObGMVS1uw==
X-Received: by 2002:a05:600c:198d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-47d195a06a0mr78888855e9.27.1766324575726;
        Sun, 21 Dec 2025 05:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGndUGZlLP7dF9QsIdTkQlYcFSwsza8K4tRMm6Y1+UEUb2YQun2bVAVDpswkOGEHQO9izRXxw==
X-Received: by 2002:a05:600c:198d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-47d195a06a0mr78888685e9.27.1766324575102;
        Sun, 21 Dec 2025 05:42:55 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193621c8sm139563755e9.7.2025.12.21.05.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 05:42:54 -0800 (PST)
Date: Sun, 21 Dec 2025 08:42:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] virtio-net: enable all napis before scheduling
 refill work
Message-ID: <20251221084218-mutt-send-email-mst@kernel.org>
References: <20251212152741.11656-1-minhquangbui99@gmail.com>
 <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
 <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
 <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
 <5434a67e-dd6e-4cd1-870b-fdd32ad34a28@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5434a67e-dd6e-4cd1-870b-fdd32ad34a28@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pKuN-SagtncPEwxubv7ABfHA0cHcPPROSxDqHOPOo9Y_1766324576
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 19, 2025 at 12:03:29PM +0700, Bui Quang Minh wrote:
> On 12/17/25 09:58, Jason Wang wrote:
> > On Wed, Dec 17, 2025 at 12:23 AM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> > > On 12/16/25 11:16, Jason Wang wrote:
> > > > On Fri, Dec 12, 2025 at 11:28 PM Bui Quang Minh
> > > > <minhquangbui99@gmail.com> wrote:
> > > > > Calling napi_disable() on an already disabled napi can cause the
> > > > > deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> > > > > when pausing rx"), to avoid the deadlock, when pausing the RX in
> > > > > virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> > > > > However, in the virtnet_rx_resume_all(), we enable the delayed refill
> > > > > work too early before enabling all the receive queue napis.
> > > > > 
> > > > > The deadlock can be reproduced by running
> > > > > selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> > > > > device and inserting a cond_resched() inside the for loop in
> > > > > virtnet_rx_resume_all() to increase the success rate. Because the worker
> > > > > processing the delayed refilled work runs on the same CPU as
> > > > > virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> > > > > In real scenario, the contention on netdev_lock can cause the
> > > > > reschedule.
> > > > > 
> > > > > This fixes the deadlock by ensuring all receive queue's napis are
> > > > > enabled before we enable the delayed refill work in
> > > > > virtnet_rx_resume_all() and virtnet_open().
> > > > > 
> > > > > Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> > > > > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > > > > Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Move try_fill_recv() before rx napi_enable()
> > > > > - Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-minhquangbui99@gmail.com/
> > > > > ---
> > > > >    drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++---------------
> > > > >    1 file changed, 45 insertions(+), 26 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 8e04adb57f52..4e08880a9467 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct virtnet_info *vi)
> > > > >    static int virtnet_open(struct net_device *dev)
> > > > >    {
> > > > >           struct virtnet_info *vi = netdev_priv(dev);
> > > > > +       bool schedule_refill = false;
> > > > >           int i, err;
> > > > > 
> > > > > -       enable_delayed_refill(vi);
> > > > > -
> > > > > +       /* - We must call try_fill_recv before enabling napi of the same receive
> > > > > +        * queue so that it doesn't race with the call in virtnet_receive.
> > > > > +        * - We must enable and schedule delayed refill work only when we have
> > > > > +        * enabled all the receive queue's napi. Otherwise, in refill_work, we
> > > > > +        * have a deadlock when calling napi_disable on an already disabled
> > > > > +        * napi.
> > > > > +        */
> > > > >           for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > >                   if (i < vi->curr_queue_pairs)
> > > > >                           /* Make sure we have some buffers: if oom use wq. */
> > > > >                           if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > > > > -                               schedule_delayed_work(&vi->refill, 0);
> > > > > +                               schedule_refill = true;
> > > > > 
> > > > >                   err = virtnet_enable_queue_pair(vi, i);
> > > > >                   if (err < 0)
> > > > >                           goto err_enable_qp;
> > > > >           }
> > > > So NAPI could be scheduled and it may want to refill but since refill
> > > > is not enabled, there would be no refill work.
> > > > 
> > > > Is this a problem?
> > > You are right. It is indeed a problem.
> > > 
> > > I think we can unconditionally schedule the delayed refill after
> > > enabling all the RX NAPIs (don't check the boolean schedule_refill
> > > anymore) to ensure that we will have refill work. We can still keep the
> > > try_fill_recv here to fill the receive buffer earlier in normal case.
> > > What do you think?
> > Or we can have a reill_pending
> 
> Okay, let me implement this in the next version.
> 
> > but basically I think we need something
> > that is much more simple. That is, using a per rq work instead of a
> > global one?
> 
> I think we can leave this in a net-next patch later.
> 
> Thanks,
> Quang Minh

i am not sure per rq is not simpler than this pile of tricks.


> > 
> > Thanks
> > 
> > > > 
> > > > > +       enable_delayed_refill(vi);
> > > > > +       if (schedule_refill)
> > > > > +               schedule_delayed_work(&vi->refill, 0);
> > > > > +
> > > > >           if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > >                   if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > >                           netif_carrier_on(vi->dev);
> > > > > @@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> > > > >           __virtnet_rx_pause(vi, rq);
> > > > >    }
> > > > > 
> > > > Thanks
> > > > 
> > > Thanks,
> > > Quang Minh.
> > > 

