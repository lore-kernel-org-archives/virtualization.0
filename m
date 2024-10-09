Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFA91E22E0
	for <virtualization@lists.linux.dev>; Wed,  9 Oct 2024 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488633; cv=none; b=U2RwtNKdGggX8wzDmzpw2jy+FkRjsrg8cfq2237JssQlx/5mMhNLEDRra4c/t32k/Xzc/3OFFOEGTaUoQl90t8dVUpadWQDQueYiMPMSqkR3Ap/b1RG1LZ+/Id+jE6p6fp2VzZwSV+j2TjbJHDxWEDr17hDupE28DwqoOsxAbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488633; c=relaxed/simple;
	bh=ALCn5nX2IVltGWpCr8Pfx5ViOJxPdmVSP4zL12BOUm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVc2Y24JxDfpT7ZyaW8P1vyS8vfqyRyR7Fol2w96+N1VMV0V+OzUsaZlRqHu+eu+FGdvV5/fS4aJOPUdJ0DG/34vu7TYQk/hl624wRxOZUhFF+Pfsoe/qyODqYoUcpSjGE090HgATKiTcl+VbiQvWo4Y0u2ZZ8wbD/VJZtCPaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHfHjm6K; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHfHjm6K"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aa086b077so826845366b.0
        for <virtualization@lists.linux.dev>; Wed, 09 Oct 2024 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488630; x=1729093430; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=anu0cTMQYHGCKMgsjTpzIjdO1NCpBTN/hmAIcwURhZ8=;
        b=QHfHjm6K8ySyWKJ0Bf/cZ396lyQo/st+GIJDL7vYDYsAedcIvXrGD/o7RwXT5ubtW5
         vr2vR7H7QrAmbOiSZW9eyDYExnBuDVejhR7ugs/IMuhUFZ3yhAdbTBIn0UC8/prkn39F
         69Sw0ygUwtZyLDOQgpATgX8Iu7QZYxJyh5rGtCdXf3/o7Eb8S3vkuNM233Cfp4Hru+0M
         krst/95Eply6MsubwTn3qbByEk5PTzeC5mWL+tt8vIIs5RhF0dRThWtywUZVJbu+RpP5
         RC/H+3ACIrBLzaYPSRTCG1vaBiytGq4wU0RaXnV0rODAL8IwYbui3wfnv2dG6DQKFqvL
         +f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488630; x=1729093430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anu0cTMQYHGCKMgsjTpzIjdO1NCpBTN/hmAIcwURhZ8=;
        b=YzQP84O7Qcy4lEcy2ndH6CC1Ij5EdowGkknGkjJgCzoxeuvo9N91HxZd9ceiPfYfo7
         fBIhuOH2Iu7xZRv12nTbLIkvpDa4bpLPd+VwF4VuVeF0ceXWu9qLpHnxc7Ie5ZqugyXV
         hy1j/a3b/gQqUPqkvDGozuA9hRM47bS+ruSjTgyHjyHnfZQ7YeNGDX7XaX2PxvW4zehs
         Kq/EuAU0x9HdifdyJWvSubFgOy+JMgwc3i2EetLsvSgrVMchSdbg+sx6yaNky/h+X9BN
         2QYrFyywvC1Nixsd4lHo1uThDE77S81NTPEb5QTL3fY1aF0Uzs/onn9wlJjEwElInR4c
         WS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqnyB1U+16dJv+Yr8UvrwCbHF1QgaVQBk+xLvWkoIYWT8Mc8Fb9JZlIcl+8nHLhlGeyNb55ywrKa5P8ieVHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0HtBl5f1UniHuXKlnMv7c4zLXsUZkvIZDyjD8EEFLnePqjw69
	yyFLO4nX/SeWgRB1gzWMe94unqcshRTcyS75W7wroqs9b+Vqd0zj
