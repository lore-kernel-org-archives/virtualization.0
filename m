Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226F9C282E7
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 20:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A146460BAE;
	Mon, 15 Aug 2022 20:39:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A146460BAE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cwwCc7/r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uoL__d2ZhVH9; Mon, 15 Aug 2022 20:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 05B6C60B18;
	Mon, 15 Aug 2022 20:39:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05B6C60B18
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB062C0032;
	Mon, 15 Aug 2022 20:39:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4601CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1314F81499
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:39:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1314F81499
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cwwCc7/r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H5tDHLhBp02q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:39:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE8358146D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE8358146D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660595960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Ju82h2Seq9g+C5kY2YGtQXKyGbfylxp+FKU0h7Nrc0=;
 b=cwwCc7/rxrEHBebZtedKTnX3ahM/5qWBBk9EmA7LfmHf2FqWR7/9FxdzMLpBHEL9lFmOsA
 ZWoIu2doMRaqrxovOtl2nQaicM1i8ZC9whiBJKXP/NBFX8CwmYs1of6qHwQkQt3fCrulPV
 93+IKQltwDU2y4k2FaCJoDyMXpDgQsI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-187-srzV-4tuOzWExNQ1vVR5yQ-1; Mon, 15 Aug 2022 16:39:17 -0400
X-MC-Unique: srzV-4tuOzWExNQ1vVR5yQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 c14-20020a05640227ce00b0043e5df12e2cso5405727ede.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=1Ju82h2Seq9g+C5kY2YGtQXKyGbfylxp+FKU0h7Nrc0=;
 b=YuGue1O6oj1PEuYVIbaQV7gTQavRHKXKUV8bjiTPfoYYEvfl7OSfBHJl/nHF6jhdiU
 35Se+FMJJRvhOOSspKnnfmQNOylauTSIaoK6PiyohYfMlJifeEeBFJ2Ty5ydCFlZmTLw
 FqbtaoyFMnl/rbEWMWp5Rzm9X07m7shVBSFitLSMzYMDwcZM1WrtCh5SdnGUhVxCShIH
 5s8SFHC42F0oxpmx1nCcktMFN3E4DCKQ00aG/52WzWYzbmj/1MDzz0uBP/5098CpPSFT
 ePOnXcmYVBhAOJaqijUk9cYVEB1nrTkGPQyogfFlhCue1dVe39X+Q0VzMOA1eGHJSB8M
 J6og==
X-Gm-Message-State: ACgBeo1uuUoTDQ5ryaCSs6IKGrTjIQpk48im9Z6X/OeSL33zhx7zeMzi
 p+KpRYPGIvSXSnYMhThWgJKHw+xjs2KovMpKzzIiZY5pm5QYqR+Y4wKDj9TQIDN+4k3wfbjEGUI
 srtGQyC7M8S/0nbcuh4JS9va+utHBz7AKfXgO7pF4ZA==
X-Received: by 2002:aa7:dc10:0:b0:440:b446:c0cc with SMTP id
 b16-20020aa7dc10000000b00440b446c0ccmr15993700edu.34.1660595956283; 
 Mon, 15 Aug 2022 13:39:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR45Fuir9EoNpEYCDZwTaOCu5+yshYNzN86x9kBq/JCQrW+g/Q8mhFtNHXDl7fhQaOWy+suhNw==
X-Received: by 2002:aa7:dc10:0:b0:440:b446:c0cc with SMTP id
 b16-20020aa7dc10000000b00440b446c0ccmr15993678edu.34.1660595956040; 
 Mon, 15 Aug 2022 13:39:16 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 m17-20020a1709066d1100b007305b8aa36bsm4417030ejr.157.2022.08.15.13.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 13:39:15 -0700 (PDT)
Date: Mon, 15 Aug 2022 16:39:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Message-ID: <20220815162524-mutt-send-email-mst@kernel.org>
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
 Jiang Wang <jiang.wang@bytedance.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Aug 15, 2022 at 10:56:03AM -0700, Bobby Eshleman wrote:
