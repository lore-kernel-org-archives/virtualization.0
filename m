Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41581C433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 02:23:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D47D5408DF;
	Wed, 11 May 2022 02:23:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id csY1kkxd5qHr; Wed, 11 May 2022 02:23:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 53DD940463;
	Wed, 11 May 2022 02:23:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26C12C0032;
	Wed, 11 May 2022 02:23:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9271C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B444F82EF0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PKl2w_byVKQL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:23:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B013982E22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652235795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NoNShCUgG/r5sx7GtSLhujeTcuOeCXLnixMsESYMdzg=;
 b=Mo172dR/XPeQRbZvRdT99BnmDmJQa1BmkLnPnwRS/LGRKfaDjUas9EQPw+KVPDL9bfv7ME
 hnozkNVVkhIiSX/png3SsL1hXkeeOUQWZccKRW5c5hVocYZLsUKZ+4OKg59eueLuCCZ/vB
 SkCJcZ8YxqbUu5gFRqlxQICaxHpSG2o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-DwVo-NPvMOCE_G7N9ukavw-1; Tue, 10 May 2022 22:23:12 -0400
X-MC-Unique: DwVo-NPvMOCE_G7N9ukavw-1
Received: by mail-lj1-f200.google.com with SMTP id
 194-20020a2e09cb000000b002508b2e655dso179800ljj.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 19:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NoNShCUgG/r5sx7GtSLhujeTcuOeCXLnixMsESYMdzg=;
 b=iB60nkEHoxMTL5Yp2P7dLe7hivxxEJSK/i3BBACplpfAfGzsRmhmkVVx9qsGF0SF5x
 msBz34/UpW8Z+8U5Z8Us/6F4qKQZtO0e7AZkJMTTcaJCO/ADJXLQu1JqEQNXc2HIHdw/
 6U+FxeXX7dHT/NRBiI5KW1eW8vZKkcI2Lzr2HDRo2toXmqnz5Nvism2x4viyjpPXHg8y
 EublmG3UfO1I5X6155yQfanf4/kVjRo7Rs3Hndyi0hXv2XH5VOHCVDGbePmSKfoHyIod
 DL1Qeynsk7I0R2nuFXPvOqPvBMvBrxZcQXOqw8eq9m+OmeBPY38sc+AxtOahJHZo0obG
 Ogaw==
X-Gm-Message-State: AOAM530yWwI7NdXsguBMDY2q+zkZ/PJ9YUTshDbGNAdJngcg/TTUzOXF
 zfpzTM04xiS173e7f8C7aBMW7Sy43eEeS5w8+eA+C/v6yVikLc/UO+x/ZUQP4i7kuBRYUdDj9T5
 gLUg1x1M8e7Mli9yALMDZvbS5cUNV7mKXxK2MAeG955kGXqMUZBbbJVCcsQ==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr18193782lfj.587.1652235790481; 
 Tue, 10 May 2022 19:23:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfn5RF53v2JjmJJQkV8pzwLGeqEl3ZHCNTpF3vbu92pgelfIJ4hMyyAb1vY2XGHUKz6rIPN4WAR3mln3WzRxs=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr18193766lfj.587.1652235790258; Tue, 10
 May 2022 19:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com>
 <875ymd3fd1.fsf@redhat.com>
