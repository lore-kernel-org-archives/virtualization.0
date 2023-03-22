Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05847C6FD1F
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 03:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61EB14148F;
	Wed, 22 Mar 2023 03:54:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61EB14148F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AOs1dyqs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P9oRfjoOrZJ0; Wed, 22 Mar 2023 03:54:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D40DA40237;
	Wed, 22 Mar 2023 03:54:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D40DA40237
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAE4EC0071;
	Wed, 22 Mar 2023 03:54:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0096C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A472D60E9D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:54:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A472D60E9D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AOs1dyqs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZUBlsZ2DJgxg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:54:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB59460E4A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB59460E4A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679457242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kmfz3AHdHTkdeXNmLeWbjpqYQCkdTd0YBubZk4XP0tI=;
 b=AOs1dyqs1lvBVK75gZBs3R+FoFkTURK9Wx7NhsmgXKiwUyfRNuPYFkhB9Ncl1wQTg1J2nu
 9CDGHes/b0KtRsWkx6ciiglhE713RO8H5CjjZptZyrLxIdSW01esfEoaT01MTreUwMODBF
 K/VpJAcOVoARf5l8N7hYbLpQ0NrbB6k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-0rjh5J3BPvKtu7FiAckSTQ-1; Tue, 21 Mar 2023 23:53:59 -0400
X-MC-Unique: 0rjh5J3BPvKtu7FiAckSTQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 o37-20020a05600c512500b003edd119ec9eso4647869wms.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 20:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679457238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kmfz3AHdHTkdeXNmLeWbjpqYQCkdTd0YBubZk4XP0tI=;
 b=COy646uh1G/kiH6ePVIgcA45zs4ex3TQ0T88T4s00JenAW5DZai2qcEUyCGrKvXUns
 h6+JUV+QQWbc4ZJSdKCvz1EG0LjH9V1R1TyMXN/2yScjuR88aIXtZ/9Xkm0yvu3EHqkj
 wwD4UGDe4nl9l3aFeJwd237zdhj9GiNIcVv11UN68aeuMi4TRcGPj+0WNRtcyAwRvMA7
 USLZEsYw3qbj1cE9hYw7hL72oo7nFtEh978NPVVt5FPg4Uy2K/+n0oveC2BAE4t9RfqM
 G+0e2wu065Vqe0btl2H31YzJZ8earKXggJkAZgnhwQ0gjFqDxuxkmv4LJbynB6tYZBAA
 HFqw==
X-Gm-Message-State: AO0yUKXWzRyHtr84qTz0BqzgrkPM1ogY7y+miBWM4h9V8/vkmHZN8l7k
 XUV7+kOLeCxVJIDfdWHSOqei0zlPNmJzHkcHlwoFxZzwPxwgf6rxyniuf24o2rS7T0SRaHp1t9K
 d95Wdg7gWr2rxzT35pLVHdiu9JcIBE6YUOAm+wlHSfQ==
X-Received: by 2002:a5d:6409:0:b0:2cf:e8b2:4f76 with SMTP id
 z9-20020a5d6409000000b002cfe8b24f76mr3983614wru.66.1679457237798; 
 Tue, 21 Mar 2023 20:53:57 -0700 (PDT)
X-Google-Smtp-Source: AK7set8zVCwQRMi4Rh1G47k43koQsAembGqp95czOT6L0CoZ3+ax/Z0LHSwwY9xTqnNP6PuioxViDg==
X-Received: by 2002:a5d:6409:0:b0:2cf:e8b2:4f76 with SMTP id
 z9-20020a5d6409000000b002cfe8b24f76mr3983603wru.66.1679457237513; 
 Tue, 21 Mar 2023 20:53:57 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 o17-20020a056000011100b002d30fe0d2fcsm12753934wrx.13.2023.03.21.20.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 20:53:57 -0700 (PDT)
Date: Tue, 21 Mar 2023 23:53:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/8] virtio_net: refactor xdp codes
Message-ID: <20230321235326-mutt-send-email-mst@kernel.org>
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230321233325-mutt-send-email-mst@kernel.org>
 <1679456456.3777983-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1679456456.3777983-1-xuanzhuo@linux.alibaba.com>
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

On Wed, Mar 22, 2023 at 11:40:56AM +0800, Xuan Zhuo wrote:
> On Tue, 21 Mar 2023 23:34:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Mar 22, 2023 at 11:03:00AM +0800, Xuan Zhuo wrote:
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
> > > Please review.
> > >
> > > Thanks.
> >
> > I really want to see that code make progress though.
> 
> I want to know, you refer to virtio-net + AF_XDP or refactor for XDP.
> 
> > Would it make sense to merge this one through the virtio tree?
> 
> There are some small problems that we merge this patch-set to Virtio Tree
> directly.
> 
> Thanks.

what exactly? is there a dependency on net-next?

> >
> > Then you will have all the pieces in one place and try to target
> > next linux.
> >
> >
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
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
