Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9B1116
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHuK86wm"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F89360C07
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 06:34:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F89360C07
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aHuK86wm
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QNsCJ2Db7PLC
	for <virtualization@lists.linux-foundation.org>;
	Mon, 25 Dec 2023 06:34:27 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FA3A60BF4
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 06:34:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FA3A60BF4
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-554e902064aso244673a12.1
        for <virtualization@lists.linux-foundation.org>; Sun, 24 Dec 2023 22:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703486065; x=1704090865; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeomeFEcFu9q02Wc7Knh1vYChhRuw9U4ir5ZybuLN6U=;
        b=aHuK86wmj/ENXXNEUZyqYt7tcWtNFiyYAtARhIH9nmfZ1UKl5Rmc0ygs2WwzX5Mfft
         VTyt8rV+IV/pEbey6IxwZHNL4rRf4EXruMmlzMFd5V3bRzsDOGCs2wm7do6+ZULCHFZl
         OVqHBJiq+dPMFOsMsLI1sJidGEFRHs7S0IAfsu5KCwN8rNCkJv+homvKbAhuiSHFZEVG
         jBvDa3uJl+3ZGLsaN1Wu7SJqLwTgj4+htmlARym4pP4PiRR8oNi2FXGlyFUysmxrqTDL
         gab4up9tVmYuQDG+h+5kFybGHOtAMTHR/MaJkNXex65m9TfsXUmolAbrO9l+xG8UPJ1P
         NMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703486065; x=1704090865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeomeFEcFu9q02Wc7Knh1vYChhRuw9U4ir5ZybuLN6U=;
        b=SCCDULedrGBfxVDmy9/ZHSVODXLPbZjHYiv1ypkLSAQCjX6L6YlTVSusv6JeiHR2Cr
         z2N9XGQwxGCzv1bz5JOCaQG+MoTPEPgAhIpeLV9oay/cF20KwI/AZYe5osmMz3Oz7u0E
         LyZ8LMTePvNGefjb4KWHAYYxR+gLuy7moBSbEybQ2er+wQs6i8U1tHTAS701ZxRtTeyU
         o5AD6kuduE1eAqXayIgs/Wnu5GxUHtbMChCgqXmnCn75k1W68D12H8pVkmCbjZzd7hR1
         U0sY1HDILImdyqwdqCnrzK/2eWmH1q2YHzkxTCskMin8Qq3SrGLpk2C281Gq47LJ/7dT
         jhuA==
X-Gm-Message-State: AOJu0Yx91hd4eqSI8oow2sagkmMJquFo/QELzsDfva0VDHnPAHcse6ut
	DtOhyu77oqdwmEePd7rtVu0ZMP++XV/JSpsNIOQ=
X-Google-Smtp-Source: AGHT+IEMxJ/h5LovoLdQonJp7UTysp6Lsme2Nws1ugvo5QB8A9ksZef6PfrnrZcUZoX4NUsrlC+Gt6dDjBbfed25inA=
X-Received: by 2002:a17:907:3e9e:b0:a23:6282:528d with SMTP id
 hs30-20020a1709073e9e00b00a236282528dmr2997969ejc.43.1703486065344; Sun, 24
 Dec 2023 22:34:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch> <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch> <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
 <CAL+tcoDM+Kqu1=11m5gc58vY3uKVA6JiggBy_FyCghHY3Za0Qw@mail.gmail.com> <CACGkMEsDFTPUVXfSj5FGTK_722F1QkKHJG3GNV3qvsaKATZV_w@mail.gmail.com>
