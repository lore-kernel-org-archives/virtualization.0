Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCE5C433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 09:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 06CB340516;
	Thu, 21 Apr 2022 09:10:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bXqKVklVU0GE; Thu, 21 Apr 2022 09:10:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8D1F7404DF;
	Thu, 21 Apr 2022 09:10:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C737C0033;
	Thu, 21 Apr 2022 09:10:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 407E1C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 09:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F31660E3C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 09:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gDV8EAiQguTG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 09:10:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D002F60804
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 09:10:19 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A4A8060B34;
 Thu, 21 Apr 2022 09:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC654C385A1;
 Thu, 21 Apr 2022 09:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650532218;
 bh=wWg+TqUndPGPiHos3howNQj+fH1A1hLH3CX7tyZnjDo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vx9XAvVe9eJPUylgV21gOM9CWMeYk6NW2jxKf/lucwmXYqwzcu+7fEahRDgixLeAR
 1Jhld4cGG+1fAgZd79HEyxWNjrTmibJ9u3nPaT1LnVtMPR2vzuScfBDv33LEnc+TII
 hfs1W6ratt0h1j7x32P3/Pj2XtX+xjzn81hJ3cKb00+US+SA80Fyep26+5fi2RVJEz
 pp3t6gMgfamhR9MNafZbGQrFHfP7isnmnHym3HQrOh9Fze+x709jx8saAAaOzmK7u4
 h7u2btndjZJtc7uFD6e55EfM3upP3GxvQA5i/leziUlzL3DZaTXqUwo0FhzuoEBee0
 aLwXWBw03RZ7Q==
Date: Thu, 21 Apr 2022 10:10:11 +0100
From: Will Deacon <will@kernel.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] arm64: paravirt: Disable IRQs during
 stolen_time_cpu_down_prepare
Message-ID: <20220421091011.GB8303@willie-the-truck>
References: <20220420204417.155194-1-quic_eberman@quicinc.com>
 <0737998d-3006-5866-5ea1-dcfef0cfeb32@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0737998d-3006-5866-5ea1-dcfef0cfeb32@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Murali Nalajala <quic_mnalajal@quicinc.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Alexey Makhalov <amakhalov@vmware.com>,
 Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Apr 21, 2022 at 09:44:28AM +0200, Juergen Gross wrote:
> On 20.04.22 22:44, Elliot Berman wrote:
> > From: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> > 
> > During hotplug, the stolen time data structure is unmapped and memset.
> > There is a possibility of the timer IRQ being triggered before memset
> > and stolen time is getting updated as part of this timer IRQ handler. This
> > causes the below crash in timer handler -
> > 
> >    [ 3457.473139][    C5] Unable to handle kernel paging request at virtual address ffffffc03df05148
> >    ...
> >    [ 3458.154398][    C5] Call trace:
> >    [ 3458.157648][    C5]  para_steal_clock+0x30/0x50
> >    [ 3458.162319][    C5]  irqtime_account_process_tick+0x30/0x194
> >    [ 3458.168148][    C5]  account_process_tick+0x3c/0x280
> >    [ 3458.173274][    C5]  update_process_times+0x5c/0xf4
> >    [ 3458.178311][    C5]  tick_sched_timer+0x180/0x384
> >    [ 3458.183164][    C5]  __run_hrtimer+0x160/0x57c
> >    [ 3458.187744][    C5]  hrtimer_interrupt+0x258/0x684
> >    [ 3458.192698][    C5]  arch_timer_handler_virt+0x5c/0xa0
> >    [ 3458.198002][    C5]  handle_percpu_devid_irq+0xdc/0x414
> >    [ 3458.203385][    C5]  handle_domain_irq+0xa8/0x168
> >    [ 3458.208241][    C5]  gic_handle_irq.34493+0x54/0x244
> >    [ 3458.213359][    C5]  call_on_irq_stack+0x40/0x70
> >    [ 3458.218125][    C5]  do_interrupt_handler+0x60/0x9c
> >    [ 3458.223156][    C5]  el1_interrupt+0x34/0x64
> >    [ 3458.227560][    C5]  el1h_64_irq_handler+0x1c/0x2c
> >    [ 3458.232503][    C5]  el1h_64_irq+0x7c/0x80
> >    [ 3458.236736][    C5]  free_vmap_area_noflush+0x108/0x39c
> >    [ 3458.242126][    C5]  remove_vm_area+0xbc/0x118
> >    [ 3458.246714][    C5]  vm_remove_mappings+0x48/0x2a4
> >    [ 3458.251656][    C5]  __vunmap+0x154/0x278
> >    [ 3458.255796][    C5]  stolen_time_cpu_down_prepare+0xc0/0xd8
> >    [ 3458.261542][    C5]  cpuhp_invoke_callback+0x248/0xc34
> >    [ 3458.266842][    C5]  cpuhp_thread_fun+0x1c4/0x248
> >    [ 3458.271696][    C5]  smpboot_thread_fn+0x1b0/0x400
> >    [ 3458.276638][    C5]  kthread+0x17c/0x1e0
> >    [ 3458.280691][    C5]  ret_from_fork+0x10/0x20
> > 
> > As a fix, disable the IRQs during hotplug until we unmap and memset the
> > stolen time structure.
> 
> This will work for the call chain of your observed crash, but are
> you sure that para_steal_clock() can't be called from another cpu
> concurrently?

Agreed, this needs checking as update_rq_clock() is called from all over the
place.

> In case you verified this can't happen, you can add my:
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> 
> Otherwise you either need to use RCU for doing the memunmap(), or a
> lock to protect stolen_time_region.

Yes, I think RCU would make a lot of sense here, deferring the memunmap
until there are no longer any readers. The reader is currently doing:

	if (!reg->kaddr)
		return 0;

	return le64_to_cpu(READ_ONCE(reg->kaddr->stolen_time));

so we'd also want an rcu_dereference() on reg->kaddr to avoid reading it
twice.

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
