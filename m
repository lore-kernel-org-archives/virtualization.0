Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AA6C433EF
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 11:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8698A41705;
	Thu, 12 May 2022 11:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BjieJfQw5UVP; Thu, 12 May 2022 11:33:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DDBE2419D9;
	Thu, 12 May 2022 11:33:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 269BEC0080;
	Thu, 12 May 2022 11:33:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1000FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4BD2405B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ASpZ_l0aUrkQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB9B640025
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:21 +0000 (UTC)
Received: by mail-lj1-x244.google.com with SMTP id a30so6086432ljq.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tAEF+dbAnD48BnBbAU0BUAa+dO/2WAcVo20DYQ9S6dE=;
 b=UECWek238lb5RAmbHwzkIpgTNSdQ11Yfb8ASl/tP0D+HQl0Nqfix/MsfOtRNoHmEoS
 pYBiTFYwqDnkFF343Jlt3myrxbowelTAS5vAFp0X7RR2jW5QCI2kbGW96q+UKMSumJNJ
 PEJfOawrzMY/t1idHbgtWH70hLVne5s81XWksgpHJcGY3C9FjeD67VdEw6HQFbr+WXH0
 xSf6hh+TNj7Dn0ymg9FSV7zWtFdX4X4bqBplo0p+zej1/q35zQV5l9nrAfOLPIslbS8J
 XNFEy2vMChSbY1nrUdDWMiOuZ/0wXzvOBejBKQ9CHEY++XqhZiqizqEV4u8BCPclfeW+
 beMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tAEF+dbAnD48BnBbAU0BUAa+dO/2WAcVo20DYQ9S6dE=;
 b=lsu7R1F8UF6dAAq7/zDHplYHVVyt7BuDVkjFzg0cIc1Bgbj0ZZQXjryq6VrZVXIfXK
 51yG4EGDPmYxK3W0fYY7Cr8Z0Om3vaf+SlVBFZzVos7vW6gIyrd0eEvG3W5Tt0IRTqr3
 eea4jtzp+mO1ikA8dPFB+2yo607S4YC/ldDi45LztPr2Oa3d3DMPCVdxk0JN/6boDFhy
 n9jgCLcSIS01w0vChtftHetvSKIIBALHM16HCTZceynCX0vWNhlIOfyxW+4RKhGCDOEn
 nudO11a/7jVIzRJjKYw8Ly+1iQCzvXjKiXa2to38FzVfdo8ZfoZvQPFSGyOdasYWWM1Z
 /MIA==
X-Gm-Message-State: AOAM5314bPhrdl2aj/O3ySGA24POOxo+YmxNXe4Y7N2jxcDJXzSEKhc7
 H6FWTXyiXsnk0E5ycxZVuv4h6g==
X-Google-Smtp-Source: ABdhPJxbMhTJ/x3wO6IIZjV3v1LV5Xd7J4V3uaASWzpb6lVcAwwLrn2oTVIUr8sq/9IvOQe5/iJWbQ==
X-Received: by 2002:a2e:9645:0:b0:24f:2e6f:f931 with SMTP id
 z5-20020a2e9645000000b0024f2e6ff931mr20426742ljh.466.1652355198391; 
 Thu, 12 May 2022 04:33:18 -0700 (PDT)
Received: from localhost.localdomain (host-188-190-49-235.la.net.ua.
 [188.190.49.235]) by smtp.gmail.com with ESMTPSA id
 r29-20020ac25a5d000000b0047255d211a6sm741758lfn.213.2022.05.12.04.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 04:33:17 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH v2 0/5] TUN/VirtioNet USO features support.
Date: Thu, 12 May 2022 14:23:42 +0300
Message-Id: <20220512112347.18717-1-andrew@daynix.com>
X-Mailer: git-send-email 2.35.1
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
It allows to transmission of large UDP packets.

Different features USO4 and USO6 are required for qemu where Windows guests can
enable disable USO receives for IPv4 and IPv6 separately.
On the other side, Linux can't really differentiate USO4 and USO6, for now.
For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
In the future, there would be a mechanism to control UDP_L4 GSO separately.

Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2

New types for VirtioNet already on mailing:
https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html

Also, there is a known issue with transmitting packages between two guests.
Without hacks with skb's GSO - packages are still segmented on the host's postrouting.

Andrew (5):
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
 6 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
