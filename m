Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA8FC433E0
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:55:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542CA2311A
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542CA2311A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B015F86FA1;
	Tue, 12 Jan 2021 20:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UGHahT0q4Yfk; Tue, 12 Jan 2021 20:55:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 02D9B86CD3;
	Tue, 12 Jan 2021 20:55:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD37CC0893;
	Tue, 12 Jan 2021 20:55:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC1C1C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C2B9485797
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t39MqE7HWi-z
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:55:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5FCB385792
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:55:20 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id x13so3639421oto.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 12:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uD2LwoNsLHO2bQTapcwBrSqoHTZzd1YmNCw2S92ag9Q=;
 b=Y43uZ7bLVKMqH9GbZ4BYcx2lvxcJ2i103HsmZiv7+g4ZppufN2r5P61wpRmKjQtDm+
 6Iw5P4Q3jCWLRJntB2VAsKmOyFWepWSPdDNfMwp7rBHOArihxsXGpviAmbLDbLReNp5T
 1GsQFLXpkPd3O8YBg1d9ys2pl+Y2iRrBcQPXibs/a8PG64RIBsakJm4UbXN4O3AmUBMB
 LcWcVtFHbgPEspus3oJa8xqqPKE6R8KJiuW56r+SCcE5YMmlzY88EwbtWXVIvz2bjoYL
 9avkyk50tPvH0NmYp6atvBDNCPwlyY5Wzt+QY/5vlJHqedpwjVB5eQYvs1hgfE8jwBFg
 z4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uD2LwoNsLHO2bQTapcwBrSqoHTZzd1YmNCw2S92ag9Q=;
 b=HI0l8oFWzGybWo19cEyhyUb9BR6/LYPNsiaOc7Wr1MA3f97vzaVbHCptb6Dp697FrW
 iqa6zKkK4vjX9SbIWBin7eAtqUXGrzRMTNSwIiOMyp27IxeUvzFdkJu8pFQpkwcpnsbX
 Q74cLmmFW0oSsMwlZniwthS5Ls2Z98+1q8QJqeZCzOZSw1uDXxsa99241HTXzmegGQ0E
 3oSlZpCSJP8wSboSNFEYEn+zP8Gxj/GJ3EpGqJZWkwA3eFh++g0GZ4pp/Ywc8D73JyaO
 aOLVZuH3+72BskTbc7sE8y+lgNY4y0ObWZtcafmmzJCa/AG79gJSznIQ+nYe48zMXtgi
 /bIA==
X-Gm-Message-State: AOAM530rgctYGwUtq6gYintn2rgABb71RK2RixEHqsuypTFt4Klewe5U
 3rkIS1zSSejw+gP9p3WnTtvwFh0620b5OfOg7WvP3g==
X-Google-Smtp-Source: ABdhPJyg8eUeNmxDa4BkruWI0L3XjU5KjUa3gveljnrKGwGHBS2TJW6ZNkMgbXD0kYdCRDnkUgmQJ6NHb8T8kPmTb+c=
X-Received: by 2002:a05:6830:572:: with SMTP id
 f18mr874911otc.109.1610484919603; 
 Tue, 12 Jan 2021 12:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <20210112194143.1494-4-yuri.benditovich@daynix.com>
 <CAOEp5Ocz-xGq5=e=WY0aipEYHEhN-wxekNaAiqAS+HsOF8TcDQ@mail.gmail.com>
In-Reply-To: <CAOEp5Ocz-xGq5=e=WY0aipEYHEhN-wxekNaAiqAS+HsOF8TcDQ@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 12 Jan 2021 22:55:07 +0200
Message-ID: <CAOEp5OevYR5FWVMfQ_esmWTKtz9_ddTupbe7FtBFQ=sv2kEt2w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] tun: allow use of BPF_PROG_TYPE_SCHED_CLS program
 type
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, 
 rdunlap@infradead.org, willemb@google.com, gustavoars@kernel.org, 
 herbert@gondor.apana.org.au, steffen.klassert@secunet.com, 
 pablo@netfilter.org, decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com, 
 elver@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Cc: Yan Vugenfirer <yan@daynix.com>
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

On Tue, Jan 12, 2021 at 10:40 PM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Tue, Jan 12, 2021 at 9:42 PM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > This program type can set skb hash value. It will be useful
> > when the tun will support hash reporting feature if virtio-net.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  drivers/net/tun.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 7959b5c2d11f..455f7afc1f36 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -2981,6 +2981,8 @@ static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
> >                 prog = NULL;
> >         } else {
> >                 prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
> > +               if (IS_ERR(prog))
> > +                       prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SCHED_CLS);
> >                 if (IS_ERR(prog))
> >                         return PTR_ERR(prog);
> >         }
>
> Comment from Alexei Starovoitov:
> Patches 1 and 2 are missing for me, so I couldn't review properly,
> but this diff looks odd.
> It allows sched_cls prog type to attach to tun.
> That means everything that sched_cls progs can do will be done from tun hook?

We do not have an intention to modify the packet in this steering eBPF.
There is just one function that unavailable for BPF_PROG_TYPE_SOCKET_FILTER
that the eBPF needs to make possible to deliver the hash to the guest
VM - it is 'bpf_set_hash'

Does it mean that we need to define a new eBPF type for socket filter
operations + set_hash?

Our problem is that the eBPF calculates 32-bit hash, 16-bit queue
index and 8-bit of hash type.
But it is able to return only 32-bit integer, so in this set of
patches the eBPF returns
queue index and hash type and saves the hash in skb->hash using bpf_set_hash().

If this is unacceptable, can you please recommend a better solution?

> sched_cls assumes l2 and can modify the packet.

The steering eBPF in TUN module also assumes l2.

> I think crashes are inevitable.
>
> > --
> > 2.17.1
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
