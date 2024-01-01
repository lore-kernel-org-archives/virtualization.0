Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1DCBA3C
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jan 2024 04:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RttJh0jO"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A77B40597
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jan 2024 04:14:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A77B40597
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RttJh0jO
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K5SRfgxj1IaO
	for <virtualization@lists.linux-foundation.org>;
	Mon,  1 Jan 2024 04:14:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2BEEF40567
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jan 2024 04:14:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BEEF40567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704082466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEdS1eHaVY6r/b15xQ4zdIoWPj6zWAjgnls/AyKtrcE=;
	b=RttJh0jOXp0HcHy7SkSbvzoecNYyIu4qa+bw/akemevbhG8fD7xhCCZLmfNC6c+nklpP+S
	tqT9vGmgNOdp7W/skHJB/yTV6iTdpivUN4dAiDiFHSiQCsiMrfZRHiNPIRO/L5mU3eVEzb
	c+VA0vuybiReO5FzYUgPEfjMvtkpEz0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-6i4dgRHTM0C_hCeO5EzIog-1; Sun, 31 Dec 2023 23:14:22 -0500
X-MC-Unique: 6i4dgRHTM0C_hCeO5EzIog-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12B3B83DDE0;
	Mon,  1 Jan 2024 04:14:22 +0000 (UTC)
Received: from [10.22.16.25] (unknown [10.22.16.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B0942166B31;
	Mon,  1 Jan 2024 04:14:21 +0000 (UTC)
Message-ID: <9d4024ba-6422-4775-b934-bfa80a72a858@redhat.com>
Date: Sun, 31 Dec 2023 23:14:21 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
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
 <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


On 12/31/23 16:55, David Laight wrote:
> per_cpu_ptr() indexes __per_cpu_offset[] with the cpu number.
> This requires the cpu number be 64bit.
> However the value is osq_lock() comes from a 32bit xchg() and there
> isn't a way of telling gcc the high bits are zero (they are) so
> there will always be an instruction to clear the high bits.
>
> The cpu number is also offset by one (to make the initialiser 0)
> It seems to be impossible to get gcc to convert __per_cpu_offset[cpu_p1 - 1]
> into (__per_cpu_offset - 1)[cpu_p1] (transferring the offset to the address).
>
> Converting the cpu number to 32bit unsigned prior to the decrement means
> that gcc knows the decrement has set the high bits to zero and doesn't
> add a register-register move (or cltq) to zero/sign extend the value.
>
> Not massive but saves two instructions.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>   kernel/locking/osq_lock.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 35bb99e96697..37a4fa872989 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -29,11 +29,9 @@ static inline int encode_cpu(int cpu_nr)
>   	return cpu_nr + 1;
>   }
>   
> -static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
> +static inline struct optimistic_spin_node *decode_cpu(unsigned int encoded_cpu_val)
>   {
> -	int cpu_nr = encoded_cpu_val - 1;
> -
> -	return per_cpu_ptr(&osq_node, cpu_nr);
> +	return per_cpu_ptr(&osq_node, encoded_cpu_val - 1);
>   }
>   
>   /*

You really like micro-optimization.

Anyway,

Reviewed-by: Waiman Long <longman@redhat.com>

