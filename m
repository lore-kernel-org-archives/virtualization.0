Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9F17DB
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKARG5Ok"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4377D41584
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 02:25:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4377D41584
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KKARG5Ok
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id goP8x5wVhfkM
	for <virtualization@lists.linux-foundation.org>;
	Mon, 25 Dec 2023 02:25:28 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BD6FF41583
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 02:25:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD6FF41583
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a23566e91d5so403557066b.0
        for <virtualization@lists.linux-foundation.org>; Sun, 24 Dec 2023 18:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703471126; x=1704075926; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbIFx2o+cEw7nOLFhxQ0X7KzqVoERgpLQibm5Hb+6QY=;
        b=KKARG5OkSGP1rZaXTP3xe/P8RsGbTqDbNZ/mqSQB0TxSQWeI3GkIFvu7s/KeOC3zN/
         LKf1wX6JI7LqEgoJ14qIr0umfb25cMk9EZq8jBn0ZwTKC60OVUkeqDK456ugHk7nsD3N
         0E1m+V5t4natULox2SFEMCpdbsvkr6G1c3AFHMys2ZbLIZBw9bBb8+v3BQmzIhSyyMu/
         w2h4biI0i6rgWDnWKslnQ3/JqPUMO0fSWGTwWobpHiZsYwu9/SmKlqVhhVx1uv6Ho5KX
         qqpRKZpFzbhpyNRDS7k3Uvs31sNq5Yx2AOhIIUyhBrH1aOGVJm19ILqzKuvbnNXLIvPv
         gdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703471126; x=1704075926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbIFx2o+cEw7nOLFhxQ0X7KzqVoERgpLQibm5Hb+6QY=;
        b=Drx7GIxswVLe8ht1sMYXTacVJHb+MvaZk5HNVXrG2/7tyEHdEv6x+ln85mg++IJFl+
         7yV3FVP3HkP8Iw7OPCoc4XKM/2ucsi0X4XdVwyvmvFX8zLt1SHNrEnps0ZSU8dY2uIdf
         X/7Q7QNrf/z9P0LIL+5dnUtjEROCOBWZJdinz92ZtG8DqQg2AoyHbkKKDgLlEYiawTv0
         y+y30pKHfdeTYmjgBCkoyJYWV0Mt635G4iBUTSTaWRbbtL7D/lpY9x98PUv09UVADnMP
         73IeJ68sppEEjnSGQbW8hTKQrFsltnfZs5IX0JSS5ELTu7A0XSjStVebgYGaORcWPUqE
         nw0A==
X-Gm-Message-State: AOJu0YwEfxYqppZtDdn3iTD056HK1caekaj97jT39osx9PR8ck4Mj9az
	PPqsTs/juTpWNoVY+vh6uz9PpN1V0rq2yq5/6LM=
X-Google-Smtp-Source: AGHT+IH4FzjlFYYa4nRcVYYwulNS15yheWqq6OC4EN/TrmeE31IEUgyMLdMk9eyVEFHW6uOvNyjHMCpn5l5S8AvvGuA=
X-Received: by 2002:a17:906:fb16:b0:a23:62fe:9856 with SMTP id
 lz22-20020a170906fb1600b00a2362fe9856mr1541156ejb.158.1703471125475; Sun, 24
 Dec 2023 18:25:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch> <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch> <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
In-Reply-To: <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 25 Dec 2023 10:24:48 +0800
Message-ID: <CAL+tcoDM+Kqu1=11m5gc58vY3uKVA6JiggBy_FyCghHY3Za0Qw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jason,
On Fri, Dec 22, 2023 at 10:36=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Heng Qi wrote:
> > >
> > >
> > > =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruijn =E5=86=
=99=E9=81=93:
> > > > Heng Qi wrote:
> > > >> virtio-net has two ways to switch napi_tx: one is through the
> > > >> module parameter, and the other is through coalescing parameter
> > > >> settings (provided that the nic status is down).
> > > >>
> > > >> Sometimes we face performance regression caused by napi_tx,
> > > >> then we need to switch napi_tx when debugging. However, the
> > > >> existing methods are a bit troublesome, such as needing to
> > > >> reload the driver or turn off the network card.
>
> Why is this troublesome? We don't need to turn off the card, it's just
> a toggling of the interface.
>
> This ends up with pretty simple code.
>
> > So try to make
> > > >> this update.
> > > >>
> > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > The commit does not explain why it is safe to do so.
> > >
> > > virtnet_napi_tx_disable ensures that already scheduled tx napi ends a=
nd
> > > no new tx napi will be scheduled.
> > >
> > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack cannot
> > > send the packet.
> > >
> > > Then we can safely toggle the weight to indicate where to clear the b=
uffers.
> > >
> > > >
> > > > The tx-napi weights are not really weights: it is a boolean whether
> > > > napi is used for transmit cleaning, or whether packets are cleaned
> > > > in ndo_start_xmit.
> > >
> > > Right.
> > >
> > > >
> > > > There certainly are some subtle issues with regard to pausing/wakin=
g
> > > > queues when switching between modes.
> > >
> > > What are "subtle issues" and if there are any, we find them.
> >
> > A single runtime test is not sufficient to exercise all edge cases.
> >
> > Please don't leave it to reviewers to establish the correctness of a
> > patch.
>
> +1
>
[...]
> And instead of trying to do this, it would be much better to optimize
> the NAPI performance. Then we can drop the orphan mode.

Do you mean when to call skb_orphan()? If yes, I just want to provide
more information that we also have some performance issues where the
flow control takes a bad effect, especially under some small
throughput in our production environment.
What strikes me as odd is if I restart the network, then the issue
will go with the wind. I cannot reproduce it in my testing machine.
One more thing: if I force skb_orphan() the current skb in every
start_xmit(), it could also solve the issue but not in a proper way.
After all, it drops the flow control... :S

Thanks,
Jason
>
> >
> > The napi_tx and non-napi code paths differ in how they handle at least
> > the following structures:
> >
> > 1. skb: non-napi orphans these in ndo_start_xmit. Without napi this is
> > needed as delay until the next ndo_start_xmit and thus completion is
> > unbounded.
> >
> > When switching to napi mode, orphaned skbs may now be cleaned by the
> > napi handler. This is indeed safe.
> >
> > When switching from napi to non-napi, the unbound latency resurfaces.
> > It is a small edge case, and I think a potentially acceptable risk, if
> > the user of this knob is aware of the risk.
> >
> > 2. virtqueue callback ("interrupt" masking). The non-napi path enables
> > the interrupt (disables the mask) when available descriptors falls
> > beneath a low watermark, and reenables when it recovers above a high
> > watermark. Napi disables when napi is scheduled, and reenables on
> > napi complete.
> >
> > 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls below
> > a low watermark, the driver stops the stack for queuing more packets.
> > In napi mode, it schedules napi to clean packets. See the calls to
> > netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue and
> > netif_tx_wake_queue.
> >
> > Some if this can be assumed safe by looking at existing analogous
> > code, such as the queue stop/start in virtnet_tx_resize.
> >
> > But that all virtqueue callback and dev_queue->state transitions are
> > correct when switching between modes at runtime is not trivial to
> > establish, deserves some thought and explanation in the commit
> > message.
>
> Thanks
>
>
