Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EECEC352A1
	for <virtualization@archiver.kernel.org>; Wed,  7 Dec 2022 11:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1587C81FC9;
	Wed,  7 Dec 2022 11:51:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1587C81FC9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=sjDaCL94
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FvKaKQI5gkom; Wed,  7 Dec 2022 11:51:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7E85081E42;
	Wed,  7 Dec 2022 11:51:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E85081E42
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49826C0033;
	Wed,  7 Dec 2022 11:51:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B16F8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 785DA61096
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 785DA61096
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=sjDaCL94
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B8ACbhPx1a53
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 327F161080
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 327F161080
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:26 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id m18so11823734eji.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Dec 2022 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DBe07ljlXyo0ttSKiN3zuuVFa38DRlnL73q8otf9TSw=;
 b=sjDaCL945dy0KcUZ8thrIDPspuRtiTokb0ndoNkAROQMdpLe5kMaQco70Ip0SL3yhD
 7PD1oSoL17ZZUdVzTXnFnHOWz9hUuz21ekmtxXYzBHtlmzJXF5BjucnyQG9B/DdTlsNt
 gqTlvABiJZ+dlrySl6mlcJ9+GWrsOX0BbV2rEU+LvA4vDIJ26EtsDlf7j5gotdw8YfiX
 FEO5/sdlYCxNGFZzz7Oti/QwHYFV59i0zH5Bplb7HByhNljHrAFNN+D4uuTSwSmlwOA/
 dDO/UYXL0m9/gPb9u2YI+cs8tGZzEsKNMAFeAuNEGkT1NPSXnHqZ0BYl8Vx52d55Tygk
 CKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DBe07ljlXyo0ttSKiN3zuuVFa38DRlnL73q8otf9TSw=;
 b=422n1pOsRHVXuHtj3EXqDSxPurDFYaIbPXjXRxMdZS6a8XHhWmX5IRnhDIoepib3tM
 J7jE+LYIqpQviSZ+saaqB9c6mIQORDe+qzzMycTGuS7LriLSxCFnudrbK6cE87r/8MBh
 HWbGw4DwsdBuMi4VgZbaTLPEl6Cc4nCzudmqW6SNWsI7mu5Zbpaz9Mc2nrijoW/b4JJS
 Jyr+JTq4ByEo0NoYIerm/KPK5QOlHLXy4gpqMHs8pbF8vKP2McosaTiRQkbY7AHsIDdX
 lz8wOUcDWgQIgp5lNorebcJA69C6r3aqWAvj/s5xg0G8a+3Q/H4t+hIQnFa2Wc0JGbGF
 hRCw==
X-Gm-Message-State: ANoB5pnw+mZdWRIyZFsHjAK7eSZSnXSgLGU+SJUU52yxLog/GabVZw17
 cXa3JoWsN2Y9oAr+vY+c2SYBXg==
X-Google-Smtp-Source: AA0mqf6UUiqke0lAkj898uNbfcI3c5cF0JtWZI1v2Dvi3QmAvQKNzuh5e1iZoSYanD5Cnu+m/mTkyQ==
X-Received: by 2002:a17:906:f281:b0:7ae:3b9e:1d8a with SMTP id
 gu1-20020a170906f28100b007ae3b9e1d8amr73129171ejb.581.1670413884373; 
 Wed, 07 Dec 2022 03:51:24 -0800 (PST)
Received: from localhost.localdomain ([193.33.38.48])
 by smtp.gmail.com with ESMTPSA id
 g26-20020a056402181a00b004618a89d273sm2132816edy.36.2022.12.07.03.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Dec 2022 03:51:23 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v5 0/6] TUN/VirtioNet USO features support.
Date: Wed,  7 Dec 2022 13:35:52 +0200
Message-Id: <20221207113558.19003-1-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

Changes since v4 & RFC:
 * Fixed typo and refactored.
 * Tun USO offload refactored.
 * Add support for guest-to-guest segmentation offload (thx Jason).

Andrew Melnychenko (6):
  udp: allow header check for dodgy GSO_UDP_L4 packets.
  uapi/linux/if_tun.h: Added new offload types for USO4/6.
  driver/net/tun: Added features for USO.
  uapi/linux/virtio_net.h: Added USO types.
  linux/virtio_net.h: Support USO offload in vnet header.
  drivers/net/virtio_net.c: Added USO support.

 drivers/net/tap.c               | 10 ++++++++--
 drivers/net/tun.c               |  8 +++++++-
 drivers/net/virtio_net.c        | 19 +++++++++++++++----
 include/linux/virtio_net.h      |  9 +++++++++
 include/uapi/linux/if_tun.h     |  2 ++
 include/uapi/linux/virtio_net.h |  4 ++++
 net/ipv4/udp_offload.c          |  3 ++-
 net/ipv6/udp_offload.c          |  3 ++-
 8 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
