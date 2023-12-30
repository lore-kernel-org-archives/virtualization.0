Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB233F6
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZHd77wS"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B17C060BA4
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 02:54:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B17C060BA4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eZHd77wS
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M5WEFQBZo9dS
	for <virtualization@lists.linux-foundation.org>;
	Sat, 30 Dec 2023 02:54:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 29B8860B9E
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 02:54:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29B8860B9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703904892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxnW03wmmSgu3Wsd0E5JoInO4BxSGZQ3EkhRS+WLmuE=;
	b=eZHd77wSk0M7sDcXUezi+gaGvS8biN7ZuQMojEjbBz8zpzbraqAFr1Eo79QAjydct0c+BB
	NxBrK+lUSg9mkf3lQ9ZWceAHzeI34M/1uD14THhXB8+YwA99+9QeRtzGwBMC2tJXuloVWr
	wH5qZaT8lD0i1cdqyKR4yeeP1Dvjurc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-yLI7PEG7PJSGaOHEB6Mysw-1; Fri, 29 Dec 2023 21:54:49 -0500
X-MC-Unique: yLI7PEG7PJSGaOHEB6Mysw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D63380B62C;
	Sat, 30 Dec 2023 02:54:49 +0000 (UTC)
Received: from [10.22.16.36] (unknown [10.22.16.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 89E5A492BC6;
	Sat, 30 Dec 2023 02:54:48 +0000 (UTC)
Message-ID: <2899b471-b009-4bb5-bc81-19a8b8c9c955@redhat.com>
Date: Fri, 29 Dec 2023 21:54:48 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 3/5] locking/osq_lock: Clarify osq_wait_next()
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
 <7c8828aec72e42eeb841ca0ee3397e9a@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <7c8828aec72e42eeb841ca0ee3397e9a@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


On 12/29/23 15:56, David Laight wrote:
> osq_wait_next() is passed 'prev' from osq_lock() and NULL from osq_unlock()
> but only needs the 'cpu' value to write to lock->tail.
> Just pass prev->cpu or OSQ_UNLOCKED_VAL instead.
>
> Also directly return NULL or 'next' instead of breaking the loop.
>
> Should have no effect on the generated code since gcc manages to
> assume that 'prev != NULL' due to an earlier dereference.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>   kernel/locking/osq_lock.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 55f5db896c02..9bb3a077ba92 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -48,18 +48,17 @@ static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
>   static inline struct optimistic_spin_node *
>   osq_wait_next(struct optimistic_spin_queue *lock,
>   	      struct optimistic_spin_node *node,
> -	      struct optimistic_spin_node *prev)
> +	      int old)

Make the last argument name more descriptive, like "old_cpu" as the 
"int" type does not provide enough context to allow people to guess what 
"old" may be.

Cheers,
Longman


