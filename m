Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF934AB07
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Nov 2025 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831563; cv=none; b=LDjkWiYiFsnqiP2IPioSnUBAwTNVaiF3iwgEw/nt1y+Wv6ZzfVGtTXCnOdCXssLwQfrpcwtY6+mz7n1DgrOvUqcZGM/9pg66BNfBPzdr7BSafmv7+yTskFQ3wVzo9MgZR5Kex4J5nUr/KeHgJ/yWfPlmnyQVWuzSDGPbhgkkX/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831563; c=relaxed/simple;
	bh=OagPxu3BDFrMdi8d9a7SIWrmYUKVURgm7s+OlqgLC0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYxZf+brzM2yPumwLnKR66t9G/dNliZEneRj1vS2Xf3nJCw+k34icZjzM6UxLb18WvKmxSSo7mgvjMTfe0mcrAa+Z/0JxdOPGRpCpIFP6FCrKixdahygqr3e2yLTPLi0xlV957k/EdR50/So1UKXa43fsevqdSYORG6u3T9A9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMqwjmgz; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMqwjmgz"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6E6C80F31
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Nov 2025 03:26:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YVxeo6AYhV5t for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Nov 2025 03:26:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=ming.lei@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A30D380EEF
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A30D380EEF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IMqwjmgz
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A30D380EEF
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Nov 2025 03:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762831558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO5w3yJkudGRFXI8OauYWxvQ3+YR+NH5t9Z29OeLOJo=;
	b=IMqwjmgzH7liVmaXsgmsBpwxE3bNcRRe8JdqoplixHy3362T2DjquIA5YaXDtSUTiZoTuV
	C+Ajf52hKqwJBbhfi1IaK3xRrIutBWT9yATby7HAPyqejPbHkfiikkoHibZRqNtkO7Kd+i
	In0m+A5BElNSpAMsCrHjn/oCwCrL8k4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-gGQa16xoORyOd_8dTj8QQg-1; Mon,
 10 Nov 2025 22:25:55 -0500
X-MC-Unique: gGQa16xoORyOd_8dTj8QQg-1
X-Mimecast-MFC-AGG-ID: gGQa16xoORyOd_8dTj8QQg_1762831553
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51BB1180048E;
	Tue, 11 Nov 2025 03:25:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.124])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 461EC30044E0;
	Tue, 11 Nov 2025 03:25:42 +0000 (UTC)
Date: Tue, 11 Nov 2025 11:25:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Wangyang Guo <wangyang.guo@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Dan Liang <dan.liang@intel.com>
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
Message-ID: <aRKssW96lHFrT2ZN@fedora>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251111020608.1501543-1-wangyang.guo@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
> As CPU core counts increase, the number of NVMe IRQs may be smaller than
> the total number of CPUs. This forces multiple CPUs to share the same
> IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
> performance penalty can be observed on some platforms.

Can you add details why/how CPU cluster isn't aligned with IRQ
affinity? And how performance penalty is caused?

Is it caused by remote IO completion in blk_mq_complete_need_ipi()?

	/* same CPU or cache domain and capacity?  Complete locally */
	if (cpu == rq->mq_ctx->cpu ||
	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
	     cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
	        return false;

If yes, which case you are addressing to? cache domain or capccity?

AMD's CCX shares L3 cache inside NUMA node, which has similar issue,
I guess this patchset may cover it?

> This patch improves IRQ affinity by grouping CPUs by cluster within each
> NUMA domain, ensuring better locality between CPUs and their assigned
> NVMe IRQs.

Will look into this patch, but I feel one easier way is to build
sub-node(cluster) cpumask array, and just spread over the sub-node(cluster). 


Thanks, 
Ming

