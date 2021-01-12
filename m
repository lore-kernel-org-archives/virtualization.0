Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DBCC433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:33:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B3123122
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B3123122
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D4F6D86F72;
	Tue, 12 Jan 2021 20:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5SUAAPnz87aY; Tue, 12 Jan 2021 20:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1A7B185DE0;
	Tue, 12 Jan 2021 20:33:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0C6BC0893;
	Tue, 12 Jan 2021 20:33:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 855E2C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5EDCA20408
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:33:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lMkcHGZhFIpI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:33:22 +0000 (UTC)
X-Greylist: delayed 00:43:45 by SQLgrey-1.7.6
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by silver.osuosl.org (Postfix) with ESMTPS id 3E79620010
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:33:22 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id x13so3755337oic.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 12:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KdKAiHHOV0gEOUCHTem1lXmPy7p7WSVRP8s4VyMJD7g=;
 b=XzdHAZtBLN8jEbpfBFRWzK2HBZHiOO4C9a171JtLYJzvgwtm5uUvQhkGV6EQDILv7m
 Qea0KfqrqImYYanIVbA0Zv9Afk/EzyUJss9gS9beRgEOOo7K5TeItUwEISEWfbq8xBWF
 jKvYrpNxTSSxLeVUN+c1aOhyP4jhRc+xVA6IAJ4YBZxfDPzbuXWGDmoNwetn5Cm2CX0X
 /fn+OQBB4+a2Jq8QWNnbkpzLJWRJo2WBhbjkR1wFfrMkM0kxwu+OP4BJAbDnLEBCtF4k
 pZvgmkIu56Q5jQcLR36V9SsmR1S4KgCvZyThObq7/0a+u6Fz4cffzjiKnYyHoXUA7PJh
 3YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KdKAiHHOV0gEOUCHTem1lXmPy7p7WSVRP8s4VyMJD7g=;
 b=t94X1pKTXU/Q+mTDZaPYrBNzFMNkgtPwan4x6uv0Us3KvrDXq2vaK78Df6gTe/4AET
 2wSA66fByI5cGYtUmsVwv47aPRdoxrVeByFs82nwblyeBSQgDEhpKppjIg9VC6fKwwMp
 4e+DTH+ctbK44N8m1WLLnt1NP4tSBmmws4E52WLnTkjuQ+AUt58DerbJ7/+CwseZ0Pfn
 auvwdksNIvOb0fiBP2aoeiGIZpJ/5e0xVoPcCCtCpJkWTV+TbVcX9W5/3Y3XVkzNfzuk
 xKMivcOU2g9Bch13gB/lPm+depWGxYLX4JvwfkBvuH/Z3ZZqqd5PUy6ksZbXrOVppvYm
 W1xA==
X-Gm-Message-State: AOAM531dHLcfM0DJO3giaysqwT2MO7yv267CX3iLzibuRMXfRoUj8r8I
 FtyHVN/yum0XpBdNxw0FN16BgeUOFu61FURgILmTeQ==
X-Google-Smtp-Source: ABdhPJxkWjYpBEyulD2m3Ij8CK3ZsGgrRo312GFNR95pqEC5fG4bVq8NKft/CBnSXWToT/VzmMXndNmfgHNU8eR/aPg=
X-Received: by 2002:a05:6808:49a:: with SMTP id
 z26mr570751oid.137.1610483601498; 
 Tue, 12 Jan 2021 12:33:21 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <20210112194143.1494-4-yuri.benditovich@daynix.com>
 <CAADnVQ++1_voT2fZ021ExcON0KfHtA8MyHc-WYe-XXJoPTD6ig@mail.gmail.com>
In-Reply-To: <CAADnVQ++1_voT2fZ021ExcON0KfHtA8MyHc-WYe-XXJoPTD6ig@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 12 Jan 2021 22:33:09 +0200
Message-ID: <CAOEp5Oca3-Dvm2=nV3ZKsx3Ltgrt1Sm5gzvoG+8LD+yURtJ8bg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] tun: allow use of BPF_PROG_TYPE_SCHED_CLS program
 type
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
 Randy Dunlap <rdunlap@infradead.org>, gustavoars@kernel.org,
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

On Tue, Jan 12, 2021 at 9:46 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 12, 2021 at 11:42 AM Yuri Benditovich
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
>
> You've ignored the feedback and just resend? what for?

No, I do not. Some patches did not reach relevant people at all, so I
just resent _all_ the patches to all the people.
I will copy your earlier comment to this patch and will address it in
the discussion.
Sorry for misunderstanding and some redundant noise.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
