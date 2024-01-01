Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183C1FB0
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jan 2024 04:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcVzdfB1"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6476812E5
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jan 2024 04:09:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6476812E5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AcVzdfB1
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q34IGEB_3h1Q
	for <virtualization@lists.linux-foundation.org>;
	Mon,  1 Jan 2024 04:09:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA5FE812D2
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jan 2024 04:09:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA5FE812D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704082174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXBAlgGK7S8pQB0FG4Kct0qp1YZSDI7A8y3x9iGBDgc=;
	b=AcVzdfB1NfwNRAlQRnZDGRWwNGcCVljFL6Dj8Abw2cWDWj2/Tnu69leRwm0zei4ZbeXcYd
	YPGTv+HCXqI8KxXcUVDDR99u3AUHKoStFPeEfd+in+4twZGb90AfHxNyv7g+X5t1L+SXYp
	v5AEyi0fUyWvUiOqcP+Mzuxb1QZ8Dy4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-YiIT4ADlM7Siv7xUTevm2w-1; Sun, 31 Dec 2023 23:09:31 -0500
X-MC-Unique: YiIT4ADlM7Siv7xUTevm2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97B4785A589;
	Mon,  1 Jan 2024 04:09:30 +0000 (UTC)
Received: from [10.22.16.25] (unknown [10.22.16.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2DA5A51D5;
	Mon,  1 Jan 2024 04:09:30 +0000 (UTC)
Message-ID: <82b6320e-cd5a-43a4-8a12-4d6d5484fc34@redhat.com>
Date: Sun, 31 Dec 2023 23:09:30 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 3/5] locking/osq_lock: Use node->prev_cpu instead
 of saving node->prev.
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'peterz@infradead.org'" <peterz@infradead.org>
Cc: "'mingo@redhat.com'" <mingo@redhat.com>,
 "'will@kernel.org'" <will@kernel.org>,
 "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 "'virtualization@lists.linux-foundation.org'"
 <virtualization@lists.linux-foundation.org>,
 'Zeng Heng' <zengheng4@huawei.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <7906aaa73f93493c873e6286c1f96645@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <7906aaa73f93493c873e6286c1f96645@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 12/31/23 16:54, David Laight wrote:
> node->prev is only used to update 'prev' in the unlikely case
> of concurrent unqueues.
> This can be replaced by a check for node->prev_cpu changing
> and then calling decode_cpu() to get the changed 'prev' pointer.
>
> node->cpu (or more particularly) prev->cpu is only used for the
> osq_wait_next() call in the unqueue path.
> Normally this is exactly the value that the initial xchg() read
> from lock->tail (used to obtain 'prev'), but can get updated
> by concurrent unqueues.
>
> Both the 'prev' and 'cpu' members of optimistic_spin_node are
> now unused and can be deleted.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>   kernel/locking/osq_lock.c | 31 +++++++++++++++++--------------
>   1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index eb8a6dfdb79d..27324b509f68 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -13,9 +13,8 @@
>    */
>   
>   struct optimistic_spin_node {
> -	struct optimistic_spin_node *next, *prev;
> +	struct optimistic_spin_node *next;
>   	int locked;    /* 1 if lock acquired */
> -	int cpu;       /* encoded CPU # + 1 value */
>   	int prev_cpu;  /* encoded CPU # + 1 value */
>   };
>   
> @@ -91,10 +90,9 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
>   	struct optimistic_spin_node *prev, *next;
>   	int curr = encode_cpu(smp_processor_id());
> -	int old;
> +	int prev_cpu;
>   
>   	node->next = NULL;
> -	node->cpu = curr;
>   
>   	/*
>   	 * We need both ACQUIRE (pairs with corresponding RELEASE in
> @@ -102,13 +100,12 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	 * the node fields we just initialised) semantics when updating
>   	 * the lock tail.
>   	 */
> -	old = atomic_xchg(&lock->tail, curr);
> -	if (old == OSQ_UNLOCKED_VAL)
> +	prev_cpu = atomic_xchg(&lock->tail, curr);
> +	if (prev_cpu == OSQ_UNLOCKED_VAL)
>   		return true;
>   
> -	node->prev_cpu = old;
> -	prev = decode_cpu(old);
> -	node->prev = prev;
> +	node->prev_cpu = prev_cpu;
> +	prev = decode_cpu(prev_cpu);
>   	node->locked = 0;
>   
>   	/*
> @@ -174,9 +171,16 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   
>   		/*
>   		 * Or we race against a concurrent unqueue()'s step-B, in which
> -		 * case its step-C will write us a new @node->prev pointer.
> +		 * case its step-C will write us a new @node->prev_cpu value.
>   		 */
> -		prev = READ_ONCE(node->prev);
> +		{
> +			int new_prev_cpu = READ_ONCE(node->prev_cpu);
> +
> +			if (new_prev_cpu == prev_cpu)
> +				continue;
> +			prev_cpu = new_prev_cpu;
> +			prev = decode_cpu(prev_cpu);
> +		}

Just a minor nit. It is not that common in the kernel to add another 
nesting level just to reduce the scope of  new_prev_cpu auto variable.

Anyway,

Reviewed-by: Waiman Long <longman@redhat.com>

