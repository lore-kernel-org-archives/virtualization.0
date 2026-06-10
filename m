Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD43C10AF
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082953; cv=pass; b=gg4+h/dp9O8RzGTPXqFsjaR6VYiWprKZvt9JiUdNN230CTIEDTOz0dLwLrPtPywdqjO7krsjt98ejP/z8SEp21DyoxEt5jBBdEms8LRgEKSjnzWVRmsaHwTq8bWKb/LfV28huCYkXyeWX4Jiem+v69Qu2UI16098b1Vd7EkmeoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082953; c=relaxed/simple;
	bh=dkWTevOEzDTMmxDai2XZ5/ake5l927UeEL0MaDVmHek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sasp0U2TgFVlAVzgxqSbRJBM5lJgYgfQr3WxVUKHGNAEwbNDT+ACtcGbnlbTyQrtIpUYKpFct97mMzwlRfgXpVXFoSXfXYYR4aHfY6qoT2DMI4guPTeqDJ/iZBmmcc6XJEMWz/tPLuFLeHgmuMTW/gTy/lrUIc9k+JqLBcHkGlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/O76sCo; arc=pass smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/O76sCo"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7dd3f176f84so74450127b3.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 02:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781082950; cv=none;
        d=google.com; s=arc-20240605;
        b=dPPsQh0PgZC3l/7+XZ6/BdkpYSNqCI4YsuJF062wBeppnpG6QB5//SIUNyFGibpmoD
         AROKIDW/2/rwFqMXnq+26JUNu0oPpS+gv/+e50/9RhrLKWaB/lGmnZlLqxWU0561QHW+
         hpse5ZUov58wiwov3oyXxSfQATPqYN4/jOzR7TCim+WdDUMhaNcS/C9pnK3sjZ9FT1Wd
         MPlLuA0ZzLdqId0YO+m8vyFqlECaK0OpGOqQ4V/39Rw+ffaC7J44rbUtnTdYvnE6zohO
         t2af+JqLSJdxxxiMuiU3akF2v6mA7v2q3kKUJYkAh3LmLO06Pht4eoN5H81adHCOAqoB
         VyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Vr1lvCHUXqA8wl46L5q/dYr6UTfHd+/3UQsnP1BtFs=;
        fh=+hfJFALP/SODG3yA9HV3pxelym+6X8QSOFGIJ0aH44I=;
        b=RwWzJ1EhEcxg0CLdCapsYmR6LgC1AQVDR4Pk70Uiap+K3gENaqROEPO2CmaDYOBEVP
         d70Bx8GeVnDG07RxSe6+o0yePaAkMQRfMiWsfTW50AWCdyL/DzbuKmQPQin5vxXJ8+TI
         eygTpbXMoJDrOR08mXNdxP2xPDz4+hM9bjMo8HkQFg70E37sOK2JmDDLmoD4J7LPbsA2
         o244fcAK06XElA0iv20DNng6jJX3XCK0cmpXve9nh6Sp2Oe4PCLK7dXeO6RmCIW/BtQr
         sDY5vf1HuUwOHly4k6M72vNLpFSXXvlUU0gtypeymMbWi1yIG4EAjtbg2SkcNhiWcHIZ
         N+JQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781082950; x=1781687750; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Vr1lvCHUXqA8wl46L5q/dYr6UTfHd+/3UQsnP1BtFs=;
        b=r/O76sCoDnMZlLrlOFfL+2WjYGAG+Uf5jCOsMt9OdI06EH7egB6UYWid2haPN9PJmQ
         hI078Jr8BqUa+vzj9c9MyFjrt3GFNhzt5zgB47fxEUoTBL9gPT48Y16JraC5rljeGYVJ
         t/mT0DgPXrMuKg9y6zlQeAS4jZl6kX0VVf3lU7ykjyZJZdDhfluyA7M2PRmN70egtUGx
         M9sLq83AnNj9Udd4vud1CIYF5nKyl/JId0Jyek9FoK7jyhic5u6ln7SLn8ndyHwjYNDR
         2pKXqyOIRVTygxi4iMDXWXH8EKwvSMKABPvAoMttIASJrxAuFfeW6irqIOZju7RYFwmR
         vxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082950; x=1781687750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Vr1lvCHUXqA8wl46L5q/dYr6UTfHd+/3UQsnP1BtFs=;
        b=DbGBydNVkGn1vqz+p462sfCnph8HJQITRDM3y/xTsCHDkZWEUySjP1f/zgmhtF/aDe
         qZvyZgYo6WpUtZcdiWd74RL/wftd1vcKK9clvTgupMPmp8yspIkuETDUwgrRztU9SWRx
         WEXNJ6kb+E3AwodHJIZYogEBi6sPjmr9C+9fxryAA+VVbpb79iqLNlq1n+rkb1WW1Tmz
         pALXlo45WnDL5Iv8QgLamVteu0eZt+uRMYxuwKCIL5+PiyFdLKymfsJ1+fxKPYbgRNBi
         RHw4Vf6OnC+hXtZSJOG541+eLeND45NaVvzaVgfPOd4O4YUUGDHRZGUv4fmjx/f0Y8py
         8WVA==
