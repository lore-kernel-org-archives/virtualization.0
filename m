Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DE0C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 08:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB50F847F2;
	Wed, 23 Mar 2022 08:04:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5X08esrmxR6Y; Wed, 23 Mar 2022 08:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7A226847CB;
	Wed, 23 Mar 2022 08:04:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F4F3C0012;
	Wed, 23 Mar 2022 08:04:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BB09C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06B4E60E32
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ri9RMVHk_lXa
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:04:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57C5660C06
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648022656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cePn2HPJ3CtBPN5ynUkfrIKVQlGOlqRorjeDVtC/Lcs=;
 b=Fe4Uk6RzvaA6Lryjz0kp93jTQR0gKXn0sj4hm4hrL5l7uDjgO611RmIFWsFups8bhQyG6P
 Mkk1rRhus/B/Av+CZzFw5rO1vZ5EdrRVIcQi6kPmlWflPFk9b4qz7Cuo6rc7RNuhVvaHIr
 zeOI0J1vvIa67DrRHfHjU57wQALNzBA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-s9JB7XrRNOOWOLqsi9XcSA-1; Wed, 23 Mar 2022 04:04:15 -0400
X-MC-Unique: s9JB7XrRNOOWOLqsi9XcSA-1
Received: by mail-qk1-f199.google.com with SMTP id
 h68-20020a376c47000000b0067e05dade89so514462qkc.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 01:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cePn2HPJ3CtBPN5ynUkfrIKVQlGOlqRorjeDVtC/Lcs=;
 b=miKujlhIrCit+gmysxCSi9AEOQsMDK1HmNCQWyZKwoZSAioA7f8p11rCEYpjj1pc3k
 k/QmoP8U9Bw3VAGEPhbb/XYmZjUZTfIMOAVfuKCvvaOLy8aw27AiKxINqnct22GP/UiG
 65Zrm6Or2XBG/q36zfoFcE0QU5no3Ydxjhbc97c1uyszhYKMqt7wQhlQ+WgbSU7eG60p
 CvDSd4ynbhX0ljEO4JlazWM3K+R6q3Ucab3UTfIGTd5TdSUVV38a8kGEW0K00Ktd6Dpj
 /5CsrPXLIaVyubOS3YjUM8kHgdF8AqXaTyB9a9jM4G+LX8rNL6mpbTZMo/PWe4Dq46CZ
 3Osg==
X-Gm-Message-State: AOAM531tAKsK5/fsKD2VeHwYyXCzoK6lS2KHSHudwfkxGtzhIQUakxJz
 SqYTte+OfOOAJjBYLMMYLkMb/lEcjiAD167MlB0OCMb3P2M4OPDuaUrqieDShZMqQUIX/nbUo58
 kq/YHEiRJO856W3V3jQrrst1OxqpKTU7K0eDo6JJHog==
X-Received: by 2002:a05:620a:150e:b0:67d:3243:12dd with SMTP id
 i14-20020a05620a150e00b0067d324312ddmr17782270qkk.229.1648022655089; 
 Wed, 23 Mar 2022 01:04:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO1+nfH+Nu1xL1m12zS/Ds8sfGdKU0u5Nq1/xW6f1tEz+ILQzmDYkM4kKd0qQ0sC/hqLtTQg==
X-Received: by 2002:a05:620a:150e:b0:67d:3243:12dd with SMTP id
 i14-20020a05620a150e00b0067d324312ddmr17782255qkk.229.1648022654824; 
 Wed, 23 Mar 2022 01:04:14 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 d13-20020a05622a15cd00b002e1df990d01sm15984553qty.71.2022.03.23.01.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 01:04:14 -0700 (PDT)
Date: Wed, 23 Mar 2022 09:04:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220323080408.ogoedasrjiqbol4m@sgarzare-redhat>
References: <20220322114313.116516-1-sgarzare@redhat.com>
 <20220322100635-mutt-send-email-mst@kernel.org>
 <CACGkMEuUpFKTyqmRh2T7cnF=1hbz3T3_DiT_t8L9Pfs_g5yJmA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuUpFKTyqmRh2T7cnF=1hbz3T3_DiT_t8L9Pfs_g5yJmA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 23, 2022 at 11:10:27AM +0800, Jason Wang wrote:
>On Tue, Mar 22, 2022 at 10:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Tue, Mar 22, 2022 at 12:43:13PM +0100, Stefano Garzarella wrote:
>> > After waking up a suspended VM, the kernel prints the following trace
>> > for virtio drivers which do not directly call virtio_device_ready() in
>> > the .restore:
>> >
>> >     PM: suspend exit
>> >     irq 22: nobody cared (try booting with the "irqpoll" option)
>> >     Call Trace:
>> >      <IRQ>
>> >      dump_stack_lvl+0x38/0x49
>> >      dump_stack+0x10/0x12
>> >      __report_bad_irq+0x3a/0xaf
>> >      note_interrupt.cold+0xb/0x60
>> >      handle_irq_event+0x71/0x80
>> >      handle_fasteoi_irq+0x95/0x1e0
>> >      __common_interrupt+0x6b/0x110
>> >      common_interrupt+0x63/0xe0
>> >      asm_common_interrupt+0x1e/0x40
>> >      ? __do_softirq+0x75/0x2f3
>> >      irq_exit_rcu+0x93/0xe0
>> >      sysvec_apic_timer_interrupt+0xac/0xd0
>> >      </IRQ>
>> >      <TASK>
>> >      asm_sysvec_apic_timer_interrupt+0x12/0x20
>> >      arch_cpu_idle+0x12/0x20
>> >      default_idle_call+0x39/0xf0
>> >      do_idle+0x1b5/0x210
>> >      cpu_startup_entry+0x20/0x30
>> >      start_secondary+0xf3/0x100
>> >      secondary_startup_64_no_verify+0xc3/0xcb
>> >      </TASK>
>> >     handlers:
>> >     [<000000008f9bac49>] vp_interrupt
>> >     [<000000008f9bac49>] vp_interrupt
>> >     Disabling IRQ #22
>> >
>> > This happens because we don't invoke .enable_cbs callback in
>> > virtio_device_restore(). That callback is used by some transports
>> > (e.g. virtio-pci) to enable interrupts.
>> >
>> > Let's fix it, by calling virtio_device_ready() as we do in
>> > virtio_dev_probe(). This function calls .enable_cts callback and sets
>> > DRIVER_OK status bit.
>> >
>> > This fix also avoids setting DRIVER_OK twice for those drivers that
>> > call virtio_device_ready() in the .restore.
>> >
>> > Fixes: d50497eb4e55 ("virtio_config: introduce a new .enable_cbs method")
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> >
>> > I'm not sure about the fixes tag. That one is more generic, but the
>> > following one I think introduced the issue.
>> >
>> > Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
>>
>> Jason what should we do about this one BTW? Just revert? We have other
>> issues ...
>
>Let me post a patch to revert it and give it a rework.

Thanks for reverting it.

Should we queue this patch anyway to prevent future issues and avoid 
setting DRIVER_OK twice?

Please, let me know if I have to resend it by removing the call trace 
that after the revert should no longer occur.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
