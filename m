Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9560C433EF
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 08:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18D5084CA4;
	Tue, 25 Jan 2022 08:47:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ar21WogZGMGL; Tue, 25 Jan 2022 08:47:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA32A84CA0;
	Tue, 25 Jan 2022 08:47:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E9F1C0078;
	Tue, 25 Jan 2022 08:47:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2E07C0031
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C239F41768
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0GAbPtKxbbBJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ADB834175B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:22 +0000 (UTC)
Received: by mail-lj1-x241.google.com with SMTP id q22so6967615ljh.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 00:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oUbvyNj5dnaM8qXXPaaN3calf58RmDrlF6ofRRGF5q8=;
 b=30zRHP3cawR9fo/gEqHpAmA2Q78/yKunsBnxe6QD4YYv2dV+ZUH16nD9lEUozhnFLi
 nHYLbBGOmgFfFBCvtZJX7kuVEvBu4m2+9ms9+7pTOTgRtfMzxt9YVEANSGx/w7I4cGpC
 jw3p/2FY/utquahuDCkPXVf9cP3dMXh1ALo00N0iSNlmm5xLEruBjkjf+/iYCKkWgFNS
 nstYMxpGvhRqCzKyuj3KxC4h/xGy312OnG1vehytswq716BF3P9bMbZeGDgSYjV9wyX6
 cy63f40FQeAPdxgeXgEgCLnSMUkFb/BH97zBfi7vKsVuAPm6i8bghcJniZYkJcjOpML/
 5gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oUbvyNj5dnaM8qXXPaaN3calf58RmDrlF6ofRRGF5q8=;
 b=4D3Db5SDeuBGVxs8do0ABZjXk5a/3tijNtbshlPrgOhTQ2k2EmalXI0l+lxuh5W1BO
 5Icv10G+qqfxehTVgIPmhO3Odvbvy3X9Hf7G7913fCOZE7cpCTu0EgO7/0M33tQo5UGF
 z60AxamLDTAnQcLihv2MRsnQ1heZtlETYdxpluRkXx+wObrd+aYwqU0I0GwbQYbSBSuj
 aWrDj8OLbWdCUciEsiZO2Kc/ShLdduJHjWkhaXhJpOlQkocaz9L7wer3e7jkyd/6VinE
 FszdAkgYEIXoQ9LkNwbvsatCOSNXfarrnEDnis3wJM28jESBzLMqffiuTgEqpWXC3IEQ
 6BUQ==
X-Gm-Message-State: AOAM531KhmFyx6gPUUBNSZA+TyJQ1rIXN+4hiBrnSxrLx07m8Cs7b1J+
 N/RjGBlvtdCwrbewtwOAhXGRAQ==
X-Google-Smtp-Source: ABdhPJxmuLUFKp9der5dVvy/11NTxMaDlAPxrJvNLiMLIAlXxg1yxjfnkjVt3mTw9T6dl7CBTLbrbA==
X-Received: by 2002:a05:651c:b2a:: with SMTP id
 b42mr13381928ljr.168.1643100440664; 
 Tue, 25 Jan 2022 00:47:20 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id q5sm1418944lfe.279.2022.01.25.00.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 00:47:20 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 0/5] TUN/VirtioNet USO features support.
Date: Tue, 25 Jan 2022 10:46:57 +0200
Message-Id: <20220125084702.3636253-1-andrew@daynix.com>
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

Andrew Melnychenko (5):
  uapi/linux/if_tun.h: Added new ioctl for tun/tap.
  driver/net/tun: Added features for USO.
  uapi/linux/virtio_net.h: Added USO types.
  linux/virtio_net.h: Added Support for GSO_UDP_L4 offload.
  drivers/net/virtio_net.c: Added USO support.

 drivers/net/tap.c               | 18 ++++++++++++++++--
 drivers/net/tun.c               | 15 ++++++++++++++-
 drivers/net/virtio_net.c        | 22 ++++++++++++++++++----
 include/linux/virtio_net.h      | 11 +++++++++++
 include/uapi/linux/if_tun.h     |  3 +++
 include/uapi/linux/virtio_net.h |  4 ++++
 6 files changed, 66 insertions(+), 7 deletions(-)

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
