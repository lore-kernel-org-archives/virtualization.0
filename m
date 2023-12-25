Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA52E10A2B
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 06:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cc1C6w4n"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 099E94019F
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 06:47:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 099E94019F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cc1C6w4n
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TL9HGUQo3w2s
	for <virtualization@lists.linux-foundation.org>;
	Mon, 25 Dec 2023 06:47:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0199A400FF
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 06:47:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0199A400FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703486871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xLEF3rnqF8tI7BPYNvQbmlqvrh1QxVBzNXBUpXiDmY=;
	b=cc1C6w4nJu2D0fQCS3ftT9dU8Da7fwLsA6qJ9C8AAT+HvSoETDynMdK2v5YLgkI/hG/bGI
	8OQFTK2xMgJl2N5krdcP3I9DkEEWlmfREwGV/q0UOR9zzdxRJlE3NchMe3dHMyzuxvpQCm
	puEBEEoOUqDdZ0tyBPHxz1+aWIHIo2I=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-MlC8ThsTNl2nNvOUJWIP5Q-1; Mon, 25 Dec 2023 01:47:50 -0500
X-MC-Unique: MlC8ThsTNl2nNvOUJWIP5Q-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bb7be37ad4so3261865b6e.1
        for <virtualization@lists.linux-foundation.org>; Sun, 24 Dec 2023 22:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703486869; x=1704091669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xLEF3rnqF8tI7BPYNvQbmlqvrh1QxVBzNXBUpXiDmY=;
        b=fKbU9rRSqiRCkHY/HWwBQC25QQ5WesdiMmRm569uXe4qXJbS43zHhAp9p2EVsnDF0T
         P/e0+KCgC3IIKwZ8QdQlKZmYTHilMXcWfR02rr6HdOtqppp34Rti4MYKW/JWyCPhCRGv
         KrxtAMKiBdlo9hbvGOBwM4AzlueJAwpupDTUdUPpU5C+vLEvyCcDfVsBspdodlsgWQEJ
         Vo5apnw8FGZbJqVw2pe8xRFjpXXcHx2opjWeg63UkYwAy1/9IvvN2LaUsO88nt1CYu2v
         C+ihXSMcX0mwAS6A+fEStG9LcOQ+A5QNP0Qs8OAm3HoBPM9wM3piY5qB0cOc0hRSyucj
         rDwA==
X-Gm-Message-State: AOJu0YzCyYGW842ql0gWwm6i0Y6pAyZz3k+BftmgL9PM0zH+KdKxzW8J
	9ctmsAbAhAaTcg/M3b02T7yD4PMK8sLMvHiLLIhmwU5Aecxsko13l/iXI6plWX0oRHqHt/hLEvl
	hHlJ9yXUYNDw9fB1wCMdAhq30zZqonFUBI4xEYcsnq7/eqxUR3Fv5+BHgbZcsqq+Kig==
X-Received: by 2002:a05:6808:1512:b0:3b9:ebea:3bc2 with SMTP id u18-20020a056808151200b003b9ebea3bc2mr5434670oiw.69.1703486869333;
        Sun, 24 Dec 2023 22:47:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkOXV+btxe8XFnwLoE2qrv6Qw7Q59TP4QWleTqn7lW5NfmnG7AUarFi2yYrPKXrpmBoZcM5fkObZgmfjrjp1s=
X-Received: by 2002:a05:6808:1512:b0:3b9:ebea:3bc2 with SMTP id
 u18-20020a056808151200b003b9ebea3bc2mr5434662oiw.69.1703486869058; Sun, 24
 Dec 2023 22:47:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch> <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch> <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
 <CAL+tcoDM+Kqu1=11m5gc58vY3uKVA6JiggBy_FyCghHY3Za0Qw@mail.gmail.com>
 <CACGkMEsDFTPUVXfSj5FGTK_722F1QkKHJG3GNV3qvsaKATZV_w@mail.gmail.com>
 <CAL+tcoA_kXEb2uBznUY8A+-uVcB_rXx1j39Wt8UTNx+6F0iHNA@mail.gmail.com> <CACGkMEspead380Sx-5HRjAO4LYc+R2EM+-K-7cYYuus72gPXbw@mail.gmail.com>
In-Reply-To: <CACGkMEspead380Sx-5HRjAO4LYc+R2EM+-K-7cYYuus72gPXbw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Dec 2023 14:47:37 +0800
Message-ID: <CACGkMEuNPZZthCK9VTPiTL=oVPYNJSi2O_DyBt+SBoxrW-EHuA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 2:44=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Dec 25, 2023 at 2:34=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Mon, Dec 25, 2023 at 12:14=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Mon, Dec 25, 2023 at 10:25=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >
> > > > Hello Jason,
> > > > On Fri, Dec 22, 2023 at 10:36=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Heng Qi wrote:
> > > > > > >
> > > > > > >
> > > > > > > =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruij=
n =E5=86=99=E9=81=93:
> > > > > > > > Heng Qi wrote:
> > > > > > > >> virtio-net has two ways to switch napi_tx: one is through =
the
> > > > > > > >> module parameter, and the other is through coalescing para=
meter
> > > > > > > >> settings (provided that the nic status is down).
> > > > > > > >>
> > > > > > > >> Sometimes we face performance regression caused by napi_tx=
,
> > > > > > > >> then we need to switch napi_tx when debugging. However, th=
e
> > > > > > > >> existing methods are a bit troublesome, such as needing to
> > > > > > > >> reload the driver or turn off the network card.
> > > > >
> > > > > Why is this troublesome? We don't need to turn off the card, it's=
 just
