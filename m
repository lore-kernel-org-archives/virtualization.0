Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330CA3E9C0B
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706400; cv=none; b=NdHJgC0YGmw/IpL+RJwe6aCZzM99iyEm2Lyiq3vCUt1pQmMSiRAVMIAmkHsb0qylXGbsOrTmhRjGcHZRMy/wgPbS6OTTdKuPKgL+CdIfuzf05OrAn8aFKrBlQuMpQxVL45LLlKYTNmqCVdt4r8jO+N/2kqY6d+fVaxTyEoycr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706400; c=relaxed/simple;
	bh=rCoOpEyyUCy5izIH7PFgiOzmcy6juASzPqw0DoJcH0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKtu3gRG43FkJY+NX1yR9mDTuwRQMW9OP/rqcXBa1e+cKAenra7jKzPvRNrLGEV1Zikr0hGiDaOFshEUkK4ki29+d2L5nx5qXsiZEgOXOHutJFP029kfRXAqRsx849xHk1GbVGUKAhENddUjs5w0WvJX+tA+jGO9V2RJdrHTK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVvxSFym; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVvxSFym"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so28384175e9.3
        for <virtualization@lists.linux.dev>; Mon, 25 May 2026 03:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706396; x=1780311196; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIaUsl5OR/SB9imIspw1g7Ej0mCc49YZbthvw9ulBV0=;
        b=nVvxSFymLHRnZXimBJZKDkm0OIh7bjmoN38yMhmzsYRSjU57Y8wLdv0VfGwVl4HFbQ
         kWwJfVr7a7bTjtdBYgWBsLvfk+LtoAeGoNYQSObT4t2Hu3xRZD4CeERv0xKPFQXuK2Pf
         je0aWJZ0OLOzQmrQlacZR/d5DMohtWLwlz1aQK6uFT2C5ulU/Xm2KB6xvQqUBM7oWofq
         EhRfMbCSKPpSbQs8rLmlHgynjL7cshglwyTaECONr633/kFFoZyRf30V5VoBJ6ZDg+zi
         c4kpNv2krD9TkkXPk+bdh2tq/OtOXHGmZTaes80MGqVfKIeFewOWjKbi/SAqCDiIpcNZ
         0srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706396; x=1780311196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIaUsl5OR/SB9imIspw1g7Ej0mCc49YZbthvw9ulBV0=;
        b=JnkZnjOCrcLmEgYw2iMBsEOWlxX38C/SoOGQF221lWs71iV0RUxqOVU9+dtpQTRwaU
         ZYtVEbfpRQyEbCQ8Wm1JV4V2ty6Ys6ys4pQD8/5BmHji5SXUVhotXA9LlA2PW7fxNqBT
         UJNA+084pYkYnyNvNmGaNOB1LFvx25nP392EHKg8k1o5aj63gLBU+7rO+rbcnaFj2LXF
         u1GFx0bp04Ftr+2+GUQeTfLxtzQXHQNABPcA83iJKUjluxMexQ+8vTZvfMKNEb9ZB45+
         s9nnStYGH6W61cr8HUSq7/t7NH2n4KD+M4TEJv2lXjYGHrQBOnfgtp29DtRlJWweaOuC
         hsaQ==
X-Forwarded-Encrypted: i=1; AFNElJ802P3jKEgyWU/w8VAPmsVhu0+z3rXNaDHIBZ7wbm+TbOUqFg/3e+Tg5g01Wz2RuKqeTJeicpmVWtr2qbM2lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwunDCRxb/ZR2Q19rFrF4etbu8NCEtOsshEJcbBJnCtwlZzDziE
	1pGhXhpWNehNbsmI+GD0M/xSXVwQKTqsGO+EDEZ1P8nPvsOLJ68/inS2
X-Gm-Gg: Acq92OF2Gb9lpozsEN2hI+ZvuwCtDzuFmwQRcF63nrkf80FWNeaEJ+MAPhbtsIyPBxf
	znqX4QDM8w60/Jp8V61Fu8u12JhMzUEbt3kOllOftzUAKmagEx2jd7OtWaIAvEUoVOu3id6VCJp
	UsvZHmxQlKJkWD7WXYmrsNnxRHP0+Dzr/hX7j9VdaNg864MOMod7GYfHZg4vR/xUQoD1tRqCXwK
	rCS1sMDkygvIDaT5ToK73TkO5K6YBP8bMlMJ9/Pn5y3aSMbEQmTyB1ulTRvlqgoT2z5m5RGXHLn
	kyqo8P0mdzpT3910YzC99QR2cUDAwQ5/YaJDsnQ1V2cT2us/MHMM7MOL8Nc9Drvz4ckuVPEGP08
	x0Kw0JiD9ojukB4+l5VKIlHWKPJhoShO8+WoA6lVsbnwFvMA9IrIjJEJpgR6c6TJANc9Rq/2Qb9
	0zLTJrg/9ZVuLEwRTrFO+v9Ths9gNmEt5IHJ72Oc5b2RgkMeZlggrPoFh+5ZdqFE1e
X-Received: by 2002:a05:600c:468a:b0:490:3d62:f5df with SMTP id 5b1f17b1804b1-490428e5a6amr234019415e9.30.1779706396365;
        Mon, 25 May 2026 03:53:16 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a33dsm222417485e9.11.2026.05.25.03.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:53:15 -0700 (PDT)
Date: Mon, 25 May 2026 11:53:14 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
 pabeni@redhat.com, mst@redhat.com, davem@davemloft.net,
 jasowang@redhat.com, stefanha@redhat.com, edumazet@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260525115314.3cf310e6@pumpkin>
In-Reply-To: <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
	<177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
	<20260523173557.5cc4f4f6@pumpkin>
	<ahQbVxvbBEJZ3TBU@sgarzare-redhat>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 11:57:45 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
> >On Sat, 23 May 2026 02:20:29 +0000
> >patchwork-bot+netdevbpf@kernel.org wrote:
> >  
> >> Hello:
> >>
> >> This patch was applied to netdev/net.git (main)
> >> by Jakub Kicinski <kuba@kernel.org>:  
> >
> >Did anyone else notice that is isn't a bug?
> >
> >There is no way that a 'count of bytes of kernel memory' can overflow
> >the size of 'long'.  
> 
> It's more of an estimate than an actual calculation of memory usage if 
> we queue the incoming packet. In theory, an overflow could occur if the 
> user sets `buf_alloc` to 4GB. In practice, though, I think you're right: 
> the memory should run out before we get to that check.

The calculation is:

	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0); 

skb_queue_len() will be the number of items on the queue.
SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically sizeof(skb)).

Unless you either corrupt the queue length or manage to allocate skb that use
less than the minimum about of memory that product can't overflow 'unsigned long'.

The later calculations might wrap - but the multiply can't.

-- David

> 
> Thanks,
> Stefano
> 
> >
> >-- David
> >  
> >>
> >> On Thu, 21 May 2026 14:47:32 +0200 you wrote:  
> >> > From: Stefano Garzarella <sgarzare@redhat.com>
> >> >
> >> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> >> > to 32-bit values. The multiplication can overflow before being assigned to
> >> > the u64 skb_overhead variable, making the skb overhead check ineffective.
> >> >
> >> > Cast skb_queue_len() to u64 so the multiplication is always performed in
> >> > 64-bit arithmetic.
> >> >
> >> > [...]  
> >>
> >> Here is the summary with links:
> >>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
> >>     https://git.kernel.org/netdev/net/c/4157501b9a8f
> >>
> >> You are awesome, thank you!  
> >  
> 

