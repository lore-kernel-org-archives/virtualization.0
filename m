Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0177C433DB
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:20:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78249223DB
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78249223DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F69487000;
	Mon, 18 Jan 2021 15:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ALRT8px3cXcr; Mon, 18 Jan 2021 15:20:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3B33886FDA;
	Mon, 18 Jan 2021 15:20:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D815C08A1;
	Mon, 18 Jan 2021 15:20:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF8C1C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E18CB204A0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZfKk1GhITJo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:20:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by silver.osuosl.org (Postfix) with ESMTPS id B76062049E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:20:39 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id e15so11444668qte.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F6KA9w3XTyDzR9a/eJiRfa89v7fUgs4kNlqtUAh2eRs=;
 b=LIhPXBoQ0lqZVjwUYNyS926s6D2uM+E4QTstoVoyx4n/7hogHhwpwSIBj+IPlC8YRN
 h3oF2QH8WoW7n66iWRccB6P28cnjAoaZFh9Ihuo4M2y2hnwgm269UEf0c7HlVrmhnE+9
 KJYq1eh3iCo2cSAphPIo6nJjawFJTfFVbF/c7O13aAsmJxFnegxLSNNkU62oqpaWFTiB
 V89AL0U1zhHAjVLfhYgFjt5j4ESe5y8dRSW3qJC3WKQ7QQ4pcRzH5pRi6LJUi78Ft/Ka
 uIHf3k+LMjIxLol3HyKVPi8GWfs3cxxk1fX9BduFukj4m0ZBJOyjaKxOf48FB7EvZ4B5
 EK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F6KA9w3XTyDzR9a/eJiRfa89v7fUgs4kNlqtUAh2eRs=;
 b=BUZNkRNk6z3Gl72JOWBMBPSXQujizrvcxeMk5+M8/VEhk6m9q/q1TG/x78PZvJGkqK
 rVrILwwKgfyvU6XiqLC5V8LOFbss7hV5GVoBk0W1GOz1PDiNIyf1n3AG4s8b1Fpv6bBm
 iIclv9pGvAwRlp7h/FzxftjRZZKxUtF671sZmKIjdo5UJkwNHzS7GhGCOZVHE/jpqBIA
 UhLc6Bjc/9d+ufs4XkHAFXKW3HiOB6w1ZYmf8rHOgKav+7jz3yldf3+xGoOi/zhsVNqQ
 laW9dy5EJEvBXLPtiZHGlc7w+C2nUaj2foQNkylTK96QsYcTNY/Dj/gFJJKqh9s1yrbI
 aqGg==
X-Gm-Message-State: AOAM530w9Rqj+MHfogdj82Y6AbTVQA+u+lUj5JlvjfA4d8cBGgXMY/zg
 LqNW7iky7bDPgRKaCjZmQ3XomRZbRvY=
X-Google-Smtp-Source: ABdhPJygpcMeTQ3gcDE+87binYnvhhL1/jqueWPmfCgltKnIcCBYOmxitWQCEr6n42u1XWMeMWUvSw==
X-Received: by 2002:aed:2c66:: with SMTP id f93mr134574qtd.14.1610983238109;
 Mon, 18 Jan 2021 07:20:38 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com.
 [209.85.219.170])
 by smtp.gmail.com with ESMTPSA id z20sm10688523qkz.37.2021.01.18.07.20.36
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Jan 2021 07:20:37 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id i141so5480482yba.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 07:20:36 -0800 (PST)
X-Received: by 2002:ab0:7386:: with SMTP id l6mr17924882uap.141.1610983234282; 
 Mon, 18 Jan 2021 07:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <CAOEp5OejaX4ZETThrj4-n8_yZoeTZs56CBPHbQqNsR2oni8dWw@mail.gmail.com>
 <CAOEp5Oc5qif_krU8oC6qhq6X0xRW-9GpWrBzWgPw0WevyhT8Mg@mail.gmail.com>
 <CA+FuTSfhBZfEf8+LKNUJQpSxt8c5h1wMpARupekqFKuei6YBsA@mail.gmail.com>
 <78bbc518-4b73-4629-68fb-2713250f8967@redhat.com>
 <CA+FuTSfJJhEYr6gXmjpjjXzg6Xm5wWa-dL1SEV-Zt7RcPXGztg@mail.gmail.com>
 <8ea218a8-a068-1ed9-929d-67ad30111c3c@redhat.com>
 <CAOEp5OfyHz2rXHmOeojNNE2wvrHMn_z1egr5aGQborEq829TLw@mail.gmail.com>
 <65fe1a40-abc0-77ed-56df-3f0a70615016@redhat.com>
 <CAOEp5Oe4TcOukJa+OGj-ynfMMrZC=_YQDpzSC9_9p+UXSH7hmg@mail.gmail.com>
In-Reply-To: <CAOEp5Oe4TcOukJa+OGj-ynfMMrZC=_YQDpzSC9_9p+UXSH7hmg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 18 Jan 2021 10:19:57 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfsFC0DTFhHDwT7dbtWXTmGOWjc=ozt8CgH_qDDn9gejg@mail.gmail.com>
Message-ID: <CA+FuTSfsFC0DTFhHDwT7dbtWXTmGOWjc=ozt8CgH_qDDn9gejg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Support for virtio-net hash reporting
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Song Liu <songliubraving@fb.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Yan Vugenfirer <yan@daynix.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, decui@microsoft.com,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
 Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Marco Elver <elver@google.com>, KP Singh <kpsingh@kernel.org>, cai@lca.pw,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Sitnicki <jakub@cloudflare.com>,
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

