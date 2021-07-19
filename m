Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA023C07E95
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 21:04:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5A96113E
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 21:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5A96113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ECDC82F77;
	Mon, 19 Jul 2021 21:04:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MIgSzihXyYc6; Mon, 19 Jul 2021 21:04:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 84AC482D57;
	Mon, 19 Jul 2021 21:04:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56C1BC001A;
	Mon, 19 Jul 2021 21:04:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DD79C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 21:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 692D9402AA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 21:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EkQ14YAjcLq6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 21:04:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8685240155
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 21:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626728656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDzv4r/nKmHoEY/y/S31BYFYyCyd3ydFbHliB67gI10=;
 b=ZypLFW8xkdb+aFF0+TYJSwLYYxoRilXOWlapqh1Q0ab+HWjaMvE0qNEOCF513jq3mnmqTP
 Xf4u2FDuMC+aK3ODd32jdxf25UYJNFcPF83xDHDsZLdNQc/A71nuN6orvpzXWMyG0jYPOB
 Bq1S03cjjNY2iDIPeK2DVGMW8wGjzSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-Lt425qk5P-W4_BxnE0IKdQ-1; Mon, 19 Jul 2021 17:04:15 -0400
X-MC-Unique: Lt425qk5P-W4_BxnE0IKdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A49EA100C610;
 Mon, 19 Jul 2021 21:04:13 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79F4A2706E;
 Mon, 19 Jul 2021 21:04:01 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
 id E87DB4172ED4; Mon, 19 Jul 2021 18:03:55 -0300 (-03)
Date: Mon, 19 Jul 2021 18:03:55 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 1/3] cpuidle: add poll_source API
Message-ID: <20210719210355.GA46373@fuller.cnet>
References: <20210713161906.457857-1-stefanha@redhat.com>
 <20210713161906.457857-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210713161906.457857-2-stefanha@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-pm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Hi Stefan,

