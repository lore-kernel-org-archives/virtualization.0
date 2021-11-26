Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CECC433F5
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 12:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D9848299D;
	Fri, 26 Nov 2021 12:30:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2HDoqIlCxwv; Fri, 26 Nov 2021 12:30:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0684282998;
	Fri, 26 Nov 2021 12:30:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0E4EC0012;
	Fri, 26 Nov 2021 12:30:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 603DCC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 12:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DD7382410
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 12:30:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id laofLX2i98mU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 12:30:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D14F82404
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637929823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJpjstKjFgGO5wW+gqXS3RJS7pxbzNnoYG45SxgIaVs=;
 b=DqtQb3REG6A8Wqip2hMPUaSUcAfVeM6IEdjUHM4WIYzL1YNWvSL8q28BdizRGtlHjo6+RT
 Af1gCnqZlcclntPKpr03yHw+3n4XhetD0AbRMcpcZr9mEWU85wWRIROzZi3JrpRXq9ZFbF
 6R2XTR36BdCajUBUMrw5hraEVZ0aa8o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-qQwkWFN5NiuEouxim2U8hA-1; Fri, 26 Nov 2021 07:30:22 -0500
X-MC-Unique: qQwkWFN5NiuEouxim2U8hA-1
Received: by mail-ed1-f69.google.com with SMTP id
 b15-20020aa7c6cf000000b003e7cf0f73daso7868496eds.22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 04:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=wJpjstKjFgGO5wW+gqXS3RJS7pxbzNnoYG45SxgIaVs=;
 b=xSwSZJRevglWr9bRRI+WLhq3aRCL0JgZWDTZ0at5K1FzlJbOn1r2GXeCpEv7+QP1hd
 lujLubQHrVh9g+fKcskjDCps31oDwQqaTjZJz1IC6ZsmDTfmORmVs/DKReZjz6vzp6wW
 X+GDyFZYgK3V2p4mkxAteYyFYWvEvD1jqbkh7qmMg2awEBrHTQVOuuM2fjs4pnWwiGiP
 xFL/qzYdCEdDBc6gm9tfySGyGXWlf29F4UdPZnaBCWL5AonmxszWai2ZsrnP2OgQbizo
 1eFdEcJNqdvGfq/SaLcSfKh64u40z0AubQEJND/E3pMI+G3o7/+ZF1bb9cZXacWvVsrs
 +lqA==
X-Gm-Message-State: AOAM532KTozlNm8xq7pnqsqt4ZVCCZ/qpRa5KDux/FGNEn5duMx7H/F8
 uCkIG9jviSkgOK7b7EcGj3EaVBdEYwyWT87nsqCtHLpnyCJldsZS3GarEMRyn2JS6QdqSVQUDMT
 djE+TfVMx/K59z2L7esvUG/hjmqnCix7OpYsLn/ytKA==
X-Received: by 2002:a17:906:9253:: with SMTP id
 c19mr38089912ejx.63.1637929818656; 
 Fri, 26 Nov 2021 04:30:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFpOGQFmWiCNvf6rQhtfEjSpRvn9st0kQKBRiIz3dQouSyrrzQoU3PWI7Fk46YpVzPcL/lig==
X-Received: by 2002:a17:906:9253:: with SMTP id
 c19mr38089763ejx.63.1637929817373; 
 Fri, 26 Nov 2021 04:30:17 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
 by smtp.gmail.com with ESMTPSA id l18sm2825795ejo.114.2021.11.26.04.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Nov 2021 04:30:16 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
 id 0A5011802A0; Fri, 26 Nov 2021 13:30:16 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <alexandr.lobakin@intel.com>, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH v2 net-next 21/26] ice: add XDP and XSK generic
 per-channel statistics
In-Reply-To: <20211125204007.133064-1-alexandr.lobakin@intel.com>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211123163955.154512-22-alexandr.lobakin@intel.com>
 <77407c26-4e32-232c-58e0-2d601d781f84@iogearbox.net>
 <87bl28bga6.fsf@toke.dk>
 <20211125170708.127323-1-alexandr.lobakin@intel.com>
 <20211125094440.6c402d63@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211125204007.133064-1-alexandr.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 26 Nov 2021 13:30:16 +0100
