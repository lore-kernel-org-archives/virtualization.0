Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91B2882CC
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757999947; cv=none; b=Pqj5rOTfbArHIw0t8FwWT3Ig6wrVJSaqKi8yBTgvVZSJu3JeLHWM7fq5scnvl6bbtwXnaaIsyikMqS37jCeiXvCQCyh/UIxCDnUXFzoTqFg6a3p0y2X6DhiNeWatS6XTFCIWIwAdTjA2O+F3Q1/WmBl5361bOyQYpMCILqiVEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757999947; c=relaxed/simple;
	bh=mYY1Q6a+G8tiWMSHSj+eXVNe+H398j6nOY5cYHrd3rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=S1pTb6bjuG4ddMo9a7GvkKG6XnV6irJvIL0oaKK3GcGWfH89ilknI/eKWh1A8qhZKwGlcmbk9iKtXMreWqerSydvJBknt/g+mILbfsaH/dB8jpJT1yhdF19SrqDkM42LY4jAg6xyol1kivxAHdzPLhaYScQaL0iZepZMLexqdkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJUKtbSP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJUKtbSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757999942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cqWpCLzeZ7Ek+DqtxOkx2773HtQBKMmlIbsEIMhI1E=;
	b=FJUKtbSPht2n3VeLNni6sAycU9vd/PLpxxqeO+A+EVY5vg8sxY2/QXANNoT5iNK5KFBuaX
	m8hVJsOEA0oUxZtHJjz5Y2aE4X9joNAieOn0b768YfXG/T+yhuN6UOVn+YIZAkRViFWsP1
	YtGDpdG//uE/snSjU2AbTe2zHoX/hlg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-LVvB-Yp1MKCrjXtzR5PXQg-1; Tue, 16 Sep 2025 01:19:01 -0400
X-MC-Unique: LVvB-Yp1MKCrjXtzR5PXQg-1
X-Mimecast-MFC-AGG-ID: LVvB-Yp1MKCrjXtzR5PXQg_1757999940
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b04827ca035so646767066b.0
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 22:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757999940; x=1758604740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cqWpCLzeZ7Ek+DqtxOkx2773HtQBKMmlIbsEIMhI1E=;
        b=G61mkghNQR3mGlvjaLHJqjprWfgUujtKDTgFrZYR8ixCYkoKu1W7JaA/wurQT4g8nu
         Whn++oXvD0hInY8J8x+U8nRf4Fa30mjQwL+3NKNfDuhIF3RM6rAxzG/kR62hjhQXffe3
         EdjZqXNaGhaqw+/t7aiKBIGn5wvKBqbyz0EGkQE5Dl8t52zy6E+Ta3EOySaIvzuFK3fE
         31Usi15zFDM64clujmt4dFmksTVBrxM33V4rStacwgrH184PPk3DhMGE90kOXoI4YLHD
         pePmXNafC8WYYFuLli1oVJghY7HNuI2eaF9jmH+7g5HSNd/Rq5XN3k1rjQhvf3ATBHAn
         7x3g==
X-Forwarded-Encrypted: i=1; AJvYcCVh6bGGfRkgalD/dFez2KipvLBIDNG5FY8HIL5oS1yGtX4bvgHmbt3Q3lX3Sv3x2u286YG2tnStlsb4L3iMZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YygYMpMRhkuy0YVlAoDOR+CC+/bP0Lbx65uZc9NkRinL95CWbUh
	/KltIXpntVab+QiqIjYgqG8pHh/ZgbZ1ziz+9iB9xuFoHM2tkUW4JIGqwmtA5oU7dUkvsnw+VTS
	T1zb8uPFseF3yR65PVMhMZcltq5faU/T6MA+yHzhtQCk+iuuZZDIOrNWnnOh/sw9YciN5
X-Gm-Gg: ASbGncsVpbiTW4hr4nEDLcnlAMCP5z66MPFF3rMSeFlibTet0UYn2UnH+tsAR8yAg/1
	hHSH8LHn9n890TXevpagykcmkVXFgTVU6uLFjkdT35D8I1PpLUgFFrmmO3Uv/JxPW1Qdw4+ZhRn
	pVRdRXDNoANLld4zAjWeH44v4FF6K8OCM+J84T9CjEexmzydVDOzpcwBWlEuQia5govJputLMJG
	VLugnTJuD785TdEqONPZHYRLFUb/jwst3+si4r7uknfroTkEtwxe6mDHq3aPVW2X7fLNJ7S8Rdm
	FEYdKAM14wJWX7QjnnbvWkUWaFTb
X-Received: by 2002:a17:907:1b1d:b0:b04:a780:4673 with SMTP id a640c23a62f3a-b07c38292a0mr1470550266b.31.1757999939865;
        Mon, 15 Sep 2025 22:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeTBH3RrhB4KX+YqUITKSLlPI9qo0agFX7/p4HwGPFdqgb6XY+aoH+6CU5sr1Y0eG7AGevXg==
X-Received: by 2002:a17:907:1b1d:b0:b04:a780:4673 with SMTP id a640c23a62f3a-b07c38292a0mr1470547666b.31.1757999939378;
        Mon, 15 Sep 2025 22:18:59 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f22b1sm1090360166b.86.2025.09.15.22.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:18:58 -0700 (PDT)
