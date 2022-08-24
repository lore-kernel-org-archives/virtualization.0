Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E618C00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 09:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 753FC40929;
	Wed, 24 Aug 2022 09:16:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 753FC40929
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=y/p95w/a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YV96dUxD-sgH; Wed, 24 Aug 2022 09:16:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B1EAF4020B;
	Wed, 24 Aug 2022 09:16:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1EAF4020B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83D68C0032;
	Wed, 24 Aug 2022 09:16:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EAB1C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1122960E13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:16:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1122960E13
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=y/p95w/a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gN0EyT82LaHU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:16:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A31860B51
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A31860B51
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:16:41 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id y127so12945899pfy.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 02:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=XElR36Lic8L2Dc4sb+yhSBdm1KGLNIgdcEk55Kqo6ok=;
 b=y/p95w/a6w9CLiRJZ/1LjOf8N9Qow8Gw7kBFrgIWtBUkz+5KkEPeC2I26g8oC1Ikhc
 4wmYN+V5EpyDbfxS6Y+wLzSR+nOSfQSc3Lao9WOfEGQ6ViWyAekcDzqK2a4fLA8nkriE
 v9i0/BoD3DDv/EuTmwwe9fUf871q+U5wdntviU7isnAY6r9TzEguE4FAmxiP8JW4Kr1b
 ZfTUB/JSOuBB/pIMlqrqM2wuTaSREbtmGGmNGSLBw0zWhbtZn3Ufq8ItBdTbP5HkoUsk
 h88fLFTGnhSgFxYXP4xfZs0wrElTPCrsrYAfLbhaxs7wYqK/DoEXRg8r1wzwFwPRavVj
 gjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=XElR36Lic8L2Dc4sb+yhSBdm1KGLNIgdcEk55Kqo6ok=;
 b=kYA1unbKuYRT5lqXUR2Y2GtuWZPkqqxxwxEuc042auXGaYdD0sCxs9OFZBvVHbWSAm
 m9BacC/u7P5kCPW8LrMudV5PcW/cERSA3qxXyA6NnfJESWgDbppsS5qIB5h9Xhk9SBNU
 oHyaITpfrwHDTj5g49COjiT+t0jdLxHD9obBuFPJU6CSLfg/Ra5F2VDMH8wKHDKQT59p
 UZai6oYdcMhassMYiy0bHPqJgQyxvxpfDkcEUaz6smijwnarU4Jp7srLmbnNqDDfBtob
 ZjX1/oOsS5o6vt8X2xim/vVTdOMg+M/GaxdaqdTfLL8x3c/vzMptjkAlWtKDYN46c9Wc
 Jvtg==
X-Gm-Message-State: ACgBeo32NAg+PJv7HGu64v0HOpmnIqFuo/e8WoPEz0aC/aG0rEKFpwvm
 1Sl7psmTy29/W+C0GpKvfYzrjxggwyrrBJ73i8/B/V7zsHRDOQ==
X-Google-Smtp-Source: AA6agR6dFAudR/n8OT8JYkh/PoTCf/o8zoP26GyDE17b0cz4HDynzDzRQfFDpTWk79U+OQtjW1ZPhj7lPCIIb4AtfsA=
X-Received: by 2002:aa7:8096:0:b0:52d:d5f6:2ea6 with SMTP id
 v22-20020aa78096000000b0052dd5f62ea6mr29599706pff.0.1661332600588; Wed, 24
 Aug 2022 02:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
 <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
In-Reply-To: <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 24 Aug 2022 12:16:04 +0300
Message-ID: <CAJs=3_Cnf29Om2yB=JkdASuu=YBPRmZ4i7ncFfTzrftTkYZVmQ@mail.gmail.com>
Subject: Re: Virtio-net - add timeouts to control commands
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

Hi Jason,

> Or reset but can we simply use interrupt instead of the busy waiting?

I agree that timeouts are not needed using interrupts.
This can be done, but seems like a big change.
All functions calling virtnet_send_command expect to get a response immediately.
This may be difficult, since some of the commands are sent in the
probe function.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