Message-ID: <87sfvj9k13.fsf@toke.dk>
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
 Ioana Ciornei <ioana.ciornei@nxp.com>, Arthur Kiyanovski <akiyano@amazon.com>,
 Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Noam Dagan <ndagan@amazon.com>,
 Cong Wang <cong.wang@bytedance.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, KP Singh <kpsingh@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>, Yonghong Song <yhs@fb.com>,
 Shay Agroskin <shayagr@amazon.com>, Marcin Wojtas <mw@semihalf.com>,
 Daniel Borkmann <daniel@iogearbox.net>, David Arinzon <darinzon@amazon.com>,
 David Ahern <dsahern@kernel.org>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Yajun Deng <yajun.deng@linux.dev>,
 netdev@vger.kernel.org, Saeed Bishara <saeedb@amazon.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, bpf@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
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

> From: Jakub Kicinski <kuba@kernel.org>
> Date: Thu, 25 Nov 2021 09:44:40 -0800
>
>> On Thu, 25 Nov 2021 18:07:08 +0100 Alexander Lobakin wrote:
>> > > This I agree with, and while I can see the layering argument for putting
>> > > them into 'ip' and rtnetlink instead of ethtool, I also worry that these
>> > > counters will simply be lost in obscurity, so I do wonder if it wouldn't
>> > > be better to accept the "layering violation" and keeping them all in the
>> > > 'ethtool -S' output?  
>> > 
>> > I don't think we should harm the code and the logics in favor of
>> > 'some of the users can face something'. We don't control anything
>> > related to XDP using Ethtool at all, but there is some XDP-related
>> > stuff inside iproute2 code, so for me it's even more intuitive to
>> > have them there.
>> > Jakub, may be you'd like to add something at this point?
>> 
>> TBH I wasn't following this thread too closely since I saw Daniel
>> nacked it already. I do prefer rtnl xstats, I'd just report them 
>> in -s if they are non-zero. But doesn't sound like we have an agreement
>> whether they should exist or not.
>
> Right, just -s is fine, if we drop the per-channel approach.

I agree that adding them to -s is fine (and that resolves my "no one
will find them" complain as well). If it crowds the output we could also
default to only output'ing a subset, and have the more detailed
statistics hidden behind a verbose switch (or even just in the JSON
output)?

>> Can we think of an approach which would make cloudflare and cilium
>> happy? Feels like we're trying to make the slightly hypothetical 
>> admin happy while ignoring objections of very real users.
>
> The initial idea was to only uniform the drivers. But in general
> you are right, 10 drivers having something doesn't mean it's
> something good.

I don't think it's accurate to call the admin use case "hypothetical".
We're expending a significant effort explaining to people that XDP can
"eat" your packets, and not having any standard statistics makes this
way harder. We should absolutely cater to our "early adopters", but if
we want XDP to see wider adoption, making it "less weird" is critical!

> Maciej, I think you were talking about Cilium asking for those stats
> in Intel drivers? Could you maybe provide their exact usecases/needs
> so I'll orient myself? I certainly remember about XSK Tx packets and
> bytes.
> And speaking of XSK Tx, we have per-socket stats, isn't that enough?

IMO, as long as the packets are accounted for in the regular XDP stats,
having a whole separate set of stats only for XSK is less important.

>> Please leave the per-channel stats out. They make a precedent for
>> channel stats which should be an attribute of a channel. Working for 
>> a large XDP user for a couple of years now I can tell you from my own
>> experience I've not once found them useful. In fact per-queue stats are
>> a major PITA as they crowd the output.
>
> Oh okay. My very first iterations were without this, but then I
> found most of the drivers expose their XDP stats per-channel. Since
> I didn't plan to degrade the functionality, they went that way.

I personally find the per-channel stats quite useful. One of the primary
reasons for not achieving full performance with XDP is broken
configuration of packet steering to CPUs, and having per-channel stats
is a nice way of seeing this. I can see the point about them being way
too verbose in the default output, though, and I do generally filter the
output as well when viewing them. But see my point above about only
printing a subset of the stats by default; per-channel stats could be
JSON-only, for instance?

-Toke

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
