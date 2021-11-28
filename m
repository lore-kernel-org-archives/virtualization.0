Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E36CC433F5
	for <virtualization@archiver.kernel.org>; Sun, 28 Nov 2021 17:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CC1182A29;
	Sun, 28 Nov 2021 17:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Cj3sZ5mvFwP; Sun, 28 Nov 2021 17:55:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A32A58295A;
	Sun, 28 Nov 2021 17:55:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83F6EC001C;
	Sun, 28 Nov 2021 17:55:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 710A0C000A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 17:55:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51143409B7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 17:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=messagingengine.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mUB_IHdeRVBB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 17:55:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 415DD40995
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 17:55:01 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 5B9425802EE;
 Sun, 28 Nov 2021 12:54:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Sun, 28 Nov 2021 12:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=UUHBKcGQTfc55BryKks38P9q1VVkigTZnH+REkQ6S
 Co=; b=iYiN+YmWJhZj5r+gfNGtNnX5WxIBt9yrnzuHllXQ5/GUOrZwgE+2B6kqq
 v1LacLeZi5zTVMsNqmYhaoCVMmR7ErWb/6IMezfXpj4u51pcnQtnt5/PL1NDm5AK
 d9CZlDHePScIbPZ7dXxmGzpUDRkVmvPH5Em/yqEQ5o71cDbP6BJlajUs4CRXojAc
 LzDVEKJNK78Vz3a45eafY2sJ76R61tmWYjTYc4AtkcIHMr9qmajW5sqDYL0fpYei
 h6Pe7CTiBbD0MbI7zqJGjx+gCDQ2nW3O0Uo+4yN6QuRPMxk6JKI8Svoa6WW0kNuo
 tVzHESLM+PoWuo8LTnmU9cpdyMP3A==
X-ME-Sender: <xms:cMKjYWPd5DduNFfJjqZGpi_Wq71dAWE-J_wxpNXVNN7XTVtZ_QJQOw>
 <xme:cMKjYU9Rk6Tqx55hmFgiPLQKDLq2WNdabM2IbEvkxdvab2oCAl8BYbJpTf3_rCUOp
 53xpJsCz_pSqq8>
X-ME-Received: <xmr:cMKjYdTw-ttGcSarl-eU2ZcZwmqsKK1hsatFaqZGuF6YohTU7eyzmsq4leif>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrheeigddutdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtugfgjgesthekrodttddtudenucfhrhhomhepkfguohcu
 ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
 htvghrnhepieevhfevtdejhfethedvkefgudetudegudethfdtfeefleektdekkeefjeel
 tedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
 sehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:cMKjYWtuij49OVBZsOZ08kX7vOuYx2zKXpEQngCdpqkooYt8LbI4gQ>
 <xmx:cMKjYefpDNGR53rK7VKwO17_5hlV0ErgOrbjeks77FFLX_bPwm1JjA>
 <xmx:cMKjYa29fxDeX6UVEYihZVEcU-Ns9Ce4QLuSS0jmtGkEHd2vzlMc1w>
 <xmx:csKjYbWeDFzgpl2GEEg_ew_X8_3slLF376ZQh0yCCLJ9kVNpVD_Ylw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Nov 2021 12:54:55 -0500 (EST)
Date: Sun, 28 Nov 2021 19:54:53 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 net-next 21/26] ice: add XDP and XSK generic
 per-channel statistics
