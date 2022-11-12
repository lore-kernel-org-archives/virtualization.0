Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44417C4332F
	for <virtualization@archiver.kernel.org>; Sat, 12 Nov 2022 16:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1FC460A68;
	Sat, 12 Nov 2022 16:19:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1FC460A68
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=ViAUQ8GE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XKnfhGhcYUp0; Sat, 12 Nov 2022 16:19:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D94E60670;
	Sat, 12 Nov 2022 16:19:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D94E60670
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2008FC0033;
	Sat, 12 Nov 2022 16:19:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CA75C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Nov 2022 16:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07124813A7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Nov 2022 16:19:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07124813A7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=ViAUQ8GE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aUFjO5ieTIs9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Nov 2022 16:19:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E68118138D
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E68118138D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Nov 2022 16:19:49 +0000 (UTC)
Received: by mail-yb1-xb4a.google.com with SMTP id
 y6-20020a25b9c6000000b006c1c6161716so6937950ybj.8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Nov 2022 08:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=wVgOl8R94xnVJVUhd0tLg4IuhiKfwsABI7lZpXnZ5Z4=;
 b=ViAUQ8GEYFiP4NiHdO2g7rPGt5Ijm+D+r/OTFYhZThKYiMFg26WDiMo8CJiHr81CcU
 ryjzRMgA6UQkdgwkfj6hQm3q0b7z6l1EnnbRIJOIzTcG6QlqMuMR/d19PHGAtn7A814R
 8MV9OXS9z2b99YJEwb1rW3OkFpto1r/Li4/WlW3PotvwsZY1B19kWERX1QUNIKVPWf9z
 Zh63lDV1fCx2Du13Uw79+esdiMm3n8oWYKcGlkr1JL+mL50IQupC27N7wR0kQ32D8p4p
 UEAa/O2ZlJmIOGst1oDvmezjTCwTx5D7IaRuIyb4j0E4QqAQws1gDlrY7YKfnSrvoEvD
 S37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wVgOl8R94xnVJVUhd0tLg4IuhiKfwsABI7lZpXnZ5Z4=;
 b=7qFDBbSuSZu5pt5gVYjNWAX8uDUpvtI4XBMIkDKmbYQ1h4hpsJ0scKwRLHTXzGP4R3
 ewSL/zymBXsCF7//RjVwwuafgMTLPnMFFy/X11fGnheNrDlGvqeSrXaqxG5elP7ApfWv
 Imeft7Phlk/2aHEON/ygIiJO3frjMDUCN5jCyIYiLVuXRL9XP2mJxlGr27+OH4WR0wpi
 owRV4yptfKJwv0qZFjFdCGuQFh9e6Vl5Qn3nu1SvvxSZhjPKT4zO4NaNeiL65y7xhKgx
 sKqMDTRq4LSXbmsx6+jla4gf/9QeDaQzTDlTfRXJaCDA2G8gbLaP8yd78lPe6RpTfwNz
 rN8w==
X-Gm-Message-State: ACrzQf3N52gtFQkHvgDdbWQf3aXoUGLiU8ucK3rYGMdiyXEaSQ8L+H1a
 AMyzlHniiesCuHdem7vxa7NzqB2dju8N
X-Google-Smtp-Source: AMsMyM5GjyPavtYMW5Pjbj+Tmxr9IhTS96KOzXvXYoihtVKvCnMAK9/p3eTrluDYKKz6HsYN7RGlRdh3oJF5
X-Received: from dvyukov-desk.muc.corp.google.com
 ([2a00:79e0:9c:201:ab8d:5d30:aa81:9b7b])
 (user=dvyukov job=sendgmr) by 2002:a25:4e42:0:b0:6cf:e71a:818f with SMTP id
 c63-20020a254e42000000b006cfe71a818fmr47335327ybb.113.1668269988383; Sat, 12
 Nov 2022 08:19:48 -0800 (PST)
Date: Sat, 12 Nov 2022 17:19:42 +0100
In-Reply-To: <200906190927.34831.borntraeger@de.ibm.com>
Mime-Version: 1.0
References: <200906190927.34831.borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221112161942.3197544-1-dvyukov@google.com>
Subject: Re: [PATCH/RFC] virtio_test: A module for testing virtio via userspace
To: borntraeger@de.ibm.com, mst@redhat.com, jasowang@redhat.com
Cc: tim.hofmann@de.ibm.com, ehrhardt@de.ibm.com, kvm@vger.kernel.org,
 rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org,
 syzkaller@googlegroups.com, adrian.schneider@de.ibm.com
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
From: Dmitry Vyukov via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi,

The original email is from 2009, so I assume you don't have it in
your inboxes already. Here is the original email:

https://lore.kernel.org/all/200906190927.34831.borntraeger@de.ibm.com/

> This patch introduces a prototype for a virtio_test module. This module can
> be bound to any virtio device via sysfs bind/unbind feature, e.g:
> $ echo virtio1 > /sys/bus/virtio/drivers/virtio_rng/unbind
> $ modprobe virtio_test
>
> On probe this module registers to all virtqueues and creates a character
> device for every virtio device. (/dev/viotest<number>).
> The character device offers ioctls to allow a userspace application to submit
> virtio operations like addbuf, kick and getbuf. It also offers ioctls to get
> information about the device and to query the amount of occurred callbacks (or
> wait synchronously on callbacks).

As far as I understand the test driver was never merged and I can't find
any similar testing drivers. I am looking for a test module that allows
to create a transient virtio device that can be used to activate a virtio
driver are communicate with it as if from the host.

Does such thing exist already?
Or how are virtio transports/drivers tested/fuzzed nowadays?

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
