Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377EB1FAF
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zn+PB99O"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B88DB40111
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 03:20:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B88DB40111
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zn+PB99O
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ba7kDfgE1DWg
	for <virtualization@lists.linux-foundation.org>;
	Sat, 30 Dec 2023 03:20:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9171C400BA
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 03:20:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9171C400BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703906430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJA7Dz6XH3eb7dofNJf23l8/rgg/xnXgNticl1fyqpU=;
	b=Zn+PB99O/xagQKtT7SgUAn9gRfV7GdHMfcRy+3k8ZEsNC0eix2/1kytD9xriTditinlsew
	aDunU8Tvp7szsQTsE2EBfPxFJVQggQQ1ssnm3nzIWnPek4EYfHNz/Ng2WdbJPlusxpPXYX
	Z9WOeCha7SLj+gPt51A81Je+iKlCs3g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-jTpncnn7P_m9NnT-cmNEiA-1; Fri, 29 Dec 2023 22:20:26 -0500
X-MC-Unique: jTpncnn7P_m9NnT-cmNEiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FBA485A589;
	Sat, 30 Dec 2023 03:20:26 +0000 (UTC)
Received: from [10.22.16.36] (unknown [10.22.16.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B18F2166B31;
	Sat, 30 Dec 2023 03:20:25 +0000 (UTC)
Message-ID: <835f65d9-a041-4956-b89d-7cd3660c3ab8@redhat.com>
Date: Fri, 29 Dec 2023 22:20:25 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/5] locking/osq_lock: Avoid dirtying the local cpu's
 'node' in the osq_lock() fast path.
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
 <fbb1f9ed42b2460c93eeac43a92157c8@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <fbb1f9ed42b2460c93eeac43a92157c8@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


On 12/29/23 17:11, David Laight wrote:
> osq_lock() starts by setting node->next to NULL and node->locked to 0.
> Careful analysis shows that node->next is always NULL on entry.
>
> node->locked is set non-zero by another cpu to force a wakeup.
> This can only happen after the 'prev->next = node' assignment,
> so locked can be set to zero just before that (along with the assignment
> to node->prev).
>
> Only initialise node->cpu once, after that use its value instead
> of smp_processor_id() - which is probably a real function call.
>
> Should reduce cache-line bouncing a little.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>
> Re-send without the 'RE:' on the subject line.
>   kernel/locking/osq_lock.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index d414eef4bec6..55f5db896c02 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -51,7 +51,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>   	      struct optimistic_spin_node *prev)
>   {
>   	struct optimistic_spin_node *next = NULL;
> -	int curr = encode_cpu(smp_processor_id());
> +	int curr = node->cpu;
>   	int old;
>   
>   	/*
> @@ -98,12 +98,10 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   {
>   	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
>   	struct optimistic_spin_node *prev, *next;
> -	int curr = encode_cpu(smp_processor_id());
>   	int old;
>   
> -	node->locked = 0;
> -	node->next = NULL;

I have some concern about not clearing node->next at the beginning. I 
know that next is supposed to be cleared at the end. I do have some 
worry that there may exist a race condition that leaves next not cleared 
before it is used again. So you either have to prove that such a race 
does not exist, or initializing it to NULL at the beginning like it is 
today.

Cheers,
Longman

> -	node->cpu = curr;
> +	if (unlikely(node->cpu == OSQ_UNLOCKED_VAL))
> +		node->cpu = encode_cpu(smp_processor_id());
>   
>   	/*
>   	 * We need both ACQUIRE (pairs with corresponding RELEASE in
> @@ -111,12 +109,13 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	 * the node fields we just initialised) semantics when updating
>   	 * the lock tail.
>   	 */
> -	old = atomic_xchg(&lock->tail, curr);
> +	old = atomic_xchg(&lock->tail, node->cpu);
>   	if (old == OSQ_UNLOCKED_VAL)
>   		return true;
>   
>   	prev = decode_cpu(old);
>   	node->prev = prev;
> +	node->locked = 0;
>   
>   	/*
>   	 * osq_lock()			unqueue
> @@ -214,7 +213,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   void osq_unlock(struct optimistic_spin_queue *lock)
>   {
>   	struct optimistic_spin_node *node, *next;
> -	int curr = encode_cpu(smp_processor_id());
> +	int curr = raw_cpu_read(osq_node.cpu);
>   
>   	/*
>   	 * Fast path for the uncontended case.

