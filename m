Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBBEC2D0E4
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 02:46:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8213F22228
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 02:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVlG47Wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8213F22228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B529E20416;
	Wed, 18 Nov 2020 02:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dDbbjAKZaNKe; Wed, 18 Nov 2020 02:46:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4F16520334;
	Wed, 18 Nov 2020 02:46:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E959C0891;
	Wed, 18 Nov 2020 02:46:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC09EC07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 02:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AFBD486FF8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 02:46:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2rXmuVP6Ryqs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 02:46:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 01E3486FEC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 02:46:18 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id l11so204889plt.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 18:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bPU2DhJJXJVStV77xG86G5ac7ichu4pjyj3Va1Hl664=;
 b=XVlG47WuGw3eJ9EgGQ0/GHarPO0IIGnQ/tfNpjO7NvzF4ByMk2UuEBrRnh193SKPo6
 H/75TUNzcNxN+nhEHgoT/lXs65mxWoL9XWGIRk5hxUi5fQhwgN7nSfTtmIuOqHfYVOcL
 CrDqZOWJ93OVeLX6x4Ifl0arbPLh3vbuTeunZgHVr1Mv43LJcwUGOCHW+fhh7YBNmwX4
 tHKbI1Fknfqk9Na5Re04wqqdnnZl7XKBfpRjfs7xG6hFU+8Bcf/C4fvsGA+lqhItY2bT
 iV9eTv/IoDcDOD7nFbNKbqQD6G5TPD07TiHLk3fb1NuAXOTFxkPjk8HeesTmHQIssPkw
 NC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bPU2DhJJXJVStV77xG86G5ac7ichu4pjyj3Va1Hl664=;
 b=YXh6r4HirHm0WjiPot3IajT9Pp6h6wXRM6GtgY4FQ0F8Xr7ieGdSA3Tj2LlOVWJcVZ
 Gg6CIUb2JRFmHHxU8TjXtJIauoTyEEse+4pncKbjfB0gb8ZRGwqZaB6wnbd2hIQL3bgY
 f0g33iNNX6fBY2rX6nv4UvfdQ6MVcqklWm/5Ps2qNcL26WOBIWQgTxnB+UhXOf/TBKJy
 K8xTVlwTs9BWpADjay/v3B7claeIK6lMoy9QPZYoWD/fFxHKqx/5wy7vyCs/nf/iSPVz
 yxIV4O4R+1RnwD6FsJyQPa+4+IRkBXIcO0RLuLtyeWjTt2OBqmV9VEjJcuSVoE8jQb/d
 ZUsA==
X-Gm-Message-State: AOAM5339lOw8PtVcC7aX0MHaZzSqdbG59e7qfh3fL74W7eGtI4u2CcOz
 /wPGvFmkbyBPwCJkL1tFpQE=
X-Google-Smtp-Source: ABdhPJwlKGAC6E9v5zVwN47VHI9EDvi6oL9MX6DLHzIPYGwYzwHn/lLEwIts3zbgyKyalEkQ5+dK+Q==
X-Received: by 2002:a17:902:788a:b029:d6:b9f:820a with SMTP id
 q10-20020a170902788ab02900d60b9f820amr2537595pll.76.1605667578324; 
 Tue, 17 Nov 2020 18:46:18 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
 by smtp.gmail.com with ESMTPSA id gm24sm507172pjb.20.2020.11.17.18.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 18:46:17 -0800 (PST)
Date: Wed, 18 Nov 2020 11:46:14 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: netconsole deadlock with virtnet
Message-ID: <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
References: <20201117102341.GR47002@unreal>
 <20201117093325.78f1486d@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201117093325.78f1486d@gandalf.local.home>
Cc: Petr Mladek <pmladek@suse.com>, Leon Romanovsky <leon@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Amit Shah <amit@kernel.org>, virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Ran Rozenstein <ranro@nvidia.com>, Itay Aveksis <itayav@nvidia.com>
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

