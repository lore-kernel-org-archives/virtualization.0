Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44341C38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 10:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC04560A6C;
	Tue, 31 Jan 2023 10:03:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC04560A6C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=dO5IsznX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u45p4bdCc4bG; Tue, 31 Jan 2023 10:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9C7BF60750;
	Tue, 31 Jan 2023 10:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C7BF60750
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D11AC0032;
	Tue, 31 Jan 2023 10:02:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A6E8C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 10:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2487C813AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 10:02:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2487C813AF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=dO5IsznX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id opPag-En6j28
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 10:02:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DAC53813AC
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DAC53813AC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 10:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=35NY35ZTQdq0jK+LZ4igcXPsRMRGVAft6MTNkJwdTzM=; b=dO5IsznXm5mFnFeoyNc4/TG0s1
 mpOxkbM+OBJtgsGZLgoSpVZSLQb4T9VkTS2JeBKuFuxshM7ISz0KciiVRowmqcKxrQe8KsIVeSVSE
 xDRWXakwq+rYSNY/nV0p/uIzeJf2Hv/3lrS9BawTvUB7VKD9O2eWaj63J6ocr3VcXqxmONHLqg+QJ
 tg+ItIa96WWwZCejlfiXJoRDhXAAxCu1q7tBVVA9P3O885awA5zbkech37f4qphnvC9g8Dbc9rEhn
 3vlmuZFXbufWoF8t7ub/r+yvvk8g+pPRy/IE1fCdlUNrsbvO81Hvj+8FHHgQzkAwlMVmHLEyqsmCb
 R7z1bMiA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pMnSe-004J72-0s; Tue, 31 Jan 2023 10:01:56 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBE51300673;
 Tue, 31 Jan 2023 11:02:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id AA256240A5DF6; Tue, 31 Jan 2023 11:02:27 +0100 (CET)
Date: Tue, 31 Jan 2023 11:02:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 0/2] vhost: improve livepatch switching for heavily
 loaded vhost worker kthreads
Message-ID: <Y9jnM6BW5CcKjXNv@hirez.programming.kicks-ass.net>
References: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
 <Y9KyVKQk3eH+RRse@alley> <Y9LswwnPAf+nOVFG@do-x1extreme>
 <20230127044355.frggdswx424kd5dq@treble>
 <Y9OpTtqWjAkC2pal@hirez.programming.kicks-ass.net>
 <20230127165236.rjcp6jm6csdta6z3@treble>
 <20230127170946.zey6xbr4sm4kvh3x@treble>
 <20230127221131.sdneyrlxxhc4h3fa@treble>
 <Y9e6ssSHUt+MUvum@hirez.programming.kicks-ass.net>
 <20230130195930.s5iu76e56j4q5bra@treble>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230130195930.s5iu76e56j4q5bra@treble>
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "Seth Forshee \(DigitalOcean\)" <sforshee@digitalocean.com>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
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

On Mon, Jan 30, 2023 at 11:59:30AM -0800, Josh Poimboeuf wrote:

> @@ -8662,16 +8665,19 @@ void sched_dynamic_update(int mode)
>  
>  	switch (mode) {
>  	case preempt_dynamic_none:
> -		preempt_dynamic_enable(cond_resched);
> +		if (!klp_override)
> +			preempt_dynamic_enable(cond_resched);
>  		preempt_dynamic_disable(might_resched);
>  		preempt_dynamic_disable(preempt_schedule);
>  		preempt_dynamic_disable(preempt_schedule_notrace);
>  		preempt_dynamic_disable(irqentry_exit_cond_resched);
> +		//FIXME avoid printk for klp restore

		if (mode != preempt_dynamic_mode)

>  		pr_info("Dynamic Preempt: none\n");
>  		break;
>  
>  	case preempt_dynamic_voluntary:
> -		preempt_dynamic_enable(cond_resched);
> +		if (!klp_override)
> +			preempt_dynamic_enable(cond_resched);
>  		preempt_dynamic_enable(might_resched);
>  		preempt_dynamic_disable(preempt_schedule);
>  		preempt_dynamic_disable(preempt_schedule_notrace);


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