X-Forwarded-Encrypted: i=1; AFNElJ+zYogPGuUXdok9z/CiwxDj/KRmA069U/64zJInNFmR9wHCZk49P8T7BKP9S+Xwmhtw4ADRRMbulAXNiRrPfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk0kTxbKrRU9/0hHa2SuIzueXneI4Mz1UdkZIRwEa8esBgA4w7
	/+l0q6QOaSz08zX2puWUs9BZMFB0TgoJnXQE1p4wtJq9CYHVreP6M23Dfw2gCVGHw+yGIKRHaps
	F6oGXgM95lvOOz8/wFN37cmYmUFAJf/I=
X-Gm-Gg: Acq92OHU3K61qbg1j7LtcTIk697YLzeEDpBOA7dl8isgDkWTCLlD6I6I6m3eAmrPYZ8
	bZptKft8biHXXJjiWjy8JTZwlV/wxag2hYWdNQBO20ey5afaSBjJDhTMjhmXZ8BJJuYQPLUyvru
	alDhNgDP9bwRQhguncsfweAEKtwa01hGJNb8vjwhGCw058j0eHU8L4/JdD+R5+4Xh4fvETon4M2
	kXsMzzi9bWUGfYJl8W2lXqMyEfdGVd29yIEuQogIjst+3RIsjz510TSYjC+c3d2OwB/JRG0ZAQz
	clmI3Rp1+mWq9HUQPB85
X-Received: by 2002:a05:690c:6088:b0:7b4:1ffe:f9f9 with SMTP id
 00721157ae682-7ed0d5c0168mr228901987b3.16.1781082949719; Wed, 10 Jun 2026
 02:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610081648.2205711-1-dongml2@chinatelecom.cn> <CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com>
In-Reply-To: <CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 10 Jun 2026 17:15:54 +0800
X-Gm-Features: AVVi8CeKeNx-GTsiC8xsIcnA6meI4tsNjbFnxar3BDX9_eDtXkvFWK2nbkQsqV8
Message-ID: <CADxym3ZVfwg7t96Ct20pnZdm9tTvpCypg_dp3f+3aj1TL2argQ@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:28=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Jun 10, 2026 at 10:17=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-n=
et.
> > Take the tx path for example, we set xsk_set_tx_need_wakeup() in
> > virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> > anywhere, which means the user will call send() for every packet.
> >
> > For the tx path, we will call xsk_set_tx_need_wakeup() after
> > virtnet_xsk_xmit_batch() if sq->vq is empty, as we can't be wakeup by t=
he
> > skb_xmit_done() in this case. Otherwise, we will clear the wakeup flag.
> >
> > For the rx path, we will call xsk_set_rx_need_wakeup() if we have free
> > buffers in rq->vq.
> >
> > Race condition is considered for both rx and tx path.
> >
>
> I didn't review the code itself, but the patch message lacks a Fixes:

Yeah, you are right, it's better to use the Fix tag here, and I'll
add it in the next version.

> tag. And the From and Signed-off-by emails don't match, which I'm not
> sure is valid.

Sorry about that. I use my company email in the SOB. I used
my company email for the From too. However, my company
email system can trigger "Delivery failure" messages sometimes,
and Alexei said it is annoying. So I didn't use it for the From
and removed it from the CC since then :/

Thanks!
Menglong Dong

>
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  drivers/net/virtio_net.c | 52 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 45 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 9b3da9f9786c..25e895b849a6 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
[...]
> >
> > --
> > 2.54.0
> >
>
