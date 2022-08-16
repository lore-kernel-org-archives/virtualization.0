Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDE2C32771
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 07:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC5EC81B69;
	Tue, 16 Aug 2022 07:00:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC5EC81B69
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gu57MHDr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gX43IO0jTu7N; Tue, 16 Aug 2022 07:00:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D1CA181A6A;
	Tue, 16 Aug 2022 07:00:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1CA181A6A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAEC2C0033;
	Tue, 16 Aug 2022 07:00:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C32C4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9CF9560EFE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:00:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9CF9560EFE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gu57MHDr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RVvlaTMI4dCY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:00:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56E4660ECD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56E4660ECD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660633250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JCFrsPXem3FU0mZ1VRz5YdC1rlpN6fc+j+TNrMZg18A=;
 b=gu57MHDrSFKwdtTZGjmnDuYjhcRachJ/22Guwua7Lvqo3dwJO6JcTFj0lek5EZ26JqepP2
 8epf1JleZn5olf9BeepSlUMYj2pjTNtXHkuIh+jvM/6DLQKXqFyN0rhjr3WOHn9t/Anf4s
 oLLD0OVVZlFqQU/sHaoJ1MfApxGHUb0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-jKUt9SJiNwa7zGJbnNu3RQ-1; Tue, 16 Aug 2022 03:00:49 -0400
X-MC-Unique: jKUt9SJiNwa7zGJbnNu3RQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 u7-20020a2e2e07000000b0025e4fbba9f0so2763430lju.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 00:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:x-gm-message-state:from:to:cc;
 bh=JCFrsPXem3FU0mZ1VRz5YdC1rlpN6fc+j+TNrMZg18A=;
 b=WC/8Gl8s2J+w/6VAqzCDgmUKrcjgzz1Xq4eBj4kFteRdu8KGrGTCpdMTg+oCAuAWiT
 IM72eziorAVGDzRjrgQRczkcmh5a37sbDoQKC+6NsSlWwoxAtq5X5PkHALIPUbuK7tJJ
 /B92DOZPOnM2yYyBEQaBUZdugAk8ifbdeXvUcISuxI4PdiWcRwmN80QVrGEoAyomLCa5
 uxAqmKQudkjh9CpVzQ+vu7khiuIdLUakJ3b59DiRM1nyybBRJkrp3oGMK6uCqqMO4Kam
 pc8KUMmC9VdZIND1O2YHGXntuI11L6dzUZUQ2+q7IKxZyZOutL+zBadov7DyecGdmD6A
 qcMg==
X-Gm-Message-State: ACgBeo1tZa679HTMhJtNOsjYEWvcbQbsNEBjnvZbXupkpnoXhJds1eYs
 aTFI0pllzy+p7GU22JdRSHIgljz148rX/V2sWLZPMIXZDqO/xGHCJOVEp/NKClMXYAfCKTjtK4r
 saiQsYSLzPJmpxQM2hFAdbwbmL07Vy51dNRZ7Um59S1tRJPBvwLoGOQWXmg==
X-Received: by 2002:a05:6512:3d1d:b0:48a:f9fd:4058 with SMTP id
 d29-20020a0565123d1d00b0048af9fd4058mr6680681lfv.363.1660633247497; 
 Tue, 16 Aug 2022 00:00:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ZVDeSKaAHxOM+PYvk43Q0tmWKkqzczuoAMTVwYU4f0O4hMWXyoQjz7tvwUyVqnw398WztFOE89rUl1/CBefQ=
X-Received: by 2002:a05:6512:3d1d:b0:48a:f9fd:4058 with SMTP id
 d29-20020a0565123d1d00b0048af9fd4058mr6680663lfv.363.1660633247292; Tue, 16
 Aug 2022 00:00:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:5f07:0:0:0:0:0 with HTTP; Tue, 16 Aug 2022 00:00:45
 -0700 (PDT)
In-Reply-To: <cover.1660362668.git.bobby.eshleman@bytedance.com>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 16 Aug 2022 09:00:45 +0200
Message-ID: <CAGxU2F7+L-UiNPtUm4EukOgTVJ1J6Orqs1LMvhWWvfL9zWb23g@mail.gmail.com>
Subject: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
To: Bobby Eshleman <bobby.eshleman@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Cong Wang <cong.wang@bytedance.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
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
Content-Type: multipart/mixed; boundary="===============2509355413268712857=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2509355413268712857==
Content-Type: multipart/alternative; boundary="000000000000ceb96d05e6564e1f"

--000000000000ceb96d05e6564e1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bobby,
I=E2=80=99m on vacation so I=E2=80=99ll review this series when I=E2=80=99m=
 back on 28th.

Please send next versions of this series as RFC until we have at least an
agreement on the spec changes.

I think will be better to agree on the spec before merge Linux changes.

Thanks,
Stefano

On Monday, August 15, 2022, Bobby Eshleman <bobby.eshleman@gmail.com> wrote=
:

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
>   - Some qdiscs, like SFQ, may allow vsock to avoid transport layer
> congestion. That is,
>     it may avoid datagrams from flooding out stream flows. The benefit
>     to this is that additional virtqueues are not needed for datagrams.
>   - The net_device and qdisc is bypassed by simply setting the
>     net_device state to DOWN.
>
> [1]: https://lore.kernel.org/all/20210914055440.3121004-1-jiang.
> wang@bytedance.com/
>
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
>
>

--000000000000ceb96d05e6564e1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bobby,<br>I=E2=80=99m on vacation so I=E2=80=99ll review this series whe=
n I=E2=80=99m back on 28th.<div><br></div><div>Please send next versions of=
 this series as RFC until we have at least an agreement on the spec changes=
