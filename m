Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B817E9
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEHRFr0L"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12170821D0
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 01:59:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12170821D0
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XEHRFr0L
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kUbL6Juabgju
	for <virtualization@lists.linux-foundation.org>;
	Sat, 30 Dec 2023 01:59:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3103A8218F
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 01:59:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3103A8218F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703901586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JcU3tb+go9bUv8N4pKXNlLKJPWBlko6I3J75l+sdqHY=;
	b=XEHRFr0LT8KcWfv4YDJ7P9Cgs+rlpXkts34OjZHpchb+AstYmf19cgyUDwPK/WphJUkKnm
	9S9rze2XYTgGgV+8vU4wa7ZqT10AE+a2Yz+k2v/unKnRpYDWnlLbIG9zrKLJtL233xqS36
	m//EIfCsEVG0tF2puTyRcdNO9gJCsuw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-DTuw2t2cMLie1xpKfxUkvg-1; Fri,
 29 Dec 2023 20:59:39 -0500
X-MC-Unique: DTuw2t2cMLie1xpKfxUkvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AF211C05192;
	Sat, 30 Dec 2023 01:59:38 +0000 (UTC)
Received: from [10.22.16.36] (unknown [10.22.16.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7C596C15968;
	Sat, 30 Dec 2023 01:59:37 +0000 (UTC)
Message-ID: <65559290-be3c-4a23-bb57-e6c29c53d6cf@redhat.com>
Date: Fri, 29 Dec 2023 20:59:36 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 1/5] locking/osq_lock: Move the definition of
 optimistic_spin_node into osf_lock.c
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
 <6eb23a47953b445281e04f5573aead65@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <6eb23a47953b445281e04f5573aead65@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 12/29/23 15:53, David Laight wrote:
> struct optimistic_spin_node is private to the implementation.
> Move it into the C file to ensure nothing is accessing it.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>   include/linux/osq_lock.h  | 5 -----
>   kernel/locking/osq_lock.c | 7 +++++++
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
> index 5581dbd3bd34..ea8fb31379e3 100644
> --- a/include/linux/osq_lock.h
> +++ b/include/linux/osq_lock.h
> @@ -6,11 +6,6 @@
>    * An MCS like lock especially tailored for optimistic spinning for sleeping
>    * lock implementations (mutex, rwsem, etc).
>    */
> -struct optimistic_spin_node {
> -	struct optimistic_spin_node *next, *prev;
> -	int locked; /* 1 if lock acquired */
> -	int cpu; /* encoded CPU # + 1 value */
> -};
>   
>   struct optimistic_spin_queue {
>   	/*
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index d5610ad52b92..d414eef4bec6 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -11,6 +11,13 @@
>    * called from interrupt context and we have preemption disabled while
>    * spinning.
>    */
> +
> +struct optimistic_spin_node {
> +	struct optimistic_spin_node *next, *prev;
> +	int locked; /* 1 if lock acquired */
> +	int cpu; /* encoded CPU # + 1 value */
> +};
> +
>   static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
>   
>   /*

Please correct the patch title "osf_lock.c" => "osq_lock.c".

After the fix, you can add

Acked-by: Waiman Long <longman@redhat.com>

