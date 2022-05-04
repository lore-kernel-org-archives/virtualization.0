Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022F9C433EF
	for <virtualization@archiver.kernel.org>; Wed,  4 May 2022 09:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A003183ED0;
	Wed,  4 May 2022 09:45:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SXL_QldpcM5b; Wed,  4 May 2022 09:45:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1E6FB83E93;
	Wed,  4 May 2022 09:45:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8911C0039;
	Wed,  4 May 2022 09:45:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2651C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 09:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79626404C9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 09:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JHtY6BLM-7yN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 09:45:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46D1B404A6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 09:45:18 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2F4DFB82330;
 Wed,  4 May 2022 09:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B535EC385A4;
 Wed,  4 May 2022 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651657514;
 bh=mgX/1b7wCSIg/ykp87hv7mP4XlOH4JBMZFNTWgxvqHU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UXMlWflztzqrJWz+qr5UJNyAKRGJkXDZMUhBAckFhV9FOSeMBbRfrdmjHJg9J9C8a
 5uq+3GDwrSFPXT6hdj1CDU/tI5qWVkOSkRYZDllsaPtvpf8zBmTZY0BOj74EPC6vk8
 zERnJilqK288f1BZau0nu0HrxcZjAZ8xO1629VggaMowE8K0fEiisHlNZ7NhHnQtZE
 4MKzsXAXwNvNb7LAkKUeSk9U1tlS16pzu1K3JmrlOq4pf7Q4vmbw/s0zJnFZl90w6S
 2QKe33vnuNEfzMFmde/bdfvfXAZOYyQRNCblX9dzkvu6gP9krZcFDvCpaR5XRSjxEN
 fD9swItLa7KoQ==
Date: Wed, 4 May 2022 10:45:07 +0100
From: Will Deacon <will@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v2] arm64: paravirt: Use RCU read locks to guard
 stolen_time
Message-ID: <20220504094507.GA20305@willie-the-truck>
References: <20220428183536.2866667-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220428183536.2866667-1-quic_eberman@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Juergen Gross <jgross@suse.com>,
 Murali Nalajala <quic_mnalajal@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
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

On Thu, Apr 28, 2022 at 11:35:36AM -0700, Elliot Berman wrote:
> From: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> 
> During hotplug, the stolen time data structure is unmapped and memset.
> There is a possibility of the timer IRQ being triggered before memset
> and stolen time is getting updated as part of this timer IRQ handler. This
> causes the below crash in timer handler -
> 
>   [ 3457.473139][    C5] Unable to handle kernel paging request at virtual address ffffffc03df05148
>   ...
>   [ 3458.154398][    C5] Call trace:
>   [ 3458.157648][    C5]  para_steal_clock+0x30/0x50
>   [ 3458.162319][    C5]  irqtime_account_process_tick+0x30/0x194
>   [ 3458.168148][    C5]  account_process_tick+0x3c/0x280
>   [ 3458.173274][    C5]  update_process_times+0x5c/0xf4
>   [ 3458.178311][    C5]  tick_sched_timer+0x180/0x384
>   [ 3458.183164][    C5]  __run_hrtimer+0x160/0x57c
>   [ 3458.187744][    C5]  hrtimer_interrupt+0x258/0x684
>   [ 3458.192698][    C5]  arch_timer_handler_virt+0x5c/0xa0
>   [ 3458.198002][    C5]  handle_percpu_devid_irq+0xdc/0x414
>   [ 3458.203385][    C5]  handle_domain_irq+0xa8/0x168
>   [ 3458.208241][    C5]  gic_handle_irq.34493+0x54/0x244
>   [ 3458.213359][    C5]  call_on_irq_stack+0x40/0x70
>   [ 3458.218125][    C5]  do_interrupt_handler+0x60/0x9c
>   [ 3458.223156][    C5]  el1_interrupt+0x34/0x64
>   [ 3458.227560][    C5]  el1h_64_irq_handler+0x1c/0x2c
>   [ 3458.232503][    C5]  el1h_64_irq+0x7c/0x80
>   [ 3458.236736][    C5]  free_vmap_area_noflush+0x108/0x39c
>   [ 3458.242126][    C5]  remove_vm_area+0xbc/0x118
>   [ 3458.246714][    C5]  vm_remove_mappings+0x48/0x2a4
>   [ 3458.251656][    C5]  __vunmap+0x154/0x278
>   [ 3458.255796][    C5]  stolen_time_cpu_down_prepare+0xc0/0xd8
>   [ 3458.261542][    C5]  cpuhp_invoke_callback+0x248/0xc34
>   [ 3458.266842][    C5]  cpuhp_thread_fun+0x1c4/0x248
>   [ 3458.271696][    C5]  smpboot_thread_fn+0x1b0/0x400
>   [ 3458.276638][    C5]  kthread+0x17c/0x1e0
>   [ 3458.280691][    C5]  ret_from_fork+0x10/0x20
> 
> As a fix, introduce rcu lock to update stolen time structure.
> 
> Fixes: 75df529bec91 ("arm64: paravirt: Initialize steal time when cpu is online")
> Cc: stable@vger.kernel.org
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
> Changes since v1: https://lore.kernel.org/all/20220420204417.155194-1-quic_eberman@quicinc.com/
>  - Use RCU instead of disabling interrupts
> 
>  arch/arm64/kernel/paravirt.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
> index 75fed4460407..e724ea3d86f0 100644
> --- a/arch/arm64/kernel/paravirt.c
> +++ b/arch/arm64/kernel/paravirt.c
> @@ -52,7 +52,9 @@ early_param("no-steal-acc", parse_no_stealacc);
>  /* return stolen time in ns by asking the hypervisor */
>  static u64 para_steal_clock(int cpu)
>  {
> +	struct pvclock_vcpu_stolen_time *kaddr = NULL;
>  	struct pv_time_stolen_time_region *reg;
> +	u64 ret = 0;
>  
>  	reg = per_cpu_ptr(&stolen_time_region, cpu);
>  
> @@ -61,28 +63,38 @@ static u64 para_steal_clock(int cpu)
>  	 * online notification callback runs. Until the callback
>  	 * has run we just return zero.
>  	 */
> -	if (!reg->kaddr)
> +	rcu_read_lock();
> +	kaddr = rcu_dereference(reg->kaddr);
> +	if (!kaddr) {
> +		rcu_read_unlock();
>  		return 0;
> +	}
>  
> -	return le64_to_cpu(READ_ONCE(reg->kaddr->stolen_time));
> +	ret = le64_to_cpu(READ_ONCE(kaddr->stolen_time));

Is this READ_ONCE() still required now?

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
