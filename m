Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2684FCDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 08:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC31360FE4;
	Wed, 18 Oct 2023 08:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC31360FE4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZMblYaWx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9h9DSWRnoKYZ; Wed, 18 Oct 2023 08:44:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4728760AE2;
	Wed, 18 Oct 2023 08:44:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4728760AE2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 131F0C0039;
	Wed, 18 Oct 2023 08:44:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CCF4C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE0C260807
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:44:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE0C260807
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cOaUmN0sDpER
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:44:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D433D61013
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:44:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D433D61013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697618675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k/0liIrEL7QSkgX7qVs1vHsvuoJgLIVTs8YD9K4UGPw=;
 b=ZMblYaWxJcLQiBBcwIk5cRT0qOfLS2SrncYlvxqo8l0RBkpnn54gdpnx0bky7ViVY/H0Qc
 FgVLSff151BJDpUGKofpoLqsrLD5DjC8zE8GGWCAxKLKufJoyp1dJJAamjsVRuBZnCAwA+
 uo16hU/0g8GRBlyhHkLyKOM94j2Kivo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-MTs2ZAvVO-eNN9rTyN9K6A-1; Wed, 18 Oct 2023 04:44:34 -0400
X-MC-Unique: MTs2ZAvVO-eNN9rTyN9K6A-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3b2a6655ee2so9999070b6e.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 01:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697618673; x=1698223473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/0liIrEL7QSkgX7qVs1vHsvuoJgLIVTs8YD9K4UGPw=;
 b=vZlpLL9j2cvtf56miX8KazhtoEQovvFQJCDBxzHMJrNj1Q5cLhWz6EQurj4BLG2UUs
 YomQn9yP880dBthT6mYIf2cYC+2My1YkRPNEj/gS71/5PjEsQj7+gnxyA/I6KVP4VKC5
 Y8ovHO3HnBeg3J63y0rt2MZ1iFW0pQY2slC6JaDtvSgzCgW9JuJ8s9kF+a0l9seTx4Um
 tiEKDG/sEwQ0qUmFgmX2DhwJramcG72poFtrQjtD49Tn1696B796NKy2x9l4iS/+h3LF
 UA7CXFHM2XQFQA0PZzPWyCNtiVhEzCqBBYVdqr/1+eXMDT1tC07EtoSfAT9ltTUtsIQ/
 ORzw==
X-Gm-Message-State: AOJu0Yw4ebwgwOrvdCUvB+87O/fQzWbklyvGq2Al6SDoVfzCu4BHdZ9e
 FhGxz+84kj3AeLSQgb2xSNrcM0s1vvl1+y4+3q9imxym0Hdgg5c0lWJlnqF21mMRQi0g4Jd9LsJ
 ans2EQahdilwb0+8pc4dbEcHkDHNdZIvYw66awHYdAg==
X-Received: by 2002:a05:6808:3086:b0:3b2:e536:a442 with SMTP id
 bl6-20020a056808308600b003b2e536a442mr2351964oib.16.1697618673498; 
 Wed, 18 Oct 2023 01:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzPGIXQARJW6F6uNFF8ujwB+n068AiJDbzKEeMj1yIirMEG5lXUYwOTS07wjyM14GpSR797g==
X-Received: by 2002:a05:6808:3086:b0:3b2:e536:a442 with SMTP id
 bl6-20020a056808308600b003b2e536a442mr2351949oib.16.1697618673200; 
 Wed, 18 Oct 2023 01:44:33 -0700 (PDT)
Received: from redhat.com ([193.142.201.38]) by smtp.gmail.com with ESMTPSA id
 v11-20020a54448b000000b003af732a2054sm581383oiv.57.2023.10.18.01.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:44:32 -0700 (PDT)
Date: Wed, 18 Oct 2023 04:44:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce
 virtqueue_dma_[un]map_page_attrs
Message-ID: <20231018044204-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
 <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
 <20231018035751-mutt-send-email-mst@kernel.org>
 <1697616022.630633-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697616022.630633-2-xuanzhuo@linux.alibaba.com>
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

On Wed, Oct 18, 2023 at 04:00:22PM +0800, Xuan Zhuo wrote:
> On Wed, 18 Oct 2023 03:59:03 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Oct 18, 2023 at 03:53:00PM +0800, Xuan Zhuo wrote:
> > > Hi Michael,
> > >
> > > Do you think it's appropriate to push the first two patches of this patch set to
> > > linux 6.6?
> > >
> > > Thanks.
> >
> > I generally treat patchsets as a whole unless someone asks me to do
> > otherwise. Why do you want this?
> 
> As we discussed, the patch set supporting AF_XDP will be push to net-next.
> But the two patchs belong to the vhost.
> 
> So, if you think that is appropriate, I will post a new patchset(include the two
> patchs without virtio-net + AF_XDP) to vhost. I wish that can be merged to 6.6.

Oh wait 6.6? Too late really, merge window has been closed for weeks.

> Then when the 6.7 net-next merge window is open, I can push this patch set to 6.7.
> The v1 version use the virtqueue_dma_map_single_attrs to replace
> virtqueue_dma_map_page_attrs. But I think we should use virtqueue_dma_map_page_attrs.
> 
> Thanks.
> 

Get a complete working patchset that causes no regressions posted first please
then we will discuss merge strategy.
I would maybe just put everything in one file for now, easier to merge,
refactor later when it's all upstream. But up to you.


> >
> > --
> > MST
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