In-Reply-To: <875ymd3fd1.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 May 2022 10:22:59 +0800
Message-ID: <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
Subject: Re: [PATCH V4 0/9] rework on the IRQ hardening of virtio
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 mst <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Tue, May 10, 2022 at 5:29 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Sat, May 07 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > Hi All:
> >
> > This is a rework on the IRQ hardening for virtio which is done
> > previously by the following commits are reverted:
> >
> > 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
> > 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
> >
> > The reason is that it depends on the IRQF_NO_AUTOEN which may conflict
> > with the assumption of the affinity managed IRQ that is used by some
> > virtio drivers. And what's more, it is only done for virtio-pci but
> > not other transports.
> >
> > In this rework, I try to implement a general virtio solution which
> > borrows the idea of the INTX hardening by re-using per virtqueue
> > boolean vq->broken and toggle it in virtio_device_ready() and
> > virtio_reset_device(). Then we can simply reuse the existing checks in
> > the vring_interrupt() and return early if the driver is not ready.
> >
> > Note that, I only did compile test on ccw and MMIO transport.
>
> Lockdep is unhappy with the ccw parts:
>
> ================================
> WARNING: inconsistent lock state
> 5.18.0-rc6+ #191 Not tainted
> --------------------------------
> inconsistent {IN-HARDIRQ-R} -> {HARDIRQ-ON-W} usage.
> kworker/u4:0/9 [HC0[0]:SC0[0]:HE1:SE1] takes:
> 00000000058e9618 (&vcdev->irq_lock){+-..}-{2:2}, at: virtio_ccw_synchronize_cbs+0x4e/0x60
> {IN-HARDIRQ-R} state was registered at:
>   __lock_acquire+0x442/0xc20
>   lock_acquire.part.0+0xdc/0x228
>   lock_acquire+0xa6/0x1b0
>   _raw_read_lock_irqsave+0x72/0x100
>   virtio_ccw_int_handler+0x84/0x238
>   ccw_device_call_handler+0x72/0xd0
>   ccw_device_irq+0x7a/0x198
>   do_cio_interrupt+0x11c/0x1d0
>   __handle_irq_event_percpu+0xc2/0x318
>   handle_irq_event_percpu+0x26/0x68
>   handle_percpu_irq+0x64/0x88
>   generic_handle_irq+0x40/0x58
>   do_irq_async+0x56/0xb0
>   do_io_irq+0x82/0x160
>   io_int_handler+0xe6/0x120
>   rcu_read_lock_sched_held+0x3e/0xb0
>   lock_acquired+0x12e/0x208
>   new_inode+0x3e/0xd0
>   debugfs_get_inode+0x22/0x68
>   __debugfs_create_file+0x78/0x1c0
>   debugfs_create_file_unsafe+0x36/0x58
>   debugfs_create_u32+0x38/0x68
>   sched_init_debug+0xb0/0x1c0
>   do_one_initcall+0x108/0x280
>   do_initcalls+0x124/0x148
>   kernel_init_freeable+0x242/0x280
>   kernel_init+0x2e/0x158
>   __ret_from_fork+0x3c/0x50
>   ret_from_fork+0xa/0x40
> irq event stamp: 539789
> hardirqs last  enabled at (539789): [<0000000000d9c632>] _raw_spin_unlock_irqrestore+0x72/0x88
> hardirqs last disabled at (539788): [<0000000000d9c2b6>] _raw_spin_lock_irqsave+0x96/0xd0
> softirqs last  enabled at (539568): [<0000000000d9e0d4>] __do_softirq+0x434/0x588
> softirqs last disabled at (539503): [<000000000018cd66>] __irq_exit_rcu+0x146/0x170
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&vcdev->irq_lock);
>   <Interrupt>
>     lock(&vcdev->irq_lock);
>
>  *** DEADLOCK ***

It looks to me we need to use write_lock_irq()/write_unlock_irq() to
do the synchronization.

And we probably need to keep the
read_lock_irqsave()/read_lock_irqrestore() logic since I can see the
virtio_ccw_int_handler() to be called from process context (e.g from
the io_subchannel_quiesce()).

Thanks

>
> 2 locks held by kworker/u4:0/9:
>  #0: 000000000288d948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1ea/0x658
>  #1: 000003800004bdc8 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x1ea/0x658
>
> stack backtrace:
> CPU: 1 PID: 9 Comm: kworker/u4:0 Not tainted 5.18.0-rc6+ #191
> Hardware name: QEMU 8561 QEMU (KVM/Linux)
> Workqueue: events_unbound async_run_entry_fn
> Call Trace:
>  [<0000000000d8af22>] dump_stack_lvl+0x92/0xd0
>  [<00000000002032ac>] mark_lock_irq+0x864/0x968
>  [<0000000000203670>] mark_lock.part.0+0x2c0/0x790
>  [<0000000000203cea>] mark_usage+0x10a/0x178
>  [<000000000020692a>] __lock_acquire+0x442/0xc20
>  [<0000000000207cc4>] lock_acquire.part.0+0xdc/0x228
>  [<0000000000207eb6>] lock_acquire+0xa6/0x1b0
>  [<0000000000d9c774>] _raw_write_lock+0x54/0xa8
>  [<0000000000d5a1f6>] virtio_ccw_synchronize_cbs+0x4e/0x60
>  [<00000000008eec04>] register_virtio_device+0xdc/0x1b0
>  [<0000000000d5aabe>] virtio_ccw_online+0x246/0x2e8
>  [<0000000000c9fecc>] ccw_device_set_online+0x1c4/0x540
>  [<0000000000d5a05e>] virtio_ccw_auto_online+0x26/0x50
>  [<00000000001ba2b0>] async_run_entry_fn+0x40/0x108
>  [<00000000001ab9b4>] process_one_work+0x2a4/0x658
>  [<00000000001abdd0>] worker_thread+0x68/0x440
>  [<00000000001b4668>] kthread+0x128/0x130
>  [<0000000000102fac>] __ret_from_fork+0x3c/0x50
>  [<0000000000d9d3aa>] ret_from_fork+0xa/0x40
> INFO: lockdep is turned off.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
