Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ED013F43A
	for <virtualization@lists.linux.dev>; Wed,  9 Oct 2024 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494985; cv=none; b=kbKD9bdMFkJDzBXGAfXDwIl6Jba8F/8L5cIRrGLOwwb21IMUxDrDhpdjj/U3fULxJtcJLWVamiVkgh7+7snMGfT1HcjSmXks4YM9UZgKol9CcaVHhqBGW3fKGvKzrwqYL1YotR64qCjLyT5bWfMF9e3Mykhpa34dtcBU+le+5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494985; c=relaxed/simple;
	bh=H5Y/vdF9w0zcs3yfYi+U1ozQa6mSZk+BtYQMChsKEPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZNJsKA4QWbO3SpeL2f7uMEOXp4pKwcxfhDWziBfMBt4jPGLXIx4XFPAatgwiR/o8zjknUT425CmkgCwShPqX9qAT2uh028fXAZV/uA2T+Gc+KNv0rcv+LGnVJPORL+4QfFbmvtv7CLCNHIjhP5TVD3Muzg7rXGYr/5u99ELNaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so60675e9.2
        for <virtualization@lists.linux.dev>; Wed, 09 Oct 2024 10:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494982; x=1729099782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph4dHmwwGNUtPR7csyoZqdOsKA9zJtXDkHwHqPNDsrU=;
        b=HzvJyzA7mJY5sGDuwk7iF1UN2QbUGtIv7R1CUGj2J4E43Q7AcG4Lunp4cvwCRrnZOY
         J1nGbIVcDDdpVCVUv68Yr2LDZFavTCB9xK9Aj02HJAU6DNKMH+VJHBNlPfgqXKDUOtbt
         c8L4j6ymszPdBJRTFq27xxlWiG9KeMU2x43B3JbRRtCM9WDxImFof0NiBNKqia/HtSzJ
         21+XwChcvYJsqwbbyodQchPOnda6QhaiS39TIWFR+mbVO5dzjydckHXQDak+l3+3UBKc
         2qwhBULs8dzb6LtM2sXYBmvOAv71/7gNcMT5caFwIgoS77QNvx7jtWSGSb0ZT32ga7pH
         WIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT2MvDb2KSvWnqjg24uE/m5w0FWYgqurEaEDtYJ/VS28V3x4mYM7yM/DfiHfbyv3smuFFabQ7LXiKiVxqpNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlLBCkyzk1oBcTVAFBsbnCbs/IAfet8cbLSnXMIRoQMoe+Mmjs
	gAem6vrlnplREVm8ozh1wo3JThbE8+klFnjXc9FFyauuyK3x5zTieue3cMPr
X-Google-Smtp-Source: AGHT+IFNQl26Yi9sJ60W1L0+ivvA50jgr/dBp9oX5oLvkywajWxtJLgg0Ahqel0Alu1BiDwdLhJF5Q==
X-Received: by 2002:a05:600c:2149:b0:431:11e6:d540 with SMTP id 5b1f17b1804b1-43111e6d828mr25137035e9.17.1728494982289;
        Wed, 09 Oct 2024 10:29:42 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b42d8sm26789015e9.31.2024.10.09.10.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:29:41 -0700 (PDT)
Date: Wed, 9 Oct 2024 10:29:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Pavel Begunkov <asml.silence@gmail.com>, kuba@kernel.org
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	vschneid@redhat.com, axboe@kernel.dk,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: 6.12-rc1: Lockdep regression bissected
 (virtio-net/console/scheduler)
Message-ID: <20241009-ultramarine-bison-of-abundance-2bfcdd@leitao>
References: <20241003-savvy-efficient-locust-ae7bbc@leitao>
 <20241003153231.GV5594@noisy.programming.kicks-ass.net>
 <20241003-mahogany-quail-of-reading-eeee7e@leitao>
 <20241004-blazing-rousing-lynx-8c4dc9@leitao>
 <Zv_IR9LAecB2FKNz@pathway.suse.cz>
 <8434l6sjwz.fsf@jogness.linutronix.de>
 <f88adb83-618b-4be3-8357-0aabcf3a2db8@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88adb83-618b-4be3-8357-0aabcf3a2db8@gmail.com>

On Wed, Oct 09, 2024 at 04:44:24PM +0100, Pavel Begunkov wrote:
> On 10/8/24 16:18, John Ogness wrote:
> > On 2024-10-04, Petr Mladek <pmladek@suse.com> wrote:
> > > On Fri 2024-10-04 02:08:52, Breno Leitao wrote:
> > > > 	 =====================================================
> > > > 	 WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> > > > 	 6.12.0-rc1-kbuilder-virtme-00033-gd4ac164bde7a #50 Not tainted
> > > > 	 -----------------------------------------------------
> > > > 	 swapper/0/1 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> > > > 	 ff1100010a260518 (_xmit_ETHER#2){+.-.}-{2:2}, at: virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969)
> > > > 
> > > > 	and this task is already holding:
> > > > 	 ffffffff86f2b5b8 (target_list_lock){....}-{2:2}, at: write_ext_msg (drivers/net/netconsole.c:?)
> > > > 	 which would create a new lock dependency:
> > > > 	  (target_list_lock){....}-{2:2} -> (_xmit_ETHER#2){+.-.}-{2:2}
> > > > 
> > > > 	but this new dependency connects a HARDIRQ-irq-safe lock:
> > > > 	  (console_owner){-...}-{0:0}
> > 
> > ...
> > 
> > > > 	to a HARDIRQ-irq-unsafe lock:
> > > > 	  (_xmit_ETHER#2){+.-.}-{2:2}
> > 
> > ...
> > 
> > > > 	other info that might help us debug this:
> > > > 
> > > > 	 Chain exists of:
> > > > 	console_owner --> target_list_lock --> _xmit_ETHER#2
> > > > 
> > > > 	  Possible interrupt unsafe locking scenario:
> > > > 
> > > > 		CPU0                    CPU1
> > > > 		----                    ----
> > > > 	   lock(_xmit_ETHER#2);
> > > > 					local_irq_disable();
> > > > 					lock(console_owner);
> > > > 					lock(target_list_lock);
> > > > 	   <Interrupt>
> > > > 	     lock(console_owner);
> > 
> > I can trigger this lockdep splat on v6.11 as well.
> > 
> > It only requires a printk() call within any interrupt handler, sometime
> > after the netconsole is initialized and has had at least one run from
> > softirq context.
> > 
> > > My understanding is that the fix is to always take "_xmit_ETHER#2"
> > > lock with interrupts disabled.
> > 
> > That seems to be one possible solution. But maybe there is reasoning why
> > that should not be done. (??) Right now it is clearly a spinlock that is
> 
> It's expensive, and it's a hot path if I understand correctly which
> lock that is. And, IIRC the driver might spend there some time, it's
> always nicer to keep irqs enabled if possible.

This also seems a broad network lock, which might have so many other
impacts beyond performance.

That said, I am running out of ideas on how to get this fixed,
unfortunately.

--breno
