Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C40AEB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 17:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D26616110D;
	Thu,  6 Jul 2023 17:06:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D26616110D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Etr/KpRs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Up1Ii76HZM3o; Thu,  6 Jul 2023 17:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F18E6110B;
	Thu,  6 Jul 2023 17:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F18E6110B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 261F4C0072;
	Thu,  6 Jul 2023 17:06:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E990CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 17:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C22CD41872
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 17:06:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C22CD41872
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Etr/KpRs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4FHqr47bK-Yh
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 17:06:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B875A4099E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B875A4099E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688663197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QM/UutVaUSnuvT54IV8uHxbnE8kyc0wDH+u+J+MujRA=;
 b=Etr/KpRs3nuZbf3s4l6vc+G9s51+D6AuMrb1v+afd+ZHJaUCg8/ugIICjZa+YNsmJBfDW3
 Fyd9d7/ZGQYt3KjWKYEZ2TTAyxUDtI/dCINU+BwvcW6TL+fzF0v0jmSqwNrCXtfqlHkohj
 HXgac+RnS4tQuZniCEQhs4lKCPzCNIo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-SlnVevXqO22F14hAyNICew-1; Thu, 06 Jul 2023 13:06:36 -0400
X-MC-Unique: SlnVevXqO22F14hAyNICew-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-573a92296c7so10610547b3.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 10:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688663188; x=1691255188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QM/UutVaUSnuvT54IV8uHxbnE8kyc0wDH+u+J+MujRA=;
 b=MM5i81Qs5l/bUYOp/9pJzEZb6SVeUA+e9BQk1m3DQecJb+oqD+Tcw/vkIAinf4N1Oj
 Qp7oV90yj0TUUalfuoE26hAnTKlLvv+GH7gUIZTqNAq5XKjK4+l9Tk5M/CnyZhJKapXj
 7kJX5pI14vqathTOOVYuw83QmE8oSQ3P7i1AnV6b/Y3B4Dto/FBAo/Jp/ArRzCZ/7HHo
 yd8GTColURsGWOUGc0i5bjBpCMrLmA0oucJwWFFWR1XgejRecgFKPZoGGaz6nY57SjpB
 0+WB5xVoEqRMOW6ULZvRwZ7+cxBPY/Yo+MgtTzHRHk7zBzvDvQugVk5K+irsmTT1PIT+
 /ikg==
X-Gm-Message-State: ABy/qLaHMC6TfL2aLy8mytFh2H0UuezgXFzt+8TBYI7ii4wCIL0UUxPv
 rgK3xlqzuw2Mt4UX7Zqi8l6zhsXSnjdTk2wEUcgOFp6cGJ5Jz4dutoAMtyhWU7wkrJ4oKygVRvN
 b+YZlPZDtdxNNO2c1L88oDBV32sK4x3TeznkEs979qT60AatRpj25fHUQhw==
X-Received: by 2002:a81:71c2:0:b0:577:2f3f:ddbb with SMTP id
 m185-20020a8171c2000000b005772f3fddbbmr2826581ywc.47.1688663188583; 
 Thu, 06 Jul 2023 10:06:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGUPhZB++pPprAX0mNv8YwgUVnvLjCcxh4OxP6jPuw+p92V0NCOAKC1wTT6antIgmpYOn5jTkY1ZGQ2v0ndfQ4=
X-Received: by 2002:a81:71c2:0:b0:577:2f3f:ddbb with SMTP id
 m185-20020a8171c2000000b005772f3fddbbmr2826555ywc.47.1688663188348; Thu, 06
 Jul 2023 10:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-15-AVKrasnov@sberdevices.ru>
In-Reply-To: <20230701063947.3422088-15-AVKrasnov@sberdevices.ru>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 6 Jul 2023 19:06:17 +0200
Message-ID: <CAGxU2F410NSNSzdNS4m-9UM8rZFBFpe5LeNZtkF0VzJc5_JFmg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 14/17] docs: net: description of MSG_ZEROCOPY for
 AF_VSOCK
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Sat, Jul 01, 2023 at 09:39:44AM +0300, Arseniy Krasnov wrote:
>This adds description of MSG_ZEROCOPY flag support for AF_VSOCK type of
>socket.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Documentation/networking/msg_zerocopy.rst | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/networking/msg_zerocopy.rst b/Documentation/networking/msg_zerocopy.rst
>index b3ea96af9b49..34bc7ff411ce 100644
>--- a/Documentation/networking/msg_zerocopy.rst
>+++ b/Documentation/networking/msg_zerocopy.rst
>@@ -7,7 +7,8 @@ Intro
> =====
>
> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
>-The feature is currently implemented for TCP and UDP sockets.
>+The feature is currently implemented for TCP, UDP and VSOCK (with
>+virtio transport) sockets.
>
>
> Opportunity and Caveats
>@@ -174,7 +175,7 @@ read_notification() call in the previous snippet. A notification
> is encoded in the standard error format, sock_extended_err.
>
> The level and type fields in the control data are protocol family
>-specific, IP_RECVERR or IPV6_RECVERR.
>+specific, IP_RECVERR or IPV6_RECVERR (for TCP or UDP socket).
>
> Error origin is the new type SO_EE_ORIGIN_ZEROCOPY. ee_errno is zero,
> as explained before, to avoid blocking read and write system calls on
>@@ -201,6 +202,7 @@ undefined, bar for ee_code, as discussed below.
>
>       printf("completed: %u..%u\n", serr->ee_info, serr->ee_data);
>
>+For VSOCK socket, cmsg_level will be SOL_VSOCK and cmsg_type will be 0.

Maybe better to move up, just under the previous change.

By the way, should we define a valid type value for vsock
(e.g. VSOCK_RECVERR)?

>
> Deferred copies
> ~~~~~~~~~~~~~~~
>@@ -235,12 +237,15 @@ Implementation
> Loopback
> --------
>
>+For TCP and UDP:
> Data sent to local sockets can be queued indefinitely if the receive
> process does not read its socket. Unbound notification latency is not
> acceptable. For this reason all packets generated with MSG_ZEROCOPY
> that are looped to a local socket will incur a deferred copy. This
> includes looping onto packet sockets (e.g., tcpdump) and tun devices.
>
>+For VSOCK:
>+Data path sent to local sockets is the same as for non-local sockets.
>
> Testing
> =======
>@@ -254,3 +259,6 @@ instance when run with msg_zerocopy.sh between a veth pair across
> namespaces, the test will not show any improvement. For testing, the
> loopback restriction can be temporarily relaxed by making
> skb_orphan_frags_rx identical to skb_orphan_frags.
>+
>+For VSOCK type of socket example can be found in  tools/testing/vsock/
>+vsock_test_zerocopy.c.

For VSOCK socket, example can be found in
tools/testing/vsock/vsock_test_zerocopy.c

(we should leave the entire path on the same line)

>--
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
