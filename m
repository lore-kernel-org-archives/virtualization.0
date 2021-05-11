Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E45C433B4
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 04:43:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074736191D
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 04:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074736191D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B3B18449A;
	Tue, 11 May 2021 04:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GijNZpOinNgm; Tue, 11 May 2021 04:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB1BD84493;
	Tue, 11 May 2021 04:43:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EF09C000D;
	Tue, 11 May 2021 04:43:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69E4BC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4490E405A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KHXzofHQksYA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6089740239
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:22 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id a4so18708560wrr.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 21:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=r+fuEWOXQS7I9x8O8/V7V8Fp627y94Agl9rZO/rVwbM=;
 b=qrhFd3cPjwMZqof4JqMgZ2pVJfMjIk58KoCi4X28Jd57Igp9i5b6Kn2iiDX5AU5uxq
 x5gmUtUeHxnwSyf6SNM1m29mrqIA5C6P2oohNmsZYXhOHc0tY+huK8T3ZBdKBn+s+VEN
 OhYCh2+IiYXwzrEka9XcEM7qUomzyxfWJ5aZWugkqvklX/xuJCqMz2seGdy6q5mdMJwD
 LSFjfNpqfnLsis4zBJEiN8mXIuIRT22gtcqdyMBAg2R01OryoOH9GGMBp5UMfkuIgXpS
 Em+u2qNX3oEcjKWNDGAX0N1UYsEt/Ivjlo6lVOnlfhaoKxveTCDy228GdqQdGjHFAvKz
 xGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=r+fuEWOXQS7I9x8O8/V7V8Fp627y94Agl9rZO/rVwbM=;
 b=SNTLWUSZDNBgxKPC+FJ0xoom2f3wubZdK89dVxYsxL0PBbPHE1TJ3uzRtf/OrIpf1i
 LHIRgulbNMCNhFQVp51pLfSizGFCqJtt8Pu0P6s3Igq9Lgo1G2SqP+vuiv7He7d9lb6O
 IV+TSxHp/+LHBmp2mZ7yJsltVv9zFY3UXrJEmUhE3Q616cPpz/Cpe8kbNX5Hpgm7Lhvl
 7NKADf3A5StowldTO11flVbIK0OSvzkLkCdEicy9oxX6rOLV1Y9obpmxT4epUhYtqlOl
 yYVf7J6YjWe3SnUb1VXPmAjBhperpj1GNqLz+0gEoQquj6krIANKGx3mdhGMdmwx9f2K
 ktGg==
X-Gm-Message-State: AOAM531eYliY11AVA0nue6FI6hQLJaaWNSqLmMpMnaTmPQFXf+H8CccE
 lIhsCtqOGqiCYm/yjXb6+s+9mA==
X-Google-Smtp-Source: ABdhPJxUhqz1WaZH/FOnhkVGUbpgaA1N+uNYZJE5IYt0YY+EuOaBPMEZo3xsZpY0faKRoNgtCX+xMw==
X-Received: by 2002:a05:6000:144:: with SMTP id
 r4mr34846567wrx.128.1620708200204; 
 Mon, 10 May 2021 21:43:20 -0700 (PDT)
Received: from f1.Home (bzq-79-180-42-161.red.bezeqint.net. [79.180.42.161])
 by smtp.gmail.com with ESMTPSA id a9sm22360520wmj.1.2021.05.10.21.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 21:43:19 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 0/4] Add host USO support to TUN device
Date: Tue, 11 May 2021 07:42:49 +0300
Message-Id: <20210511044253.469034-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Cc: yan@daynix.com
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

This series adds support for UDP segmentation offload feature
in TUN device according to the VIRTIO specification

Yuri Benditovich (4):
  virtio-net: add definitions for host USO feature
  virtio-net: add support of UDP segmentation (USO) on the host
  tun: define feature bit for USO support
  tun: indicate support for USO feature

 drivers/net/tun.c               | 2 +-
 include/linux/virtio_net.h      | 5 +++++
 include/uapi/linux/if_tun.h     | 1 +
 include/uapi/linux/virtio_net.h | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
