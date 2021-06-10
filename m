Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8C9C47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 12:09:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD6A613FF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 12:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD6A613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26C4260881;
	Thu, 10 Jun 2021 12:09:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ILiwYebjw6tr; Thu, 10 Jun 2021 12:09:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9ABA760853;
	Thu, 10 Jun 2021 12:09:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6949BC000D;
	Thu, 10 Jun 2021 12:09:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88DEDC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:09:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6929460862
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:09:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wfnOFm9Ssbtf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:09:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 761AC60853
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:09:18 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id e20so10477021pgg.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b8nZP+Gapaq0m2CiyXSp+UoYpv4V40nbqCx5vZWy2So=;
 b=qNpHGLbzx8OhyV03T1XQBAEOd4lRjyRCU0fJwWQZM9z8cmhPoAFi+GDxkHRMRhazLH
 R0nsMAtnYe96LshwmR/TMRPVGoU8ytMBoxbmB53R8tZYrcmwEFY8HlHAn44TpYb0pzTh
 qmB77sFVrdZyAyBI4G19njPnorLQYKYdmRF092cSd0Ei7zqUxCPk/1jsa5KnX0YhIvk1
 SzFP1/gawTAr5K0/RmkjYDxzJD37wlU3JNFPy+LzxoihOhSyx3ZJ+C93QrVboF34Xv0n
 Li/GbaMZV6qI7CbrdPL5RJ9aq7yt+bgyv+rUCOxswMYCURW7p2jiiOGrkgPqjecyRGWA
 0TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b8nZP+Gapaq0m2CiyXSp+UoYpv4V40nbqCx5vZWy2So=;
 b=TP7chrbLe1LbywgWGWFnPH8M0MR36Vi/PYRNn9U82ig+cCLzuGEQ3PDeSGPwIQm/yG
 g9xVqVpRUaXBt5F0pD5ikt5m2PjRQyEpnOL/MmQ5RreZ46Iksg+3zWWXns3MGDkU2Kjw
 B8ag26+cC5Epd8PMVYrHTgUjlSn0anJc+CyjH+ZnymnC/+G/f7utzbDaqAJX6xopXmQf
 /l0h94Tw8c15rO3SsMherxPKGS0IBhtOgbfmjp/DQftnDajHIBTx74n57Vlt/pDSON0F
 QRQDkXgdnZ8xnz1mV5CPPHIp7RnqWItz8g0mE8gSr1GFKE7U2rdbQOvYjBdf89mEJ5CJ
 jY/w==
X-Gm-Message-State: AOAM532gL6j4Dj/rqMV6SPhDsQhOr3T1uoRHZCHmkFheGNBV5k/T/dYW
 GubjwFfx5jtOi+WGu8K3KKkwzg==
X-Google-Smtp-Source: ABdhPJwSp9xuwNSizzHp3uvbFX+DHZygMqXvOaYSXbJZdQ1gOs84CgFHQge7IuxwbzYsh3V0+5Vtug==
X-Received: by 2002:a62:ab16:0:b029:2ed:8599:7df8 with SMTP id
 p22-20020a62ab160000b02902ed85997df8mr2772433pff.31.1623326957801; 
 Thu, 10 Jun 2021 05:09:17 -0700 (PDT)
Received: from localhost ([136.185.169.128])
 by smtp.gmail.com with ESMTPSA id v67sm2423802pfb.193.2021.06.10.05.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 05:09:17 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>
Subject: [PATCH V3 0/3] gpio: Add virtio based driver
Date: Thu, 10 Jun 2021 17:39:05 +0530
Message-Id: <cover.1623326176.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-gpio@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 stratos-dev@op-lists.linaro.org
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

Hello,

This adds a virtio based GPIO driver based on the proposed specification [1].

The first two versions [2] were sent by Enrico earlier and here is a newer version.
I have retained the authorship of the work done by Enrico (1st patch) to make
sure we don't loose his credits.

I have tested all basic operations of the patchset (with Qemu guest) with the
libgpiod utility. I have also tested the handling of interrupts on the guest
side. All works as expected.

I will now be working towards a Rust based hypervisor agnostic backend to
provide a generic solution for that.

This should be merged only after the specifications are merged, I will keep
everyone posted for the same.

I am not adding a version history here as a lot of changes have been made, from
protocol to code and this really needs a full review from scratch.

--
Viresh

[1] https://lists.oasis-open.org/archives/virtio-comment/202106/msg00022.html
[2] https://lore.kernel.org/linux-gpio/20201203191135.21576-2-info@metux.net/

Enrico Weigelt, metux IT consult (1):
  gpio: Add virtio-gpio driver

Viresh Kumar (2):
  gpio: virtio: Add IRQ support
  MAINTAINERS: Add entry for Virtio-gpio

 MAINTAINERS                      |   7 +
 drivers/gpio/Kconfig             |   9 +
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio-virtio.c       | 566 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_gpio.h |  56 +++
 include/uapi/linux/virtio_ids.h  |   1 +
 6 files changed, 640 insertions(+)
 create mode 100644 drivers/gpio/gpio-virtio.c
 create mode 100644 include/uapi/linux/virtio_gpio.h

-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
