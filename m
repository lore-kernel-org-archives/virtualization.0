Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D55FC2D0E4
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 03:15:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF6B24695
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 03:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAlpYTcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF6B24695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3510B8683F;
	Wed, 18 Nov 2020 03:15:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ixEmZM1Y9Dlb; Wed, 18 Nov 2020 03:15:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A31A986815;
	Wed, 18 Nov 2020 03:15:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 968F7C0800;
	Wed, 18 Nov 2020 03:15:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D021C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 03:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 731308683F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 03:15:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nxQP5m5O+LQk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 03:15:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4635B86815
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 03:15:21 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id r9so296843pjl.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 19:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=45BcZfB4qjtYkI8/2HzFOEDKlMEt7/Y/IUJgFyvoHXM=;
 b=qAlpYTcwc6js2GxHdU4y1zmeWYLd+N3jjzmrmsJvkkKljz/PyVbVnSzdh6F+OMCGBF
 gV7qQ7m43ENNu+dSwF/389Dl0wFSIWCHVFzASzC3jyfVcoWt1sNg6Nx1hveMGHm9EpzN
 kIsSgE9BxaWUWMOWbmWHl6mVhyWj9denNWo0gACsrmsSEOVRgus8DiwxFPVFhKVkqUnf
 hMm/F3LJ3tZ+FgWylYU7kGdrEqyd7y6LLuJMTnrCz5D6EDzFIBAhucaLWjxAemnwoMZ1
 4LlrgouM+xrdM3W9+aOA84Xl08oRVEmts98D4C3Zj6WISRiBFXax0sk4CnQbBxek1t7l
 y0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=45BcZfB4qjtYkI8/2HzFOEDKlMEt7/Y/IUJgFyvoHXM=;
 b=G0xsKLm8nKxg2xqmFUEWGUD1kXxRGz/x3Tnj8uvIVuLTFSKob/9wHSpQqZAsrJVBSR
 nPsJoPgdrd2pWN0cl2kfosctdln6qf3W13Tl85xdxjtkPCWjlVncu1N+UdqfSZCEXGDD
 GfEoRunaOvrjFFWXVBceVpBKBI4b8deaZu+JqSf/KPA4EwzSAV/Jes407h1H56iLb7zh
 bvODOiyJoknqkGEoqYtQE6UxbGiTSc06el+dOLmLIqJCevJKm1/ozXGB+CNtYBL0R4da
 ezGDP8dD3SWqMEKOvdABofjqC9AaECGlrcVYVcWomINv4xwycK6W71V4RG49V4idjp+t
 +soQ==
X-Gm-Message-State: AOAM533w0Wp6C6L8oe4O6Y0FKOm4l7ro+9BgC4P8FoDT552St7HyuU0W
 62V1yefUZmSqa5hResBGcFQ=
X-Google-Smtp-Source: ABdhPJypT3J+8PExIyXsRA8K2la+VPw/1iyTAVlgmd1dN9QAa+DeERbhhdtcXub+Wu0UtvfdGkCvww==
X-Received: by 2002:a17:902:24b:b029:d6:cd52:61e3 with SMTP id
 69-20020a170902024bb02900d6cd5261e3mr2660517plc.2.1605669320697; 
 Tue, 17 Nov 2020 19:15:20 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
 by smtp.gmail.com with ESMTPSA id r4sm21742631pgs.54.2020.11.17.19.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 19:15:19 -0800 (PST)
Date: Wed, 18 Nov 2020 12:15:16 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: netconsole deadlock with virtnet
Message-ID: <X7SRxB6C+9Bm+r4q@jagdpanzerIV.localdomain>
References: <20201117102341.GR47002@unreal>
 <20201117093325.78f1486d@gandalf.local.home>
 <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
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

On (20/11/18 11:46), Sergey Senozhatsky wrote:
[..]
> > Because I'm not sure where the xmit_lock is taken while holding the
> > target_list_lock.
> 
> I don't see where does this happen. It seems to me that the report
> is not about broken locking order, but more about:
> - soft-irq can be preempted (while holding _xmit_lock) by a hardware
>   interrupt, that will attempt to acquire the same _xmit_lock lock.
> 
>    CPU0
>    <<soft IRQ>>
>     virtnet_poll_tx()
>      __netif_tx_lock()
>       spin_lock(_xmit_lock)
>    <<hard IRQ>>
>     add_interrupt_randomness()
>      crng_fast_load()
>       printk()
>        call_console_drivers()
>         spin_lock_irqsave(&target_list_lock)
> 	 spin_lock(_xmit_lock);
> 
> Does this make sense?

Hmm, lockdep says something similar, but there are 2 printk()
happening - both on local and remote CPUs.

[   21.149564]        CPU0                    CPU1
[   21.149565]        ----                    ----
[   21.149566]   lock(_xmit_ETHER#2);
[   21.149569]                                local_irq_disable();
[   21.149570]                                lock(console_owner);
[   21.149572]                                lock(target_list_lock);
[   21.149575]   <Interrupt>
[   21.149576]     lock(console_owner);

This CPU0 lock(_xmit_ETHER#2) -> hard IRQ -> lock(console_owner) is
basically
	soft IRQ -> lock(_xmit_ETHER#2) -> hard IRQ -> printk()

Then CPU1 spins on xmit, which is owned by CPU0, CPU0 spins on
console_owner, which is owned by CPU1?

A quick-and-dirty idea (it doesn't fix the lockdep report) - can we
add some sort of max_loops variable to console_trylock_spinning(),
so that it will not spin forever in `while (READ_ONCE(console_waiter))`
waiting for a console_owner to pass the lock?

	-ss
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
