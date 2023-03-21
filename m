Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD684C74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 12:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FAC641843;
	Tue, 21 Mar 2023 12:22:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FAC641843
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=blxRop1t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kZkDTWB_ivbJ; Tue, 21 Mar 2023 12:22:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9A5FF41838;
	Tue, 21 Mar 2023 12:22:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A5FF41838
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DFADC0035;
	Tue, 21 Mar 2023 12:22:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75161C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 12:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41A9F41832
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 12:22:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41A9F41832
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nGYtsJz-TgbA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 12:22:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0346D4182C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0346D4182C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 12:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679401354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bhYIAqjSaFFOuKGO8P8w2NdVEdEzB+ZDIXOhFeNjrwE=;
 b=blxRop1twE1lr1ePPgrv/3WrD2n0NpL5tyNBeuWshimHjER/qRnkbldaXFrw1/9mSdBI62
 DtmEvGhZvXG0JU/98ongTv3l1yhFLc5eQowMaz0GuGinMNTDM7V1SkfkVv9ECjc/v13WXk
 QTGAXZUXeXhKLiGa5QwZ5Qs0Rh2kUcw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-If94Mz_jPvmhE_3EhJpfhA-1; Tue, 21 Mar 2023 08:22:30 -0400
X-MC-Unique: If94Mz_jPvmhE_3EhJpfhA-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg13-20020a05600c3c8d00b003ed40f09355so6990925wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 05:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679401349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhYIAqjSaFFOuKGO8P8w2NdVEdEzB+ZDIXOhFeNjrwE=;
 b=REYqrtKJShqdbAUvLctdHFeGjIKCELt4cBTeCKOOlbvMxNP4eNNK4tvJhZH5RRDqGv
 BMyAk+y9Ccjiu6X13+qEkngiT6yyGwCK0zRt4lFEZujVOkth7dhf7vX2khuCkHpmpLYR
 tZvmZR3Q4IVS4fVUTu7dCiEYamMjaQXhUMBxu2FMqadwUeVwKpircYgt+1I10VEOgDjk
 aLNDCYFe1biyfpUkzG59FnvRtpeW3jJPVQAY+TBeDcYPFjNIulxXjPypx8VwwbDhAkVO
 RtYzuk2B1b4SA7y0JYa1osGZcu+aZQeUR6dzIU50QrfLQTUCW/dNX2iN9n9nY+ReVEMj
 P9Eg==
X-Gm-Message-State: AO0yUKVDIc8txAYa0A02ryiweeOwrcTLgH9+wDHmoJlwVpWW+4xZ29Os
 Mt0/t6VEtxRWjoLQBqeQFucYJAjI38HK/63wDOlj9b/QBNh1qoXFHb0C5QDPyXi2Es8/KLKNEjN
 wn+duLm+oW664V2fcQjl8yrDOz+cV3am7KcGCuIsiNw==
X-Received: by 2002:a1c:f20e:0:b0:3ed:ac66:9445 with SMTP id
 s14-20020a1cf20e000000b003edac669445mr2297565wmc.8.1679401349796; 
 Tue, 21 Mar 2023 05:22:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set8YeKutAAOEemeAKynuByQv3FxmQfnuDB21wRMtth8a1Pu+Sesej59PAmO4YgxyGIvYNZKqfg==
X-Received: by 2002:a1c:f20e:0:b0:3ed:ac66:9445 with SMTP id
 s14-20020a1cf20e000000b003edac669445mr2297546wmc.8.1679401349536; 
 Tue, 21 Mar 2023 05:22:29 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 c16-20020a7bc850000000b003ee2bed222asm2127363wml.32.2023.03.21.05.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 05:22:29 -0700 (PDT)
Date: Tue, 21 Mar 2023 08:22:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next 0/8] virtio_net: refactor xdp codes
Message-ID: <20230321082216-mutt-send-email-mst@kernel.org>
References: <20230315041042.88138-1-xuanzhuo@linux.alibaba.com>
 <1679399929.1424522-1-xuanzhuo@linux.alibaba.com>
 <1679401220.8186114-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1679401220.8186114-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Tue, Mar 21, 2023 at 08:20:20PM +0800, Xuan Zhuo wrote:
> On Tue, 21 Mar 2023 19:58:49 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > On Wed, 15 Mar 2023 12:10:34 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > Due to historical reasons, the implementation of XDP in virtio-net is relatively
> > > chaotic. For example, the processing of XDP actions has two copies of similar
> > > code. Such as page, xdp_page processing, etc.
> > >
> > > The purpose of this patch set is to refactor these code. Reduce the difficulty
> > > of subsequent maintenance. Subsequent developers will not introduce new bugs
> > > because of some complex logical relationships.
> > >
> > > In addition, the supporting to AF_XDP that I want to submit later will also need
> > > to reuse the logic of XDP, such as the processing of actions, I don't want to
> > > introduce a new similar code. In this way, I can reuse these codes in the
> > > future.
> > >
> > > This patches are developed on the top of another patch set[1]. I may have to
> > > wait to merge this. So this patch set is a RFC.
> >
> >
> > Hi, Jason:
> >
> > Now, the patch set[1] has been in net-next. So this patch set can been merge
> > into net-next.
> >
> > Please review.
> 
> 
> I do not know why this patch set miss Jason. I send it normally. ^_^
> 
> Thanks.


repost as non-rfc.

> 
> 
> >
> > Thanks.
> >
> >
> > >
> > > Please review.
> > >
> > > Thanks.
> > >
> > > [1]. https://lore.kernel.org/netdev/20230315015223.89137-1-xuanzhuo@linux.alibaba.com/
> > >
> > >
> > > Xuan Zhuo (8):
> > >   virtio_net: mergeable xdp: put old page immediately
> > >   virtio_net: mergeable xdp: introduce mergeable_xdp_prepare
> > >   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
> > >     run xdp
> > >   virtio_net: separate the logic of freeing xdp shinfo
> > >   virtio_net: separate the logic of freeing the rest mergeable buf
> > >   virtio_net: auto release xdp shinfo
> > >   virtio_net: introduce receive_mergeable_xdp()
> > >   virtio_net: introduce receive_small_xdp()
> > >
> > >  drivers/net/virtio_net.c | 615 +++++++++++++++++++++++----------------
> > >  1 file changed, 357 insertions(+), 258 deletions(-)
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> > > _______________________________________________
> > > Virtualization mailing list
> > > Virtualization@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