On Tue, Jul 13, 2021 at 05:19:04PM +0100, Stefan Hajnoczi wrote:
> Introduce an API for adding cpuidle poll callbacks:
> 
>   struct poll_source_ops {
>       void (*start)(struct poll_source *src);
>       void (*stop)(struct poll_source *src);
>       void (*poll)(struct poll_source *src);
>   };
> 
>   int poll_source_register(struct poll_source *src);
>   int poll_source_unregister(struct poll_source *src);
> 
> When cpuidle enters the poll state it invokes ->start() and then invokes
> ->poll() repeatedly from the busy wait loop. Finally ->stop() is invoked
> when the busy wait loop finishes.
> 
> The ->poll() function should check for activity and cause
> TIF_NEED_RESCHED to be set in order to stop the busy wait loop.
> 
> This API is intended to be used by drivers that can cheaply poll for
> events. Participating in cpuidle polling allows them to avoid interrupt
> latencies during periods where the CPU is going to poll anyway.
> 
> Note that each poll_source is bound to a particular CPU. The API is
> mainly intended to by used by drivers that have multiple queues with irq
> affinity.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  drivers/cpuidle/Makefile      |  1 +
>  include/linux/poll_source.h   | 53 +++++++++++++++++++
>  drivers/cpuidle/poll_source.c | 99 +++++++++++++++++++++++++++++++++++
>  drivers/cpuidle/poll_state.c  |  6 +++
>  4 files changed, 159 insertions(+)
>  create mode 100644 include/linux/poll_source.h
>  create mode 100644 drivers/cpuidle/poll_source.c
> 
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 26bbc5e74123..994f72d6fe95 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -7,6 +7,7 @@ obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
>  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>  obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
>  obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o
> +obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_source.o
>  obj-$(CONFIG_HALTPOLL_CPUIDLE)		  += cpuidle-haltpoll.o
>  
>  ##################################################################################
> diff --git a/include/linux/poll_source.h b/include/linux/poll_source.h
> new file mode 100644
> index 000000000000..ccfb424e170b
> --- /dev/null
> +++ b/include/linux/poll_source.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * poll_source.h - cpuidle busy waiting API
> + */
> +#ifndef __LINUX_POLLSOURCE_H__
> +#define __LINUX_POLLSOURCE_H__
> +
> +#include <linux/list.h>
> +
> +struct poll_source;
> +
> +struct poll_source_ops {
> +	void (*start)(struct poll_source *src);
> +	void (*stop)(struct poll_source *src);
> +	void (*poll)(struct poll_source *src);
> +};
> +
> +struct poll_source {
> +	const struct poll_source_ops *ops;
> +	struct list_head node;
> +	int cpu;
> +};
> +
> +/**
> + * poll_source_register - Add a poll_source for a CPU
> + */
> +#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_ARCH_HAS_CPU_RELAX)
> +int poll_source_register(struct poll_source *src);
> +#else
> +static inline int poll_source_register(struct poll_source *src)
> +{
> +	return 0;
> +}
> +#endif
> +
> +/**
> + * poll_source_unregister - Remove a previously registered poll_source
> + */
> +#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_ARCH_HAS_CPU_RELAX)
> +int poll_source_unregister(struct poll_source *src);
> +#else
> +static inline int poll_source_unregister(struct poll_source *src)
> +{
> +	return 0;
> +}
> +#endif
> +
> +/* Used by the cpuidle driver */
> +void poll_source_start(void);
> +void poll_source_run_once(void);
> +void poll_source_stop(void);
> +
> +#endif /* __LINUX_POLLSOURCE_H__ */
> diff --git a/drivers/cpuidle/poll_source.c b/drivers/cpuidle/poll_source.c
> new file mode 100644
> index 000000000000..46100e5a71e4
> --- /dev/null
> +++ b/drivers/cpuidle/poll_source.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * poll_source.c - cpuidle busy waiting API
> + */
> +
> +#include <linux/lockdep.h>
> +#include <linux/percpu.h>
> +#include <linux/poll_source.h>
> +
> +/* The per-cpu list of registered poll sources */
> +DEFINE_PER_CPU(struct list_head, poll_source_list);
> +
> +/* Called from idle task with TIF_POLLING_NRFLAG set and irqs enabled */
> +void poll_source_start(void)
> +{
> +	struct poll_source *src;
> +
> +	list_for_each_entry(src, this_cpu_ptr(&poll_source_list), node)
> +		src->ops->start(src);
> +}
> +
> +/* Called from idle task with TIF_POLLING_NRFLAG set and irqs enabled */
> +void poll_source_run_once(void)
> +{
> +	struct poll_source *src;
> +
> +	list_for_each_entry(src, this_cpu_ptr(&poll_source_list), node)
> +		src->ops->poll(src);
> +}
> +
> +/* Called from idle task with TIF_POLLING_NRFLAG set and irqs enabled */
> +void poll_source_stop(void)
> +{
> +	struct poll_source *src;
> +
> +	list_for_each_entry(src, this_cpu_ptr(&poll_source_list), node)
> +		src->ops->stop(src);
> +}
> +
> +static void poll_source_register_this_cpu(void *opaque)
> +{
> +	struct poll_source *src = opaque;
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	list_add_tail(&src->node, this_cpu_ptr(&poll_source_list));
> +}
> +
> +int poll_source_register(struct poll_source *src)
> +{
> +	if (!list_empty(&src->node))
> +		return -EBUSY;
> +
> +	/*
> +	 * There is no race with src->cpu iterating over poll_source_list
> +	 * because smp_call_function_single() just sets TIF_NEED_RESCHED

Hum... what about 

CPU-0				CPU-1

poll_source_start		poll_source_register IPI'ing CPU-0

Perhaps a llist can be used?

>               while (!need_resched()) {
> +                     poll_source_run_once();

Probably want to use static_key's for ->start, ->stop and ->poll?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
