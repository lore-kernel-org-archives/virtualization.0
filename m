Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCB1C433F5
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 08:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C471403D8;
	Mon, 17 Jan 2022 08:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5YG6YzpODByW; Mon, 17 Jan 2022 08:00:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F04440343;
	Mon, 17 Jan 2022 08:00:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70211C0039;
	Mon, 17 Jan 2022 08:00:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF893C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D09EA81451
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b4sap8AAoOPO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:00:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 32D008144C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:00:34 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id p27so42725859lfa.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 00:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+H0zUCZv+PTbsjw6WPR3YzVb03mPL0wUh/zK0tt2hGw=;
 b=w3o2mfF/QcNtbmAO+X3N+3mZb66b8dPkWJSAzmHn/XQxtHKM4X9lxc6EZzTNmRSJh6
 mUFIqRpzqAzrChRDUmhTTr1n/IkAbq4TWwb8WfElWjG2kpoA/YuIvVqYLy62w8Dp1lCy
 Z7MdE8L9n6OlodsZDq0iOTCIdJUFxeKZUkzixzfJZcvq8Qx2KD0A7rRcrQi9bu7ZsRMD
 qMFy1wjG6KEImCBr19vgNwI5YFKGJn5mgIgKZvpXA2TBwioOIgTQ/LVe08oDrHbEn59m
 n2MS92npwB7ya7/C1nkj8UCFguanp293eKiiQVvwQQg8XMOdCewsqgWtyLMQ3aiwq72u
 uCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+H0zUCZv+PTbsjw6WPR3YzVb03mPL0wUh/zK0tt2hGw=;
 b=OW8DpFRjBEv3RqXDmBMrAylARBxle04PQqy03iX5LqfNPoMGOAADRolUAlwEk1pD4J
 er5VPlwmMMxMKy5zfJ8URmk5h8F0a3kytZ4HihM8w+C7HyYvTRrGuqMqwPHmChP+1Qoe
 TM3TqjIvCyaUBnQMhxO6v2YpWQ5eQRTwIeNTKhjLRTpnWIbRxExGAYD4stjHpzefQ9/Z
 9Z/OZPUa/P2MfuntaqncSiDWKO0cZWGSp2VcPq909EFy3Vm36dgbZbbFplz1QPPRPdv0
 oc8t+WMmy6TEQQd2neW2E2h0Y0VITDZmLeVqwTO2Fa+Ai5qN/ubSH7ESTAksYnSF5l5b
 Ktuw==
X-Gm-Message-State: AOAM531Fn3K8WHNRypNnkOTCUR4nIaTK2WMZ2a/LZBOUI4QXlyIZI/O0
 WFz49/IsrFHTZDAPXCl6cx0dzw==
X-Google-Smtp-Source: ABdhPJxO6ngGKXzadDc3G8zp/wx4Iok3uM6u7Dx6cWr47gGgibeoEZgtpG5Pnr8GbcbDUWBwVDLBQQ==
X-Received: by 2002:a2e:a5c9:: with SMTP id n9mr15395640ljp.220.1642406431042; 
 Mon, 17 Jan 2022 00:00:31 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id x18sm1279423ljd.105.2022.01.17.00.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jan 2022 00:00:30 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH v2 0/4] RSS support for VirtioNet.
Date: Mon, 17 Jan 2022 10:00:05 +0200
Message-Id: <20220117080009.3055012-1-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
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

Virtio-net supports "hardware" RSS with toeplitz key.
Also, it allows receiving calculated hash in vheader
that may be used with RPS.
Added ethtools callbacks to manipulate RSS.

Technically hash calculation may be set only for
SRC+DST and SRC+DST+PORTSRC+PORTDST hashflows.
The completely disabling hash calculation for TCP or UDP
would disable hash calculation for IP.

RSS/RXHASH is disabled by default.

Changes since v1:
* refactored virtnet_set_hashflow
* refactored virtio_net_ctrl_rss
* moved hunks between patches a bit

Changes since rfc:
* code refactored
* patches reformatted
* added feature validation

Andrew Melnychenko (4):
  drivers/net/virtio_net: Fixed padded vheader to use v1 with hash.
  drivers/net/virtio_net: Added basic RSS support.
  drivers/net/virtio_net: Added RSS hash report.
  drivers/net/virtio_net: Added RSS hash report control.

 drivers/net/virtio_net.c | 383 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 370 insertions(+), 13 deletions(-)

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
