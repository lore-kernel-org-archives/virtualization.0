Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0195EC00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 07:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2847E41892;
	Mon, 15 Aug 2022 07:02:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2847E41892
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=anarazel.de header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=vH5e5G5t;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=0Mh9+zPW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KkIGA22O-_Gq; Mon, 15 Aug 2022 07:02:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2AD4E417C4;
	Mon, 15 Aug 2022 07:02:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AD4E417C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E15DC0032;
	Mon, 15 Aug 2022 07:02:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4CA3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2305F60AF7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2305F60AF7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=anarazel.de
 header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=vH5e5G5t; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=0Mh9+zPW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fgep1z-b7Gze
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:02:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 266E060EFD
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 266E060EFD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:02:08 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id ED7175C00C5;
 Mon, 15 Aug 2022 03:02:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Mon, 15 Aug 2022 03:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1660546926; x=1660633326; bh=7XuUYChiRO
 cmN5Xe3tNrNb0d4/N6U6GmFm8bRA2mFtk=; b=vH5e5G5tLvGDdYIwaCom93xIqK
 /6QcVDoe1ka18/izrAzvhNMVIv423tgERZhx+sjgFaZ4S4WO1qLUATrrWdIXM6Go
 LSJQSTwfCu6V8oee8TmU+35873gzvFWshjjfJWybrebTMTL3fPtH+5DuxEkAXNWV
 Nv06f5tcqHcib1A/AcLoSIQbNNscKYE4b9ZNaxaVn+MbaY19BZEs5xQySS1PZmeU
 KnqZq5PUMJA/61i5S4EWgPqYstenYf4Zxcl9d9/dv+9NwN5tr4dEj0CT0dV9nZb0
 mcTgyG//37OJ+tFNPPZmCRx9JvZhQbwN46uJJTRQoVAklZFeJifvnHWUI76g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1660546926; x=1660633326; bh=7XuUYChiROcmN5Xe3tNrNb0d4/N6
 U6GmFm8bRA2mFtk=; b=0Mh9+zPWZ20UDPeP7vaHcWXp/NI8ITDyDD3QP8533ylV
 /+cdrGP2w1N1yWTzSjfmYRgVDG8NzDgZUZmk/jEVrA/RGvuPBfVS2i54NryJAGFA
 j2rxw4B659ne16DH99ePsDBUB/8/9r4ndTSeGfN4zzaV24S6UlcW7H5YOgC5QhJw
 yVXvhDCMKBIquJKp6DkmrZ5nzwuHI0u5VYDXPM+A5p7viRECWYXSecpREofxQZuy
 0wzND6APj+G6UjizDOyFcmYR/phKTG25KGjHCOF1xVb9VA2fsOaoIsByzJ62A1e+
 giYQmOFtQ6MN4tyBoQu6fkalNpK/UyBQPuw9iuc0Jw==
X-ME-Sender: <xms:bO_5Yt3A_yXm-xHz4fhrr0yd8O9daPYalo0o1IdTFY7xHLnzFteJeQ>
 <xme:bO_5YkHI3a5OUndFVMzpNfllZiWLiMYSS-vmgBEUsaIpEQ9s9GtrytRjwjSn5wTCj
 otax7oE7ZH_mRW-vw>
X-ME-Received: <xmr:bO_5Yt4Bpac5DfOgs7Wvh-d_XGVQPVpSlt1qA2ehBEq9R9X4axVz7kFQRvxYJ4fF0I9jD4mjiJwxdfEBzEyyPPE9vFWmSYY8RUN8GW4eN-RpsuSh6ypyBCieXJt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddguddukecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
 rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
 frrghtthgvrhhnpeeuleehvdekhedvvdegveelkeethfetfeeufeehhfetiefggfdtgeek
 keegieegueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigv
 lhdruggv
X-ME-Proxy: <xmx:be_5Yq2reiIsazzhUnbA6CSFyQggLT14gX8z1vPb04JEKdiOv-9ttg>
 <xmx:be_5YgFLOGrNJVMTgjfz18VrH7gMLOrGtrImU1IOibeyhrIZjp7vMw>
 <xmx:be_5Yr9xLVFZt0cFdLN1d3e6lP-qzPXptj7pF5fcWmmmEv8q8uXarA>
 <xmx:bu_5YjGomEc1YBtJYX2oYkWY_i9_YqIFKCU7yeyOH5OMbCEPyRH7Kw>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 03:02:04 -0400 (EDT)
