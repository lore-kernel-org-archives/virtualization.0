Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31427C433EF
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 16:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C83AD605CE;
	Tue, 30 Nov 2021 16:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WGOcblxu5H7R; Tue, 30 Nov 2021 16:17:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 60311605C5;
	Tue, 30 Nov 2021 16:17:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D96FC0012;
	Tue, 30 Nov 2021 16:17:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27DE7C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 16:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01477605CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 16:17:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vO-Bug8Cg8C8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 16:17:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0B9C605C5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638289049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bh2xH2WYNc1n+eZ6WtfnZ4QpRuO9aH5y18ufnjGl1cA=;
 b=N1jTE+/R0rhhw2cAe8Q7hFcuv1pxTQwMq+OXkpyc/eTCG9rxbitHH4iyZlIiyRWznVLmA1
 soUtq2HISlAKvh3Z7HR7kFGG3lJ75SY6FTqiYH79Pr9tPcfrckFsqvgw/uZ5LF6q1crxkR
 oWFym05dj7kIXwaObPNLOgRHu+2rSJg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-1bzRF-bCOwusbw-IXAy4aA-1; Tue, 30 Nov 2021 11:17:27 -0500
X-MC-Unique: 1bzRF-bCOwusbw-IXAy4aA-1
Received: by mail-ed1-f70.google.com with SMTP id
 y9-20020aa7c249000000b003e7bf7a1579so17376450edo.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 08:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=Bh2xH2WYNc1n+eZ6WtfnZ4QpRuO9aH5y18ufnjGl1cA=;
 b=F569Fx4gIsLYWG7sx9uEBtSnkO2CvZHBx+TKrVASoXSy0VlZlawmx/Rc7im1BjgeRt
 DY0faP7+vOXCZ2qSwmYYaK86BzorZnnWX0pqJFsrg8Udh0oWVgz4UIjw1Xm0BgnfeBG7
 jd1ru6dkwV1qEdqje/H4HZblrEijQ9+6k7zIfPQhjr2WcbqVjGYC0Kr4atQnF9XN6sAx
 t2OJjCaQsVAdg5nfICVQTJzYeJySyD3KwJdZgMUob9sLLKVQe3Z/E6LjTIKfUKwrupKy
 SL6+aVY0sW+adY2FXuc01E0mjZuUBeNtiO1srmlzPB3grZpo4DjBIV/ovX3tR4Hbr60/
 aGhw==
X-Gm-Message-State: AOAM533pc7Xv3SetiblIsM03ae8RQaXV6Xmi76vGcNMny4bZTEqT66Cs
 8aL+3ibqEisPA/J3Ob9Cun6Ar2w1IMI/+vZf07RYFnj4qgTu3pPdTW+BLOdr4G6mrD2hs8woXh6
 Ue/uwRL7RiCX5sN9xRjJa0doF2DGzKKD1waziK5VsZg==
X-Received: by 2002:a17:906:d54d:: with SMTP id
 cr13mr22673ejc.409.1638289045917; 
 Tue, 30 Nov 2021 08:17:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm7jXoK2TvSroiJ5tHiLFjrswRyG0q/IaZ6d4NOHuATUVkXigtSnHPZVM/QNjl22FRlNuJYA==
X-Received: by 2002:a17:906:d54d:: with SMTP id
 cr13mr22591ejc.409.1638289045383; 
 Tue, 30 Nov 2021 08:17:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
 by smtp.gmail.com with ESMTPSA id u23sm11967828edi.88.2021.11.30.08.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Nov 2021 08:17:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
 id 39B381802A0; Tue, 30 Nov 2021 17:17:24 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <alexandr.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 net-next 00/26] net: introduce and use generic XDP stats
