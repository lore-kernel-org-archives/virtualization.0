Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B9415C6
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNtoVSih"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6BCD410BB
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 06:45:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6BCD410BB
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BNtoVSih
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Ie0Yv_M4C0X
	for <virtualization@lists.linux-foundation.org>;
	Mon, 25 Dec 2023 06:45:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F040410B5
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 06:45:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F040410B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703486712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmtImPcIoJ1LGqQ77I/n9yZ5QbLq+pXgyPpHJK1YtUg=;
	b=BNtoVSihZGPuDKkLI3zucCVdeQnV5x0s1ZhuCBHkqzkFbKg0vKha601VXDDm6iglycnlmr
	yw8xb8afDZuOBvRW4uG5GvOjVe1gdQ2WoTDKayTXDSI+Q6T2+4rVcMmJDgMTGnjt5/B3yl
	ozqvgoF/LBQtcu2BzoN6fESx7fkBfuI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-leMy0Ep3N9mBCLV0ht5J_g-1; Mon, 25 Dec 2023 01:45:09 -0500
X-MC-Unique: leMy0Ep3N9mBCLV0ht5J_g-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-594a2fb0476so104449eaf.3
        for <virtualization@lists.linux-foundation.org>; Sun, 24 Dec 2023 22:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703486708; x=1704091508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmtImPcIoJ1LGqQ77I/n9yZ5QbLq+pXgyPpHJK1YtUg=;
        b=WPgkZp8yrQUtgMib8nlEH1AEpV8So3ofnfetVZcYHWrnVntK/lmujOHAUilcA0s+aC
         xwL/eR0MvAcoSZdtyzBu3ObKq4fEju5Q4KTI189qFYXcTI4QuitQMl/xNSVAnXSUwbqu
         kkIv/e8NQagfcoLAOBN467Xsk9Kua64kdo+V2O+E2fxKx4vnbAc67mWIT45lAw91uxqk
         qCr+4y+F/QFbuWNkhd3SFGd4AW5uac9dU8YGBkdCPzb050EyhknOE2GQTp5Mm0H3DD8U
         cqM9TjH5b0V7GMJnlhC9iMaOozjmSbCBv2bRuYZoMMYV6Hvi8r5bh0pSJyx3MlcZtG4d
         jh7g==
X-Gm-Message-State: AOJu0YxUWHzJkYaIYNVnmIprbTHVVPmO8hM4Rl9PSPo22T+/PLPkTaF/
	0jt+WQfe+MuWyluBT19fKanSOG/S2yPjuReADKtfHQ42mjN2knuRioZ42gvy9/qV1Mw3+MPU+Fz
	aRIbuWhSnkqli8QYPsZJsUF6MEtoQ0jyLrltNE++O+Xyw20dCO3dhQFYeGQydbl2ZmQ==
X-Received: by 2002:a05:6808:2118:b0:3bb:8522:dba0 with SMTP id r24-20020a056808211800b003bb8522dba0mr5969403oiw.112.1703486708435;
        Sun, 24 Dec 2023 22:45:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDDjdG0E4rbWENM0XwXtvhozKjVakj52ReAo9xKUNnOo1aUueOtsVVgVodGV0+LniXB5cZZmnMx39GWiJ+ylo=
X-Received: by 2002:a05:6808:2118:b0:3bb:8522:dba0 with SMTP id
 r24-20020a056808211800b003bb8522dba0mr5969385oiw.112.1703486708117; Sun, 24
 Dec 2023 22:45:08 -0800 (PST)
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
 <CACGkMEsDFTPUVXfSj5FGTK_722F1QkKHJG3GNV3qvsaKATZV_w@mail.gmail.com> <CAL+tcoA_kXEb2uBznUY8A+-uVcB_rXx1j39Wt8UTNx+6F0iHNA@mail.gmail.com>
In-Reply-To: <CAL+tcoA_kXEb2uBznUY8A+-uVcB_rXx1j39Wt8UTNx+6F0iHNA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Dec 2023 14:44:56 +0800
Message-ID: <CACGkMEspead380Sx-5HRjAO4LYc+R2EM+-K-7cYYuus72gPXbw@mail.gmail.com>
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

On Mon, Dec 25, 2023 at 2:34=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Dec 25, 2023 at 12:14=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Dec 25, 2023 at 10:25=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > Hello Jason,
> > > On Fri, Dec 22, 2023 at 10:36=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Heng Qi wrote:
> > > > > >
> > > > > >
> > > > > > =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruijn =
=E5=86=99=E9=81=93:
> > > > > > > Heng Qi wrote:
> > > > > > >> virtio-net has two ways to switch napi_tx: one is through th=
e
> > > > > > >> module parameter, and the other is through coalescing parame=
ter
> > > > > > >> settings (provided that the nic status is down).
> > > > > > >>
> > > > > > >> Sometimes we face performance regression caused by napi_tx,
> > > > > > >> then we need to switch napi_tx when debugging. However, the
> > > > > > >> existing methods are a bit troublesome, such as needing to
> > > > > > >> reload the driver or turn off the network card.
> > > >
> > > > Why is this troublesome? We don't need to turn off the card, it's j=
ust
> > > > a toggling of the interface.
> > > >
> > > > This ends up with pretty simple code.
> > > >
> > > > > So try to make
> > > > > > >> this update.
> > > > > > >>
> > > > > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > The commit does not explain why it is safe to do so.
> > > > > >
> > > > > > virtnet_napi_tx_disable ensures that already scheduled tx napi =
ends and
> > > > > > no new tx napi will be scheduled.
> > > > > >
> > > > > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack c=
annot
> > > > > > send the packet.
> > > > > >
> > > > > > Then we can safely toggle the weight to indicate where to clear=
 the buffers.
