Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7D17C7
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHg63qeE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9544760B7C
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 02:35:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9544760B7C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KHg63qeE
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eO-CvC0bJuW0
	for <virtualization@lists.linux-foundation.org>;
	Fri, 22 Dec 2023 02:35:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 371AA60B79
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 02:35:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 371AA60B79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703212523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9z6L6ey7JbOtFUR6jZ6N2AL2ixhO+eS9tFlq+uZiyA=;
	b=KHg63qeEano6x3EwOBsWtungS2wafJkdsO2zbyqyLAtZJiZVFPMgZDIrVu/G4qxgcGsFvw
	RL5Noc1HLJNkD0sXOjxOGlcqGeI8RNcyjOnBeYUcnrbRkMjRY4pPWctwEhrnot/ctVveAR
	5+R4W8CRso0CkpFrE0MMHWSHzIr0e1g=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-7VwtItdtMOKa-Mt5VN_mew-1; Thu, 21 Dec 2023 21:35:21 -0500
X-MC-Unique: 7VwtItdtMOKa-Mt5VN_mew-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bb81df616dso1098046b6e.2
        for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 18:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703212520; x=1703817320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9z6L6ey7JbOtFUR6jZ6N2AL2ixhO+eS9tFlq+uZiyA=;
        b=le1DcoiMO5Aw0vnZyb3Xl5FtHTzZHHYvVTucHHn6G0NaDyMbKvDBIdqQpTx11i2COv
         PYBZO13kDQ/VQ1j9hEkKScXXt/s9FXlnLza8JKx9HOmRL0XzrZfUeELMiQkr1ECdt6AZ
         ZMt5uINcPE1YfLZSTgvJvZ9YQ3BnvvQDdA4mZxf6wNtwRh8s0GEJvtfBsfgzrU0LTJjA
         MyblQGT39cD+TcUuFihkqLy60P6vfkfHB90tTjInEcjloCxuPsyhJh+D6TZ4gMTN2Wg0
         7GiQ9CsOrwQ/dv1SzWxur+d5aw4+I5lXdhSaQhCcv134ZARFWIbAbUrWj8ASggjhE8yz
         SmMw==
X-Gm-Message-State: AOJu0Yz5ZwRAOUSJ/TRsYi+HJpm3Kmfs1J9BjlH9PhaqjWnKEK1gP9fu
	yhn6xpPxNFCzo6vG0xPWU+g9/0aKXl+SthL2DCKdsHrkj6pVW/O43OIbjaAZ35HKC2c5lz5yjbN
	Vc6rV5WteMqZAlJNd2LZ/tW7lo7do/Mg3PuVxgM0BY1vsV/eTfQkTx3oiwyNUnB+EAw==
X-Received: by 2002:a05:6808:2dc4:b0:3b9:e537:860d with SMTP id gn4-20020a0568082dc400b003b9e537860dmr918013oib.102.1703212520541;
        Thu, 21 Dec 2023 18:35:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZQ4V1pLjCf0GWjudKMk1QY0eW7XKH0Yj52OXCX7T4cxPR/8rwiBFz6wvwzDgxwJ0hkzr8rnhfQdI0hCMrzBg=
X-Received: by 2002:a05:6808:2dc4:b0:3b9:e537:860d with SMTP id
 gn4-20020a0568082dc400b003b9e537860dmr917994oib.102.1703212520268; Thu, 21
 Dec 2023 18:35:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch> <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch>
In-Reply-To: <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2023 10:35:07 +0800
Message-ID: <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Heng Qi wrote:
> >
> >
> > =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruijn =E5=86=
=99=E9=81=93:
> > > Heng Qi wrote:
> > >> virtio-net has two ways to switch napi_tx: one is through the
> > >> module parameter, and the other is through coalescing parameter
> > >> settings (provided that the nic status is down).
> > >>
> > >> Sometimes we face performance regression caused by napi_tx,
> > >> then we need to switch napi_tx when debugging. However, the
> > >> existing methods are a bit troublesome, such as needing to
> > >> reload the driver or turn off the network card.

Why is this troublesome? We don't need to turn off the card, it's just
a toggling of the interface.

This ends up with pretty simple code.

> So try to make
> > >> this update.
> > >>
> > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > The commit does not explain why it is safe to do so.
> >
> > virtnet_napi_tx_disable ensures that already scheduled tx napi ends and
> > no new tx napi will be scheduled.
> >
> > Afterwards, if the __netif_tx_lock_bh lock is held, the stack cannot
> > send the packet.
> >
> > Then we can safely toggle the weight to indicate where to clear the buf=
fers.
> >
> > >
> > > The tx-napi weights are not really weights: it is a boolean whether
> > > napi is used for transmit cleaning, or whether packets are cleaned
> > > in ndo_start_xmit.
> >
> > Right.
> >
> > >
> > > There certainly are some subtle issues with regard to pausing/waking
> > > queues when switching between modes.
> >
> > What are "subtle issues" and if there are any, we find them.
>
> A single runtime test is not sufficient to exercise all edge cases.
>
> Please don't leave it to reviewers to establish the correctness of a
> patch.

+1

And instead of trying to do this, it would be much better to optimize
the NAPI performance. Then we can drop the orphan mode.

>
> The napi_tx and non-napi code paths differ in how they handle at least
> the following structures:
>
> 1. skb: non-napi orphans these in ndo_start_xmit. Without napi this is
> needed as delay until the next ndo_start_xmit and thus completion is
> unbounded.
>
> When switching to napi mode, orphaned skbs may now be cleaned by the
> napi handler. This is indeed safe.
>
> When switching from napi to non-napi, the unbound latency resurfaces.
> It is a small edge case, and I think a potentially acceptable risk, if
> the user of this knob is aware of the risk.
>
> 2. virtqueue callback ("interrupt" masking). The non-napi path enables
> the interrupt (disables the mask) when available descriptors falls
> beneath a low watermark, and reenables when it recovers above a high
> watermark. Napi disables when napi is scheduled, and reenables on
> napi complete.
>
> 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls below
> a low watermark, the driver stops the stack for queuing more packets.
> In napi mode, it schedules napi to clean packets. See the calls to
> netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue and
> netif_tx_wake_queue.
>
> Some if this can be assumed safe by looking at existing analogous
> code, such as the queue stop/start in virtnet_tx_resize.
>
> But that all virtqueue callback and dev_queue->state transitions are
> correct when switching between modes at runtime is not trivial to
> establish, deserves some thought and explanation in the commit
> message.

Thanks

