Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081B1C433EF
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:55:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5D3611F2
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C5D3611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5080F4048C;
	Fri, 22 Oct 2021 09:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OPPoc4kEPt94; Fri, 22 Oct 2021 09:55:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5B7AD4045B;
	Fri, 22 Oct 2021 09:55:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26966C001F;
	Fri, 22 Oct 2021 09:55:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B14BC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33B268398E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a_FiKzQQUcO9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:55:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD1F683211
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634896547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oyPMC4BMvpJqw94U6eXtKiGzGpxsYuta6e19CXIzYJc=;
 b=SWBdfwyXFodzEyHZEhZ4tGKnn/wCsxaKx3qKGqtHcQAgaFLajatD6MVzawxlhkXlgOs3mr
 BHqHScbo/U5NizR93XbZcA2xsFaco7k74I80hIcnGr3dbPcYa1sebS92rNhFW00gLsNH71
 eY+HIHsjKSqpWvEE6o6ECCQ2NtB8D1Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-_UPka-0lOvmC9pyOFsj9QQ-1; Fri, 22 Oct 2021 05:55:43 -0400
X-MC-Unique: _UPka-0lOvmC9pyOFsj9QQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 a18-20020a1cf012000000b0032ca3eb2ac3so131535wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 02:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oyPMC4BMvpJqw94U6eXtKiGzGpxsYuta6e19CXIzYJc=;
 b=ZRlBQEX0FRX3uFzkwtaWiGDrrexbQymk3AJ70+LHI1+FdebMxn7uLHd71/rnHidufC
 3UiroIiy8m9CYlxrUTm4CXnS5EMy5gZNtfmo+xOCaGi2URFeMiyZf1BRL3boMNzv7D0a
 tqNVd0ewnq+hnEeie86bX2JhJEPtaeSa8yW9oe1vTz0fuUcM1BzTLaqCcPY3f6qCFSPb
 3YYS3P+UudAciHZPmjUrbn1amJTyJ+o5OCPT5IKNfeWM9/DTifIPG7hPRki1Zh3k6m9z
 yHq7XVMKMKI2pH9riaH6U8cSgo3dV9/CMlHkGY58VUXPsU9v4DCV/v1qLIMZCBDXZlOe
 1laQ==
X-Gm-Message-State: AOAM530rdVyA3+7gqZttfH57joKWFJe8Y6NQ9c49C+dVpflEt+KJBnNm
 3LnC5cdRF2RI7s6KW4urCeqobBvDnYMs0ZBO0YR4ZnUmBwHOp2bFpuQ3qJkYlB7fQWiDuAnh567
 eqJcnK4XKBpqVddf9TAO11IK53F3TWmbq7lqprx2eBw==
X-Received: by 2002:a05:6000:1869:: with SMTP id
 d9mr14403326wri.161.1634896542312; 
 Fri, 22 Oct 2021 02:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwIIRMmly5S+2vEgMYm1nfr2gbIxOjr1BxuUmgnL4D0uDvFMZ0WeH9ER1EUR3epP9MJyTeVA==
X-Received: by 2002:a05:6000:1869:: with SMTP id
 d9mr14403280wri.161.1634896541986; 
 Fri, 22 Oct 2021 02:55:41 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id r4sm9621807wrz.58.2021.10.22.02.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 02:55:41 -0700 (PDT)
Date: Fri, 22 Oct 2021 05:55:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V4 2/8] fork: move PF_IO_WORKER's kernel frame setup to
 new flag
Message-ID: <20211022055416-mutt-send-email-mst@kernel.org>
References: <20211007214448.6282-1-michael.christie@oracle.com>
 <20211007214448.6282-3-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20211007214448.6282-3-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, hdanton@sina.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 vverma@digitalocean.com, geert@linux-m68k.org, stefanha@redhat.com,
 christian.brauner@ubuntu.com
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

