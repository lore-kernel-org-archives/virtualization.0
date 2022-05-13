Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA849C433F5
	for <virtualization@archiver.kernel.org>; Sat, 14 May 2022 00:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8024F83F2C;
	Sat, 14 May 2022 00:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C4mhUSfMn1JE; Sat, 14 May 2022 00:04:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E5B6183F16;
	Sat, 14 May 2022 00:04:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDE6AC0039;
	Sat, 14 May 2022 00:04:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07D62C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E277141794
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 94zY0KQxexeo
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:04:54 +0000 (UTC)
X-Greylist: delayed 00:31:31 by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD7C1409B3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:04:54 +0000 (UTC)
Received: from [128.177.82.146] (helo=srivatsab-a02.vmware.com)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1npemM-000Vex-0L; Fri, 13 May 2022 19:33:02 -0400
To: Elliot Berman <quic_eberman@quicinc.com>, Juergen Gross
 <jgross@suse.com>, Alexey Makhalov <amakhalov@vmware.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20220513174654.362169-1-quic_eberman@quicinc.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v3] arm64: paravirt: Use RCU read locks to guard
 stolen_time
Message-ID: <c24e405e-b5f9-d2f7-a629-1ee1beab3681@csail.mit.edu>
Date: Fri, 13 May 2022 16:32:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220513174654.362169-1-quic_eberman@quicinc.com>
Content-Language: en-US
Cc: Murali Nalajala <quic_mnalajal@quicinc.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

On 5/13/22 10:46 AM, Elliot Berman wrote:
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
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---

Looks good to me, but one quick question though (see below).

Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

>  
>  static int stolen_time_cpu_down_prepare(unsigned int cpu)
>  {
> +	struct pvclock_vcpu_stolen_time *kaddr = NULL;
>  	struct pv_time_stolen_time_region *reg;
>  
>  	reg = this_cpu_ptr(&stolen_time_region);
>  	if (!reg->kaddr)
>  		return 0;
>  
> -	memunmap(reg->kaddr);
> -	memset(reg, 0, sizeof(*reg));
> +	kaddr = rcu_replace_pointer(reg->kaddr, NULL, true);
> +	synchronize_rcu();
> +	memunmap(kaddr);
>  

The original code used to memset the stolen time region, but this
patch seems to drop it. Was that change intentional?

Regards,
Srivatsa
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