Date: Mon, 15 Aug 2022 00:02:03 -0700
From: Andres Freund <andres@anarazel.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] virtio: fatures, fixes
Message-ID: <20220815070203.plwjx7b3cyugpdt7@awork3.anarazel.de>
References: <20220812114250-mutt-send-email-mst@kernel.org>
 <20220814004522.33ecrwkmol3uz7aq@awork3.anarazel.de>
 <1660441835.6907768-1-xuanzhuo@linux.alibaba.com>
 <20220814035239.m7rtepyum5xvtu2c@awork3.anarazel.de>
 <20220814043906.xkmhmnp23bqjzz4s@awork3.anarazel.de>
 <20220814045853-mutt-send-email-mst@kernel.org>
 <20220814194031.ciql3slc5c34ayjw@awork3.anarazel.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220814194031.ciql3slc5c34ayjw@awork3.anarazel.de>
Cc: peng.fan@nxp.com, kvm@vger.kernel.org, alvaro.karsz@solid-run.com,
 virtualization@lists.linux-foundation.org, quic_mingxue@quicinc.com,
 syoshida@redhat.com, elic@nvidia.com, eperezma@redhat.com,
 Guenter Roeck <linux@roeck-us.net>, jiaming@nfschina.com, hulkci@huawei.com,
 liubo03@inspur.com, dan.carpenter@oracle.com, kangjie.xu@linux.alibaba.com,
 robin.murphy@arm.com, hdegoede@redhat.com, pankaj.gupta@amd.com,
 gautam.dawar@xilinx.com, suwan.kim027@gmail.com, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xuqiang36@huawei.com,
 xieyongji@bytedance.com, colin.i.king@gmail.com, lingshan.zhu@intel.com,
 colin.king@intel.com, Linus Torvalds <torvalds@linux-foundation.org>
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

Hi,

On 2022-08-14 12:40:31 -0700, Andres Freund wrote:
> On 2022-08-14 04:59:48 -0400, Michael S. Tsirkin wrote:
> > On Sat, Aug 13, 2022 at 09:39:06PM -0700, Andres Freund wrote:
> > > Hi,
> > >
> > > On 2022-08-13 20:52:39 -0700, Andres Freund wrote:
> > > > Is there specific information you'd like from the VM? I just recreated the
> > > > problem and can extract.
> > >
> > > Actually, after reproducing I seem to now hit a likely different issue. I
> > > guess I should have checked exactly the revision I had a problem with earlier,
> > > rather than doing a git pull (up to aea23e7c464b)
> >
> > Looks like there's a generic memory corruption so it crashes
> > in random places.
>
> Either a generic memory corruption, or something wrong with IO.
>
> > Would bisect be possible for you?
>
> I'll give it a go.

Bisect points to

commit 762faee5a2678559d3dc09d95f8f2c54cd0466a7 (refs/bisect/bad)
Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date:   Mon Aug 1 14:38:57 2022 +0800

    virtio_net: set the default max ring size by find_vqs()

    Use virtio_find_vqs_ctx_size() to specify the maximum ring size of tx,
    rx at the same time.

                             | rx/tx ring size
    -------------------------------------------
    speed == UNKNOWN or < 10G| 1024
    speed < 40G              | 4096
    speed >= 40G             | 8192

    Call virtnet_update_settings() once before calling init_vqs() to update
    speed.

    Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
    Acked-by: Jason Wang <jasowang@redhat.com>
    Message-Id: <20220801063902.129329-38-xuanzhuo@linux.alibaba.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


I'm not 100% confident yet, because the likelihood of encountering problems
was not uniform across the versions, with one of them showing the problem only
in 1/3 boots, whereas some of the others showed it 100% of the time. But I've
rebooted enough times to be fairly confident.

With 762faee5a267 I reliably see network not connecting, with
762faee5a267^=fe3dc04e31aa I haven't seen a problem yet.


I did see some other types of crashes in commits nearby, so this might not be
the only problematic bit. See also the discussion around
https://lore.kernel.org/all/CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com/

Greetings,

Andres Freund
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