> > > > > >
> > > > > > >
> > > > > > > The tx-napi weights are not really weights: it is a boolean w=
hether
> > > > > > > napi is used for transmit cleaning, or whether packets are cl=
eaned
> > > > > > > in ndo_start_xmit.
> > > > > >
> > > > > > Right.
> > > > > >
> > > > > > >
> > > > > > > There certainly are some subtle issues with regard to pausing=
/waking
> > > > > > > queues when switching between modes.
> > > > > >
> > > > > > What are "subtle issues" and if there are any, we find them.
> > > > >
> > > > > A single runtime test is not sufficient to exercise all edge case=
s.
> > > > >
> > > > > Please don't leave it to reviewers to establish the correctness o=
f a
> > > > > patch.
> > > >
> > > > +1
> > > >
> > > [...]
> > > > And instead of trying to do this, it would be much better to optimi=
ze
> > > > the NAPI performance. Then we can drop the orphan mode.
> > >
> [...]
> > > Do you mean when to call skb_orphan()? If yes, I just want to provide
> > > more information that we also have some performance issues where the
> > > flow control takes a bad effect, especially under some small
> > > throughput in our production environment.
> >
> > I think you need to describe it in detail.
>
> Some of the details were described below in the last email. The
> decreased performance happened because of flow control: the delay of
> skb free means the delay

What do you mean by delay here? Is it an interrupt delay? If yes, Does
it work better if you simply remove

virtqueue_enable_cb_delayed() with virtqueue_enable_cb()? As the
former may delay the interrupt more or less depend on the traffic.

> of decreasing of sk_wmem_alloc, then it will
> hit the limit of TSQ mechanism, finally causing transmitting slowly in
> the TCP layer.

TSQ might work better with BQL which virtio-net doesn't have right now.

>
> >
> > > What strikes me as odd is if I restart the network, then the issue
> > > will go with the wind. I cannot reproduce it in my testing machine.
> > > One more thing: if I force skb_orphan() the current skb in every
> > > start_xmit(), it could also solve the issue but not in a proper way.
> > > After all, it drops the flow control... :S
> >
> > Yes, that's the known issue.
>
> Really? Did you have some numbers or have some discussion links to
> share? I failed to reproduce on my testing machine, probably the short
> rtt is the key/obstacle.

I basically mean it is a known side effect of skb_orphan() as it might
decrease sk_wmem_alloc too early.

Thanks


>
> @Eric, it seems it still exists.
>
> Thanks,
> Jason
>
> >
> > Thanks
> >
> > >
> > > Thanks,
> > > Jason
> > > >
> > > > >
> > > > > The napi_tx and non-napi code paths differ in how they handle at =
least
> > > > > the following structures:
> > > > >
> > > > > 1. skb: non-napi orphans these in ndo_start_xmit. Without napi th=
is is
> > > > > needed as delay until the next ndo_start_xmit and thus completion=
 is
> > > > > unbounded.
> > > > >
> > > > > When switching to napi mode, orphaned skbs may now be cleaned by =
the
> > > > > napi handler. This is indeed safe.
> > > > >
> > > > > When switching from napi to non-napi, the unbound latency resurfa=
ces.
> > > > > It is a small edge case, and I think a potentially acceptable ris=
k, if
> > > > > the user of this knob is aware of the risk.
> > > > >
> > > > > 2. virtqueue callback ("interrupt" masking). The non-napi path en=
ables
> > > > > the interrupt (disables the mask) when available descriptors fall=
s
> > > > > beneath a low watermark, and reenables when it recovers above a h=
igh
> > > > > watermark. Napi disables when napi is scheduled, and reenables on
> > > > > napi complete.
> > > > >
> > > > > 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls bel=
ow
> > > > > a low watermark, the driver stops the stack for queuing more pack=
ets.
> > > > > In napi mode, it schedules napi to clean packets. See the calls t=
o
> > > > > netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue and
> > > > > netif_tx_wake_queue.
> > > > >
> > > > > Some if this can be assumed safe by looking at existing analogous
> > > > > code, such as the queue stop/start in virtnet_tx_resize.
> > > > >
> > > > > But that all virtqueue callback and dev_queue->state transitions =
are
> > > > > correct when switching between modes at runtime is not trivial to
> > > > > establish, deserves some thought and explanation in the commit
> > > > > message.
> > > >
> > > > Thanks
> > > >
> > > >
> > >
> >
>

