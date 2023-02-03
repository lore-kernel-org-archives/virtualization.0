Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FB3C636CC
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 09:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4660429F2;
	Fri,  3 Feb 2023 09:09:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4660429F2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AbfZJ8Gq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HVyD1ulEvdmN; Fri,  3 Feb 2023 09:09:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BCD3C429E2;
	Fri,  3 Feb 2023 09:09:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCD3C429E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 965E8C0032;
	Fri,  3 Feb 2023 09:09:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42801C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 115B1410CC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:09:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 115B1410CC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AbfZJ8Gq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5jaRIWKq1omH
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:09:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B3E3405B5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B3E3405B5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675415377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/jc51KQG0w1SZ2JKvl1VHrz8cQjDpUX5SSWtJktdkfw=;
 b=AbfZJ8Gq8IchH3IRBH2s8BHyfH3SEjvprpArQQZzNPtzp/4vj3lzNMoxQwr8kzR5oqhwai
 cwbU0Aeif6VZR5DG2Kk/yMAi2nwzTDkywkJDDaHe0uJS+F0PRHdOTsaINX68wutx/F3VoL
 0lT7YADNZ/cKvFovzSZ4g6XsNYnTER4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-197-b-2lkws-Nqqpst_lQJZknw-1; Fri, 03 Feb 2023 04:09:34 -0500
X-MC-Unique: b-2lkws-Nqqpst_lQJZknw-1
Received: by mail-wm1-f69.google.com with SMTP id
 o8-20020a05600c510800b003dfdf09ffc2so1926591wms.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 01:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jc51KQG0w1SZ2JKvl1VHrz8cQjDpUX5SSWtJktdkfw=;
 b=0yVxq4RDKupPKIIIyHftzniJmsqyMueWB3p9UbUTRXg4a0Bg/km+LW6qH/eNpDK1Hu
 WKAenbmpzx3j1MAohM0rn5GMdh0y777E2fata/Ktfap9C+izpJmUeRFSURWMYBfzV1Jh
 +RRNykVwuiEtN8ysiJd4NKV/hq69UnMi3SMKbHetOU/HOuWzx0IAUkDm7JLk+dsgVh2L
 nE5JilKN931skYYBpXooexSWIUoxoK+S6jEQG2+JpNMfhzHX4ToIZfucyM/JWR248NdY
 iCjwijKe8uaDSlTkainUb7SBYz/stn30l1hlODTHvojiiegirkvuvsoMOpUN0nBdye1e
 ce1A==
X-Gm-Message-State: AO0yUKUcdXcG/eS+n4B27X6KdBjssPq5KZPS3tAxRHHl/aKm9gXBipF8
 xn31cBidGYhz8Wts0iyUNiMdpOYyA0VYLhZGZIzr7c4D2GHdPnjEh4SXIhbls+npVtNWsw9S/Ns
 BAgVu6Wi6bYAmm3oqqUN8qKNlXVpZJPV0DnhW6YMzTA==
X-Received: by 2002:adf:d1cc:0:b0:2bf:9465:641 with SMTP id
 b12-20020adfd1cc000000b002bf94650641mr11248063wrd.65.1675415372856; 
 Fri, 03 Feb 2023 01:09:32 -0800 (PST)
X-Google-Smtp-Source: AK7set+TiUkutaIauQ/Tf6xE+qTDtiSxX6A28pk8T4mrOWVcvuU+FUXyr19sF+jujDTG7YmNX7j8MQ==
X-Received: by 2002:adf:d1cc:0:b0:2bf:9465:641 with SMTP id
 b12-20020adfd1cc000000b002bf94650641mr11248042wrd.65.1675415372633; 
 Fri, 03 Feb 2023 01:09:32 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 e20-20020a5d5954000000b002bfd524255esm1510845wri.43.2023.02.03.01.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 01:09:31 -0800 (PST)
Date: Fri, 3 Feb 2023 04:09:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH 00/33] virtio-net: support AF_XDP zero copy
Message-ID: <20230203040855-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <5fda6140fa51b4d2944f77b9e24446e4625641e2.camel@redhat.com>
 <1675395211.6279888-2-xuanzhuo@linux.alibaba.com>
 <20230203033405-mutt-send-email-mst@kernel.org>
 <Y9zJ9j0GthvRSFHL@boxer>
MIME-Version: 1.0
In-Reply-To: <Y9zJ9j0GthvRSFHL@boxer>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Fri, Feb 03, 2023 at 09:46:46AM +0100, Maciej Fijalkowski wrote:
> On Fri, Feb 03, 2023 at 03:37:32AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Feb 03, 2023 at 11:33:31AM +0800, Xuan Zhuo wrote:
> > > On Thu, 02 Feb 2023 15:41:44 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> > > > On Thu, 2023-02-02 at 19:00 +0800, Xuan Zhuo wrote:
> > > > > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > > > > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > > > > performance of zero copy is very good. mlx5 and intel ixgbe already support
> > > > > this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> > > > > feature.
> > > > >
> > > > > Virtio-net did not support per-queue reset, so it was impossible to support XDP
> > > > > Socket Zerocopy. At present, we have completed the work of Virtio Spec and
> > > > > Kernel in Per-Queue Reset. It is time for Virtio-Net to complete the support for
> > > > > the XDP Socket Zerocopy.
> > > > >
> > > > > Virtio-net can not increase the queue at will, so xsk shares the queue with
> > > > > kernel.
> > > > >
> > > > > On the other hand, Virtio-Net does not support generate interrupt manually, so
> > > > > when we wakeup tx xmit, we used some tips. If the CPU run by TX NAPI last time
> > > > > is other CPUs, use IPI to wake up NAPI on the remote CPU. If it is also the
> > > > > local CPU, then we wake up sofrirqd.
> > > >
> > > > Thank you for the large effort.
> > > >
> > > > Since this will likely need a few iterations, on next revision please
> > > > do split the work in multiple chunks to help the reviewer efforts -
> > > > from Documentation/process/maintainer-netdev.rst:
> > > >
> > > >  - don't post large series (> 15 patches), break them up
> > > >
> > > > In this case I guess you can split it in 1 (or even 2) pre-req series
> > > > and another one for the actual xsk zero copy support.
> > > 
> > > 
> > > OK.
> > > 
> > > I can split patch into multiple parts such as
> > > 
> > > * virtio core
> > > * xsk
> > > * virtio-net prepare
> > > * virtio-net support xsk zerocopy
> > > 
> > > However, there is a problem, the virtio core part should enter the VHOST branch
> > > of Michael. Then, should I post follow-up patches to which branch vhost or
> > > next-next?
> > > 
> > > Thanks.
> > 
> > I personally think 33 patches is still manageable no need to split.
> > Do try to be careful and track acks and changes: if someone sends an ack
> > add it in the patch if you change the patch drop the acks,
> > and logs this fact in the changelog in the cover letter
> > so people know they need to re-review.
> 
> To me some of the patches are too granular but probably this is related to
> personal taste.

I agree here. Some unrelated refactoring can also be deferred.

> However, I would like to ask to check how this series
> affects existing ZC enabled driver(s), since xsk core is touched.
> 
> > 
> > 
> > > 
> > > >
> > > > Thanks!
> > > >
> > > > Paolo
> > > >
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
