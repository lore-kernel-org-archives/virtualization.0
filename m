Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79128C864
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006484; cv=none; b=mJmimzWOEx0YkQbDN0/bqZzfwIRXDxaYbMPvJP8JUELByzIw6mhJmO9NELSt+JDbxfsdn+mKjqFjWN52EAT1BR0I9WmNdlIVaPlTvgLCHTHPuGvyOjxWIt4TZuLWk6K2uFXARMckHA9X/vo75qZnGFAyBvj6AFBkNFkGHWiG0Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006484; c=relaxed/simple;
	bh=yQKLpG7rL3c3VSnaKMz320BDbIw/zC1Hrox8B/emiEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=psG+U7HbBaHd/VhrND84zXLCtP6gsNZGxZdCV2kVCDDLAqEXR4OtLSe3aDU0v9gylstNN6Cw08jPzXgjRaDRxAmlZ5DZpW4+zLqjByHRemW5aWf8D38+0Zq7XZZjNSSTRyTY4WbnFINqEyWN4g3Jafjm30KrKrYagkdOVWrTazQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGsWqvTQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGsWqvTQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758006482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHDgI0DNgcZtkaITzjCOU1skgj0FzLZyOLaS/H3q/YM=;
	b=KGsWqvTQfGV3F/ynLysEAnAjdv1ogw1rljOtmTeg4YmLFNDQ1ZLIOArQ+zpRKqz8txqlLO
	m/hor7LRqBYKCnOxQ2wZ/JIInrUTC0m0zi6xkTmXpcahvtE6N697GDAvijJdFPld5+uVpk
	n35kVygI3MtRHPe846aNhTtaLiyOuNA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-5gNxFBItOZmPc2xrWthE9Q-1; Tue, 16 Sep 2025 03:08:01 -0400
X-MC-Unique: 5gNxFBItOZmPc2xrWthE9Q-1
X-Mimecast-MFC-AGG-ID: 5gNxFBItOZmPc2xrWthE9Q_1758006479
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b0438a5f20fso566131666b.3
        for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 00:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758006479; x=1758611279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHDgI0DNgcZtkaITzjCOU1skgj0FzLZyOLaS/H3q/YM=;
        b=KVSsM0eRCj4hYCF4mN+aPWf7T0JKQcVIj8DGWazp6cUVg3KhZvTo9Jy07l1Yszw81m
         +dLYtntw4rnrWzF1vPqs11wHN0ix4erRt3z+K4y57BD9aax8cLKyWySG4J4BUGs1jLeU
         A6AA0ZRtGrPBdSGXj1RKi3H9iZoj0xc+6cuVMAOjyVoeihEgy8OeyXsf+bgli7asxnnR
         qo/y2CQxEITAGUYykMcTTSYsY+nyrgt4AJpWjRtxvsbxXsCwE/hR68fkK7+3lS5JTgol
         dM+n7nDIVRCp/z7EUyKtIpC+Kdu7/mwfv6sCqxHjq2xkAFM4sxUQiBA09FjL1QcQIp8c
         WcaA==
X-Forwarded-Encrypted: i=1; AJvYcCWGswzpDe0Hez4viv4qIjZgpVh8iagOW1mpauPZhDl/QA1z+dUy4i8QKViAYA8/6VqNM0xDJbLNQdq8EYPTew==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhXkeZ4bUyAmN2tAbAaN/PXPjOxRblcdq9ZkYFgzSFeT8lcos/
	Z6BFn7geitVzmCv/vRG1ycm2fFFM+ieiru4gxGiOLFQCORPcL56grKFMSvmQwk0Ts+TVnK5nBbG
	frusQTD8PJQ8EKmpRNY06EEGdB0dBy4zvFC5iRx4ZyQeKFGTiq7ZWd3ZIHhHoQdLF1f77
X-Gm-Gg: ASbGncscCWWnz3thZeuiYzkNGzn38soEVWXoREGF/ZZnQceMwjlyh8XKV0YQsErL+xi
	2swz91Y2OyHQUf4GiXa2gPdq4+e5653Qwxus/9U0uBFtUsg89kct8Ecpaom2Hyrwf5vD63xZcBP
	KPJga+GjoAiQ7iVE8Vq6Okw2XJ4MP9yKkczZfp0G8IHLuLazBt3NNOhPUNXNeFNnzIsiJMBedSC
	mSxPIw6riPsK/sDKYbkPfKETs09Jy51jqvcQliy1Xguzg9Ztttltp2MI6LXTsew/xHiKTCV5Cwa
	3MkuLK1/am207b+Ps6Isl1BVC+CS
X-Received: by 2002:a17:906:478c:b0:b04:2533:e8dd with SMTP id a640c23a62f3a-b07c3a8c7a9mr1512271766b.60.1758006479324;
        Tue, 16 Sep 2025 00:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgIdN7vt4rVLkFQKCbA4fzr7ooEwlspblCquvU3nA4jyYYJdxii6DXBn74W0DSzmPxUER9Fg==
X-Received: by 2002:a17:906:478c:b0:b04:2533:e8dd with SMTP id a640c23a62f3a-b07c3a8c7a9mr1512266566b.60.1758006478595;
        Tue, 16 Sep 2025 00:07:58 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f22b1sm1106591366b.86.2025.09.16.00.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:07:57 -0700 (PDT)
