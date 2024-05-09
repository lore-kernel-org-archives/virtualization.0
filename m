Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6318B3D3AC
	for <virtualization@lists.linux.dev>; Thu,  9 May 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280160; cv=none; b=kS4tZT1stRYw7wLdtPw6i6s9clrrPtuMUacy721mLMqPBgUpqLbxck4ff6ghZBenDMI8/OJEn9SnhSkHTZXEQ9S/uLWc8h6sN0whU5Cq907ZaMxaOpKlbvFyrtNfR95sC40pBrUVuy6HNc0HO8GT9U1KvqsSa96Ahqwooo34ItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280160; c=relaxed/simple;
	bh=3ndaJASgzHn4G3ckMjyOhyQuArGaXPwtj0dYJYISKb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVKDGn6faj1LvIqvtzCCc1/1uNG2VdMkA7A7Z/dldv9LZk1f3n7jR6FlqwE5RaP2ZqVzr2LanOYw4rZEjIvsMToc+FpoMbGqMCSxrFruhc1yfMHUtvVWzboyQB1vo3BgCQbGMrXKsO/YSRG7JF6muGg43WCqc9CAYOXe7nqWtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uh6U+Guu; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uh6U+Guu"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7da55194b31so9441539f.3
        for <virtualization@lists.linux.dev>; Thu, 09 May 2024 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715280157; x=1715884957; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb/hMrXR7iTuHRfsjZ3bhhr22tRj7HOFnte2NJWfYLc=;
        b=uh6U+Guubju026IiAWiYs2V4QdDxfL4KybN1k2HeB2OLAK1HGqjhBK9d81Tr6l92HX
         l4M3C58MS6Hs6OZswRB4zjI1QeRDsImY2b/MDIsB7l2frCh4R1NnbzWw0SII3MF+AVmu
         PPvuLg8Chi6/kd35aE8QFoI4nuoXEuzC6oCbBkAhNcHbW18EznTvuLsDGYqFTC2t/uCQ
         JMLCDHRtyCWHTLMgct1UDqVpQmxlZYGxT8q76c36wPwQGvq0JmIDdzG4Gy4PmSqPI88Q
         fvlc1nTt8xvs1m1qdCJqzmYpcGUgEB+gJWL9uq3AIY7ABSJxbjw3QgMhImJm9cWQOvWC
         ELhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715280157; x=1715884957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb/hMrXR7iTuHRfsjZ3bhhr22tRj7HOFnte2NJWfYLc=;
        b=birrw/Dpz5+20Jc9EfP8YaAawagXb1y3rB7RQ5bs/7JggbQYxTv97J5R7VscaXhpD3
         RWwAAvPy9KZXFtAzL7n6QAbdEPK5O7FMJF2WtZqzQwZuH01n1NPMXVvPf5QxDv89o3BY
         6BauYNIy8ECqplnT+3tMZTk/Kz3wk/HLdMHmHqg46n0TulYURQPC+V6QiMmyDJFdJ+Qb
         Taql+JDzrkoW8xlZRewm8Sr1oCdGg5q11Zj1AYqckmNrphimeD1oDDLC3AuYweex4Bar
         +6qjEKUO6Jqq0sR8HJmv6Vc5e+ctvqhholju2KclxnHDvdKUQtsdqTxFqe421vrl+HJq
         zkPg==
X-Forwarded-Encrypted: i=1; AJvYcCXLpD+t49lnyhOUsRydo1V2lQVEGWDqJNzHAH06/tImY2csaw1cFh/RokTHylHJ0lP8ZhHTwX7JhxdnvLf8FolUMdxs5TgmecF55JIcG2A=
X-Gm-Message-State: AOJu0YyVeafY1Bp+dYFLzg/MsUYYfsK9OWpNuF9MHTFqYrTK93gWiVv/
	ZbTSCOfBnHSLhePCIBjWDLWATalky7qPuagWArED0R7AxePP2Pu64erY40BjyuQ=
X-Google-Smtp-Source: AGHT+IHV1XMYkIb7S1TRyZqI608+jxhYsfIgUvPyWV4bIxpRx0wtJEwv4Lfl0RUasfhcfdAlKxNOYw==
X-Received: by 2002:a6b:d101:0:b0:7e1:86e1:cd46 with SMTP id ca18e2360f4ac-7e1b520b2f8mr64956039f.2.1715280157494;
        Thu, 09 May 2024 11:42:37 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489375c1b48sm501321173.110.2024.05.09.11.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:42:37 -0700 (PDT)
Message-ID: <8fea3ee7-345c-4391-b8a9-a68eb90b9a3f@kernel.dk>
Date: Thu, 9 May 2024 12:42:35 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_net: Fix memory leak in virtnet_rx_mod_work
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com
References: <20240509183634.143273-1-danielj@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240509183634.143273-1-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/24 12:36 PM, Daniel Jurgens wrote:
> The pointer delcaration was missing the __free(kfree).

Works for me:

Tested-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