In-Reply-To: <CACGkMEsDFTPUVXfSj5FGTK_722F1QkKHJG3GNV3qvsaKATZV_w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 25 Dec 2023 14:33:48 +0800
Message-ID: <CAL+tcoA_kXEb2uBznUY8A+-uVcB_rXx1j39Wt8UTNx+6F0iHNA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 12:14=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Dec 25, 2023 at 10:25=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > Hello Jason,
> > On Fri, Dec 22, 2023 at 10:36=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Heng Qi wrote:
> > > > >
> > > > >
> > > > > =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruijn =
=E5=86=99=E9=81=93:
> > > > > > Heng Qi wrote:
> > > > > >> virtio-net has two ways to switch napi_tx: one is through the
> > > > > >> module parameter, and the other is through coalescing paramete=
r
> > > > > >> settings (provided that the nic status is down).
> > > > > >>
> > > > > >> Sometimes we face performance regression caused by napi_tx,
> > > > > >> then we need to switch napi_tx when debugging. However, the
> > > > > >> existing methods are a bit troublesome, such as needing to
> > > > > >> reload the driver or turn off the network card.
> > >
> > > Why is this troublesome? We don't need to turn off the card, it's jus=
t
> > > a toggling of the interface.
> > >
> > > This ends up with pretty simple code.
> > >
> > > > So try to make
> > > > > >> this update.
> > > > > >>
> > > > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > The commit does not explain why it is safe to do so.
> > > > >
> > > > > virtnet_napi_tx_disable ensures that already scheduled tx napi en=
ds and
> > > > > no new tx napi will be scheduled.
> > > > >
> > > > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack can=
not
> > > > > send the packet.
> > > > >
> > > > > Then we can safely toggle the weight to indicate where to clear t=
he buffers.
> > > > >
> > > > > >
> > > > > > The tx-napi weights are not really weights: it is a boolean whe=
ther
> > > > > > napi is used for transmit cleaning, or whether packets are clea=
ned
> > > > > > in ndo_start_xmit.
> > > > >
> > > > > Right.
> > > > >
> > > > > >
> > > > > > There certainly are some subtle issues with regard to pausing/w=
aking
> > > > > > queues when switching between modes.
> > > > >
> > > > > What are "subtle issues" and if there are any, we find them.
> > > >
> > > > A single runtime test is not sufficient to exercise all edge cases.
> > > >
> > > > Please don't leave it to reviewers to establish the correctness of =
a
> > > > patch.
> > >
> > > +1
> > >
> > [...]
> > > And instead of trying to do this, it would be much better to optimize
> > > the NAPI performance. Then we can drop the orphan mode.
> >
[...]
> > Do you mean when to call skb_orphan()? If yes, I just want to provide
> > more information that we also have some performance issues where the
> > flow control takes a bad effect, especially under some small
> > throughput in our production environment.
>
> I think you need to describe it in detail.

Some of the details were described below in the last email. The
decreased performance happened because of flow control: the delay of
skb free means the delay of decreasing of sk_wmem_alloc, then it will
hit the limit of TSQ mechanism, finally causing transmitting slowly in
the TCP layer.

>
> > What strikes me as odd is if I restart the network, then the issue
> > will go with the wind. I cannot reproduce it in my testing machine.
> > One more thing: if I force skb_orphan() the current skb in every
> > start_xmit(), it could also solve the issue but not in a proper way.
> > After all, it drops the flow control... :S
>
> Yes, that's the known issue.

Really? Did you have some numbers or have some discussion links to
share? I failed to reproduce on my testing machine, probably the short
rtt is the key/obstacle.

@Eric, it seems it still exists.

Thanks,
Jason

>
> Thanks
>
> >
> > Thanks,
> > Jason
> > >
> > > >
> > > > The napi_tx and non-napi code paths differ in how they handle at le=
ast
> > > > the following structures:
> > > >
> > > > 1. skb: non-napi orphans these in ndo_start_xmit. Without napi this=
 is
> > > > needed as delay until the next ndo_start_xmit and thus completion i=
s
> > > > unbounded.
> > > >
> > > > When switching to napi mode, orphaned skbs may now be cleaned by th=
e
> > > > napi handler. This is indeed safe.
> > > >
> > > > When switching from napi to non-napi, the unbound latency resurface=
s.
> > > > It is a small edge case, and I think a potentially acceptable risk,=
 if
> > > > the user of this knob is aware of the risk.
> > > >
> > > > 2. virtqueue callback ("interrupt" masking). The non-napi path enab=
les
> > > > the interrupt (disables the mask) when available descriptors falls
> > > > beneath a low watermark, and reenables when it recovers above a hig=
h
> > > > watermark. Napi disables when napi is scheduled, and reenables on
> > > > napi complete.
> > > >
> > > > 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls below
> > > > a low watermark, the driver stops the stack for queuing more packet=
s.
> > > > In napi mode, it schedules napi to clean packets. See the calls to
> > > > netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue and
> > > > netif_tx_wake_queue.
> > > >
> > > > Some if this can be assumed safe by looking at existing analogous
> > > > code, such as the queue stop/start in virtnet_tx_resize.
> > > >
> > > > But that all virtqueue callback and dev_queue->state transitions ar=
e
> > > > correct when switching between modes at runtime is not trivial to
> > > > establish, deserves some thought and explanation in the commit
> > > > message.
> > >
> > > Thanks
> > >
> > >
> >
>
