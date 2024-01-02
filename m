Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D96CA6F
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jan 2024 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMTOD3LW"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 52262404B2
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jan 2024 09:54:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 52262404B2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WMTOD3LW
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.5
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GRACWHQPGVOD
	for <virtualization@lists.linux-foundation.org>;
	Tue,  2 Jan 2024 09:54:31 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B44C4020B
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jan 2024 09:54:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B44C4020B
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-33694bf8835so7751170f8f.3
        for <virtualization@lists.linux-foundation.org>; Tue, 02 Jan 2024 01:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704189269; x=1704794069; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5fH/2DQvO/Vknv81zYHwP4l6yn/7Tm5ckvZigBomFQ=;
        b=WMTOD3LWCht8pR8gGKOu0fDK6ZObLefLXfkeOgmHRjjqLp1U+1TwZrTCoLMU9/jku5
         9JiZH4lyBQKR3NsLhbPAodWJAPNVKrYBe26Gb7fGICwTlA33pU6w09cOJmUJg4NcoD8K
         PM37FMcHhIigUyaZmYLUsb5rBnaoJKDxCEYdGMvOXynx77y9bBZtXQzukNYvBaYqrdDm
         z1OLih+mYEUtQufcOO8eNMCJ04Zis/vFcCxa1B9FpWTdrMCgauk1FOzQJrkEpnfzt/rA
         6iSifowZ0jp6kd1o43YcfgTMDhMYs2ibmFyiwwA7hpejL127qn9EPl0GzGE8v+D5rfGM
         RaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704189269; x=1704794069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5fH/2DQvO/Vknv81zYHwP4l6yn/7Tm5ckvZigBomFQ=;
        b=v+zPGylRCHWAuhgaOpfIevsOEHTYBQGV3sUnV4GMD4X+Pv1duYq1kflb0FvVsfCAC1
         cs7bL2psbSZx51ZEhBRHXQ90VJ7x0xPOnWNQSwYqa5PBKhor3nB82y4yGAhNxExi7X4J
         /p01LHmWehoWKbCO/c2TfJrq3EXlbsBvr/1ijC8FKmz/bGPOkhBwCRGVHzkaTmDrUplw
         hPzD6rWnms0JW+qXHJ+OqKb30+/fD7M9tOYKG8Gat7jSH5e/c2DXrlaDx06x7SlG2J4S
         nkxB3ogJtj+rHpQeG0x1usCu5pIxlM3ql8QwaV86EwVXQPnI+w5DJW6rCkQCki0A0SF+
         Cq7Q==
X-Gm-Message-State: AOJu0Yyx+lzYNkqbfVSrGpQNpIdVAlbUOCnhDWrB/QjNzVHVMYEii3li
	5Qu9wBXm+Tin6Y1GzIMvie8=
X-Google-Smtp-Source: AGHT+IHy31iwxEy43w6fN/vNlkM0ir2q4MluKLushJVZYOoHKf25TxnAm+J0tCxuYFjtncIAyV3jxA==
X-Received: by 2002:a05:600c:4f91:b0:40d:5d89:7c37 with SMTP id n17-20020a05600c4f9100b0040d5d897c37mr5072603wmq.142.1704189269120;
        Tue, 02 Jan 2024 01:54:29 -0800 (PST)
Received: from gmail.com (195-38-113-95.pool.digikabel.hu. [195.38.113.95])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b0040d4e1393dcsm36397862wmo.20.2024.01.02.01.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 01:54:28 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 2 Jan 2024 10:54:26 +0100
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
Subject: Re: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Message-ID: <ZZPdUv6uRvqXlyYo@gmail.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>


* David Laight <David.Laight@ACULAB.COM> wrote:

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
>  kernel/locking/osq_lock.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 35bb99e96697..37a4fa872989 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -29,11 +29,9 @@ static inline int encode_cpu(int cpu_nr)
>  	return cpu_nr + 1;
>  }
>  
> -static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
> +static inline struct optimistic_spin_node *decode_cpu(unsigned int encoded_cpu_val)
>  {
> -	int cpu_nr = encoded_cpu_val - 1;
> -
> -	return per_cpu_ptr(&osq_node, cpu_nr);
> +	return per_cpu_ptr(&osq_node, encoded_cpu_val - 1);

So why do we 'encode' the CPU number to begin with?

Why not use -1 as the special value? Checks for negative values 
generates similarly fast machine code compared to checking for 0, if 
the value is also used (which it is in most cases here). What am I 
missing? We seem to be going through a lot of unnecessary hoops, and 
some of that is in the runtime path.

Thanks,

	Ingo