Date: Tue, 16 Sep 2025 01:18:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250916011733-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
 <20250915120210-mutt-send-email-mst@kernel.org>
 <CACGkMEufUAL1tBrfZVMQCEBmBZ=Z+aPqUtP=RzOQhjtG9jn7UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEufUAL1tBrfZVMQCEBmBZ=Z+aPqUtP=RzOQhjtG9jn7UA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eYcCcbsS3bL9umTWnaIHV1VsS_Qp4i-X0n57h4ykWJ0_1757999940
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Sep 16, 2025 at 10:37:35AM +0800, Jason Wang wrote:
> On Tue, Sep 16, 2025 at 12:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> > > Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> > > sendmsg") tries to defer the notification enabling by moving the logic
> > > out of the loop after the vhost_tx_batch() when nothing new is
> > > spotted. This will bring side effects as the new logic would be reused
> > > for several other error conditions.
> > >
> > > One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> > > might return -EAGAIN and exit the loop and see there's still available
> > > buffers, so it will queue the tx work again until userspace feed the
> > > IOTLB entry correctly. This will slowdown the tx processing and may
> > > trigger the TX watchdog in the guest.
> > >
> > > Fixing this by stick the notificaiton enabling logic inside the loop
> > > when nothing new is spotted and flush the batched before.
> > >
> > > Reported-by: Jon Kohler <jon@nutanix.com>
> > > Cc: stable@vger.kernel.org
> > > Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/vhost/net.c | 33 +++++++++++++--------------------
> > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index 16e39f3ab956..3611b7537932 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >       int err;
> > >       int sent_pkts = 0;
> > >       bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> > > -     bool busyloop_intr;
> > >       bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> > >
> > >       do {
> > > -             busyloop_intr = false;
> > > +             bool busyloop_intr = false;
> > > +
> > >               if (nvq->done_idx == VHOST_NET_BATCH)
> > >                       vhost_tx_batch(net, nvq, sock, &msg);
> > >
> > > @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >                       break;
> > >               /* Nothing new?  Wait for eventfd to tell us they refilled. */
> > >               if (head == vq->num) {
> > > -                     /* Kicks are disabled at this point, break loop and
> > > -                      * process any remaining batched packets. Queue will
> > > -                      * be re-enabled afterwards.
> > > +                     /* Flush batched packets before enabling
> > > +                      * virqtueue notification to reduce
> > > +                      * unnecssary virtqueue kicks.
> > >                        */
> > > +                     vhost_tx_batch(net, nvq, sock, &msg);
> >
> > So why don't we do this in the "else" branch"? If we are busy polling
> > then we are not enabling kicks, so is there a reason to flush?
> 
> It should be functional equivalent:
> 
> do {
>     if (head == vq->num) {
>         vhost_tx_batch();
>         if (unlikely(busyloop_intr)) {
>             vhost_poll_queue()
>         } else if () {
>             vhost_disable_notify(&net->dev, vq);
>             continue;
>         }
>         return;
> }
> 
> vs
> 
> do {
>     if (head == vq->num) {
>         if (unlikely(busyloop_intr)) {
>             vhost_poll_queue()
>         } else if () {
>             vhost_tx_batch();
>             vhost_disable_notify(&net->dev, vq);
>             continue;
>         }
>         break;
> }
> 
> vhost_tx_batch();
> return;
> 
> Thanks
>

But this is not what the code comment says:

                     /* Flush batched packets before enabling
                      * virqtueue notification to reduce
                      * unnecssary virtqueue kicks.


So I ask - of we queued more polling, why do we need
to flush batched packets? We might get more in the next
polling round, this is what polling is designed to do.

 
> 
> >
> >
> > > +                     if (unlikely(busyloop_intr)) {
> > > +                             vhost_poll_queue(&vq->poll);
> > > +                     } else if (unlikely(vhost_enable_notify(&net->dev,
> > > +                                                             vq))) {
> > > +                             vhost_disable_notify(&net->dev, vq);
> > > +                             continue;
> > > +                     }
> > >                       break;
> > >               }
> > >
> > > @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >               ++nvq->done_idx;
> > >       } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> > >
> > > -     /* Kicks are still disabled, dispatch any remaining batched msgs. */
> > >       vhost_tx_batch(net, nvq, sock, &msg);
> > > -
> > > -     if (unlikely(busyloop_intr))
> > > -             /* If interrupted while doing busy polling, requeue the
> > > -              * handler to be fair handle_rx as well as other tasks
> > > -              * waiting on cpu.
> > > -              */
> > > -             vhost_poll_queue(&vq->poll);
> > > -     else
> > > -             /* All of our work has been completed; however, before
> > > -              * leaving the TX handler, do one last check for work,
> > > -              * and requeue handler if necessary. If there is no work,
> > > -              * queue will be reenabled.
> > > -              */
> > > -             vhost_net_busy_poll_try_queue(net, vq);
> > >  }
> > >
> > >  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> > > --
> > > 2.34.1
> >

