Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716294;
	b=XBNU0XvSF2xtC//h217OTLG/BXkaTic2KlCvLI0bJGsI0tuFk42J69T3JQf3by3gOsTE
	 ozJwaHNpGzt5GZcs1sZc8zq09a8OHmv8vlPx2+COlmgJ4CvKPjPWOtUSmDCWcPUC1dxWs
	 dFDOBB1/iV95kc45JDSCIrL6VgPRQSGDY7kZCYD2J4eRBborXxfd+86KFj/p3bj5YvNOm
	 WjhMttMh2nZn9E0BAGOC2SrIH3VENIuC52MdX9BhRvExjBcXPFoP0lqXmhA5vm4UZNEXn
	 dXkhBGQilbFwAz0d2+eu0UbXUJWXE2VzAuINp+ehEkT88CXG/l+Ilwaq7MOUnufmLZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=wk9IlcGYhsSNWUuj3B81ByEUkAlft9P2T8KxXmSzXGY=;
	b=GSYownmKc0mhHCTwXDN2ct/jQyujFCQvyy/WG22KkIy6cq1w1BDfpBwXKzupefErdY8F
	 gW4Z87QbEHGGiFEZcOixpCKauUtOJYAHd24cemYXROAqTA6QejMtDxLpjIC0oF3sBq3Up
	 oqs3LSNhe7Yk5NXoCjDdN+aJK0Yozcm3aGKBoqfdnh+7nbnK3BXVeXC7GsW/PD+EC7ej0
	 FWPmbC2afYq9NDdhUKTysrQQN4awB0UPTymQUc65yG+nMGxHPKMXOMG3ZBlXO+U2tODq0
	 jJNJU+gMasz2Mvj72B/JUrCvslWGkKZVDQRJoBxOBnXPMYTY3yMztnF7HMZMu7xD0aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RRKhmFHK;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387AD6083632
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 14:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 387AD6083632
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RRKhmFHK
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2761c69fbso7218789c88.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 06:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716288; x=1794321088; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wk9IlcGYhsSNWUuj3B81ByEUkAlft9P2T8KxXmSzXGY=;
        b=RRKhmFHK8lerJ45rDb4x2WeaBbjOV0XMkGCnYQq1RhcC90MrMWQBs7CpHrDpXxh9+8
         YAB7zF55gFhGaXpQXzfGqzsiP9E1msqjKKRFPRZX4qr4zQBQCsn27O0hgET79yN6nSTb
         ne/SImqkzcnyudJCjlbPXHNEOlVyRRdMFmQrUddl+ZQ6CZuRYvqCgs2m2RWD3800Gj0u
         itbve3JGCRCUQS0KSTQmOT4RKSXGWk8SX4XITJlYhQ5ChbE7TGtMldI+mWpQ9ChwSLYo
         P2uzIK5IRUgn6WVv+NDBgkwGSUwYqdrtnCfwUlGhOoQOvrC/4gNondeayJAQ/sU77e4W
         DoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716288; x=1794321088;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wk9IlcGYhsSNWUuj3B81ByEUkAlft9P2T8KxXmSzXGY=;
        b=ACJ7t7H8bFC+pZsqzZ3/bG357tdSADF9UcDJrgbeUlYdEMhVXJl1K6wyskz4w/gIWm
         1QClcZGToignf9JOvl/6LPht9HS/236xq18WbKc3bm5ShloNnNkzt5Qd0B8j/6IJQ42Y
         AZeWgzlPEawDXeb7Z+qUhusXve/jyp2K3XySftbBsYTZ+79+vbHkahQV8wKbJktNa3Ta
         8+21+Md81+THLf12p8C20g23NY2hECr5Gtn9yPbkwbkqlYFkEGAikbOMFiXmxwUAvfn+
         I02EMnIebGvUuGw4gx7NHRuyM0Y8CYbkL3KqOBI0Jq7epjvXDmT9Bd3e2TG2YGb3dUZY
         ujDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJNoSAGhO7IQqbCuQ8Lm+2+5gtYfO7S0AuaTbnu2CIXcvjNPexG/mFhjk7QXAZnH2/8rvz/rAj/F5HfI1MuA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8BLF4Z4+tmuG5kVA5qbCTLs7M8EIrvhWuwmewfl4708RPh1iZP
	q4G9ii2LWwtWrqVs5PE2YY5nnYzpE0+loLKYmqSxTt2TVoFwV5q+eJ94/lz9GmTwk60=
X-Gm-Gg: AYBFou2ovVRCCEgCeZ7/B6JJRea5IndH0ef+onPF1Fjm+YdhdLYB8WfDStSQArhVXuv
	ao+jRmi6ZYodeB3++zB5JIdL+FRCLznmmVCpCVpSOc5JsG4Ze1noAUjBBy440CatGwLlkVFUxFb
	o+oXgYyT9VAqeLRvYTp8VPfUXRAfvTLLWdNwlV6oww9atzeH89pyWl/Z+HrGIOHDz5Q70mEDz8B
	HvxKkos1qZkUnZpwUJbdDVT6JTRfF2s2xMlyPaUHxTnujkvPS0+xycqyn5KJWuy7JLfP7Z9XeAu
	SxZGye1bFFgEopTpw2rHio9YUsjGHtwVzZwR/CGDpsbBu3XnaPUy9iHLX1r6RVJAeWkPrGHrV7N
	Yrb2fWd53PE2UTtJute1FUPG/cTwW0mrE2XQ703o82jmqitk14bIVqbxUQgDJDWqc+iTPFYb7qU
	uhNhzPPFgYZ2g6q+Si8NYxhsOK0dVRCWTmZ8YfWnYarWV9LEwNasPuCmZ8Wg1a+q6QDdikh+IDn
	VVA/Ekp8zs5b8JA1uU8RzTphkfoouuKSLir/3wLOGCsKUkkCRxNKbqwDV4TRJ7YSDHZlbaUk4YL
	k9hU373CBHtp8N/gMYkHeb7/361/aeaX47tc7dpScGKpEeQdulM4NIs3k6ejY3vB3NUrToLNspN
	+lQ0344gLgoE+
X-Received: by 2002:a05:7022:f517:b0:193:9aa3:4758 with SMTP id a92af1059eb24-1ac55968b07mr19882618c88.4.1793716288267;
        Tue, 03 Nov 2026 06:31:28 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Yunye Zhao <yunye.zhao@linux.alibaba.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
 virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Ferry Meng <mengferry@linux.alibaba.com>
In-Reply-To: <20261102133740.88919-1-yunye.zhao@linux.alibaba.com>
References: <20261102133740.88919-1-yunye.zhao@linux.alibaba.com>
Subject: Re: [PATCH] virtio_blk: freeze the virtqueue layout at probe time
Message-Id: <179371628704.3691261.225757712594968612.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:27 -0700
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 02 Nov 2026 21:37:40 +0800, Yunye Zhao wrote:
> init_vq() reads the writable num_request_queues and poll_queues module
> parameters both at probe and when recreating virtqueues after suspend
> or reset. However, virtio-blk does not update the blk-mq hardware queue
> count or queue maps on restore.
> 
> Increasing poll_queues can therefore remove the completion callback
> from a virtqueue still used for interrupt-driven I/O, leaving requests
> uncompleted. Reducing the effective request queue count through
> num_request_queues can instead leave existing hardware contexts
> indexing beyond the reallocated vblk->vqs array.
> 
> [...]

Applied, thanks!

[1/1] virtio_blk: freeze the virtqueue layout at probe time
      commit: d53c1a12ff1cfdb12770ddcfdf5603915d0ba0d8

Best regards,
-- 
Jens Axboe



