Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695B0C4332F
	for <virtualization@archiver.kernel.org>; Tue, 15 Nov 2022 10:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3FF1605A4;
	Tue, 15 Nov 2022 10:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E3FF1605A4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=CEem9Gsy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6MTFgMqw5mPI; Tue, 15 Nov 2022 10:25:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 61A6A60B0F;
	Tue, 15 Nov 2022 10:25:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61A6A60B0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F958C0032;
	Tue, 15 Nov 2022 10:25:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E096C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 10:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E85E2402BC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 10:25:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E85E2402BC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=CEem9Gsy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gVuApGgK49wk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 10:25:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 402B640117
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 402B640117
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 10:25:47 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 m7-20020a9d6447000000b0066da0504b5eso1925556otl.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 02:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2t/5Fwa+kcrVYytVyoGhwhA0LJjVEpVh4ghi2At6TpQ=;
 b=CEem9Gsy++2rAsQ/k1o5liFOA2uPpAASYqhA6AnuHXBHfXB4od6axyNPZtCv6GEK53
 5ykhhjViwhhCa62lVWXsEvwATbyPa/8qHDk7ndWMqu/hopblMmBOBNK94HetZnzbdqR2
 vuDFPvgX4MSsDRkycRv/VfG+ZJFx8q6ppWO/TYWasr3cFfxjWEgiVIzipQ7EaTg2lSru
 X0P5dR5HnaBMEV+K3U9/shsubjx3F28hkyHoSOgDZ1ogfigVwM4VIANbkdOxbIiwRMG0
 5IB0isoBbrvsZZsT4ToVtecXCu5+TSmm6j/5iVMQwQaamAcAKLa6sBSzeZZOq0Y/NxQy
 tRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2t/5Fwa+kcrVYytVyoGhwhA0LJjVEpVh4ghi2At6TpQ=;
 b=j60/JvAaiWFk7znQOSvGUIqrkpA+8+Mx74OzNSBH4CDqVkJLOJ1tMtDJa95GSfkmRK
 qatlVKNPPjY+PRRnqD1KvukmgywHx8imTGC6gTN/I90kr/eYOyM7/hoN6Z9BqhqTWHxq
 cKZpQX7bxkq+TLvQqem+WXITMYAF90y8zDg5SjEWwmuHm2uxXKtJei7aEQTEJgZlA3f6
 7rThzCleE+YDYtaV/Je51TIj0AxWgd/hAJ/Dlo+1uzR/Smc4xzPCNSwWRhNxRaHxZewa
 Y6bHQ5H70pjD0cyg/kzSM2MT5NxC1H8EUHjU7OnNLyAa9ZB5XWxlq/qaA1d4CW720kHq
 dY9g==
X-Gm-Message-State: ANoB5pkVmVya2qgFAc6B4VNWiobX6oYDbkSY7/1l1p06llHuPtyjbBzF
 UK4ypuLRJvBkztOYPwT7TuWZfPxEegqW63fDgvD4yg==
X-Google-Smtp-Source: AA0mqf5VuYJHPM+V6ecnOYF/+hnmZj0D7vizVbqN/Zav7eTQIgtl+v3njMF45IQfXgvQoS+y1N/AHOPDG2c8OcZCMKk=
X-Received: by 2002:a9d:32f:0:b0:66c:7982:2d45 with SMTP id
 44-20020a9d032f000000b0066c79822d45mr8358758otv.123.1668507946033; Tue, 15
 Nov 2022 02:25:46 -0800 (PST)
MIME-Version: 1.0
References: <200906190927.34831.borntraeger@de.ibm.com>
 <20221112161942.3197544-1-dvyukov@google.com>
 <20221114080345-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221114080345-mutt-send-email-mst@kernel.org>
Date: Tue, 15 Nov 2022 11:25:35 +0100
Message-ID: <CACT4Y+bsjzCvYvVWoHM2GNC1CuR4xDoqjD5WSPkv=oWq+WAt4A@mail.gmail.com>
Subject: Re: [PATCH/RFC] virtio_test: A module for testing virtio via userspace
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: borntraeger@de.ibm.com, syzkaller <syzkaller@googlegroups.com>,
 KVM list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
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

On Mon, 14 Nov 2022 at 14:06, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, Nov 12, 2022 at 05:19:42PM +0100, Dmitry Vyukov wrote:
> > I am looking for a test module that allows
> > to create a transient virtio device that can be used to activate a virtio
> > driver are communicate with it as if from the host.
> > Does such thing exist already?
> > Or how are virtio transports/drivers tested/fuzzed nowadays?
> >
> > Thanks
>
> Just coding it up in qemu is probably easiest.  This is how we test
> most things.

This works for some testing scenarios, but has important downsides:
 - fixed number of global virtio devices, so tests are not
hermetic/parallel and proper fuzzing is impossible
 - tests running inside of the kernel can't control the device
behavior, so lots of scenarios are untestable/unfuzzable
 - not suitable for most CI/fuzzing systems that run in clouds (nested
virt is very slow)
 - require special setup per test suite (not scalable for CI/fuzzing
systems that test all of kernel)

A better and flexible approach to stub devices is to implement them
inside of the kernel and allow creation of new transient instances
(e.g. /dev/net/tun). Such stubs allow proper fuzzing, allow
self-contained tests, allow the test to control stub behavior and are
compatible with all machines (cloud, physical hw).

Is my understanding of how such in-kernel stub device can be
implemented correct?
A stub driver could create struct virtio_device and call
register_virtio_device() directly skipping all of the bus/probing
code.
The virtio_device implementation will be parallel to virtio_mmio/pci
and implement its own virtio_config_ops and notify/kick callback.
This will allow us to test all of the virtio device drivers (console,
balloon, virtio sound/gpu, etc), but not the virtio_mmio/pci nor the
real probing code.

Is there a reasonable way to also test virtio_mmio/pci/probing from
within the kernel?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
