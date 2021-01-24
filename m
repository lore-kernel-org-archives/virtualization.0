Return-Path: <SRS0=rEPQ=G3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6747C433DB
	for <virtualization@archiver.kernel.org>; Sun, 24 Jan 2021 11:52:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2199D230FD
	for <virtualization@archiver.kernel.org>; Sun, 24 Jan 2021 11:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2199D230FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3E8E85F83;
	Sun, 24 Jan 2021 11:52:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3auZmWBmYADi; Sun, 24 Jan 2021 11:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0345E85F67;
	Sun, 24 Jan 2021 11:52:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D932EC08A1;
	Sun, 24 Jan 2021 11:52:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29BFFC013A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 11:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1CB5F85F68
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 11:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OkTXD8vwB8Vr
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 11:52:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2F52485F67
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 11:52:42 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id g46so2221686ooi.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 03:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pu6Zr2Jo68blbhpXwzl9uRs7KbDV3skHPD8u3gz3sVI=;
 b=hLK0CiEKpK6Efjx+XUatItsaWE/mRmo/IWq/x6fk1BFPF2i7i2bt6e2DFk6OygAPzE
 skDu0spVWAOL2kvuzdgaIX2Qzsskv8asVzkubHi6iX0Ny6xxFzxJjd3ejJAIKNpcdQmB
 l2s+Xraztpfd/HTF6ODoGotgqxTnd9XN8vvHZVJfZ2UjfoOC1hS7U8dgydDpnwXWPG3Z
 KVKPhLqebfmRllhbj66PsU7MRJ0MA6C01kJ1uNo0VpBNMHDFWjksnk6joesUdAeLg94o
 8DWm9RaNOF0kKvdzaOGdAbgJGAVRkvQey/hZo8Xq3kMC+AYT1hayxKGLfKPk03C3pgXo
 G36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pu6Zr2Jo68blbhpXwzl9uRs7KbDV3skHPD8u3gz3sVI=;
 b=eooYPWH2DhXKu7tZx6MyPo0zRyLbJl9QdhoYAm5uz5RZ19LWh7lHYuPY9aF0GGwY8N
 jGdB9N3DIa7lKuQFdCwYtx9eNjdP7w2JnwK3zbltjL/BeMsIusBK+V5SNWUDTiA8tp4K
 Zl1fdt7HGO+UQAbSTw8OjfVhl1yuJ5iYejWA4PIj2FKitx/VCMjbfG1m11+EKRaB3lRP
 CZX9FIS2VrrwCo6dQ4EXR03ES5wHh6W20T11N8GsFrZ3/hrXACmfw2hRZgd1jX37iSmc
 iWbpk11+OLoC3p1yoOEKMrqTSGfm69a7ewNVxn6bMBCaOK3t3xa9SpsgjZYTxlMoBilL
 +lBw==
X-Gm-Message-State: AOAM530UMDwAfx2R7rW4SxFRXn8ObffX8Dj7Mc7HsmHEGfRhjlDQz5mj
 gOQpHMaT/l+rvU3yUBNCmQrGj2oBcSxHhhyaEF2bBw==
X-Google-Smtp-Source: ABdhPJwt8xWKLlXxiJG8fjcBaxoKGZnK9ey4WRGE+AXDo7swV/wzVlPEyFF7MT2HJelv6cWoDDRUCoFqXQlbsX91d4E=
X-Received: by 2002:a4a:7353:: with SMTP id e19mr9268056oof.55.1611489161343; 
 Sun, 24 Jan 2021 03:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <20210112194143.1494-4-yuri.benditovich@daynix.com>
 <CAOEp5Ocz-xGq5=e=WY0aipEYHEhN-wxekNaAiqAS+HsOF8TcDQ@mail.gmail.com>
 <CAOEp5OevYR5FWVMfQ_esmWTKtz9_ddTupbe7FtBFQ=sv2kEt2w@mail.gmail.com>
 <CAADnVQJLN0sFyKdAmc6Pikv8Ww9OocnK_VXMG=ZLSMONHkqe4Q@mail.gmail.com>
