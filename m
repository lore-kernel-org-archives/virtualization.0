Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5F5C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Apr 2022 15:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 834BB40323;
	Thu, 14 Apr 2022 15:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CVFe5EaG5Iri; Thu, 14 Apr 2022 15:23:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1EB69400A8;
	Thu, 14 Apr 2022 15:23:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD28EC002F;
	Thu, 14 Apr 2022 15:23:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62855C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 15:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40ADD40323
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 15:23:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KxKwSE34aTlS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 15:23:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3DD0C400A8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=a7zF3jN+ZuZUeKxEZxyh6BUyYjHKt2ke+Gaa4KDb6Ss=; b=JI7UTDpPYhqXfQKCuMEmYAowpM
 KIhHEIS1dFUdiL/5HF6Ars5OntlUd2gqm+jpr8egpvGlWNYIvboqCNJV5AEHMDPviYf2LtankgtO1
 aN63NIxsiNrqgH/yec/1SBUhuUGXoD2DhaigfktalJ0QviP9lT4XfmUbyBSFrbRBu46E+wkhKg29P
 S5TTuXj3ELigIDn7xfH0U6QP8z8oaktVYWwuKrTIFGTJi0OdSidmRIzUj2ESbknagmLuFJ3Tcl4l5
 JR/BZZsqY69LwJApHxjCus6gVVR/R4DXR1bg70z3O9MRZOrdswtpHtL5/LTTA5zD+Tu82Nrb7YNY7
 +kx8Q6GA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nf1Jd-00FEUn-VO; Thu, 14 Apr 2022 15:23:26 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80B2C3002DE;
 Thu, 14 Apr 2022 17:23:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 434D631B56D1F; Thu, 14 Apr 2022 17:23:25 +0200 (CEST)
Date: Thu, 14 Apr 2022 17:23:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 2/3] nodemask.h: Fix compilation error with GCC12
Message-ID: <Ylg8baQjQTkrnnD9@hirez.programming.kicks-ass.net>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-3-dinechin@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220414150855.2407137-3-dinechin@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, trivial@kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
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

On Thu, Apr 14, 2022 at 05:08:54PM +0200, Christophe de Dinechin wrote:

> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 567c3ddba2c4..c6199dbe2591 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -375,14 +375,13 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
>  }
>  
>  #if MAX_NUMNODES > 1
> -#define for_each_node_mask(node, mask)			\
> -	for ((node) = first_node(mask);			\
> -		(node) < MAX_NUMNODES;			\
> -		(node) = next_node((node), (mask)))
> +#define for_each_node_mask(node, mask)				    \
> +	for ((node) = first_node(mask);				    \
> +	     (node >= 0) && (node) < MAX_NUMNODES;		    \
> +	     (node) = next_node((node), (mask)))
>  #else /* MAX_NUMNODES == 1 */
> -#define for_each_node_mask(node, mask)			\
> -	if (!nodes_empty(mask))				\
> -		for ((node) = 0; (node) < 1; (node)++)
> +#define for_each_node_mask(node, mask)                                  \
> +	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
>  #endif /* MAX_NUMNODES */

Again, less readable code :/ And why?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
