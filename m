Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2623AE
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcRLGt/E"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 916A741703
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 03:13:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 916A741703
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TcRLGt/E
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7HUXjsJ_9S6L
	for <virtualization@lists.linux-foundation.org>;
	Sat, 30 Dec 2023 03:13:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BAA3E416FD
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 03:13:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAA3E416FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703906028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpeDQlYrs9xI9CR1L4ThLCdAkxla8O4tTg7H/CNq1DY=;
	b=TcRLGt/EUFo8se55ZPc4CWYVPFJuhVIS/TVPq9mxgWHQdAuW+uR9Kx/KHTKdKHEah6KEnc
	sdND1bCgg4qkzbPTCVQjiizSkyYh05GO5CK0wk0N6ZqnKhUe0C0uA3CqpOOM9lbwH8ufQy
	+DYzBuUTAS+A8EAhC5PktXMcE5uPSyI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-BQL9WZbaMuG0E7XX7J2y9A-1; Fri,
 29 Dec 2023 22:13:45 -0500
X-MC-Unique: BQL9WZbaMuG0E7XX7J2y9A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60A831C25A6A;
	Sat, 30 Dec 2023 03:13:44 +0000 (UTC)
Received: from [10.22.16.36] (unknown [10.22.16.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CEA56492BC6;
	Sat, 30 Dec 2023 03:13:43 +0000 (UTC)
Message-ID: <e7cf4154-294e-40bd-a485-0b23220d4b7a@redhat.com>
Date: Fri, 29 Dec 2023 22:13:43 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 5/5] locking/osq_lock: Optimise vcpu_is_preempted()
 check.
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'peterz@infradead.org'" <peterz@infradead.org>
Cc: "'mingo@redhat.com'" <mingo@redhat.com>,
 "'will@kernel.org'" <will@kernel.org>,
 "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 "'xinhui.pan@linux.vnet.ibm.com'" <xinhui.pan@linux.vnet.ibm.com>,
 "'virtualization@lists.linux-foundation.org'"
 <virtualization@lists.linux-foundation.org>,
 'Zeng Heng' <zengheng4@huawei.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <23cef5ac49494b9087953f529ae5df16@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <23cef5ac49494b9087953f529ae5df16@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


On 12/29/23 15:58, David Laight wrote:
> The vcpu_is_preempted() test stops osq_lock() spinning if a virtual
>    cpu is no longer running.
> Although patched out for bare-metal the code still needs the cpu number.
> Reading this from 'prev->cpu' is a pretty much guaranteed have a cache miss
> when osq_unlock() is waking up the next cpu.
>
> Instead save 'prev->cpu' in 'node->prev_cpu' and use that value instead.
> Update in the osq_lock() 'unqueue' path when 'node->prev' is changed.
>
> This is simpler than checking for 'node->prev' changing and caching
> 'prev->cpu'.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>   kernel/locking/osq_lock.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index b60b0add0161..89be63627434 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -14,8 +14,9 @@
>   
>   struct optimistic_spin_node {
>   	struct optimistic_spin_node *self, *next, *prev;
> -	int locked; /* 1 if lock acquired */
> -	int cpu; /* encoded CPU # + 1 value */
> +	int locked;    /* 1 if lock acquired */
> +	int cpu;       /* encoded CPU # + 1 value */
> +	int prev_cpu;  /* actual CPU # for vpcu_is_preempted() */
>   };
>   
>   static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
> @@ -29,11 +30,6 @@ static inline int encode_cpu(int cpu_nr)
>   	return cpu_nr + 1;
>   }
>   
> -static inline int node_cpu(struct optimistic_spin_node *node)
> -{
> -	return node->cpu - 1;
> -}
> -
>   static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
>   {
>   	int cpu_nr = encoded_cpu_val - 1;
> @@ -114,6 +110,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	if (old == OSQ_UNLOCKED_VAL)
>   		return true;
>   
> +	node->prev_cpu = old - 1;
>   	prev = decode_cpu(old);
>   	node->prev = prev;
>   	node->locked = 0;
> @@ -148,7 +145,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	 * polling, be careful.
>   	 */
>   	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
> -				  vcpu_is_preempted(node_cpu(node->prev))))
> +				  vcpu_is_preempted(node->prev_cpu)))
>   		return true;
>   
>   	/* unqueue */
> @@ -205,6 +202,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	 * it will wait in Step-A.
>   	 */
>   
> +	WRITE_ONCE(next->prev_cpu, prev->cpu - 1);
>   	WRITE_ONCE(next->prev, prev);
>   	WRITE_ONCE(prev->next, next);
Reviewed-by: Waiman Long <longman@redhat.com>

>   