> > > > > a toggling of the interface.
> > > > >
> > > > > This ends up with pretty simple code.
> > > > >
> > > > > > So try to make
> > > > > > > >> this update.
> > > > > > > >>
> > > > > > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > The commit does not explain why it is safe to do so.
> > > > > > >
> > > > > > > virtnet_napi_tx_disable ensures that already scheduled tx nap=
i ends and
> > > > > > > no new tx napi will be scheduled.
> > > > > > >
> > > > > > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack=
 cannot
> > > > > > > send the packet.
> > > > > > >
> > > > > > > Then we can safely toggle the weight to indicate where to cle=
ar the buffers.
> > > > > > >
> > > > > > > >
> > > > > > > > The tx-napi weights are not really weights: it is a boolean=
 whether
> > > > > > > > napi is used for transmit cleaning, or whether packets are =
cleaned
> > > > > > > > in ndo_start_xmit.
> > > > > > >
> > > > > > > Right.
> > > > > > >
> > > > > > > >
> > > > > > > > There certainly are some subtle issues with regard to pausi=
ng/waking
> > > > > > > > queues when switching between modes.
> > > > > > >
> > > > > > > What are "subtle issues" and if there are any, we find them.
> > > > > >
> > > > > > A single runtime test is not sufficient to exercise all edge ca=
ses.
> > > > > >
> > > > > > Please don't leave it to reviewers to establish the correctness=
 of a
> > > > > > patch.
> > > > >
> > > > > +1
> > > > >
> > > > [...]
> > > > > And instead of trying to do this, it would be much better to opti=
mize
> > > > > the NAPI performance. Then we can drop the orphan mode.
> > > >
> > [...]
> > > > Do you mean when to call skb_orphan()? If yes, I just want to provi=
de
> > > > more information that we also have some performance issues where th=
e
> > > > flow control takes a bad effect, especially under some small
> > > > throughput in our production environment.
> > >
> > > I think you need to describe it in detail.
> >
> > Some of the details were described below in the last email. The
> > decreased performance happened because of flow control: the delay of
> > skb free means the delay
>
> What do you mean by delay here? Is it an interrupt delay? If yes, Does
> it work better if you simply remove
>
> virtqueue_enable_cb_delayed() with virtqueue_enable_cb()? As the
> former may delay the interrupt more or less depend on the traffic.
>
> > of decreasing of sk_wmem_alloc, then it will
> > hit the limit of TSQ mechanism, finally causing transmitting slowly in
> > the TCP layer.
>
> TSQ might work better with BQL which virtio-net doesn't have right now.
>
> >
> > >
> > > > What strikes me as odd is if I restart the network, then the issue
> > > > will go with the wind. I cannot reproduce it in my testing machine.
> > > > One more thing: if I force skb_orphan() the current skb in every
> > > > start_xmit(), it could also solve the issue but not in a proper way=
.
> > > > After all, it drops the flow control... :S
> > >
> > > Yes, that's the known issue.

Just to clarify, I mean the skb_orphan() drop flow control is a known
issue. Not the restart...

Thanks

> >
> > Really? Did you have some numbers or have some discussion links to
> > share? I failed to reproduce on my testing machine, probably the short
> > rtt is the key/obstacle.
>
> I basically mean it is a known side effect of skb_orphan() as it might
> decrease sk_wmem_alloc too early.
>
> Thanks
>
>
> >
> > @Eric, it seems it still exists.
> >
> > Thanks,
> > Jason
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks,
> > > > Jason
> > > > >
> > > > > >
> > > > > > The napi_tx and non-napi code paths differ in how they handle a=
t least
> > > > > > the following structures:
> > > > > >
> > > > > > 1. skb: non-napi orphans these in ndo_start_xmit. Without napi =
this is
> > > > > > needed as delay until the next ndo_start_xmit and thus completi=
on is
> > > > > > unbounded.
> > > > > >
> > > > > > When switching to napi mode, orphaned skbs may now be cleaned b=
y the
> > > > > > napi handler. This is indeed safe.
> > > > > >
> > > > > > When switching from napi to non-napi, the unbound latency resur=
faces.
> > > > > > It is a small edge case, and I think a potentially acceptable r=
isk, if
> > > > > > the user of this knob is aware of the risk.
> > > > > >
> > > > > > 2. virtqueue callback ("interrupt" masking). The non-napi path =
enables
> > > > > > the interrupt (disables the mask) when available descriptors fa=
lls
> > > > > > beneath a low watermark, and reenables when it recovers above a=
 high
> > > > > > watermark. Napi disables when napi is scheduled, and reenables =
on
> > > > > > napi complete.
> > > > > >
> > > > > > 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls b=
elow
> > > > > > a low watermark, the driver stops the stack for queuing more pa=
ckets.
> > > > > > In napi mode, it schedules napi to clean packets. See the calls=
 to
> > > > > > netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue a=
nd
> > > > > > netif_tx_wake_queue.
> > > > > >
> > > > > > Some if this can be assumed safe by looking at existing analogo=
us
> > > > > > code, such as the queue stop/start in virtnet_tx_resize.
> > > > > >
> > > > > > But that all virtqueue callback and dev_queue->state transition=
s are
> > > > > > correct when switching between modes at runtime is not trivial =
to
> > > > > > establish, deserves some thought and explanation in the commit
> > > > > > message.
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > >
> > >
> >

