Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3BCC4332F
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 22:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C66C41066;
	Thu,  1 Dec 2022 22:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C66C41066
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=4j5NUQ9Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EABhlIDM9mD9; Thu,  1 Dec 2022 22:12:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C2ABB40112;
	Thu,  1 Dec 2022 22:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2ABB40112
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91EFAC0032;
	Thu,  1 Dec 2022 22:12:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1032C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E4A682127
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:12:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E4A682127
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=4j5NUQ9Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id omOEy3BEXOPR
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:12:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64F9B82125
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 64F9B82125
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:12:07 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id fy37so7491526ejc.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xS2P4l3h67FXA/VaxZNf4GYyU7HMjaYo9LN5Y0vNp+c=;
 b=4j5NUQ9QdJc57qk824L+vXNEARliSp3Y2YM09ia9uXfX+4XV1Y3dOzHw+peBOIsPfw
 oqFKaK35oDA1QKOIS8ON/8sZHuQNyec1tsHa8sjWvizzo7OOA83WPtK8WX3lRt3sU+mv
 4ELV0XJuB3DVbDsmeQAJRkxQKOO5yIUxYThPpQH+kGvkf7wB0MEMrwHthDE1FC38VE14
 pF/cc7T2DxJ34QccGCvIaaJxm4pqWdQTCEguW5j86I1nuF/7AubfyTV0Pa3wMYAkb78+
 adEXWqVpLrlGYlK8fSqehtZLAYHhrrN0LDwzyLZJmgQ3xWT43Jb4/dO0SroCLGoFCtnk
 wLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xS2P4l3h67FXA/VaxZNf4GYyU7HMjaYo9LN5Y0vNp+c=;
 b=b1WrLID9c2FTiqDbts7s+rHqZ6gxtlfR/N6xIOrAKpmBvIcpxVNicic4VNX/oZ5w64
 6q+UE4PT6s3KGG9CBDAki2jCNvLsOsw3xtpbWKiKDa50zox7cbotzi9TSBKYzJexUqpB
 vp1i6Pbjj3hYK6g7udNWfA6rizY+Z/dc/eIpZ1+Ue5TKQ6fA0A5G6QulYKM5VYa+X2Gk
 yvRqYurbZ+z8q0Ht/g4qPNfYKefrazmyOXHZUbr7rYNurSgAQkIUpv1fPqhU6qWREskW
 iwU93DwFToMKqpYFtjSc39iaj8uQoqDfqeT8El2Bnb/wX3YHogkNrYcf5TIz9ARm8R7N
 PE4w==
X-Gm-Message-State: ANoB5pnOOafCwnlI0rlRTrg3GDbKmGWveVkQS/eEmkI3cXJGCQy/IR7r
 nZlSeil9LHrV6G8CnQPHoS+5jQ==
X-Google-Smtp-Source: AA0mqf6UzOvVeGPxnQxjxwIH4JOjFC003wnQEu5aMFSrUpWtBcU4R6aGxTPaBPL2zLpN5i1c9/Hk2g==
X-Received: by 2002:a17:906:ce4d:b0:7be:1b8b:21fc with SMTP id
 se13-20020a170906ce4d00b007be1b8b21fcmr23250111ejb.666.1669932725308; 
 Thu, 01 Dec 2022 14:12:05 -0800 (PST)
Received: from localhost.localdomain (46-133-148-166.mobile.vf-ua.net.
 [46.133.148.166]) by smtp.gmail.com with ESMTPSA id
 gf16-20020a170906e21000b007815ca7ae57sm2230726ejb.212.2022.12.01.14.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 14:12:04 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v4 0/6] TUN/VirtioNet USO features support.
Date: Thu,  1 Dec 2022 23:56:38 +0200
Message-Id: <20221201215644.246571-1-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Cc: devel@daynix.com
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

Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
Technically they enable NETIF_F_GSO_UDP_L4
(and only if USO4 & USO6 are set simultaneously).
It allows the transmission of large UDP packets.

UDP Segmentation Offload (USO/GSO_UDP_L4) - ability to split UDP packets
into several segments. It's similar to UFO, except it doesn't use IP
fragmentation. The drivers may push big packets and the NIC will split
them(or assemble them in case of receive), but in the case of VirtioNet
we just pass big UDP to the host. So we are freeing the driver from doing
the unnecessary job of splitting. The same thing for several guests
on one host, we can pass big packets between guests.

Different features USO4 and USO6 are required for qemu where Windows
guests can enable disable USO receives for IPv4 and IPv6 separately.
On the other side, Linux can't really differentiate USO4 and USO6, for now.
For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
In the future, there would be a mechanism to control UDP_L4 GSO separately.

New types for virtio-net already in virtio-net specification:
https://github.com/oasis-tcs/virtio-spec/issues/120

Test it WIP Qemu https://github.com/daynix/qemu/tree/USOv3

Andrew (5):
  uapi/linux/if_tun.h: Added new offload types for USO4/6.
  driver/net/tun: Added features for USO.
  uapi/linux/virtio_net.h: Added USO types.
  linux/virtio_net.h: Support USO offload in vnet header.
  drivers/net/virtio_net.c: Added USO support.

Andrew Melnychenko (1):
  udp: allow header check for dodgy GSO_UDP_L4 packets.

 drivers/net/tap.c               | 10 ++++++++--
 drivers/net/tun.c               |  8 +++++++-
 drivers/net/virtio_net.c        | 24 +++++++++++++++++++++---
 include/linux/virtio_net.h      |  9 +++++++++
 include/uapi/linux/if_tun.h     |  2 ++
 include/uapi/linux/virtio_net.h |  5 +++++
 net/ipv4/udp_offload.c          |  3 ++-
 net/ipv6/udp_offload.c          |  3 ++-
 8 files changed, 56 insertions(+), 8 deletions(-)

-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