Message-ID: <YaPCbaMVaVlxXcHC@shredder>
References: <20211123163955.154512-22-alexandr.lobakin@intel.com>
 <77407c26-4e32-232c-58e0-2d601d781f84@iogearbox.net>
 <87bl28bga6.fsf@toke.dk>
 <20211125170708.127323-1-alexandr.lobakin@intel.com>
 <20211125094440.6c402d63@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211125204007.133064-1-alexandr.lobakin@intel.com>
 <87sfvj9k13.fsf@toke.dk>
 <20211126100611.514df099@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87ee72ah56.fsf@toke.dk>
 <20211126111431.4a2ed007@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211126111431.4a2ed007@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
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
 nikolay@nvidia.com, Cong Wang <cong.wang@bytedance.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, KP Singh <kpsingh@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>, Yonghong Song <yhs@fb.com>,
 Shay Agroskin <shayagr@amazon.com>, Marcin Wojtas <mw@semihalf.com>,
 petrm@nvidia.com, Daniel Borkmann <daniel@iogearbox.net>,
 David Arinzon <darinzon@amazon.com>, David Ahern <dsahern@kernel.org>,
 Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Yajun Deng <yajun.deng@linux.dev>, netdev@vger.kernel.org,
 Saeed Bishara <saeedb@amazon.com>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

+Petr, Nik

On Fri, Nov 26, 2021 at 11:14:31AM -0800, Jakub Kicinski wrote:
> On Fri, 26 Nov 2021 19:47:17 +0100 Toke H=F8iland-J=F8rgensen wrote:
> > > Fair. In all honesty I said that hoping to push for a more flexible
> > > approach hidden entirely in BPF, and not involving driver changes.
> > > Assuming the XDP program has more fine grained stats we should be able
> > > to extract those instead of double-counting. Hence my vague "let's wo=
rk
> > > with apps" comment.
> > >
> > > For example to a person familiar with the workload it'd be useful to
> > > know if program returned XDP_DROP because of configured policy or
> > > failure to parse a packet. I don't think that sort distinction is
> > > achievable at the level of standard stats.
> > >
> > > The information required by the admin is higher level. As you say the
> > > primary concern there is "how many packets did XDP eat".  =

> > =

> > Right, sure, I am also totally fine with having only a somewhat
> > restricted subset of stats available at the interface level and make
> > everything else be BPF-based. I'm hoping we can converge of a common
> > understanding of what this "minimal set" should be :)
> > =

> > > Speaking of which, one thing that badly needs clarification is our
> > > expectation around XDP packets getting counted towards the interface
> > > stats.  =

> > =

> > Agreed. My immediate thought is that "XDP packets are interface packets"
> > but that is certainly not what we do today, so not sure if changing it
> > at this point would break things?
> =

> I'd vote for taking the risk and trying to align all the drivers.

I agree. I think IFLA_STATS64 in RTM_NEWLINK should contain statistics
of all the packets seen by the netdev. The breakdown into software /
hardware / XDP should be reported via RTM_NEWSTATS.

Currently, for soft devices such as VLANs, bridges and GRE, user space
only sees statistics of packets forwarded by software, which is quite
useless when forwarding is offloaded from the kernel to hardware.

Petr is working on exposing hardware statistics for such devices via
rtnetlink. Unlike XDP (?), we need to be able to let user space enable /
disable hardware statistics as we have a limited number of hardware
counters and they can also reduce the bandwidth when enabled. We are
thinking of adding a new RTM_SETSTATS for that:

# ip stats set dev swp1 hw_stats on

For query, something like (under discussion):

# ip stats show dev swp1 // all groups
# ip stats show dev swp1 group link
# ip stats show dev swp1 group offload // all sub-groups
# ip stats show dev swp1 group offload sub-group cpu
# ip stats show dev swp1 group offload sub-group hw

Like other iproute2 commands, these follow the nesting of the
RTM_{NEW,GET}STATS uAPI.

Looking at patch #1 [1], I think that whatever you decide to expose for
XDP can be queried via:

# ip stats show dev swp1 group xdp
# ip stats show dev swp1 group xdp sub-group regular
# ip stats show dev swp1 group xdp sub-group xsk

Regardless, the following command should show statistics of all the
packets seen by the netdev:

# ip -s link show dev swp1

There is a PR [2] for node_exporter to use rtnetlink to fetch netdev
statistics instead of the old proc interface. It should be possible to
extend it to use RTM_*STATS for more fine-grained statistics.

[1] https://lore.kernel.org/netdev/20211123163955.154512-2-alexandr.lobakin=
@intel.com/
[2] https://github.com/prometheus/node_exporter/pull/2074
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
