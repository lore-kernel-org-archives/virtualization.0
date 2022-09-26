Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215EDC32771
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 13:42:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A090C402EB;
	Mon, 26 Sep 2022 13:42:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A090C402EB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OHLNI4Yy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id erTvui6Qsd1z; Mon, 26 Sep 2022 13:42:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1675040BB2;
	Mon, 26 Sep 2022 13:42:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1675040BB2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6B99C0033;
	Mon, 26 Sep 2022 13:42:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC08AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A91D582A28
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:42:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A91D582A28
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OHLNI4Yy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mWj8fGurjXBK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:42:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9116582A0B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9116582A0B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664199750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmwtN+NyrhixAl+NaySPGi8yrkPzbP4TeUvnBlgzaxk=;
 b=OHLNI4Yy+AVo5tHiKj+3OGIoX4a2uwgXjxS7ddy8O0X3/cwCfJryWkPbQUTSkUQSO0QFGc
 3/vLQ5z5VT7EeZ3D9d4v1nNkp8Gev+A3Ev9FcJWBU96gHnWUOCOXrV/rhw2vxavYXNQTlE
 A0qYAV6z6cdeLBsaKdfzOL3n78mI/MI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-WmOfVejlPnOMB4f2P_h65A-1; Mon, 26 Sep 2022 09:42:27 -0400
X-MC-Unique: WmOfVejlPnOMB4f2P_h65A-1
Received: by mail-qv1-f69.google.com with SMTP id
 q5-20020a056214194500b004a03466c568so3822679qvk.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 06:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=FmwtN+NyrhixAl+NaySPGi8yrkPzbP4TeUvnBlgzaxk=;
 b=w0w96dzI4f5BI1ccBZWlALDJMWnli6QGKfeZro3FGAXEBwmVh5vvnctoypJI71gcQV
 G582mUwEbXn4Xj+YXwYw2qbdZHh3NzJ4XFB+jVf7kKUgla8i9z0S8ctPA9sN8MBnf8EA
 wNREKAu+kf1M9sbBo1cJq6YvxZUYYvKj0EtEb71gU1FApFQ22KVzDtzhpRBeWjhZB1d1
 mlzivSiGDKjgu0DQx9mgQdiZeZW2PG5hl7WkYoSgbQp32410ZE4Exa8xtQn7hgzAL81q
 qAnnRBNrZ1EA2TGRiODn7iN6rEipDqHPs1h69RtUnOteUaTzrPmOW/5i3Zfn/4XaPiiZ
 ZNHg==
X-Gm-Message-State: ACrzQf0mHBptCrOenOzCcNvZVd99EtB2rxCR91Qp4LO5HSoRGjsTqdxl
 yiNcYasE4wlxsHfoNv+vFEJfCp3mgOOrIgA+vxB6/QcpYGls0c3gd77LPfapglFQAGRxiJYFTER
 CGduFZdpwxvlmFEmTvWmLEgvgdPdod4rLFkEMkcU/MA==
X-Received: by 2002:a05:620a:3711:b0:6ce:e7b3:d91b with SMTP id
 de17-20020a05620a371100b006cee7b3d91bmr13773042qkb.428.1664199746842; 
 Mon, 26 Sep 2022 06:42:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM48rV68CI6BIVBegZsCpLRad8XltAIyLSTgKKG3vra2SE+tRk0FWFyXXO/Eu5qJt2XZgTxJpQ==
X-Received: by 2002:a05:620a:3711:b0:6ce:e7b3:d91b with SMTP id
 de17-20020a05620a371100b006cee7b3d91bmr13773011qkb.428.1664199746543; 
 Mon, 26 Sep 2022 06:42:26 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it.
 [79.46.200.222]) by smtp.gmail.com with ESMTPSA id
 d7-20020a05620a240700b006cede93c765sm11947587qkn.28.2022.09.26.06.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Sep 2022 06:42:25 -0700 (PDT)
Date: Mon, 26 Sep 2022 15:42:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Message-ID: <20220926134219.sreibsw2rfgw7625@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <cover.1660362668.git.bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Wei Liu <wei.liu@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-hyperv@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi,

On Mon, Aug 15, 2022 at 10:56:03AM -0700, Bobby Eshleman wrote:
>Hey everybody,
>
>This series introduces datagrams, packet scheduling, and sk_buff usage
>to virtio vsock.

