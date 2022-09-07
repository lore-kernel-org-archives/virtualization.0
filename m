Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5511C38145
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 12:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFC9F60AEF;
	Wed,  7 Sep 2022 12:51:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CFC9F60AEF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Ua/cyoxQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VWLRTM45e73R; Wed,  7 Sep 2022 12:51:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 769ED60AF0;
	Wed,  7 Sep 2022 12:51:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 769ED60AF0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 351A2C0033;
	Wed,  7 Sep 2022 12:51:17 +0000 (UTC)
Received: from smtp4.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe79:d16b])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56AADC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A64D40890
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A64D40890
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=Ua/cyoxQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QtkaBRK2BJHw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF718405AA
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF718405AA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:13 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id s23so8691528wmj.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=Eixd0LQlH9rFcFjWqY+uzWCg74XW8uX92B343SAZfdI=;
 b=Ua/cyoxQXRqo0RqGtbjFqvKgM9vCY0kNMhEbEbPQnYmskVEQSSAs2UjliwH+aDY92z
 Dm0deZY0cQBo7YmcaodkWAg4uwigGImN3kqL5BRQ0Cdv59fRCz/630LrjITA2g3MBcTJ
 Orqz3NW40BVAgBUkcsjP+R42xeriW2nsEMBC61s+eqWcqcWxK4b8D06d0FAC7g0B/nua
 RsgHocu5HNwvpRdN1fkrZCQfJLwtmv9sv0x0Aq2Lggd6uRsqyXpjbVC2g8YFusAHVSew
 y0bUUr/rvmnvu3T7f8Um+fYaVTLUZWPczhNY0OYatwtsUBocMr07kWIT/zy7yKyTAe4/
 7h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=Eixd0LQlH9rFcFjWqY+uzWCg74XW8uX92B343SAZfdI=;
 b=K4gcscKTYn4Y7w3q+v1xHDGvLPDezrgk9KD+Tot7mUwGEcGFvecLR6RzP4NDV+FCO6
 pJeZhrhWlDoqdj8YLeb93ZfPsTvgOvMuP4U/+d77fgaVILd9YxPRVY5r+BAPWqS857Uy
 WmPUrDFTcIhceBxCg2sUel9d1fRHRCrY+FwHWdmS1DJYa76rRS4tcljectI+Jrk/nRbb
 kKEjb+X/wVp8eINDjl6nDLPJG1Pn0zQg3UEekkyvaq6dsWPPJ9glgn0ucBmeUkYNRSG9
 hPpICbp9h99CLLY6eCbi4fsuTe9GpX9wk0TJJY0Ey+wWthV6IJGUlRZxysGD4x4anN81
 bJlQ==
X-Gm-Message-State: ACgBeo0S1XV/7+z1Y3QG9Go4Qwi4oXeoM1KGq5k3kvlSzfibcU7kF4Yn
 2vHhALahVYIVnrOvvj4Ik5b5xw==
X-Google-Smtp-Source: AA6agR5nqbud/xqJWh1gRcFJdSIwxrCkx4UG/dfRBJj0MMjTrVl4a1rLD1tnDU/z+D4K1HRYzI57Tw==
X-Received: by 2002:a05:600c:22cd:b0:3a6:7b62:3778 with SMTP id
 13-20020a05600c22cd00b003a67b623778mr1937379wmg.45.1662555072169; 
 Wed, 07 Sep 2022 05:51:12 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 e27-20020adf9bdb000000b0021f0ff1bc6csm11480001wrc.41.2022.09.07.05.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 05:51:11 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: edumazet@google.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, jasowang@redhat.com, mst@redhat.com,
 pabeni@redhat.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org
Subject: [PATCH v3 0/6] TUN/VirtioNet USO features support.
Date: Wed,  7 Sep 2022 15:50:42 +0300
Message-Id: <20220907125048.396126-1-andrew@daynix.com>
X-Mailer: git-send-email 2.37.2
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

Different features USO4 and USO6 are required for qemu where Windows guests can
enable disable USO receives for IPv4 and IPv6 separately.
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
 drivers/net/virtio_net.c        | 19 +++++++++++++++----
 include/linux/virtio_net.h      |  9 +++++++++
 include/uapi/linux/if_tun.h     |  2 ++
 include/uapi/linux/virtio_net.h |  5 +++++
 net/ipv4/udp_offload.c          |  2 +-
 7 files changed, 47 insertions(+), 8 deletions(-)

-- 
2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
