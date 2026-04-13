Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489B63B2FC1
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071900; cv=none; b=ZI0/5O4sx7NE4UfN47dM9bOucYZq19YbL75y7cW9HatQdS71HFHC+3JgA89kx4hhITOoDB+vI+g6Ja6sr1J2Ye3NLPuLQXAkUEk42C0sL58AWc+zQJWNZVTMEbd2DImBPjwPhZN051rUxD34g9AHAwxSRPuPMc16WqsYKPE7bNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071900; c=relaxed/simple;
	bh=uDVsXuAgOukhJvoFEJaLM04wN34waooFTfCn+0aeSUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuaIYjTUo0SAtMjO1b6ycJGqfb+Im7FIyg3Scl1scN2Nmgi6Ixli7QM6Kj3q64n43YmYyYTO+DxnSsuTFvaoCvRi5sWryEdCjvHPbz4VllF+oT8r4HSGxQi7055/KdgKRRMTbYtehx8WIDuqHYexb0jJcbRacwqXuKqZOBu9BU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktOjdJ+R; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktOjdJ+R"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so2991617f8f.1
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776071895; x=1776676695; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIAN/FrHU6F27zvsbKpZ8LqpxugufEWgzIK9oqXBU9c=;
        b=ktOjdJ+R/Cv4zQAQXQ0da/NhTD9eiHSjnyP9s2/0Th9ULzm1Hcj/IL9fisW3a4xcZi
         tYp9nYoe9FiOfuOdyma0hXyhd5Pt6RLzwAlsUy6PbLXrYgb9DAj4IfBqQrq930pJKpnN
         yUEIi2Fg52JtwTQTEWfTjDLog7QOi3xeaMn08+FC5oolwp6OVIOqj0x6a39/hWNt3sd4
         58b3kjQsdnacm2c1BPqHisi5L4tGWTETdbv/WMhrLV95/TrAXuvsG12HCzeZpG2k/6tE
         QdGz6jc7q4oeqe/kb2pDXTTdkvMy38pVpeGfEtt6TQ2NDuk+sJDYShC9SlrjmpiCGT4c
         Iing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776071895; x=1776676695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIAN/FrHU6F27zvsbKpZ8LqpxugufEWgzIK9oqXBU9c=;
        b=HuLAiIpQRxHMHiOoaGdvN5N5I9VcM1CH6QZf5GYxAY7Fb/lIg+RNVQg2tptEgBmcgX
         IYwjQrXLw1SeityUOacG6nE96zSVZXlbFuQz8+vHzsz1yDvNxgPsq6fj4/kbMUKWCzww
         FqzfdA7eYuBfez0m5JQLGa0x3qqXljNu2zp7k2MvMnC212+yt5BGWoXZDS3B+AJc41UF
         Fas1V1+YYiHTof4wcyNoQgd+BNblZFBak6XBSMlBHozRjbDJ/rNWlKqCxWYF8O/HV3fy
         Y3MLsGJ5BzXN91FP0EgHTtpNMGwO4K097uXIRG9XMagCo5MJpEY8DriTNesgCWQErHhp
         NubA==
X-Forwarded-Encrypted: i=1; AFNElJ8fK1LGJQIuM6akchmwNSvaHOt+LxeE4/tfsZpjt/f73s/+LJNSDyyyRYkzhkbEsfbauI2Oq112ivwY0LWVeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcSxKXfkJNadVbeezM0lYyL/TqyZIuYUigoqU7azoWnGdBnpCc
	IQ7RZd4qey9rPIqtc388QaEBwJccPnhI+9tqD1DlHrREWH7TgY6T4ZZp
X-Gm-Gg: AeBDievzU+gYA+Z6UWcshL+R4AsneMfkyYs0iR32LrubOJzljxHqYDp8WF7hki2ax/5
	SK4J7lR0MffBIvUfzMAObfvF8qUzuRiFBUzuDfrgzoh0gnzSUerIrL4Si2vYUSxDs0LMyFVJ6h3
	gscgxDvGOT3Vrsz9NlXO7BQfhvxsFK+8schwh+OesdN9YsTMihb1pk9kV3NMiJIuR08TInGXEdW
	EHrJwUykXu5VPlLpFLL4Qqgl9DhTuh/Gt4XclMFLcBAOP7lX5/BFG83tqp3kphn5d1cxIjIygN+
	s/PJotv5OXyvcLt3KLWrLdTTv8btI6fclU11JTHHL7BrN9wDaS1DBgWvm87Lkyt2wZ3DXxm95I5
	k4fIwOorJseSO5u65aJqB83xQM34n6BYDr8Tkc/JI82yZn1Is3qSJtxYfQQVRvuQd7xhFD9llLZ
	SMag/pP5nLraCQ/+Hqq8OLXJr/7GZmG5IvCKHG56vMQNbRLVmzVZFTjrKanEvtJ3J9
X-Received: by 2002:a5d:64c3:0:b0:43d:714:34e5 with SMTP id ffacd0b85a97d-43d642da7aamr17575085f8f.24.1776071895213;
        Mon, 13 Apr 2026 02:18:15 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7b219576sm4172172f8f.19.2026.04.13.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:18:11 -0700 (PDT)
Date: Mon, 13 Apr 2026 10:17:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jinhui Guo <guojinhui.liam@bytedance.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with
 spin_lock_irqsave held in virtqueue_exec_admin_cmd()
Message-ID: <20260413101759.6323fb68@pumpkin>
In-Reply-To: <20260413034046-mutt-send-email-mst@kernel.org>
References: <20260413072249.30433-1-guojinhui.liam@bytedance.com>
	<20260413034046-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 03:45:20 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 13, 2026 at 03:22:49PM +0800, Jinhui Guo wrote:
> > virtqueue_exec_admin_cmd() holds admin_vq->lock with spin_lock_irqsave(),
> > which disables interrupts.  Using GFP_KERNEL inside this critical section
> > is unsafe because kmalloc() may sleep, leading to potential deadlocks or
> > scheduling violations.
> > 
> > Switch to GFP_ATOMIC to ensure the allocation is non-blocking.
> > 
> > Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> > ---
> >  drivers/virtio/virtio_pci_modern.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 6d8ae2a6a8ca..db8e4f88b749 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -101,7 +101,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> >  		return -EIO;
> >  
> >  	spin_lock_irqsave(&admin_vq->lock, flags);
> > -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> > +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
> >  	if (ret < 0) {
> >  		if (ret == -ENOSPC) {
> >  			spin_unlock_irqrestore(&admin_vq->lock, flags);  
> 
> 
> GFP_ATOMIC allocations can and will fail. If using them, one must
> retry, not just propagate failures.
> Or just switch admin_vq->lock to a mutex?

Or do the allocate before acquiring the lock (and free it not used
in the error path).

	David

> 
> 
> > -- 
> > 2.20.1  
> 
> 