> Hey everybody,
> 
> This series introduces datagrams, packet scheduling, and sk_buff usage
> to virtio vsock.
> 
> The usage of struct sk_buff benefits users by a) preparing vsock to use
> other related systems that require sk_buff, such as sockmap and qdisc,
> b) supporting basic congestion control via sock_alloc_send_skb, and c)
> reducing copying when delivering packets to TAP.
> 
> The socket layer no longer forces errors to be -ENOMEM, as typically
> userspace expects -EAGAIN when the sk_sndbuf threshold is reached and
> messages are being sent with option MSG_DONTWAIT.
> 
> The datagram work is based off previous patches by Jiang Wang[1].
> 
> The introduction of datagrams creates a transport layer fairness issue
> where datagrams may freely starve streams of queue access. This happens
> because, unlike streams, datagrams lack the transactions necessary for
> calculating credits and throttling.
> 
> Previous proposals introduce changes to the spec to add an additional
> virtqueue pair for datagrams[1]. Although this solution works, using
> Linux's qdisc for packet scheduling leverages already existing systems,
> avoids the need to change the virtio specification, and gives additional
> capabilities. The usage of SFQ or fq_codel, for example, may solve the
> transport layer starvation problem. It is easy to imagine other use
> cases as well. For example, services of varying importance may be
> assigned different priorities, and qdisc will apply appropriate
> priority-based scheduling. By default, the system default pfifo qdisc is
> used. The qdisc may be bypassed and legacy queuing is resumed by simply
> setting the virtio-vsock%d network device to state DOWN. This technique
> still allows vsock to work with zero-configuration.
> 
> In summary, this series introduces these major changes to vsock:
> 
> - virtio vsock supports datagrams
> - virtio vsock uses struct sk_buff instead of virtio_vsock_pkt
>   - Because virtio vsock uses sk_buff, it also uses sock_alloc_send_skb,
>     which applies the throttling threshold sk_sndbuf.
> - The vsock socket layer supports returning errors other than -ENOMEM.
>   - This is used to return -EAGAIN when the sk_sndbuf threshold is
>     reached.
> - virtio vsock uses a net_device, through which qdisc may be used.
>  - qdisc allows scheduling policies to be applied to vsock flows.
>   - Some qdiscs, like SFQ, may allow vsock to avoid transport layer congestion. That is,
>     it may avoid datagrams from flooding out stream flows. The benefit
>     to this is that additional virtqueues are not needed for datagrams.
>   - The net_device and qdisc is bypassed by simply setting the
>     net_device state to DOWN.
> 
> [1]: https://lore.kernel.org/all/20210914055440.3121004-1-jiang.wang@bytedance.com/

Given this affects the driver/device interface I'd like to
ask you to please copy virtio-dev mailing list on these patches.
Subscriber only I'm afraid you will need to subscribe :(

> Bobby Eshleman (5):
>   vsock: replace virtio_vsock_pkt with sk_buff
>   vsock: return errors other than -ENOMEM to socket
>   vsock: add netdev to vhost/virtio vsock
>   virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
>   virtio/vsock: add support for dgram
> 
> Jiang Wang (1):
>   vsock_test: add tests for vsock dgram
> 
>  drivers/vhost/vsock.c                   | 238 ++++----
>  include/linux/virtio_vsock.h            |  73 ++-
>  include/net/af_vsock.h                  |   2 +
>  include/uapi/linux/virtio_vsock.h       |   2 +
>  net/vmw_vsock/af_vsock.c                |  30 +-
>  net/vmw_vsock/hyperv_transport.c        |   2 +-
>  net/vmw_vsock/virtio_transport.c        | 237 +++++---
>  net/vmw_vsock/virtio_transport_common.c | 771 ++++++++++++++++--------
>  net/vmw_vsock/vmci_transport.c          |   9 +-
>  net/vmw_vsock/vsock_loopback.c          |  51 +-
>  tools/testing/vsock/util.c              | 105 ++++
>  tools/testing/vsock/util.h              |   4 +
>  tools/testing/vsock/vsock_test.c        | 195 ++++++
>  13 files changed, 1176 insertions(+), 543 deletions(-)
> 
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