Date: Tue, 16 Sep 2025 03:07:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250916030549-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
 <20250915120210-mutt-send-email-mst@kernel.org>
 <CACGkMEufUAL1tBrfZVMQCEBmBZ=Z+aPqUtP=RzOQhjtG9jn7UA@mail.gmail.com>
 <20250916011733-mutt-send-email-mst@kernel.org>
 <CACGkMEu_p-ouLbEq26vMTJmeGs1hw5JHOk1qLt8mLLPOMLDbaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu_p-ouLbEq26vMTJmeGs1hw5JHOk1qLt8mLLPOMLDbaQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HP4bRDdh5vE5O_gj1pMd7Gq7hR6mirZvdHj5j8YtL4U_1758006479
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Sep 16, 2025 at 02:24:22PM +0800, Jason Wang wrote:
> On Tue, Sep 16, 2025 at 1:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 10:37:35AM +0800, Jason Wang wrote:
> > > On Tue, Sep 16, 2025 at 12:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> > > > > Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> > > > > sendmsg") tries to defer the notification enabling by moving the logic
> > > > > out of the loop after the vhost_tx_batch() when nothing new is
> > > > > spotted. This will bring side effects as the new logic would be reused
> > > > > for several other error conditions.
> > > > >
> > > > > One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> > > > > might return -EAGAIN and exit the loop and see there's still available
> > > > > buffers, so it will queue the tx work again until userspace feed the
> > > > > IOTLB entry correctly. This will slowdown the tx processing and may
> > > > > trigger the TX watchdog in the guest.
> > > > >
> > > > > Fixing this by stick the notificaiton enabling logic inside the loop
> > > > > when nothing new is spotted and flush the batched before.
> > > > >
> > > > > Reported-by: Jon Kohler <jon@nutanix.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  drivers/vhost/net.c | 33 +++++++++++++--------------------
> > > > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > > > index 16e39f3ab956..3611b7537932 100644
> > > > > --- a/drivers/vhost/net.c
> > > > > +++ b/drivers/vhost/net.c
> > > > > @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > >       int err;
> > > > >       int sent_pkts = 0;
> > > > >       bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> > > > > -     bool busyloop_intr;
> > > > >       bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> > > > >
> > > > >       do {
> > > > > -             busyloop_intr = false;
> > > > > +             bool busyloop_intr = false;
> > > > > +
> > > > >               if (nvq->done_idx == VHOST_NET_BATCH)
> > > > >                       vhost_tx_batch(net, nvq, sock, &msg);
> > > > >
> > > > > @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > >                       break;
> > > > >               /* Nothing new?  Wait for eventfd to tell us they refilled. */
> > > > >               if (head == vq->num) {
> > > > > -                     /* Kicks are disabled at this point, break loop and
> > > > > -                      * process any remaining batched packets. Queue will
> > > > > -                      * be re-enabled afterwards.
> > > > > +                     /* Flush batched packets before enabling
> > > > > +                      * virqtueue notification to reduce
> > > > > +                      * unnecssary virtqueue kicks.
> > > > >                        */
> > > > > +                     vhost_tx_batch(net, nvq, sock, &msg);
> > > >
> > > > So why don't we do this in the "else" branch"? If we are busy polling
> > > > then we are not enabling kicks, so is there a reason to flush?
> > >
> > > It should be functional equivalent:
> > >
> > > do {
> > >     if (head == vq->num) {
> > >         vhost_tx_batch();
> > >         if (unlikely(busyloop_intr)) {
> > >             vhost_poll_queue()
> > >         } else if () {
> > >             vhost_disable_notify(&net->dev, vq);
> > >             continue;
> > >         }
> > >         return;
> > > }
> > >
> > > vs
> > >
> > > do {
> > >     if (head == vq->num) {
> > >         if (unlikely(busyloop_intr)) {
> > >             vhost_poll_queue()
> > >         } else if () {
> > >             vhost_tx_batch();
> > >             vhost_disable_notify(&net->dev, vq);
> > >             continue;
> > >         }
> > >         break;
> > > }
> > >
> > > vhost_tx_batch();
> > > return;
> > >
> > > Thanks
> > >
> >
> > But this is not what the code comment says:
> >
> >                      /* Flush batched packets before enabling
> >                       * virqtueue notification to reduce
> >                       * unnecssary virtqueue kicks.
> >
> >
> > So I ask - of we queued more polling, why do we need
> > to flush batched packets? We might get more in the next
> > polling round, this is what polling is designed to do.
> 
> The reason is there could be a rx work when busyloop_intr is true, so
> we need to flush.
> 
> Thanks

Then you need to update the comment to explain.
Want to post your version of this patchset?


> >
> >
> > >
> > > >
> > > >
> > > > > +                     if (unlikely(busyloop_intr)) {
> > > > > +                             vhost_poll_queue(&vq->poll);
> > > > > +                     } else if (unlikely(vhost_enable_notify(&net->dev,
> > > > > +                                                             vq))) {
> > > > > +                             vhost_disable_notify(&net->dev, vq);
> > > > > +                             continue;
> > > > > +                     }
> > > > >                       break;
> > > > >               }
> > > > >
> > > > > @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > >               ++nvq->done_idx;
> > > > >       } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> > > > >
> > > > > -     /* Kicks are still disabled, dispatch any remaining batched msgs. */
> > > > >       vhost_tx_batch(net, nvq, sock, &msg);
> > > > > -
> > > > > -     if (unlikely(busyloop_intr))
> > > > > -             /* If interrupted while doing busy polling, requeue the
> > > > > -              * handler to be fair handle_rx as well as other tasks
> > > > > -              * waiting on cpu.
> > > > > -              */
> > > > > -             vhost_poll_queue(&vq->poll);
> > > > > -     else
> > > > > -             /* All of our work has been completed; however, before
> > > > > -              * leaving the TX handler, do one last check for work,
> > > > > -              * and requeue handler if necessary. If there is no work,
> > > > > -              * queue will be reenabled.
> > > > > -              */
> > > > > -             vhost_net_busy_poll_try_queue(net, vq);
> > > > >  }
> > > > >
> > > > >  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> > > > > --
> > > > > 2.34.1
> > > >
> >