On Thu, Oct 07, 2021 at 04:44:42PM -0500, Mike Christie wrote:
> The vhost worker threads need the same frame setup as io_uring's worker
> threads, but handle signals differently and do not need the same
> scheduling behavior. This patch separate's the frame setup parts of
> PF_IO_WORKER into a new PF flag PF_USER_WORKER.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  arch/alpha/kernel/process.c      | 2 +-
>  arch/arc/kernel/process.c        | 2 +-
>  arch/arm/kernel/process.c        | 2 +-
>  arch/arm64/kernel/process.c      | 2 +-
>  arch/csky/kernel/process.c       | 2 +-
>  arch/h8300/kernel/process.c      | 2 +-
>  arch/hexagon/kernel/process.c    | 2 +-
>  arch/ia64/kernel/process.c       | 2 +-
>  arch/m68k/kernel/process.c       | 2 +-
>  arch/microblaze/kernel/process.c | 2 +-
>  arch/mips/kernel/process.c       | 2 +-
>  arch/nds32/kernel/process.c      | 2 +-
>  arch/nios2/kernel/process.c      | 2 +-
>  arch/openrisc/kernel/process.c   | 2 +-
>  arch/parisc/kernel/process.c     | 2 +-
>  arch/powerpc/kernel/process.c    | 2 +-
>  arch/riscv/kernel/process.c      | 2 +-
>  arch/s390/kernel/process.c       | 2 +-
>  arch/sh/kernel/process_32.c      | 2 +-
>  arch/sparc/kernel/process_32.c   | 2 +-
>  arch/sparc/kernel/process_64.c   | 2 +-
>  arch/um/kernel/process.c         | 2 +-
>  arch/x86/kernel/process.c        | 2 +-
>  arch/xtensa/kernel/process.c     | 2 +-
>  include/linux/sched.h            | 1 +
>  include/linux/sched/task.h       | 1 +
>  kernel/fork.c                    | 4 +++-
>  27 files changed, 29 insertions(+), 25 deletions(-)


For something that's touching include/linux/sched.h
and all arches at once, this has not been CC'd widely enough.


> diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
> index a5123ea426ce..e350fff2ea14 100644
> --- a/arch/alpha/kernel/process.c
> +++ b/arch/alpha/kernel/process.c
> @@ -249,7 +249,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>  	childti->pcb.ksp = (unsigned long) childstack;
>  	childti->pcb.flags = 1;	/* set FEN, clear everything else */
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		/* kernel thread */
>  		memset(childstack, 0,
>  			sizeof(struct switch_stack) + sizeof(struct pt_regs));
> diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
> index 3793876f42d9..c3f4952cce17 100644
> --- a/arch/arc/kernel/process.c
> +++ b/arch/arc/kernel/process.c
> @@ -191,7 +191,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>  	childksp[0] = 0;			/* fp */
>  	childksp[1] = (unsigned long)ret_from_fork; /* blink */
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		memset(c_regs, 0, sizeof(struct pt_regs));
>  
>  		c_callee->r13 = kthread_arg;
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 0e2d3051741e..449c9db3942a 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -247,7 +247,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  	thread->cpu_domain = get_domain();
>  #endif
>  
> -	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
> +	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
>  		*childregs = *current_pt_regs();
>  		childregs->ARM_r0 = 0;
>  		if (stack_start)
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 40adb8cdbf5a..e2fe88a3ae90 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -333,7 +333,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  
>  	ptrauth_thread_init_kernel(p);
>  
> -	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
> +	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
>  		*childregs = *current_pt_regs();
>  		childregs->regs[0] = 0;
>  
> diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
> index 3d0ca22cd0e2..509f2bfe4ace 100644
> --- a/arch/csky/kernel/process.c
> +++ b/arch/csky/kernel/process.c
> @@ -49,7 +49,7 @@ int copy_thread(unsigned long clone_flags,
>  	/* setup thread.sp for switch_to !!! */
>  	p->thread.sp = (unsigned long)childstack;
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		childstack->r15 = (unsigned long) ret_from_kernel_thread;
>  		childstack->r10 = kthread_arg;
> diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
> index 2ac27e4248a4..11baf058b6c5 100644
> --- a/arch/h8300/kernel/process.c
> +++ b/arch/h8300/kernel/process.c
> @@ -112,7 +112,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>  
>  	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		childregs->retpc = (unsigned long) ret_from_kernel_thread;
>  		childregs->er4 = topstk; /* arg */
> diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
> index 6a6835fb4242..f17573b66303 100644
> --- a/arch/hexagon/kernel/process.c
> +++ b/arch/hexagon/kernel/process.c
> @@ -73,7 +73,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>  						    sizeof(*ss));
>  	ss->lr = (unsigned long)ret_from_fork;
>  	p->thread.switch_sp = ss;
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		/* r24 <- fn, r25 <- arg */
>  		ss->r24 = usp;
> diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
> index e56d63f4abf9..4a58daa56af4 100644
> --- a/arch/ia64/kernel/process.c
> +++ b/arch/ia64/kernel/process.c
> @@ -338,7 +338,7 @@ copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
>  
>  	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		if (unlikely(!user_stack_base)) {
>  			/* fork_idle() called us */
>  			return 0;
> diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
> index 1ab692b952cd..e7474a118410 100644
> --- a/arch/m68k/kernel/process.c
> +++ b/arch/m68k/kernel/process.c
> @@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>  	 */
>  	p->thread.fc = USER_DATA;
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		/* kernel thread */
>  		memset(frame, 0, sizeof(struct fork_frame));
>  		frame->regs.sr = PS_S;
> diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
> index 62aa237180b6..5b543be324d4 100644
> --- a/arch/microblaze/kernel/process.c
> +++ b/arch/microblaze/kernel/process.c
> @@ -59,7 +59,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>  	struct pt_regs *childregs = task_pt_regs(p);
>  	struct thread_info *ti = task_thread_info(p);
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		/* if we're creating a new kernel thread then just zeroing all
>  		 * the registers. That's OK for a brand new thread.*/
>  		memset(childregs, 0, sizeof(struct pt_regs));
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 95aa86fa6077..d9ca11dd544f 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -120,7 +120,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>  	/*  Put the stack after the struct pt_regs.  */
>  	childksp = (unsigned long) childregs;
>  	p->thread.cp0_status = (read_c0_status() & ~(ST0_CU2|ST0_CU1)) | ST0_KERNEL_CUMASK;
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		/* kernel thread */
>  		unsigned long status = p->thread.cp0_status;
>  		memset(childregs, 0, sizeof(struct pt_regs));
> diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
> index 391895b54d13..2dba51d1889c 100644
> --- a/arch/nds32/kernel/process.c
> +++ b/arch/nds32/kernel/process.c
> @@ -156,7 +156,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  
>  	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		/* kernel thread fn */
>  		p->thread.cpu_context.r6 = stack_start;
> diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
> index 9ff37ba2bb60..ce6ad177da15 100644
> --- a/arch/nios2/kernel/process.c
> +++ b/arch/nios2/kernel/process.c
> @@ -109,7 +109,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>  	struct switch_stack *childstack =
>  		((struct switch_stack *)childregs) - 1;
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		memset(childstack, 0,
>  			sizeof(struct switch_stack) + sizeof(struct pt_regs));
>  
> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> index b0698d9ce14f..d1d189c16676 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -172,7 +172,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>  	sp -= sizeof(struct pt_regs);
>  	kregs = (struct pt_regs *)sp;
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		memset(kregs, 0, sizeof(struct pt_regs));
>  		kregs->gpr[20] = usp; /* fn, kernel thread */
>  		kregs->gpr[22] = arg;
> diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
> index 38ec4ae81239..257bec7e67d4 100644
> --- a/arch/parisc/kernel/process.c
> +++ b/arch/parisc/kernel/process.c
> @@ -197,7 +197,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
>  	extern void * const ret_from_kernel_thread;
>  	extern void * const child_return;
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		/* kernel thread */
>  		memset(cregs, 0, sizeof(struct pt_regs));
>  		if (!usp) /* idle thread */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 50436b52c213..817847723bff 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1700,7 +1700,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>  	/* Copy registers */
>  	sp -= sizeof(struct pt_regs);
>  	childregs = (struct pt_regs *) sp;
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		/* kernel thread */
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		childregs->gpr[1] = sp + sizeof(struct pt_regs);
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 03ac3aa611f5..8deeb94eb51e 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -125,7 +125,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>  	struct pt_regs *childregs = task_pt_regs(p);
>  
>  	/* p->thread holds context to be restored by __switch_to() */
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		/* Kernel thread */
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		childregs->gp = gp_in_global;
> diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> index 350e94d0cac2..f596843ab55c 100644
> --- a/arch/s390/kernel/process.c
> +++ b/arch/s390/kernel/process.c
> @@ -130,7 +130,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
>  	frame->sf.gprs[9] = (unsigned long)frame;
>  
>  	/* Store access registers to kernel stack of new process. */
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		/* kernel thread */
>  		memset(&frame->childregs, 0, sizeof(struct pt_regs));
>  		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
> diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
> index 717de05c81f4..e74906f53c3e 100644
> --- a/arch/sh/kernel/process_32.c
> +++ b/arch/sh/kernel/process_32.c
> @@ -114,7 +114,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>  
>  	childregs = task_pt_regs(p);
>  	p->thread.sp = (unsigned long) childregs;
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		p->thread.pc = (unsigned long) ret_from_kernel_thread;
>  		childregs->regs[4] = arg;
> diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
> index bbbe0cfef746..978e0bc10ad4 100644
> --- a/arch/sparc/kernel/process_32.c
> +++ b/arch/sparc/kernel/process_32.c
> @@ -296,7 +296,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  	ti->ksp = (unsigned long) new_stack;
>  	p->thread.kregs = childregs;
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		extern int nwindows;
>  		unsigned long psr;
>  		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
> diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
> index d1cc410d2f64..1c45cd5089f4 100644
> --- a/arch/sparc/kernel/process_64.c
> +++ b/arch/sparc/kernel/process_64.c
> @@ -594,7 +594,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  				       sizeof(struct sparc_stackf));
>  	t->fpsaved[0] = 0;
>  
> -	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		memset(child_trap_frame, 0, child_stack_sz);
>  		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
>  			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> index 457a38db368b..2bc3141cbf01 100644
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
>  		unsigned long arg, struct task_struct * p, unsigned long tls)
>  {
>  	void (*handler)(void);
> -	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
> +	int kthread = current->flags & (PF_KTHREAD | PF_USER_WORKER);
>  	int ret = 0;
>  
>  	p->thread = (struct thread_struct) INIT_THREAD;
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 1d9463e3096b..d88be9dd5dfd 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -178,7 +178,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  	task_user_gs(p) = get_user_gs(current_pt_regs());
>  #endif
>  
> -	if (unlikely(p->flags & PF_IO_WORKER)) {
> +	if (unlikely(p->flags & PF_USER_WORKER)) {
>  		/*
>  		 * An IO thread is a user space thread, but it doesn't
>  		 * return to ret_after_fork().
> diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
> index 060165340612..61ad0bfbd7ea 100644
> --- a/arch/xtensa/kernel/process.c
> +++ b/arch/xtensa/kernel/process.c
> @@ -217,7 +217,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
>  
>  	p->thread.sp = (unsigned long)childregs;
>  
> -	if (!(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	if (!(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		struct pt_regs *regs = current_pt_regs();
>  		unsigned long usp = usp_thread_fn ?
>  			usp_thread_fn : regs->areg[1];
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c1a927ddec64..b1027e916be4 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1665,6 +1665,7 @@ extern struct pid *cad_pid;
>  #define PF_VCPU			0x00000001	/* I'm a virtual CPU */
>  #define PF_IDLE			0x00000002	/* I am an IDLE thread */
>  #define PF_EXITING		0x00000004	/* Getting shut down */
> +#define PF_USER_WORKER		0x00000008	/* Kernel thread cloned from userspace thread */
>  #define PF_IO_WORKER		0x00000010	/* Task is an IO worker */
>  #define PF_WQ_WORKER		0x00000020	/* I'm a workqueue worker */
>  #define PF_FORKNOEXEC		0x00000040	/* Forked but didn't exec */
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 48417c735438..53599a99d7e0 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -19,6 +19,7 @@ struct css_set;
>  #define CLONE_LEGACY_FLAGS 0xffffffffULL
>  
>  #define KERN_WORKER_IO		BIT(0)
> +#define KERN_WORKER_USER	BIT(1)
>  
>  struct kernel_clone_args {
>  	u64 flags;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3988106e9609..4f780424de46 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2035,6 +2035,8 @@ static __latent_entropy struct task_struct *copy_process(
>  		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
>  	}
>  
> +	if (args->worker_flags & KERN_WORKER_USER)
> +		p->flags |= PF_USER_WORKER;
>  	/*
>  	 * This _must_ happen before we call free_task(), i.e. before we jump
>  	 * to any of the bad_fork_* labels. This is to avoid freeing
> @@ -2526,7 +2528,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
>  		.stack		= (unsigned long)fn,
>  		.stack_size	= (unsigned long)arg,
> -		.worker_flags	= KERN_WORKER_IO,
> +		.worker_flags	= KERN_WORKER_IO | KERN_WORKER_USER,
>  	};
>  
>  	return copy_process(NULL, 0, node, &args);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