> > >>>>> What it does not give is a type indication, such as
> > >>>>> VIRTIO_NET_HASH_TYPE_TCPv6. I don't understand how this would be used.
> > >>>>> In datapaths where the NIC has already computed the four-tuple hash
> > >>>>> and stored it in skb->hash --the common case for servers--, That type
> > >>>>> field is the only reason to have to compute again.
> > >>>> The problem is there's no guarantee that the packet comes from the NIC,
> > >>>> it could be a simple VM2VM or host2VM packet.
> > >>>>
> > >>>> And even if the packet is coming from the NIC that calculates the hash
> > >>>> there's no guarantee that it's the has that guest want (guest may use
> > >>>> different RSS keys).
> > >>> Ah yes, of course.
> > >>>
> > >>> I would still revisit the need to store a detailed hash_type along with
> > >>> the hash, as as far I can tell that conveys no actionable information
> > >>> to the guest.
> > >>
> > >> Yes, need to figure out its usage. According to [1], it only mention
> > >> that storing has type is a charge of driver. Maybe Yuri can answer this.
> > >>
> > > For the case of Windows VM we can't know how exactly the network stack
> > > uses provided hash data (including hash type). But: different releases
> > > of Windows
> > > enable different hash types (for example UDP hash is enabled only on
> > > Server 2016 and up).
> > >
> > > Indeed the Windows requires a little more from the network adapter/driver
> > > than Linux does.
> > >
> > > The addition of RSS support to virtio specification takes in account
> > > the widest set of
> > > requirements (i.e. Windows one), our initial impression is that this
> > > should be enough also for Linux.
> > >
> > > The NDIS specification in part of RSS is _mandatory_ and there are
> > > certification tests
> > > that check that the driver provides the hash data as expected. All the
> > > high-performance
> > > network adapters have such RSS functionality in the hardware.

Thanks for the context.

If Windows requires the driver to pass the hash-type along with the
hash data, then indeed this will be needed.

If it only requires the device to support a subset of of the possible
types, chosen at init, that would be different and it would be cheaper
for the driver to pass this config to the device one time.

> > > With pre-RSS QEMU (i.e. where the virtio-net device does not indicate
> > > the RSS support)
> > > the virtio-net driver for Windows does all the job related to RSS:
> > > - hash calculation
> > > - hash/hash_type delivery
> > > - reporting each packet on the correct CPU according to RSS settings
> > >
> > > With RSS support in QEMU all the packets always come on a proper CPU and
> > > the driver never needs to reschedule them. The driver still need to
> > > calculate the
> > > hash and report it to Windows. In this case we do the same job twice: the device
> > > (QEMU or eBPF) does calculate the hash and get proper queue/CPU to deliver
> > > the packet. But the hash is not delivered by the device, so the driver needs to
> > > recalculate it and report to the Windows.
> > >
> > > If we add HASH_REPORT support (current set of patches) and the device
> > > indicates this
> > > feature we can avoid hash recalculation in the driver assuming we
> > > receive the correct hash
> > > value and hash type. Otherwise the driver can't know which exactly
> > > hash the device has calculated.
> > >
> > > Please let me know if I did not answer the question.
> >
> >
> > I think I get you. The hash type is also a kind of classification (e.g
> > TCP or UDP). Any possibility that it can be deduced from the driver? (Or
> > it could be too expensive to do that).
> >
> The driver does it today (when the device does not offer any features)
> and of course can continue doing it.
> IMO if the device can't report the data according to the spec it
> should not indicate support for the respective feature (or fallback to
> vhost=off).
> Again, IMO if Linux does not need the exact hash_type we can use (for
> Linux) the way that Willem de Brujin suggested in his patchset:
> - just add VIRTIO_NET_HASH_REPORT_L4 to the spec
> - Linux can use MQ + hash delivery (and use VIRTIO_NET_HASH_REPORT_L4)
> - Linux can use (if makes sense) RSS with VIRTIO_NET_HASH_REPORT_L4 and eBPF
> - Windows gets what it needs + eBPF
> So, everyone has what they need at the respective cost.
>
> Regarding use of skb->cb for hash type:
> Currently, if I'm not mistaken, there are 2 bytes at the end of skb->cb:
> skb->cb is 48 bytes array
> There is skb_gso_cb (14 bytes) at offset SKB_GSO_CB_OFFSET(32)
> Is it possible to use one of these 2 bytes for hash_type?
> If yes, shall we extend the skb_gso_cb and place the 1-bytes hash_type
> in it or just emit compilation error if the skb_gso_cb grows beyond 15
> bytes?

Good catch on segmentation taking place between .ndo_select_queue and
.ndo_start_xmit.

That also means that whatever field in the skb is used, has to be
copied to all segments in skb_segment. Which happens for cb. But this
feature is completely unrelated to the skb_gso_cb type. Perhaps
another field with a real type is more clear. For instance, an
extension to the union with napi_id and sender_cpu, as neither is used
in this egress path with .ndo_select_queue?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
