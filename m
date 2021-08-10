Return-Path: <SRS0=EG+p=NB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2158FC4338F
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 10:25:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7EB61051
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 10:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD7EB61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7684E82B8C;
	Tue, 10 Aug 2021 10:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P9Bsk7gprhvh; Tue, 10 Aug 2021 10:25:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 17B7D82798;
	Tue, 10 Aug 2021 10:25:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E386EC001A;
	Tue, 10 Aug 2021 10:25:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D994C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 10:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B27940232
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 10:25:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id valSSL2WB_F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 10:25:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 07629400EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 10:25:26 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 t7-20020a17090a5d87b029017807007f23so3587496pji.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZdCiYC9u4FnuS70bUd9/octYWkdJG1zK6Pj5AbL4FKs=;
 b=cQctpUWGgS8XavHH49A7V07HpxQh3UZrgT0rpm6Xo7pjORT+h6V/gpJmAk/K9q82l0
 BXpx2fSycKX07osBbPOk/myawlvQA2W1M+F/f8oOsBLdfuRqo6JaTriVSznwdhJadbrP
 2kKOFPWUDPXnGnLFu5FFweje7fwSYSsPE36n/iipqP85ti4NnpCTiS+XjRlVk1MFh/nE
 Bfno9U2KlR96Faike7CAHkTU3WBSWpIlTIaEY9yC7TQ4/ZJvYmj0aashV0IlkVQFkRi2
 JFkacqTJxlS3oqGOYl77XZRvrIPSD6kp9q20EvRFTryUlmnBhYmsbKQadXdFz8Cur9No
 0ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZdCiYC9u4FnuS70bUd9/octYWkdJG1zK6Pj5AbL4FKs=;
 b=Vy3bs6roaIA51mG/a40pb9DU/3b2MzPTks6RVsE0NAWOPQhP7iaebxfz+PyRTUV7Wi
 Nd7XESLHdWRlCNSnQ27h5JrITgldKEOU7jE9gWqePeEnGvTbaYAU2gEsp25PG+tLe7NN
 GUFHf7fqcIP9lODRx/vIiyLH9LUUsozJ8Y5ZtJZGcEHeUUYMmP+jf/GYy9PmlTZhQsZC
 3Szi10Jt5Y7evgnr2eKeh/yX7vWkvjpoATuMsLS5pncrlrEwFfYu2NXd4yCat9LBawbU
 5pfPRbbOd3QQzjVJL7+eQ+1HU2KOx05P25KJJNwbyyfBPU1ovdnPGASmgdvVsmCtoZP9
 xhTw==
X-Gm-Message-State: AOAM530jKwv4Uhznrn/a84WnS0n9sq25Tp4FLUdyLAvN1MgD6OpLvt4D
 jfJ9uy71fA7++uh2zydJ9un1bw==
X-Google-Smtp-Source: ABdhPJwfe8truRga+QTqCjf8OWZq0lELLcSbl5CksIhnr3YftGvX2WA1G7Yb3PcGGaa9QKuM2Hs74w==
X-Received: by 2002:a65:450c:: with SMTP id n12mr312121pgq.316.1628591126406; 
 Tue, 10 Aug 2021 03:25:26 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id a11sm27981920pgj.75.2021.08.10.03.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Aug 2021 03:25:25 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>
Subject: [PATCH V5 0/2] gpio: Add virtio based driver
Date: Tue, 10 Aug 2021 15:55:14 +0530
Message-Id: <cover.1628590591.git.viresh.kumar@linaro.org>
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

V4->V5:
- Use ____cacheline_aligned for buffers.
- Proper locking in place, which avoids the use of work-item for processing
  interrupts.
- Separate callbacks for enable/disable of irqs.
- The irq is disabled at the host only for enable/disable now, instead of
  mask/unmask.
- mask/unmask only control the queuing of buffers now.
- Use handle_level_irq() instead of handle_fasteoi_irq().
- Other minor changes.

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
 drivers/gpio/gpio-virtio.c       | 668 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_gpio.h |  72 ++++
 5 files changed, 758 insertions(+)
 create mode 100644 drivers/gpio/gpio-virtio.c
 create mode 100644 include/uapi/linux/virtio_gpio.h

-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
