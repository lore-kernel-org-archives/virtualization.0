Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E63748A
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jan 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA7nn/go"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2045280FAF
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jan 2024 09:47:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2045280FAF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nA7nn/go
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.5
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8TZl-XllybHu
	for <virtualization@lists.linux-foundation.org>;
	Tue,  2 Jan 2024 09:47:21 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5305080F92
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jan 2024 09:47:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5305080F92
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40d3ae326f6so100403085e9.3
        for <virtualization@lists.linux-foundation.org>; Tue, 02 Jan 2024 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704188839; x=1704793639; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7ojcp2dbDyRW3OreP4mBJTzhyFdUANE5vMCwyKkm88=;
        b=nA7nn/goEGmtJEl8vI9mInvYy/JLZBep6N7yN/h56QGPJkIdy/qciZmM1S77shR9+L
         RrvDHdm0MsAofA3vJIfS9bUX1saFgkttE2AkwxW30BSiKO9RXU6kiyrAXwT7eoxHdJll
         Ss7OPrENgIg2jnPo0Er37Bzon67kD1YbkyzAiJVTJRYvYKJUDDKSpy+MPgK8QloM878Q
         71iU4I3VjZGPuyEXGfp2O4s1QDq+sobjt9MdXYyFLmBVDZUg3fYOJkqnuMaBE6PSym2k
         U0m8lI13nNBhH/RsyXhyw0I+hKgHri/10FLn3x1MqRjA1JahbgfMHHE6HWj+dScPm8xf
         2qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704188839; x=1704793639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7ojcp2dbDyRW3OreP4mBJTzhyFdUANE5vMCwyKkm88=;
        b=mDYLgjOHmNuw9Yju+sgdSVXb7JT6EIrRYj0s9+eRrwd+JlbpatuoSXYeIBnQqznzt7
         I4Dd2KE/U0hItsOpef9dlQPpjCv+uO2nEGsq+TJETgO/1daEz2pOUbczNbyLlMNqlgA1
         FvWszjwrlZ1GuY3+MGR063hbpFVtLmd49452ii/EuWahYUmXzn8flvQinXVc1sRbIXG8
         PrXPRcnhlmV/k1MTy1JCcTvfKdH6t0I/mCJkH8ZjHx25LMdpxIi1e0VPR5itjrbfBz6M
         NESHmRJCIspXeIDfg/BGLen+X+niTfqu1Q/EfFVJmEgGE5mKNkd1X/XwC7Z3mdxBq1Bd
         DfQA==
X-Gm-Message-State: AOJu0Yz8PVDBm8V726xES0m7uwUAYbIzMDiIETOFCIrW30RCpGeHb16E
	By42VPJ/qGJlPyQaSE9865M=
X-Google-Smtp-Source: AGHT+IFWJ+IvDpEcqEsJAyOvMYPgoON85E2aD+ewCnnsASGnoIXua1Y29Ox7PjM5n0vY6mgrIktyKQ==
X-Received: by 2002:a05:600c:35c7:b0:40d:87cc:4acd with SMTP id r7-20020a05600c35c700b0040d87cc4acdmr1390780wmq.148.1704188839104;
        Tue, 02 Jan 2024 01:47:19 -0800 (PST)
Received: from gmail.com (195-38-113-95.pool.digikabel.hu. [195.38.113.95])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b0040d6b91efd9sm18522525wmb.44.2024.01.02.01.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 01:47:18 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 2 Jan 2024 10:47:16 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>,
	"'longman@redhat.com'" <longman@redhat.com>,
	"'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>,
	"'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
	'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'" <virtualization@lists.linux-foundation.org>,
	'Zeng Heng' <zengheng4@huawei.com>
Subject: Re: [PATCH next v2 4/5] locking/osq_lock: Avoid writing to
 node->next in the osq_lock() fast path.
Message-ID: <ZZPbpPaxi0zy8UyF@gmail.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <06a11b2c7d784f2d80dc8e81c7175c57@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a11b2c7d784f2d80dc8e81c7175c57@AcuMS.aculab.com>


* David Laight <David.Laight@ACULAB.COM> wrote:

> When osq_lock() returns false or osq_unlock() returns static
> analysis shows that node->next should always be NULL.
> This means that it isn't necessary to explicitly set it to NULL
> prior to atomic_xchg(&lock->tail, curr) on extry to osq_lock().
> 
> Just in case there a non-obvious race condition that can leave it
> non-NULL check with WARN_ON_ONCE() and NULL if set.
> Note that without this check the fast path (adding at the list head)
> doesn't need to to access the per-cpu osq_node at all.
> 
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>  kernel/locking/osq_lock.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 27324b509f68..35bb99e96697 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -87,12 +87,17 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>  
>  bool osq_lock(struct optimistic_spin_queue *lock)
>  {
> -	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> -	struct optimistic_spin_node *prev, *next;
> +	struct optimistic_spin_node *node, *prev, *next;
>  	int curr = encode_cpu(smp_processor_id());
>  	int prev_cpu;
>  
> -	node->next = NULL;
> +	/*
> +	 * node->next should be NULL on entry.
> +	 * Check just in case there is a race somewhere.
> +	 * Note that this is probably an unnecessary cache miss in the fast path.
> +	 */
> +	if (WARN_ON_ONCE(raw_cpu_read(osq_node.next) != NULL))
> +		raw_cpu_write(osq_node.next, NULL);

The fix-uppery and explanation about something that shouldn't happen is 
excessive: please just put a plain WARN_ON_ONCE() here - which we can 
remove in a release or so.

Thanks,

	Ingo
