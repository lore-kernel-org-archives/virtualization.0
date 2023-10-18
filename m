Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAA2CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 09:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DE9741F5E;
	Wed, 18 Oct 2023 09:14:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DE9741F5E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TVsm8+Pf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0s4aIerzDdUX; Wed, 18 Oct 2023 09:14:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ADA4841F43;
	Wed, 18 Oct 2023 09:14:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADA4841F43
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93377C0039;
	Wed, 18 Oct 2023 09:14:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E168C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 09:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B000404D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 09:14:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B000404D4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TVsm8+Pf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dGCAeR9j3hLt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 09:14:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E45CD40439
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 09:14:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E45CD40439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697620442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v98xBIyBJ/sPUC9GJh7rulg1/URL0/oOEeAw0GP7jZM=;
 b=TVsm8+PfHyDpLfwLwscViiXDNfbaB35hnJiYucTtdfuRMRQPwn88lJ8BxPZLj/nDGpXn5x
 098fcv78rioPIWHKUj/6DcP6LK9eIoNPlU7nOGdA9g2obCIwi1q5XeDtG14kzrjo4RFEUj
 9e8zLAh/GY3ujZbvUDoeQo7pUpRVTHU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-kChp94dYOOOt22LVusyleA-1; Wed, 18 Oct 2023 05:13:51 -0400
X-MC-Unique: kChp94dYOOOt22LVusyleA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-993c2d9e496so461298866b.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 02:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697620430; x=1698225230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v98xBIyBJ/sPUC9GJh7rulg1/URL0/oOEeAw0GP7jZM=;
 b=vwF63HHBQWcW7Unw+wU3OzwlLEwD3ewVTHpeLXwT8CzM5x+9hulvTP9kGhJj+4AAKu
 /2usICVBxEyLoDUQry+Pu5t6RHXgPPOS01jIDpEIh2GcKuqpEq/glA2ECCKCWuyeDJxD
 Kp4G+jEkqGzsS5VejvgljvQk+NcdPBwULTjku+uJ0rfh53oD+X7DxkytAUvPkGc5gxjQ
 OKLUCrfcm8lCnSC6YVzfayx41rXInwoUMKebyQkeki9Ti87/BRdkJddflPuYcsaloJMl
 es1ys62q8IyMsbuv0K+E6+5irwerWAurFY9dYgNKnAIC7+XO0zhZ0eR4TGHxWo73D9Q4
 Awyw==
X-Gm-Message-State: AOJu0YxI8jH+QCl1shUVS92wT6ZZK3quLFKCm7RBnHwuMU0y+ZdU/bmu
 DicJo67aaYRINvt+GoqIcJyrhUJTBaKQ/E59EOW6/sfx26xLE42NyVmQfW+7lvQdxKDBkjaZn0K
 Ez51cyNvpAIwQSb0JwS0r9bm29YNymRCDZZvh6hVcAw==
X-Received: by 2002:a17:907:72d0:b0:9a9:ef41:e5c7 with SMTP id
 du16-20020a17090772d000b009a9ef41e5c7mr3845033ejc.8.1697620430386; 
 Wed, 18 Oct 2023 02:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+QMli7NKSSKCArCyKPit9urwbgTh0jXYZj5BcmUsdRcVCgnT75EXLlIW5G/G2XZ6Kd+BSHQ==
X-Received: by 2002:a17:907:72d0:b0:9a9:ef41:e5c7 with SMTP id
 du16-20020a17090772d000b009a9ef41e5c7mr3845014ejc.8.1697620430054; 
 Wed, 18 Oct 2023 02:13:50 -0700 (PDT)
Received: from redhat.com ([193.142.201.38]) by smtp.gmail.com with ESMTPSA id
 l26-20020a1709061c5a00b009adcb6c0f0esm1233352ejg.193.2023.10.18.02.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 02:13:49 -0700 (PDT)
Date: Wed, 18 Oct 2023 05:13:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce
 virtqueue_dma_[un]map_page_attrs
Message-ID: <20231018051201-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
 <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
 <20231018035751-mutt-send-email-mst@kernel.org>
 <1697616022.630633-2-xuanzhuo@linux.alibaba.com>
 <20231018044204-mutt-send-email-mst@kernel.org>
 <1697619441.5367694-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697619441.5367694-3-xuanzhuo@linux.alibaba.com>
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

On Wed, Oct 18, 2023 at 04:57:21PM +0800, Xuan Zhuo wrote:
> On Wed, 18 Oct 2023 04:44:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Oct 18, 2023 at 04:00:22PM +0800, Xuan Zhuo wrote:
> > > On Wed, 18 Oct 2023 03:59:03 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Oct 18, 2023 at 03:53:00PM +0800, Xuan Zhuo wrote:
> > > > > Hi Michael,
> > > > >
> > > > > Do you think it's appropriate to push the first two patches of this patch set to
> > > > > linux 6.6?
> > > > >
> > > > > Thanks.
> > > >
> > > > I generally treat patchsets as a whole unless someone asks me to do
> > > > otherwise. Why do you want this?
> > >
> > > As we discussed, the patch set supporting AF_XDP will be push to net-next.
> > > But the two patchs belong to the vhost.
> > >
> > > So, if you think that is appropriate, I will post a new patchset(include the two
> > > patchs without virtio-net + AF_XDP) to vhost. I wish that can be merged to 6.6.
> >
> > Oh wait 6.6? Too late really, merge window has been closed for weeks.
> 
> I mean as a fix. So I ask you do you think it is appropriate?

Sure if there's a bugfix please post is separately - what issues do
these two patches fix? this is the part I'm missing. Especially patch 2
which just adds a new API.

> >
> > > Then when the 6.7 net-next merge window is open, I can push this patch set to 6.7.
> > > The v1 version use the virtqueue_dma_map_single_attrs to replace
> > > virtqueue_dma_map_page_attrs. But I think we should use virtqueue_dma_map_page_attrs.
> > >
> > > Thanks.
> > >
> >
> > Get a complete working patchset that causes no regressions posted first please
> > then we will discuss merge strategy.
> > I would maybe just put everything in one file for now, easier to merge,
> > refactor later when it's all upstream. But up to you.
> 
> OK. I will get a working patchset firstly.
> 
> Thanks.
> 
> >
> >
> > > >
> > > > --
> > > > MST
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
