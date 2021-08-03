Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2683BC4338F
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 11:37:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA7360F48
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 11:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFA7360F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62DA060750;
	Tue,  3 Aug 2021 11:37:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qx8LW0Wvsszv; Tue,  3 Aug 2021 11:37:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EEF796063E;
	Tue,  3 Aug 2021 11:37:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7EC9C001A;
	Tue,  3 Aug 2021 11:37:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8158EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 11:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D9CE82FA2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 11:37:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a6aHmUIKe2cw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 11:37:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44FAC82F77
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 11:37:12 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 g23-20020a17090a5797b02901765d605e14so4244340pji.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Aug 2021 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lx8aY+/yDtRv3FLOutHx5ZS4iEMyIdYBOMCpO0cyw18=;
 b=BUOS8Ggwq+VCAPWWigjVP6z8eL2qBxxXXQBzAIuTNLlNZXZxPG4jPoV/9pRshmmPte
 gdH/a/PdZt30r1WZkEoC+6upgD9f6cwEtXdpNuhy0qY08oNZlxyYLMPfb18zMZPmljTc
 3cDhZ3vYl3qbrLYPUjkmv54kKQyMdH5yBLC20skpM3bXCbOFTTgAHbWUqn8OPDGin1MB
 KOvd+xRYIi+k8vyURRBTnFR5+8q5NpLedWzLZx0hXEOzdeTtZJWK5Cumwh4BSnUcaVMe
 7/OWuyQr0QVSOq/aLUQyLSZNCaWBAMGGzuca90NABo62tyJ0KZytiDXryJ0BAf73yI7V
 gtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lx8aY+/yDtRv3FLOutHx5ZS4iEMyIdYBOMCpO0cyw18=;
 b=DoFlMer7MlMfAeydIKqhG2NbDM6ObkV/LxWwB6hD9Q/P5qPHTtPYdbPEFV7iL02YQW
 5SQ5Golb9G9Ze58obQyYcmEonS9bEceRDfKaYY3jnZHlYltMD3YfCU4D6USOV/k2RqWK
 4IIRkCelMoLtCyjzA9bRXt78C6BGx5mh+pY1VOOgcf7nRUWXXZV6PxfMgl8TyG+B3//j
 jNgxuTmdOipZ7nVj3F/Z1NmcCiMe98Qz2GCuWqoa03fgFK300+PedR+S1TzAbNZLz5nv
 XnGDhtP7BNMGOpo+kpP2pnDzK+A5qpXmF9t1dkMxsmTrED5H+EwypJ93x5dUn7s8S2+i
 y5Sg==
X-Gm-Message-State: AOAM531I8oDsITXd6CgAU7U7yp4LQohH4ZZPRirWXOo7U6TfVIfFhB7z
 rP6Drrr88gU8W1i/xFwYnZ3T7Q==
X-Google-Smtp-Source: ABdhPJza6By/DI7WFRBuWNKSnUEnJyrqLv1g7UqN9TlFDao7Pbvy0JReR7BuPUrsYAZVWyN05p6Fiw==
X-Received: by 2002:a63:120e:: with SMTP id h14mr647881pgl.215.1627990631637; 
 Tue, 03 Aug 2021 04:37:11 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id s36sm17710157pgk.64.2021.08.03.04.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Aug 2021 04:37:11 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>
Subject: [PATCH V4 0/2] gpio: Add virtio based driver
Date: Tue,  3 Aug 2021 17:06:54 +0530
Message-Id: <cover.1627989586.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bill Mills <bill.mills@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-gpio@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stratos-dev@op-lists.linaro.org
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

This adds Virtio GPIO driver based on the proposed specification [1].

The specification for basic GPIO operations is already reviewed by Linus and
Arnd, while the IRQ stuff is still under discussion and not finalized.

I am sharing the code, so everyone gets more clarity on how it will work
eventually in Linux.

I have tested this patchset with Qemu guest with help of the libgpiod utility.
I have also tested basic handling of interrupts on the guest side. It works as
expected.

The host side virtio-backend isn't ready yet and my tests only tested the flow
control between guest and host, but didn't play with real GPIO pins.  That will
be done once I have a working backend in place (WIP).

V3->V4:
- Lots of changes, as the specification changed too much. Better forget
  everything we have done until now :)

--
Viresh

[1] https://lists.oasis-open.org/archives/virtio-dev/202107/msg00232.html

Viresh Kumar (2):
  gpio: Add virtio-gpio driver
  gpio: virtio: Add IRQ support

 MAINTAINERS                      |   7 +
 drivers/gpio/Kconfig             |  10 +
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio-virtio.c       | 648 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_gpio.h |  72 ++++
 5 files changed, 738 insertions(+)
 create mode 100644 drivers/gpio/gpio-virtio.c
 create mode 100644 include/uapi/linux/virtio_gpio.h

-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
