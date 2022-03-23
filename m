Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06B5C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 08:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 818558494D;
	Wed, 23 Mar 2022 08:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZZpkgpPEsKi1; Wed, 23 Mar 2022 08:16:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 132C5847A2;
	Wed, 23 Mar 2022 08:16:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E57A5C0012;
	Wed, 23 Mar 2022 08:16:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CA4BC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7690E418EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:16:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9S-xVeJxjm03
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:16:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA8474086E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648023386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vnuSgpHYe4+kaFzuDCRUytBvJ7SkYMJ/tCQLfbkYDOw=;
 b=FjEQewAM0uBoyQaClOkpbSdp3QKoOBB0mLO9vI8aOyTsyegPWVJ9UZp4XNBZqkWN4POVQE
 ++B/Ukz3JLMoOpR82G1Ej033Fnno4mjL1XFcYqkYYEzIgvGfuLLQtmYW5SHRDZ2mn7cHdX
 7ECb7xm4bUgnQf5cZbbuPKcfXJQloVo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-iXetO-sqOWyl0T1ZX51ZdA-1; Wed, 23 Mar 2022 04:16:25 -0400
X-MC-Unique: iXetO-sqOWyl0T1ZX51ZdA-1
Received: by mail-lj1-f197.google.com with SMTP id
 e3-20020a2e9303000000b00249765c005cso288474ljh.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 01:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vnuSgpHYe4+kaFzuDCRUytBvJ7SkYMJ/tCQLfbkYDOw=;
 b=Yw0BvAln07dnOVrv5T+2Wqb+uxiFHOnFlK6t5WY5dBC6J3u46dEB+YvkUxs88+p/vh
 +k2Mx9qGQbVpBAUz3UQniwuow0OQMBDp5sOzd4L8jwTFbbXg+ruVtZKwsiARND3qCEvL
 c4SGJQWpJF2refuRRc3mfoRFH3xf3YHuNwEtWgny/8dgAMQYhsi2q01/cLAx1ONg35xP
 U8sxxKPXmJouhLZ0Xyw9PzGGb1Odwr9IUBvB7fKqRi/FRlhzzBFPQwhPm/jB/HXGZIA/
 CBjXQzWa9J2A0bmE8gpoj+a6ikdArBYFeadIn0W1wO49OxpJDFDBrUpJNP8mgu8SSsjW
 e5tg==
X-Gm-Message-State: AOAM531Q1UVHZzY4AzS+/NOpVBn+DUnmFYLyxaueO5QlLeP6tbW7RdcP
 rUFSUXDW9gAEA/mfqIK0xOHh494Bs9nM7qTYT1NGACBQWsK7zasnNk8zfPwWj3FyJFCikfcyg42
 rlM+wG1tT8DEMOY2UCHMj4K0EeBdFTVngkpZOkHHWdxy/Ie32RKm1wKSwPA==
X-Received: by 2002:a2e:54d:0:b0:249:8213:f970 with SMTP id
 74-20020a2e054d000000b002498213f970mr11608111ljf.315.1648023383801; 
 Wed, 23 Mar 2022 01:16:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeecRAmB2VmOwb5nw++BO3YvxDg933DtJoEkzYqXR4btJkrva8lntOp+9O3PJt0+U7IJnYrj7sZWMvSePf6/Y=
X-Received: by 2002:a2e:54d:0:b0:249:8213:f970 with SMTP id
 74-20020a2e054d000000b002498213f970mr11608093ljf.315.1648023383515; Wed, 23
 Mar 2022 01:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220322114313.116516-1-sgarzare@redhat.com>
 <20220322100635-mutt-send-email-mst@kernel.org>
 <CACGkMEuUpFKTyqmRh2T7cnF=1hbz3T3_DiT_t8L9Pfs_g5yJmA@mail.gmail.com>
 <20220323080408.ogoedasrjiqbol4m@sgarzare-redhat>
In-Reply-To: <20220323080408.ogoedasrjiqbol4m@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Mar 2022 16:16:12 +0800
Message-ID: <CACGkMEuGhvV_jVJY6k54gPABdeJO3+7gR+vUwjwFneqxzUdorg@mail.gmail.com>
Subject: Re: [PATCH] virtio: use virtio_device_ready() in
 virtio_device_restore()
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 23, 2022 at 4:04 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Wed, Mar 23, 2022 at 11:10:27AM +0800, Jason Wang wrote:
> >On Tue, Mar 22, 2022 at 10:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Tue, Mar 22, 2022 at 12:43:13PM +0100, Stefano Garzarella wrote:
> >> > After waking up a suspended VM, the kernel prints the following trace
> >> > for virtio drivers which do not directly call virtio_device_ready() in
> >> > the .restore:
> >> >
> >> >     PM: suspend exit
> >> >     irq 22: nobody cared (try booting with the "irqpoll" option)
> >> >     Call Trace:
> >> >      <IRQ>
> >> >      dump_stack_lvl+0x38/0x49
> >> >      dump_stack+0x10/0x12
> >> >      __report_bad_irq+0x3a/0xaf
> >> >      note_interrupt.cold+0xb/0x60
> >> >      handle_irq_event+0x71/0x80
> >> >      handle_fasteoi_irq+0x95/0x1e0
> >> >      __common_interrupt+0x6b/0x110
> >> >      common_interrupt+0x63/0xe0
> >> >      asm_common_interrupt+0x1e/0x40
> >> >      ? __do_softirq+0x75/0x2f3
> >> >      irq_exit_rcu+0x93/0xe0
> >> >      sysvec_apic_timer_interrupt+0xac/0xd0
> >> >      </IRQ>
> >> >      <TASK>
> >> >      asm_sysvec_apic_timer_interrupt+0x12/0x20
> >> >      arch_cpu_idle+0x12/0x20
> >> >      default_idle_call+0x39/0xf0
> >> >      do_idle+0x1b5/0x210
> >> >      cpu_startup_entry+0x20/0x30
> >> >      start_secondary+0xf3/0x100
> >> >      secondary_startup_64_no_verify+0xc3/0xcb
> >> >      </TASK>
> >> >     handlers:
> >> >     [<000000008f9bac49>] vp_interrupt
> >> >     [<000000008f9bac49>] vp_interrupt
> >> >     Disabling IRQ #22
> >> >
> >> > This happens because we don't invoke .enable_cbs callback in
> >> > virtio_device_restore(). That callback is used by some transports
> >> > (e.g. virtio-pci) to enable interrupts.
> >> >
> >> > Let's fix it, by calling virtio_device_ready() as we do in
> >> > virtio_dev_probe(). This function calls .enable_cts callback and sets
> >> > DRIVER_OK status bit.
> >> >
> >> > This fix also avoids setting DRIVER_OK twice for those drivers that
> >> > call virtio_device_ready() in the .restore.
> >> >
> >> > Fixes: d50497eb4e55 ("virtio_config: introduce a new .enable_cbs method")
> >> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> > ---
> >> >
> >> > I'm not sure about the fixes tag. That one is more generic, but the
> >> > following one I think introduced the issue.
> >> >
> >> > Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
> >>
> >> Jason what should we do about this one BTW? Just revert? We have other
> >> issues ...
> >
> >Let me post a patch to revert it and give it a rework.
>
> Thanks for reverting it.
>
> Should we queue this patch anyway to prevent future issues and avoid
> setting DRIVER_OK twice?
>
> Please, let me know if I have to resend it by removing the call trace
> that after the revert should no longer occur.

I think we can have another version.

Thanks

>
> Thanks,
> Stefano
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