In-Reply-To: <CAADnVQJLN0sFyKdAmc6Pikv8Ww9OocnK_VXMG=ZLSMONHkqe4Q@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Sun, 24 Jan 2021 13:52:29 +0200
Message-ID: <CAOEp5OeV0y5-vw3Kufe_=rszOu8QPsHPrFjtn-fAM_TJtBTuhA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] tun: allow use of BPF_PROG_TYPE_SCHED_CLS program
 type
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Yan Vugenfirer <yan@daynix.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, decui@microsoft.com,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
 Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Marco Elver <elver@google.com>, KP Singh <kpsingh@kernel.org>, cai@lca.pw,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemb@google.com>,
 Network Development <netdev@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <kafai@fb.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jan 20, 2021 at 8:45 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 12, 2021 at 12:55 PM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > On Tue, Jan 12, 2021 at 10:40 PM Yuri Benditovich
> > <yuri.benditovich@daynix.com> wrote:
> > >
> > > On Tue, Jan 12, 2021 at 9:42 PM Yuri Benditovich
> > > <yuri.benditovich@daynix.com> wrote:
> > > >
> > > > This program type can set skb hash value. It will be useful
> > > > when the tun will support hash reporting feature if virtio-net.
> > > >
> > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > ---
> > > >  drivers/net/tun.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > index 7959b5c2d11f..455f7afc1f36 100644
> > > > --- a/drivers/net/tun.c
> > > > +++ b/drivers/net/tun.c
> > > > @@ -2981,6 +2981,8 @@ static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
> > > >                 prog = NULL;
> > > >         } else {
> > > >                 prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
> > > > +               if (IS_ERR(prog))
> > > > +                       prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SCHED_CLS);
> > > >                 if (IS_ERR(prog))
> > > >                         return PTR_ERR(prog);
> > > >         }
> > >
> > > Comment from Alexei Starovoitov:
> > > Patches 1 and 2 are missing for me, so I couldn't review properly,
> > > but this diff looks odd.
> > > It allows sched_cls prog type to attach to tun.
> > > That means everything that sched_cls progs can do will be done from tun hook?
> >
> > We do not have an intention to modify the packet in this steering eBPF.
>
> The intent is irrelevant. Using SCHED_CLS here will let users modify the packet
> and some users will do so. Hence the tun code has to support it.
>
> > There is just one function that unavailable for BPF_PROG_TYPE_SOCKET_FILTER
> > that the eBPF needs to make possible to deliver the hash to the guest
> > VM - it is 'bpf_set_hash'
> >
> > Does it mean that we need to define a new eBPF type for socket filter
> > operations + set_hash?
> >
> > Our problem is that the eBPF calculates 32-bit hash, 16-bit queue
> > index and 8-bit of hash type.
> > But it is able to return only 32-bit integer, so in this set of
> > patches the eBPF returns
> > queue index and hash type and saves the hash in skb->hash using bpf_set_hash().
>
> bpf prog can only return a 32-bit integer. That's true.
> But the prog can use helpers to set any number of bits and variables.
> bpf_set_hash_v2() with hash, queue and index arguments could fit this purpose,
> but if you allow it for SCHED_CLS type,

Do I understand correctly that this means:
1. Creation of new helper like
https://lists.linuxfoundation.org/pipermail/bridge/2020-July/013036.html
2. Validation on tun side that the BPF uses only limited subset of
helpers available for SCHED_CLS

> tc side of the code should be ready to deal with that too and this extended
> helper should be meaningful for both tc and tun.
>
> In general if the purpose of the prog is to compute three values they better be
> grouped together. Returned two of them via ORed 32-bit integer and
> returning 32-bit via bpf_set_hash is an awkward api.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
