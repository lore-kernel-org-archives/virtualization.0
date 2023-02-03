Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1F0C61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 09:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F1C6D402A7;
	Fri,  3 Feb 2023 09:18:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1C6D402A7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Da+AK1ye
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hi_GWBurdPAZ; Fri,  3 Feb 2023 09:18:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A61B401D5;
	Fri,  3 Feb 2023 09:18:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A61B401D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E1EFC0033;
	Fri,  3 Feb 2023 09:18:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AFDEC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13E3381EC8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:18:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13E3381EC8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Da+AK1ye
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0VeZpuTi58rX
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:18:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 127D08142F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 127D08142F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675415887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=epRfDPzeCVTwbxr7ZzaPb0BTAgrqd0oxNwKqq2k7gGE=;
 b=Da+AK1yepzzoZujPzFrN42VasVkb3RY50ooxTYWkG9Qft3tiX8fPF4TTEcZ8NNPh87zBug
 2OO3/VH/HCmB0VYs14W/lUVXozVdRhwC/Hzq3Xk/OIO4Sm3vMyKvTkum6smkT8nwH+sz7h
 3D8cymzFHySHbuNrmWxMPyoBwhyG3aM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-PCQpJI9HPhOFzySG1mdMjg-1; Fri, 03 Feb 2023 04:18:06 -0500
X-MC-Unique: PCQpJI9HPhOFzySG1mdMjg-1
Received: by mail-ed1-f71.google.com with SMTP id
 en20-20020a056402529400b004a26ef05c34so3172711edb.16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 01:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epRfDPzeCVTwbxr7ZzaPb0BTAgrqd0oxNwKqq2k7gGE=;
 b=hZ0Ii7f794VMGnR2SNiio+TsmAq1W/47zjpnjWWyxgxSVkJFolDoXIk2TKN8M/4nWU
 RgP6LVNTDMj+amwVJ72yG6Rm1u+HEb0wKsTHs7h+jA/DbaXzN3pGu8Djfu2F6+epGB34
 iJiBbvQlvoue7+hzkcGD5AULcSwsA02K+UJLYKCvRVsthc5EeuegollMIoaWKUUIIGJp
 4kVN/o0oJO1zS71tx+ha2rLfP7cbbsfdPvhP/jmDHhH5O/4dR7uG9MpcFTsdCX8OgMYY
 DDz5DfuLdhwV/5bfCpNDPlQjxf4iEJHZQRFxSoVx2BWd2sGJJo3R0LDaTYumC6Ndymrx
 M5uw==
X-Gm-Message-State: AO0yUKUiz0NgM8Oz3YOKQl7WWgl43tZQOYJPNHRX1hq5a3Wg2uICfs12
 d+EniCt3JeKhFGmg7+MQqc9mgokKXpCDn+o8CbLkil6HUxRrVW8Dd0ojXMoGpMBL9L5ESS6pD+7
 ZvgkenHpENRvUjcO34fOEYYchHFUEaJsFPGRtNOiDxA==
X-Received: by 2002:a17:906:4787:b0:884:37fd:bf4c with SMTP id
 cw7-20020a170906478700b0088437fdbf4cmr10854188ejc.19.1675415884882; 
 Fri, 03 Feb 2023 01:18:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/r1+CDvVLFdXnEssdesv7QuGqfhjJVfo5pd8868UK6ys7Bboue+Ipv1DMVtJdspKbRue9+hg==
X-Received: by 2002:a17:906:4787:b0:884:37fd:bf4c with SMTP id
 cw7-20020a170906478700b0088437fdbf4cmr10854167ejc.19.1675415884639; 
 Fri, 03 Feb 2023 01:18:04 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1709066bd800b0088452ca0666sm1077211ejs.196.2023.02.03.01.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 01:18:04 -0800 (PST)
Date: Fri, 3 Feb 2023 04:17:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/33] virtio-net: support AF_XDP zero copy
Message-ID: <20230203034212-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <5fda6140fa51b4d2944f77b9e24446e4625641e2.camel@redhat.com>
 <1675395211.6279888-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1675395211.6279888-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
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

On Fri, Feb 03, 2023 at 11:33:31AM +0800, Xuan Zhuo wrote:
> On Thu, 02 Feb 2023 15:41:44 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> > On Thu, 2023-02-02 at 19:00 +0800, Xuan Zhuo wrote:
> > > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > > performance of zero copy is very good. mlx5 and intel ixgbe already support
> > > this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> > > feature.
> > >
> > > Virtio-net did not support per-queue reset, so it was impossible to support XDP
> > > Socket Zerocopy. At present, we have completed the work of Virtio Spec and
> > > Kernel in Per-Queue Reset. It is time for Virtio-Net to complete the support for
> > > the XDP Socket Zerocopy.
> > >
> > > Virtio-net can not increase the queue at will, so xsk shares the queue with
> > > kernel.
> > >
> > > On the other hand, Virtio-Net does not support generate interrupt manually, so
> > > when we wakeup tx xmit, we used some tips. If the CPU run by TX NAPI last time
> > > is other CPUs, use IPI to wake up NAPI on the remote CPU. If it is also the
> > > local CPU, then we wake up sofrirqd.
> >
> > Thank you for the large effort.
> >
> > Since this will likely need a few iterations, on next revision please
> > do split the work in multiple chunks to help the reviewer efforts -
> > from Documentation/process/maintainer-netdev.rst:
> >
> >  - don't post large series (> 15 patches), break them up
> >
> > In this case I guess you can split it in 1 (or even 2) pre-req series
> > and another one for the actual xsk zero copy support.
> 
> 
> OK.
> 
> I can split patch into multiple parts such as
> 
> * virtio core
> * xsk
> * virtio-net prepare
> * virtio-net support xsk zerocopy
> 
> However, there is a problem, the virtio core part should enter the VHOST branch
> of Michael. Then, should I post follow-up patches to which branch vhost or
> next-next?
> 
> Thanks.
> 

Here are some ideas on how to make the patchset smaller
and easier to merge:
- keep everything in virtio_net.c for now. We can split
  things out later, but this way your patchset will not
  conflict with every since change merged meanwhile.
  Also, split up needs to be done carefully with sane
  APIs between components, let's maybe not waste time
  on that now, do the split-up later.
- you have patches that add APIs then other
  patches use them. as long as it's only virtio net just
  add and use in a single patch, review is actually easier this way.
- we can try merging pre-requisites earlier, then patchset
  size will shrink.


> >
> > Thanks!
> >
> > Paolo
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