In-Reply-To: <20211130155612.594688-1-alexandr.lobakin@intel.com>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211130155612.594688-1-alexandr.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 30 Nov 2021 17:17:24 +0100
Message-ID: <871r2x8vor.fsf@toke.dk>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=toke@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Song Liu <songliubraving@fb.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Andrei Vagin <avagin@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Noam Dagan <ndagan@amazon.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Cong Wang <cong.wang@bytedance.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, KP Singh <kpsingh@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>, Yonghong Song <yhs@fb.com>,
 Shay Agroskin <shayagr@amazon.com>, Marcin Wojtas <mw@semihalf.com>,
 Leon Romanovsky <leon@kernel.org>, David Arinzon <darinzon@amazon.com>,
 David Ahern <dsahern@kernel.org>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Edward Cree <ecree.xilinx@gmail.com>,
 Yajun Deng <yajun.deng@linux.dev>, netdev@vger.kernel.org,
 Saeed Bishara <saeedb@amazon.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, bpf@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Martin KaFai Lau <kafai@fb.com>
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

Alexander Lobakin <alexandr.lobakin@intel.com> writes:

> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Tue, 23 Nov 2021 17:39:29 +0100
>
> Ok, open questions:
>
> 1. Channels vs queues vs global.
>
> Jakub: no per-channel.
> David (Ahern): it's worth it to separate as Rx/Tx.
> Toke is fine with globals at the end I think?

Well, I don't like throwing data away, so in that sense I do like
per-queue stats, but it's not a very strong preference (i.e., I can live
with either)...

> My point was that for most of the systems we have 1:1 Rx:Tx
> (usually num_online_cpus()), so asking drivers separately for
> the number of RQs and then SQs would end up asking for the same
> number twice.
> But the main reason TBH was that most of the drivers store stats
> on a per-channel basis and I didn't want them to regress in
> functionality. I'm fine with reporting only netdev-wide if
> everyone are.
>
> In case if we keep per-channel: report per-channel only by request
> and cumulative globals by default to not flood the output?

... however if we do go with per-channel stats I do agree that they
shouldn't be in the default output. I guess netlink could still split
them out and iproute2 could just sum them before display?

> 2. Count all errors as "drops" vs separately.
>
> Daniel: account everything as drops, plus errors should be
> reported as exceptions for tracing sub.
> Jesper: we shouldn't mix drops and errors.
>
> My point: we shouldn't, that's why there are patches for 2 drivers
> to give errors a separate counter.
> I provided an option either to report all errors together ('errors'
> in stats structure) or to provide individual counters for each of
> them (sonamed ctrs), but personally prefer detailed errors. However,
> they might "go detailed" under trace_xdp_exception() only, sound
> fine (OTOH in RTNL stats we have both "general" errors and detailed
> error counters).

I agree it would be nice to have a separate error counter, but a single
counter is enough when combined with the tracepoints.

> 3. XDP and XSK ctrs separately or not.
>
> My PoV is that those are two quite different worlds.
> However, stats for actions on XSK really make a little sense since
> 99% of time we have xskmap redirect. So I think it'd be fine to just
> expand stats structure with xsk_{rx,tx}_{packets,bytes} and count
> the rest (actions, errors) together with XDP.

A whole set of separate counters for XSK is certainly overkill. No
strong preference as to whether they need a separate counter at all...

> Rest:
>  - don't create a separate `ip` command and report under `-s`;
>  - save some RTNL skb space by skipping zeroed counters.
>
> Also, regarding that I count all on the stack and then add to the
> storage once in a polling cycle -- most drivers don't do that and
> just increment the values in the storage directly, but this can be
> less performant for frequently updated stats (or it's just my
> embedded past).
> Re u64 vs u64_stats_t -- the latter is more universal and
> architecture-friendly, the former is used directly in most of the
> drivers primarily because those drivers and the corresponding HW
> are being run on 64-bit systems in the vast majority of cases, and
> Ethtools stats themselves are not so critical to guard them with
> anti-tearing. Anyways, local64_t is cheap on ARM64/x86_64 I guess?

I'm generally a fan of correctness first, so since you're touching all
the drivers anyway why I'd say go for u64_stats_t :)

-Toke

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
