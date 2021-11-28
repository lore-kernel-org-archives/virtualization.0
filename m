Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAE7C433F5
	for <virtualization@archiver.kernel.org>; Sun, 28 Nov 2021 22:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EF6A403E6;
	Sun, 28 Nov 2021 22:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IXD79S-VCPQv; Sun, 28 Nov 2021 22:23:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F023640434;
	Sun, 28 Nov 2021 22:23:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDB92C0012;
	Sun, 28 Nov 2021 22:23:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2BF0C000A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 22:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C953140434
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 22:23:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b6gPGiRcCy44
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 22:23:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99A09403E6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 22:23:53 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id q25so30972236oiw.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 14:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=M5rtFSgsWKzafi8Cs4A/snez2F9siOW7EyMGKMlf5GI=;
 b=hq9071HUdLZ2TaOnDWMrUmkEjmGHPPdTYkA47Un8OgZrB6yRF/DDW8F2TRjD1Te19u
 iwz7IofjNHmeoxPcYl7UCdDln5AfF+oBejaZnHIFQwTg+gm1U9+1Rb0P0GWb/NR69e4e
 HeUhV/KFKLd9XUXKFJVmgeC4J0r5TQnv1NJ+2Bx+oe5ZCTpFo0EJ7t29VyUgLvsKBoqI
 /u1OO+yD8J5oRDDhs/6UAFhdL1gR7NeF9utMME7xbGZnk7Dwf0OIocm2klvolQJMDSs2
 1QegL3fy+FKj/LJwCCf6vQ7+wg9TQOQVwwqfaZxdwTR7sSWQu8DzfoZ1VoZlEQJGdoFg
 yLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=M5rtFSgsWKzafi8Cs4A/snez2F9siOW7EyMGKMlf5GI=;
 b=fn9smQpbTpFGm/m6YFmBDdZlAhcR1a8zTiYxDH118gb+ixnkvDYixiKAmb7aTOjUEn
 l2LV10Ms9hVObluubNOua6s6UPJgJrY9y0pjhF96Nx404pf9r12PbSAB5fa/vC+MBpk3
 Da0vtppEeeiV8XpaaVLSbGoqDExB+r6sq4lTWGbjAGpg9Lz+jLduypfjefNAysQ3dP8T
 E8HVONdhOF9YHQl7GjQZNz/3+px/r5ft2U3vdK5NFntUDz5mGt1YODSGHXWhpwk/JsGK
 vHT4fiaCyAx4lXvBUoEpLACibheFNpw/iJdE0bXQP2L+rdfq1tECI7TlIk0Pbi5jCxA7
 xCCQ==
X-Gm-Message-State: AOAM532vaMHJEpslGi77OVNfQ1+v5HPsWE2fXKZYZ8X/9gqjHpFw0/Z6
 4yX4uHPUtQslUAROw3Rabl0=
X-Google-Smtp-Source: ABdhPJzDpxaefKBU6oCHFFQgwoEO9P28FUz/LwlZRp8iIlHj4Qp+gFDBjfKDrMFg6OvgX+VjCyPvHw==
X-Received: by 2002:a54:4614:: with SMTP id p20mr38321110oip.39.1638138232614; 
 Sun, 28 Nov 2021 14:23:52 -0800 (PST)
Received: from [172.16.0.2] ([8.48.134.30])
 by smtp.googlemail.com with ESMTPSA id l9sm2021123oom.4.2021.11.28.14.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Nov 2021 14:23:52 -0800 (PST)
Message-ID: <2b9c3c1f-159f-f7c0-d4cb-1159e17e0dd4@gmail.com>
Date: Sun, 28 Nov 2021 15:23:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH v2 net-next 00/26] net: introduce and use generic XDP stats
Content-Language: en-US
To: Alexander Lobakin <alexandr.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20211123163955.154512-1-alexandr.lobakin@intel.com>
Cc: Song Liu <songliubraving@fb.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrei Vagin <avagin@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Noam Dagan <ndagan@amazon.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Arthur Kiyanovski <akiyano@amazon.com>,
 Cong Wang <cong.wang@bytedance.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, KP Singh <kpsingh@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Yonghong Song <yhs@fb.com>, Shay Agroskin <shayagr@amazon.com>,
 Marcin Wojtas <mw@semihalf.com>, Leon Romanovsky <leon@kernel.org>,
 David Arinzon <darinzon@amazon.com>, David Ahern <dsahern@kernel.org>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Edward Cree <ecree.xilinx@gmail.com>, Yajun Deng <yajun.deng@linux.dev>,
 netdev@vger.kernel.org, Saeed Bishara <saeedb@amazon.com>,
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

On 11/23/21 9:39 AM, Alexander Lobakin wrote:
> This is an almost complete rework of [0].
> 
> This series introduces generic XDP statistics infra based on rtnl
> xstats (Ethtool standard stats previously), and wires up the drivers
> which collect appropriate statistics to this new interface. Finally,
> it introduces XDP/XSK statistics to all XDP-capable Intel drivers.
> 
> Those counters are:
> * packets: number of frames passed to bpf_prog_run_xdp().
> * bytes: number of bytes went through bpf_prog_run_xdp().
> * errors: number of general XDP errors, if driver has one unified
>   counter.
> * aborted: number of XDP_ABORTED returns.
> * drop: number of XDP_DROP returns.
> * invalid: number of returns of unallowed values (i.e. not XDP_*).
> * pass: number of XDP_PASS returns.
> * redirect: number of successfully performed XDP_REDIRECT requests.
> * redirect_errors: number of failed XDP_REDIRECT requests.
> * tx: number of successfully performed XDP_TX requests.
> * tx_errors: number of failed XDP_TX requests.
> * xmit_packets: number of successfully transmitted XDP/XSK frames.
> * xmit_bytes: number of successfully transmitted XDP/XSK frames.
> * xmit_errors: of XDP/XSK frames failed to transmit.
> * xmit_full: number of XDP/XSK queue being full at the moment of
>   transmission.
> 
> To provide them, developers need to implement .ndo_get_xdp_stats()
> and, if they want to expose stats on a per-channel basis,
> .ndo_get_xdp_stats_nch(). include/net/xdp.h contains some helper

Why the tie to a channel? There are Rx queues and Tx queues and no
requirement to link them into a channel. It would be better (more
flexible) to allow them to be independent. Rather than ask the driver
"how many channels", ask 'how many Rx queues' and 'how many Tx queues'
for which xdp stats are reported.

From there, allow queue numbers or queue id's to be non-consecutive and
add a queue id or number as an attribute. e.g.,

[XDP stats]
	[ Rx queue N]
		counters


	[ Tx queue N]
		counters

This would allow a follow on patch set to do something like "Give me XDP
stats for Rx queue N" instead of doing a full dump.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
