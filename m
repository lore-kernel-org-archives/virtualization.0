Return-Path: <SRS0=Mk6X=PT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAF3C433EF
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 05:00:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF0E60EB4
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 05:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BF0E60EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E95984018E;
	Sun, 31 Oct 2021 05:00:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FqS5uaSPlWhG; Sun, 31 Oct 2021 05:00:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5222340198;
	Sun, 31 Oct 2021 05:00:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33628C0019;
	Sun, 31 Oct 2021 05:00:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6581CC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4152160708
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rTzSIm2nPTga
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48D5760653
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:09 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id y26so29577453lfa.11
 for <virtualization@lists.linux-foundation.org>;
 Sat, 30 Oct 2021 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lVy/fH24QPthS6HWBiNCLxZd58wLIhBCTESTMr1diy8=;
 b=GIqiP/e/0airkBt7AVVY9zwAqH+XFDnesnpw99ouddGWsttfIktj4aAfI9gEGXK9Mf
 IjUUcCwzBLka6YrTwoDQwnX+Sv4M5h86v4FbXS4pyxv7OW5d2c0MB+usBFsCg2VKoFFf
 a0IoU76Nm1UoIBaNYnjUN6hBfnNC9DAZldpovLf/WvQ1TPARBxfejVE+ogZJ8DcrCQg/
 ZDqLVhXkzk9SWmyB0eWrxcAqdDpz6iBZ61N1XUkXnDU/vGfpmtIckAaF7GuM8wjoM9US
 3pJLpff//y9JOx4cmV9NlSGe2Hhfu6m6I1h9kulySyK5GLhqixFRduT6YIGeh9+nmYGL
 BTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lVy/fH24QPthS6HWBiNCLxZd58wLIhBCTESTMr1diy8=;
 b=Xp6JpFwy8lSmIT8z5uyKymqzXA4IClQ/eZrjPD+rwBbooLqLQmUWwD3zW+uZCVftwY
 5nGIEJwVQgt7qUA53A4Nl9la0U7P+2zMIIuQgEfVxQOOdAxZM1/s4UJRK+yoBRdXtHA1
 CwIgAXRUoTuI7cbEvVWMxZNkNz4WF0TTIMLcFObo/nBNBBvubtZYfu3cDC2xDwnbVPMI
 cs+d8PGiWbztNPRUf4C+AAqQmOexTyf0vl9FwVwxz4rEhTowFW75AvKeknyn55HLbCQn
 /6neWcLTrcKXsOvCGwlAU7M2FgX/6ytA6mdNAKBte0YFM/w4BmYSneoBFyPp+xEOEV/f
 zL2g==
X-Gm-Message-State: AOAM5305/ne9jynjydOwpZQUjze0Ck6B/O0NlyowvAZFcDssrL4ZXX9A
 h2RseOEjWVLRwjSoytoHyDRw6A==
X-Google-Smtp-Source: ABdhPJyKTkZQH3l/LPlaLkLV/r+BpuZCIeqJk+kdJFxDS+cI9MUR+ouY31Lbxo7K5bbon3ujFVQhIg==
X-Received: by 2002:a05:6512:260e:: with SMTP id
 bt14mr20820988lfb.129.1635656407162; 
 Sat, 30 Oct 2021 22:00:07 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id v26sm444766lfo.125.2021.10.30.22.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Oct 2021 22:00:06 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net, kuba@kernel.org
Subject: [RFC PATCH 0/4] Added RSS support.
Date: Sun, 31 Oct 2021 06:59:55 +0200
Message-Id: <20211031045959.143001-1-andrew@daynix.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Cc: yan@daynix.com, netdev@vger.kernel.org, yuri.benditovich@daynix.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

This series of RFC patches for comments and additional proposals.

Virtio-net supports "hardware" RSS with toeplitz key.
Also, it allows receiving calculated hash in vheader
that may be used with RPS.
Added ethtools callbacks to manipulate RSS.

Technically hash calculation may be set only for
SRC+DST and SRC+DST+PORTSRC+PORTDST hashflows.
The completely disabling hash calculation for TCP or UDP
would disable hash calculation for IP.

RSS/RXHASH is disabled by default.

Changes since rfc:
* code refactored
* patches reformatted
* added feature validation

Andrew Melnychenko (4):
  drivers/net/virtio_net: Fixed vheader to use v1.
  drivers/net/virtio_net: Changed mergeable buffer length calculation.
  drivers/net/virtio_net: Added basic RSS support.
  drivers/net/virtio_net: Added RSS hash report control.

 drivers/net/virtio_net.c | 405 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 390 insertions(+), 15 deletions(-)

-- 
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