X-Google-Smtp-Source: AGHT+IGMEn8xUymg5M9O0Cbi2djrOzdY6QGvxyYG/ZDhLZVh3ETv3LF4VWiQ4wB4z45ZIcnINUh+OQ==
X-Received: by 2002:a17:906:c14b:b0:a99:89e9:a43d with SMTP id a640c23a62f3a-a999e81aa13mr63814366b.39.1728488629601;
        Wed, 09 Oct 2024 08:43:49 -0700 (PDT)
Received: from [192.168.42.207] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e62392csm677484666b.52.2024.10.09.08.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 08:43:49 -0700 (PDT)
Message-ID: <f88adb83-618b-4be3-8357-0aabcf3a2db8@gmail.com>
Date: Wed, 9 Oct 2024 16:44:24 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.12-rc1: Lockdep regression bissected
 (virtio-net/console/scheduler)
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 kuba@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vschneid@redhat.com, axboe@kernel.dk,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20241003-savvy-efficient-locust-ae7bbc@leitao>
 <20241003153231.GV5594@noisy.programming.kicks-ass.net>
 <20241003-mahogany-quail-of-reading-eeee7e@leitao>
 <20241004-blazing-rousing-lynx-8c4dc9@leitao>
 <Zv_IR9LAecB2FKNz@pathway.suse.cz> <8434l6sjwz.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <8434l6sjwz.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 16:18, John Ogness wrote:
> On 2024-10-04, Petr Mladek <pmladek@suse.com> wrote:
>> On Fri 2024-10-04 02:08:52, Breno Leitao wrote:
>>> 	 =====================================================
>>> 	 WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>>> 	 6.12.0-rc1-kbuilder-virtme-00033-gd4ac164bde7a #50 Not tainted
>>> 	 -----------------------------------------------------
>>> 	 swapper/0/1 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>>> 	 ff1100010a260518 (_xmit_ETHER#2){+.-.}-{2:2}, at: virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969)
>>>
>>> 	and this task is already holding:
>>> 	 ffffffff86f2b5b8 (target_list_lock){....}-{2:2}, at: write_ext_msg (drivers/net/netconsole.c:?)
>>> 	 which would create a new lock dependency:
>>> 	  (target_list_lock){....}-{2:2} -> (_xmit_ETHER#2){+.-.}-{2:2}
>>>
>>> 	but this new dependency connects a HARDIRQ-irq-safe lock:
>>> 	  (console_owner){-...}-{0:0}
> 
> ...
> 
>>> 	to a HARDIRQ-irq-unsafe lock:
>>> 	  (_xmit_ETHER#2){+.-.}-{2:2}
> 
> ...
> 
>>> 	other info that might help us debug this:
>>>
>>> 	 Chain exists of:
>>> 	console_owner --> target_list_lock --> _xmit_ETHER#2
>>>
>>> 	  Possible interrupt unsafe locking scenario:
>>>
>>> 		CPU0                    CPU1
>>> 		----                    ----
>>> 	   lock(_xmit_ETHER#2);
>>> 					local_irq_disable();
>>> 					lock(console_owner);
>>> 					lock(target_list_lock);
>>> 	   <Interrupt>
>>> 	     lock(console_owner);
> 
> I can trigger this lockdep splat on v6.11 as well.
> 
> It only requires a printk() call within any interrupt handler, sometime
> after the netconsole is initialized and has had at least one run from
> softirq context.
> 
>> My understanding is that the fix is to always take "_xmit_ETHER#2"
>> lock with interrupts disabled.
> 
> That seems to be one possible solution. But maybe there is reasoning why
> that should not be done. (??) Right now it is clearly a spinlock that is

It's expensive, and it's a hot path if I understand correctly which
lock that is. And, IIRC the driver might spend there some time, it's
always nicer to keep irqs enabled if possible.

> being taken from both interrupt and softirq contexts and does not
> disable interrupts.

It rather seems the xmit lock is bh protected, but printk is a one
off case taking it with irqs disabled. I wonder if the printk side
could help with that, e.g. offloading sending from hardirq to softirq?

> I will check if there is some previous kernel release where this problem
> does not exist.

-- 
Pavel Begunkov
