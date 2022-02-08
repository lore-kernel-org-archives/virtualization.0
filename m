Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D46DC433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 18:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFB4C81C40;
	Tue,  8 Feb 2022 18:15:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qYbitwLyyAn5; Tue,  8 Feb 2022 18:15:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 60B89813EF;
	Tue,  8 Feb 2022 18:15:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3310FC001A;
	Tue,  8 Feb 2022 18:15:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41351C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22C1A60E3A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PlDHL6fHcdYb
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC10E60BC6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:44 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id f18so5761133lfj.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ubojHHrasWsqhS6qr/dbMNAqWg0S4l0W2lxdG9od6YA=;
 b=7UmIQ9z5CVY4nqjy1zfqHmy+itjDZKx6BB61jiQKXprE09I4TN+opuJCV0itXXHB6E
 4q4L7vf1nz8jfx3Zw2r0+PaePFmZFUnhdn8aAobd4I3TnJZa7rm88wwbanBWNjPqiY0b
 gy1tLj1MKefoY88SmyTtwXJwsKSHGhA+t1JDChEd6+LTE7F0LyVVFhzGVIxBB2BWBjND
 435WBDpWdFtnwyRORG+wXCj4Gxkqfz35P7VKT0e/lLWY5D1+nguQThqh1Y9oflq6pcT8
 gmaZlYkg+SLGBG3soegU/pCCO0fQ69Vq4hmDuUFCsy3CGmJGrB0dcwdI/C/IuI7U2A8P
 Wfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ubojHHrasWsqhS6qr/dbMNAqWg0S4l0W2lxdG9od6YA=;
 b=ziwiQVd1PAJ3djJ7Mq2tZRqPCINdEhB3wauM0jJEJ3ZN+8BOAa3qtJ+3LrzGdnWfG2
 5pVqaZAsyQKHPje8BdnmgGXUw8o2mfcBJt6L1nZl3Y/n6eX5KGzFIxjb0VIrgQaGgPuF
 d0DC4M4hweZYLgTOpz8SStuIKSbBOf/jb5PLXxqNJgc/fe8iOeaaTNEVTd201JzqG+XH
 eTrfSic1kJJu83xG1dbPb6PZuES6aRilUx0qg2cQWOylpbycLkTvOpQmKGgxaPNjUl4R
 HN+W464JkgYVcZ1+HC9kyLKvLgFusFVI48B7o6ejBDl7QJY7j6osNEpgvjB9WReO32VQ
 J4tQ==
X-Gm-Message-State: AOAM532o7x9++Bw2cuXt/5atM/EFU0FCGbUls/TSMZbVb3EoDoNycT92
 pGfrvNvfeuywm0qBBFgKP0Ageg==
X-Google-Smtp-Source: ABdhPJwzqbI+mN9KcrTVXPsPB3UD7i65WJfgtYokQzM0tLnA7+rYbrnDMW8UVrsv6pAndRL6TU+ZaA==
X-Received: by 2002:a05:6512:2821:: with SMTP id
 cf33mr3740205lfb.37.1644344142449; 
 Tue, 08 Feb 2022 10:15:42 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id p16sm2125082ljc.86.2022.02.08.10.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Feb 2022 10:15:41 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH v3 0/4] RSS support for VirtioNet.
Date: Tue,  8 Feb 2022 20:15:06 +0200
Message-Id: <20220208181510.787069-1-andrew@daynix.com>
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

 drivers/net/virtio_net.c | 382 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 369 insertions(+), 13 deletions(-)

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