Just a reminder for those who are interested, tomorrow Sep 27 @ 16:00 
UTC we will discuss more about the next steps for this series in this 
room: https://meet.google.com/fxi-vuzr-jjb
(I'll try to record it and take notes that we will share)

Bobby, thank you so much for working on this! It would be great to solve 
the fairness issue and support datagram!

I took a look at the series, left some comments in the individual 
patches, and add some advice here that we could pick up tomorrow:
- it would be nice to run benchmarks (e.g., iperf-vsock, uperf, etc.) to
   see how much the changes cost (e.g. sk_buff use)
- we should take care also of other transports (i.e. vmci, hyperv), the 
   uAPI should be as close as possible regardless of the transport

About the use of netdev, it seems the most controversial point and I 
understand Jakub and Michael's concerns. Tomorrow would be great if you 
can update us if you have found any way to avoid it, just reusing a 
packet scheduler somehow.
It would be great if we could make it available for all transports (I'm 
not asking you to implement it for all, but to have a generic api that 
others can use).

But we can talk about that tomorrow!
Thanks,
Stefano

>
>The usage of struct sk_buff benefits users by a) preparing vsock to use
>other related systems that require sk_buff, such as sockmap and qdisc,
>b) supporting basic congestion control via sock_alloc_send_skb, and c)
>reducing copying when delivering packets to TAP.
>
>The socket layer no longer forces errors to be -ENOMEM, as typically
>userspace expects -EAGAIN when the sk_sndbuf threshold )s reached and
>messages are being sent with option MSG_DONTWAIT.
>
>The datagram work is based off previous patches by Jiang Wang[1].
>
>The introduction of datagrams creates a transport layer fairness issue
>where datagrams may freely starve streams of queue access. This happens
>because, unlike streams, datagrams lack the transactions necessary for
>calculating credits and throttling.
>
>Previous proposals introduce changes to the spec to add an additional
>virtqueue pair for datagrams[1]. Although this solution works, using
>Linux's qdisc for packet scheduling leverages already existing systems,
>avoids the need to change the virtio specification, and gives additional
>capabilities. The usage of SFQ or fq_codel, for example, may solve the
>transport layer starvation problem. It is easy to imagine other use
>cases as well. For example, services of varying importance may be
>assigned different priorities, and qdisc will apply appropriate
>priority-based scheduling. By default, the system default pfifo qdisc is
>used. The qdisc may be bypassed and legacy queuing is resumed by simply
>setting the virtio-vsock%d network device to state DOWN. This technique
>still allows vsock to work with zero-configuration.
>
>In summary, this series introduces these major changes to vsock:
>
>- virtio vsock supports datagrams
>- virtio vsock uses struct sk_buff instead of virtio_vsock_pkt
>  - Because virtio vsock uses sk_buff, it also uses sock_alloc_send_skb,
>    which applies the throttling threshold sk_sndbuf.
>- The vsock socket layer supports returning errors other than -ENOMEM.
>  - This is used to return -EAGAIN when the sk_sndbuf threshold is
>    reached.
>- virtio vsock uses a net_device, through which qdisc may be used.
> - qdisc allows scheduling policies to be applied to vsock flows.
>  - Some qdiscs, like SFQ, may allow vsock to avoid transport layer congestion. That is,
>    it may avoid datagrams from flooding out stream flows. The benefit
>    to this is that additional virtqueues are not needed for datagrams.
>  - The net_device and qdisc is bypassed by simply setting the
>    net_device state to DOWN.
>
>[1]: https://lore.kernel.org/all/20210914055440.3121004-1-jiang.wang@bytedance.com/
>
>Bobby Eshleman (5):
>  vsock: replace virtio_vsock_pkt with sk_buff
>  vsock: return errors other than -ENOMEM to socket
>  vsock: add netdev to vhost/virtio vsock
>  virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
>  virtio/vsock: add support for dgram
>
>Jiang Wang (1):
>  vsock_test: add tests for vsock dgram
>
> drivers/vhost/vsock.c                   | 238 ++++----
> include/linux/virtio_vsock.h            |  73 ++-
> include/net/af_vsock.h                  |   2 +
> include/uapi/linux/virtio_vsock.h       |   2 +
> net/vmw_vsock/af_vsock.c                |  30 +-
> net/vmw_vsock/hyperv_transport.c        |   2 +-
> net/vmw_vsock/virtio_transport.c        | 237 +++++---
> net/vmw_vsock/virtio_transport_common.c | 771 ++++++++++++++++--------
> net/vmw_vsock/vmci_transport.c          |   9 +-
> net/vmw_vsock/vsock_loopback.c          |  51 +-
> tools/testing/vsock/util.c              | 105 ++++
> tools/testing/vsock/util.h              |   4 +
> tools/testing/vsock/vsock_test.c        | 195 ++++++
> 13 files changed, 1176 insertions(+), 543 deletions(-)
>
>-- 
>2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
