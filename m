Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C189EE7AD76
	for <virtualization@archiver.kernel.org>; Tue,  3 Oct 2023 16:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5AB214052A;
	Tue,  3 Oct 2023 16:24:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AB214052A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yea67Fgg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o5j69dLunryr; Tue,  3 Oct 2023 16:24:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C405840182;
	Tue,  3 Oct 2023 16:23:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C405840182
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ACD4C0071;
	Tue,  3 Oct 2023 16:23:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A998EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91CBF4052A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 91CBF4052A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K5rDXD4UWx7H
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51E3140182
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51E3140182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696350236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BApKczrxEPgLzQsQyB3wpnpVoMtABSfbJmV036In4jc=;
 b=Yea67FggXt4uBFK8u85XeX2GxWoaw37JsGCJP0MRO3XJm2x44/ks0GHMsJoIzMBrBt9V6+
 1oYrIchG0pOv5UbSpCm77VNNFQF9fvvpRmGW0GHoPOHNfmIt4l+Ea84oQl/LoO9yLvU9wk
 /UMnoDQr8zBlqPgiZd45h85jbq2mLmw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-wO7ZGNaCNnaqzY03vanG-Q-1; Tue, 03 Oct 2023 12:23:53 -0400
X-MC-Unique: wO7ZGNaCNnaqzY03vanG-Q-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-d8141d6fbe3so1257058276.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Oct 2023 09:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696350233; x=1696955033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BApKczrxEPgLzQsQyB3wpnpVoMtABSfbJmV036In4jc=;
 b=rl2sXRYBNNxzs/6JCQl2tOAGQf7iV5pce9CKGAqt1CTUiDGKv6FRB4LgE34dG8+2GO
 Pip7EXXOxd1B350SurXgMjDmiJJkvtZTCXYYtrzFXQnOXeHl4F1EHNmjxISsbBlbzk2A
 gXAlvAVtB9jyOAMh988P7yVYrdzVjljFSLO19r9o3fVXLXXae6KCRXtIPeXCJ+76GcFS
 ScbbAkiZPEIrEaYLSb66lq3CWrzHUnuIQyyhqlWGHrEYvQ60vDaQQjYQJP3u1JZ38d+a
 CiCfPifBhQ3v3QBnXdLOCZR2CN/BfutV0obH0JuljpmB8Aw9scRpetWUpsfVZK3gEWBM
 LVbw==
X-Gm-Message-State: AOJu0Yx6fyl+zCFpTTcS2d3NWmI5S1GsLwU7WvrQUMK8W5Qrw5NqrXYn
 xtapn2FVJDDNO4SofkQipAoeJwwmQiDQXjN68CcFo4IfYrcMZUfN1FP9IFSryBZxYEESn0VjcWU
 XNoRfWZlTBoYJOCBEW9bmKtLuFUW5Rw6EN7ZTTgM3Ug==
X-Received: by 2002:a25:6fc1:0:b0:d74:62df:e802 with SMTP id
 k184-20020a256fc1000000b00d7462dfe802mr13099896ybc.0.1696350233386; 
 Tue, 03 Oct 2023 09:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFA4CkY3jrhTI4v/yIBb1i8/xVZlYFpMjG1ENvBNmWm2bYF1ZcRT0YuJJUdqErnU00bMgI0g==
X-Received: by 2002:a25:6fc1:0:b0:d74:62df:e802 with SMTP id
 k184-20020a256fc1000000b00d7462dfe802mr13099882ybc.0.1696350233091; 
 Tue, 03 Oct 2023 09:23:53 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 y6-20020a0ce046000000b0065823d20381sm596479qvk.8.2023.10.03.09.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 09:23:52 -0700 (PDT)
Date: Tue, 3 Oct 2023 18:23:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v2 09/12] docs: net: description of MSG_ZEROCOPY
 for AF_VSOCK
Message-ID: <waco5sx7dxzvb7ogs3nnxugrt7afppk3432wc2fwwovic5y4pa@wmdi3tis36rz>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <20230930210308.2394919-10-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230930210308.2394919-10-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Oct 01, 2023 at 12:03:05AM +0300, Arseniy Krasnov wrote:
>This adds description of MSG_ZEROCOPY flag support for AF_VSOCK type of
>socket.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Documentation/networking/msg_zerocopy.rst | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/Documentation/networking/msg_zerocopy.rst b/Documentation/networking/msg_zerocopy.rst
>index b3ea96af9b49..78fb70e748b7 100644
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
>@@ -174,7 +175,9 @@ read_notification() call in the previous snippet. A notification
> is encoded in the standard error format, sock_extended_err.
>
> The level and type fields in the control data are protocol family
>-specific, IP_RECVERR or IPV6_RECVERR.
>+specific, IP_RECVERR or IPV6_RECVERR (for TCP or UDP socket).
>+For VSOCK socket, cmsg_level will be SOL_VSOCK and cmsg_type will be
>+VSOCK_RECVERR.
>
> Error origin is the new type SO_EE_ORIGIN_ZEROCOPY. ee_errno is zero,
> as explained before, to avoid blocking read and write system calls on
>@@ -235,12 +238,15 @@ Implementation
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
>@@ -254,3 +260,6 @@ instance when run with msg_zerocopy.sh between a veth pair across
> namespaces, the test will not show any improvement. For testing, the
> loopback restriction can be temporarily relaxed by making
> skb_orphan_frags_rx identical to skb_orphan_frags.
>+
>+For VSOCK type of socket example can be found in
>+tools/testing/vsock/vsock_test_zerocopy.c.
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
