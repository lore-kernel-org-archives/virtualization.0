Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EC6C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 12:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19881405B2;
	Tue, 22 Feb 2022 12:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pSbpmay1OdOO; Tue, 22 Feb 2022 12:01:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6EA2340155;
	Tue, 22 Feb 2022 12:01:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F0CFC0021;
	Tue, 22 Feb 2022 12:01:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B963C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A4DF60E93
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XSaoijPLO_mc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2F7260B12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:33 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id e2so15725120ljq.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FzYNR2sKDetapYfGLWWudbc7yc1Ktg/KaORx1hjvCVQ=;
 b=4aO75Z6ibjpnvJtJm9vFf+C1Cs8xY5swKEEbD5ADFmeDBZ6zj+gi1xD8nhzvxm78x1
 pBsZIM5BgIRrjJtXenkK9q7vGokX7yfmdFjB6DQlzNpsiRZLTWVYw+sWJQ6wO3xKEDvH
 ILje7SS0I5xpWYbhZDKr6dlzbhdgWZSQIRmcZ1geG/Z8CCwAfSq+4mJLZrZfLzFxF7+K
 64yt+nUdpOhBEbCUu593jPu5Ryx0kfmZn011uvrNgu5THWhISG/bBtMYISGLc4DPZwSh
 sNf5GSI+4f0HuEN/4rAgBxLwls+SxGt1Ypj9VuI+ZNb9/Kd7VP2agqayJ/jLUsPIjg88
 oQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FzYNR2sKDetapYfGLWWudbc7yc1Ktg/KaORx1hjvCVQ=;
 b=NGvFDmNw4luP5JhCLjXfg+bJRplt306QTHnaw4Gu/v4JkLRcP/mAcwn75Uo6sKgF/1
 A+wASIAT7ETAvLzDRR/m+1VMRLk9EqwrvDCc0bnyGK/UDL9kiOLhhj53WlOqRL1uwEE+
 OiLiJ+RjRfnzwrPChe9v915Qp5wEMeZPw6yEhPBbYvw6LAvdrwZ5v7XVx+G4r2gXFXab
 kpQDNnbbvfPSmijQfXlgIof7MZ45BGc5Es2FlMW0s/lB8pc/qJ5A58uhWs53V/NgwGTl
 FGAdB7b+l8ih0LfQr04FNcoa/GitHxSZirgOVxbH8gtPMHIKoriX3cvZL9DtVprZPaz/
 zEwA==
X-Gm-Message-State: AOAM531aPlW+D/574kdUTmI2kXNaUVnziK6ny2QBZO4s8585C0eRVPK5
 pnMfKUK2pUEqW4oAmHH9IVhlOw==
X-Google-Smtp-Source: ABdhPJwGQOfNgPwytiF1r2dQWgVgu6SzGM3zrIl9c3Z1NfSqcUk5K2eYcvGZE8RkVljl2SCy4STEKQ==
X-Received: by 2002:a2e:978f:0:b0:246:360:6cff with SMTP id
 y15-20020a2e978f000000b0024603606cffmr17319826lji.106.1645531291571; 
 Tue, 22 Feb 2022 04:01:31 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id v29sm1664024ljv.72.2022.02.22.04.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 04:01:31 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH v4 0/4] RSS support for VirtioNet.
Date: Tue, 22 Feb 2022 14:00:50 +0200
Message-Id: <20220222120054.400208-1-andrew@daynix.com>
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

Andrew Melnychenko (4):
  drivers/net/virtio_net: Fixed padded vheader to use v1 with hash.
  drivers/net/virtio_net: Added basic RSS support.
  drivers/net/virtio_net: Added RSS hash report.
  drivers/net/virtio_net: Added RSS hash report control.

 drivers/net/virtio_net.c | 389 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 376 insertions(+), 13 deletions(-)

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
