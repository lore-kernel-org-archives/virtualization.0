Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF3AC433F5
	for <virtualization@archiver.kernel.org>; Mon, 28 Mar 2022 18:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C141240A91;
	Mon, 28 Mar 2022 18:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ncsXd_4GaqEk; Mon, 28 Mar 2022 18:01:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1BA64401A4;
	Mon, 28 Mar 2022 18:01:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D71B6C001D;
	Mon, 28 Mar 2022 18:01:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 975CAC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6EB3481767
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X6tdl5CJVvJH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7ACF681766
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:42 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id q5so20301961ljb.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uuYv067X4kT+NOzbPXQ219scQGqPB4cAH5gxcRBn5ME=;
 b=RyjbhIYZZ7QEgJfc3+9Bvvfbd8rZqEPj/OObh6rKDftThCHs1swjSvwR2LsVN2SMXn
 ACeJlGqAX0jZU6F0xlnzpYw7hbagCAR/zZLV+JNklkWGwSwvEW1KcmO7l78PUUW1OZgs
 wLtAHxeU1GiXwYZ5dlr2HBceQA4EVjrnVyjsofmW1YxlcOPqS8S+n+0/Cybudrx+USc7
 rYeomXkg6+VSjJSzSesLobXvpvMInAmwMTitRxEfPaI0eQ/8COOsr21qosO8ck+XJ7zq
 UJEaVw4GqdoS/oHfy7t42zHNWpI34jr4HGSu20CZOZJk3tulDkJdnNzdjdbaxmRyiwFS
 UPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uuYv067X4kT+NOzbPXQ219scQGqPB4cAH5gxcRBn5ME=;
 b=3A0Sb26gacWKdciQUGgJVij0LGZ6agfiEctzYKvLZ5rN34/Y2y1Ju6d6FnZPaf7JuB
 EoezvuAWj3JO1YmDOtA1Ny6Xki6D8Sh2AshNGhtPZSkeSRv3JErM+jtyBnUYWUbOUTtS
 K555ToiPzSSuLv605Ye22RIm+H33USBjOltT3AXP9RWoOuiVc7nhvdE4JVOdDNX8r75Y
 0uE+wi4BBScBKLNIGWFB/P04ssJ931R6Eztk5WeLE4m8WpSDTyfd64XUPTFZ2TjP86Rw
 580wqrjj26SG3PpXMKqep8Lb39DEa4yIXMF4Jf5D3Abj3PFMjme3kBw2saCn7KLYfPBn
 ZxoQ==
X-Gm-Message-State: AOAM532Uk39PM27lcXyfNMTuaqFKpeysjMn250/kog4yWHlugyCWxS/j
 FFA9fYqYizyDcd01UMMSXO8Y1w==
X-Google-Smtp-Source: ABdhPJyshjbv5zxOBh3CePhb4vs8HHNCKWvlGyNfSZ0PMMK0RCvdxXijXOCiAixCaIl0voXdnRAxrA==
X-Received: by 2002:a05:651c:17a3:b0:245:f39e:f2d2 with SMTP id
 bn35-20020a05651c17a300b00245f39ef2d2mr22295503ljb.490.1648490500316; 
 Mon, 28 Mar 2022 11:01:40 -0700 (PDT)
Received: from localhost.localdomain (host-188-190-49-235.la.net.ua.
 [188.190.49.235]) by smtp.gmail.com with ESMTPSA id
 a4-20020a2eb164000000b0024988e1cfb6sm1801559ljm.94.2022.03.28.11.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 11:01:39 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v5 0/4] RSS support for VirtioNet.
Date: Mon, 28 Mar 2022 20:53:32 +0300
Message-Id: <20220328175336.10802-1-andrew@daynix.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: mst@redhat.com, yuri.benditovich@daynix.com, yan@daynix.com,
 kuba@kernel.org, davem@davemloft.net
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

Changes since v4:
* Refactored code.
* Fixed sparse warnings, there would be warnings for using
  restricted fields in vnet header structure.

Changes since v3:
* Moved hunks a bit.
* Added indirection table zero size check
  for hash report only feature.
* Added virtio_skb_set_hash() helper instead of in-place routine.

Changes since v2:
* Fixed issue with calculating padded header length.
  During review/tests, there was found an issue that
  will crash the kernel if VIRTIO_NET_F_MRG_RXBUF
  was not set. (thx to Jason Wang <jasowang@redhat.com>)
* Refactored the code according to review.

Changes since v1:
* Refactored virtnet_set_hashflow.
* Refactored virtio_net_ctrl_rss.
* Moved hunks between patches a bit.

Changes since rfc:
* Code refactored.
* Patches reformatted.
* Added feature validation.

Andrew (1):
  drivers/net/virtio_net: Added RSS hash report control.

Andrew Melnychenko (3):
  drivers/net/virtio_net: Fixed padded vheader to use v1 with hash.
  drivers/net/virtio_net: Added basic RSS support.
  drivers/net/virtio_net: Added RSS hash report.

 drivers/net/virtio_net.c | 389 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 376 insertions(+), 13 deletions(-)

-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