On (20/11/17 09:33), Steven Rostedt wrote:
> > [   21.149601]     IN-HARDIRQ-W at:
> > [   21.149602]                          __lock_acquire+0xa78/0x1a94
> > [   21.149603]                          lock_acquire.part.0+0x170/0x360
> > [   21.149604]                          lock_acquire+0x68/0x8c
> > [   21.149605]                          console_unlock+0x1e8/0x6a4
> > [   21.149606]                          vprintk_emit+0x1c4/0x3c4
> > [   21.149607]                          vprintk_default+0x40/0x4c
> > [   21.149608]                          vprintk_func+0x10c/0x220
> > [   21.149610]                          printk+0x68/0x90
> > [   21.149611]                          crng_fast_load+0x1bc/0x1c0
> > [   21.149612]                          add_interrupt_randomness+0x280/0x290
> > [   21.149613]                          handle_irq_event+0x80/0x120
> > [   21.149614]                          handle_fasteoi_irq+0xac/0x200
> > [   21.149615]                          __handle_domain_irq+0x84/0xf0
> > [   21.149616]                          gic_handle_irq+0xd4/0x320
> > [   21.149617]                          el1_irq+0xd0/0x180
> > [   21.149618]                          arch_cpu_idle+0x24/0x44
> > [   21.149619]                          default_idle_call+0x48/0xa0
> > [   21.149620]                          do_idle+0x260/0x300
> > [   21.149621]                          cpu_startup_entry+0x30/0x6c
> > [   21.149622]                          rest_init+0x1b4/0x288
> > [   21.149624]                          arch_call_rest_init+0x18/0x24
> > [   21.149625]                          start_kernel+0x5cc/0x608
> > [   21.149625]     IN-SOFTIRQ-W at:
> > [   21.149627]                          __lock_acquire+0x894/0x1a94
> > [   21.149628]                          lock_acquire.part.0+0x170/0x360
> > [   21.149629]                          lock_acquire+0x68/0x8c
> > [   21.149630]                          console_unlock+0x1e8/0x6a4
> > [   21.149631]                          vprintk_emit+0x1c4/0x3c4
> > [   21.149632]                          vprintk_default+0x40/0x4c
> > [   21.149633]                          vprintk_func+0x10c/0x220
> > [   21.149634]                          printk+0x68/0x90
> > [   21.149635]                          hrtimer_interrupt+0x290/0x294
> > [   21.149636]                          arch_timer_handler_virt+0x3c/0x50
> > [   21.149637]                          handle_percpu_devid_irq+0x94/0x164
> > [   21.149673]                          __handle_domain_irq+0x84/0xf0
> > [   21.149674]                          gic_handle_irq+0xd4/0x320
> > [   21.149675]                          el1_irq+0xd0/0x180
> > [   21.149676]                          __do_softirq+0x108/0x638
> > [   21.149677]                          __irq_exit_rcu+0x17c/0x1b0
> > [   21.149678]                          irq_exit+0x18/0x44
> > [   21.149679]                          __handle_domain_irq+0x88/0xf0
> > [   21.149680]                          gic_handle_irq+0xd4/0x320
> > [   21.149681]                          el1_irq+0xd0/0x180
> > [   21.149682]                          smp_call_function_many_cond+0x3cc/0x3f0
> > [   21.149683]                          kick_all_cpus_sync+0x4c/0x80
> > [   21.149684]                          load_module+0x1eec/0x2734
> > [   21.149685]                          __do_sys_finit_module+0xbc/0x12c
> > [   21.149686]                          __arm64_sys_finit_module+0x28/0x34
> > [   21.149687]                          el0_svc_common.constprop.0+0x84/0x200
> > [   21.149688]                          do_el0_svc+0x2c/0x90
> > [   21.149689]                          el0_svc+0x18/0x50
> > [   21.149690]                          el0_sync_handler+0xe0/0x350
> > [   21.149691]                          el0_sync+0x158/0x180

[..]

> It really sucks that we lose 190 messages that would help to decipher this
> more. :-p

Indeed.

> Because I'm not sure where the xmit_lock is taken while holding the
> target_list_lock.

I don't see where does this happen. It seems to me that the report
is not about broken locking order, but more about:
- soft-irq can be preempted (while holding _xmit_lock) by a hardware
  interrupt, that will attempt to acquire the same _xmit_lock lock.

   CPU0
   <<soft IRQ>>
    virtnet_poll_tx()
     __netif_tx_lock()
      spin_lock(_xmit_lock)
   <<hard IRQ>>
    add_interrupt_randomness()
     crng_fast_load()
      printk()
       call_console_drivers()
        spin_lock_irqsave(&target_list_lock)
	 spin_lock(_xmit_lock);

Does this make sense?

	-ss
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
