Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968F4C61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 08:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15274429B7;
	Fri,  3 Feb 2023 08:37:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15274429B7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VQR2vI4q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fc4tO7tZFgJR; Fri,  3 Feb 2023 08:37:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2CF7441D69;
	Fri,  3 Feb 2023 08:37:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CF7441D69
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3843C0032;
	Fri,  3 Feb 2023 08:37:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38712C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1190041D69
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:37:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1190041D69
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9y3NtxcSEgVb
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC69A41D2C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC69A41D2C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675413459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7TlzcS7seIBaGtc1ElIfuXPqV8FAfo/3wn3H0VyUI+E=;
 b=VQR2vI4qWmKdHwlltP+7K3p/SH4Xd7GD4IHg/Gt+ada86Pgj5065lhnPFHgzzTqHxJ7e98
 e+WhlgGiTCPeYaHPNyxwr1sEcxPcGNh2GwbnE+SG0RUenmgw3L0lgiKdJIbjnEyCss1UDD
 nwPJtK2GIo5z09YK8TXW0gZs45+u+sg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-aHstbZGaMiaUdOUUya4QMw-1; Fri, 03 Feb 2023 03:37:38 -0500
X-MC-Unique: aHstbZGaMiaUdOUUya4QMw-1
Received: by mail-wm1-f72.google.com with SMTP id
 fl9-20020a05600c0b8900b003dfe4bae099so1003713wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 00:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TlzcS7seIBaGtc1ElIfuXPqV8FAfo/3wn3H0VyUI+E=;
 b=J7YjVRpscplZBgHViA4nd0SHn3mJoof+5YQ1Fb3H5fCw3lVYUgJHG+DSZTZHFvjIaJ
 zPJThSgs4TSpDOVTtvkOn8l8kGW2olHT08Yc8adFSL+uuCQCsqPXbld99PHeZXMD/Al0
 AS3N4znV1hQZq6PSzUz4nOYpcQwHy0+M7fQ7wVb9BY/XxONFjaCHS+eSHDYsvvBl0jau
 rhcJ5L8KU4zeVSqvvrZ3l43CEWb84YVWQKMN0HL5iKecotshLb64FcemUAd53VDINOzY
 6YQr12NjJS4zLMTBj5PV/oi3FNGR5qKNEzlJKIEPJu6Z0mnKC9TEPK1j8S0jiRigqwX1
 Y2Mg==
X-Gm-Message-State: AO0yUKUfNaSlHnCaEEQL9tquIIIeTk92aJ93kZYJjBoZ0Zy2mxlpRBUq
 zTOlWHeedUUGSFHVhPPlgWfz03VaBvNlhVb3M2KGnxMgRonNgxr3V4o+uZjYMEI8kJ4mLPczOmW
 ozgXIBabO+oNuJosSLU3xtFUJ1od5mBAKnlEqCt4p8A==
X-Received: by 2002:a05:600c:4f4e:b0:3dc:5baf:df01 with SMTP id
 m14-20020a05600c4f4e00b003dc5bafdf01mr8649119wmq.5.1675413457268; 
 Fri, 03 Feb 2023 00:37:37 -0800 (PST)
X-Google-Smtp-Source: AK7set/RPW2WAWaTuKsXO5Yvg/JI0uqQ/bc9WDzqoSbtkrWppWMrDb2fom0hSvqVmim9wpfcc8PcBA==
X-Received: by 2002:a05:600c:4f4e:b0:3dc:5baf:df01 with SMTP id
 m14-20020a05600c4f4e00b003dc5bafdf01mr8649107wmq.5.1675413457090; 
 Fri, 03 Feb 2023 00:37:37 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 i10-20020a05600c354a00b003dd1c15e7fcsm8095193wmq.15.2023.02.03.00.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 00:37:36 -0800 (PST)
Date: Fri, 3 Feb 2023 03:37:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/33] virtio-net: support AF_XDP zero copy
Message-ID: <20230203033405-mutt-send-email-mst@kernel.org>
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

I personally think 33 patches is still manageable no need to split.
Do try to be careful and track acks and changes: if someone sends an ack
add it in the patch if you change the patch drop the acks,
and logs this fact in the changelog in the cover letter
so people know they need to re-review.


> 
> >
> > Thanks!
> >
> > Paolo
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