.</div><div><br></div><div>I think will be better to agree on the spec befo=
re merge Linux changes.</div><div><br></div><div>Thanks,</div><div>Stefano<=
br><br></div><div>On Monday, August 15, 2022, Bobby Eshleman &lt;<a href=3D=
"mailto:bobby.eshleman@gmail.com" target=3D"_blank">bobby.eshleman@gmail.co=
m</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hey everybody,<br>
<br>
This series introduces datagrams, packet scheduling, and sk_buff usage<br>
to virtio vsock.<br>
<br>
The usage of struct sk_buff benefits users by a) preparing vsock to use<br>
other related systems that require sk_buff, such as sockmap and qdisc,<br>
b) supporting basic congestion control via sock_alloc_send_skb, and c)<br>
reducing copying when delivering packets to TAP.<br>
<br>
The socket layer no longer forces errors to be -ENOMEM, as typically<br>
userspace expects -EAGAIN when the sk_sndbuf threshold is reached and<br>
messages are being sent with option MSG_DONTWAIT.<br>
<br>
The datagram work is based off previous patches by Jiang Wang[1].<br>
<br>
The introduction of datagrams creates a transport layer fairness issue<br>
where datagrams may freely starve streams of queue access. This happens<br>
because, unlike streams, datagrams lack the transactions necessary for<br>
calculating credits and throttling.<br>
<br>
Previous proposals introduce changes to the spec to add an additional<br>
virtqueue pair for datagrams[1]. Although this solution works, using<br>
Linux&#39;s qdisc for packet scheduling leverages already existing systems,=
<br>
avoids the need to change the virtio specification, and gives additional<br=
>
capabilities. The usage of SFQ or fq_codel, for example, may solve the<br>
transport layer starvation problem. It is easy to imagine other use<br>
cases as well. For example, services of varying importance may be<br>
assigned different priorities, and qdisc will apply appropriate<br>
priority-based scheduling. By default, the system default pfifo qdisc is<br=
>
used. The qdisc may be bypassed and legacy queuing is resumed by simply<br>
setting the virtio-vsock%d network device to state DOWN. This technique<br>
still allows vsock to work with zero-configuration.<br>
<br>
In summary, this series introduces these major changes to vsock:<br>
<br>
- virtio vsock supports datagrams<br>
- virtio vsock uses struct sk_buff instead of virtio_vsock_pkt<br>
=C2=A0 - Because virtio vsock uses sk_buff, it also uses sock_alloc_send_sk=
b,<br>
=C2=A0 =C2=A0 which applies the throttling threshold sk_sndbuf.<br>
- The vsock socket layer supports returning errors other than -ENOMEM.<br>
=C2=A0 - This is used to return -EAGAIN when the sk_sndbuf threshold is<br>
=C2=A0 =C2=A0 reached.<br>
- virtio vsock uses a net_device, through which qdisc may be used.<br>
=C2=A0- qdisc allows scheduling policies to be applied to vsock flows.<br>
=C2=A0 - Some qdiscs, like SFQ, may allow vsock to avoid transport layer co=
ngestion. That is,<br>
=C2=A0 =C2=A0 it may avoid datagrams from flooding out stream flows. The be=
nefit<br>
=C2=A0 =C2=A0 to this is that additional virtqueues are not needed for data=
grams.<br>
=C2=A0 - The net_device and qdisc is bypassed by simply setting the<br>
=C2=A0 =C2=A0 net_device state to DOWN.<br>
<br>
[1]: <a href=3D"https://lore.kernel.org/all/20210914055440.3121004-1-jiang.=
wang@bytedance.com/" target=3D"_blank">https://lore.kernel.org/all/20<wbr>2=
10914055440.3121004-1-jiang.<wbr>wang@bytedance.com/</a><br>
<br>
Bobby Eshleman (5):<br>
=C2=A0 vsock: replace virtio_vsock_pkt with sk_buff<br>
=C2=A0 vsock: return errors other than -ENOMEM to socket<br>
=C2=A0 vsock: add netdev to vhost/virtio vsock<br>
=C2=A0 virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit<br>
=C2=A0 virtio/vsock: add support for dgram<br>
<br>
Jiang Wang (1):<br>
=C2=A0 vsock_test: add tests for vsock dgram<br>
<br>
=C2=A0drivers/vhost/vsock.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 238 ++++----<br>
=C2=A0include/linux/virtio_vsock.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 73 ++-<br>
=C2=A0include/net/af_vsock.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0include/uapi/linux/virtio_vso<wbr>ck.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A02 +<br>
=C2=A0net/vmw_vsock/af_vsock.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 30 +-<br>
=C2=A0net/vmw_vsock/hyperv_transpor<wbr>t.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +-<br>
=C2=A0net/vmw_vsock/virtio_transpor<wbr>t.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 23=
7 +++++---<br>
=C2=A0net/vmw_vsock/virtio_transpor<wbr>t_common.c | 771 ++++++++++++++++--=
------<br>
=C2=A0net/vmw_vsock/vmci_transport.<wbr>c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A09 +-<br>
=C2=A0net/vmw_vsock/vsock_loopback.<wbr>c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 51 +-<br>
=C2=A0tools/testing/vsock/util.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 105 ++++<br>
=C2=A0tools/testing/vsock/util.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A04 +<br>
=C2=A0tools/testing/vsock/vsock_tes<wbr>t.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 19=
5 ++++++<br>
=C2=A013 files changed, 1176 insertions(+), 543 deletions(-)<br>
<br>
-- <br>
2.35.1<br>
<br>
</blockquote></div>

--000000000000ceb96d05e6564e1f--


--===============2509355413268712857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2509355413268712857==--

